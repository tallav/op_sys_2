#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "kthread.h"

struct threadTable{
  struct kthread threads[NTHREAD]; // Thread table for every process
};
struct ptable{
  struct spinlock lock;
  struct proc proc[NPROC];
  struct threadTable ttable[NPROC]; // Table of all threads
};
extern struct ptable ptable;

extern int nexttid;
extern void trapret(void);
extern void forkret(void);
static void wakeupThreads(void *chan);

int kthread_create(void (*start_func)(), void* stack){
    struct proc *p = myproc();
    struct kthread *t = 0;
    char *sp;

    acquire(&ptable.lock);
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
        if(tempT->state == UNINIT){
            t = tempT;
            break;
        }
    }

    if (t == 0){
        release(&ptable.lock);
        return -1;
    }

    t->tproc = p;
    t->tid = nexttid++;

    release(&ptable.lock);  

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

    t->exitRequest = 0;
    t->state = RUNNABLE;
    t->ustack = stack;
    *t->tf = *mythread()->tf;
    t->tf->eip = (uint)start_func;
    t->tf->esp = (uint)(stack);
    return t->tid;
}

int kthread_id(){
    //procdump();
    return mythread()->tid;
}

void kthread_exit(){
    struct kthread *curthread = mythread();
    struct proc *threadProc;
    struct kthread *t;

    acquire(&ptable.lock);
    
    // check if it is the last running thread. if it is, the process execute exit();
    threadProc = curthread->tproc;
    int lastRunning = 1;
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
            lastRunning = 0;
        }
    }
    if(lastRunning){
        release(&ptable.lock);
        exit();
    }
    
    wakeupThreads(curthread);
    //cprintf("wake up threads sleeping on thread %d\n", curthread->tid);

    // Jump into the scheduler, never to return.
    curthread->state = TERMINATED;
    //cprintf("thread %d exiting\n", mythread()->tid);
    sched();
    panic("terminated exit");
}

int kthread_join(int thread_id){
    struct proc *curproc = myproc();
    struct kthread *curthread = mythread();
    struct kthread *t;
    if(curthread->tid == thread_id){
        return -1;
    }
    acquire(&ptable.lock);
    // look for the thread with this id
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
        if (t->tid == thread_id){
            break;
        }
    }
    if (t == 0 || t->tid != thread_id){ // thread not found
        release(&ptable.lock);
        return -1;
    }
    if (t->state == UNINIT){ // thread was not initialized - no need to wait
        release(&ptable.lock);
        return -1;
    }
    while (t->state != TERMINATED){ // thread is not finished yet
        //cprintf("kthread_join------thread %d going to sleep on thread %d with state %d\n", mythread()->tid, t->tid, t->state);
        sleep(t, &ptable.lock);
    }
    kfree(t->kstack);
    t->kstack = 0;
    t->state = UNINIT;
    //cprintf("thread %d joining on thread %d\n", mythread()->tid, thread_id);
    release(&ptable.lock);
    return 0;
}

static void
wakeupThreads(void *chan)
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

/*
void
waitForRunnableThreads(){
  struct proc *curproc = myproc();
  struct kthread *curthread = mythread();
 // cprintf("wait for runnable threads");
  if(curthread->exitRequest == 0){
    acquire(&ptable.lock);
    struct kthread *t;
    int allTerminated = 0;
  //  cprintf("exit request, all terminated: %d \n",allTerminated);
    //cprintf("curthread %d  add: %p\n", curthread->tid,curthread);
    while (!allTerminated){
      allTerminated = 1;
       for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
         if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
      //       cprintf("thread %d didn't terminate, state: %d, chan: %p\n", t->tid, t->state,t->chan);
            allTerminated = 0;
           break;
         }
       }
       if (allTerminated)
          break;
       //cprintf("cur proc %p \n", curproc);
       wakeupThreads(curproc);
       //cprintf("go to sleep");
       sleep(curthread, &ptable.lock);
    }
    release(&ptable.lock);
  }
}
*/
