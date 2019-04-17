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

int 
exitTest(){
 int pid = fork();
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


void 
printSomething(){
    printf(1,"\nhello\n");
}

int 
createThreadsTest(){
   /*  int pid = fork();
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
    sleep(3000);*/
	void(*start_func)();
    start_func = (void*)printSomething;
    char* stackPointer = (char*)malloc(4000);
    printf(1,"func address from myprog %d\n", (void*)kthread_id);
    kthread_create(start_func,stackPointer);

 
   return 1;
}


void
run(){
	int id = kthread_id();
	int pid = getpid();
	//int i, j;
	printf(1, "my id: %d\n", id);
	printf(1,"my pid: %d\n", pid);
	/*for(i=0; i<100000;i++)
		for(j=0; j<400;j++)
			id++;*/
	printf(1,"hey");
	//kthread_exit();
}

int
main(int argc, char *argv[])
{
    void* stack = (void*)malloc(4000);
	void(*start_func)();
	start_func = (void*)run;
	int pid = getpid();
	printf(1, "%d\n",pid);
    printf(1, "start_func address: %d\n", start_func);
	int tid = kthread_create(start_func, stack);
	//int rest = kthread_join(tid);
	int rest = 0;
    sleep(50000);
	printf(1, "result: %d, tid: %d\n", rest, tid);
    exit();
   //createThreadsTest();
   //exit();
}

