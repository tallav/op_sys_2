#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"

int printSomthing(){
    printf(1,"\n HELLO \n");
    return 0;
}

void test_kthread_create(){
    char* ustack = (char*)malloc(4000);
    kthread_create(&printSomthing, ustack);
}

void test_kthread_exit(){
    int tid = kthread_id();
    printf(1, "thread id: %d\n", tid);
    kthread_exit();
    /*
    int pid = fork();
    if(pid == 0){
        int tid1 = kthread_id();
        printf(1, "child - thread id: %d\n", tid1);
        kthread_exit();
    }else{
        int tid2 = kthread_id();
        printf(1, "parent - thread id: %d\n", tid2);
        kthread_exit();
    }
    wait();
    */
}

int
main(int argc, char *argv[])
{
    test_kthread_create();
    //test_kthread_exit();

    printf(1, "finish\n");
    exit();
}
