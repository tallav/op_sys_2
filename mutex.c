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
  int waitingThreads; // counts the number of threads that waits for this mutex
};
struct mutexTable {
  struct spinlock lock;
  struct kthread_mutex_t mutexes[MAX_MUTEXES];
};
extern struct mutexTable mutexTable;

int kthread_mutex_alloc(){
    struct kthread_mutex_t *mutex;
    int i = 0;
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(!mutex->used){
            mutex->id = i;
            mutex->locked = 0;
            mutex->tid = 0;
            mutex->used = 1;
            mutex->waitingThreads = 0;
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
                release(&mutexTable.lock);
                return -1;
            }else{
                if(!mutex->used){ // already deallocated
                    release(&mutexTable.lock);
                    return -1;
                }
                mutex->id = 0;
                mutex->locked = 0;
                mutex->tid = 0;
                mutex->used = 0;
                mutex->waitingThreads = 0;
                release(&mutexTable.lock);
                return 0;
            }
        }
    }
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id not found
        release(&mutexTable.lock);
        return -1;
    }
    release(&mutexTable.lock);
    return -1; // mutex_id does not exist
}


int kthread_mutex_lock(int mutex_id){
    //cprintf("thread %d trying to lock mutex %d\n", mythread()->tid, mutex_id);
    struct kthread_mutex_t *mutex;
    // find the mutex with this mutex_id
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(mutex->id == mutex_id)
            break;
    }
    release(&mutexTable.lock);
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id was not found
        return -1;
    }
    if(mutex->used == 0){ // mutex is not allocated
        return -1;
    }
    struct kthread *curthread = mythread();
    acquire(&mutex->lock);
    if (mutex->tid != curthread->tid){
            mutex->waitingThreads+=1;
    }
    while (mutex->locked) { // wait for the lock to be unlocked
        //cprintf("------thread %d going to sleep on mutex %d\n", mythread()->tid, mutex->id);
        sleep(&mutex->tid, &mutex->lock);
    }
    cprintf("kthread_mutex_lock, thread with id: %d trying to lock the mutex id: %d , mutex tid: %d\n", curthread->tid,mutex->id,mutex->tid);
    if(mutex->locked == 0){ // catch the free lock
         if (mutex->tid != curthread->tid )
            mutex->waitingThreads-=1;
        cprintf("waiting count: %d \n",  mutex->waitingThreads);
        if (mutex->tid != curthread->tid || (mutex->tid == curthread->tid && mutex->waitingThreads == 0)){ // lock only if you are not the previouse thread who locked
            cprintf("thread %d locking the mutex with id: %d\n", curthread->tid,mutex_id);
            mutex->locked = 1;
            mutex->tid = curthread->tid;
        }
    }
    release(&mutex->lock);
    return 0;
}

int kthread_mutex_unlock(int mutex_id){
    //cprintf("thread %d trying to unlock mutex %d\n", mythread()->tid, mutex_id);
    struct kthread_mutex_t *mutex;
    // find the mutex with this mutex_id
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(mutex->id == mutex_id)
            break;
    }
    release(&mutexTable.lock);
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id was not found
        return -1;
    }
    struct kthread *curthread = mythread();
    if(curthread->tid != mutex->tid){ 
        cprintf("thread is not holding the lock\n");
        return -1;
    }

 
    cprintf("req mutex id: %d, found mutex id: %d, is mutex locked: %d, mutex->isUsed: %d, mutex tid: %d, cur thread: %d \n", mutex_id, mutex->id, mutex->locked, mutex->used,mutex->tid,curthread->tid);
    acquire(&mutex->lock);
    if (mutex->locked == 0){ // mutex is not locked
        release(&mutex->lock);
        return -1;
    }
    //cprintf("thread %d unlocking the mutex %d\n", mythread()->tid, mutex->id);
    mutex->locked = 0; // release the mutex
    //mutex->tid = 0;
    release(&mutex->lock);
    cprintf("wakeup threads sleeping on curthread id: %d, mutex state: %d \n",curthread->tid, mutex->locked);
    wakeup(&mutex->tid);
    //cprintf("wake up threads sleeping on mutex %d\n", mutex->id);
    return 0;
}
