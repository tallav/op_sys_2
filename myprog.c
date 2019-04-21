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

int a = 4;
int mutex;
int test;

int printSomthing(){
    printf(1,"\n HELLO \n");
    a = 2;
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
    return;
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
Test()
{
	void* stack = (void*)malloc(4000);
	int pid = getpid();
	printf(1, "main pid: %d\n",pid);
	int tid = kthread_create(&run, stack);
	int rest = kthread_join(tid);
	printf(1, "tid: %d, rest: %d\n", tid, rest);
    kthread_id();
	exit();
}

void
printer()
{
	int input = kthread_mutex_lock(mutex);
	if(input<0)
		printf(1,"Error: thread mutex didnt lock!");
	printf(1,"thread %d said hi\n",kthread_id());
	test=1;
	input = kthread_mutex_unlock(mutex);
	if(input<0)
		printf(1,"Error: thread mutex didnt unlock!");
	kthread_exit();
	printf(1,"Error: returned from exit !!");
}

int 
mutexTest()
{
	printf(1,"~~~~~~~~~~~~~~~~~~\ntest starts\nIf it ends without Errors you win! : )\n~~~~~~~~~~~~~~~~~~\n");
	int input,i;
	mutex = kthread_mutex_alloc();
	printf(1,"the mutex: %d\n",mutex);
	if(mutex<0)
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
	for(i = 0; i<5; i++){
        printf(1,"index: %d\n",i);
		test=0;
		input = kthread_mutex_lock(mutex);
		if(input<0)
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
		char* stack = malloc(4000);
		int tid = kthread_create ((void*)printer, stack);
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
		printf(1,"joining on thread %d\n",tid);
		if(test)printf(1,"Error: mutex didnt prevent writing!\n");
		input = kthread_mutex_unlock(mutex);
		if(input<0) printf(1,"Error: mutex didnt unlock!\n");
		kthread_join(tid);
		if(!test) printf(1,"Error: thread didnt run!\n");
		printf(1,"finished join\n");
	}
	printf(1,"Exiting\n");
	input = kthread_mutex_dealloc(mutex);
	if(input<0)
		printf(1,"Error: mutex didnt dealloc!\n");
	exit();
    printf(1,"Error: returned from exit !!\n");
}


int
main(int argc, char *argv[])
{
    //test_kthread_exit();
    //test_kthread_create();
    //test_kthread_join();
    //Test();

    mutexTest();
    printf(1, "finish\n");
    exit();
}
