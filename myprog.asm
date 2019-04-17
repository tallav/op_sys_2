
_myprog:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return;
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
  11:	e8 8a 00 00 00       	call   a0 <test_kthread_create>
    //test_kthread_join();
    //test();
    printf(1, "finish\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 6d 09 00 00       	push   $0x96d
  1e:	6a 01                	push   $0x1
  20:	e8 7b 05 00 00       	call   5a0 <printf>
    exit();
  25:	e8 08 04 00 00       	call   432 <exit>
  2a:	66 90                	xchg   %ax,%ax
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <printSomthing>:
int printSomthing(){
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	83 ec 10             	sub    $0x10,%esp
    printf(1,"\n HELLO \n");
  36:	68 f8 08 00 00       	push   $0x8f8
  3b:	6a 01                	push   $0x1
  3d:	e8 5e 05 00 00       	call   5a0 <printf>
}
  42:	31 c0                	xor    %eax,%eax
  44:	c9                   	leave  
  45:	c3                   	ret    
  46:	8d 76 00             	lea    0x0(%esi),%esi
  49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000050 <run>:
run(){
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
	int id = kthread_id();
  55:	e8 80 04 00 00       	call   4da <kthread_id>
  5a:	89 c6                	mov    %eax,%esi
	int pid = getpid();
  5c:	e8 51 04 00 00       	call   4b2 <getpid>
	printf(1, "my id: %d\n", id);
  61:	83 ec 04             	sub    $0x4,%esp
	int pid = getpid();
  64:	89 c3                	mov    %eax,%ebx
	printf(1, "my id: %d\n", id);
  66:	56                   	push   %esi
  67:	68 02 09 00 00       	push   $0x902
  6c:	6a 01                	push   $0x1
  6e:	e8 2d 05 00 00       	call   5a0 <printf>
	printf(1,"my pid: %d\n", pid);
  73:	83 c4 0c             	add    $0xc,%esp
  76:	53                   	push   %ebx
  77:	68 0d 09 00 00       	push   $0x90d
  7c:	6a 01                	push   $0x1
  7e:	e8 1d 05 00 00       	call   5a0 <printf>
	printf(1,"hey\n");
  83:	58                   	pop    %eax
  84:	5a                   	pop    %edx
  85:	68 19 09 00 00       	push   $0x919
  8a:	6a 01                	push   $0x1
  8c:	e8 0f 05 00 00       	call   5a0 <printf>
	kthread_exit();
  91:	83 c4 10             	add    $0x10,%esp
}
  94:	8d 65 f8             	lea    -0x8(%ebp),%esp
  97:	5b                   	pop    %ebx
  98:	5e                   	pop    %esi
  99:	5d                   	pop    %ebp
	kthread_exit();
  9a:	e9 43 04 00 00       	jmp    4e2 <kthread_exit>
  9f:	90                   	nop

000000a0 <test_kthread_create>:
void test_kthread_create(){
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	56                   	push   %esi
  a4:	53                   	push   %ebx
    char* ustack = (char*)malloc(4000);
  a5:	83 ec 0c             	sub    $0xc,%esp
  a8:	68 a0 0f 00 00       	push   $0xfa0
  ad:	e8 4e 07 00 00       	call   800 <malloc>
  b2:	89 c3                	mov    %eax,%ebx
    int tid = kthread_create(&printSomthing, ustack);
  b4:	58                   	pop    %eax
  b5:	5a                   	pop    %edx
  b6:	53                   	push   %ebx
  b7:	68 30 00 00 00       	push   $0x30
  bc:	e8 11 04 00 00       	call   4d2 <kthread_create>
    sleep(50);
  c1:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    int tid = kthread_create(&printSomthing, ustack);
  c8:	89 c6                	mov    %eax,%esi
    sleep(50);
  ca:	e8 f3 03 00 00       	call   4c2 <sleep>
    free(ustack);
  cf:	89 1c 24             	mov    %ebx,(%esp)
  d2:	e8 99 06 00 00       	call   770 <free>
    printf(1, "created thread %d\n", tid);
  d7:	83 c4 0c             	add    $0xc,%esp
  da:	56                   	push   %esi
  db:	68 1e 09 00 00       	push   $0x91e
  e0:	6a 01                	push   $0x1
  e2:	e8 b9 04 00 00       	call   5a0 <printf>
    kthread_exit();
  e7:	83 c4 10             	add    $0x10,%esp
}
  ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ed:	5b                   	pop    %ebx
  ee:	5e                   	pop    %esi
  ef:	5d                   	pop    %ebp
    kthread_exit();
  f0:	e9 ed 03 00 00       	jmp    4e2 <kthread_exit>
  f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <test_kthread_exit>:
void test_kthread_exit(){
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 08             	sub    $0x8,%esp
    int tid = kthread_id();
 106:	e8 cf 03 00 00       	call   4da <kthread_id>
    printf(1, "thread id: %d\n", tid);
 10b:	83 ec 04             	sub    $0x4,%esp
 10e:	50                   	push   %eax
 10f:	68 31 09 00 00       	push   $0x931
 114:	6a 01                	push   $0x1
 116:	e8 85 04 00 00       	call   5a0 <printf>
    kthread_exit();
 11b:	83 c4 10             	add    $0x10,%esp
}
 11e:	c9                   	leave  
    kthread_exit();
 11f:	e9 be 03 00 00       	jmp    4e2 <kthread_exit>
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <test>:
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	83 ec 10             	sub    $0x10,%esp
	void* stack = (void*)malloc(4000);
 137:	68 a0 0f 00 00       	push   $0xfa0
 13c:	e8 bf 06 00 00       	call   800 <malloc>
 141:	89 c3                	mov    %eax,%ebx
	int pid = getpid();
 143:	e8 6a 03 00 00       	call   4b2 <getpid>
	printf(1, "main pid: %d\n",pid);
 148:	83 c4 0c             	add    $0xc,%esp
 14b:	50                   	push   %eax
 14c:	68 40 09 00 00       	push   $0x940
 151:	6a 01                	push   $0x1
 153:	e8 48 04 00 00       	call   5a0 <printf>
	int tid = kthread_create(&run, stack);
 158:	58                   	pop    %eax
 159:	5a                   	pop    %edx
 15a:	53                   	push   %ebx
 15b:	68 50 00 00 00       	push   $0x50
 160:	e8 6d 03 00 00       	call   4d2 <kthread_create>
	printf(1, "tid: %d\n", tid);
 165:	83 c4 0c             	add    $0xc,%esp
 168:	50                   	push   %eax
 169:	68 54 09 00 00       	push   $0x954
 16e:	6a 01                	push   $0x1
 170:	e8 2b 04 00 00       	call   5a0 <printf>
	exit();
 175:	e8 b8 02 00 00       	call   432 <exit>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <test_kthread_join>:
void test_kthread_join(){
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 189:	83 ec 04             	sub    $0x4,%esp
    int pid = fork();
 18c:	e8 99 02 00 00       	call   42a <fork>
    if(pid == 0){
 191:	85 c0                	test   %eax,%eax
 193:	75 1f                	jne    1b4 <test_kthread_join+0x34>
        tid = kthread_id();
 195:	e8 40 03 00 00       	call   4da <kthread_id>
        printf(1, "child tid: %d\n", tid);
 19a:	83 ec 04             	sub    $0x4,%esp
        tid = kthread_id();
 19d:	89 c3                	mov    %eax,%ebx
        printf(1, "child tid: %d\n", tid);
 19f:	50                   	push   %eax
 1a0:	68 4e 09 00 00       	push   $0x94e
 1a5:	6a 01                	push   $0x1
 1a7:	e8 f4 03 00 00       	call   5a0 <printf>
        kthread_exit();
 1ac:	e8 31 03 00 00       	call   4e2 <kthread_exit>
 1b1:	83 c4 10             	add    $0x10,%esp
    wait();
 1b4:	e8 81 02 00 00       	call   43a <wait>
    printf(1, "parent tid: %d\n", tid);
 1b9:	83 ec 04             	sub    $0x4,%esp
 1bc:	53                   	push   %ebx
 1bd:	68 5d 09 00 00       	push   $0x95d
 1c2:	6a 01                	push   $0x1
 1c4:	e8 d7 03 00 00       	call   5a0 <printf>
    kthread_join(tid);
 1c9:	89 1c 24             	mov    %ebx,(%esp)
 1cc:	e8 19 03 00 00       	call   4ea <kthread_join>
    return;
 1d1:	83 c4 10             	add    $0x10,%esp
}
 1d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1d7:	c9                   	leave  
 1d8:	c3                   	ret    
 1d9:	66 90                	xchg   %ax,%ax
 1db:	66 90                	xchg   %ax,%ax
 1dd:	66 90                	xchg   %ax,%ax
 1df:	90                   	nop

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ea:	89 c2                	mov    %eax,%edx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c1 01             	add    $0x1,%ecx
 1f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1f7:	83 c2 01             	add    $0x1,%edx
 1fa:	84 db                	test   %bl,%bl
 1fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1ff:	75 ef                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 201:	5b                   	pop    %ebx
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 20a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	0f b6 19             	movzbl (%ecx),%ebx
 220:	84 c0                	test   %al,%al
 222:	75 1c                	jne    240 <strcmp+0x30>
 224:	eb 2a                	jmp    250 <strcmp+0x40>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 230:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 233:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 236:	83 c1 01             	add    $0x1,%ecx
 239:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 23c:	84 c0                	test   %al,%al
 23e:	74 10                	je     250 <strcmp+0x40>
 240:	38 d8                	cmp    %bl,%al
 242:	74 ec                	je     230 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 244:	29 d8                	sub    %ebx,%eax
}
 246:	5b                   	pop    %ebx
 247:	5d                   	pop    %ebp
 248:	c3                   	ret    
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 250:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 252:	29 d8                	sub    %ebx,%eax
}
 254:	5b                   	pop    %ebx
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <strlen>:

uint
strlen(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 266:	80 39 00             	cmpb   $0x0,(%ecx)
 269:	74 15                	je     280 <strlen+0x20>
 26b:	31 d2                	xor    %edx,%edx
 26d:	8d 76 00             	lea    0x0(%esi),%esi
 270:	83 c2 01             	add    $0x1,%edx
 273:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 277:	89 d0                	mov    %edx,%eax
 279:	75 f5                	jne    270 <strlen+0x10>
    ;
  return n;
}
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 280:	31 c0                	xor    %eax,%eax
}
 282:	5d                   	pop    %ebp
 283:	c3                   	ret    
 284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 28a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000290 <memset>:

void*
memset(void *dst, int c, uint n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 297:	8b 4d 10             	mov    0x10(%ebp),%ecx
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	89 d7                	mov    %edx,%edi
 29f:	fc                   	cld    
 2a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2a2:	89 d0                	mov    %edx,%eax
 2a4:	5f                   	pop    %edi
 2a5:	5d                   	pop    %ebp
 2a6:	c3                   	ret    
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <strchr>:

char*
strchr(const char *s, char c)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2ba:	0f b6 10             	movzbl (%eax),%edx
 2bd:	84 d2                	test   %dl,%dl
 2bf:	74 1d                	je     2de <strchr+0x2e>
    if(*s == c)
 2c1:	38 d3                	cmp    %dl,%bl
 2c3:	89 d9                	mov    %ebx,%ecx
 2c5:	75 0d                	jne    2d4 <strchr+0x24>
 2c7:	eb 17                	jmp    2e0 <strchr+0x30>
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2d0:	38 ca                	cmp    %cl,%dl
 2d2:	74 0c                	je     2e0 <strchr+0x30>
  for(; *s; s++)
 2d4:	83 c0 01             	add    $0x1,%eax
 2d7:	0f b6 10             	movzbl (%eax),%edx
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strchr+0x20>
      return (char*)s;
  return 0;
 2de:	31 c0                	xor    %eax,%eax
}
 2e0:	5b                   	pop    %ebx
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <gets>:

char*
gets(char *buf, int max)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
 2f5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f6:	31 f6                	xor    %esi,%esi
 2f8:	89 f3                	mov    %esi,%ebx
{
 2fa:	83 ec 1c             	sub    $0x1c,%esp
 2fd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 300:	eb 2f                	jmp    331 <gets+0x41>
 302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 308:	8d 45 e7             	lea    -0x19(%ebp),%eax
 30b:	83 ec 04             	sub    $0x4,%esp
 30e:	6a 01                	push   $0x1
 310:	50                   	push   %eax
 311:	6a 00                	push   $0x0
 313:	e8 32 01 00 00       	call   44a <read>
    if(cc < 1)
 318:	83 c4 10             	add    $0x10,%esp
 31b:	85 c0                	test   %eax,%eax
 31d:	7e 1c                	jle    33b <gets+0x4b>
      break;
    buf[i++] = c;
 31f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 323:	83 c7 01             	add    $0x1,%edi
 326:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 329:	3c 0a                	cmp    $0xa,%al
 32b:	74 23                	je     350 <gets+0x60>
 32d:	3c 0d                	cmp    $0xd,%al
 32f:	74 1f                	je     350 <gets+0x60>
  for(i=0; i+1 < max; ){
 331:	83 c3 01             	add    $0x1,%ebx
 334:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 337:	89 fe                	mov    %edi,%esi
 339:	7c cd                	jl     308 <gets+0x18>
 33b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 33d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 340:	c6 03 00             	movb   $0x0,(%ebx)
}
 343:	8d 65 f4             	lea    -0xc(%ebp),%esp
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    
 34b:	90                   	nop
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 350:	8b 75 08             	mov    0x8(%ebp),%esi
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	01 de                	add    %ebx,%esi
 358:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 35a:	c6 03 00             	movb   $0x0,(%ebx)
}
 35d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 360:	5b                   	pop    %ebx
 361:	5e                   	pop    %esi
 362:	5f                   	pop    %edi
 363:	5d                   	pop    %ebp
 364:	c3                   	ret    
 365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <stat>:

int
stat(const char *n, struct stat *st)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 375:	83 ec 08             	sub    $0x8,%esp
 378:	6a 00                	push   $0x0
 37a:	ff 75 08             	pushl  0x8(%ebp)
 37d:	e8 f0 00 00 00       	call   472 <open>
  if(fd < 0)
 382:	83 c4 10             	add    $0x10,%esp
 385:	85 c0                	test   %eax,%eax
 387:	78 27                	js     3b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 389:	83 ec 08             	sub    $0x8,%esp
 38c:	ff 75 0c             	pushl  0xc(%ebp)
 38f:	89 c3                	mov    %eax,%ebx
 391:	50                   	push   %eax
 392:	e8 f3 00 00 00       	call   48a <fstat>
  close(fd);
 397:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 39a:	89 c6                	mov    %eax,%esi
  close(fd);
 39c:	e8 b9 00 00 00       	call   45a <close>
  return r;
 3a1:	83 c4 10             	add    $0x10,%esp
}
 3a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3a7:	89 f0                	mov    %esi,%eax
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3b5:	eb ed                	jmp    3a4 <stat+0x34>
 3b7:	89 f6                	mov    %esi,%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003c0 <atoi>:

int
atoi(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	0f be 11             	movsbl (%ecx),%edx
 3ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 3cd:	3c 09                	cmp    $0x9,%al
  n = 0;
 3cf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 3d4:	77 1f                	ja     3f5 <atoi+0x35>
 3d6:	8d 76 00             	lea    0x0(%esi),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3e3:	83 c1 01             	add    $0x1,%ecx
 3e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3ea:	0f be 11             	movsbl (%ecx),%edx
 3ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3f0:	80 fb 09             	cmp    $0x9,%bl
 3f3:	76 eb                	jbe    3e0 <atoi+0x20>
  return n;
}
 3f5:	5b                   	pop    %ebx
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
 405:	8b 5d 10             	mov    0x10(%ebp),%ebx
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40e:	85 db                	test   %ebx,%ebx
 410:	7e 14                	jle    426 <memmove+0x26>
 412:	31 d2                	xor    %edx,%edx
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 418:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 41c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 41f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 422:	39 d3                	cmp    %edx,%ebx
 424:	75 f2                	jne    418 <memmove+0x18>
  return vdst;
}
 426:	5b                   	pop    %ebx
 427:	5e                   	pop    %esi
 428:	5d                   	pop    %ebp
 429:	c3                   	ret    

0000042a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42a:	b8 01 00 00 00       	mov    $0x1,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <exit>:
SYSCALL(exit)
 432:	b8 02 00 00 00       	mov    $0x2,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <wait>:
SYSCALL(wait)
 43a:	b8 03 00 00 00       	mov    $0x3,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <pipe>:
SYSCALL(pipe)
 442:	b8 04 00 00 00       	mov    $0x4,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <read>:
SYSCALL(read)
 44a:	b8 05 00 00 00       	mov    $0x5,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <write>:
SYSCALL(write)
 452:	b8 10 00 00 00       	mov    $0x10,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <close>:
SYSCALL(close)
 45a:	b8 15 00 00 00       	mov    $0x15,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <kill>:
SYSCALL(kill)
 462:	b8 06 00 00 00       	mov    $0x6,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <exec>:
SYSCALL(exec)
 46a:	b8 07 00 00 00       	mov    $0x7,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <open>:
SYSCALL(open)
 472:	b8 0f 00 00 00       	mov    $0xf,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <mknod>:
SYSCALL(mknod)
 47a:	b8 11 00 00 00       	mov    $0x11,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <unlink>:
SYSCALL(unlink)
 482:	b8 12 00 00 00       	mov    $0x12,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <fstat>:
SYSCALL(fstat)
 48a:	b8 08 00 00 00       	mov    $0x8,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <link>:
SYSCALL(link)
 492:	b8 13 00 00 00       	mov    $0x13,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <mkdir>:
SYSCALL(mkdir)
 49a:	b8 14 00 00 00       	mov    $0x14,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <chdir>:
SYSCALL(chdir)
 4a2:	b8 09 00 00 00       	mov    $0x9,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <dup>:
SYSCALL(dup)
 4aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <getpid>:
SYSCALL(getpid)
 4b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <sbrk>:
SYSCALL(sbrk)
 4ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <sleep>:
SYSCALL(sleep)
 4c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <uptime>:
SYSCALL(uptime)
 4ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <kthread_create>:
SYSCALL(kthread_create)
 4d2:	b8 16 00 00 00       	mov    $0x16,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <kthread_id>:
SYSCALL(kthread_id)
 4da:	b8 17 00 00 00       	mov    $0x17,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <kthread_exit>:
SYSCALL(kthread_exit)
 4e2:	b8 18 00 00 00       	mov    $0x18,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <kthread_join>:
SYSCALL(kthread_join)
 4ea:	b8 19 00 00 00       	mov    $0x19,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    
 4f2:	66 90                	xchg   %ax,%ax
 4f4:	66 90                	xchg   %ax,%ax
 4f6:	66 90                	xchg   %ax,%ax
 4f8:	66 90                	xchg   %ax,%ax
 4fa:	66 90                	xchg   %ax,%ax
 4fc:	66 90                	xchg   %ax,%ax
 4fe:	66 90                	xchg   %ax,%ax

00000500 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 509:	85 d2                	test   %edx,%edx
{
 50b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 50e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 510:	79 76                	jns    588 <printint+0x88>
 512:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 516:	74 70                	je     588 <printint+0x88>
    x = -xx;
 518:	f7 d8                	neg    %eax
    neg = 1;
 51a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 521:	31 f6                	xor    %esi,%esi
 523:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 526:	eb 0a                	jmp    532 <printint+0x32>
 528:	90                   	nop
 529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 530:	89 fe                	mov    %edi,%esi
 532:	31 d2                	xor    %edx,%edx
 534:	8d 7e 01             	lea    0x1(%esi),%edi
 537:	f7 f1                	div    %ecx
 539:	0f b6 92 7c 09 00 00 	movzbl 0x97c(%edx),%edx
  }while((x /= base) != 0);
 540:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 542:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 545:	75 e9                	jne    530 <printint+0x30>
  if(neg)
 547:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 54a:	85 c0                	test   %eax,%eax
 54c:	74 08                	je     556 <printint+0x56>
    buf[i++] = '-';
 54e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 553:	8d 7e 02             	lea    0x2(%esi),%edi
 556:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 55a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 55d:	8d 76 00             	lea    0x0(%esi),%esi
 560:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 563:	83 ec 04             	sub    $0x4,%esp
 566:	83 ee 01             	sub    $0x1,%esi
 569:	6a 01                	push   $0x1
 56b:	53                   	push   %ebx
 56c:	57                   	push   %edi
 56d:	88 45 d7             	mov    %al,-0x29(%ebp)
 570:	e8 dd fe ff ff       	call   452 <write>

  while(--i >= 0)
 575:	83 c4 10             	add    $0x10,%esp
 578:	39 de                	cmp    %ebx,%esi
 57a:	75 e4                	jne    560 <printint+0x60>
    putc(fd, buf[i]);
}
 57c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 57f:	5b                   	pop    %ebx
 580:	5e                   	pop    %esi
 581:	5f                   	pop    %edi
 582:	5d                   	pop    %ebp
 583:	c3                   	ret    
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 588:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 58f:	eb 90                	jmp    521 <printint+0x21>
 591:	eb 0d                	jmp    5a0 <printf>
 593:	90                   	nop
 594:	90                   	nop
 595:	90                   	nop
 596:	90                   	nop
 597:	90                   	nop
 598:	90                   	nop
 599:	90                   	nop
 59a:	90                   	nop
 59b:	90                   	nop
 59c:	90                   	nop
 59d:	90                   	nop
 59e:	90                   	nop
 59f:	90                   	nop

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5ac:	0f b6 1e             	movzbl (%esi),%ebx
 5af:	84 db                	test   %bl,%bl
 5b1:	0f 84 b3 00 00 00    	je     66a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 5b7:	8d 45 10             	lea    0x10(%ebp),%eax
 5ba:	83 c6 01             	add    $0x1,%esi
  state = 0;
 5bd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 5bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5c2:	eb 2f                	jmp    5f3 <printf+0x53>
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5c8:	83 f8 25             	cmp    $0x25,%eax
 5cb:	0f 84 a7 00 00 00    	je     678 <printf+0xd8>
  write(fd, &c, 1);
 5d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5d4:	83 ec 04             	sub    $0x4,%esp
 5d7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5da:	6a 01                	push   $0x1
 5dc:	50                   	push   %eax
 5dd:	ff 75 08             	pushl  0x8(%ebp)
 5e0:	e8 6d fe ff ff       	call   452 <write>
 5e5:	83 c4 10             	add    $0x10,%esp
 5e8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5eb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5ef:	84 db                	test   %bl,%bl
 5f1:	74 77                	je     66a <printf+0xca>
    if(state == 0){
 5f3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5f5:	0f be cb             	movsbl %bl,%ecx
 5f8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5fb:	74 cb                	je     5c8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5fd:	83 ff 25             	cmp    $0x25,%edi
 600:	75 e6                	jne    5e8 <printf+0x48>
      if(c == 'd'){
 602:	83 f8 64             	cmp    $0x64,%eax
 605:	0f 84 05 01 00 00    	je     710 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 60b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 611:	83 f9 70             	cmp    $0x70,%ecx
 614:	74 72                	je     688 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 616:	83 f8 73             	cmp    $0x73,%eax
 619:	0f 84 99 00 00 00    	je     6b8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 61f:	83 f8 63             	cmp    $0x63,%eax
 622:	0f 84 08 01 00 00    	je     730 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 628:	83 f8 25             	cmp    $0x25,%eax
 62b:	0f 84 ef 00 00 00    	je     720 <printf+0x180>
  write(fd, &c, 1);
 631:	8d 45 e7             	lea    -0x19(%ebp),%eax
 634:	83 ec 04             	sub    $0x4,%esp
 637:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 63b:	6a 01                	push   $0x1
 63d:	50                   	push   %eax
 63e:	ff 75 08             	pushl  0x8(%ebp)
 641:	e8 0c fe ff ff       	call   452 <write>
 646:	83 c4 0c             	add    $0xc,%esp
 649:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 64c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 64f:	6a 01                	push   $0x1
 651:	50                   	push   %eax
 652:	ff 75 08             	pushl  0x8(%ebp)
 655:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 658:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 65a:	e8 f3 fd ff ff       	call   452 <write>
  for(i = 0; fmt[i]; i++){
 65f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 663:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 666:	84 db                	test   %bl,%bl
 668:	75 89                	jne    5f3 <printf+0x53>
    }
  }
}
 66a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66d:	5b                   	pop    %ebx
 66e:	5e                   	pop    %esi
 66f:	5f                   	pop    %edi
 670:	5d                   	pop    %ebp
 671:	c3                   	ret    
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 678:	bf 25 00 00 00       	mov    $0x25,%edi
 67d:	e9 66 ff ff ff       	jmp    5e8 <printf+0x48>
 682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 688:	83 ec 0c             	sub    $0xc,%esp
 68b:	b9 10 00 00 00       	mov    $0x10,%ecx
 690:	6a 00                	push   $0x0
 692:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 695:	8b 45 08             	mov    0x8(%ebp),%eax
 698:	8b 17                	mov    (%edi),%edx
 69a:	e8 61 fe ff ff       	call   500 <printint>
        ap++;
 69f:	89 f8                	mov    %edi,%eax
 6a1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6a4:	31 ff                	xor    %edi,%edi
        ap++;
 6a6:	83 c0 04             	add    $0x4,%eax
 6a9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6ac:	e9 37 ff ff ff       	jmp    5e8 <printf+0x48>
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6bb:	8b 08                	mov    (%eax),%ecx
        ap++;
 6bd:	83 c0 04             	add    $0x4,%eax
 6c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6c3:	85 c9                	test   %ecx,%ecx
 6c5:	0f 84 8e 00 00 00    	je     759 <printf+0x1b9>
        while(*s != 0){
 6cb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 6ce:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 6d0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 6d2:	84 c0                	test   %al,%al
 6d4:	0f 84 0e ff ff ff    	je     5e8 <printf+0x48>
 6da:	89 75 d0             	mov    %esi,-0x30(%ebp)
 6dd:	89 de                	mov    %ebx,%esi
 6df:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6e2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 6e5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6e8:	83 ec 04             	sub    $0x4,%esp
          s++;
 6eb:	83 c6 01             	add    $0x1,%esi
 6ee:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6f1:	6a 01                	push   $0x1
 6f3:	57                   	push   %edi
 6f4:	53                   	push   %ebx
 6f5:	e8 58 fd ff ff       	call   452 <write>
        while(*s != 0){
 6fa:	0f b6 06             	movzbl (%esi),%eax
 6fd:	83 c4 10             	add    $0x10,%esp
 700:	84 c0                	test   %al,%al
 702:	75 e4                	jne    6e8 <printf+0x148>
 704:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 707:	31 ff                	xor    %edi,%edi
 709:	e9 da fe ff ff       	jmp    5e8 <printf+0x48>
 70e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 710:	83 ec 0c             	sub    $0xc,%esp
 713:	b9 0a 00 00 00       	mov    $0xa,%ecx
 718:	6a 01                	push   $0x1
 71a:	e9 73 ff ff ff       	jmp    692 <printf+0xf2>
 71f:	90                   	nop
  write(fd, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
 723:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 726:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 729:	6a 01                	push   $0x1
 72b:	e9 21 ff ff ff       	jmp    651 <printf+0xb1>
        putc(fd, *ap);
 730:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 733:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 736:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 738:	6a 01                	push   $0x1
        ap++;
 73a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 73d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 740:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 743:	50                   	push   %eax
 744:	ff 75 08             	pushl  0x8(%ebp)
 747:	e8 06 fd ff ff       	call   452 <write>
        ap++;
 74c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 74f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 752:	31 ff                	xor    %edi,%edi
 754:	e9 8f fe ff ff       	jmp    5e8 <printf+0x48>
          s = "(null)";
 759:	bb 75 09 00 00       	mov    $0x975,%ebx
        while(*s != 0){
 75e:	b8 28 00 00 00       	mov    $0x28,%eax
 763:	e9 72 ff ff ff       	jmp    6da <printf+0x13a>
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	a1 f0 0c 00 00       	mov    0xcf0,%eax
{
 776:	89 e5                	mov    %esp,%ebp
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 77e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 788:	39 c8                	cmp    %ecx,%eax
 78a:	8b 10                	mov    (%eax),%edx
 78c:	73 32                	jae    7c0 <free+0x50>
 78e:	39 d1                	cmp    %edx,%ecx
 790:	72 04                	jb     796 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 792:	39 d0                	cmp    %edx,%eax
 794:	72 32                	jb     7c8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 796:	8b 73 fc             	mov    -0x4(%ebx),%esi
 799:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 79c:	39 fa                	cmp    %edi,%edx
 79e:	74 30                	je     7d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7a0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7a3:	8b 50 04             	mov    0x4(%eax),%edx
 7a6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a9:	39 f1                	cmp    %esi,%ecx
 7ab:	74 3a                	je     7e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7ad:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7af:	a3 f0 0c 00 00       	mov    %eax,0xcf0
}
 7b4:	5b                   	pop    %ebx
 7b5:	5e                   	pop    %esi
 7b6:	5f                   	pop    %edi
 7b7:	5d                   	pop    %ebp
 7b8:	c3                   	ret    
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c0:	39 d0                	cmp    %edx,%eax
 7c2:	72 04                	jb     7c8 <free+0x58>
 7c4:	39 d1                	cmp    %edx,%ecx
 7c6:	72 ce                	jb     796 <free+0x26>
{
 7c8:	89 d0                	mov    %edx,%eax
 7ca:	eb bc                	jmp    788 <free+0x18>
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7d0:	03 72 04             	add    0x4(%edx),%esi
 7d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d6:	8b 10                	mov    (%eax),%edx
 7d8:	8b 12                	mov    (%edx),%edx
 7da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7dd:	8b 50 04             	mov    0x4(%eax),%edx
 7e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7e3:	39 f1                	cmp    %esi,%ecx
 7e5:	75 c6                	jne    7ad <free+0x3d>
    p->s.size += bp->s.size;
 7e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ea:	a3 f0 0c 00 00       	mov    %eax,0xcf0
    p->s.size += bp->s.size;
 7ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7f5:	89 10                	mov    %edx,(%eax)
}
 7f7:	5b                   	pop    %ebx
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 15 f0 0c 00 00    	mov    0xcf0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 78 07             	lea    0x7(%eax),%edi
 815:	c1 ef 03             	shr    $0x3,%edi
 818:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 81b:	85 d2                	test   %edx,%edx
 81d:	0f 84 9d 00 00 00    	je     8c0 <malloc+0xc0>
 823:	8b 02                	mov    (%edx),%eax
 825:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 828:	39 cf                	cmp    %ecx,%edi
 82a:	76 6c                	jbe    898 <malloc+0x98>
 82c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 832:	bb 00 10 00 00       	mov    $0x1000,%ebx
 837:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 83a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 841:	eb 0e                	jmp    851 <malloc+0x51>
 843:	90                   	nop
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 848:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 84a:	8b 48 04             	mov    0x4(%eax),%ecx
 84d:	39 f9                	cmp    %edi,%ecx
 84f:	73 47                	jae    898 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 851:	39 05 f0 0c 00 00    	cmp    %eax,0xcf0
 857:	89 c2                	mov    %eax,%edx
 859:	75 ed                	jne    848 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 85b:	83 ec 0c             	sub    $0xc,%esp
 85e:	56                   	push   %esi
 85f:	e8 56 fc ff ff       	call   4ba <sbrk>
  if(p == (char*)-1)
 864:	83 c4 10             	add    $0x10,%esp
 867:	83 f8 ff             	cmp    $0xffffffff,%eax
 86a:	74 1c                	je     888 <malloc+0x88>
  hp->s.size = nu;
 86c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 86f:	83 ec 0c             	sub    $0xc,%esp
 872:	83 c0 08             	add    $0x8,%eax
 875:	50                   	push   %eax
 876:	e8 f5 fe ff ff       	call   770 <free>
  return freep;
 87b:	8b 15 f0 0c 00 00    	mov    0xcf0,%edx
      if((p = morecore(nunits)) == 0)
 881:	83 c4 10             	add    $0x10,%esp
 884:	85 d2                	test   %edx,%edx
 886:	75 c0                	jne    848 <malloc+0x48>
        return 0;
  }
}
 888:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 88b:	31 c0                	xor    %eax,%eax
}
 88d:	5b                   	pop    %ebx
 88e:	5e                   	pop    %esi
 88f:	5f                   	pop    %edi
 890:	5d                   	pop    %ebp
 891:	c3                   	ret    
 892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 898:	39 cf                	cmp    %ecx,%edi
 89a:	74 54                	je     8f0 <malloc+0xf0>
        p->s.size -= nunits;
 89c:	29 f9                	sub    %edi,%ecx
 89e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8a7:	89 15 f0 0c 00 00    	mov    %edx,0xcf0
}
 8ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8b0:	83 c0 08             	add    $0x8,%eax
}
 8b3:	5b                   	pop    %ebx
 8b4:	5e                   	pop    %esi
 8b5:	5f                   	pop    %edi
 8b6:	5d                   	pop    %ebp
 8b7:	c3                   	ret    
 8b8:	90                   	nop
 8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 8c0:	c7 05 f0 0c 00 00 f4 	movl   $0xcf4,0xcf0
 8c7:	0c 00 00 
 8ca:	c7 05 f4 0c 00 00 f4 	movl   $0xcf4,0xcf4
 8d1:	0c 00 00 
    base.s.size = 0;
 8d4:	b8 f4 0c 00 00       	mov    $0xcf4,%eax
 8d9:	c7 05 f8 0c 00 00 00 	movl   $0x0,0xcf8
 8e0:	00 00 00 
 8e3:	e9 44 ff ff ff       	jmp    82c <malloc+0x2c>
 8e8:	90                   	nop
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb b1                	jmp    8a7 <malloc+0xa7>
