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

/*
int a = 4;

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
*/
int mutex;
int test;

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

void 
mutexTest()
{
	printf(1,"~~~~~~~~~~~~~~~~~~\ntest starts\nIf it ends without Errors you win! : )\n~~~~~~~~~~~~~~~~~~\n");
	int input,i;
	mutex = kthread_mutex_alloc();
	printf(1,"the mutex: %d\n",mutex);
	if(mutex<0)
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
	for(i = 0; i<16; i++){
        printf(1,"index: %d\n",i);
		test=0;
		input = kthread_mutex_lock(mutex);
		if(input<0)
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
		char* stack = malloc(MAX_STACK_SIZE);
		int tid = kthread_create ((void*)printer, stack);
		printf(1, "created thread with id: %d\n", tid);
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
		//printf(1,"joining on thread %d\n",tid);
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
	//exit();
    //printf(1,"Error: returned from exit !!\n");
}

int THREAD_NUM = 5;

void run(){
	int id = kthread_id(); 
	printf(1,"thread %d entering\n", id); 
	sleep(id*100);
	printf(1,"thread %d exiting\n", id); 
	kthread_exit(); 
}

void test_kthread_create(){
	void* threads_stacks[THREAD_NUM];
	for(int i = 0; i < THREAD_NUM; i++){
		char* ustack = (char*)malloc(MAX_STACK_SIZE);
		threads_stacks[i] = ustack;
	}
    for(int i = 0; i < THREAD_NUM; i++){
        kthread_create(run, threads_stacks[i]);
    }
	sleep(1000);
    exit();
}

void run1(){
	int id = kthread_id();
	printf(1, "my id: %d\n", id);
	sleep(id*100);
	printf(1,"hello\n");
	kthread_exit();
}

void test1(){
	void* stack = (void*)malloc(MAX_STACK_SIZE);
	int tid = kthread_create(run1, stack);
	int res = kthread_join(tid);
	printf(1, "result: %d, tid: %d\n", res, tid);
	exit();
}


void print_id(void)
{
	printf(1,"Thread id is: %d\n",kthread_id());
	sleep(1000);
	printf(1,"Thread is exiting.\n");
	kthread_exit();
}

void threadTest1(){
	int tid1,tid2;
	void* stack1 = (void*)malloc(4000);
	void* stack2 = (void*)malloc(4000);	
	
	tid1=kthread_create((void*)print_id,stack1);
	tid2=kthread_create((void*)print_id,stack2);
	
	kthread_join(tid1);
	printf(1,"Got id : %d \n",tid1);
	kthread_join(tid2);
	printf(1,"Got id : %d \n",tid2);
	printf(1,"Finished.\n");
	sleep(500);
	kthread_exit();
}

void* printBLABLA()
{
	printf(1,"blabla.\n");
	sleep(500);
	exit();
}

void threadTest2(){
	void* stack1 = (void*)malloc(4000);
	void* stack2 = (void*)malloc(4000);	
	/*int tid1,tid2;*/
	kthread_create((void*)printBLABLA,stack1);
	kthread_create((void*)printBLABLA,stack2);
	/*printf(1,"tid1 is: %d.\n",tid1);
	printf(1,"tid2 is: %d.\n",tid2);
	printf(1,"pid: %d.\n",getpid());*/
	sleep(500);
	exit();
}

void* printme() {
  printf(1,"Thread %d running !\n", kthread_id());
  kthread_exit();
  return 0;
}

void threadTest3(){
	 uint *stack, *stack1, *stack2;
  int tid, tid1, tid2;
  int MAX_STACK = 4000;
 
  stack = malloc(MAX_STACK);
  memset(stack, 0, sizeof(*stack));
  if ((tid = (kthread_create((void*)printme, stack))) < 0) {
    printf(2, "thread_create error\n");
  }
  stack1  = malloc(MAX_STACK);
  memset(stack1, 0, sizeof(*stack1));
  if ((tid1 = (kthread_create((void*)printme, stack1))) < 0) {
    printf(2, "thread_create error\n");
  }
  stack2  = malloc(MAX_STACK);
  memset(stack2, 0, sizeof(*stack2));
  if ((tid2 = (kthread_create((void*)printme, stack2))) < 0) {
    printf(2, "thread_create error\n");
  }
  printf(1, "Joining %d\n", tid);
  if (kthread_join(tid) < 0) {
    printf(2, "join error\n");
  }
  printf(1, "Joining %d\n", tid1);
  if (kthread_join(tid1) < 0) {
    printf(2, "join error\n");
  }
  printf(1, "Joining %d\n", tid2);
  if (kthread_join(tid2) < 0) {
    printf(2, "join error\n");
  }
  printf(1, "\nAll threads done!\n");
  exit();
}

int
main(int argc, char *argv[])
{
    //test_kthread_create();
	//test1();
	for(int i = 0; i < 200; i++){
		printf(1, "loop - %d\n", i);
    	mutexTest();
	}
	//threadTest1();
	//threadTest2();
	//threadTest3();
    exit();
}
