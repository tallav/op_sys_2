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

struct trnmnt_tree* trnmnt_tree_alloc(int depth){
    struct trnmnt_tree *tree = malloc(sizeof(struct trnmnt_tree));
    struct tree_node *root = malloc(sizeof(struct tree_node));
    tree->depth = depth;
    tree->root = root;
    root->parent = 0;
    create_tree(tree->root, depth);
    return tree;
}

void create_tree(struct tree_node* node, int depth){
    if(depth == 0){
        return;
    }
    struct tree_node *left = malloc(sizeof(struct tree_node));
    struct tree_node *right = malloc(sizeof(struct tree_node));
    left->parent = node;
    right->parent = node;
    node->left_child = left;
    node->right_child = right;
    node->mutex_id = kthread_mutex_alloc();
    create_tree(left, depth-1);
    create_tree(right, depth-1);
    return;
}
/*
static void print_tree(struct tree_node *node){
    if (node != 0){
        print_tree(node->left_child); 
        printf(1, "Node : %d, ", node->mutex_id); 
        if (node->parent == 0) 
            printf(1, "Parent : NULL \n"); 
        else
            printf(1, "Parent : %d \n", node->parent->mutex_id); 
        print_tree(node->right_child); 
    }
}
*/
static void print_tree(struct tree_node *r,int l){
	int i;
	if(!r) return ;
	print_tree(r->right_child,l+1);
	for(i=0;i<l;++i){
		printf(1,"  ");
    }
	printf(1,"%d \n",r->mutex_id);
	print_tree(r->left_child,l+1);
}

int deleteTree(struct tree_node *node){
    if (node != 0){ 
        if(kthread_mutex_dealloc(node->mutex_id) < 0){
            printf(1, "mutex dealloc failed\n");
            return -1;
        }

        /* first delete both subtrees */
        deleteTree(node->left_child); 
        deleteTree(node->right_child); 
        
        /* then delete the node */
        printf(1, "Deleting node: %d\n", node->mutex_id); 
        free(node); 
        if(node == 0)
            printf(1, "free node\n");
    }
    return 0;
}

int trnmnt_tree_dealloc(struct trnmnt_tree* tree){
    if(deleteTree(tree->root) == 0){
        if(tree->root == 0)
            printf(1,"free tree\n");
        free(tree);
        return 0;
        
    }else
        return -1;
}

int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID){
    return 0;
}

int trnmnt_tree_release(struct trnmnt_tree* tree,int ID){
    return 0;
}

int
main(int argc, char *argv[])
{
    struct trnmnt_tree *tree = trnmnt_tree_alloc(3);
    print_tree(tree->root, 0);
    trnmnt_tree_dealloc(tree);
    print_tree(tree->root, 0);
    exit();
}