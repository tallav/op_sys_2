#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"

int
main(int argc, char *argv[])
{
    int pid = fork();
    if(pid == 0){
        int tid1 = kthread_id();
        printf(1, "child - thread id: %d\n", tid1);
        kthread_exit();
        printf(1, "exited thread\n");
    }else{
        int tid2 = kthread_id();
        printf(1, "parent - thread id: %d\n", tid2);
    }
    wait();
    exit();
}