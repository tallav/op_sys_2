#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "kthread.h"



void printSomething();
extern void forkret(void);

struct threadTable{
  struct kthread threads[NTHREAD]; // Thread table for every process
};

struct ptable{
  struct spinlock lock;
  struct proc proc[NPROC];
  struct threadTable ttable[NPROC]; // Table of all threads
};

extern struct ptable ptable;
extern void trapret(void);

int kthread_create(void (*start_func)(), void* stack){
    struct proc *p;
    struct kthread *t = 0;
    char *sp;

    p = myproc();

    cprintf("kthread_create\n");

    acquire(&ptable.lock);
    int tid = 1;
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
        if(tempT->state == UNINIT){
            t = tempT;
            break;
        }
        else{
            tid++;
        }
    }
    t->tid = tid;
    release(&ptable.lock);

    if (t == 0)
        return -1;

    t->tproc = p;    

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
    memset(t->context, 0, sizeof *t->context); //todo: 0 or tid?

    //cprintf("func address: %d\n",(uint) t->tf->eip);
    t->context->eip = (uint)forkret;
    
    struct kthread* thread = mythread();
    *t->tf=*thread->tf;
    t->tf->eip=(uint)start_func;
    t->tf->esp=(uint) (stack+KSTACKSIZE);

 
    t->exitRequest = 0;
    t->state=RUNNABLE;
    t->ustack = stack;


    cprintf("finished func %d\n",(uint)start_func);


    return t->tid;
}

/*kthread getThread(int tid){
    struct proc *p;
    struct kthread *t = 0;
    struct cpu *c = mycpu();
    char *sp;

    p = c->proc;

    acquire(&ptable.lock);
    int tid = 1;
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
        if(t->tid == tid){
            return t;
        }
    }

    if (t == 0)
        return -1;
}*/


int kthread_id(){
    procdump();
    return mythread()->tid;
}

void kthread_exit(){
    struct kthread *curthread = mythread();
    struct proc *threadProc;
    struct kthread *t;

    acquire(&ptable.lock);
    threadProc = curthread->tproc;
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t->tproc == threadProc){ // threads of the same process 
            t->exitRequest = 1;
        }
    }
    // check if it is the last running thread. if it is, the process execute exit();
    int lastRunning = 1;
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t != curthread && t->state != TERMINATED){
            lastRunning = 0;
        }
    }
    if(lastRunning){
        exit();
    }
    // Jump into the scheduler, never to return.
    curthread->state = TERMINATED;
    procdump();
    sched();
    panic("terminated exit");
}

int kthread_join(int thread_id){
    /*struct thread* t;
	int exists=0;
	struct proc *threadProc = myproc();
	acquire(&ptable.lock);
	
      for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t->tid ==thread_id){
            exists=1;
			break;
        }
    }
	
	if(!exists){
		release(&ptable.lock);
		return -1;
	}
	if(t->state==UNINIT){
  	release(&ptable.lock);
  	return 0;
  }
	else if(t->state == TERMINATED){
		free_and_return:
    kfree(t->kstack);
    t->kstack = 0;
    t->state = UNUSED;
    release(&ptable.lock);
    return 0;
  }
  else{
  	while(t->state!=TERMINATED){
  		sleep(t,&ptable.lock);
  		}
  	if(t->state==UNINIT)
  		panic("kthread_join: won't wake up because thread was going from ready to unused");
  	goto free_and_return;
  }
   
 */

return 0;
   /* struct proc *p;
    struct kthread *t = 0;
    int threadTerminated = 0;
    p = myproc();
    
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
        if (tempT->tid == thread_id){
            t = tempT;
            if (tempT->state == TERMINATED){
                threadTerminated = 1;
            }
            break;
        }
    }

    if (t == 0)
        return -1;

    while (!threadTerminated){
          if (t->state == TERMINATED){
                threadTerminated = 1;
            }
    }
    return 0;*/
}