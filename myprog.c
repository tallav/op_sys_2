#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"
#include "kthread.h"

int a=4;

int printSomthing(){
    printf(1,"\n HELLO \n");
    a=2;
    kthread_exit();
    return 0;
}

void test_kthread_create(){
    char* ustack = (char*)malloc(4000);
    printf(1, "a=%d\n",a);
    int tid = kthread_create((void*)&printSomthing, ustack);
    sleep(50);
    free(ustack);
    printf(1, "created thread %d\n", tid);
    printf(1, "a=%d\n",a);
    return;
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
    return;
}

void
run(){
	int id = kthread_id();
	int pid = getpid();
	printf(1, "my id: %d\n", id);
	printf(1,"my pid: %d\n", pid);
    int i, j;
    for(i=0; i<1000;i++)
		for(j=0; j<1000;j++)
			id++;
	printf(1,"hey\n");
	kthread_exit();
}

int
test()
{
	void* stack = (void*)malloc(4000);
	int pid = getpid();
	printf(1, "main pid: %d\n",pid);
	int tid = kthread_create(&run, stack);
	//int rest = kthread_join(tid);
    //sleep(10000);
	printf(1, "tid: %d\n", tid);
	exit();
}

void test_kthread_join(){
    int pid = fork();
    int tid = -1;
    if(pid == 0){
        tid = kthread_id();
        printf(1, "child tid: %d\n", tid);
        kthread_exit();
    }
    wait();
    printf(1, "parent tid: %d\n", tid);
    kthread_join(tid);
    return;
}

int createThreadsTest(){
	/*int pid = fork();
    if(pid == 0){
        int tid1 = kthread_id();
        printf(1, "child - thread id: %d\n", tid1);
        //kthread_exit();
        char* stackPointer = (char*)malloc(4000);
        printf(1,"func address from myprog %d\n", (void*)printSomething);
        kthread_create((void*)printSomething,stackPointer);
        printf(1, "exited thread\n");
    }else{
        int tid2 = kthread_id();
        printf(1, "parent - thread id: %d\n", tid2);
    }
    printf(1, "----------------");
    sleep(3000);
	void(*start_func)();
    start_func = (void*)printSomething;
    char* stackPointer = (char*)malloc(4000);
    printf(1,"func address from myprog %d\n", (void*)kthread_id);
    kthread_create(start_func,stackPointer);
	*/
   return 1;
}

int
main(int argc, char *argv[])
{
    //test_kthread_exit();
    test_kthread_create();
    //test_kthread_join();
    //test();
    printf(1, "finish\n");
    exit();
}
