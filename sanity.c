#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"
#include "tournament_tree.h"
#include "kthread.h"

// power calculation
int findPower(int base, int power) {
   if (power == 0)
      return 1;
   else
      return (base * findPower(base, power-1));
}  

// thread code in test_kthread1 and test_kthread2
void run1(){ 
    int id = kthread_id();
    sleep(id * 100); 
    printf(1,"thread %d entering\n", id); 
    printf(1,"thread %d exiting\n", id); 
    kthread_exit(); 
}

// general test for kthread
void test_kthread1(int threadsNum){
    void* stacks[threadsNum];
    for(int i = 0; i < threadsNum; i++){
        stacks[i] = ((char*) malloc(500*sizeof(char))) + 500;
        kthread_create(run1, stacks[i]);
        sleep(10);
    }

    sleep(2000);
    
    for(int i = 0; i < threadsNum; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    
    exit();
}

// test for kthread_create and kthread_join
// should not be able to join the second time
void test_kthread2(int threadsNum){
    void* stacks[threadsNum];
    int tids[threadsNum];
    for(int i = 0;i < threadsNum;i++){
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
        stacks[i] = stack;
        tids[i] = kthread_create(run1, stack);
        sleep(10);
    }

    for(int i = 0;i < threadsNum;i++){
        int result = kthread_join(tids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",tids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
    }
    sleep(1000);
    for(int i = 0;i < threadsNum;i++){
        printf(1,"trying to join thread %d\n",tids[i]);
        int result = kthread_join(tids[i]);
        if(result == 0){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
        if(result == -1){
            printf(1,"OK - join thread %d\n",tids[i]);
        }
    }    

    for(int i = 0; i < threadsNum; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

// thread code in test_kthread3
void run5(){ 
    int id = kthread_id();
    sleep(id); 
    kthread_exit(); 
}

// check that the process will not create more then 16 threads
void test_kthread3(int threadsNum){
    void* stacks[threadsNum];
    int tids[threadsNum];
    for(int i = 0;i < threadsNum;i++){
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
        stacks[i] = stack;
        tids[i] = kthread_create(run5, stacks[i]);
        if(tids[i] < 0){
            printf(1,"create thread %d failed\n",i+2);
        }else{
            printf(1,"create thread %d succeed\n",i+2);
        }
    }
    sleep(1000);
    for(int i = 0;i < threadsNum-1;i++){
        printf(1,"trying to join thread %d\n",tids[i]);
        int result = kthread_join(tids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",tids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
    }
    for(int i = 0; i < threadsNum; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

// thread code in test_mutex1
// general test for mutex functions 
void run2(){ 
    int mid; 
    int result; 
    mid = kthread_mutex_alloc(); 
    if(mid < 0){ 
        printf(1,"Error - mutex allocate\n"); 
        kthread_exit();
    }else{
        printf(1,"OK - mutex allocate, mid=%d\n", mid);
    }
    result = kthread_mutex_lock(mid); 
    if(result == 0){ 
        printf(1,"OK - mutex lock, mid=%d\n", mid); 
    } 
    if(result == -1){
        printf(1,"Error - mutex lock, mid=%d\n", mid); 
    }
    result = kthread_mutex_unlock(mid); 
    if(result == 0){ 
        printf(1,"OK - mutex unlock, mid=%d\n", mid); 
    } 
    if(result == -1){
        printf(1,"Error - mutex unlock, mid=%d\n", mid); 
    }
    result = kthread_mutex_dealloc(mid); 
    if(result == 0){ 
        printf(1,"OK - mutex deallocate, mid=%d\n", mid); 
    } 
    if(result == -1){ 
        printf(1,"Error - mutex deallocate, mid=%d\n", mid); 
    } 
    kthread_exit(); 
}

// thread code in test_mutex1
// should not be able to deallocate the second time
void run3(){ 
    int mid; 
    int result; 
    for(int i = 0;i < 10;i++){ 
        mid = kthread_mutex_alloc(); 
        if(mid < 0){ 
            printf(1,"Error - mutex allocate\n"); 
            kthread_exit();
        }else{
            printf(1,"OK - mutex allocate\n");
        }
        result = kthread_mutex_dealloc(mid); 
        if(result == 0){ 
            printf(1,"OK - mutex deallocate\n"); 
        } 
        if(result == -1){ 
            printf(1,"Error - mutex deallocate\n"); 
        } 
        result = kthread_mutex_dealloc(mid); 
        if(result == 0){ 
        printf(1,"Error - mutex deallocate (mutex already deallocated)\n"); 
        } 
        if(result == -1){ 
            printf(1,"OK - mutex deallocate\n"); 
        } 
    } 
    kthread_exit(); 
}

void test_mutex1(int threadsNum, void (*func)()){
    void* stacks[threadsNum];
    int tids[threadsNum];
    for(int i = 0;i < threadsNum;i++){
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
        stacks[i] = stack;
        tids[i] = kthread_create(func, stack);
        sleep(100);
    }
    
    for(int i = 0;i < threadsNum;i++){
        printf(1,"trying to join thread %d\n",tids[i]);
        int result = kthread_join(tids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",tids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
    }

    for(int i = 0; i < threadsNum; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

int mid = -1;
int num = 0;
volatile int waitFlag;

void run4(){
    int result; 
    while(waitFlag){};
    result = kthread_mutex_lock(mid); 
    if(result == -1){  
        printf(1,"Error - mutex lock, mid=%d\n", mid); 
    } 
    for(int i = 0;i < 100;i++){ 
        int temp = num; 
        temp++; 
        sleep(1); 
        num = temp; 
    } 
    result = kthread_mutex_unlock(mid); 
    if(result == -1){ 
        printf(1,"Error - mutex unlock, mid=%d\n", mid); 
    } 
    kthread_exit(); 
} 

// tests multiple threads trying to join on the same mutex
// expected num = 500 at the end
void test_mutex2(int threadsNum){
    waitFlag = 1;
    int tids[threadsNum];
    void* stacks[threadsNum];
    int result;
    mid = kthread_mutex_alloc(); 
    if(mid == -1){ 
        printf(1,"mutex allocated unsuccessfully\n"); 
    } 
    for(int i = 0;i < threadsNum;i++){
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
        stacks[i] = stack;
        tids[i] = kthread_create(run4, stack);
    }
    waitFlag = 0;
    for(int i = 0;i < threadsNum;i++){
        printf(1,"trying to join thread %d\n",tids[i]);
        int result = kthread_join(tids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",tids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
    }
    result = kthread_mutex_dealloc(mid); 
    if(result == -1){ 
        printf(1,"Error - mutex deallocated\n"); 
    } 
    printf(1,"num is %d\n",num);
    for(int i = 0; i < threadsNum; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

int mutexId;
int isThreadRunning;
int res;

 void test_mutex3_helper()
 {
 	int funcInput = kthread_mutex_lock(mutexId);
 	if(funcInput<0){
 		printf(1,"ERROR: thread mutex didnt lock!");
        res = 0;
     }
 	printf(1,"thread %d running func\n",kthread_id());
 	isThreadRunning=1;
	funcInput = kthread_mutex_unlock(mutexId);
 	if(funcInput<0){
        printf(1,"ERROR: thread mutex didnt unlock!");
        res = 0;
     }
    	
 	kthread_exit();
 	printf(1,"ERROR: returned from exit !!");
    res = 0;
 }

// Test threads behavior while using mutexes, and also mutex functions.
 void test_mutex3()
 {
    int res = 1;
 	int funcInput;
 	mutexId = kthread_mutex_alloc();
 	if(mutexId<0){
         printf(1,"ERROR: mutex %d didnt alloc! \n",mutexId);
         res = 0;
     }
 	for(int i = 0; i<20; i++){
 		isThreadRunning=0;
 		funcInput = kthread_mutex_lock(mutexId);
 		char* stack =  ((char *) malloc(MAX_STACK_SIZE * sizeof(char))) + MAX_STACK_SIZE;
 		int tid = kthread_create ((void*)test_mutex3_helper, stack);
 		if(tid<0){
             printf(1,"ERROR: Thread wasnt created correctly %d\n",tid);
             res = 0;
         }
 		if(isThreadRunning){
             printf(1,"ERROR: mutex didnt prevent writing!\n");
             res =0;
        }
 		funcInput = kthread_mutex_unlock(mutexId);
 		if(funcInput<0){
            printf(1,"ERROR: mutex didnt unlock!\n");
            res = 0;
         }
 		kthread_join(tid);
 		if(!isThreadRunning){
              printf(1,"ERROR: thread didnt run!\n");
              res = 0;
         }
 	}
 	funcInput = kthread_mutex_dealloc(mutexId);
 	if(funcInput<0){
        printf(1,"ERROR: mutex didnt dealloc!\n");
        res = 0;
    }

 	if (res == 1){
         printf(1, "Test passed!");
    }else{
        printf(1, "Test failed.. :(");
    }
    exit();
 }


// allocates turnament tree with several depthes and prints them
void test_tree1(){
    int result;
    struct trnmnt_tree* tree;
    
    for(int i = 1; i < 5; i++){
        tree = trnmnt_tree_alloc(i); 
        if(tree == 0){ 
            printf(1,"Error - trnmnt_tree allocate\n"); 
        } 
        print_tree(tree);
        printf(1, "\n--------------------------------\n");
        result = trnmnt_tree_dealloc(tree); 
        if(result == -1){ 
            printf(1,"Error - trnmnt_tree deallocate\n"); 
        } 
    }
    exit();
}

void test_tree2(){
    int result;
    trnmnt_tree* tree;
    int depth;
    for(depth = 1; depth < 5; depth++){
        tree = trnmnt_tree_alloc(depth); 
        if(tree == 0){ 
            printf(1,"Error - trnmnt_tree allocate\n"); 
        }
        int maxIndex = findPower(2,depth)-1;
        printf(1, "depth=%d, maxIndex=%d\n", depth, maxIndex);
        for(int index = 0; index <= maxIndex; index++){
            result = trnmnt_tree_acquire(tree, index); 
            if(result == 0){  
                printf(1,"OK - trnmnt_tree lock by ID=%d\n", index); 
            }
            if(result == -1){  
                printf(1,"Error - trnmnt_tree lock by ID=%d\n", index); 
            }
            result = trnmnt_tree_release(tree, index); 
            if(result == 0){  
                printf(1,"OK - trnmnt_tree unlock by ID=%d\n", index); 
            }
            if(result == -1){  
                printf(1,"Error - trnmnt_tree unlock by ID=%d\n", index); 
            }
        }
        result = trnmnt_tree_dealloc(tree); 
        if(result == -1){ 
            printf(1,"Error - trnmnt_tree deallocate\n"); 
        } 
    }
    exit();
}

trnmnt_tree* tree;
volatile int waitFlag2;
int result;

// thread trying to acquire the tree and need to succeed
void run6(){
    int result6;
    while(waitFlag2){} 

    result6 = trnmnt_tree_acquire(tree, 0); 
    if(result6 == 0){  
        printf(1,"OK - trnmnt_tree_acquire by thread %d\n", kthread_id()); 
    }
    if(result6 == -1){  
        printf(1,"Error - trnmnt_tree_acquire by thread %d\n", kthread_id()); 
    }

    sleep(400);
    
    result6 = trnmnt_tree_release(tree, 0); 
    if(result == 0){  
        printf(1,"OK - trnmnt_tree_release by thread %d\n", kthread_id()); 
    }
    if(result == -1){  
        printf(1,"Error - trnmnt_tree_release by thread %d\n", kthread_id()); 
    }

    kthread_exit(); 
}

// thread trying to deallocate the tree when it's locked - supposed to fail
// supposed to succeed on the seconed time (after release by the other thread)
void run7(){
    int result;
    while(waitFlag2){} 
    sleep(200);

    result = trnmnt_tree_dealloc(tree); 
    if(result == 0){
        printf(1,"Error - trnmnt_tree deallocate by thread %d\n", kthread_id()); 
    } 
    if(result == -1){
        printf(1,"OK - trnmnt_tree deallocate should be -1 by thread %d\n", kthread_id());
    } 

    sleep(600);

    result = trnmnt_tree_dealloc(tree); 
    if(result == 0){
        printf(1,"OK - trnmnt_tree deallocate should be 0 by thread %d\n", kthread_id());
    } 
    if(result == -1){
        printf(1,"Error - trnmnt_tree deallocate by thread %d\n", kthread_id()); 
    } 

    kthread_exit(); 
}

// thread trying to acquire the tree when it's already locked
// supposed to succeed only after release by thr other thread
void run8(){
    int result6;
    while(waitFlag2){} 

    result6 = trnmnt_tree_acquire(tree, 6); 
    if(result6 == 0){  
        printf(1,"OK - trnmnt_tree_acquire thread %d should succeed after release\n", kthread_id()); 
    }
    if(result6 == -1){  
        printf(1,"Error - trnmnt_tree_acquire by thread %d\n", kthread_id()); 
    }
    
    result6 = trnmnt_tree_release(tree, 6); 
    if(result == 0){  
        printf(1,"OK - trnmnt_tree_release by thread %d\n", kthread_id()); 
    }
    if(result == -1){  
        printf(1,"Error - trnmnt_tree_release by thread %d\n", kthread_id()); 
    }

    kthread_exit(); 
}

void test_tree3(void (*func1)(), void (*func2)()){
    int threadsNum = 2;
    waitFlag2 = 1;
    void* stacks[threadsNum];
    int tids[threadsNum];

    tree = trnmnt_tree_alloc(3); 
    if(tree == 0){ 
        printf(1,"Error - trnmnt_tree allocate\n"); 
    } 
    print_tree(tree);
    for(int i = 0;i < threadsNum;i++){
        stacks[i] = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
    }
    tids[0] = kthread_create(func1, stacks[0]);
    tids[1] = kthread_create(func2, stacks[1]);

    waitFlag2 = 0;
    
    for(int i = 0;i < threadsNum;i++){
        int result = kthread_join(tids[i]);
        if(result == -1){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
    }
    for(int i = 0;i < threadsNum;i++){
        free(stacks[i]);
    }
    exit();
}

int
main(int argc, char *argv[])
{
    if(argc < 2){
		printf(1, "test num missing\n");
		exit();
	}
    int test_num = atoi(argv[1]);
    if(test_num == 1)
        test_kthread1(6);
    if(test_num == 2)
        test_kthread2(10);
    if(test_num == 3)
        test_kthread3(16);
    if(test_num == 4)
        test_mutex1(5, run2);
    if(test_num == 5)
        test_mutex1(2, run3);
    if(test_num == 6)
        test_mutex2(4);
    if(test_num == 7)
        test_tree1();
    if(test_num == 8)
        test_tree2();
    if(test_num == 9)
        test_tree3(run6, run7);
    if(test_num == 10)
        test_tree3(run6, run6);
    if (test_num == 11)
        test_mutex3(3);

    exit();
}
