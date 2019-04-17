
_myprog:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   return 1;
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    //test_kthread_exit();
    test_kthread_create();
  11:	e8 9a 00 00 00       	call   b0 <test_kthread_create>
    //test_kthread_join();
    //test();
    printf(1, "finish\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 b3 09 00 00       	push   $0x9b3
  1e:	6a 01                	push   $0x1
  20:	e8 bb 05 00 00       	call   5e0 <printf>
    exit();
  25:	e8 48 04 00 00       	call   472 <exit>
  2a:	66 90                	xchg   %ax,%ax
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <printSomthing>:
int printSomthing(){
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	83 ec 10             	sub    $0x10,%esp
    printf(1,"\n HELLO \n");
  36:	68 38 09 00 00       	push   $0x938
  3b:	6a 01                	push   $0x1
  3d:	e8 9e 05 00 00       	call   5e0 <printf>
    a=2;
  42:	c7 05 58 0d 00 00 02 	movl   $0x2,0xd58
  49:	00 00 00 
    kthread_exit();
  4c:	e8 d1 04 00 00       	call   522 <kthread_exit>
}
  51:	31 c0                	xor    %eax,%eax
  53:	c9                   	leave  
  54:	c3                   	ret    
  55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000060 <run>:
run(){
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
	int id = kthread_id();
  65:	e8 b0 04 00 00       	call   51a <kthread_id>
  6a:	89 c6                	mov    %eax,%esi
	int pid = getpid();
  6c:	e8 81 04 00 00       	call   4f2 <getpid>
	printf(1, "my id: %d\n", id);
  71:	83 ec 04             	sub    $0x4,%esp
	int pid = getpid();
  74:	89 c3                	mov    %eax,%ebx
	printf(1, "my id: %d\n", id);
  76:	56                   	push   %esi
  77:	68 42 09 00 00       	push   $0x942
  7c:	6a 01                	push   $0x1
  7e:	e8 5d 05 00 00       	call   5e0 <printf>
	printf(1,"my pid: %d\n", pid);
  83:	83 c4 0c             	add    $0xc,%esp
  86:	53                   	push   %ebx
  87:	68 4d 09 00 00       	push   $0x94d
  8c:	6a 01                	push   $0x1
  8e:	e8 4d 05 00 00       	call   5e0 <printf>
	printf(1,"hey\n");
  93:	58                   	pop    %eax
  94:	5a                   	pop    %edx
  95:	68 59 09 00 00       	push   $0x959
  9a:	6a 01                	push   $0x1
  9c:	e8 3f 05 00 00       	call   5e0 <printf>
	kthread_exit();
  a1:	83 c4 10             	add    $0x10,%esp
}
  a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  a7:	5b                   	pop    %ebx
  a8:	5e                   	pop    %esi
  a9:	5d                   	pop    %ebp
	kthread_exit();
  aa:	e9 73 04 00 00       	jmp    522 <kthread_exit>
  af:	90                   	nop

000000b0 <test_kthread_create>:
void test_kthread_create(){
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	56                   	push   %esi
  b4:	53                   	push   %ebx
    char* ustack = (char*)malloc(4000);
  b5:	83 ec 0c             	sub    $0xc,%esp
  b8:	68 a0 0f 00 00       	push   $0xfa0
  bd:	e8 7e 07 00 00       	call   840 <malloc>
    printf(1, "a=%d\n",a);
  c2:	83 c4 0c             	add    $0xc,%esp
  c5:	ff 35 58 0d 00 00    	pushl  0xd58
    char* ustack = (char*)malloc(4000);
  cb:	89 c3                	mov    %eax,%ebx
    printf(1, "a=%d\n",a);
  cd:	68 5e 09 00 00       	push   $0x95e
  d2:	6a 01                	push   $0x1
  d4:	e8 07 05 00 00       	call   5e0 <printf>
    int tid = kthread_create((void*)&printSomthing, ustack);
  d9:	58                   	pop    %eax
  da:	5a                   	pop    %edx
  db:	53                   	push   %ebx
  dc:	68 30 00 00 00       	push   $0x30
  e1:	e8 2c 04 00 00       	call   512 <kthread_create>
    sleep(50);
  e6:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    int tid = kthread_create((void*)&printSomthing, ustack);
  ed:	89 c6                	mov    %eax,%esi
    sleep(50);
  ef:	e8 0e 04 00 00       	call   502 <sleep>
    free(ustack);
  f4:	89 1c 24             	mov    %ebx,(%esp)
  f7:	e8 b4 06 00 00       	call   7b0 <free>
    printf(1, "created thread %d\n", tid);
  fc:	83 c4 0c             	add    $0xc,%esp
  ff:	56                   	push   %esi
 100:	68 64 09 00 00       	push   $0x964
 105:	6a 01                	push   $0x1
 107:	e8 d4 04 00 00       	call   5e0 <printf>
    printf(1, "a=%d\n",a);
 10c:	83 c4 0c             	add    $0xc,%esp
 10f:	ff 35 58 0d 00 00    	pushl  0xd58
 115:	68 5e 09 00 00       	push   $0x95e
 11a:	6a 01                	push   $0x1
 11c:	e8 bf 04 00 00       	call   5e0 <printf>
    return;
 121:	83 c4 10             	add    $0x10,%esp
}
 124:	8d 65 f8             	lea    -0x8(%ebp),%esp
 127:	5b                   	pop    %ebx
 128:	5e                   	pop    %esi
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    
 12b:	90                   	nop
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000130 <test_kthread_exit>:
void test_kthread_exit(){
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	83 ec 08             	sub    $0x8,%esp
    int tid = kthread_id();
 136:	e8 df 03 00 00       	call   51a <kthread_id>
    printf(1, "thread id: %d\n", tid);
 13b:	83 ec 04             	sub    $0x4,%esp
 13e:	50                   	push   %eax
 13f:	68 77 09 00 00       	push   $0x977
 144:	6a 01                	push   $0x1
 146:	e8 95 04 00 00       	call   5e0 <printf>
    kthread_exit();
 14b:	83 c4 10             	add    $0x10,%esp
}
 14e:	c9                   	leave  
    kthread_exit();
 14f:	e9 ce 03 00 00       	jmp    522 <kthread_exit>
 154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 15a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000160 <test>:
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	53                   	push   %ebx
 164:	83 ec 10             	sub    $0x10,%esp
	void* stack = (void*)malloc(4000);
 167:	68 a0 0f 00 00       	push   $0xfa0
 16c:	e8 cf 06 00 00       	call   840 <malloc>
 171:	89 c3                	mov    %eax,%ebx
	int pid = getpid();
 173:	e8 7a 03 00 00       	call   4f2 <getpid>
	printf(1, "main pid: %d\n",pid);
 178:	83 c4 0c             	add    $0xc,%esp
 17b:	50                   	push   %eax
 17c:	68 86 09 00 00       	push   $0x986
 181:	6a 01                	push   $0x1
 183:	e8 58 04 00 00       	call   5e0 <printf>
	int tid = kthread_create(&run, stack);
 188:	58                   	pop    %eax
 189:	5a                   	pop    %edx
 18a:	53                   	push   %ebx
 18b:	68 60 00 00 00       	push   $0x60
 190:	e8 7d 03 00 00       	call   512 <kthread_create>
	printf(1, "tid: %d\n", tid);
 195:	83 c4 0c             	add    $0xc,%esp
 198:	50                   	push   %eax
 199:	68 9a 09 00 00       	push   $0x99a
 19e:	6a 01                	push   $0x1
 1a0:	e8 3b 04 00 00       	call   5e0 <printf>
	exit();
 1a5:	e8 c8 02 00 00       	call   472 <exit>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <test_kthread_join>:
void test_kthread_join(){
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 1b9:	83 ec 04             	sub    $0x4,%esp
    int pid = fork();
 1bc:	e8 a9 02 00 00       	call   46a <fork>
    if(pid == 0){
 1c1:	85 c0                	test   %eax,%eax
 1c3:	75 1f                	jne    1e4 <test_kthread_join+0x34>
        tid = kthread_id();
 1c5:	e8 50 03 00 00       	call   51a <kthread_id>
        printf(1, "child tid: %d\n", tid);
 1ca:	83 ec 04             	sub    $0x4,%esp
        tid = kthread_id();
 1cd:	89 c3                	mov    %eax,%ebx
        printf(1, "child tid: %d\n", tid);
 1cf:	50                   	push   %eax
 1d0:	68 94 09 00 00       	push   $0x994
 1d5:	6a 01                	push   $0x1
 1d7:	e8 04 04 00 00       	call   5e0 <printf>
        kthread_exit();
 1dc:	e8 41 03 00 00       	call   522 <kthread_exit>
 1e1:	83 c4 10             	add    $0x10,%esp
    wait();
 1e4:	e8 91 02 00 00       	call   47a <wait>
    printf(1, "parent tid: %d\n", tid);
 1e9:	83 ec 04             	sub    $0x4,%esp
 1ec:	53                   	push   %ebx
 1ed:	68 a3 09 00 00       	push   $0x9a3
 1f2:	6a 01                	push   $0x1
 1f4:	e8 e7 03 00 00       	call   5e0 <printf>
    kthread_join(tid);
 1f9:	89 1c 24             	mov    %ebx,(%esp)
 1fc:	e8 29 03 00 00       	call   52a <kthread_join>
    return;
 201:	83 c4 10             	add    $0x10,%esp
}
 204:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 207:	c9                   	leave  
 208:	c3                   	ret    
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <createThreadsTest>:
int createThreadsTest(){
 210:	55                   	push   %ebp
}
 211:	b8 01 00 00 00       	mov    $0x1,%eax
int createThreadsTest(){
 216:	89 e5                	mov    %esp,%ebp
}
 218:	5d                   	pop    %ebp
 219:	c3                   	ret    
 21a:	66 90                	xchg   %ax,%ax
 21c:	66 90                	xchg   %ax,%ax
 21e:	66 90                	xchg   %ax,%ax

00000220 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 22a:	89 c2                	mov    %eax,%edx
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 230:	83 c1 01             	add    $0x1,%ecx
 233:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 237:	83 c2 01             	add    $0x1,%edx
 23a:	84 db                	test   %bl,%bl
 23c:	88 5a ff             	mov    %bl,-0x1(%edx)
 23f:	75 ef                	jne    230 <strcpy+0x10>
    ;
  return os;
}
 241:	5b                   	pop    %ebx
 242:	5d                   	pop    %ebp
 243:	c3                   	ret    
 244:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 24a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000250 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 55 08             	mov    0x8(%ebp),%edx
 257:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 25a:	0f b6 02             	movzbl (%edx),%eax
 25d:	0f b6 19             	movzbl (%ecx),%ebx
 260:	84 c0                	test   %al,%al
 262:	75 1c                	jne    280 <strcmp+0x30>
 264:	eb 2a                	jmp    290 <strcmp+0x40>
 266:	8d 76 00             	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 270:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 273:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 276:	83 c1 01             	add    $0x1,%ecx
 279:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 27c:	84 c0                	test   %al,%al
 27e:	74 10                	je     290 <strcmp+0x40>
 280:	38 d8                	cmp    %bl,%al
 282:	74 ec                	je     270 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 284:	29 d8                	sub    %ebx,%eax
}
 286:	5b                   	pop    %ebx
 287:	5d                   	pop    %ebp
 288:	c3                   	ret    
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 290:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 292:	29 d8                	sub    %ebx,%eax
}
 294:	5b                   	pop    %ebx
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <strlen>:

uint
strlen(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2a6:	80 39 00             	cmpb   $0x0,(%ecx)
 2a9:	74 15                	je     2c0 <strlen+0x20>
 2ab:	31 d2                	xor    %edx,%edx
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2b7:	89 d0                	mov    %edx,%eax
 2b9:	75 f5                	jne    2b0 <strlen+0x10>
    ;
  return n;
}
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 2c0:	31 c0                	xor    %eax,%eax
}
 2c2:	5d                   	pop    %ebp
 2c3:	c3                   	ret    
 2c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 d7                	mov    %edx,%edi
 2df:	fc                   	cld    
 2e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2e2:	89 d0                	mov    %edx,%eax
 2e4:	5f                   	pop    %edi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <strchr>:

char*
strchr(const char *s, char c)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 45 08             	mov    0x8(%ebp),%eax
 2f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2fa:	0f b6 10             	movzbl (%eax),%edx
 2fd:	84 d2                	test   %dl,%dl
 2ff:	74 1d                	je     31e <strchr+0x2e>
    if(*s == c)
 301:	38 d3                	cmp    %dl,%bl
 303:	89 d9                	mov    %ebx,%ecx
 305:	75 0d                	jne    314 <strchr+0x24>
 307:	eb 17                	jmp    320 <strchr+0x30>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 310:	38 ca                	cmp    %cl,%dl
 312:	74 0c                	je     320 <strchr+0x30>
  for(; *s; s++)
 314:	83 c0 01             	add    $0x1,%eax
 317:	0f b6 10             	movzbl (%eax),%edx
 31a:	84 d2                	test   %dl,%dl
 31c:	75 f2                	jne    310 <strchr+0x20>
      return (char*)s;
  return 0;
 31e:	31 c0                	xor    %eax,%eax
}
 320:	5b                   	pop    %ebx
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
 323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <gets>:

char*
gets(char *buf, int max)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 336:	31 f6                	xor    %esi,%esi
 338:	89 f3                	mov    %esi,%ebx
{
 33a:	83 ec 1c             	sub    $0x1c,%esp
 33d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 340:	eb 2f                	jmp    371 <gets+0x41>
 342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 348:	8d 45 e7             	lea    -0x19(%ebp),%eax
 34b:	83 ec 04             	sub    $0x4,%esp
 34e:	6a 01                	push   $0x1
 350:	50                   	push   %eax
 351:	6a 00                	push   $0x0
 353:	e8 32 01 00 00       	call   48a <read>
    if(cc < 1)
 358:	83 c4 10             	add    $0x10,%esp
 35b:	85 c0                	test   %eax,%eax
 35d:	7e 1c                	jle    37b <gets+0x4b>
      break;
    buf[i++] = c;
 35f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 363:	83 c7 01             	add    $0x1,%edi
 366:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 369:	3c 0a                	cmp    $0xa,%al
 36b:	74 23                	je     390 <gets+0x60>
 36d:	3c 0d                	cmp    $0xd,%al
 36f:	74 1f                	je     390 <gets+0x60>
  for(i=0; i+1 < max; ){
 371:	83 c3 01             	add    $0x1,%ebx
 374:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 377:	89 fe                	mov    %edi,%esi
 379:	7c cd                	jl     348 <gets+0x18>
 37b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 37d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 380:	c6 03 00             	movb   $0x0,(%ebx)
}
 383:	8d 65 f4             	lea    -0xc(%ebp),%esp
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret    
 38b:	90                   	nop
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 390:	8b 75 08             	mov    0x8(%ebp),%esi
 393:	8b 45 08             	mov    0x8(%ebp),%eax
 396:	01 de                	add    %ebx,%esi
 398:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 39a:	c6 03 00             	movb   $0x0,(%ebx)
}
 39d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3a0:	5b                   	pop    %ebx
 3a1:	5e                   	pop    %esi
 3a2:	5f                   	pop    %edi
 3a3:	5d                   	pop    %ebp
 3a4:	c3                   	ret    
 3a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	56                   	push   %esi
 3b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b5:	83 ec 08             	sub    $0x8,%esp
 3b8:	6a 00                	push   $0x0
 3ba:	ff 75 08             	pushl  0x8(%ebp)
 3bd:	e8 f0 00 00 00       	call   4b2 <open>
  if(fd < 0)
 3c2:	83 c4 10             	add    $0x10,%esp
 3c5:	85 c0                	test   %eax,%eax
 3c7:	78 27                	js     3f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3c9:	83 ec 08             	sub    $0x8,%esp
 3cc:	ff 75 0c             	pushl  0xc(%ebp)
 3cf:	89 c3                	mov    %eax,%ebx
 3d1:	50                   	push   %eax
 3d2:	e8 f3 00 00 00       	call   4ca <fstat>
  close(fd);
 3d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3da:	89 c6                	mov    %eax,%esi
  close(fd);
 3dc:	e8 b9 00 00 00       	call   49a <close>
  return r;
 3e1:	83 c4 10             	add    $0x10,%esp
}
 3e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3e7:	89 f0                	mov    %esi,%eax
 3e9:	5b                   	pop    %ebx
 3ea:	5e                   	pop    %esi
 3eb:	5d                   	pop    %ebp
 3ec:	c3                   	ret    
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3f5:	eb ed                	jmp    3e4 <stat+0x34>
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <atoi>:

int
atoi(const char *s)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 407:	0f be 11             	movsbl (%ecx),%edx
 40a:	8d 42 d0             	lea    -0x30(%edx),%eax
 40d:	3c 09                	cmp    $0x9,%al
  n = 0;
 40f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 414:	77 1f                	ja     435 <atoi+0x35>
 416:	8d 76 00             	lea    0x0(%esi),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 420:	8d 04 80             	lea    (%eax,%eax,4),%eax
 423:	83 c1 01             	add    $0x1,%ecx
 426:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 42a:	0f be 11             	movsbl (%ecx),%edx
 42d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 430:	80 fb 09             	cmp    $0x9,%bl
 433:	76 eb                	jbe    420 <atoi+0x20>
  return n;
}
 435:	5b                   	pop    %ebx
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    
 438:	90                   	nop
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000440 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	56                   	push   %esi
 444:	53                   	push   %ebx
 445:	8b 5d 10             	mov    0x10(%ebp),%ebx
 448:	8b 45 08             	mov    0x8(%ebp),%eax
 44b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 44e:	85 db                	test   %ebx,%ebx
 450:	7e 14                	jle    466 <memmove+0x26>
 452:	31 d2                	xor    %edx,%edx
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 458:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 45c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 45f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 462:	39 d3                	cmp    %edx,%ebx
 464:	75 f2                	jne    458 <memmove+0x18>
  return vdst;
}
 466:	5b                   	pop    %ebx
 467:	5e                   	pop    %esi
 468:	5d                   	pop    %ebp
 469:	c3                   	ret    

0000046a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 46a:	b8 01 00 00 00       	mov    $0x1,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <exit>:
SYSCALL(exit)
 472:	b8 02 00 00 00       	mov    $0x2,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <wait>:
SYSCALL(wait)
 47a:	b8 03 00 00 00       	mov    $0x3,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <pipe>:
SYSCALL(pipe)
 482:	b8 04 00 00 00       	mov    $0x4,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <read>:
SYSCALL(read)
 48a:	b8 05 00 00 00       	mov    $0x5,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <write>:
SYSCALL(write)
 492:	b8 10 00 00 00       	mov    $0x10,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <close>:
SYSCALL(close)
 49a:	b8 15 00 00 00       	mov    $0x15,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <kill>:
SYSCALL(kill)
 4a2:	b8 06 00 00 00       	mov    $0x6,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <exec>:
SYSCALL(exec)
 4aa:	b8 07 00 00 00       	mov    $0x7,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <open>:
SYSCALL(open)
 4b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <mknod>:
SYSCALL(mknod)
 4ba:	b8 11 00 00 00       	mov    $0x11,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <unlink>:
SYSCALL(unlink)
 4c2:	b8 12 00 00 00       	mov    $0x12,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <fstat>:
SYSCALL(fstat)
 4ca:	b8 08 00 00 00       	mov    $0x8,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <link>:
SYSCALL(link)
 4d2:	b8 13 00 00 00       	mov    $0x13,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <mkdir>:
SYSCALL(mkdir)
 4da:	b8 14 00 00 00       	mov    $0x14,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <chdir>:
SYSCALL(chdir)
 4e2:	b8 09 00 00 00       	mov    $0x9,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <dup>:
SYSCALL(dup)
 4ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <getpid>:
SYSCALL(getpid)
 4f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <sbrk>:
SYSCALL(sbrk)
 4fa:	b8 0c 00 00 00       	mov    $0xc,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <sleep>:
SYSCALL(sleep)
 502:	b8 0d 00 00 00       	mov    $0xd,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <uptime>:
SYSCALL(uptime)
 50a:	b8 0e 00 00 00       	mov    $0xe,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <kthread_create>:
SYSCALL(kthread_create)
 512:	b8 16 00 00 00       	mov    $0x16,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <kthread_id>:
SYSCALL(kthread_id)
 51a:	b8 17 00 00 00       	mov    $0x17,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <kthread_exit>:
SYSCALL(kthread_exit)
 522:	b8 18 00 00 00       	mov    $0x18,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <kthread_join>:
SYSCALL(kthread_join)
 52a:	b8 19 00 00 00       	mov    $0x19,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    
 532:	66 90                	xchg   %ax,%ax
 534:	66 90                	xchg   %ax,%ax
 536:	66 90                	xchg   %ax,%ax
 538:	66 90                	xchg   %ax,%ax
 53a:	66 90                	xchg   %ax,%ax
 53c:	66 90                	xchg   %ax,%ax
 53e:	66 90                	xchg   %ax,%ax

00000540 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 549:	85 d2                	test   %edx,%edx
{
 54b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 54e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 550:	79 76                	jns    5c8 <printint+0x88>
 552:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 556:	74 70                	je     5c8 <printint+0x88>
    x = -xx;
 558:	f7 d8                	neg    %eax
    neg = 1;
 55a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 561:	31 f6                	xor    %esi,%esi
 563:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 566:	eb 0a                	jmp    572 <printint+0x32>
 568:	90                   	nop
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 570:	89 fe                	mov    %edi,%esi
 572:	31 d2                	xor    %edx,%edx
 574:	8d 7e 01             	lea    0x1(%esi),%edi
 577:	f7 f1                	div    %ecx
 579:	0f b6 92 c4 09 00 00 	movzbl 0x9c4(%edx),%edx
  }while((x /= base) != 0);
 580:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 582:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 585:	75 e9                	jne    570 <printint+0x30>
  if(neg)
 587:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 58a:	85 c0                	test   %eax,%eax
 58c:	74 08                	je     596 <printint+0x56>
    buf[i++] = '-';
 58e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 593:	8d 7e 02             	lea    0x2(%esi),%edi
 596:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 59a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
 5a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
 5a6:	83 ee 01             	sub    $0x1,%esi
 5a9:	6a 01                	push   $0x1
 5ab:	53                   	push   %ebx
 5ac:	57                   	push   %edi
 5ad:	88 45 d7             	mov    %al,-0x29(%ebp)
 5b0:	e8 dd fe ff ff       	call   492 <write>

  while(--i >= 0)
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	39 de                	cmp    %ebx,%esi
 5ba:	75 e4                	jne    5a0 <printint+0x60>
    putc(fd, buf[i]);
}
 5bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bf:	5b                   	pop    %ebx
 5c0:	5e                   	pop    %esi
 5c1:	5f                   	pop    %edi
 5c2:	5d                   	pop    %ebp
 5c3:	c3                   	ret    
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5c8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5cf:	eb 90                	jmp    561 <printint+0x21>
 5d1:	eb 0d                	jmp    5e0 <printf>
 5d3:	90                   	nop
 5d4:	90                   	nop
 5d5:	90                   	nop
 5d6:	90                   	nop
 5d7:	90                   	nop
 5d8:	90                   	nop
 5d9:	90                   	nop
 5da:	90                   	nop
 5db:	90                   	nop
 5dc:	90                   	nop
 5dd:	90                   	nop
 5de:	90                   	nop
 5df:	90                   	nop

000005e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5ec:	0f b6 1e             	movzbl (%esi),%ebx
 5ef:	84 db                	test   %bl,%bl
 5f1:	0f 84 b3 00 00 00    	je     6aa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 5f7:	8d 45 10             	lea    0x10(%ebp),%eax
 5fa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 5fd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 5ff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 602:	eb 2f                	jmp    633 <printf+0x53>
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 608:	83 f8 25             	cmp    $0x25,%eax
 60b:	0f 84 a7 00 00 00    	je     6b8 <printf+0xd8>
  write(fd, &c, 1);
 611:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 614:	83 ec 04             	sub    $0x4,%esp
 617:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 61a:	6a 01                	push   $0x1
 61c:	50                   	push   %eax
 61d:	ff 75 08             	pushl  0x8(%ebp)
 620:	e8 6d fe ff ff       	call   492 <write>
 625:	83 c4 10             	add    $0x10,%esp
 628:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 62b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 62f:	84 db                	test   %bl,%bl
 631:	74 77                	je     6aa <printf+0xca>
    if(state == 0){
 633:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 635:	0f be cb             	movsbl %bl,%ecx
 638:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 63b:	74 cb                	je     608 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 63d:	83 ff 25             	cmp    $0x25,%edi
 640:	75 e6                	jne    628 <printf+0x48>
      if(c == 'd'){
 642:	83 f8 64             	cmp    $0x64,%eax
 645:	0f 84 05 01 00 00    	je     750 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 64b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 651:	83 f9 70             	cmp    $0x70,%ecx
 654:	74 72                	je     6c8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 656:	83 f8 73             	cmp    $0x73,%eax
 659:	0f 84 99 00 00 00    	je     6f8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65f:	83 f8 63             	cmp    $0x63,%eax
 662:	0f 84 08 01 00 00    	je     770 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 668:	83 f8 25             	cmp    $0x25,%eax
 66b:	0f 84 ef 00 00 00    	je     760 <printf+0x180>
  write(fd, &c, 1);
 671:	8d 45 e7             	lea    -0x19(%ebp),%eax
 674:	83 ec 04             	sub    $0x4,%esp
 677:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 67b:	6a 01                	push   $0x1
 67d:	50                   	push   %eax
 67e:	ff 75 08             	pushl  0x8(%ebp)
 681:	e8 0c fe ff ff       	call   492 <write>
 686:	83 c4 0c             	add    $0xc,%esp
 689:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 68c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 68f:	6a 01                	push   $0x1
 691:	50                   	push   %eax
 692:	ff 75 08             	pushl  0x8(%ebp)
 695:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 698:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 69a:	e8 f3 fd ff ff       	call   492 <write>
  for(i = 0; fmt[i]; i++){
 69f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 6a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6a6:	84 db                	test   %bl,%bl
 6a8:	75 89                	jne    633 <printf+0x53>
    }
  }
}
 6aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ad:	5b                   	pop    %ebx
 6ae:	5e                   	pop    %esi
 6af:	5f                   	pop    %edi
 6b0:	5d                   	pop    %ebp
 6b1:	c3                   	ret    
 6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 6b8:	bf 25 00 00 00       	mov    $0x25,%edi
 6bd:	e9 66 ff ff ff       	jmp    628 <printf+0x48>
 6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6c8:	83 ec 0c             	sub    $0xc,%esp
 6cb:	b9 10 00 00 00       	mov    $0x10,%ecx
 6d0:	6a 00                	push   $0x0
 6d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6d5:	8b 45 08             	mov    0x8(%ebp),%eax
 6d8:	8b 17                	mov    (%edi),%edx
 6da:	e8 61 fe ff ff       	call   540 <printint>
        ap++;
 6df:	89 f8                	mov    %edi,%eax
 6e1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6e4:	31 ff                	xor    %edi,%edi
        ap++;
 6e6:	83 c0 04             	add    $0x4,%eax
 6e9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6ec:	e9 37 ff ff ff       	jmp    628 <printf+0x48>
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6fb:	8b 08                	mov    (%eax),%ecx
        ap++;
 6fd:	83 c0 04             	add    $0x4,%eax
 700:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 703:	85 c9                	test   %ecx,%ecx
 705:	0f 84 8e 00 00 00    	je     799 <printf+0x1b9>
        while(*s != 0){
 70b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 70e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 710:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 712:	84 c0                	test   %al,%al
 714:	0f 84 0e ff ff ff    	je     628 <printf+0x48>
 71a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 71d:	89 de                	mov    %ebx,%esi
 71f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 722:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 725:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 728:	83 ec 04             	sub    $0x4,%esp
          s++;
 72b:	83 c6 01             	add    $0x1,%esi
 72e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 731:	6a 01                	push   $0x1
 733:	57                   	push   %edi
 734:	53                   	push   %ebx
 735:	e8 58 fd ff ff       	call   492 <write>
        while(*s != 0){
 73a:	0f b6 06             	movzbl (%esi),%eax
 73d:	83 c4 10             	add    $0x10,%esp
 740:	84 c0                	test   %al,%al
 742:	75 e4                	jne    728 <printf+0x148>
 744:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 747:	31 ff                	xor    %edi,%edi
 749:	e9 da fe ff ff       	jmp    628 <printf+0x48>
 74e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	b9 0a 00 00 00       	mov    $0xa,%ecx
 758:	6a 01                	push   $0x1
 75a:	e9 73 ff ff ff       	jmp    6d2 <printf+0xf2>
 75f:	90                   	nop
  write(fd, &c, 1);
 760:	83 ec 04             	sub    $0x4,%esp
 763:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 766:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 769:	6a 01                	push   $0x1
 76b:	e9 21 ff ff ff       	jmp    691 <printf+0xb1>
        putc(fd, *ap);
 770:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 773:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 776:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 778:	6a 01                	push   $0x1
        ap++;
 77a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 77d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 780:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 783:	50                   	push   %eax
 784:	ff 75 08             	pushl  0x8(%ebp)
 787:	e8 06 fd ff ff       	call   492 <write>
        ap++;
 78c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 78f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 792:	31 ff                	xor    %edi,%edi
 794:	e9 8f fe ff ff       	jmp    628 <printf+0x48>
          s = "(null)";
 799:	bb bb 09 00 00       	mov    $0x9bb,%ebx
        while(*s != 0){
 79e:	b8 28 00 00 00       	mov    $0x28,%eax
 7a3:	e9 72 ff ff ff       	jmp    71a <printf+0x13a>
 7a8:	66 90                	xchg   %ax,%ax
 7aa:	66 90                	xchg   %ax,%ax
 7ac:	66 90                	xchg   %ax,%ax
 7ae:	66 90                	xchg   %ax,%ax

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	a1 5c 0d 00 00       	mov    0xd5c,%eax
{
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	57                   	push   %edi
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 7be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c8:	39 c8                	cmp    %ecx,%eax
 7ca:	8b 10                	mov    (%eax),%edx
 7cc:	73 32                	jae    800 <free+0x50>
 7ce:	39 d1                	cmp    %edx,%ecx
 7d0:	72 04                	jb     7d6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d2:	39 d0                	cmp    %edx,%eax
 7d4:	72 32                	jb     808 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7dc:	39 fa                	cmp    %edi,%edx
 7de:	74 30                	je     810 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7e3:	8b 50 04             	mov    0x4(%eax),%edx
 7e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7e9:	39 f1                	cmp    %esi,%ecx
 7eb:	74 3a                	je     827 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7ed:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7ef:	a3 5c 0d 00 00       	mov    %eax,0xd5c
}
 7f4:	5b                   	pop    %ebx
 7f5:	5e                   	pop    %esi
 7f6:	5f                   	pop    %edi
 7f7:	5d                   	pop    %ebp
 7f8:	c3                   	ret    
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 800:	39 d0                	cmp    %edx,%eax
 802:	72 04                	jb     808 <free+0x58>
 804:	39 d1                	cmp    %edx,%ecx
 806:	72 ce                	jb     7d6 <free+0x26>
{
 808:	89 d0                	mov    %edx,%eax
 80a:	eb bc                	jmp    7c8 <free+0x18>
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 810:	03 72 04             	add    0x4(%edx),%esi
 813:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 816:	8b 10                	mov    (%eax),%edx
 818:	8b 12                	mov    (%edx),%edx
 81a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 81d:	8b 50 04             	mov    0x4(%eax),%edx
 820:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 823:	39 f1                	cmp    %esi,%ecx
 825:	75 c6                	jne    7ed <free+0x3d>
    p->s.size += bp->s.size;
 827:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 82a:	a3 5c 0d 00 00       	mov    %eax,0xd5c
    p->s.size += bp->s.size;
 82f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 832:	8b 53 f8             	mov    -0x8(%ebx),%edx
 835:	89 10                	mov    %edx,(%eax)
}
 837:	5b                   	pop    %ebx
 838:	5e                   	pop    %esi
 839:	5f                   	pop    %edi
 83a:	5d                   	pop    %ebp
 83b:	c3                   	ret    
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 84c:	8b 15 5c 0d 00 00    	mov    0xd5c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 852:	8d 78 07             	lea    0x7(%eax),%edi
 855:	c1 ef 03             	shr    $0x3,%edi
 858:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 85b:	85 d2                	test   %edx,%edx
 85d:	0f 84 9d 00 00 00    	je     900 <malloc+0xc0>
 863:	8b 02                	mov    (%edx),%eax
 865:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 868:	39 cf                	cmp    %ecx,%edi
 86a:	76 6c                	jbe    8d8 <malloc+0x98>
 86c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 872:	bb 00 10 00 00       	mov    $0x1000,%ebx
 877:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 87a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 881:	eb 0e                	jmp    891 <malloc+0x51>
 883:	90                   	nop
 884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 888:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 88a:	8b 48 04             	mov    0x4(%eax),%ecx
 88d:	39 f9                	cmp    %edi,%ecx
 88f:	73 47                	jae    8d8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 891:	39 05 5c 0d 00 00    	cmp    %eax,0xd5c
 897:	89 c2                	mov    %eax,%edx
 899:	75 ed                	jne    888 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 89b:	83 ec 0c             	sub    $0xc,%esp
 89e:	56                   	push   %esi
 89f:	e8 56 fc ff ff       	call   4fa <sbrk>
  if(p == (char*)-1)
 8a4:	83 c4 10             	add    $0x10,%esp
 8a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8aa:	74 1c                	je     8c8 <malloc+0x88>
  hp->s.size = nu;
 8ac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8af:	83 ec 0c             	sub    $0xc,%esp
 8b2:	83 c0 08             	add    $0x8,%eax
 8b5:	50                   	push   %eax
 8b6:	e8 f5 fe ff ff       	call   7b0 <free>
  return freep;
 8bb:	8b 15 5c 0d 00 00    	mov    0xd5c,%edx
      if((p = morecore(nunits)) == 0)
 8c1:	83 c4 10             	add    $0x10,%esp
 8c4:	85 d2                	test   %edx,%edx
 8c6:	75 c0                	jne    888 <malloc+0x48>
        return 0;
  }
}
 8c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8cb:	31 c0                	xor    %eax,%eax
}
 8cd:	5b                   	pop    %ebx
 8ce:	5e                   	pop    %esi
 8cf:	5f                   	pop    %edi
 8d0:	5d                   	pop    %ebp
 8d1:	c3                   	ret    
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8d8:	39 cf                	cmp    %ecx,%edi
 8da:	74 54                	je     930 <malloc+0xf0>
        p->s.size -= nunits;
 8dc:	29 f9                	sub    %edi,%ecx
 8de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8e7:	89 15 5c 0d 00 00    	mov    %edx,0xd5c
}
 8ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8f0:	83 c0 08             	add    $0x8,%eax
}
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
 8f8:	90                   	nop
 8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 900:	c7 05 5c 0d 00 00 60 	movl   $0xd60,0xd5c
 907:	0d 00 00 
 90a:	c7 05 60 0d 00 00 60 	movl   $0xd60,0xd60
 911:	0d 00 00 
    base.s.size = 0;
 914:	b8 60 0d 00 00       	mov    $0xd60,%eax
 919:	c7 05 64 0d 00 00 00 	movl   $0x0,0xd64
 920:	00 00 00 
 923:	e9 44 ff ff ff       	jmp    86c <malloc+0x2c>
 928:	90                   	nop
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 930:	8b 08                	mov    (%eax),%ecx
 932:	89 0a                	mov    %ecx,(%edx)
 934:	eb b1                	jmp    8e7 <malloc+0xa7>
