struct trnmnt_tree{
    struct tree_node *root;
    int depth;
};

struct tree_node{
    struct tree_node *left_child;
    struct tree_node *right_child;
    struct tree_node *parent;
    int mutex_id;
    int index; 
    int level;
    struct tree_node **lockPath;
};

void create_tree(struct tree_node* node, int depth);
void print_node(struct tree_node *n,int l);
void print_tree(struct trnmnt_tree *t);
int delete_node(struct tree_node *node);
struct tree_node* find_leaf(struct tree_node* node, int ID);
