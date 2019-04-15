#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "kthread.h"

extern void trapret(void);


int kthread_create(void (*start_func)(), void* stack){
    struct proc *p;
    struct kthread *t;
    struct cpu *c = mycpu();
    char *sp;

    p = c->proc;

    //acquire(&ptable.lock);
    int tid = 1;
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
        if(t->state == UNINIT){
            break;
        }
        else{
            tid++;
        }
    }

    if (t == 0)
        return -1;

    // Allocate kernel stack for the thread.
    if((t->kstack = kalloc()) == 0){
        return 0;
    }
    sp = t->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *t->tf;
    t->tf = (struct trapframe*)sp;

    t->state = RUNNABLE;
    t->tid = tid;
    t->tproc = p;
    
    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *t->context;
    t->context = (struct context*)sp;
    memset(t->context, 0, sizeof *t->context);
    t->context->eip = (uint)start_func;
  //  t->chan = 
    t->exitRequest = 0;
    return t->tid;
}

int kthread_id(){
    return 0;
}

void kthread_exit(){

}

int kthread_join(int thread_id){
    return 0;
}