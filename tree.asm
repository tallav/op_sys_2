
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
  14:	e8 17 01 00 00       	call   130 <trnmnt_tree_alloc>
  19:	89 c3                	mov    %eax,%ebx
    print_tree(tree->root, 0);
  1b:	8b 00                	mov    (%eax),%eax
  1d:	31 d2                	xor    %edx,%edx
  1f:	e8 1c 00 00 00       	call   40 <print_tree>
    trnmnt_tree_dealloc(tree);
  24:	89 1c 24             	mov    %ebx,(%esp)
  27:	e8 c4 01 00 00       	call   1f0 <trnmnt_tree_dealloc>
    print_tree(tree->root, 0);
  2c:	8b 03                	mov    (%ebx),%eax
  2e:	31 d2                	xor    %edx,%edx
  30:	e8 0b 00 00 00       	call   40 <print_tree>
    exit();
  35:	e8 88 04 00 00       	call   4c2 <exit>
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

00000040 <print_tree>:
	if(!r) return ;
  40:	85 c0                	test   %eax,%eax
  42:	74 6c                	je     b0 <print_tree+0x70>
static void print_tree(struct tree_node *r,int l){
  44:	55                   	push   %ebp
  45:	89 e5                	mov    %esp,%ebp
  47:	57                   	push   %edi
  48:	56                   	push   %esi
  49:	53                   	push   %ebx
  4a:	89 c6                	mov    %eax,%esi
  4c:	89 d3                	mov    %edx,%ebx
  4e:	83 ec 1c             	sub    $0x1c,%esp
	print_tree(r->right_child,l+1);
  51:	8d 43 01             	lea    0x1(%ebx),%eax
  54:	89 c2                	mov    %eax,%edx
  56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  59:	8b 46 04             	mov    0x4(%esi),%eax
  5c:	e8 df ff ff ff       	call   40 <print_tree>
	for(i=0;i<l;++i){
  61:	85 db                	test   %ebx,%ebx
  63:	7e 24                	jle    89 <print_tree+0x49>
  65:	31 ff                	xor    %edi,%edi
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		printf(1,"  ");
  70:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
  73:	83 c7 01             	add    $0x1,%edi
		printf(1,"  ");
  76:	68 a8 09 00 00       	push   $0x9a8
  7b:	6a 01                	push   $0x1
  7d:	e8 ce 05 00 00       	call   650 <printf>
	for(i=0;i<l;++i){
  82:	83 c4 10             	add    $0x10,%esp
  85:	39 df                	cmp    %ebx,%edi
  87:	75 e7                	jne    70 <print_tree+0x30>
	printf(1,"%d \n",r->mutex_id);
  89:	83 ec 04             	sub    $0x4,%esp
  8c:	ff 76 0c             	pushl  0xc(%esi)
  8f:	68 ab 09 00 00       	push   $0x9ab
  94:	6a 01                	push   $0x1
  96:	e8 b5 05 00 00       	call   650 <printf>
	print_tree(r->left_child,l+1);
  9b:	8b 36                	mov    (%esi),%esi
	if(!r) return ;
  9d:	83 c4 10             	add    $0x10,%esp
	print_tree(r->left_child,l+1);
  a0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!r) return ;
  a3:	85 f6                	test   %esi,%esi
  a5:	75 aa                	jne    51 <print_tree+0x11>
}
  a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  aa:	5b                   	pop    %ebx
  ab:	5e                   	pop    %esi
  ac:	5f                   	pop    %edi
  ad:	5d                   	pop    %ebp
  ae:	c3                   	ret    
  af:	90                   	nop
  b0:	f3 c3                	repz ret 
  b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000c0 <create_tree>:
void create_tree(struct tree_node* node, int depth){
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 0c             	sub    $0xc,%esp
    if(depth == 0){
  c9:	8b 75 0c             	mov    0xc(%ebp),%esi
void create_tree(struct tree_node* node, int depth){
  cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
  cf:	85 f6                	test   %esi,%esi
  d1:	74 48                	je     11b <create_tree+0x5b>
    struct tree_node *left = malloc(sizeof(struct tree_node));
  d3:	83 ec 0c             	sub    $0xc,%esp
  d6:	6a 10                	push   $0x10
  d8:	e8 d3 07 00 00       	call   8b0 <malloc>
  dd:	89 c6                	mov    %eax,%esi
    struct tree_node *right = malloc(sizeof(struct tree_node));
  df:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
  e6:	e8 c5 07 00 00       	call   8b0 <malloc>
    left->parent = node;
  eb:	89 5e 08             	mov    %ebx,0x8(%esi)
    right->parent = node;
  ee:	89 58 08             	mov    %ebx,0x8(%eax)
    struct tree_node *right = malloc(sizeof(struct tree_node));
  f1:	89 c7                	mov    %eax,%edi
    node->left_child = left;
  f3:	89 33                	mov    %esi,(%ebx)
    node->right_child = right;
  f5:	89 43 04             	mov    %eax,0x4(%ebx)
    node->mutex_id = kthread_mutex_alloc();
  f8:	e8 85 04 00 00       	call   582 <kthread_mutex_alloc>
  fd:	89 43 0c             	mov    %eax,0xc(%ebx)
    create_tree(left, depth-1);
 100:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
 104:	89 fb                	mov    %edi,%ebx
 106:	58                   	pop    %eax
 107:	5a                   	pop    %edx
 108:	ff 75 0c             	pushl  0xc(%ebp)
 10b:	56                   	push   %esi
 10c:	e8 af ff ff ff       	call   c0 <create_tree>
    if(depth == 0){
 111:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c9                	test   %ecx,%ecx
 119:	75 b8                	jne    d3 <create_tree+0x13>
}
 11b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 11e:	5b                   	pop    %ebx
 11f:	5e                   	pop    %esi
 120:	5f                   	pop    %edi
 121:	5d                   	pop    %ebp
 122:	c3                   	ret    
 123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <trnmnt_tree_alloc>:
struct trnmnt_tree* trnmnt_tree_alloc(int depth){
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	56                   	push   %esi
 134:	53                   	push   %ebx
 135:	8b 75 08             	mov    0x8(%ebp),%esi
    struct trnmnt_tree *tree = malloc(sizeof(struct trnmnt_tree));
 138:	83 ec 0c             	sub    $0xc,%esp
 13b:	6a 08                	push   $0x8
 13d:	e8 6e 07 00 00       	call   8b0 <malloc>
 142:	89 c3                	mov    %eax,%ebx
    struct tree_node *root = malloc(sizeof(struct tree_node));
 144:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
 14b:	e8 60 07 00 00       	call   8b0 <malloc>
    tree->depth = depth;
 150:	89 73 04             	mov    %esi,0x4(%ebx)
    tree->root = root;
 153:	89 03                	mov    %eax,(%ebx)
    root->parent = 0;
 155:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    create_tree(tree->root, depth);
 15c:	58                   	pop    %eax
 15d:	5a                   	pop    %edx
 15e:	56                   	push   %esi
 15f:	ff 33                	pushl  (%ebx)
 161:	e8 5a ff ff ff       	call   c0 <create_tree>
}
 166:	8d 65 f8             	lea    -0x8(%ebp),%esp
 169:	89 d8                	mov    %ebx,%eax
 16b:	5b                   	pop    %ebx
 16c:	5e                   	pop    %esi
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    
 16f:	90                   	nop

00000170 <deleteTree>:
int deleteTree(struct tree_node *node){
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
 175:	8b 5d 08             	mov    0x8(%ebp),%ebx
    return 0;
 178:	31 f6                	xor    %esi,%esi
    if (node != 0){ 
 17a:	85 db                	test   %ebx,%ebx
 17c:	74 42                	je     1c0 <deleteTree+0x50>
        if(kthread_mutex_dealloc(node->mutex_id) < 0){
 17e:	83 ec 0c             	sub    $0xc,%esp
 181:	ff 73 0c             	pushl  0xc(%ebx)
 184:	e8 01 04 00 00       	call   58a <kthread_mutex_dealloc>
 189:	83 c4 10             	add    $0x10,%esp
 18c:	85 c0                	test   %eax,%eax
 18e:	78 40                	js     1d0 <deleteTree+0x60>
        deleteTree(node->left_child); 
 190:	83 ec 0c             	sub    $0xc,%esp
 193:	ff 33                	pushl  (%ebx)
 195:	e8 d6 ff ff ff       	call   170 <deleteTree>
        deleteTree(node->right_child); 
 19a:	58                   	pop    %eax
 19b:	ff 73 04             	pushl  0x4(%ebx)
 19e:	e8 cd ff ff ff       	call   170 <deleteTree>
        printf(1, "Deleting node: %d\n", node->mutex_id); 
 1a3:	83 c4 0c             	add    $0xc,%esp
 1a6:	ff 73 0c             	pushl  0xc(%ebx)
 1a9:	68 c6 09 00 00       	push   $0x9c6
 1ae:	6a 01                	push   $0x1
 1b0:	e8 9b 04 00 00       	call   650 <printf>
        free(node); 
 1b5:	89 1c 24             	mov    %ebx,(%esp)
 1b8:	e8 63 06 00 00       	call   820 <free>
 1bd:	83 c4 10             	add    $0x10,%esp
}
 1c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c3:	89 f0                	mov    %esi,%eax
 1c5:	5b                   	pop    %ebx
 1c6:	5e                   	pop    %esi
 1c7:	5d                   	pop    %ebp
 1c8:	c3                   	ret    
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1, "mutex dealloc failed\n");
 1d0:	83 ec 08             	sub    $0x8,%esp
 1d3:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d8:	68 b0 09 00 00       	push   $0x9b0
 1dd:	6a 01                	push   $0x1
 1df:	e8 6c 04 00 00       	call   650 <printf>
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	eb d7                	jmp    1c0 <deleteTree+0x50>
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <trnmnt_tree_dealloc>:
int trnmnt_tree_dealloc(struct trnmnt_tree* tree){
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(deleteTree(tree->root) == 0){
 1f8:	83 ec 0c             	sub    $0xc,%esp
 1fb:	ff 33                	pushl  (%ebx)
 1fd:	e8 6e ff ff ff       	call   170 <deleteTree>
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	75 3f                	jne    248 <trnmnt_tree_dealloc+0x58>
 209:	89 c6                	mov    %eax,%esi
        if(tree->root == 0)
 20b:	8b 03                	mov    (%ebx),%eax
 20d:	85 c0                	test   %eax,%eax
 20f:	74 1f                	je     230 <trnmnt_tree_dealloc+0x40>
        free(tree);
 211:	83 ec 0c             	sub    $0xc,%esp
 214:	53                   	push   %ebx
 215:	e8 06 06 00 00       	call   820 <free>
        return 0;
 21a:	83 c4 10             	add    $0x10,%esp
}
 21d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 220:	89 f0                	mov    %esi,%eax
 222:	5b                   	pop    %ebx
 223:	5e                   	pop    %esi
 224:	5d                   	pop    %ebp
 225:	c3                   	ret    
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            printf(1,"free tree\n");
 230:	83 ec 08             	sub    $0x8,%esp
 233:	68 d9 09 00 00       	push   $0x9d9
 238:	6a 01                	push   $0x1
 23a:	e8 11 04 00 00       	call   650 <printf>
 23f:	83 c4 10             	add    $0x10,%esp
 242:	eb cd                	jmp    211 <trnmnt_tree_dealloc+0x21>
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 248:	be ff ff ff ff       	mov    $0xffffffff,%esi
 24d:	eb ce                	jmp    21d <trnmnt_tree_dealloc+0x2d>
 24f:	90                   	nop

00000250 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID){
 250:	55                   	push   %ebp
}
 251:	31 c0                	xor    %eax,%eax
int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID){
 253:	89 e5                	mov    %esp,%ebp
}
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <trnmnt_tree_release>:
 260:	55                   	push   %ebp
 261:	31 c0                	xor    %eax,%eax
 263:	89 e5                	mov    %esp,%ebp
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	66 90                	xchg   %ax,%ax
 269:	66 90                	xchg   %ax,%ax
 26b:	66 90                	xchg   %ax,%ax
 26d:	66 90                	xchg   %ax,%ax
 26f:	90                   	nop

00000270 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27a:	89 c2                	mov    %eax,%edx
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	83 c1 01             	add    $0x1,%ecx
 283:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 287:	83 c2 01             	add    $0x1,%edx
 28a:	84 db                	test   %bl,%bl
 28c:	88 5a ff             	mov    %bl,-0x1(%edx)
 28f:	75 ef                	jne    280 <strcpy+0x10>
    ;
  return os;
}
 291:	5b                   	pop    %ebx
 292:	5d                   	pop    %ebp
 293:	c3                   	ret    
 294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
 2a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2aa:	0f b6 02             	movzbl (%edx),%eax
 2ad:	0f b6 19             	movzbl (%ecx),%ebx
 2b0:	84 c0                	test   %al,%al
 2b2:	75 1c                	jne    2d0 <strcmp+0x30>
 2b4:	eb 2a                	jmp    2e0 <strcmp+0x40>
 2b6:	8d 76 00             	lea    0x0(%esi),%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2c6:	83 c1 01             	add    $0x1,%ecx
 2c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 2cc:	84 c0                	test   %al,%al
 2ce:	74 10                	je     2e0 <strcmp+0x40>
 2d0:	38 d8                	cmp    %bl,%al
 2d2:	74 ec                	je     2c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 2d4:	29 d8                	sub    %ebx,%eax
}
 2d6:	5b                   	pop    %ebx
 2d7:	5d                   	pop    %ebp
 2d8:	c3                   	ret    
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 2e2:	29 d8                	sub    %ebx,%eax
}
 2e4:	5b                   	pop    %ebx
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <strlen>:

uint
strlen(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f6:	80 39 00             	cmpb   $0x0,(%ecx)
 2f9:	74 15                	je     310 <strlen+0x20>
 2fb:	31 d2                	xor    %edx,%edx
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
 300:	83 c2 01             	add    $0x1,%edx
 303:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 307:	89 d0                	mov    %edx,%eax
 309:	75 f5                	jne    300 <strlen+0x10>
    ;
  return n;
}
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 310:	31 c0                	xor    %eax,%eax
}
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 31a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000320 <memset>:

void*
memset(void *dst, int c, uint n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 327:	8b 4d 10             	mov    0x10(%ebp),%ecx
 32a:	8b 45 0c             	mov    0xc(%ebp),%eax
 32d:	89 d7                	mov    %edx,%edi
 32f:	fc                   	cld    
 330:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 332:	89 d0                	mov    %edx,%eax
 334:	5f                   	pop    %edi
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <strchr>:

char*
strchr(const char *s, char c)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 34a:	0f b6 10             	movzbl (%eax),%edx
 34d:	84 d2                	test   %dl,%dl
 34f:	74 1d                	je     36e <strchr+0x2e>
    if(*s == c)
 351:	38 d3                	cmp    %dl,%bl
 353:	89 d9                	mov    %ebx,%ecx
 355:	75 0d                	jne    364 <strchr+0x24>
 357:	eb 17                	jmp    370 <strchr+0x30>
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 360:	38 ca                	cmp    %cl,%dl
 362:	74 0c                	je     370 <strchr+0x30>
  for(; *s; s++)
 364:	83 c0 01             	add    $0x1,%eax
 367:	0f b6 10             	movzbl (%eax),%edx
 36a:	84 d2                	test   %dl,%dl
 36c:	75 f2                	jne    360 <strchr+0x20>
      return (char*)s;
  return 0;
 36e:	31 c0                	xor    %eax,%eax
}
 370:	5b                   	pop    %ebx
 371:	5d                   	pop    %ebp
 372:	c3                   	ret    
 373:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <gets>:

char*
gets(char *buf, int max)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 386:	31 f6                	xor    %esi,%esi
 388:	89 f3                	mov    %esi,%ebx
{
 38a:	83 ec 1c             	sub    $0x1c,%esp
 38d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 390:	eb 2f                	jmp    3c1 <gets+0x41>
 392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 398:	8d 45 e7             	lea    -0x19(%ebp),%eax
 39b:	83 ec 04             	sub    $0x4,%esp
 39e:	6a 01                	push   $0x1
 3a0:	50                   	push   %eax
 3a1:	6a 00                	push   $0x0
 3a3:	e8 32 01 00 00       	call   4da <read>
    if(cc < 1)
 3a8:	83 c4 10             	add    $0x10,%esp
 3ab:	85 c0                	test   %eax,%eax
 3ad:	7e 1c                	jle    3cb <gets+0x4b>
      break;
    buf[i++] = c;
 3af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3b3:	83 c7 01             	add    $0x1,%edi
 3b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 3b9:	3c 0a                	cmp    $0xa,%al
 3bb:	74 23                	je     3e0 <gets+0x60>
 3bd:	3c 0d                	cmp    $0xd,%al
 3bf:	74 1f                	je     3e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 3c1:	83 c3 01             	add    $0x1,%ebx
 3c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3c7:	89 fe                	mov    %edi,%esi
 3c9:	7c cd                	jl     398 <gets+0x18>
 3cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 3cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 3d0:	c6 03 00             	movb   $0x0,(%ebx)
}
 3d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    
 3db:	90                   	nop
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e0:	8b 75 08             	mov    0x8(%ebp),%esi
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	01 de                	add    %ebx,%esi
 3e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 3ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 3ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f0:	5b                   	pop    %ebx
 3f1:	5e                   	pop    %esi
 3f2:	5f                   	pop    %edi
 3f3:	5d                   	pop    %ebp
 3f4:	c3                   	ret    
 3f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <stat>:

int
stat(const char *n, struct stat *st)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 405:	83 ec 08             	sub    $0x8,%esp
 408:	6a 00                	push   $0x0
 40a:	ff 75 08             	pushl  0x8(%ebp)
 40d:	e8 f0 00 00 00       	call   502 <open>
  if(fd < 0)
 412:	83 c4 10             	add    $0x10,%esp
 415:	85 c0                	test   %eax,%eax
 417:	78 27                	js     440 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 419:	83 ec 08             	sub    $0x8,%esp
 41c:	ff 75 0c             	pushl  0xc(%ebp)
 41f:	89 c3                	mov    %eax,%ebx
 421:	50                   	push   %eax
 422:	e8 f3 00 00 00       	call   51a <fstat>
  close(fd);
 427:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 42a:	89 c6                	mov    %eax,%esi
  close(fd);
 42c:	e8 b9 00 00 00       	call   4ea <close>
  return r;
 431:	83 c4 10             	add    $0x10,%esp
}
 434:	8d 65 f8             	lea    -0x8(%ebp),%esp
 437:	89 f0                	mov    %esi,%eax
 439:	5b                   	pop    %ebx
 43a:	5e                   	pop    %esi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 440:	be ff ff ff ff       	mov    $0xffffffff,%esi
 445:	eb ed                	jmp    434 <stat+0x34>
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <atoi>:

int
atoi(const char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
 454:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 457:	0f be 11             	movsbl (%ecx),%edx
 45a:	8d 42 d0             	lea    -0x30(%edx),%eax
 45d:	3c 09                	cmp    $0x9,%al
  n = 0;
 45f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 464:	77 1f                	ja     485 <atoi+0x35>
 466:	8d 76 00             	lea    0x0(%esi),%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 470:	8d 04 80             	lea    (%eax,%eax,4),%eax
 473:	83 c1 01             	add    $0x1,%ecx
 476:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 47a:	0f be 11             	movsbl (%ecx),%edx
 47d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 480:	80 fb 09             	cmp    $0x9,%bl
 483:	76 eb                	jbe    470 <atoi+0x20>
  return n;
}
 485:	5b                   	pop    %ebx
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	56                   	push   %esi
 494:	53                   	push   %ebx
 495:	8b 5d 10             	mov    0x10(%ebp),%ebx
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 49e:	85 db                	test   %ebx,%ebx
 4a0:	7e 14                	jle    4b6 <memmove+0x26>
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 4b2:	39 d3                	cmp    %edx,%ebx
 4b4:	75 f2                	jne    4a8 <memmove+0x18>
  return vdst;
}
 4b6:	5b                   	pop    %ebx
 4b7:	5e                   	pop    %esi
 4b8:	5d                   	pop    %ebp
 4b9:	c3                   	ret    

000004ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ba:	b8 01 00 00 00       	mov    $0x1,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <exit>:
SYSCALL(exit)
 4c2:	b8 02 00 00 00       	mov    $0x2,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <wait>:
SYSCALL(wait)
 4ca:	b8 03 00 00 00       	mov    $0x3,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <pipe>:
SYSCALL(pipe)
 4d2:	b8 04 00 00 00       	mov    $0x4,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <read>:
SYSCALL(read)
 4da:	b8 05 00 00 00       	mov    $0x5,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <write>:
SYSCALL(write)
 4e2:	b8 10 00 00 00       	mov    $0x10,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <close>:
SYSCALL(close)
 4ea:	b8 15 00 00 00       	mov    $0x15,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kill>:
SYSCALL(kill)
 4f2:	b8 06 00 00 00       	mov    $0x6,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <exec>:
SYSCALL(exec)
 4fa:	b8 07 00 00 00       	mov    $0x7,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <open>:
SYSCALL(open)
 502:	b8 0f 00 00 00       	mov    $0xf,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mknod>:
SYSCALL(mknod)
 50a:	b8 11 00 00 00       	mov    $0x11,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <unlink>:
SYSCALL(unlink)
 512:	b8 12 00 00 00       	mov    $0x12,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <fstat>:
SYSCALL(fstat)
 51a:	b8 08 00 00 00       	mov    $0x8,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <link>:
SYSCALL(link)
 522:	b8 13 00 00 00       	mov    $0x13,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <mkdir>:
SYSCALL(mkdir)
 52a:	b8 14 00 00 00       	mov    $0x14,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <chdir>:
SYSCALL(chdir)
 532:	b8 09 00 00 00       	mov    $0x9,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <dup>:
SYSCALL(dup)
 53a:	b8 0a 00 00 00       	mov    $0xa,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <getpid>:
SYSCALL(getpid)
 542:	b8 0b 00 00 00       	mov    $0xb,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <sbrk>:
SYSCALL(sbrk)
 54a:	b8 0c 00 00 00       	mov    $0xc,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <sleep>:
SYSCALL(sleep)
 552:	b8 0d 00 00 00       	mov    $0xd,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <uptime>:
SYSCALL(uptime)
 55a:	b8 0e 00 00 00       	mov    $0xe,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <kthread_create>:
SYSCALL(kthread_create)
 562:	b8 16 00 00 00       	mov    $0x16,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <kthread_id>:
SYSCALL(kthread_id)
 56a:	b8 17 00 00 00       	mov    $0x17,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <kthread_exit>:
SYSCALL(kthread_exit)
 572:	b8 18 00 00 00       	mov    $0x18,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <kthread_join>:
SYSCALL(kthread_join)
 57a:	b8 19 00 00 00       	mov    $0x19,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 582:	b8 1a 00 00 00       	mov    $0x1a,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 58a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 592:	b8 1c 00 00 00       	mov    $0x1c,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 59a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    
 5a2:	66 90                	xchg   %ax,%ax
 5a4:	66 90                	xchg   %ax,%ax
 5a6:	66 90                	xchg   %ax,%ax
 5a8:	66 90                	xchg   %ax,%ax
 5aa:	66 90                	xchg   %ax,%ax
 5ac:	66 90                	xchg   %ax,%ax
 5ae:	66 90                	xchg   %ax,%ax

000005b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b9:	85 d2                	test   %edx,%edx
{
 5bb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 5be:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 5c0:	79 76                	jns    638 <printint+0x88>
 5c2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5c6:	74 70                	je     638 <printint+0x88>
    x = -xx;
 5c8:	f7 d8                	neg    %eax
    neg = 1;
 5ca:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5d1:	31 f6                	xor    %esi,%esi
 5d3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5d6:	eb 0a                	jmp    5e2 <printint+0x32>
 5d8:	90                   	nop
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 5e0:	89 fe                	mov    %edi,%esi
 5e2:	31 d2                	xor    %edx,%edx
 5e4:	8d 7e 01             	lea    0x1(%esi),%edi
 5e7:	f7 f1                	div    %ecx
 5e9:	0f b6 92 ec 09 00 00 	movzbl 0x9ec(%edx),%edx
  }while((x /= base) != 0);
 5f0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 5f2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 5f5:	75 e9                	jne    5e0 <printint+0x30>
  if(neg)
 5f7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5fa:	85 c0                	test   %eax,%eax
 5fc:	74 08                	je     606 <printint+0x56>
    buf[i++] = '-';
 5fe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 603:	8d 7e 02             	lea    0x2(%esi),%edi
 606:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 60a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
 610:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
 616:	83 ee 01             	sub    $0x1,%esi
 619:	6a 01                	push   $0x1
 61b:	53                   	push   %ebx
 61c:	57                   	push   %edi
 61d:	88 45 d7             	mov    %al,-0x29(%ebp)
 620:	e8 bd fe ff ff       	call   4e2 <write>

  while(--i >= 0)
 625:	83 c4 10             	add    $0x10,%esp
 628:	39 de                	cmp    %ebx,%esi
 62a:	75 e4                	jne    610 <printint+0x60>
    putc(fd, buf[i]);
}
 62c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 62f:	5b                   	pop    %ebx
 630:	5e                   	pop    %esi
 631:	5f                   	pop    %edi
 632:	5d                   	pop    %ebp
 633:	c3                   	ret    
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 638:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 63f:	eb 90                	jmp    5d1 <printint+0x21>
 641:	eb 0d                	jmp    650 <printf>
 643:	90                   	nop
 644:	90                   	nop
 645:	90                   	nop
 646:	90                   	nop
 647:	90                   	nop
 648:	90                   	nop
 649:	90                   	nop
 64a:	90                   	nop
 64b:	90                   	nop
 64c:	90                   	nop
 64d:	90                   	nop
 64e:	90                   	nop
 64f:	90                   	nop

00000650 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 659:	8b 75 0c             	mov    0xc(%ebp),%esi
 65c:	0f b6 1e             	movzbl (%esi),%ebx
 65f:	84 db                	test   %bl,%bl
 661:	0f 84 b3 00 00 00    	je     71a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 667:	8d 45 10             	lea    0x10(%ebp),%eax
 66a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 66d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 66f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 672:	eb 2f                	jmp    6a3 <printf+0x53>
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 678:	83 f8 25             	cmp    $0x25,%eax
 67b:	0f 84 a7 00 00 00    	je     728 <printf+0xd8>
  write(fd, &c, 1);
 681:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 684:	83 ec 04             	sub    $0x4,%esp
 687:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 68a:	6a 01                	push   $0x1
 68c:	50                   	push   %eax
 68d:	ff 75 08             	pushl  0x8(%ebp)
 690:	e8 4d fe ff ff       	call   4e2 <write>
 695:	83 c4 10             	add    $0x10,%esp
 698:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 69b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 69f:	84 db                	test   %bl,%bl
 6a1:	74 77                	je     71a <printf+0xca>
    if(state == 0){
 6a3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 6a5:	0f be cb             	movsbl %bl,%ecx
 6a8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6ab:	74 cb                	je     678 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ad:	83 ff 25             	cmp    $0x25,%edi
 6b0:	75 e6                	jne    698 <printf+0x48>
      if(c == 'd'){
 6b2:	83 f8 64             	cmp    $0x64,%eax
 6b5:	0f 84 05 01 00 00    	je     7c0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6bb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6c1:	83 f9 70             	cmp    $0x70,%ecx
 6c4:	74 72                	je     738 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6c6:	83 f8 73             	cmp    $0x73,%eax
 6c9:	0f 84 99 00 00 00    	je     768 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6cf:	83 f8 63             	cmp    $0x63,%eax
 6d2:	0f 84 08 01 00 00    	je     7e0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6d8:	83 f8 25             	cmp    $0x25,%eax
 6db:	0f 84 ef 00 00 00    	je     7d0 <printf+0x180>
  write(fd, &c, 1);
 6e1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6e4:	83 ec 04             	sub    $0x4,%esp
 6e7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6eb:	6a 01                	push   $0x1
 6ed:	50                   	push   %eax
 6ee:	ff 75 08             	pushl  0x8(%ebp)
 6f1:	e8 ec fd ff ff       	call   4e2 <write>
 6f6:	83 c4 0c             	add    $0xc,%esp
 6f9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6fc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ff:	6a 01                	push   $0x1
 701:	50                   	push   %eax
 702:	ff 75 08             	pushl  0x8(%ebp)
 705:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 708:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 70a:	e8 d3 fd ff ff       	call   4e2 <write>
  for(i = 0; fmt[i]; i++){
 70f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 713:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 716:	84 db                	test   %bl,%bl
 718:	75 89                	jne    6a3 <printf+0x53>
    }
  }
}
 71a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 71d:	5b                   	pop    %ebx
 71e:	5e                   	pop    %esi
 71f:	5f                   	pop    %edi
 720:	5d                   	pop    %ebp
 721:	c3                   	ret    
 722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 728:	bf 25 00 00 00       	mov    $0x25,%edi
 72d:	e9 66 ff ff ff       	jmp    698 <printf+0x48>
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 738:	83 ec 0c             	sub    $0xc,%esp
 73b:	b9 10 00 00 00       	mov    $0x10,%ecx
 740:	6a 00                	push   $0x0
 742:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 745:	8b 45 08             	mov    0x8(%ebp),%eax
 748:	8b 17                	mov    (%edi),%edx
 74a:	e8 61 fe ff ff       	call   5b0 <printint>
        ap++;
 74f:	89 f8                	mov    %edi,%eax
 751:	83 c4 10             	add    $0x10,%esp
      state = 0;
 754:	31 ff                	xor    %edi,%edi
        ap++;
 756:	83 c0 04             	add    $0x4,%eax
 759:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 75c:	e9 37 ff ff ff       	jmp    698 <printf+0x48>
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 768:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 76b:	8b 08                	mov    (%eax),%ecx
        ap++;
 76d:	83 c0 04             	add    $0x4,%eax
 770:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 773:	85 c9                	test   %ecx,%ecx
 775:	0f 84 8e 00 00 00    	je     809 <printf+0x1b9>
        while(*s != 0){
 77b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 77e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 780:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 782:	84 c0                	test   %al,%al
 784:	0f 84 0e ff ff ff    	je     698 <printf+0x48>
 78a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 78d:	89 de                	mov    %ebx,%esi
 78f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 792:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 795:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 798:	83 ec 04             	sub    $0x4,%esp
          s++;
 79b:	83 c6 01             	add    $0x1,%esi
 79e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7a1:	6a 01                	push   $0x1
 7a3:	57                   	push   %edi
 7a4:	53                   	push   %ebx
 7a5:	e8 38 fd ff ff       	call   4e2 <write>
        while(*s != 0){
 7aa:	0f b6 06             	movzbl (%esi),%eax
 7ad:	83 c4 10             	add    $0x10,%esp
 7b0:	84 c0                	test   %al,%al
 7b2:	75 e4                	jne    798 <printf+0x148>
 7b4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 7b7:	31 ff                	xor    %edi,%edi
 7b9:	e9 da fe ff ff       	jmp    698 <printf+0x48>
 7be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7c8:	6a 01                	push   $0x1
 7ca:	e9 73 ff ff ff       	jmp    742 <printf+0xf2>
 7cf:	90                   	nop
  write(fd, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7d6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7d9:	6a 01                	push   $0x1
 7db:	e9 21 ff ff ff       	jmp    701 <printf+0xb1>
        putc(fd, *ap);
 7e0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 7e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7e6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 7e8:	6a 01                	push   $0x1
        ap++;
 7ea:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 7ed:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 7f0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7f3:	50                   	push   %eax
 7f4:	ff 75 08             	pushl  0x8(%ebp)
 7f7:	e8 e6 fc ff ff       	call   4e2 <write>
        ap++;
 7fc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 7ff:	83 c4 10             	add    $0x10,%esp
      state = 0;
 802:	31 ff                	xor    %edi,%edi
 804:	e9 8f fe ff ff       	jmp    698 <printf+0x48>
          s = "(null)";
 809:	bb e4 09 00 00       	mov    $0x9e4,%ebx
        while(*s != 0){
 80e:	b8 28 00 00 00       	mov    $0x28,%eax
 813:	e9 72 ff ff ff       	jmp    78a <printf+0x13a>
 818:	66 90                	xchg   %ax,%ax
 81a:	66 90                	xchg   %ax,%ax
 81c:	66 90                	xchg   %ax,%ax
 81e:	66 90                	xchg   %ax,%ax

00000820 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 820:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 821:	a1 ac 0d 00 00       	mov    0xdac,%eax
{
 826:	89 e5                	mov    %esp,%ebp
 828:	57                   	push   %edi
 829:	56                   	push   %esi
 82a:	53                   	push   %ebx
 82b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 82e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 838:	39 c8                	cmp    %ecx,%eax
 83a:	8b 10                	mov    (%eax),%edx
 83c:	73 32                	jae    870 <free+0x50>
 83e:	39 d1                	cmp    %edx,%ecx
 840:	72 04                	jb     846 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 842:	39 d0                	cmp    %edx,%eax
 844:	72 32                	jb     878 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 846:	8b 73 fc             	mov    -0x4(%ebx),%esi
 849:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 84c:	39 fa                	cmp    %edi,%edx
 84e:	74 30                	je     880 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 850:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 853:	8b 50 04             	mov    0x4(%eax),%edx
 856:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 859:	39 f1                	cmp    %esi,%ecx
 85b:	74 3a                	je     897 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 85d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 85f:	a3 ac 0d 00 00       	mov    %eax,0xdac
}
 864:	5b                   	pop    %ebx
 865:	5e                   	pop    %esi
 866:	5f                   	pop    %edi
 867:	5d                   	pop    %ebp
 868:	c3                   	ret    
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	39 d0                	cmp    %edx,%eax
 872:	72 04                	jb     878 <free+0x58>
 874:	39 d1                	cmp    %edx,%ecx
 876:	72 ce                	jb     846 <free+0x26>
{
 878:	89 d0                	mov    %edx,%eax
 87a:	eb bc                	jmp    838 <free+0x18>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 880:	03 72 04             	add    0x4(%edx),%esi
 883:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 886:	8b 10                	mov    (%eax),%edx
 888:	8b 12                	mov    (%edx),%edx
 88a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 88d:	8b 50 04             	mov    0x4(%eax),%edx
 890:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 893:	39 f1                	cmp    %esi,%ecx
 895:	75 c6                	jne    85d <free+0x3d>
    p->s.size += bp->s.size;
 897:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 89a:	a3 ac 0d 00 00       	mov    %eax,0xdac
    p->s.size += bp->s.size;
 89f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8a5:	89 10                	mov    %edx,(%eax)
}
 8a7:	5b                   	pop    %ebx
 8a8:	5e                   	pop    %esi
 8a9:	5f                   	pop    %edi
 8aa:	5d                   	pop    %ebp
 8ab:	c3                   	ret    
 8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8bc:	8b 15 ac 0d 00 00    	mov    0xdac,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c2:	8d 78 07             	lea    0x7(%eax),%edi
 8c5:	c1 ef 03             	shr    $0x3,%edi
 8c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8cb:	85 d2                	test   %edx,%edx
 8cd:	0f 84 9d 00 00 00    	je     970 <malloc+0xc0>
 8d3:	8b 02                	mov    (%edx),%eax
 8d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8d8:	39 cf                	cmp    %ecx,%edi
 8da:	76 6c                	jbe    948 <malloc+0x98>
 8dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8e7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 8ea:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8f1:	eb 0e                	jmp    901 <malloc+0x51>
 8f3:	90                   	nop
 8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8fa:	8b 48 04             	mov    0x4(%eax),%ecx
 8fd:	39 f9                	cmp    %edi,%ecx
 8ff:	73 47                	jae    948 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 901:	39 05 ac 0d 00 00    	cmp    %eax,0xdac
 907:	89 c2                	mov    %eax,%edx
 909:	75 ed                	jne    8f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 90b:	83 ec 0c             	sub    $0xc,%esp
 90e:	56                   	push   %esi
 90f:	e8 36 fc ff ff       	call   54a <sbrk>
  if(p == (char*)-1)
 914:	83 c4 10             	add    $0x10,%esp
 917:	83 f8 ff             	cmp    $0xffffffff,%eax
 91a:	74 1c                	je     938 <malloc+0x88>
  hp->s.size = nu;
 91c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 91f:	83 ec 0c             	sub    $0xc,%esp
 922:	83 c0 08             	add    $0x8,%eax
 925:	50                   	push   %eax
 926:	e8 f5 fe ff ff       	call   820 <free>
  return freep;
 92b:	8b 15 ac 0d 00 00    	mov    0xdac,%edx
      if((p = morecore(nunits)) == 0)
 931:	83 c4 10             	add    $0x10,%esp
 934:	85 d2                	test   %edx,%edx
 936:	75 c0                	jne    8f8 <malloc+0x48>
        return 0;
  }
}
 938:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 93b:	31 c0                	xor    %eax,%eax
}
 93d:	5b                   	pop    %ebx
 93e:	5e                   	pop    %esi
 93f:	5f                   	pop    %edi
 940:	5d                   	pop    %ebp
 941:	c3                   	ret    
 942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 948:	39 cf                	cmp    %ecx,%edi
 94a:	74 54                	je     9a0 <malloc+0xf0>
        p->s.size -= nunits;
 94c:	29 f9                	sub    %edi,%ecx
 94e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 951:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 954:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 957:	89 15 ac 0d 00 00    	mov    %edx,0xdac
}
 95d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 960:	83 c0 08             	add    $0x8,%eax
}
 963:	5b                   	pop    %ebx
 964:	5e                   	pop    %esi
 965:	5f                   	pop    %edi
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
 968:	90                   	nop
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 970:	c7 05 ac 0d 00 00 b0 	movl   $0xdb0,0xdac
 977:	0d 00 00 
 97a:	c7 05 b0 0d 00 00 b0 	movl   $0xdb0,0xdb0
 981:	0d 00 00 
    base.s.size = 0;
 984:	b8 b0 0d 00 00       	mov    $0xdb0,%eax
 989:	c7 05 b4 0d 00 00 00 	movl   $0x0,0xdb4
 990:	00 00 00 
 993:	e9 44 ff ff ff       	jmp    8dc <malloc+0x2c>
 998:	90                   	nop
 999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 9a0:	8b 08                	mov    (%eax),%ecx
 9a2:	89 0a                	mov    %ecx,(%edx)
 9a4:	eb b1                	jmp    957 <malloc+0xa7>
