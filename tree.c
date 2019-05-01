#include "types.h"
#include "user.h"
#include "tournament_tree.h"
#include "kthread.h"

int* level_index; // array of node indeces that holds the max index in the level (used in create_tree)
int treeDepth = 0;

trnmnt_tree* trnmnt_tree_alloc(int depth){
    if(depth < 1) // illegal depth
        return 0;
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
    struct tree_node *root = malloc(sizeof(struct tree_node));
    treeDepth = depth;
    tree->depth = depth;
    tree->root = root;
    root->parent = 0;
    int arr[depth+1];
    for(int i = 0; i < depth+1; i++)
        arr[i] = 0;
    level_index = arr;
    create_tree(tree->root, depth+1);
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
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
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

void print_tree(trnmnt_tree *t){
    if(!t) return;
	print_node(t->root,0);
}

int delete_node(struct tree_node *node){
    if (node != 0){ 
        if(kthread_mutex_dealloc(node->mutex_id) == -1){
            return -1;
        }
        // first delete both subtrees
        delete_node(node->left_child); 
        delete_node(node->right_child); 
        node->left_child = 0;
        node->right_child = 0;
        if(node->lockPath){
            free(node->lockPath);
            node->lockPath = 0;
        }
        // then delete the node
        free(node); 
    }
    return 0;
}

int trnmnt_tree_dealloc(trnmnt_tree* tree){
    if(delete_node(tree->root) == 0){
        tree->root = 0;
        free(tree);
        tree = 0;
        return 0;
    }else{
        return -1;
    }
}

int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
    struct tree_node* leaf = find_leaf(tree->root, ID);
    struct tree_node* curNode = leaf;
    while(curNode->parent){
        int mutexID = curNode->parent->mutex_id;
        int level = curNode->parent->level;
        int mutex_lock = kthread_mutex_lock(mutexID);
        leaf->lockPath[level] = curNode->parent->mutex_id;

        if(mutex_lock == -1){
            return -1;
        }
        if(mutex_lock == 0){
            curNode = curNode->parent;
        }
    }
    return 0;
}

int trnmnt_tree_release(trnmnt_tree* tree,int ID){
    struct tree_node* leaf = find_leaf(tree->root, ID);
    for(int i = treeDepth-1; i >= 0; i--){
        int res = kthread_mutex_unlock(leaf->lockPath[i]);
        if(res == -1){
            return -1;
        }
        leaf->lockPath[i] = 0;
    }
    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
    if(node->right_child == 0 && node->left_child == 0){ 
        if(ID == node->index){
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
