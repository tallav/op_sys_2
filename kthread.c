#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "kthread.h"

int kthread_create(void (*start_func)(), void* stack){
    return 0;
}

int kthread_id(){
    return 0;
}

void kthread_exit(){

}

int kthread_join(int thread_id){
    return 0;
}