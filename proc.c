#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "kthread.h"
#include "spinlock.h"

struct threadTable{
  struct kthread threads[NTHREAD]; // Thread table for every process
};
struct ptable {
  struct spinlock lock;
  struct proc proc[NPROC];
  struct threadTable ttable[NPROC]; // Table of all threads
};
struct ptable ptable;

struct kthread_mutex_t{
  struct spinlock lock;
  int id; // mutex id
  int locked; // value 1 if it's locked
  int tid; // thread id of the locking thread
  int used; // lock alredy allocated
};
struct mutexTable {
  struct spinlock lock;
  struct kthread_mutex_t mutexes[MAX_MUTEXES];
};
struct mutexTable mutexTable;

static struct proc *initproc;

int nextpid = 1;
int nexttid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
  initlock(&mutexTable.lock, "mutexTable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

// Returns the current running thread
struct kthread*
mythread(void)
{
  struct cpu *c;
  struct kthread *t;
  pushcli();
  c = mycpu();
  t = c->thread;
  popcli();
  return t;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  //cprintf("entered allocproc: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;
  struct kthread *t; // Main thread
  char *sp;
  int i = 0;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
    else
      i++;
  
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->threads = ptable.ttable[i].threads;
  struct kthread *tTemp;
  for(tTemp = p->threads; tTemp < &p->threads[NTHREAD]; tTemp++){
    tTemp->state = UNINIT;
  }
  t = p->threads; // First thread in the table will be the main process thread
  t->tproc = p;
  t->tid = nexttid++;
  t->exitRequest = 0;

  release(&ptable.lock);
  /*
  // Allocate kernel stack for the process.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  */
  // Allocate kernel stack for the thread.
  if((t->kstack = kalloc()) == 0){
    return 0;
  }
  sp = t->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *t->tf;
  t->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
  t->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  //cprintf("entered userinit: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  struct kthread *t;

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  // TODO: lock on sz
  p->sz = PGSIZE;
  t = p->threads;
  memset(t->tf, 0, sizeof(*t->tf));
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  t->tf->es = t->tf->ds;
  t->tf->ss = t->tf->ds;
  t->tf->eflags = FL_IF;
  t->tf->esp = PGSIZE;
  t->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = USED;
  t->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();
  // TODO: lock the ptable or create new lock  
  acquire(&ptable.lock);
  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
      return -1;
    }
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
      return -1;
    }
  }
  curproc->sz = sz;
  switchuvm(curproc);
  release(&ptable.lock);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  //cprintf("entered fork: process=%p, thread=%p\n", myproc(), mythread());
  int i, pid;
  struct proc *np;
  struct kthread *nt;
  struct proc *curproc = myproc();
  struct kthread *curthread = mythread();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  nt = np->threads;
  nt->tproc = np;

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(nt->kstack);
    nt->kstack = 0;
    np->state = UNUSED;
    nt->state = UNINIT;
    return -1;
  }
  // TODO: lock on pgdir and sz
  np->sz = curproc->sz;
  np->parent = curproc;
  *nt->tf = *curthread->tf;

  // Clear %eax so that fork returns 0 in the child.
  nt->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = USED;
  nt->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  //cprintf("entered exit: process=%d, thread=%d\n", myproc()->pid, mythread()->tid);
  struct proc *curproc = myproc();
  struct kthread *curthread = mythread();
  struct proc *p;
  struct kthread *t;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  acquire(&ptable.lock);
  // tell the process threads to exit
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
    if(t->state != UNINIT && t->state != TERMINATED)
      t->exitRequest = 1;
  }
  
  //terminate the current thread
  /*curthread->tproc = 0;
  curthread->exitRequest = 0;
  curthread->tf = 0;*/
  
  // check if it is the last running thread. if it is, the process execute exit();
  int lastRunning = 1;
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
      if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
          lastRunning = 0;
      }
  }

  if(lastRunning){
    release(&ptable.lock);
    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
      if(curproc->ofile[fd]){
        fileclose(curproc->ofile[fd]);
        curproc->ofile[fd] = 0;
      }
    }

    begin_op();
    iput(curproc->cwd);
    end_op();
    curproc->cwd = 0;

    acquire(&ptable.lock);
    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent == curproc){
        p->parent = initproc;
        if(p->state == ZOMBIE)
          wakeup1(initproc);
      }
    }

    // wake up thread that sleeping in curthread before it terminates
    wakeup1(curthread);

    // Jump into the scheduler, never to return.
    curproc->state = ZOMBIE;
    curthread->state = TERMINATED;
    sched();
    panic("zombie exit");
  }
  else{
    release(&ptable.lock);
  }
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  //cprintf("entered wait: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;
  struct kthread *t;
  int havekids, pid = 0;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // check if the process threads are terminated
        int hasNonTerminated = 0;
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
          // clean all the process threads
          if(t->state == TERMINATED){
            kfree(t->kstack);
            t->kstack = 0;
            t->tid = 0;
            t->tproc = 0;
            t->exitRequest = 0;
            t->state = UNINIT;
          }
          if(t != mythread() && t->state != UNINIT && t->state != TERMINATED){
            hasNonTerminated = 1;
          }
        }
        if(!hasNonTerminated){
          // Found one.
          pid = p->pid;
          freevm(p->pgdir);
          p->pid = 0;
          p->parent = 0;
          p->name[0] = 0;
          p->killed = 0;
          p->state = UNUSED;
          for(int i = 0; i < MAX_MUTEXES; i++){
            kthread_mutex_dealloc(mutexTable.mutexes[i].id);
          }
        }
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct kthread *t;
  struct cpu *c = mycpu();
  c->proc = 0;
  c->thread = 0;
  for(;;){
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != USED){
        continue;
      }
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
        if(t->state != RUNNABLE){
            continue;
        }
        /*
        if(p && t)
          cprintf("scheduler found runnable: process=%d, thread=%d\n", p->pid, t->tid);
        */
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        c->proc = p;
        c->thread = t;
        switchuvm(p);
        t->state = RUNNING;

        swtch(&(c->scheduler), t->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
        c->thread = 0;
      }
    }
    release(&ptable.lock);
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  //cprintf("sched: thread=%d\n", mythread()->tid);
  int intena;
  struct kthread *t = mythread();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(t->state == RUNNING){
    cprintf("sched thread=%d\n", t->tid);
    panic("sched running");
  }
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&t->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  //cprintf("entered yield: process=%p, thread=%p\n", myproc(), mythread());
  acquire(&ptable.lock);  //DOC: yieldlock
  mythread()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct kthread *t = mythread();
  
  if(t == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  
  //cprintf("entered sleep: chan=%p, thread=%p\n", chan, t->tid);

  // Go to sleep.
  t->chan = chan;
  t->state = SLEEPING;

  sched();

  // Tidy up.
  t->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED){
      continue;
    }
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
      if(t->state == SLEEPING && t->chan == chan){
        t->state = RUNNABLE;
      }
    }
  }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  //cprintf("entered kill: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      /*if(p->state == SLEEPING)
        p->state = RUNNABLE;*/
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]     "unused",
  [EMBRYO]     "embryo",
  [USED]       "used  ",
  [ZOMBIE]     "zombie",
  [UNINIT]     "uninit",
  [SLEEPING]   "sleep ",
  [RUNNABLE]   "runble",
  [RUNNING]    "run   ",
  [BLOCKED]    "block ",
  [TERMINATED] "termnt"
  };
  int i;
  struct proc *p;
  struct kthread *t;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("process: %d %s %s , ", p->pid, state, p->name);
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
      if(t->state == UNINIT)
        continue;
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
        state = states[p->state];
      else
        state = "???";
      cprintf("thread: %d %s , ", t->tid, state);
      if(t->state == SLEEPING){
        getcallerpcs((uint*)t->context->ebp+2, pc);
        for(i=0; i<10 && pc[i] != 0; i++){
          cprintf(" %p ", pc[i]);
        }
      }
    }
  }
  cprintf("\n");
}
