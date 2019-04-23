#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"
#include "spinlock.h"
#include "tournament_tree.h"

int* level_index;

struct trnmnt_tree* trnmnt_tree_alloc(int depth){
    struct trnmnt_tree *tree = malloc(sizeof(struct trnmnt_tree));
    struct tree_node *root = malloc(sizeof(struct tree_node));
    tree->depth = depth;
    tree->root = root;
    root->parent = 0;
    int arr[depth];
    for(int i = 0; i < depth; i++)
        arr[i] = 0;
    level_index = arr;
    create_tree(tree->root, depth);
    return tree;
}

int index = 0;
int curLevel = -2;

void create_tree(struct tree_node* node, int depth){
    if(depth == 0){
        return;
    }
    if(curLevel != depth-2){
            index = level_index[depth-1];
            curLevel = depth-2;
        }
    node->level = curLevel;
    node->index = index;
    index++;
    level_index[depth-1] = index;
    if(depth == 1){
        node->left_child = 0;
        node->right_child = 0;
    }else{
        struct tree_node *left = malloc(sizeof(struct tree_node));
        struct tree_node *right = malloc(sizeof(struct tree_node));
        left->parent = node;
        right->parent = node;
        node->left_child = left;
        node->right_child = right;
        node->mutex_id = kthread_mutex_alloc();
        create_tree(left, depth-1);
        create_tree(right, depth-1);
    }
    return;
}

void print_node(struct tree_node *n,int l){
	if(!n) return;
    int i;
	print_node(n->right_child,l+1);
	for(i=0;i<l;++i){
		printf(1,"    ");
    }
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
	print_node(n->left_child,l+1);
}

void print_tree(struct trnmnt_tree *t){
    if(!t) return;
	print_node(t->root,0);
}

int delete_node(struct tree_node *node){
    if (node != 0){ 
        if(kthread_mutex_dealloc(node->mutex_id) < 0){
            printf(1, "mutex dealloc failed\n");
            return -1;
        }
        // first delete both subtrees
        delete_node(node->left_child); 
        delete_node(node->right_child); 
        node->left_child = 0;
        node->right_child = 0;
        // then delete the node
        printf(1, "Deleting node: %d\n", node->mutex_id); 
        free(node); 
    }
    return 0;
}

int trnmnt_tree_dealloc(struct trnmnt_tree* tree){
    if(delete_node(tree->root) == 0){
        tree->root = 0;
        free(tree);
        return 0;
    }else{
        return -1;
    }
}

int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID){
    struct tree_node* leaf = find_leaf(tree->root, ID);
    while(leaf->parent){
        int mutexID = leaf->parent->mutex_id;
        int mutex_lock = kthread_mutex_lock(mutexID);
        if(mutex_lock == -1){
            return -1;
        }
        if(mutex_lock == 0){
            leaf = leaf->parent;
        }
    }
    return 0;
}

int trnmnt_tree_release(struct trnmnt_tree* tree,int ID){

    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
    if(node->right_child == 0 && node->left_child == 0){ //leaf
        printf(1, "leaf %d\n", node->index);
        if(ID == node->index){
            printf(1, "found %d\n", node->index);
            return node;
        }else{
            return 0;
        }
    }else{
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
        if(leaf1)
            return leaf1;
        else
            return leaf2;
    }
} 

struct trnmnt_tree *tree;
int i;

void tryAcquireMutex(){
    trnmnt_tree_acquire(tree, i);
    kthread_exit();
}

int
main(int argc, char *argv[])
{
    tree = trnmnt_tree_alloc(4);
    print_tree(tree);
    i = 1;
    void* stack1 = (char*)(malloc(4000*sizeof(char))) + 4000;
    int tid1 = kthread_create(tryAcquireMutex, stack1);
    kthread_join(tid1);
    /*i = 2;
    void* stack2 = (char*)(malloc(4000*sizeof(char))) + 4000;
    int tid2 = kthread_create(tryAcquireMutex, stack2);
    kthread_join(tid2);*/
    exit();
}
