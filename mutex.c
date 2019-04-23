#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "kthread.h"

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

int kthread_mutex_alloc(){
    struct kthread_mutex_t *mutex;
    int i = 0;
   // cprintf("mutex alloc\n");
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(!mutex->used){
            mutex->id = i;
            mutex->locked = 0;
            mutex->tid = 0;
            mutex->used = 1;
            //cprintf("mutex allocated %d, max mutexts %d\n", mutex->id,MAX_MUTEXES);
            break;
        }
        i++;
    }
    release(&mutexTable.lock);
    if(i >= MAX_MUTEXES)
        return -1;
    else
        return i;
}

int kthread_mutex_dealloc(int mutex_id){
    struct kthread_mutex_t *mutex;
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(mutex->id == mutex_id){
            if(mutex->locked == 1){
            //    cprintf("mutex is locked, can't dealloc");
                release(&mutexTable.lock);
                return -1;
            }else{
                if (mutex->used ==0) {// mutex already deallocated
                    // cprintf("mutex is already dealloc");
                    release(&mutexTable.lock);
                    return -1;
                }
              //  cprintf("dealocate worked");
                mutex->id = 0;
                mutex->locked = 0;
                mutex->tid = 0;
                mutex->used = 0;
                release(&mutexTable.lock);
                return 0;
            }
        }
    }
      if(mutex == 0 || mutex->id!=mutex_id){
       // cprintf("mutex id doesn't exists");
        release(&mutexTable.lock);        
        return -1;
    }
    release(&mutexTable.lock);
    return -1; // mutex_id does not exist
}

int waitingCount=0;
int kthread_mutex_lock(int mutex_id){
    struct kthread_mutex_t *mutex;
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(mutex->id == mutex_id)
            break;
    }
    release(&mutexTable.lock);
    if(mutex == 0 || mutex->id != mutex_id){
       // cprintf("lock - mutex_id does not exist\n");
        return -1;
    }

    if(mutex->used == 0){
       // cprintf("mutex already dealocated\n");
        return -1;
    }

    struct kthread *curthread = mythread();
    //cprintf("kthread_mutex_lock, thread with id: %d entered\n", curthread->tid);
    acquire(&mutex->lock);
    if (mutex->tid != curthread->tid){
            waitingCount+=1;
    }
    while (mutex->locked) {
       // cprintf("sleep and wait to hold the mutex lock, sleep on tid: %d\n", curthread->tid);
        sleep(&mutex->tid, &mutex->lock);
    }
    cprintf("kthread_mutex_lock, thread with id: %d trying to lock the mutex\n", curthread->tid);
    if(mutex->locked == 0){
        cprintf("waiting count: %d \n", waitingCount);
         if (mutex->tid != curthread->tid )
            waitingCount-=1;
        if (mutex->tid != curthread->tid || (mutex->tid == curthread->tid && waitingCount == 0)){
            cprintf("thread %d locking the mutex with id: %d\n", curthread->tid,mutex_id);
            mutex->locked = 1;
            mutex->tid = curthread->tid;
        }
       
    }
    release(&mutex->lock);
    return 0;
}

int kthread_mutex_unlock(int mutex_id){
    struct kthread_mutex_t *mutex;
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(mutex->id == mutex_id)
            break;
    }
    release(&mutexTable.lock);
    if(mutex == 0 || mutex->id!=mutex_id){
        //cprintf("unlock - mutex_id does not exist\n");
        return -1;
    }
    struct kthread *curthread = mythread();
    if(curthread->tid != mutex->tid){ 
        //cprintf("thread is not holding the lock\n");
        return -1;
    }

 
    //cprintf("req mutex id: %d, found mutex id: %d, is mutex locked: %d, mutex->isUsed: %d, mutex tid: %d, cur thread: %d \n", mutex_id, mutex->id, mutex->locked, mutex->used,mutex->tid,curthread->tid);
    acquire(&mutex->lock);
       if (mutex->locked == 0){
      //     cprintf("--mutex unlocked, mutex id: %d \n",mutex->id);
            release(&mutex->lock);
            return -1;
       }
    mutex->locked = 0;
    //mutex->tid = 0;
    release(&mutex->lock);
    //cprintf("wakeup threads sleeping on curthread id: %d, mutex state: %d \n",curthread->tid, mutex->locked);
    wakeup(&mutex->tid);
    return 0;
}
