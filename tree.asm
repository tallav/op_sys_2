
_tree:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return 0;
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
    struct trnmnt_tree *tree = trnmnt_tree_alloc(3);
   f:	83 ec 0c             	sub    $0xc,%esp
  12:	6a 03                	push   $0x3
  14:	e8 b7 00 00 00       	call   d0 <trnmnt_tree_alloc>
    if(!t) return;
  19:	83 c4 10             	add    $0x10,%esp
  1c:	85 c0                	test   %eax,%eax
  1e:	74 28                	je     48 <main+0x48>
  20:	89 c3                	mov    %eax,%ebx
	print_node(t->root,0);
  22:	50                   	push   %eax
  23:	50                   	push   %eax
  24:	6a 00                	push   $0x0
  26:	ff 33                	pushl  (%ebx)
  28:	e8 e3 00 00 00       	call   110 <print_node>
    print_tree(tree);
    trnmnt_tree_dealloc(tree);
  2d:	89 1c 24             	mov    %ebx,(%esp)
  30:	e8 fb 01 00 00       	call   230 <trnmnt_tree_dealloc>
	print_node(t->root,0);
  35:	5a                   	pop    %edx
  36:	59                   	pop    %ecx
  37:	6a 00                	push   $0x0
  39:	ff 33                	pushl  (%ebx)
  3b:	e8 d0 00 00 00       	call   110 <print_node>
  40:	83 c4 10             	add    $0x10,%esp
    //tree = 0;
    print_tree(tree);
    exit();
  43:	e8 aa 04 00 00       	call   4f2 <exit>
    trnmnt_tree_dealloc(tree);
  48:	83 ec 0c             	sub    $0xc,%esp
  4b:	6a 00                	push   $0x0
  4d:	e8 de 01 00 00       	call   230 <trnmnt_tree_dealloc>
  52:	83 c4 10             	add    $0x10,%esp
  55:	eb ec                	jmp    43 <main+0x43>
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <create_tree>:
void create_tree(struct tree_node* node, int depth){
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	57                   	push   %edi
  64:	56                   	push   %esi
  65:	53                   	push   %ebx
  66:	83 ec 0c             	sub    $0xc,%esp
    if(depth == 0){
  69:	8b 75 0c             	mov    0xc(%ebp),%esi
void create_tree(struct tree_node* node, int depth){
  6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
  6f:	85 f6                	test   %esi,%esi
  71:	74 48                	je     bb <create_tree+0x5b>
    struct tree_node *left = malloc(sizeof(struct tree_node));
  73:	83 ec 0c             	sub    $0xc,%esp
  76:	6a 10                	push   $0x10
  78:	e8 63 08 00 00       	call   8e0 <malloc>
  7d:	89 c6                	mov    %eax,%esi
    struct tree_node *right = malloc(sizeof(struct tree_node));
  7f:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
  86:	e8 55 08 00 00       	call   8e0 <malloc>
    left->parent = node;
  8b:	89 5e 08             	mov    %ebx,0x8(%esi)
    right->parent = node;
  8e:	89 58 08             	mov    %ebx,0x8(%eax)
    struct tree_node *right = malloc(sizeof(struct tree_node));
  91:	89 c7                	mov    %eax,%edi
    node->left_child = left;
  93:	89 33                	mov    %esi,(%ebx)
    node->right_child = right;
  95:	89 43 04             	mov    %eax,0x4(%ebx)
    node->mutex_id = kthread_mutex_alloc();
  98:	e8 15 05 00 00       	call   5b2 <kthread_mutex_alloc>
  9d:	89 43 0c             	mov    %eax,0xc(%ebx)
    create_tree(left, depth-1);
  a0:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
  a4:	89 fb                	mov    %edi,%ebx
  a6:	58                   	pop    %eax
  a7:	5a                   	pop    %edx
  a8:	ff 75 0c             	pushl  0xc(%ebp)
  ab:	56                   	push   %esi
  ac:	e8 af ff ff ff       	call   60 <create_tree>
    if(depth == 0){
  b1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  b4:	83 c4 10             	add    $0x10,%esp
  b7:	85 c9                	test   %ecx,%ecx
  b9:	75 b8                	jne    73 <create_tree+0x13>
}
  bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  be:	5b                   	pop    %ebx
  bf:	5e                   	pop    %esi
  c0:	5f                   	pop    %edi
  c1:	5d                   	pop    %ebp
  c2:	c3                   	ret    
  c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000d0 <trnmnt_tree_alloc>:
struct trnmnt_tree* trnmnt_tree_alloc(int depth){
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	56                   	push   %esi
  d4:	53                   	push   %ebx
  d5:	8b 75 08             	mov    0x8(%ebp),%esi
    struct trnmnt_tree *tree = malloc(sizeof(struct trnmnt_tree));
  d8:	83 ec 0c             	sub    $0xc,%esp
  db:	6a 08                	push   $0x8
  dd:	e8 fe 07 00 00       	call   8e0 <malloc>
  e2:	89 c3                	mov    %eax,%ebx
    struct tree_node *root = malloc(sizeof(struct tree_node));
  e4:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
  eb:	e8 f0 07 00 00       	call   8e0 <malloc>
    tree->depth = depth;
  f0:	89 73 04             	mov    %esi,0x4(%ebx)
    tree->root = root;
  f3:	89 03                	mov    %eax,(%ebx)
    root->parent = 0;
  f5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    create_tree(tree->root, depth);
  fc:	58                   	pop    %eax
  fd:	5a                   	pop    %edx
  fe:	56                   	push   %esi
  ff:	ff 33                	pushl  (%ebx)
 101:	e8 5a ff ff ff       	call   60 <create_tree>
}
 106:	8d 65 f8             	lea    -0x8(%ebp),%esp
 109:	89 d8                	mov    %ebx,%eax
 10b:	5b                   	pop    %ebx
 10c:	5e                   	pop    %esi
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
 10f:	90                   	nop

00000110 <print_node>:
void print_node(struct tree_node *n,int l){
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 1c             	sub    $0x1c,%esp
 119:	8b 75 08             	mov    0x8(%ebp),%esi
 11c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
 11f:	85 f6                	test   %esi,%esi
 121:	74 54                	je     177 <print_node+0x67>
	print_node(n->right_child,l+1);
 123:	8d 43 01             	lea    0x1(%ebx),%eax
 126:	83 ec 08             	sub    $0x8,%esp
 129:	50                   	push   %eax
 12a:	ff 76 04             	pushl  0x4(%esi)
 12d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 130:	e8 db ff ff ff       	call   110 <print_node>
	for(i=0;i<l;++i){
 135:	83 c4 10             	add    $0x10,%esp
 138:	85 db                	test   %ebx,%ebx
 13a:	7e 1d                	jle    159 <print_node+0x49>
 13c:	31 ff                	xor    %edi,%edi
 13e:	66 90                	xchg   %ax,%ax
		printf(1,"  ");
 140:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
 143:	83 c7 01             	add    $0x1,%edi
		printf(1,"  ");
 146:	68 d8 09 00 00       	push   $0x9d8
 14b:	6a 01                	push   $0x1
 14d:	e8 2e 05 00 00       	call   680 <printf>
	for(i=0;i<l;++i){
 152:	83 c4 10             	add    $0x10,%esp
 155:	39 df                	cmp    %ebx,%edi
 157:	75 e7                	jne    140 <print_node+0x30>
	printf(1,"%d \n",n->mutex_id);
 159:	83 ec 04             	sub    $0x4,%esp
 15c:	ff 76 0c             	pushl  0xc(%esi)
 15f:	68 db 09 00 00       	push   $0x9db
 164:	6a 01                	push   $0x1
 166:	e8 15 05 00 00       	call   680 <printf>
	print_node(n->left_child,l+1);
 16b:	8b 36                	mov    (%esi),%esi
	if(!n) return;
 16d:	83 c4 10             	add    $0x10,%esp
	print_node(n->left_child,l+1);
 170:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
 173:	85 f6                	test   %esi,%esi
 175:	75 ac                	jne    123 <print_node+0x13>
}
 177:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17a:	5b                   	pop    %ebx
 17b:	5e                   	pop    %esi
 17c:	5f                   	pop    %edi
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
 17f:	90                   	nop

00000180 <print_tree>:
void print_tree(struct trnmnt_tree *t){
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 08             	sub    $0x8,%esp
 186:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
 189:	85 c0                	test   %eax,%eax
 18b:	74 0f                	je     19c <print_tree+0x1c>
	print_node(t->root,0);
 18d:	83 ec 08             	sub    $0x8,%esp
 190:	6a 00                	push   $0x0
 192:	ff 30                	pushl  (%eax)
 194:	e8 77 ff ff ff       	call   110 <print_node>
 199:	83 c4 10             	add    $0x10,%esp
}
 19c:	c9                   	leave  
 19d:	c3                   	ret    
 19e:	66 90                	xchg   %ax,%ax

000001a0 <delete_node>:
int delete_node(struct tree_node *node){
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    return 0;
 1a8:	31 f6                	xor    %esi,%esi
    if (node != 0){ 
 1aa:	85 db                	test   %ebx,%ebx
 1ac:	74 4f                	je     1fd <delete_node+0x5d>
        if(kthread_mutex_dealloc(node->mutex_id) < 0){
 1ae:	83 ec 0c             	sub    $0xc,%esp
 1b1:	ff 73 0c             	pushl  0xc(%ebx)
 1b4:	e8 01 04 00 00       	call   5ba <kthread_mutex_dealloc>
 1b9:	83 c4 10             	add    $0x10,%esp
 1bc:	85 c0                	test   %eax,%eax
 1be:	78 50                	js     210 <delete_node+0x70>
        delete_node(node->left_child); 
 1c0:	83 ec 0c             	sub    $0xc,%esp
 1c3:	ff 33                	pushl  (%ebx)
 1c5:	e8 d6 ff ff ff       	call   1a0 <delete_node>
        delete_node(node->right_child); 
 1ca:	58                   	pop    %eax
 1cb:	ff 73 04             	pushl  0x4(%ebx)
 1ce:	e8 cd ff ff ff       	call   1a0 <delete_node>
        printf(1, "Deleting node: %d\n", node->mutex_id); 
 1d3:	83 c4 0c             	add    $0xc,%esp
        node->left_child = 0;
 1d6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
 1dc:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        printf(1, "Deleting node: %d\n", node->mutex_id); 
 1e3:	ff 73 0c             	pushl  0xc(%ebx)
 1e6:	68 f6 09 00 00       	push   $0x9f6
 1eb:	6a 01                	push   $0x1
 1ed:	e8 8e 04 00 00       	call   680 <printf>
        free(node); 
 1f2:	89 1c 24             	mov    %ebx,(%esp)
 1f5:	e8 56 06 00 00       	call   850 <free>
 1fa:	83 c4 10             	add    $0x10,%esp
}
 1fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
 200:	89 f0                	mov    %esi,%eax
 202:	5b                   	pop    %ebx
 203:	5e                   	pop    %esi
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    
 206:	8d 76 00             	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            printf(1, "mutex dealloc failed\n");
 210:	83 ec 08             	sub    $0x8,%esp
 213:	be ff ff ff ff       	mov    $0xffffffff,%esi
 218:	68 e0 09 00 00       	push   $0x9e0
 21d:	6a 01                	push   $0x1
 21f:	e8 5c 04 00 00       	call   680 <printf>
 224:	83 c4 10             	add    $0x10,%esp
 227:	eb d4                	jmp    1fd <delete_node+0x5d>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <trnmnt_tree_dealloc>:
int trnmnt_tree_dealloc(struct trnmnt_tree* tree){
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
 235:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
 238:	83 ec 0c             	sub    $0xc,%esp
 23b:	ff 33                	pushl  (%ebx)
 23d:	e8 5e ff ff ff       	call   1a0 <delete_node>
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	75 27                	jne    270 <trnmnt_tree_dealloc+0x40>
        free(tree);
 249:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
 24c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
 252:	89 c6                	mov    %eax,%esi
        free(tree);
 254:	53                   	push   %ebx
 255:	e8 f6 05 00 00       	call   850 <free>
        return 0;
 25a:	83 c4 10             	add    $0x10,%esp
}
 25d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 260:	89 f0                	mov    %esi,%eax
 262:	5b                   	pop    %ebx
 263:	5e                   	pop    %esi
 264:	5d                   	pop    %ebp
 265:	c3                   	ret    
 266:	8d 76 00             	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
 270:	be ff ff ff ff       	mov    $0xffffffff,%esi
 275:	eb e6                	jmp    25d <trnmnt_tree_dealloc+0x2d>
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID){
 280:	55                   	push   %ebp
}
 281:	31 c0                	xor    %eax,%eax
int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID){
 283:	89 e5                	mov    %esp,%ebp
}
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <trnmnt_tree_release>:
 290:	55                   	push   %ebp
 291:	31 c0                	xor    %eax,%eax
 293:	89 e5                	mov    %esp,%ebp
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	66 90                	xchg   %ax,%ax
 299:	66 90                	xchg   %ax,%ax
 29b:	66 90                	xchg   %ax,%ax
 29d:	66 90                	xchg   %ax,%ax
 29f:	90                   	nop

000002a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2aa:	89 c2                	mov    %eax,%edx
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	83 c1 01             	add    $0x1,%ecx
 2b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2b7:	83 c2 01             	add    $0x1,%edx
 2ba:	84 db                	test   %bl,%bl
 2bc:	88 5a ff             	mov    %bl,-0x1(%edx)
 2bf:	75 ef                	jne    2b0 <strcpy+0x10>
    ;
  return os;
}
 2c1:	5b                   	pop    %ebx
 2c2:	5d                   	pop    %ebp
 2c3:	c3                   	ret    
 2c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
 2d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2da:	0f b6 02             	movzbl (%edx),%eax
 2dd:	0f b6 19             	movzbl (%ecx),%ebx
 2e0:	84 c0                	test   %al,%al
 2e2:	75 1c                	jne    300 <strcmp+0x30>
 2e4:	eb 2a                	jmp    310 <strcmp+0x40>
 2e6:	8d 76 00             	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2f0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2f6:	83 c1 01             	add    $0x1,%ecx
 2f9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 2fc:	84 c0                	test   %al,%al
 2fe:	74 10                	je     310 <strcmp+0x40>
 300:	38 d8                	cmp    %bl,%al
 302:	74 ec                	je     2f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 304:	29 d8                	sub    %ebx,%eax
}
 306:	5b                   	pop    %ebx
 307:	5d                   	pop    %ebp
 308:	c3                   	ret    
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 310:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 312:	29 d8                	sub    %ebx,%eax
}
 314:	5b                   	pop    %ebx
 315:	5d                   	pop    %ebp
 316:	c3                   	ret    
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <strlen>:

uint
strlen(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 326:	80 39 00             	cmpb   $0x0,(%ecx)
 329:	74 15                	je     340 <strlen+0x20>
 32b:	31 d2                	xor    %edx,%edx
 32d:	8d 76 00             	lea    0x0(%esi),%esi
 330:	83 c2 01             	add    $0x1,%edx
 333:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 337:	89 d0                	mov    %edx,%eax
 339:	75 f5                	jne    330 <strlen+0x10>
    ;
  return n;
}
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret    
 33d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 340:	31 c0                	xor    %eax,%eax
}
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <memset>:

void*
memset(void *dst, int c, uint n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 357:	8b 4d 10             	mov    0x10(%ebp),%ecx
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 d7                	mov    %edx,%edi
 35f:	fc                   	cld    
 360:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 362:	89 d0                	mov    %edx,%eax
 364:	5f                   	pop    %edi
 365:	5d                   	pop    %ebp
 366:	c3                   	ret    
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <strchr>:

char*
strchr(const char *s, char c)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 45 08             	mov    0x8(%ebp),%eax
 377:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 37a:	0f b6 10             	movzbl (%eax),%edx
 37d:	84 d2                	test   %dl,%dl
 37f:	74 1d                	je     39e <strchr+0x2e>
    if(*s == c)
 381:	38 d3                	cmp    %dl,%bl
 383:	89 d9                	mov    %ebx,%ecx
 385:	75 0d                	jne    394 <strchr+0x24>
 387:	eb 17                	jmp    3a0 <strchr+0x30>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 390:	38 ca                	cmp    %cl,%dl
 392:	74 0c                	je     3a0 <strchr+0x30>
  for(; *s; s++)
 394:	83 c0 01             	add    $0x1,%eax
 397:	0f b6 10             	movzbl (%eax),%edx
 39a:	84 d2                	test   %dl,%dl
 39c:	75 f2                	jne    390 <strchr+0x20>
      return (char*)s;
  return 0;
 39e:	31 c0                	xor    %eax,%eax
}
 3a0:	5b                   	pop    %ebx
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <gets>:

char*
gets(char *buf, int max)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b6:	31 f6                	xor    %esi,%esi
 3b8:	89 f3                	mov    %esi,%ebx
{
 3ba:	83 ec 1c             	sub    $0x1c,%esp
 3bd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 3c0:	eb 2f                	jmp    3f1 <gets+0x41>
 3c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 3c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3cb:	83 ec 04             	sub    $0x4,%esp
 3ce:	6a 01                	push   $0x1
 3d0:	50                   	push   %eax
 3d1:	6a 00                	push   $0x0
 3d3:	e8 32 01 00 00       	call   50a <read>
    if(cc < 1)
 3d8:	83 c4 10             	add    $0x10,%esp
 3db:	85 c0                	test   %eax,%eax
 3dd:	7e 1c                	jle    3fb <gets+0x4b>
      break;
    buf[i++] = c;
 3df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3e3:	83 c7 01             	add    $0x1,%edi
 3e6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 3e9:	3c 0a                	cmp    $0xa,%al
 3eb:	74 23                	je     410 <gets+0x60>
 3ed:	3c 0d                	cmp    $0xd,%al
 3ef:	74 1f                	je     410 <gets+0x60>
  for(i=0; i+1 < max; ){
 3f1:	83 c3 01             	add    $0x1,%ebx
 3f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3f7:	89 fe                	mov    %edi,%esi
 3f9:	7c cd                	jl     3c8 <gets+0x18>
 3fb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 3fd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 400:	c6 03 00             	movb   $0x0,(%ebx)
}
 403:	8d 65 f4             	lea    -0xc(%ebp),%esp
 406:	5b                   	pop    %ebx
 407:	5e                   	pop    %esi
 408:	5f                   	pop    %edi
 409:	5d                   	pop    %ebp
 40a:	c3                   	ret    
 40b:	90                   	nop
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 410:	8b 75 08             	mov    0x8(%ebp),%esi
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	01 de                	add    %ebx,%esi
 418:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 41a:	c6 03 00             	movb   $0x0,(%ebx)
}
 41d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 420:	5b                   	pop    %ebx
 421:	5e                   	pop    %esi
 422:	5f                   	pop    %edi
 423:	5d                   	pop    %ebp
 424:	c3                   	ret    
 425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <stat>:

int
stat(const char *n, struct stat *st)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	56                   	push   %esi
 434:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 435:	83 ec 08             	sub    $0x8,%esp
 438:	6a 00                	push   $0x0
 43a:	ff 75 08             	pushl  0x8(%ebp)
 43d:	e8 f0 00 00 00       	call   532 <open>
  if(fd < 0)
 442:	83 c4 10             	add    $0x10,%esp
 445:	85 c0                	test   %eax,%eax
 447:	78 27                	js     470 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 449:	83 ec 08             	sub    $0x8,%esp
 44c:	ff 75 0c             	pushl  0xc(%ebp)
 44f:	89 c3                	mov    %eax,%ebx
 451:	50                   	push   %eax
 452:	e8 f3 00 00 00       	call   54a <fstat>
  close(fd);
 457:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 45a:	89 c6                	mov    %eax,%esi
  close(fd);
 45c:	e8 b9 00 00 00       	call   51a <close>
  return r;
 461:	83 c4 10             	add    $0x10,%esp
}
 464:	8d 65 f8             	lea    -0x8(%ebp),%esp
 467:	89 f0                	mov    %esi,%eax
 469:	5b                   	pop    %ebx
 46a:	5e                   	pop    %esi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 470:	be ff ff ff ff       	mov    $0xffffffff,%esi
 475:	eb ed                	jmp    464 <stat+0x34>
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <atoi>:

int
atoi(const char *s)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	53                   	push   %ebx
 484:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 487:	0f be 11             	movsbl (%ecx),%edx
 48a:	8d 42 d0             	lea    -0x30(%edx),%eax
 48d:	3c 09                	cmp    $0x9,%al
  n = 0;
 48f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 494:	77 1f                	ja     4b5 <atoi+0x35>
 496:	8d 76 00             	lea    0x0(%esi),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4a3:	83 c1 01             	add    $0x1,%ecx
 4a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 4aa:	0f be 11             	movsbl (%ecx),%edx
 4ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4b0:	80 fb 09             	cmp    $0x9,%bl
 4b3:	76 eb                	jbe    4a0 <atoi+0x20>
  return n;
}
 4b5:	5b                   	pop    %ebx
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
 4c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4c8:	8b 45 08             	mov    0x8(%ebp),%eax
 4cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	7e 14                	jle    4e6 <memmove+0x26>
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4df:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 4e2:	39 d3                	cmp    %edx,%ebx
 4e4:	75 f2                	jne    4d8 <memmove+0x18>
  return vdst;
}
 4e6:	5b                   	pop    %ebx
 4e7:	5e                   	pop    %esi
 4e8:	5d                   	pop    %ebp
 4e9:	c3                   	ret    

000004ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ea:	b8 01 00 00 00       	mov    $0x1,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <exit>:
SYSCALL(exit)
 4f2:	b8 02 00 00 00       	mov    $0x2,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <wait>:
SYSCALL(wait)
 4fa:	b8 03 00 00 00       	mov    $0x3,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <pipe>:
SYSCALL(pipe)
 502:	b8 04 00 00 00       	mov    $0x4,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <read>:
SYSCALL(read)
 50a:	b8 05 00 00 00       	mov    $0x5,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <write>:
SYSCALL(write)
 512:	b8 10 00 00 00       	mov    $0x10,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <close>:
SYSCALL(close)
 51a:	b8 15 00 00 00       	mov    $0x15,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <kill>:
SYSCALL(kill)
 522:	b8 06 00 00 00       	mov    $0x6,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <exec>:
SYSCALL(exec)
 52a:	b8 07 00 00 00       	mov    $0x7,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <open>:
SYSCALL(open)
 532:	b8 0f 00 00 00       	mov    $0xf,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <mknod>:
SYSCALL(mknod)
 53a:	b8 11 00 00 00       	mov    $0x11,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <unlink>:
SYSCALL(unlink)
 542:	b8 12 00 00 00       	mov    $0x12,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <fstat>:
SYSCALL(fstat)
 54a:	b8 08 00 00 00       	mov    $0x8,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <link>:
SYSCALL(link)
 552:	b8 13 00 00 00       	mov    $0x13,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <mkdir>:
SYSCALL(mkdir)
 55a:	b8 14 00 00 00       	mov    $0x14,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <chdir>:
SYSCALL(chdir)
 562:	b8 09 00 00 00       	mov    $0x9,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <dup>:
SYSCALL(dup)
 56a:	b8 0a 00 00 00       	mov    $0xa,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <getpid>:
SYSCALL(getpid)
 572:	b8 0b 00 00 00       	mov    $0xb,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <sbrk>:
SYSCALL(sbrk)
 57a:	b8 0c 00 00 00       	mov    $0xc,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <sleep>:
SYSCALL(sleep)
 582:	b8 0d 00 00 00       	mov    $0xd,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <uptime>:
SYSCALL(uptime)
 58a:	b8 0e 00 00 00       	mov    $0xe,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <kthread_create>:
SYSCALL(kthread_create)
 592:	b8 16 00 00 00       	mov    $0x16,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <kthread_id>:
SYSCALL(kthread_id)
 59a:	b8 17 00 00 00       	mov    $0x17,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <kthread_exit>:
SYSCALL(kthread_exit)
 5a2:	b8 18 00 00 00       	mov    $0x18,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <kthread_join>:
SYSCALL(kthread_join)
 5aa:	b8 19 00 00 00       	mov    $0x19,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 5b2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 5ba:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 5c2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 5ca:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    
 5d2:	66 90                	xchg   %ax,%ax
 5d4:	66 90                	xchg   %ax,%ax
 5d6:	66 90                	xchg   %ax,%ax
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5e9:	85 d2                	test   %edx,%edx
{
 5eb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 5ee:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 5f0:	79 76                	jns    668 <printint+0x88>
 5f2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5f6:	74 70                	je     668 <printint+0x88>
    x = -xx;
 5f8:	f7 d8                	neg    %eax
    neg = 1;
 5fa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 601:	31 f6                	xor    %esi,%esi
 603:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 606:	eb 0a                	jmp    612 <printint+0x32>
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 610:	89 fe                	mov    %edi,%esi
 612:	31 d2                	xor    %edx,%edx
 614:	8d 7e 01             	lea    0x1(%esi),%edi
 617:	f7 f1                	div    %ecx
 619:	0f b6 92 10 0a 00 00 	movzbl 0xa10(%edx),%edx
  }while((x /= base) != 0);
 620:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 622:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 625:	75 e9                	jne    610 <printint+0x30>
  if(neg)
 627:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 62a:	85 c0                	test   %eax,%eax
 62c:	74 08                	je     636 <printint+0x56>
    buf[i++] = '-';
 62e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 633:	8d 7e 02             	lea    0x2(%esi),%edi
 636:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 63a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
 640:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
 646:	83 ee 01             	sub    $0x1,%esi
 649:	6a 01                	push   $0x1
 64b:	53                   	push   %ebx
 64c:	57                   	push   %edi
 64d:	88 45 d7             	mov    %al,-0x29(%ebp)
 650:	e8 bd fe ff ff       	call   512 <write>

  while(--i >= 0)
 655:	83 c4 10             	add    $0x10,%esp
 658:	39 de                	cmp    %ebx,%esi
 65a:	75 e4                	jne    640 <printint+0x60>
    putc(fd, buf[i]);
}
 65c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 65f:	5b                   	pop    %ebx
 660:	5e                   	pop    %esi
 661:	5f                   	pop    %edi
 662:	5d                   	pop    %ebp
 663:	c3                   	ret    
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 668:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 66f:	eb 90                	jmp    601 <printint+0x21>
 671:	eb 0d                	jmp    680 <printf>
 673:	90                   	nop
 674:	90                   	nop
 675:	90                   	nop
 676:	90                   	nop
 677:	90                   	nop
 678:	90                   	nop
 679:	90                   	nop
 67a:	90                   	nop
 67b:	90                   	nop
 67c:	90                   	nop
 67d:	90                   	nop
 67e:	90                   	nop
 67f:	90                   	nop

00000680 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 689:	8b 75 0c             	mov    0xc(%ebp),%esi
 68c:	0f b6 1e             	movzbl (%esi),%ebx
 68f:	84 db                	test   %bl,%bl
 691:	0f 84 b3 00 00 00    	je     74a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 697:	8d 45 10             	lea    0x10(%ebp),%eax
 69a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 69d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 69f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6a2:	eb 2f                	jmp    6d3 <printf+0x53>
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6a8:	83 f8 25             	cmp    $0x25,%eax
 6ab:	0f 84 a7 00 00 00    	je     758 <printf+0xd8>
  write(fd, &c, 1);
 6b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6b4:	83 ec 04             	sub    $0x4,%esp
 6b7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6ba:	6a 01                	push   $0x1
 6bc:	50                   	push   %eax
 6bd:	ff 75 08             	pushl  0x8(%ebp)
 6c0:	e8 4d fe ff ff       	call   512 <write>
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 6cb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6cf:	84 db                	test   %bl,%bl
 6d1:	74 77                	je     74a <printf+0xca>
    if(state == 0){
 6d3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 6d5:	0f be cb             	movsbl %bl,%ecx
 6d8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6db:	74 cb                	je     6a8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6dd:	83 ff 25             	cmp    $0x25,%edi
 6e0:	75 e6                	jne    6c8 <printf+0x48>
      if(c == 'd'){
 6e2:	83 f8 64             	cmp    $0x64,%eax
 6e5:	0f 84 05 01 00 00    	je     7f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6eb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6f1:	83 f9 70             	cmp    $0x70,%ecx
 6f4:	74 72                	je     768 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6f6:	83 f8 73             	cmp    $0x73,%eax
 6f9:	0f 84 99 00 00 00    	je     798 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ff:	83 f8 63             	cmp    $0x63,%eax
 702:	0f 84 08 01 00 00    	je     810 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 708:	83 f8 25             	cmp    $0x25,%eax
 70b:	0f 84 ef 00 00 00    	je     800 <printf+0x180>
  write(fd, &c, 1);
 711:	8d 45 e7             	lea    -0x19(%ebp),%eax
 714:	83 ec 04             	sub    $0x4,%esp
 717:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 71b:	6a 01                	push   $0x1
 71d:	50                   	push   %eax
 71e:	ff 75 08             	pushl  0x8(%ebp)
 721:	e8 ec fd ff ff       	call   512 <write>
 726:	83 c4 0c             	add    $0xc,%esp
 729:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 72c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 72f:	6a 01                	push   $0x1
 731:	50                   	push   %eax
 732:	ff 75 08             	pushl  0x8(%ebp)
 735:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 738:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 73a:	e8 d3 fd ff ff       	call   512 <write>
  for(i = 0; fmt[i]; i++){
 73f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 743:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 746:	84 db                	test   %bl,%bl
 748:	75 89                	jne    6d3 <printf+0x53>
    }
  }
}
 74a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 74d:	5b                   	pop    %ebx
 74e:	5e                   	pop    %esi
 74f:	5f                   	pop    %edi
 750:	5d                   	pop    %ebp
 751:	c3                   	ret    
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 758:	bf 25 00 00 00       	mov    $0x25,%edi
 75d:	e9 66 ff ff ff       	jmp    6c8 <printf+0x48>
 762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 768:	83 ec 0c             	sub    $0xc,%esp
 76b:	b9 10 00 00 00       	mov    $0x10,%ecx
 770:	6a 00                	push   $0x0
 772:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 775:	8b 45 08             	mov    0x8(%ebp),%eax
 778:	8b 17                	mov    (%edi),%edx
 77a:	e8 61 fe ff ff       	call   5e0 <printint>
        ap++;
 77f:	89 f8                	mov    %edi,%eax
 781:	83 c4 10             	add    $0x10,%esp
      state = 0;
 784:	31 ff                	xor    %edi,%edi
        ap++;
 786:	83 c0 04             	add    $0x4,%eax
 789:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 78c:	e9 37 ff ff ff       	jmp    6c8 <printf+0x48>
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 798:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 79b:	8b 08                	mov    (%eax),%ecx
        ap++;
 79d:	83 c0 04             	add    $0x4,%eax
 7a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 7a3:	85 c9                	test   %ecx,%ecx
 7a5:	0f 84 8e 00 00 00    	je     839 <printf+0x1b9>
        while(*s != 0){
 7ab:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 7ae:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 7b0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 7b2:	84 c0                	test   %al,%al
 7b4:	0f 84 0e ff ff ff    	je     6c8 <printf+0x48>
 7ba:	89 75 d0             	mov    %esi,-0x30(%ebp)
 7bd:	89 de                	mov    %ebx,%esi
 7bf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7c2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 7c5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7c8:	83 ec 04             	sub    $0x4,%esp
          s++;
 7cb:	83 c6 01             	add    $0x1,%esi
 7ce:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7d1:	6a 01                	push   $0x1
 7d3:	57                   	push   %edi
 7d4:	53                   	push   %ebx
 7d5:	e8 38 fd ff ff       	call   512 <write>
        while(*s != 0){
 7da:	0f b6 06             	movzbl (%esi),%eax
 7dd:	83 c4 10             	add    $0x10,%esp
 7e0:	84 c0                	test   %al,%al
 7e2:	75 e4                	jne    7c8 <printf+0x148>
 7e4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 7e7:	31 ff                	xor    %edi,%edi
 7e9:	e9 da fe ff ff       	jmp    6c8 <printf+0x48>
 7ee:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 7f0:	83 ec 0c             	sub    $0xc,%esp
 7f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7f8:	6a 01                	push   $0x1
 7fa:	e9 73 ff ff ff       	jmp    772 <printf+0xf2>
 7ff:	90                   	nop
  write(fd, &c, 1);
 800:	83 ec 04             	sub    $0x4,%esp
 803:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 806:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 809:	6a 01                	push   $0x1
 80b:	e9 21 ff ff ff       	jmp    731 <printf+0xb1>
        putc(fd, *ap);
 810:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 813:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 816:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 818:	6a 01                	push   $0x1
        ap++;
 81a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 81d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 820:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 823:	50                   	push   %eax
 824:	ff 75 08             	pushl  0x8(%ebp)
 827:	e8 e6 fc ff ff       	call   512 <write>
        ap++;
 82c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 82f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 832:	31 ff                	xor    %edi,%edi
 834:	e9 8f fe ff ff       	jmp    6c8 <printf+0x48>
          s = "(null)";
 839:	bb 09 0a 00 00       	mov    $0xa09,%ebx
        while(*s != 0){
 83e:	b8 28 00 00 00       	mov    $0x28,%eax
 843:	e9 72 ff ff ff       	jmp    7ba <printf+0x13a>
 848:	66 90                	xchg   %ax,%ax
 84a:	66 90                	xchg   %ax,%ax
 84c:	66 90                	xchg   %ax,%ax
 84e:	66 90                	xchg   %ax,%ax

00000850 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 850:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 851:	a1 f0 0d 00 00       	mov    0xdf0,%eax
{
 856:	89 e5                	mov    %esp,%ebp
 858:	57                   	push   %edi
 859:	56                   	push   %esi
 85a:	53                   	push   %ebx
 85b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 85e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 868:	39 c8                	cmp    %ecx,%eax
 86a:	8b 10                	mov    (%eax),%edx
 86c:	73 32                	jae    8a0 <free+0x50>
 86e:	39 d1                	cmp    %edx,%ecx
 870:	72 04                	jb     876 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 872:	39 d0                	cmp    %edx,%eax
 874:	72 32                	jb     8a8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 876:	8b 73 fc             	mov    -0x4(%ebx),%esi
 879:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 87c:	39 fa                	cmp    %edi,%edx
 87e:	74 30                	je     8b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 880:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 883:	8b 50 04             	mov    0x4(%eax),%edx
 886:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 889:	39 f1                	cmp    %esi,%ecx
 88b:	74 3a                	je     8c7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 88d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 88f:	a3 f0 0d 00 00       	mov    %eax,0xdf0
}
 894:	5b                   	pop    %ebx
 895:	5e                   	pop    %esi
 896:	5f                   	pop    %edi
 897:	5d                   	pop    %ebp
 898:	c3                   	ret    
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a0:	39 d0                	cmp    %edx,%eax
 8a2:	72 04                	jb     8a8 <free+0x58>
 8a4:	39 d1                	cmp    %edx,%ecx
 8a6:	72 ce                	jb     876 <free+0x26>
{
 8a8:	89 d0                	mov    %edx,%eax
 8aa:	eb bc                	jmp    868 <free+0x18>
 8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 8b0:	03 72 04             	add    0x4(%edx),%esi
 8b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b6:	8b 10                	mov    (%eax),%edx
 8b8:	8b 12                	mov    (%edx),%edx
 8ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8bd:	8b 50 04             	mov    0x4(%eax),%edx
 8c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8c3:	39 f1                	cmp    %esi,%ecx
 8c5:	75 c6                	jne    88d <free+0x3d>
    p->s.size += bp->s.size;
 8c7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8ca:	a3 f0 0d 00 00       	mov    %eax,0xdf0
    p->s.size += bp->s.size;
 8cf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8d2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8d5:	89 10                	mov    %edx,(%eax)
}
 8d7:	5b                   	pop    %ebx
 8d8:	5e                   	pop    %esi
 8d9:	5f                   	pop    %edi
 8da:	5d                   	pop    %ebp
 8db:	c3                   	ret    
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
 8e5:	53                   	push   %ebx
 8e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ec:	8b 15 f0 0d 00 00    	mov    0xdf0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f2:	8d 78 07             	lea    0x7(%eax),%edi
 8f5:	c1 ef 03             	shr    $0x3,%edi
 8f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8fb:	85 d2                	test   %edx,%edx
 8fd:	0f 84 9d 00 00 00    	je     9a0 <malloc+0xc0>
 903:	8b 02                	mov    (%edx),%eax
 905:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 908:	39 cf                	cmp    %ecx,%edi
 90a:	76 6c                	jbe    978 <malloc+0x98>
 90c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 912:	bb 00 10 00 00       	mov    $0x1000,%ebx
 917:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 91a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 921:	eb 0e                	jmp    931 <malloc+0x51>
 923:	90                   	nop
 924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 928:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 92a:	8b 48 04             	mov    0x4(%eax),%ecx
 92d:	39 f9                	cmp    %edi,%ecx
 92f:	73 47                	jae    978 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 931:	39 05 f0 0d 00 00    	cmp    %eax,0xdf0
 937:	89 c2                	mov    %eax,%edx
 939:	75 ed                	jne    928 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 93b:	83 ec 0c             	sub    $0xc,%esp
 93e:	56                   	push   %esi
 93f:	e8 36 fc ff ff       	call   57a <sbrk>
  if(p == (char*)-1)
 944:	83 c4 10             	add    $0x10,%esp
 947:	83 f8 ff             	cmp    $0xffffffff,%eax
 94a:	74 1c                	je     968 <malloc+0x88>
  hp->s.size = nu;
 94c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 94f:	83 ec 0c             	sub    $0xc,%esp
 952:	83 c0 08             	add    $0x8,%eax
 955:	50                   	push   %eax
 956:	e8 f5 fe ff ff       	call   850 <free>
  return freep;
 95b:	8b 15 f0 0d 00 00    	mov    0xdf0,%edx
      if((p = morecore(nunits)) == 0)
 961:	83 c4 10             	add    $0x10,%esp
 964:	85 d2                	test   %edx,%edx
 966:	75 c0                	jne    928 <malloc+0x48>
        return 0;
  }
}
 968:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 96b:	31 c0                	xor    %eax,%eax
}
 96d:	5b                   	pop    %ebx
 96e:	5e                   	pop    %esi
 96f:	5f                   	pop    %edi
 970:	5d                   	pop    %ebp
 971:	c3                   	ret    
 972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 978:	39 cf                	cmp    %ecx,%edi
 97a:	74 54                	je     9d0 <malloc+0xf0>
        p->s.size -= nunits;
 97c:	29 f9                	sub    %edi,%ecx
 97e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 981:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 984:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 987:	89 15 f0 0d 00 00    	mov    %edx,0xdf0
}
 98d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 990:	83 c0 08             	add    $0x8,%eax
}
 993:	5b                   	pop    %ebx
 994:	5e                   	pop    %esi
 995:	5f                   	pop    %edi
 996:	5d                   	pop    %ebp
 997:	c3                   	ret    
 998:	90                   	nop
 999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 9a0:	c7 05 f0 0d 00 00 f4 	movl   $0xdf4,0xdf0
 9a7:	0d 00 00 
 9aa:	c7 05 f4 0d 00 00 f4 	movl   $0xdf4,0xdf4
 9b1:	0d 00 00 
    base.s.size = 0;
 9b4:	b8 f4 0d 00 00       	mov    $0xdf4,%eax
 9b9:	c7 05 f8 0d 00 00 00 	movl   $0x0,0xdf8
 9c0:	00 00 00 
 9c3:	e9 44 ff ff ff       	jmp    90c <malloc+0x2c>
 9c8:	90                   	nop
 9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 9d0:	8b 08                	mov    (%eax),%ecx
 9d2:	89 0a                	mov    %ecx,(%edx)
 9d4:	eb b1                	jmp    987 <malloc+0xa7>
