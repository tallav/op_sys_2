
_tree:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 18             	sub    $0x18,%esp
    tree = trnmnt_tree_alloc(4);
  13:	6a 04                	push   $0x4
  15:	e8 56 01 00 00       	call   170 <trnmnt_tree_alloc>
    if(!t) return;
  1a:	83 c4 10             	add    $0x10,%esp
  1d:	85 c0                	test   %eax,%eax
    tree = trnmnt_tree_alloc(4);
  1f:	a3 0c 12 00 00       	mov    %eax,0x120c
    if(!t) return;
  24:	74 0e                	je     34 <main+0x34>
	print_node(t->root,0);
  26:	51                   	push   %ecx
  27:	51                   	push   %ecx
  28:	6a 00                	push   $0x0
  2a:	ff 30                	pushl  (%eax)
  2c:	e8 bf 01 00 00       	call   1f0 <print_node>
  31:	83 c4 10             	add    $0x10,%esp
    print_tree(tree);

    void* stack1 = (char*)(malloc(4000*sizeof(char))) + 4000;
  34:	83 ec 0c             	sub    $0xc,%esp
  37:	68 a0 0f 00 00       	push   $0xfa0
  3c:	e8 af 0b 00 00       	call   bf0 <malloc>
    int tid1 = kthread_create(tryAcquireMutex, stack1);
  41:	5a                   	pop    %edx
  42:	59                   	pop    %ecx
    void* stack1 = (char*)(malloc(4000*sizeof(char))) + 4000;
  43:	05 a0 0f 00 00       	add    $0xfa0,%eax
    int tid1 = kthread_create(tryAcquireMutex, stack1);
  48:	50                   	push   %eax
  49:	68 30 05 00 00       	push   $0x530
  4e:	e8 4f 08 00 00       	call   8a2 <kthread_create>
    
    void* stack2 = (char*)(malloc(4000*sizeof(char))) + 4000;
  53:	c7 04 24 a0 0f 00 00 	movl   $0xfa0,(%esp)
    int tid1 = kthread_create(tryAcquireMutex, stack1);
  5a:	89 c6                	mov    %eax,%esi
    void* stack2 = (char*)(malloc(4000*sizeof(char))) + 4000;
  5c:	e8 8f 0b 00 00       	call   bf0 <malloc>
    int tid2 = kthread_create(tryAcquireMutex, stack2);
  61:	5b                   	pop    %ebx
  62:	5a                   	pop    %edx
    void* stack2 = (char*)(malloc(4000*sizeof(char))) + 4000;
  63:	05 a0 0f 00 00       	add    $0xfa0,%eax
    int tid2 = kthread_create(tryAcquireMutex, stack2);
  68:	50                   	push   %eax
  69:	68 30 05 00 00       	push   $0x530
  6e:	e8 2f 08 00 00       	call   8a2 <kthread_create>
  73:	89 c3                	mov    %eax,%ebx

    kthread_join(tid1);
  75:	89 34 24             	mov    %esi,(%esp)
  78:	e8 3d 08 00 00       	call   8ba <kthread_join>
    kthread_join(tid2);
  7d:	89 1c 24             	mov    %ebx,(%esp)
  80:	e8 35 08 00 00       	call   8ba <kthread_join>
    
    exit();
  85:	e8 78 07 00 00       	call   802 <exit>
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <create_tree>:
void create_tree(struct tree_node* node, int depth){
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	56                   	push   %esi
  95:	53                   	push   %ebx
  96:	83 ec 1c             	sub    $0x1c,%esp
  99:	8b 75 0c             	mov    0xc(%ebp),%esi
  9c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
  9f:	85 f6                	test   %esi,%esi
  a1:	0f 84 8a 00 00 00    	je     131 <create_tree+0xa1>
  a7:	8d 04 b5 fc ff ff ff 	lea    -0x4(,%esi,4),%eax
  ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  b1:	8d 4e fe             	lea    -0x2(%esi),%ecx
  b4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  b7:	03 15 08 12 00 00    	add    0x1208,%edx
    if(curLevel != depth-2){
  bd:	39 0d ec 11 00 00    	cmp    %ecx,0x11ec
  c3:	a1 f4 11 00 00       	mov    0x11f4,%eax
  c8:	74 08                	je     d2 <create_tree+0x42>
        index = level_index[depth-1];
  ca:	8b 02                	mov    (%edx),%eax
        curLevel = depth-2;
  cc:	89 0d ec 11 00 00    	mov    %ecx,0x11ec
    node->index = index;
  d2:	89 43 10             	mov    %eax,0x10(%ebx)
    index++;
  d5:	83 c0 01             	add    $0x1,%eax
    if(depth == 1){
  d8:	83 fe 01             	cmp    $0x1,%esi
    node->level = curLevel;
  db:	89 4b 14             	mov    %ecx,0x14(%ebx)
    index++;
  de:	a3 f4 11 00 00       	mov    %eax,0x11f4
    level_index[depth-1] = index;
  e3:	89 02                	mov    %eax,(%edx)
    if(depth == 1){
  e5:	74 59                	je     140 <create_tree+0xb0>
        struct tree_node *left = malloc(sizeof(struct tree_node));
  e7:	83 ec 0c             	sub    $0xc,%esp
        create_tree(left, depth-1);
  ea:	83 ee 01             	sub    $0x1,%esi
        struct tree_node *left = malloc(sizeof(struct tree_node));
  ed:	6a 1c                	push   $0x1c
  ef:	e8 fc 0a 00 00       	call   bf0 <malloc>
        struct tree_node *right = malloc(sizeof(struct tree_node));
  f4:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
        struct tree_node *left = malloc(sizeof(struct tree_node));
  fb:	89 c7                	mov    %eax,%edi
        struct tree_node *right = malloc(sizeof(struct tree_node));
  fd:	e8 ee 0a 00 00       	call   bf0 <malloc>
        left->parent = node;
 102:	89 5f 08             	mov    %ebx,0x8(%edi)
        right->parent = node;
 105:	89 58 08             	mov    %ebx,0x8(%eax)
        node->left_child = left;
 108:	89 3b                	mov    %edi,(%ebx)
        node->right_child = right;
 10a:	89 43 04             	mov    %eax,0x4(%ebx)
 10d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        node->mutex_id = kthread_mutex_alloc();
 110:	e8 ad 07 00 00       	call   8c2 <kthread_mutex_alloc>
 115:	89 43 0c             	mov    %eax,0xc(%ebx)
        create_tree(left, depth-1);
 118:	58                   	pop    %eax
 119:	5a                   	pop    %edx
 11a:	56                   	push   %esi
 11b:	57                   	push   %edi
 11c:	e8 6f ff ff ff       	call   90 <create_tree>
 121:	8b 55 e0             	mov    -0x20(%ebp),%edx
 124:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
    if(depth == 0){
 128:	83 c4 10             	add    $0x10,%esp
 12b:	85 f6                	test   %esi,%esi
 12d:	89 d3                	mov    %edx,%ebx
 12f:	75 80                	jne    b1 <create_tree+0x21>
}
 131:	8d 65 f4             	lea    -0xc(%ebp),%esp
 134:	5b                   	pop    %ebx
 135:	5e                   	pop    %esi
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        node->left_child = 0;
 140:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        struct tree_node* nodeArr[treeDepth-1];
 146:	a1 f8 11 00 00       	mov    0x11f8,%eax
    if(depth == 1){
 14b:	89 e2                	mov    %esp,%edx
        node->right_child = 0;
 14d:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        struct tree_node* nodeArr[treeDepth-1];
 154:	8d 04 85 0e 00 00 00 	lea    0xe(,%eax,4),%eax
 15b:	83 e0 f0             	and    $0xfffffff0,%eax
 15e:	29 c4                	sub    %eax,%esp
        node->lockPath = nodeArr;
 160:	89 63 18             	mov    %esp,0x18(%ebx)
 163:	89 d4                	mov    %edx,%esp
}
 165:	8d 65 f4             	lea    -0xc(%ebp),%esp
 168:	5b                   	pop    %ebx
 169:	5e                   	pop    %esi
 16a:	5f                   	pop    %edi
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
 16d:	8d 76 00             	lea    0x0(%esi),%esi

00000170 <trnmnt_tree_alloc>:
trnmnt_tree* trnmnt_tree_alloc(int depth){
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
 175:	8b 5d 08             	mov    0x8(%ebp),%ebx
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 178:	83 ec 0c             	sub    $0xc,%esp
 17b:	6a 08                	push   $0x8
 17d:	e8 6e 0a 00 00       	call   bf0 <malloc>
 182:	89 c6                	mov    %eax,%esi
    struct tree_node *root = malloc(sizeof(struct tree_node));
 184:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
 18b:	e8 60 0a 00 00       	call   bf0 <malloc>
    treeDepth = depth;
 190:	89 1d f8 11 00 00    	mov    %ebx,0x11f8
    tree->depth = depth;
 196:	89 5e 04             	mov    %ebx,0x4(%esi)
    int arr[depth];
 199:	83 c4 10             	add    $0x10,%esp
    tree->root = root;
 19c:	89 06                	mov    %eax,(%esi)
    root->parent = 0;
 19e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    int arr[depth];
 1a5:	8d 04 9d 12 00 00 00 	lea    0x12(,%ebx,4),%eax
 1ac:	83 e0 f0             	and    $0xfffffff0,%eax
 1af:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < depth; i++)
 1b1:	85 db                	test   %ebx,%ebx
    int arr[depth];
 1b3:	89 e2                	mov    %esp,%edx
    for(int i = 0; i < depth; i++)
 1b5:	7e 17                	jle    1ce <trnmnt_tree_alloc+0x5e>
 1b7:	31 c0                	xor    %eax,%eax
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        arr[i] = 0;
 1c0:	c7 04 82 00 00 00 00 	movl   $0x0,(%edx,%eax,4)
    for(int i = 0; i < depth; i++)
 1c7:	83 c0 01             	add    $0x1,%eax
 1ca:	39 c3                	cmp    %eax,%ebx
 1cc:	75 f2                	jne    1c0 <trnmnt_tree_alloc+0x50>
    create_tree(tree->root, depth);
 1ce:	83 ec 08             	sub    $0x8,%esp
    level_index = arr;
 1d1:	89 15 08 12 00 00    	mov    %edx,0x1208
    create_tree(tree->root, depth);
 1d7:	53                   	push   %ebx
 1d8:	ff 36                	pushl  (%esi)
 1da:	e8 b1 fe ff ff       	call   90 <create_tree>
}
 1df:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e2:	89 f0                	mov    %esi,%eax
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
 1e8:	90                   	nop
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <print_node>:
void print_node(struct tree_node *n,int l){
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
 1f5:	53                   	push   %ebx
 1f6:	83 ec 1c             	sub    $0x1c,%esp
 1f9:	8b 75 08             	mov    0x8(%ebp),%esi
 1fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
 1ff:	85 f6                	test   %esi,%esi
 201:	74 5a                	je     25d <print_node+0x6d>
	print_node(n->right_child,l+1);
 203:	8d 43 01             	lea    0x1(%ebx),%eax
 206:	83 ec 08             	sub    $0x8,%esp
 209:	50                   	push   %eax
 20a:	ff 76 04             	pushl  0x4(%esi)
 20d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 210:	e8 db ff ff ff       	call   1f0 <print_node>
	for(i=0;i<l;++i){
 215:	83 c4 10             	add    $0x10,%esp
 218:	85 db                	test   %ebx,%ebx
 21a:	7e 1d                	jle    239 <print_node+0x49>
 21c:	31 ff                	xor    %edi,%edi
 21e:	66 90                	xchg   %ax,%ax
		printf(1,"    ");
 220:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
 223:	83 c7 01             	add    $0x1,%edi
		printf(1,"    ");
 226:	68 e8 0c 00 00       	push   $0xce8
 22b:	6a 01                	push   $0x1
 22d:	e8 5e 07 00 00       	call   990 <printf>
	for(i=0;i<l;++i){
 232:	83 c4 10             	add    $0x10,%esp
 235:	39 df                	cmp    %ebx,%edi
 237:	75 e7                	jne    220 <print_node+0x30>
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
 239:	83 ec 0c             	sub    $0xc,%esp
 23c:	ff 76 0c             	pushl  0xc(%esi)
 23f:	ff 76 10             	pushl  0x10(%esi)
 242:	ff 76 14             	pushl  0x14(%esi)
 245:	68 ed 0c 00 00       	push   $0xced
 24a:	6a 01                	push   $0x1
 24c:	e8 3f 07 00 00       	call   990 <printf>
	print_node(n->left_child,l+1);
 251:	8b 36                	mov    (%esi),%esi
	if(!n) return;
 253:	83 c4 20             	add    $0x20,%esp
	print_node(n->left_child,l+1);
 256:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
 259:	85 f6                	test   %esi,%esi
 25b:	75 a6                	jne    203 <print_node+0x13>
}
 25d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 260:	5b                   	pop    %ebx
 261:	5e                   	pop    %esi
 262:	5f                   	pop    %edi
 263:	5d                   	pop    %ebp
 264:	c3                   	ret    
 265:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <print_tree>:
void print_tree(trnmnt_tree *t){
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 08             	sub    $0x8,%esp
 276:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
 279:	85 c0                	test   %eax,%eax
 27b:	74 0f                	je     28c <print_tree+0x1c>
	print_node(t->root,0);
 27d:	83 ec 08             	sub    $0x8,%esp
 280:	6a 00                	push   $0x0
 282:	ff 30                	pushl  (%eax)
 284:	e8 67 ff ff ff       	call   1f0 <print_node>
 289:	83 c4 10             	add    $0x10,%esp
}
 28c:	c9                   	leave  
 28d:	c3                   	ret    
 28e:	66 90                	xchg   %ax,%ax

00000290 <delete_node>:
int delete_node(struct tree_node *node){
 290:	55                   	push   %ebp
    return 0;
 291:	31 c0                	xor    %eax,%eax
int delete_node(struct tree_node *node){
 293:	89 e5                	mov    %esp,%ebp
 295:	53                   	push   %ebx
 296:	83 ec 04             	sub    $0x4,%esp
 299:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (node != 0){ 
 29c:	85 db                	test   %ebx,%ebx
 29e:	74 62                	je     302 <delete_node+0x72>
        if(kthread_mutex_dealloc(node->mutex_id) < 0){
 2a0:	83 ec 0c             	sub    $0xc,%esp
 2a3:	ff 73 0c             	pushl  0xc(%ebx)
 2a6:	e8 1f 06 00 00       	call   8ca <kthread_mutex_dealloc>
 2ab:	83 c4 10             	add    $0x10,%esp
 2ae:	85 c0                	test   %eax,%eax
 2b0:	78 5e                	js     310 <delete_node+0x80>
        delete_node(node->left_child); 
 2b2:	83 ec 0c             	sub    $0xc,%esp
 2b5:	ff 33                	pushl  (%ebx)
 2b7:	e8 d4 ff ff ff       	call   290 <delete_node>
        delete_node(node->right_child); 
 2bc:	58                   	pop    %eax
 2bd:	ff 73 04             	pushl  0x4(%ebx)
 2c0:	e8 cb ff ff ff       	call   290 <delete_node>
        if(node->lockPath)
 2c5:	8b 53 18             	mov    0x18(%ebx),%edx
 2c8:	83 c4 10             	add    $0x10,%esp
        node->left_child = 0;
 2cb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
 2d1:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        if(node->lockPath)
 2d8:	85 d2                	test   %edx,%edx
 2da:	74 07                	je     2e3 <delete_node+0x53>
            node->lockPath = 0;
 2dc:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
        printf(1, "Deleting node: %d\n", node->mutex_id); 
 2e3:	83 ec 04             	sub    $0x4,%esp
 2e6:	ff 73 0c             	pushl  0xc(%ebx)
 2e9:	68 0d 0d 00 00       	push   $0xd0d
 2ee:	6a 01                	push   $0x1
 2f0:	e8 9b 06 00 00       	call   990 <printf>
        free(node); 
 2f5:	89 1c 24             	mov    %ebx,(%esp)
 2f8:	e8 63 08 00 00       	call   b60 <free>
 2fd:	83 c4 10             	add    $0x10,%esp
    return 0;
 300:	31 c0                	xor    %eax,%eax
}
 302:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 305:	c9                   	leave  
 306:	c3                   	ret    
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            printf(1, "mutex dealloc failed\n");
 310:	83 ec 08             	sub    $0x8,%esp
 313:	68 f7 0c 00 00       	push   $0xcf7
 318:	6a 01                	push   $0x1
 31a:	e8 71 06 00 00       	call   990 <printf>
 31f:	83 c4 10             	add    $0x10,%esp
 322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 327:	eb d9                	jmp    302 <delete_node+0x72>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <trnmnt_tree_dealloc>:
int trnmnt_tree_dealloc(trnmnt_tree* tree){
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
 338:	83 ec 0c             	sub    $0xc,%esp
 33b:	ff 33                	pushl  (%ebx)
 33d:	e8 4e ff ff ff       	call   290 <delete_node>
 342:	83 c4 10             	add    $0x10,%esp
 345:	85 c0                	test   %eax,%eax
 347:	75 27                	jne    370 <trnmnt_tree_dealloc+0x40>
        free(tree);
 349:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
 34c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
 352:	89 c6                	mov    %eax,%esi
        free(tree);
 354:	53                   	push   %ebx
 355:	e8 06 08 00 00       	call   b60 <free>
        return 0;
 35a:	83 c4 10             	add    $0x10,%esp
}
 35d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 360:	89 f0                	mov    %esi,%eax
 362:	5b                   	pop    %ebx
 363:	5e                   	pop    %esi
 364:	5d                   	pop    %ebp
 365:	c3                   	ret    
 366:	8d 76 00             	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
 370:	be ff ff ff ff       	mov    $0xffffffff,%esi
 375:	eb e6                	jmp    35d <trnmnt_tree_dealloc+0x2d>
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <find_leaf>:
struct tree_node* find_leaf(struct tree_node* node, int ID){
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	83 ec 1c             	sub    $0x1c,%esp
 389:	8b 5d 08             	mov    0x8(%ebp),%ebx
 38c:	8b 75 0c             	mov    0xc(%ebp),%esi
    if(node->right_child == 0 && node->left_child == 0){ //leaf
 38f:	8b 4b 04             	mov    0x4(%ebx),%ecx
 392:	8b 03                	mov    (%ebx),%eax
 394:	85 c9                	test   %ecx,%ecx
 396:	75 04                	jne    39c <find_leaf+0x1c>
 398:	85 c0                	test   %eax,%eax
 39a:	74 2c                	je     3c8 <find_leaf+0x48>
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 39c:	83 ec 08             	sub    $0x8,%esp
 39f:	56                   	push   %esi
 3a0:	50                   	push   %eax
 3a1:	e8 da ff ff ff       	call   380 <find_leaf>
 3a6:	89 c7                	mov    %eax,%edi
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 3a8:	58                   	pop    %eax
 3a9:	5a                   	pop    %edx
 3aa:	56                   	push   %esi
 3ab:	ff 73 04             	pushl  0x4(%ebx)
 3ae:	e8 cd ff ff ff       	call   380 <find_leaf>
        if(leaf1)
 3b3:	83 c4 10             	add    $0x10,%esp
 3b6:	85 ff                	test   %edi,%edi
 3b8:	0f 45 c7             	cmovne %edi,%eax
} 
 3bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3be:	5b                   	pop    %ebx
 3bf:	5e                   	pop    %esi
 3c0:	5f                   	pop    %edi
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	90                   	nop
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "leaf %d\n", node->index);
 3c8:	83 ec 04             	sub    $0x4,%esp
 3cb:	ff 73 10             	pushl  0x10(%ebx)
 3ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 3d1:	68 20 0d 00 00       	push   $0xd20
 3d6:	6a 01                	push   $0x1
 3d8:	e8 b3 05 00 00       	call   990 <printf>
        if(ID == node->index){
 3dd:	83 c4 10             	add    $0x10,%esp
 3e0:	3b 73 10             	cmp    0x10(%ebx),%esi
 3e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 3e6:	75 d3                	jne    3bb <find_leaf+0x3b>
            printf(1, "found %d\n", node->index);
 3e8:	83 ec 04             	sub    $0x4,%esp
 3eb:	56                   	push   %esi
 3ec:	68 29 0d 00 00       	push   $0xd29
 3f1:	6a 01                	push   $0x1
 3f3:	e8 98 05 00 00       	call   990 <printf>
 3f8:	83 c4 10             	add    $0x10,%esp
} 
 3fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
            printf(1, "found %d\n", node->index);
 3fe:	89 d8                	mov    %ebx,%eax
} 
 400:	5b                   	pop    %ebx
 401:	5e                   	pop    %esi
 402:	5f                   	pop    %edi
 403:	5d                   	pop    %ebp
 404:	c3                   	ret    
 405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 24             	sub    $0x24,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 419:	8b 45 08             	mov    0x8(%ebp),%eax
 41c:	ff 75 0c             	pushl  0xc(%ebp)
 41f:	ff 30                	pushl  (%eax)
 421:	e8 5a ff ff ff       	call   380 <find_leaf>
 426:	8b 50 08             	mov    0x8(%eax),%edx
 429:	89 c7                	mov    %eax,%edi
    while(curNode->parent){
 42b:	83 c4 10             	add    $0x10,%esp
 42e:	89 c6                	mov    %eax,%esi
 430:	85 d2                	test   %edx,%edx
 432:	74 4f                	je     483 <trnmnt_tree_acquire+0x73>
        int mutex_lock = kthread_mutex_lock(mutexID);
 434:	83 ec 0c             	sub    $0xc,%esp
        int level = curNode->parent->level;
 437:	8b 5a 14             	mov    0x14(%edx),%ebx
        int mutex_lock = kthread_mutex_lock(mutexID);
 43a:	ff 72 0c             	pushl  0xc(%edx)
 43d:	e8 90 04 00 00       	call   8d2 <kthread_mutex_lock>
        leaf->lockPath[level] = curNode->parent;
 442:	8b 56 08             	mov    0x8(%esi),%edx
        int mutex_lock = kthread_mutex_lock(mutexID);
 445:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        leaf->lockPath[level] = curNode->parent;
 448:	8b 47 18             	mov    0x18(%edi),%eax
 44b:	89 14 98             	mov    %edx,(%eax,%ebx,4)
        printf(1, "level=%d, mutex_id=%d, index=%d\n", level, leaf->lockPath[level]->mutex_id, leaf->lockPath[level]->index);
 44e:	8b 47 18             	mov    0x18(%edi),%eax
 451:	5a                   	pop    %edx
 452:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 455:	ff 70 10             	pushl  0x10(%eax)
 458:	ff 70 0c             	pushl  0xc(%eax)
 45b:	53                   	push   %ebx
 45c:	68 48 0d 00 00       	push   $0xd48
 461:	6a 01                	push   $0x1
 463:	e8 28 05 00 00       	call   990 <printf>
        if(mutex_lock == -1){
 468:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 46b:	83 c4 20             	add    $0x20,%esp
 46e:	83 f9 ff             	cmp    $0xffffffff,%ecx
 471:	74 12                	je     485 <trnmnt_tree_acquire+0x75>
        if(mutex_lock == 0){
 473:	85 c9                	test   %ecx,%ecx
 475:	8b 56 08             	mov    0x8(%esi),%edx
 478:	75 b6                	jne    430 <trnmnt_tree_acquire+0x20>
 47a:	89 d6                	mov    %edx,%esi
 47c:	8b 52 08             	mov    0x8(%edx),%edx
    while(curNode->parent){
 47f:	85 d2                	test   %edx,%edx
 481:	75 b1                	jne    434 <trnmnt_tree_acquire+0x24>
    return 0;
 483:	31 c9                	xor    %ecx,%ecx
}
 485:	8d 65 f4             	lea    -0xc(%ebp),%esp
 488:	89 c8                	mov    %ecx,%eax
 48a:	5b                   	pop    %ebx
 48b:	5e                   	pop    %esi
 48c:	5f                   	pop    %edi
 48d:	5d                   	pop    %ebp
 48e:	c3                   	ret    
 48f:	90                   	nop

00000490 <trnmnt_tree_release>:
int trnmnt_tree_release(trnmnt_tree* tree,int ID){
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 24             	sub    $0x24,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 499:	8b 45 08             	mov    0x8(%ebp),%eax
 49c:	ff 75 0c             	pushl  0xc(%ebp)
 49f:	ff 30                	pushl  (%eax)
 4a1:	e8 da fe ff ff       	call   380 <find_leaf>
    for(int i = treeDepth-2; i >= 0; i--){
 4a6:	8b 35 f8 11 00 00    	mov    0x11f8,%esi
 4ac:	83 c4 10             	add    $0x10,%esp
 4af:	83 ee 02             	sub    $0x2,%esi
 4b2:	78 6c                	js     520 <trnmnt_tree_release+0x90>
 4b4:	89 c1                	mov    %eax,%ecx
 4b6:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
 4bd:	eb 19                	jmp    4d8 <trnmnt_tree_release+0x48>
 4bf:	90                   	nop
        leaf->lockPath[i] = 0;
 4c0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    for(int i = treeDepth-2; i >= 0; i--){
 4c3:	83 ee 01             	sub    $0x1,%esi
        leaf->lockPath[i] = 0;
 4c6:	8b 41 18             	mov    0x18(%ecx),%eax
 4c9:	c7 04 18 00 00 00 00 	movl   $0x0,(%eax,%ebx,1)
 4d0:	83 eb 04             	sub    $0x4,%ebx
    for(int i = treeDepth-2; i >= 0; i--){
 4d3:	83 fe ff             	cmp    $0xffffffff,%esi
 4d6:	74 48                	je     520 <trnmnt_tree_release+0x90>
        struct tree_node *curNode = leaf->lockPath[i];
 4d8:	8b 41 18             	mov    0x18(%ecx),%eax
        int res = kthread_mutex_unlock(curNode->mutex_id);
 4db:	83 ec 0c             	sub    $0xc,%esp
        struct tree_node *curNode = leaf->lockPath[i];
 4de:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 4e1:	8b 14 18             	mov    (%eax,%ebx,1),%edx
        int res = kthread_mutex_unlock(curNode->mutex_id);
 4e4:	ff 72 0c             	pushl  0xc(%edx)
 4e7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 4ea:	e8 eb 03 00 00       	call   8da <kthread_mutex_unlock>
        printf(1, "mutex_id=%d, res=%d\n", curNode->mutex_id, res);
 4ef:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 4f2:	50                   	push   %eax
        int res = kthread_mutex_unlock(curNode->mutex_id);
 4f3:	89 c7                	mov    %eax,%edi
        printf(1, "mutex_id=%d, res=%d\n", curNode->mutex_id, res);
 4f5:	ff 72 0c             	pushl  0xc(%edx)
 4f8:	68 33 0d 00 00       	push   $0xd33
 4fd:	6a 01                	push   $0x1
 4ff:	e8 8c 04 00 00       	call   990 <printf>
        if(res == -1){
 504:	83 c4 20             	add    $0x20,%esp
 507:	83 ff ff             	cmp    $0xffffffff,%edi
 50a:	75 b4                	jne    4c0 <trnmnt_tree_release+0x30>
}
 50c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50f:	89 f8                	mov    %edi,%eax
 511:	5b                   	pop    %ebx
 512:	5e                   	pop    %esi
 513:	5f                   	pop    %edi
 514:	5d                   	pop    %ebp
 515:	c3                   	ret    
 516:	8d 76 00             	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 520:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 523:	31 ff                	xor    %edi,%edi
}
 525:	89 f8                	mov    %edi,%eax
 527:	5b                   	pop    %ebx
 528:	5e                   	pop    %esi
 529:	5f                   	pop    %edi
 52a:	5d                   	pop    %ebp
 52b:	c3                   	ret    
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <tryAcquireMutex>:
void tryAcquireMutex(){
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	83 ec 08             	sub    $0x8,%esp
    if (i==0){
 536:	8b 15 f0 11 00 00    	mov    0x11f0,%edx
 53c:	a1 0c 12 00 00       	mov    0x120c,%eax
 541:	85 d2                	test   %edx,%edx
 543:	74 3b                	je     580 <tryAcquireMutex+0x50>
        trnmnt_tree_acquire(tree, 5);
 545:	83 ec 08             	sub    $0x8,%esp
 548:	6a 05                	push   $0x5
 54a:	50                   	push   %eax
 54b:	e8 c0 fe ff ff       	call   410 <trnmnt_tree_acquire>
        sleep(i*100);
 550:	6b 05 f0 11 00 00 64 	imul   $0x64,0x11f0,%eax
 557:	89 04 24             	mov    %eax,(%esp)
 55a:	e8 33 03 00 00       	call   892 <sleep>
        trnmnt_tree_release(tree, 5);
 55f:	58                   	pop    %eax
 560:	5a                   	pop    %edx
 561:	6a 05                	push   $0x5
 563:	ff 35 0c 12 00 00    	pushl  0x120c
 569:	e8 22 ff ff ff       	call   490 <trnmnt_tree_release>
        kthread_exit();
 56e:	83 c4 10             	add    $0x10,%esp
}
 571:	c9                   	leave  
        kthread_exit();
 572:	e9 3b 03 00 00       	jmp    8b2 <kthread_exit>
 577:	89 f6                	mov    %esi,%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        trnmnt_tree_acquire(tree, 4);
 580:	83 ec 08             	sub    $0x8,%esp
        i++;
 583:	c7 05 f0 11 00 00 01 	movl   $0x1,0x11f0
 58a:	00 00 00 
        trnmnt_tree_acquire(tree, 4);
 58d:	6a 04                	push   $0x4
 58f:	50                   	push   %eax
 590:	e8 7b fe ff ff       	call   410 <trnmnt_tree_acquire>
        sleep(i*100);
 595:	6b 05 f0 11 00 00 64 	imul   $0x64,0x11f0,%eax
 59c:	89 04 24             	mov    %eax,(%esp)
 59f:	e8 ee 02 00 00       	call   892 <sleep>
        trnmnt_tree_release(tree, 4);
 5a4:	59                   	pop    %ecx
 5a5:	58                   	pop    %eax
 5a6:	6a 04                	push   $0x4
 5a8:	eb b9                	jmp    563 <tryAcquireMutex+0x33>
 5aa:	66 90                	xchg   %ax,%ax
 5ac:	66 90                	xchg   %ax,%ax
 5ae:	66 90                	xchg   %ax,%ax

000005b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	53                   	push   %ebx
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5ba:	89 c2                	mov    %eax,%edx
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5c0:	83 c1 01             	add    $0x1,%ecx
 5c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 5c7:	83 c2 01             	add    $0x1,%edx
 5ca:	84 db                	test   %bl,%bl
 5cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 5cf:	75 ef                	jne    5c0 <strcpy+0x10>
    ;
  return os;
}
 5d1:	5b                   	pop    %ebx
 5d2:	5d                   	pop    %ebp
 5d3:	c3                   	ret    
 5d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	53                   	push   %ebx
 5e4:	8b 55 08             	mov    0x8(%ebp),%edx
 5e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5ea:	0f b6 02             	movzbl (%edx),%eax
 5ed:	0f b6 19             	movzbl (%ecx),%ebx
 5f0:	84 c0                	test   %al,%al
 5f2:	75 1c                	jne    610 <strcmp+0x30>
 5f4:	eb 2a                	jmp    620 <strcmp+0x40>
 5f6:	8d 76 00             	lea    0x0(%esi),%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 600:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 603:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 606:	83 c1 01             	add    $0x1,%ecx
 609:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 60c:	84 c0                	test   %al,%al
 60e:	74 10                	je     620 <strcmp+0x40>
 610:	38 d8                	cmp    %bl,%al
 612:	74 ec                	je     600 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 614:	29 d8                	sub    %ebx,%eax
}
 616:	5b                   	pop    %ebx
 617:	5d                   	pop    %ebp
 618:	c3                   	ret    
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 620:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 622:	29 d8                	sub    %ebx,%eax
}
 624:	5b                   	pop    %ebx
 625:	5d                   	pop    %ebp
 626:	c3                   	ret    
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <strlen>:

uint
strlen(const char *s)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 636:	80 39 00             	cmpb   $0x0,(%ecx)
 639:	74 15                	je     650 <strlen+0x20>
 63b:	31 d2                	xor    %edx,%edx
 63d:	8d 76 00             	lea    0x0(%esi),%esi
 640:	83 c2 01             	add    $0x1,%edx
 643:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 647:	89 d0                	mov    %edx,%eax
 649:	75 f5                	jne    640 <strlen+0x10>
    ;
  return n;
}
 64b:	5d                   	pop    %ebp
 64c:	c3                   	ret    
 64d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 650:	31 c0                	xor    %eax,%eax
}
 652:	5d                   	pop    %ebp
 653:	c3                   	ret    
 654:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 65a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000660 <memset>:

void*
memset(void *dst, int c, uint n)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 667:	8b 4d 10             	mov    0x10(%ebp),%ecx
 66a:	8b 45 0c             	mov    0xc(%ebp),%eax
 66d:	89 d7                	mov    %edx,%edi
 66f:	fc                   	cld    
 670:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 672:	89 d0                	mov    %edx,%eax
 674:	5f                   	pop    %edi
 675:	5d                   	pop    %ebp
 676:	c3                   	ret    
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <strchr>:

char*
strchr(const char *s, char c)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	53                   	push   %ebx
 684:	8b 45 08             	mov    0x8(%ebp),%eax
 687:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 68a:	0f b6 10             	movzbl (%eax),%edx
 68d:	84 d2                	test   %dl,%dl
 68f:	74 1d                	je     6ae <strchr+0x2e>
    if(*s == c)
 691:	38 d3                	cmp    %dl,%bl
 693:	89 d9                	mov    %ebx,%ecx
 695:	75 0d                	jne    6a4 <strchr+0x24>
 697:	eb 17                	jmp    6b0 <strchr+0x30>
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a0:	38 ca                	cmp    %cl,%dl
 6a2:	74 0c                	je     6b0 <strchr+0x30>
  for(; *s; s++)
 6a4:	83 c0 01             	add    $0x1,%eax
 6a7:	0f b6 10             	movzbl (%eax),%edx
 6aa:	84 d2                	test   %dl,%dl
 6ac:	75 f2                	jne    6a0 <strchr+0x20>
      return (char*)s;
  return 0;
 6ae:	31 c0                	xor    %eax,%eax
}
 6b0:	5b                   	pop    %ebx
 6b1:	5d                   	pop    %ebp
 6b2:	c3                   	ret    
 6b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <gets>:

char*
gets(char *buf, int max)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6c6:	31 f6                	xor    %esi,%esi
 6c8:	89 f3                	mov    %esi,%ebx
{
 6ca:	83 ec 1c             	sub    $0x1c,%esp
 6cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 6d0:	eb 2f                	jmp    701 <gets+0x41>
 6d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 6d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6db:	83 ec 04             	sub    $0x4,%esp
 6de:	6a 01                	push   $0x1
 6e0:	50                   	push   %eax
 6e1:	6a 00                	push   $0x0
 6e3:	e8 32 01 00 00       	call   81a <read>
    if(cc < 1)
 6e8:	83 c4 10             	add    $0x10,%esp
 6eb:	85 c0                	test   %eax,%eax
 6ed:	7e 1c                	jle    70b <gets+0x4b>
      break;
    buf[i++] = c;
 6ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 6f3:	83 c7 01             	add    $0x1,%edi
 6f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 6f9:	3c 0a                	cmp    $0xa,%al
 6fb:	74 23                	je     720 <gets+0x60>
 6fd:	3c 0d                	cmp    $0xd,%al
 6ff:	74 1f                	je     720 <gets+0x60>
  for(i=0; i+1 < max; ){
 701:	83 c3 01             	add    $0x1,%ebx
 704:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 707:	89 fe                	mov    %edi,%esi
 709:	7c cd                	jl     6d8 <gets+0x18>
 70b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 710:	c6 03 00             	movb   $0x0,(%ebx)
}
 713:	8d 65 f4             	lea    -0xc(%ebp),%esp
 716:	5b                   	pop    %ebx
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
 71b:	90                   	nop
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 720:	8b 75 08             	mov    0x8(%ebp),%esi
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	01 de                	add    %ebx,%esi
 728:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 72a:	c6 03 00             	movb   $0x0,(%ebx)
}
 72d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 730:	5b                   	pop    %ebx
 731:	5e                   	pop    %esi
 732:	5f                   	pop    %edi
 733:	5d                   	pop    %ebp
 734:	c3                   	ret    
 735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <stat>:

int
stat(const char *n, struct stat *st)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	56                   	push   %esi
 744:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 745:	83 ec 08             	sub    $0x8,%esp
 748:	6a 00                	push   $0x0
 74a:	ff 75 08             	pushl  0x8(%ebp)
 74d:	e8 f0 00 00 00       	call   842 <open>
  if(fd < 0)
 752:	83 c4 10             	add    $0x10,%esp
 755:	85 c0                	test   %eax,%eax
 757:	78 27                	js     780 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 759:	83 ec 08             	sub    $0x8,%esp
 75c:	ff 75 0c             	pushl  0xc(%ebp)
 75f:	89 c3                	mov    %eax,%ebx
 761:	50                   	push   %eax
 762:	e8 f3 00 00 00       	call   85a <fstat>
  close(fd);
 767:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 76a:	89 c6                	mov    %eax,%esi
  close(fd);
 76c:	e8 b9 00 00 00       	call   82a <close>
  return r;
 771:	83 c4 10             	add    $0x10,%esp
}
 774:	8d 65 f8             	lea    -0x8(%ebp),%esp
 777:	89 f0                	mov    %esi,%eax
 779:	5b                   	pop    %ebx
 77a:	5e                   	pop    %esi
 77b:	5d                   	pop    %ebp
 77c:	c3                   	ret    
 77d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 780:	be ff ff ff ff       	mov    $0xffffffff,%esi
 785:	eb ed                	jmp    774 <stat+0x34>
 787:	89 f6                	mov    %esi,%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <atoi>:

int
atoi(const char *s)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	53                   	push   %ebx
 794:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 797:	0f be 11             	movsbl (%ecx),%edx
 79a:	8d 42 d0             	lea    -0x30(%edx),%eax
 79d:	3c 09                	cmp    $0x9,%al
  n = 0;
 79f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 7a4:	77 1f                	ja     7c5 <atoi+0x35>
 7a6:	8d 76 00             	lea    0x0(%esi),%esi
 7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 7b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 7b3:	83 c1 01             	add    $0x1,%ecx
 7b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 7ba:	0f be 11             	movsbl (%ecx),%edx
 7bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 7c0:	80 fb 09             	cmp    $0x9,%bl
 7c3:	76 eb                	jbe    7b0 <atoi+0x20>
  return n;
}
 7c5:	5b                   	pop    %ebx
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret    
 7c8:	90                   	nop
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	56                   	push   %esi
 7d4:	53                   	push   %ebx
 7d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 7d8:	8b 45 08             	mov    0x8(%ebp),%eax
 7db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 7de:	85 db                	test   %ebx,%ebx
 7e0:	7e 14                	jle    7f6 <memmove+0x26>
 7e2:	31 d2                	xor    %edx,%edx
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 7e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 7ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 7ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 7f2:	39 d3                	cmp    %edx,%ebx
 7f4:	75 f2                	jne    7e8 <memmove+0x18>
  return vdst;
}
 7f6:	5b                   	pop    %ebx
 7f7:	5e                   	pop    %esi
 7f8:	5d                   	pop    %ebp
 7f9:	c3                   	ret    

000007fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7fa:	b8 01 00 00 00       	mov    $0x1,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <exit>:
SYSCALL(exit)
 802:	b8 02 00 00 00       	mov    $0x2,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <wait>:
SYSCALL(wait)
 80a:	b8 03 00 00 00       	mov    $0x3,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <pipe>:
SYSCALL(pipe)
 812:	b8 04 00 00 00       	mov    $0x4,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <read>:
SYSCALL(read)
 81a:	b8 05 00 00 00       	mov    $0x5,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <write>:
SYSCALL(write)
 822:	b8 10 00 00 00       	mov    $0x10,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <close>:
SYSCALL(close)
 82a:	b8 15 00 00 00       	mov    $0x15,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <kill>:
SYSCALL(kill)
 832:	b8 06 00 00 00       	mov    $0x6,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <exec>:
SYSCALL(exec)
 83a:	b8 07 00 00 00       	mov    $0x7,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <open>:
SYSCALL(open)
 842:	b8 0f 00 00 00       	mov    $0xf,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <mknod>:
SYSCALL(mknod)
 84a:	b8 11 00 00 00       	mov    $0x11,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <unlink>:
SYSCALL(unlink)
 852:	b8 12 00 00 00       	mov    $0x12,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <fstat>:
SYSCALL(fstat)
 85a:	b8 08 00 00 00       	mov    $0x8,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <link>:
SYSCALL(link)
 862:	b8 13 00 00 00       	mov    $0x13,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <mkdir>:
SYSCALL(mkdir)
 86a:	b8 14 00 00 00       	mov    $0x14,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <chdir>:
SYSCALL(chdir)
 872:	b8 09 00 00 00       	mov    $0x9,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    

0000087a <dup>:
SYSCALL(dup)
 87a:	b8 0a 00 00 00       	mov    $0xa,%eax
 87f:	cd 40                	int    $0x40
 881:	c3                   	ret    

00000882 <getpid>:
SYSCALL(getpid)
 882:	b8 0b 00 00 00       	mov    $0xb,%eax
 887:	cd 40                	int    $0x40
 889:	c3                   	ret    

0000088a <sbrk>:
SYSCALL(sbrk)
 88a:	b8 0c 00 00 00       	mov    $0xc,%eax
 88f:	cd 40                	int    $0x40
 891:	c3                   	ret    

00000892 <sleep>:
SYSCALL(sleep)
 892:	b8 0d 00 00 00       	mov    $0xd,%eax
 897:	cd 40                	int    $0x40
 899:	c3                   	ret    

0000089a <uptime>:
SYSCALL(uptime)
 89a:	b8 0e 00 00 00       	mov    $0xe,%eax
 89f:	cd 40                	int    $0x40
 8a1:	c3                   	ret    

000008a2 <kthread_create>:
SYSCALL(kthread_create)
 8a2:	b8 16 00 00 00       	mov    $0x16,%eax
 8a7:	cd 40                	int    $0x40
 8a9:	c3                   	ret    

000008aa <kthread_id>:
SYSCALL(kthread_id)
 8aa:	b8 17 00 00 00       	mov    $0x17,%eax
 8af:	cd 40                	int    $0x40
 8b1:	c3                   	ret    

000008b2 <kthread_exit>:
SYSCALL(kthread_exit)
 8b2:	b8 18 00 00 00       	mov    $0x18,%eax
 8b7:	cd 40                	int    $0x40
 8b9:	c3                   	ret    

000008ba <kthread_join>:
SYSCALL(kthread_join)
 8ba:	b8 19 00 00 00       	mov    $0x19,%eax
 8bf:	cd 40                	int    $0x40
 8c1:	c3                   	ret    

000008c2 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 8c2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 8c7:	cd 40                	int    $0x40
 8c9:	c3                   	ret    

000008ca <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 8ca:	b8 1b 00 00 00       	mov    $0x1b,%eax
 8cf:	cd 40                	int    $0x40
 8d1:	c3                   	ret    

000008d2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 8d2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 8d7:	cd 40                	int    $0x40
 8d9:	c3                   	ret    

000008da <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 8da:	b8 1d 00 00 00       	mov    $0x1d,%eax
 8df:	cd 40                	int    $0x40
 8e1:	c3                   	ret    
 8e2:	66 90                	xchg   %ax,%ax
 8e4:	66 90                	xchg   %ax,%ax
 8e6:	66 90                	xchg   %ax,%ax
 8e8:	66 90                	xchg   %ax,%ax
 8ea:	66 90                	xchg   %ax,%ax
 8ec:	66 90                	xchg   %ax,%ax
 8ee:	66 90                	xchg   %ax,%ax

000008f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8f9:	85 d2                	test   %edx,%edx
{
 8fb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 8fe:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 900:	79 76                	jns    978 <printint+0x88>
 902:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 906:	74 70                	je     978 <printint+0x88>
    x = -xx;
 908:	f7 d8                	neg    %eax
    neg = 1;
 90a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 911:	31 f6                	xor    %esi,%esi
 913:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 916:	eb 0a                	jmp    922 <printint+0x32>
 918:	90                   	nop
 919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 920:	89 fe                	mov    %edi,%esi
 922:	31 d2                	xor    %edx,%edx
 924:	8d 7e 01             	lea    0x1(%esi),%edi
 927:	f7 f1                	div    %ecx
 929:	0f b6 92 74 0d 00 00 	movzbl 0xd74(%edx),%edx
  }while((x /= base) != 0);
 930:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 932:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 935:	75 e9                	jne    920 <printint+0x30>
  if(neg)
 937:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 93a:	85 c0                	test   %eax,%eax
 93c:	74 08                	je     946 <printint+0x56>
    buf[i++] = '-';
 93e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 943:	8d 7e 02             	lea    0x2(%esi),%edi
 946:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 94a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 94d:	8d 76 00             	lea    0x0(%esi),%esi
 950:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 953:	83 ec 04             	sub    $0x4,%esp
 956:	83 ee 01             	sub    $0x1,%esi
 959:	6a 01                	push   $0x1
 95b:	53                   	push   %ebx
 95c:	57                   	push   %edi
 95d:	88 45 d7             	mov    %al,-0x29(%ebp)
 960:	e8 bd fe ff ff       	call   822 <write>

  while(--i >= 0)
 965:	83 c4 10             	add    $0x10,%esp
 968:	39 de                	cmp    %ebx,%esi
 96a:	75 e4                	jne    950 <printint+0x60>
    putc(fd, buf[i]);
}
 96c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 96f:	5b                   	pop    %ebx
 970:	5e                   	pop    %esi
 971:	5f                   	pop    %edi
 972:	5d                   	pop    %ebp
 973:	c3                   	ret    
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 978:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 97f:	eb 90                	jmp    911 <printint+0x21>
 981:	eb 0d                	jmp    990 <printf>
 983:	90                   	nop
 984:	90                   	nop
 985:	90                   	nop
 986:	90                   	nop
 987:	90                   	nop
 988:	90                   	nop
 989:	90                   	nop
 98a:	90                   	nop
 98b:	90                   	nop
 98c:	90                   	nop
 98d:	90                   	nop
 98e:	90                   	nop
 98f:	90                   	nop

00000990 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
 993:	57                   	push   %edi
 994:	56                   	push   %esi
 995:	53                   	push   %ebx
 996:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 999:	8b 75 0c             	mov    0xc(%ebp),%esi
 99c:	0f b6 1e             	movzbl (%esi),%ebx
 99f:	84 db                	test   %bl,%bl
 9a1:	0f 84 b3 00 00 00    	je     a5a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 9a7:	8d 45 10             	lea    0x10(%ebp),%eax
 9aa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 9ad:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 9af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9b2:	eb 2f                	jmp    9e3 <printf+0x53>
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 9b8:	83 f8 25             	cmp    $0x25,%eax
 9bb:	0f 84 a7 00 00 00    	je     a68 <printf+0xd8>
  write(fd, &c, 1);
 9c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 9c4:	83 ec 04             	sub    $0x4,%esp
 9c7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 9ca:	6a 01                	push   $0x1
 9cc:	50                   	push   %eax
 9cd:	ff 75 08             	pushl  0x8(%ebp)
 9d0:	e8 4d fe ff ff       	call   822 <write>
 9d5:	83 c4 10             	add    $0x10,%esp
 9d8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 9db:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 9df:	84 db                	test   %bl,%bl
 9e1:	74 77                	je     a5a <printf+0xca>
    if(state == 0){
 9e3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 9e5:	0f be cb             	movsbl %bl,%ecx
 9e8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 9eb:	74 cb                	je     9b8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9ed:	83 ff 25             	cmp    $0x25,%edi
 9f0:	75 e6                	jne    9d8 <printf+0x48>
      if(c == 'd'){
 9f2:	83 f8 64             	cmp    $0x64,%eax
 9f5:	0f 84 05 01 00 00    	je     b00 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 9fb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 a01:	83 f9 70             	cmp    $0x70,%ecx
 a04:	74 72                	je     a78 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 a06:	83 f8 73             	cmp    $0x73,%eax
 a09:	0f 84 99 00 00 00    	je     aa8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a0f:	83 f8 63             	cmp    $0x63,%eax
 a12:	0f 84 08 01 00 00    	je     b20 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 a18:	83 f8 25             	cmp    $0x25,%eax
 a1b:	0f 84 ef 00 00 00    	je     b10 <printf+0x180>
  write(fd, &c, 1);
 a21:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a24:	83 ec 04             	sub    $0x4,%esp
 a27:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a2b:	6a 01                	push   $0x1
 a2d:	50                   	push   %eax
 a2e:	ff 75 08             	pushl  0x8(%ebp)
 a31:	e8 ec fd ff ff       	call   822 <write>
 a36:	83 c4 0c             	add    $0xc,%esp
 a39:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 a3c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 a3f:	6a 01                	push   $0x1
 a41:	50                   	push   %eax
 a42:	ff 75 08             	pushl  0x8(%ebp)
 a45:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a48:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 a4a:	e8 d3 fd ff ff       	call   822 <write>
  for(i = 0; fmt[i]; i++){
 a4f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 a53:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 a56:	84 db                	test   %bl,%bl
 a58:	75 89                	jne    9e3 <printf+0x53>
    }
  }
}
 a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a5d:	5b                   	pop    %ebx
 a5e:	5e                   	pop    %esi
 a5f:	5f                   	pop    %edi
 a60:	5d                   	pop    %ebp
 a61:	c3                   	ret    
 a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 a68:	bf 25 00 00 00       	mov    $0x25,%edi
 a6d:	e9 66 ff ff ff       	jmp    9d8 <printf+0x48>
 a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a78:	83 ec 0c             	sub    $0xc,%esp
 a7b:	b9 10 00 00 00       	mov    $0x10,%ecx
 a80:	6a 00                	push   $0x0
 a82:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 a85:	8b 45 08             	mov    0x8(%ebp),%eax
 a88:	8b 17                	mov    (%edi),%edx
 a8a:	e8 61 fe ff ff       	call   8f0 <printint>
        ap++;
 a8f:	89 f8                	mov    %edi,%eax
 a91:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a94:	31 ff                	xor    %edi,%edi
        ap++;
 a96:	83 c0 04             	add    $0x4,%eax
 a99:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 a9c:	e9 37 ff ff ff       	jmp    9d8 <printf+0x48>
 aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 aa8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 aab:	8b 08                	mov    (%eax),%ecx
        ap++;
 aad:	83 c0 04             	add    $0x4,%eax
 ab0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 ab3:	85 c9                	test   %ecx,%ecx
 ab5:	0f 84 8e 00 00 00    	je     b49 <printf+0x1b9>
        while(*s != 0){
 abb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 abe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 ac0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 ac2:	84 c0                	test   %al,%al
 ac4:	0f 84 0e ff ff ff    	je     9d8 <printf+0x48>
 aca:	89 75 d0             	mov    %esi,-0x30(%ebp)
 acd:	89 de                	mov    %ebx,%esi
 acf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 ad2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 ad5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 ad8:	83 ec 04             	sub    $0x4,%esp
          s++;
 adb:	83 c6 01             	add    $0x1,%esi
 ade:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 ae1:	6a 01                	push   $0x1
 ae3:	57                   	push   %edi
 ae4:	53                   	push   %ebx
 ae5:	e8 38 fd ff ff       	call   822 <write>
        while(*s != 0){
 aea:	0f b6 06             	movzbl (%esi),%eax
 aed:	83 c4 10             	add    $0x10,%esp
 af0:	84 c0                	test   %al,%al
 af2:	75 e4                	jne    ad8 <printf+0x148>
 af4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 af7:	31 ff                	xor    %edi,%edi
 af9:	e9 da fe ff ff       	jmp    9d8 <printf+0x48>
 afe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 b00:	83 ec 0c             	sub    $0xc,%esp
 b03:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b08:	6a 01                	push   $0x1
 b0a:	e9 73 ff ff ff       	jmp    a82 <printf+0xf2>
 b0f:	90                   	nop
  write(fd, &c, 1);
 b10:	83 ec 04             	sub    $0x4,%esp
 b13:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 b16:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 b19:	6a 01                	push   $0x1
 b1b:	e9 21 ff ff ff       	jmp    a41 <printf+0xb1>
        putc(fd, *ap);
 b20:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 b23:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 b26:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 b28:	6a 01                	push   $0x1
        ap++;
 b2a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 b2d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 b30:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 b33:	50                   	push   %eax
 b34:	ff 75 08             	pushl  0x8(%ebp)
 b37:	e8 e6 fc ff ff       	call   822 <write>
        ap++;
 b3c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 b3f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b42:	31 ff                	xor    %edi,%edi
 b44:	e9 8f fe ff ff       	jmp    9d8 <printf+0x48>
          s = "(null)";
 b49:	bb 6c 0d 00 00       	mov    $0xd6c,%ebx
        while(*s != 0){
 b4e:	b8 28 00 00 00       	mov    $0x28,%eax
 b53:	e9 72 ff ff ff       	jmp    aca <printf+0x13a>
 b58:	66 90                	xchg   %ax,%ax
 b5a:	66 90                	xchg   %ax,%ax
 b5c:	66 90                	xchg   %ax,%ax
 b5e:	66 90                	xchg   %ax,%ax

00000b60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b61:	a1 fc 11 00 00       	mov    0x11fc,%eax
{
 b66:	89 e5                	mov    %esp,%ebp
 b68:	57                   	push   %edi
 b69:	56                   	push   %esi
 b6a:	53                   	push   %ebx
 b6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 b6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b78:	39 c8                	cmp    %ecx,%eax
 b7a:	8b 10                	mov    (%eax),%edx
 b7c:	73 32                	jae    bb0 <free+0x50>
 b7e:	39 d1                	cmp    %edx,%ecx
 b80:	72 04                	jb     b86 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b82:	39 d0                	cmp    %edx,%eax
 b84:	72 32                	jb     bb8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b86:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b89:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b8c:	39 fa                	cmp    %edi,%edx
 b8e:	74 30                	je     bc0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b90:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b93:	8b 50 04             	mov    0x4(%eax),%edx
 b96:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b99:	39 f1                	cmp    %esi,%ecx
 b9b:	74 3a                	je     bd7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b9d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b9f:	a3 fc 11 00 00       	mov    %eax,0x11fc
}
 ba4:	5b                   	pop    %ebx
 ba5:	5e                   	pop    %esi
 ba6:	5f                   	pop    %edi
 ba7:	5d                   	pop    %ebp
 ba8:	c3                   	ret    
 ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb0:	39 d0                	cmp    %edx,%eax
 bb2:	72 04                	jb     bb8 <free+0x58>
 bb4:	39 d1                	cmp    %edx,%ecx
 bb6:	72 ce                	jb     b86 <free+0x26>
{
 bb8:	89 d0                	mov    %edx,%eax
 bba:	eb bc                	jmp    b78 <free+0x18>
 bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 bc0:	03 72 04             	add    0x4(%edx),%esi
 bc3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 bc6:	8b 10                	mov    (%eax),%edx
 bc8:	8b 12                	mov    (%edx),%edx
 bca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 bcd:	8b 50 04             	mov    0x4(%eax),%edx
 bd0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 bd3:	39 f1                	cmp    %esi,%ecx
 bd5:	75 c6                	jne    b9d <free+0x3d>
    p->s.size += bp->s.size;
 bd7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 bda:	a3 fc 11 00 00       	mov    %eax,0x11fc
    p->s.size += bp->s.size;
 bdf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 be2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 be5:	89 10                	mov    %edx,(%eax)
}
 be7:	5b                   	pop    %ebx
 be8:	5e                   	pop    %esi
 be9:	5f                   	pop    %edi
 bea:	5d                   	pop    %ebp
 beb:	c3                   	ret    
 bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000bf0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bf0:	55                   	push   %ebp
 bf1:	89 e5                	mov    %esp,%ebp
 bf3:	57                   	push   %edi
 bf4:	56                   	push   %esi
 bf5:	53                   	push   %ebx
 bf6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bfc:	8b 15 fc 11 00 00    	mov    0x11fc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c02:	8d 78 07             	lea    0x7(%eax),%edi
 c05:	c1 ef 03             	shr    $0x3,%edi
 c08:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 c0b:	85 d2                	test   %edx,%edx
 c0d:	0f 84 9d 00 00 00    	je     cb0 <malloc+0xc0>
 c13:	8b 02                	mov    (%edx),%eax
 c15:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 c18:	39 cf                	cmp    %ecx,%edi
 c1a:	76 6c                	jbe    c88 <malloc+0x98>
 c1c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 c22:	bb 00 10 00 00       	mov    $0x1000,%ebx
 c27:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 c2a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 c31:	eb 0e                	jmp    c41 <malloc+0x51>
 c33:	90                   	nop
 c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c38:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c3a:	8b 48 04             	mov    0x4(%eax),%ecx
 c3d:	39 f9                	cmp    %edi,%ecx
 c3f:	73 47                	jae    c88 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c41:	39 05 fc 11 00 00    	cmp    %eax,0x11fc
 c47:	89 c2                	mov    %eax,%edx
 c49:	75 ed                	jne    c38 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 c4b:	83 ec 0c             	sub    $0xc,%esp
 c4e:	56                   	push   %esi
 c4f:	e8 36 fc ff ff       	call   88a <sbrk>
  if(p == (char*)-1)
 c54:	83 c4 10             	add    $0x10,%esp
 c57:	83 f8 ff             	cmp    $0xffffffff,%eax
 c5a:	74 1c                	je     c78 <malloc+0x88>
  hp->s.size = nu;
 c5c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 c5f:	83 ec 0c             	sub    $0xc,%esp
 c62:	83 c0 08             	add    $0x8,%eax
 c65:	50                   	push   %eax
 c66:	e8 f5 fe ff ff       	call   b60 <free>
  return freep;
 c6b:	8b 15 fc 11 00 00    	mov    0x11fc,%edx
      if((p = morecore(nunits)) == 0)
 c71:	83 c4 10             	add    $0x10,%esp
 c74:	85 d2                	test   %edx,%edx
 c76:	75 c0                	jne    c38 <malloc+0x48>
        return 0;
  }
}
 c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 c7b:	31 c0                	xor    %eax,%eax
}
 c7d:	5b                   	pop    %ebx
 c7e:	5e                   	pop    %esi
 c7f:	5f                   	pop    %edi
 c80:	5d                   	pop    %ebp
 c81:	c3                   	ret    
 c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c88:	39 cf                	cmp    %ecx,%edi
 c8a:	74 54                	je     ce0 <malloc+0xf0>
        p->s.size -= nunits;
 c8c:	29 f9                	sub    %edi,%ecx
 c8e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c91:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c94:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c97:	89 15 fc 11 00 00    	mov    %edx,0x11fc
}
 c9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ca0:	83 c0 08             	add    $0x8,%eax
}
 ca3:	5b                   	pop    %ebx
 ca4:	5e                   	pop    %esi
 ca5:	5f                   	pop    %edi
 ca6:	5d                   	pop    %ebp
 ca7:	c3                   	ret    
 ca8:	90                   	nop
 ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 cb0:	c7 05 fc 11 00 00 00 	movl   $0x1200,0x11fc
 cb7:	12 00 00 
 cba:	c7 05 00 12 00 00 00 	movl   $0x1200,0x1200
 cc1:	12 00 00 
    base.s.size = 0;
 cc4:	b8 00 12 00 00       	mov    $0x1200,%eax
 cc9:	c7 05 04 12 00 00 00 	movl   $0x0,0x1204
 cd0:	00 00 00 
 cd3:	e9 44 ff ff ff       	jmp    c1c <malloc+0x2c>
 cd8:	90                   	nop
 cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 ce0:	8b 08                	mov    (%eax),%ecx
 ce2:	89 0a                	mov    %ecx,(%edx)
 ce4:	eb b1                	jmp    c97 <malloc+0xa7>
