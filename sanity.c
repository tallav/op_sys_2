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

#define STACK_SIZE 700

int power(int number,int power);
int powerHelper(int currentValue,int power, int times);

// thread code in test_kthread1 and test_kthread2
void run1(){ 
    int id = kthread_id();
    sleep(id * 100); 
    printf(1,"thread %d entering\n", id); 
    printf(1,"thread %d exiting\n", id); 
    kthread_exit(); 
}

// general test for kthread
void test_kthread1(int THREAD_NUM){
    void* stacks[THREAD_NUM];
    for(int i = 0; i < THREAD_NUM; i++){
        void* stack = ((char*) malloc(STACK_SIZE*sizeof(char))) + STACK_SIZE;
        stacks[i] = stack;
        kthread_create(run1, stack);
    }
    sleep(2000);
    for(int i = 0; i < THREAD_NUM; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

// test for kthread_create and kthread_join
// should not be able to join the second time
void test_kthread2(int THREAD_NUM){
    void* stacks[THREAD_NUM];
    int pids[THREAD_NUM];
    for(int i = 0;i < THREAD_NUM;i++){
        void* stack = ((char*) malloc(STACK_SIZE*sizeof(char))) + STACK_SIZE;
        stacks[i] = stack;
        pids[i] = kthread_create(run1, stack);
    }

    for(int i = 0;i < THREAD_NUM;i++){
        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",pids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",pids[i]);
        }
    }

    for(int i = 0;i < THREAD_NUM;i++){
        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Error - join thread %d\n",pids[i]);
        }
        if(result == -1){
            printf(1,"OK - join thread %d\n",pids[i]);
        }
    }    

    for(int i = 0; i < THREAD_NUM; i++){
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
void test_kthread3(int THREAD_NUM){
    void* stacks[THREAD_NUM];
    int tids[THREAD_NUM];
    for(int i = 0;i < THREAD_NUM;i++){
        void* stack = ((char*) malloc(STACK_SIZE*sizeof(char))) + STACK_SIZE;
        stacks[i] = stack;
        tids[i] = kthread_create(run5, stacks[i]);
        if(tids[i] > 0){
            printf(1,"create thread %d succeed\n",i+2);
        }else{
            printf(1,"create thread %d failed\n",i+2);
        }
    }
    for(int i = 0;i < THREAD_NUM-1;i++){
        int result = kthread_join(tids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",tids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",tids[i]);
        }
    }
    for(int i = 0; i < THREAD_NUM; i++){
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

void test_mutex1(int THREAD_NUM, void (*func)()){
    void* stacks[THREAD_NUM];
    int pids[THREAD_NUM];
    for(int i = 0;i < THREAD_NUM;i++){
        void* stack = ((char*) malloc(STACK_SIZE*sizeof(char))) + STACK_SIZE;
        stacks[i] = stack;
        pids[i] = kthread_create(func, stack);
        sleep(100);
    }
    
    for(int i = 0;i < THREAD_NUM;i++){
        printf(1,"trying to join thread %d\n",pids[i]);
        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",pids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",pids[i]);
        }
    }

    for(int i = 0; i < THREAD_NUM; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

int mid = -1;
volatile int dontStart;
int num = 0;

void run4(){
    int result; 
    while(dontStart){}; 
    result = kthread_mutex_lock(mid); 
    if(result < 0){  
        printf(1,"mutex locked unsuccessfully\n"); 
    } 
    for(int i = 0;i < 500;i++){ 
        int temp = num; 
        temp++; 
        sleep(1); 
        num = temp; 
    } 
    result = kthread_mutex_unlock(mid); 
    if(result < 0){ 
        printf(1,"mutex unlocked unsuccessfully\n"); 
    } 
    kthread_exit(); 
} 

void test_mutex2(int THREAD_NUM){
    dontStart = 1;
    int pids[THREAD_NUM];
    int result;
    mid = kthread_mutex_alloc(); 
    if(mid == -1){ 
        printf(1,"mutex allocated unsuccessfully\n"); 
    } 
    void* stacks[THREAD_NUM];
    for(int i = 0;i < THREAD_NUM;i++){
        void* stack = ((char*) malloc(STACK_SIZE*sizeof(char))) + STACK_SIZE;
        stacks[i] = stack;
        pids[i] = kthread_create(run4, stack);
    }

    dontStart = 0;
    
    for(int i = 0;i < THREAD_NUM;i++){
        printf(1,"trying to join thread %d\n",pids[i]);
        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"OK - join thread %d\n",pids[i]);
        }
        if(result == -1){
            printf(1,"Error - join thread %d\n",pids[i]);
        }
    }

    result = kthread_mutex_dealloc(mid); 
    if(result == -1){ 
        printf(1,"Error - mutex deallocated\n"); 
    } 

    printf(1,"num is %d\n",num);

    for(int i = 0; i < THREAD_NUM; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

void test_tree1(){
    int result;
    struct trnmnt_tree* tree;
    
    for(int i = 1; i <= 5; i++){
        tree = trnmnt_tree_alloc(i); 
        if(tree == 0){ 
            printf(1,"1 trnmnt_tree allocated unsuccessfully\n"); 
        } 
        print_tree(tree);
        printf(1, "\n--------------------------------\n");
        result = trnmnt_tree_dealloc(tree); 
        if(result == 0){}
        else if(result == -1){ 
            printf(1,"1 trnmnt_tree deallocated unsuccessfully\n"); 
        } 
        else{ 
            printf(1,"unkown return code from trnmnt_tree_dealloc\n"); 
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
            printf(1,"trnmnt_tree allocated unsuccessfully\n"); 
        } 
        print_tree(tree);

        int maxIndex = power(2,depth)-1;
        printf(1, "depth=%d, maxIndex=%d\n", depth, maxIndex);
        for(int index = 0; index < maxIndex; index++){
            result = trnmnt_tree_acquire(tree, index); 
            if(result == 0){  
                printf(1,"trnmnt_tree locked - depth=%d , index=%d\n", depth, index); 
            }else if(result == -1){  
                printf(1,"trnmnt_tree locked unsuccessfully - depth=%d , index=%d\n", depth, index); 
            }else{
                printf(1,"unkown return code from trnmnt_tree_acquire\n"); 
            }
            result = trnmnt_tree_release(tree, index); 
            if(result == 0){  
                printf(1,"trnmnt_tree unlocked - depth=%d , index=%d\n", depth, index); 
            }else if(result == -1){  
                printf(1,"trnmnt_tree unlocked unsuccessfully - depth=%d , index=%d\n", depth, index); 
            }else{
                printf(1,"unkown return code from trnmnt_tree_release\n"); 
            }
        }

        result = trnmnt_tree_dealloc(tree); 
        if(result == -1){ 
            printf(1,"trnmnt_tree deallocated unsuccessfully\n"); 
        } 
    }
    exit();
}

trnmnt_tree* tree;
volatile int dontStart;
int result;
int THREAD_NUM = 2;
int DEPTH_MAX = 3;
int num;
volatile int depth;

int power(int number,int power);
int powerHelper(int currentValue,int power, int times);


void run6(){ 
    int id = kthread_id() - 5;
    printf(1, "id=%d\n", id);
    trnmnt_tree* tree; 
    int result2; 
    tree = trnmnt_tree_alloc(depth); 
    if(tree == 0){  
        printf(1,"4 trnmnt_tree allocated unsuccessfully\n"); 
    } 
    print_tree(tree);
    result2 = trnmnt_tree_acquire(tree, id - 1); 
    if(result2 < 0){  
        printf(1,"trnmnt_tree locked unsuccessfully\n"); 
    } 
    result2 = trnmnt_tree_release(tree, id - 1); 
    if(result < 0){ 
        printf(1,"trnmnt_tree unlocked unsuccessfully\n"); 
    } 
    result2 = trnmnt_tree_dealloc(tree); 
    if(result2 == -1){ 
        printf(1,"1 trnmnt_tree deallocated unsuccessfully\n"); 
    } 
    kthread_exit(); 
}  

void initiateMutexTest(){
    dontStart = 1;
    int result;
    int num_threads = power(2,depth);
    printf(1,"num_threads=%d\n", num_threads);
    int pids[num_threads];
    void* threads_stacks[num_threads];

    for(int i = 0;i < num_threads;i++){
        threads_stacks[i] = ((char*) malloc(STACK_SIZE * sizeof(char))) + STACK_SIZE;
        pids[i] = kthread_create(run6, threads_stacks[i]);
    }

    dontStart = 0;
    
    for(int i = 0;i < num_threads;i++){
        printf(1,"Attempting to join thread %d\n",i+1);

        result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Finished joing thread %d\n",i+1);
        }
        else if(result == -1){
            printf(1,"Error in joing thread %d\n",i+1);
        }
        else{
            printf(1,"Unknown result code from join\n");
        }
    }

    for(int i = 0;i < num_threads;i++){
        free(threads_stacks[i]);
        threads_stacks[i] = 0;
    }
    exit();
}

int test_tree4(){
    int pid;

    printf(1,"Starting tournament test 4\n");

    for(int i = 0;i < 1;i++){
        depth = i + 1;
        printf(1,"\n---------------------------------------\nStarted current test for %d depth\n",i+1);

        if((pid = fork()) == 0){
            initiateMutexTest();
            exit();
        }
        else if(pid > 0){
            wait();
        }
        else{
            printf(1,"fork failed\n");
        }

        printf(1,"Finished current test for %d depth\n---------------------------------------\n",i+1);
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
        test_kthread1(10);
    if(test_num == 2)
        test_kthread2(10);
    if(test_num == 3)
        test_kthread3(16);
    // TODO: not an intresting test
    if(test_num == 4)
        test_mutex1(5, run2);
    if(test_num == 5)
        test_mutex1(2, run3);
    // TODO: test_mutex2 sometimes print error
    if(test_num == 6)
        test_mutex2(15);
    if(test_num == 7)
        test_tree1();
    if(test_num == 8)
        test_tree2();
    if(test_num == 9)
        test_tree4();

    exit();
}

// Calculating math power
int power(int number,int power){
    if(power == 0){
        return 1;
    }
    else if(power == 1){
        return number;
    }
    else{
        return powerHelper(1, number, power);
    }
}

// Calculating math power helper
int powerHelper(int currentValue,int power, int times){
    if(times == 0){
        return currentValue;
    }
    else{
        return powerHelper(currentValue * power, power, times - 1);
    }
}
