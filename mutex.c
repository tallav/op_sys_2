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
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(!mutex->used){
            mutex->id = i;
            mutex->locked = 0;
            mutex->tid = 0;
            mutex->used = 1;
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
                int tempId = mutex->id;
                mutex->id = 0;
                mutex->locked = 0;
                mutex->tid = 0;
                mutex->used = 0;
                release(&mutexTable.lock);
                return tempId;
            }
        }
    }
    release(&mutexTable.lock);
    return -1; // mutex_id does not exist
}

int kthread_mutex_lock(int mutex_id){
    struct kthread_mutex_t *mutex;
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
        if(mutex->id == mutex_id)
            break;
    }
    release(&mutexTable.lock);
    if(mutex == 0){
        cprintf("lock - mutex_id does not exist\n");
        return -1;
    }
    struct kthread *curthread = mythread();
    acquire(&mutex->lock);
    while (mutex->locked) {
        sleep(curthread, &mutex->lock);
    }
    mutex->locked = 1;
    mutex->tid = curthread->tid;
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
    if(mutex == 0){
        cprintf("unlock - mutex_id does not exist\n");
        return -1;
    }
    struct kthread *curthread = mythread();
    if(curthread->tid != mutex->tid){ 
        cprintf("thread is not holding the lock\n");
        return -1;
    }
    acquire(&mutex->lock);
    mutex->locked = 0;
    mutex->tid = 0;
    release(&mutex->lock);
    wakeup(curthread);
    return 0;
}
