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

#define STACK_SIZE 500

void run1(){ 
    int id = kthread_id();
    sleep(id * 100); 
    printf(1,"thread %d entering\n", id); 
    printf(1,"thread %d exiting\n", id); 
    kthread_exit(); 
}

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

void test_kthread2(int THREAD_NUM){
    void* stacks[THREAD_NUM];
    int pids[THREAD_NUM];
    for(int i = 0;i < THREAD_NUM;i++){
        void* stack = ((char*) malloc(STACK_SIZE*sizeof(char))) + STACK_SIZE;
        stacks[i] = stack;
        pids[i] = kthread_create(run1, stack);
    }

    printf(1,"Starting joining threads, should indicate when each thread was sucessfully joined soon\n");

    for(int i = 0;i < THREAD_NUM;i++){
        int result = kthread_join(pids[i]);
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

    for(int i = 0;i < THREAD_NUM;i++){
        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Thread %d shouldn't be my thread anymore\n",i+1);
        }
        else if(result == -1){
            printf(1,"Thread %d isn't my thread anymore, as it should be\n",i+1);
        }
        else{
            printf(1,"Unknown result code from join\n");
        }
    }    

    for(int i = 0; i < THREAD_NUM; i++){
        free(stacks[i]);
        stacks[i] = 0;
    }
    exit();
}

void run2(){ 
    int mid; 
    int result; 
    mid = kthread_mutex_alloc(); 
    if(mid == -1){ 
        printf(1,"mutex allocated unsuccessfully\n"); 
    } 
    result = kthread_mutex_lock(mid); 
    if(result < 0){ 
        printf(1,"mutex locked unsuccessfully\n"); 
    } 
    result = kthread_mutex_unlock(mid); 
    if(result < 0){ 
        printf(1,"mutex unlocked unsuccessfully\n"); 
    } 
    result = kthread_mutex_dealloc(mid); 
    if(result == 0){} 
    else if(result == -1){ 
        printf(1,"mutex deallocated unsuccessfully\n"); 
    } 
    else{ 
        printf(1,"unkown return code from mutex dealloc\n"); 
    } 
    kthread_exit(); 
}

void run3(){ 
    int mid; 
    int result; 
    for(int i = 0;i < 20;i++){ 
        mid = kthread_mutex_alloc(); 
        if(mid == -1){ 
            printf(1,"mutex allocated unsuccessfully\n"); 
        } 
        result = kthread_mutex_dealloc(mid); 
        if(result == 0){} 
        else if(result == -1){ 
            printf(1,"mutex %d deallocated unsuccessfully\n", mid); 
        } 
        else{ 
            printf(1,"unkown return code from mutex dealloc\n"); 
        } 
        result = kthread_mutex_dealloc(mid); 
        if(result == 0){
            printf(1,"mutex %d deallocated successfully where it should not have been by thread %d\n", mid, kthread_id()); 
        } 
        else if(result == -1){} 
        else{ 
            printf(1,"unkown return code from mutex dealloc\n"); 
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
    }
    
    for(int i = 0;i < THREAD_NUM;i++){
        printf(1,"Attempting to join thread %d\n",i+1);

        int result = kthread_join(pids[i]);
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
        printf(1,"Attempting to join thread %d\n",i+1);

        int result = kthread_join(pids[i]);
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

    result = kthread_mutex_dealloc(mid); 
    if(result == -1){ 
        printf(1,"mutex deallocated unsuccessfully\n"); 
    } 

    printf(1,"Sum is %d\n",num);

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

        int maxIndex = (2^depth)-1;
        printf(1, "maxIndex=%d\n", maxIndex);
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
        test_mutex1(15, run2);
    if(test_num == 4)
        test_mutex1(15, run3);
    // TODO: test_mutex2 sometimes print error
    if(test_num == 5)
        test_mutex2(15);
    if(test_num == 6)
        test_tree1();
    if(test_num == 7)
        test_tree2();

    exit();
}