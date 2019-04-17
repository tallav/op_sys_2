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

int kthread_create(void (*start_func)(), void* stack){
    cprintf("entered kthread_create\n");
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
    t->tf->esp=(uint)(stack + MAX_STACK_SIZE);
    
    return t->tid;
}

int kthread_id(){
    return mythread()->tid;
}

void kthread_exit(){
    cprintf("entered kthread_exit\n");
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

    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t->tproc == threadProc && t->state != UNINIT){ // threads of the same process 
            t->exitRequest = 1;
        }
    }

    curthread->tf = 0;
    curthread->state = TERMINATED;
    release(&ptable.lock);
    wakeup(curthread);
    acquire(&ptable.lock);

    // Jump into the scheduler, never to return.
    sched();
    panic("terminated exit");
}

int kthread_join(int thread_id){
    cprintf("entered kthread_join with thread_id: %d\n", thread_id);
    struct proc *p = myproc();
    struct kthread *t = 0;
    
    if(mythread()->tid == thread_id){
        cprintf("join on my thread id\n");
        return -1;
    }

    acquire(&ptable.lock);
    // look for the thread with this id
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
        if (tempT->tid == thread_id){
            t = tempT;
            break;
        }
    }
    if (t == 0){ // thread not found
        release(&ptable.lock);
        return -1;
    }
    if (t->state == UNINIT){ // thread was not initialized - no need to wait
         release(&ptable.lock);
         return 0;
    }
    while (t->state != TERMINATED){ // thread is not finished yet
        sleep(t, &ptable.lock);
    }
    kfree(t->kstack);
    t->kstack = 0;
    t->state = UNINIT;
    release(&ptable.lock);
    return 0;
}