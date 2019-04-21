struct trnmnt_tree{
    struct tree_node *root;
    int depth;
};

struct tree_node{
    struct tree_node *left_child;
    struct tree_node *right_child;
    struct tree_node *parent;
    int mutex_id;
};

struct kthread_mutex_t{
  struct spinlock lock;
  int id; // mutex id
  int locked; // value 1 if it's locked
  int tid; // thread id of the locking thread
  int used; // lock alredy allocated
};

void create_tree(struct tree_node* node, int depth);
int deleteTree(struct tree_node *node);
