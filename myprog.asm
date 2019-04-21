
_myprog:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
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
    //test_kthread_create();
    //test_kthread_join();
    //Test();

    mutexTest();
  11:	e8 9a 02 00 00       	call   2b0 <mutexTest>
  16:	66 90                	xchg   %ax,%ax
  18:	66 90                	xchg   %ax,%ax
  1a:	66 90                	xchg   %ax,%ax
  1c:	66 90                	xchg   %ax,%ax
  1e:	66 90                	xchg   %ax,%ax

00000020 <printSomthing>:
int printSomthing(){
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	83 ec 10             	sub    $0x10,%esp
    printf(1,"\n HELLO \n");
  26:	68 d8 0b 00 00       	push   $0xbd8
  2b:	6a 01                	push   $0x1
  2d:	e8 4e 08 00 00       	call   880 <printf>
    a = 2;
  32:	c7 05 18 12 00 00 02 	movl   $0x2,0x1218
  39:	00 00 00 
    kthread_exit();
  3c:	e8 61 07 00 00       	call   7a2 <kthread_exit>
}
  41:	31 c0                	xor    %eax,%eax
  43:	c9                   	leave  
  44:	c3                   	ret    
  45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000050 <run>:
run(){
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
	int id = kthread_id();
  55:	e8 40 07 00 00       	call   79a <kthread_id>
  5a:	89 c6                	mov    %eax,%esi
	int pid = getpid();
  5c:	e8 11 07 00 00       	call   772 <getpid>
	printf(1, "my id: %d\n", id);
  61:	83 ec 04             	sub    $0x4,%esp
	int pid = getpid();
  64:	89 c3                	mov    %eax,%ebx
	printf(1, "my id: %d\n", id);
  66:	56                   	push   %esi
  67:	68 e2 0b 00 00       	push   $0xbe2
  6c:	6a 01                	push   $0x1
  6e:	e8 0d 08 00 00       	call   880 <printf>
	printf(1,"my pid: %d\n", pid);
  73:	83 c4 0c             	add    $0xc,%esp
  76:	53                   	push   %ebx
  77:	68 ed 0b 00 00       	push   $0xbed
  7c:	6a 01                	push   $0x1
  7e:	e8 fd 07 00 00       	call   880 <printf>
	printf(1,"hey\n");
  83:	58                   	pop    %eax
  84:	5a                   	pop    %edx
  85:	68 f9 0b 00 00       	push   $0xbf9
  8a:	6a 01                	push   $0x1
  8c:	e8 ef 07 00 00       	call   880 <printf>
	kthread_exit();
  91:	83 c4 10             	add    $0x10,%esp
}
  94:	8d 65 f8             	lea    -0x8(%ebp),%esp
  97:	5b                   	pop    %ebx
  98:	5e                   	pop    %esi
  99:	5d                   	pop    %ebp
	kthread_exit();
  9a:	e9 03 07 00 00       	jmp    7a2 <kthread_exit>
  9f:	90                   	nop

000000a0 <printer>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	83 ec 14             	sub    $0x14,%esp
	int input = kthread_mutex_lock(mutex);
  a6:	ff 35 28 12 00 00    	pushl  0x1228
  ac:	e8 11 07 00 00       	call   7c2 <kthread_mutex_lock>
	if(input<0)
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	85 c0                	test   %eax,%eax
  b6:	78 68                	js     120 <printer+0x80>
	printf(1,"thread %d said hi\n",kthread_id());
  b8:	e8 dd 06 00 00       	call   79a <kthread_id>
  bd:	83 ec 04             	sub    $0x4,%esp
  c0:	50                   	push   %eax
  c1:	68 fe 0b 00 00       	push   $0xbfe
  c6:	6a 01                	push   $0x1
  c8:	e8 b3 07 00 00       	call   880 <printf>
	input = kthread_mutex_unlock(mutex);
  cd:	58                   	pop    %eax
  ce:	ff 35 28 12 00 00    	pushl  0x1228
	test=1;
  d4:	c7 05 2c 12 00 00 01 	movl   $0x1,0x122c
  db:	00 00 00 
	input = kthread_mutex_unlock(mutex);
  de:	e8 e7 06 00 00       	call   7ca <kthread_mutex_unlock>
	if(input<0)
  e3:	83 c4 10             	add    $0x10,%esp
  e6:	85 c0                	test   %eax,%eax
  e8:	78 1e                	js     108 <printer+0x68>
	kthread_exit();
  ea:	e8 b3 06 00 00       	call   7a2 <kthread_exit>
	printf(1,"Error: returned from exit !!");
  ef:	83 ec 08             	sub    $0x8,%esp
  f2:	68 11 0c 00 00       	push   $0xc11
  f7:	6a 01                	push   $0x1
  f9:	e8 82 07 00 00       	call   880 <printf>
}
  fe:	83 c4 10             	add    $0x10,%esp
 101:	c9                   	leave  
 102:	c3                   	ret    
 103:	90                   	nop
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: thread mutex didnt unlock!");
 108:	83 ec 08             	sub    $0x8,%esp
 10b:	68 48 0d 00 00       	push   $0xd48
 110:	6a 01                	push   $0x1
 112:	e8 69 07 00 00       	call   880 <printf>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	eb ce                	jmp    ea <printer+0x4a>
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: thread mutex didnt lock!");
 120:	83 ec 08             	sub    $0x8,%esp
 123:	68 28 0d 00 00       	push   $0xd28
 128:	6a 01                	push   $0x1
 12a:	e8 51 07 00 00       	call   880 <printf>
 12f:	83 c4 10             	add    $0x10,%esp
 132:	eb 84                	jmp    b8 <printer+0x18>
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <test_kthread_create>:
void test_kthread_create(){
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	56                   	push   %esi
 144:	53                   	push   %ebx
    char* ustack = (char*)malloc(4000);
 145:	83 ec 0c             	sub    $0xc,%esp
 148:	68 a0 0f 00 00       	push   $0xfa0
 14d:	e8 8e 09 00 00       	call   ae0 <malloc>
    printf(1, "a=%d\n",a);
 152:	83 c4 0c             	add    $0xc,%esp
 155:	ff 35 18 12 00 00    	pushl  0x1218
    char* ustack = (char*)malloc(4000);
 15b:	89 c3                	mov    %eax,%ebx
    printf(1, "a=%d\n",a);
 15d:	68 2e 0c 00 00       	push   $0xc2e
 162:	6a 01                	push   $0x1
 164:	e8 17 07 00 00       	call   880 <printf>
    int tid = kthread_create((void*)&printSomthing, ustack);
 169:	58                   	pop    %eax
 16a:	5a                   	pop    %edx
 16b:	53                   	push   %ebx
 16c:	68 20 00 00 00       	push   $0x20
 171:	e8 1c 06 00 00       	call   792 <kthread_create>
    sleep(50);
 176:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    int tid = kthread_create((void*)&printSomthing, ustack);
 17d:	89 c6                	mov    %eax,%esi
    sleep(50);
 17f:	e8 fe 05 00 00       	call   782 <sleep>
    free(ustack);
 184:	89 1c 24             	mov    %ebx,(%esp)
 187:	e8 c4 08 00 00       	call   a50 <free>
    printf(1, "created thread %d\n", tid);
 18c:	83 c4 0c             	add    $0xc,%esp
 18f:	56                   	push   %esi
 190:	68 34 0c 00 00       	push   $0xc34
 195:	6a 01                	push   $0x1
 197:	e8 e4 06 00 00       	call   880 <printf>
    printf(1, "a=%d\n",a);
 19c:	83 c4 0c             	add    $0xc,%esp
 19f:	ff 35 18 12 00 00    	pushl  0x1218
 1a5:	68 2e 0c 00 00       	push   $0xc2e
 1aa:	6a 01                	push   $0x1
 1ac:	e8 cf 06 00 00       	call   880 <printf>
    return;
 1b1:	83 c4 10             	add    $0x10,%esp
}
 1b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b7:	5b                   	pop    %ebx
 1b8:	5e                   	pop    %esi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	90                   	nop
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <test_kthread_exit>:
void test_kthread_exit(){
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 08             	sub    $0x8,%esp
    int tid = kthread_id();
 1c6:	e8 cf 05 00 00       	call   79a <kthread_id>
    printf(1, "thread id: %d\n", tid);
 1cb:	83 ec 04             	sub    $0x4,%esp
 1ce:	50                   	push   %eax
 1cf:	68 47 0c 00 00       	push   $0xc47
 1d4:	6a 01                	push   $0x1
 1d6:	e8 a5 06 00 00       	call   880 <printf>
    kthread_exit();
 1db:	83 c4 10             	add    $0x10,%esp
}
 1de:	c9                   	leave  
    kthread_exit();
 1df:	e9 be 05 00 00       	jmp    7a2 <kthread_exit>
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <test_kthread_join>:
void test_kthread_join(){
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	53                   	push   %ebx
 1f4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 1f9:	83 ec 04             	sub    $0x4,%esp
    int pid = fork();
 1fc:	e8 e9 04 00 00       	call   6ea <fork>
    if(pid == 0){
 201:	85 c0                	test   %eax,%eax
 203:	75 1f                	jne    224 <test_kthread_join+0x34>
        tid = kthread_id();
 205:	e8 90 05 00 00       	call   79a <kthread_id>
        printf(1, "child tid: %d\n", tid);
 20a:	83 ec 04             	sub    $0x4,%esp
        tid = kthread_id();
 20d:	89 c3                	mov    %eax,%ebx
        printf(1, "child tid: %d\n", tid);
 20f:	50                   	push   %eax
 210:	68 56 0c 00 00       	push   $0xc56
 215:	6a 01                	push   $0x1
 217:	e8 64 06 00 00       	call   880 <printf>
        kthread_exit();
 21c:	e8 81 05 00 00       	call   7a2 <kthread_exit>
 221:	83 c4 10             	add    $0x10,%esp
    wait();
 224:	e8 d1 04 00 00       	call   6fa <wait>
    printf(1, "parent tid: %d\n", tid);
 229:	83 ec 04             	sub    $0x4,%esp
 22c:	53                   	push   %ebx
 22d:	68 65 0c 00 00       	push   $0xc65
 232:	6a 01                	push   $0x1
 234:	e8 47 06 00 00       	call   880 <printf>
    kthread_join(tid);
 239:	89 1c 24             	mov    %ebx,(%esp)
 23c:	e8 69 05 00 00       	call   7aa <kthread_join>
    return;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 247:	c9                   	leave  
 248:	c3                   	ret    
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <Test>:
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	83 ec 10             	sub    $0x10,%esp
	void* stack = (void*)malloc(4000);
 257:	68 a0 0f 00 00       	push   $0xfa0
 25c:	e8 7f 08 00 00       	call   ae0 <malloc>
 261:	89 c3                	mov    %eax,%ebx
	int pid = getpid();
 263:	e8 0a 05 00 00       	call   772 <getpid>
	printf(1, "main pid: %d\n",pid);
 268:	83 c4 0c             	add    $0xc,%esp
 26b:	50                   	push   %eax
 26c:	68 75 0c 00 00       	push   $0xc75
 271:	6a 01                	push   $0x1
 273:	e8 08 06 00 00       	call   880 <printf>
	int tid = kthread_create(&run, stack);
 278:	58                   	pop    %eax
 279:	5a                   	pop    %edx
 27a:	53                   	push   %ebx
 27b:	68 50 00 00 00       	push   $0x50
 280:	e8 0d 05 00 00       	call   792 <kthread_create>
 285:	89 c3                	mov    %eax,%ebx
	int rest = kthread_join(tid);
 287:	89 04 24             	mov    %eax,(%esp)
 28a:	e8 1b 05 00 00       	call   7aa <kthread_join>
	printf(1, "tid: %d, rest: %d\n", tid, rest);
 28f:	50                   	push   %eax
 290:	53                   	push   %ebx
 291:	68 83 0c 00 00       	push   $0xc83
 296:	6a 01                	push   $0x1
 298:	e8 e3 05 00 00       	call   880 <printf>
    kthread_id();
 29d:	83 c4 20             	add    $0x20,%esp
 2a0:	e8 f5 04 00 00       	call   79a <kthread_id>
	exit();
 2a5:	e8 48 04 00 00       	call   6f2 <exit>
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <mutexTest>:
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
	printf(1,"~~~~~~~~~~~~~~~~~~\ntest starts\nIf it ends without Errors you win! : )\n~~~~~~~~~~~~~~~~~~\n");
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	68 6c 0d 00 00       	push   $0xd6c
 2bd:	6a 01                	push   $0x1
 2bf:	e8 bc 05 00 00       	call   880 <printf>
	mutex = kthread_mutex_alloc();
 2c4:	e8 e9 04 00 00       	call   7b2 <kthread_mutex_alloc>
	printf(1,"the mutex: %d\n",mutex);
 2c9:	83 c4 0c             	add    $0xc,%esp
	mutex = kthread_mutex_alloc();
 2cc:	a3 28 12 00 00       	mov    %eax,0x1228
	printf(1,"the mutex: %d\n",mutex);
 2d1:	50                   	push   %eax
 2d2:	68 96 0c 00 00       	push   $0xc96
 2d7:	6a 01                	push   $0x1
 2d9:	e8 a2 05 00 00       	call   880 <printf>
	if(mutex<0)
 2de:	a1 28 12 00 00       	mov    0x1228,%eax
 2e3:	83 c4 10             	add    $0x10,%esp
 2e6:	85 c0                	test   %eax,%eax
 2e8:	0f 88 79 01 00 00    	js     467 <mutexTest+0x1b7>
{
 2ee:	be 05 00 00 00       	mov    $0x5,%esi
		input = kthread_mutex_lock(mutex);
 2f3:	83 ec 0c             	sub    $0xc,%esp
		test=0;
 2f6:	c7 05 2c 12 00 00 00 	movl   $0x0,0x122c
 2fd:	00 00 00 
		input = kthread_mutex_lock(mutex);
 300:	50                   	push   %eax
 301:	e8 bc 04 00 00       	call   7c2 <kthread_mutex_lock>
		if(input<0)
 306:	83 c4 10             	add    $0x10,%esp
 309:	85 c0                	test   %eax,%eax
 30b:	0f 88 0f 01 00 00    	js     420 <mutexTest+0x170>
		char* stack = malloc(4000);
 311:	83 ec 0c             	sub    $0xc,%esp
 314:	68 a0 0f 00 00       	push   $0xfa0
 319:	e8 c2 07 00 00       	call   ae0 <malloc>
		int tid = kthread_create ((void*)printer, stack);
 31e:	5a                   	pop    %edx
 31f:	59                   	pop    %ecx
 320:	50                   	push   %eax
 321:	68 a0 00 00 00       	push   $0xa0
 326:	e8 67 04 00 00       	call   792 <kthread_create>
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
 32b:	83 c4 10             	add    $0x10,%esp
 32e:	85 c0                	test   %eax,%eax
		int tid = kthread_create ((void*)printer, stack);
 330:	89 c3                	mov    %eax,%ebx
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
 332:	0f 88 a8 00 00 00    	js     3e0 <mutexTest+0x130>
		printf(1,"joining on thread %d\n",tid);
 338:	83 ec 04             	sub    $0x4,%esp
 33b:	53                   	push   %ebx
 33c:	68 a5 0c 00 00       	push   $0xca5
 341:	6a 01                	push   $0x1
 343:	e8 38 05 00 00       	call   880 <printf>
		if(test)printf(1,"Error: mutex didnt prevent writing!\n");
 348:	a1 2c 12 00 00       	mov    0x122c,%eax
 34d:	83 c4 10             	add    $0x10,%esp
 350:	85 c0                	test   %eax,%eax
 352:	75 5c                	jne    3b0 <mutexTest+0x100>
		input = kthread_mutex_unlock(mutex);
 354:	83 ec 0c             	sub    $0xc,%esp
 357:	ff 35 28 12 00 00    	pushl  0x1228
 35d:	e8 68 04 00 00       	call   7ca <kthread_mutex_unlock>
		if(input<0) printf(1,"Error: mutex didnt unlock!\n");
 362:	83 c4 10             	add    $0x10,%esp
 365:	85 c0                	test   %eax,%eax
 367:	0f 88 93 00 00 00    	js     400 <mutexTest+0x150>
		kthread_join(tid);
 36d:	83 ec 0c             	sub    $0xc,%esp
 370:	53                   	push   %ebx
 371:	e8 34 04 00 00       	call   7aa <kthread_join>
		if(!test) printf(1,"Error: thread didnt run!\n");
 376:	8b 0d 2c 12 00 00    	mov    0x122c,%ecx
 37c:	83 c4 10             	add    $0x10,%esp
 37f:	85 c9                	test   %ecx,%ecx
 381:	74 45                	je     3c8 <mutexTest+0x118>
		printf(1,"finished join\n");
 383:	83 ec 08             	sub    $0x8,%esp
 386:	68 f1 0c 00 00       	push   $0xcf1
 38b:	6a 01                	push   $0x1
 38d:	e8 ee 04 00 00       	call   880 <printf>
	for(i = 0; i<5; i++){
 392:	83 c4 10             	add    $0x10,%esp
 395:	83 ee 01             	sub    $0x1,%esi
 398:	0f 84 a2 00 00 00    	je     440 <mutexTest+0x190>
 39e:	a1 28 12 00 00       	mov    0x1228,%eax
 3a3:	e9 4b ff ff ff       	jmp    2f3 <mutexTest+0x43>
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if(test)printf(1,"Error: mutex didnt prevent writing!\n");
 3b0:	83 ec 08             	sub    $0x8,%esp
 3b3:	68 30 0e 00 00       	push   $0xe30
 3b8:	6a 01                	push   $0x1
 3ba:	e8 c1 04 00 00       	call   880 <printf>
 3bf:	83 c4 10             	add    $0x10,%esp
 3c2:	eb 90                	jmp    354 <mutexTest+0xa4>
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(!test) printf(1,"Error: thread didnt run!\n");
 3c8:	83 ec 08             	sub    $0x8,%esp
 3cb:	68 d7 0c 00 00       	push   $0xcd7
 3d0:	6a 01                	push   $0x1
 3d2:	e8 a9 04 00 00       	call   880 <printf>
 3d7:	83 c4 10             	add    $0x10,%esp
 3da:	eb a7                	jmp    383 <mutexTest+0xd3>
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
 3e0:	83 ec 04             	sub    $0x4,%esp
 3e3:	50                   	push   %eax
 3e4:	68 08 0e 00 00       	push   $0xe08
 3e9:	6a 01                	push   $0x1
 3eb:	e8 90 04 00 00       	call   880 <printf>
 3f0:	83 c4 10             	add    $0x10,%esp
 3f3:	e9 40 ff ff ff       	jmp    338 <mutexTest+0x88>
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if(input<0) printf(1,"Error: mutex didnt unlock!\n");
 400:	83 ec 08             	sub    $0x8,%esp
 403:	68 bb 0c 00 00       	push   $0xcbb
 408:	6a 01                	push   $0x1
 40a:	e8 71 04 00 00       	call   880 <printf>
 40f:	83 c4 10             	add    $0x10,%esp
 412:	e9 56 ff ff ff       	jmp    36d <mutexTest+0xbd>
 417:	89 f6                	mov    %esi,%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
 420:	83 ec 04             	sub    $0x4,%esp
 423:	50                   	push   %eax
 424:	68 e8 0d 00 00       	push   $0xde8
 429:	6a 01                	push   $0x1
 42b:	e8 50 04 00 00       	call   880 <printf>
 430:	83 c4 10             	add    $0x10,%esp
 433:	e9 d9 fe ff ff       	jmp    311 <mutexTest+0x61>
 438:	90                   	nop
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	printf(1,"Exiting\n");
 440:	83 ec 08             	sub    $0x8,%esp
 443:	68 00 0d 00 00       	push   $0xd00
 448:	6a 01                	push   $0x1
 44a:	e8 31 04 00 00       	call   880 <printf>
	input = kthread_mutex_dealloc(mutex);
 44f:	5a                   	pop    %edx
 450:	ff 35 28 12 00 00    	pushl  0x1228
 456:	e8 5f 03 00 00       	call   7ba <kthread_mutex_dealloc>
	if(input<0)
 45b:	83 c4 10             	add    $0x10,%esp
 45e:	85 c0                	test   %eax,%eax
 460:	78 20                	js     482 <mutexTest+0x1d2>
	exit();
 462:	e8 8b 02 00 00       	call   6f2 <exit>
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
 467:	53                   	push   %ebx
 468:	50                   	push   %eax
 469:	68 c8 0d 00 00       	push   $0xdc8
 46e:	6a 01                	push   $0x1
 470:	e8 0b 04 00 00       	call   880 <printf>
 475:	a1 28 12 00 00       	mov    0x1228,%eax
 47a:	83 c4 10             	add    $0x10,%esp
 47d:	e9 6c fe ff ff       	jmp    2ee <mutexTest+0x3e>
		printf(1,"Error: mutex didnt dealloc!\n");
 482:	50                   	push   %eax
 483:	50                   	push   %eax
 484:	68 09 0d 00 00       	push   $0xd09
 489:	6a 01                	push   $0x1
 48b:	e8 f0 03 00 00       	call   880 <printf>
 490:	83 c4 10             	add    $0x10,%esp
 493:	eb cd                	jmp    462 <mutexTest+0x1b2>
 495:	66 90                	xchg   %ax,%ax
 497:	66 90                	xchg   %ax,%ax
 499:	66 90                	xchg   %ax,%ax
 49b:	66 90                	xchg   %ax,%ax
 49d:	66 90                	xchg   %ax,%ax
 49f:	90                   	nop

000004a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	53                   	push   %ebx
 4a4:	8b 45 08             	mov    0x8(%ebp),%eax
 4a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4aa:	89 c2                	mov    %eax,%edx
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b0:	83 c1 01             	add    $0x1,%ecx
 4b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 4b7:	83 c2 01             	add    $0x1,%edx
 4ba:	84 db                	test   %bl,%bl
 4bc:	88 5a ff             	mov    %bl,-0x1(%edx)
 4bf:	75 ef                	jne    4b0 <strcpy+0x10>
    ;
  return os;
}
 4c1:	5b                   	pop    %ebx
 4c2:	5d                   	pop    %ebp
 4c3:	c3                   	ret    
 4c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 55 08             	mov    0x8(%ebp),%edx
 4d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4da:	0f b6 02             	movzbl (%edx),%eax
 4dd:	0f b6 19             	movzbl (%ecx),%ebx
 4e0:	84 c0                	test   %al,%al
 4e2:	75 1c                	jne    500 <strcmp+0x30>
 4e4:	eb 2a                	jmp    510 <strcmp+0x40>
 4e6:	8d 76 00             	lea    0x0(%esi),%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 4f0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 4f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 4f6:	83 c1 01             	add    $0x1,%ecx
 4f9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 4fc:	84 c0                	test   %al,%al
 4fe:	74 10                	je     510 <strcmp+0x40>
 500:	38 d8                	cmp    %bl,%al
 502:	74 ec                	je     4f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 504:	29 d8                	sub    %ebx,%eax
}
 506:	5b                   	pop    %ebx
 507:	5d                   	pop    %ebp
 508:	c3                   	ret    
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 510:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 512:	29 d8                	sub    %ebx,%eax
}
 514:	5b                   	pop    %ebx
 515:	5d                   	pop    %ebp
 516:	c3                   	ret    
 517:	89 f6                	mov    %esi,%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <strlen>:

uint
strlen(const char *s)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 526:	80 39 00             	cmpb   $0x0,(%ecx)
 529:	74 15                	je     540 <strlen+0x20>
 52b:	31 d2                	xor    %edx,%edx
 52d:	8d 76 00             	lea    0x0(%esi),%esi
 530:	83 c2 01             	add    $0x1,%edx
 533:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 537:	89 d0                	mov    %edx,%eax
 539:	75 f5                	jne    530 <strlen+0x10>
    ;
  return n;
}
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret    
 53d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 540:	31 c0                	xor    %eax,%eax
}
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 54a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000550 <memset>:

void*
memset(void *dst, int c, uint n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 557:	8b 4d 10             	mov    0x10(%ebp),%ecx
 55a:	8b 45 0c             	mov    0xc(%ebp),%eax
 55d:	89 d7                	mov    %edx,%edi
 55f:	fc                   	cld    
 560:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 562:	89 d0                	mov    %edx,%eax
 564:	5f                   	pop    %edi
 565:	5d                   	pop    %ebp
 566:	c3                   	ret    
 567:	89 f6                	mov    %esi,%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000570 <strchr>:

char*
strchr(const char *s, char c)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	53                   	push   %ebx
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 57a:	0f b6 10             	movzbl (%eax),%edx
 57d:	84 d2                	test   %dl,%dl
 57f:	74 1d                	je     59e <strchr+0x2e>
    if(*s == c)
 581:	38 d3                	cmp    %dl,%bl
 583:	89 d9                	mov    %ebx,%ecx
 585:	75 0d                	jne    594 <strchr+0x24>
 587:	eb 17                	jmp    5a0 <strchr+0x30>
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 590:	38 ca                	cmp    %cl,%dl
 592:	74 0c                	je     5a0 <strchr+0x30>
  for(; *s; s++)
 594:	83 c0 01             	add    $0x1,%eax
 597:	0f b6 10             	movzbl (%eax),%edx
 59a:	84 d2                	test   %dl,%dl
 59c:	75 f2                	jne    590 <strchr+0x20>
      return (char*)s;
  return 0;
 59e:	31 c0                	xor    %eax,%eax
}
 5a0:	5b                   	pop    %ebx
 5a1:	5d                   	pop    %ebp
 5a2:	c3                   	ret    
 5a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005b0 <gets>:

char*
gets(char *buf, int max)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5b6:	31 f6                	xor    %esi,%esi
 5b8:	89 f3                	mov    %esi,%ebx
{
 5ba:	83 ec 1c             	sub    $0x1c,%esp
 5bd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 5c0:	eb 2f                	jmp    5f1 <gets+0x41>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 5c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5cb:	83 ec 04             	sub    $0x4,%esp
 5ce:	6a 01                	push   $0x1
 5d0:	50                   	push   %eax
 5d1:	6a 00                	push   $0x0
 5d3:	e8 32 01 00 00       	call   70a <read>
    if(cc < 1)
 5d8:	83 c4 10             	add    $0x10,%esp
 5db:	85 c0                	test   %eax,%eax
 5dd:	7e 1c                	jle    5fb <gets+0x4b>
      break;
    buf[i++] = c;
 5df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5e3:	83 c7 01             	add    $0x1,%edi
 5e6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 5e9:	3c 0a                	cmp    $0xa,%al
 5eb:	74 23                	je     610 <gets+0x60>
 5ed:	3c 0d                	cmp    $0xd,%al
 5ef:	74 1f                	je     610 <gets+0x60>
  for(i=0; i+1 < max; ){
 5f1:	83 c3 01             	add    $0x1,%ebx
 5f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5f7:	89 fe                	mov    %edi,%esi
 5f9:	7c cd                	jl     5c8 <gets+0x18>
 5fb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 5fd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 600:	c6 03 00             	movb   $0x0,(%ebx)
}
 603:	8d 65 f4             	lea    -0xc(%ebp),%esp
 606:	5b                   	pop    %ebx
 607:	5e                   	pop    %esi
 608:	5f                   	pop    %edi
 609:	5d                   	pop    %ebp
 60a:	c3                   	ret    
 60b:	90                   	nop
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 610:	8b 75 08             	mov    0x8(%ebp),%esi
 613:	8b 45 08             	mov    0x8(%ebp),%eax
 616:	01 de                	add    %ebx,%esi
 618:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 61a:	c6 03 00             	movb   $0x0,(%ebx)
}
 61d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 620:	5b                   	pop    %ebx
 621:	5e                   	pop    %esi
 622:	5f                   	pop    %edi
 623:	5d                   	pop    %ebp
 624:	c3                   	ret    
 625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <stat>:

int
stat(const char *n, struct stat *st)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	56                   	push   %esi
 634:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 635:	83 ec 08             	sub    $0x8,%esp
 638:	6a 00                	push   $0x0
 63a:	ff 75 08             	pushl  0x8(%ebp)
 63d:	e8 f0 00 00 00       	call   732 <open>
  if(fd < 0)
 642:	83 c4 10             	add    $0x10,%esp
 645:	85 c0                	test   %eax,%eax
 647:	78 27                	js     670 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	ff 75 0c             	pushl  0xc(%ebp)
 64f:	89 c3                	mov    %eax,%ebx
 651:	50                   	push   %eax
 652:	e8 f3 00 00 00       	call   74a <fstat>
  close(fd);
 657:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 65a:	89 c6                	mov    %eax,%esi
  close(fd);
 65c:	e8 b9 00 00 00       	call   71a <close>
  return r;
 661:	83 c4 10             	add    $0x10,%esp
}
 664:	8d 65 f8             	lea    -0x8(%ebp),%esp
 667:	89 f0                	mov    %esi,%eax
 669:	5b                   	pop    %ebx
 66a:	5e                   	pop    %esi
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
 66d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 670:	be ff ff ff ff       	mov    $0xffffffff,%esi
 675:	eb ed                	jmp    664 <stat+0x34>
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <atoi>:

int
atoi(const char *s)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	53                   	push   %ebx
 684:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 687:	0f be 11             	movsbl (%ecx),%edx
 68a:	8d 42 d0             	lea    -0x30(%edx),%eax
 68d:	3c 09                	cmp    $0x9,%al
  n = 0;
 68f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 694:	77 1f                	ja     6b5 <atoi+0x35>
 696:	8d 76 00             	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 6a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6a3:	83 c1 01             	add    $0x1,%ecx
 6a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 6aa:	0f be 11             	movsbl (%ecx),%edx
 6ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6b0:	80 fb 09             	cmp    $0x9,%bl
 6b3:	76 eb                	jbe    6a0 <atoi+0x20>
  return n;
}
 6b5:	5b                   	pop    %ebx
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
 6b8:	90                   	nop
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	56                   	push   %esi
 6c4:	53                   	push   %ebx
 6c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6c8:	8b 45 08             	mov    0x8(%ebp),%eax
 6cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ce:	85 db                	test   %ebx,%ebx
 6d0:	7e 14                	jle    6e6 <memmove+0x26>
 6d2:	31 d2                	xor    %edx,%edx
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 6d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 6dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 6df:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 6e2:	39 d3                	cmp    %edx,%ebx
 6e4:	75 f2                	jne    6d8 <memmove+0x18>
  return vdst;
}
 6e6:	5b                   	pop    %ebx
 6e7:	5e                   	pop    %esi
 6e8:	5d                   	pop    %ebp
 6e9:	c3                   	ret    

000006ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6ea:	b8 01 00 00 00       	mov    $0x1,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <exit>:
SYSCALL(exit)
 6f2:	b8 02 00 00 00       	mov    $0x2,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <wait>:
SYSCALL(wait)
 6fa:	b8 03 00 00 00       	mov    $0x3,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <pipe>:
SYSCALL(pipe)
 702:	b8 04 00 00 00       	mov    $0x4,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <read>:
SYSCALL(read)
 70a:	b8 05 00 00 00       	mov    $0x5,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <write>:
SYSCALL(write)
 712:	b8 10 00 00 00       	mov    $0x10,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <close>:
SYSCALL(close)
 71a:	b8 15 00 00 00       	mov    $0x15,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <kill>:
SYSCALL(kill)
 722:	b8 06 00 00 00       	mov    $0x6,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <exec>:
SYSCALL(exec)
 72a:	b8 07 00 00 00       	mov    $0x7,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <open>:
SYSCALL(open)
 732:	b8 0f 00 00 00       	mov    $0xf,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <mknod>:
SYSCALL(mknod)
 73a:	b8 11 00 00 00       	mov    $0x11,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <unlink>:
SYSCALL(unlink)
 742:	b8 12 00 00 00       	mov    $0x12,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <fstat>:
SYSCALL(fstat)
 74a:	b8 08 00 00 00       	mov    $0x8,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <link>:
SYSCALL(link)
 752:	b8 13 00 00 00       	mov    $0x13,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <mkdir>:
SYSCALL(mkdir)
 75a:	b8 14 00 00 00       	mov    $0x14,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <chdir>:
SYSCALL(chdir)
 762:	b8 09 00 00 00       	mov    $0x9,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <dup>:
SYSCALL(dup)
 76a:	b8 0a 00 00 00       	mov    $0xa,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <getpid>:
SYSCALL(getpid)
 772:	b8 0b 00 00 00       	mov    $0xb,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    

0000077a <sbrk>:
SYSCALL(sbrk)
 77a:	b8 0c 00 00 00       	mov    $0xc,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret    

00000782 <sleep>:
SYSCALL(sleep)
 782:	b8 0d 00 00 00       	mov    $0xd,%eax
 787:	cd 40                	int    $0x40
 789:	c3                   	ret    

0000078a <uptime>:
SYSCALL(uptime)
 78a:	b8 0e 00 00 00       	mov    $0xe,%eax
 78f:	cd 40                	int    $0x40
 791:	c3                   	ret    

00000792 <kthread_create>:
SYSCALL(kthread_create)
 792:	b8 16 00 00 00       	mov    $0x16,%eax
 797:	cd 40                	int    $0x40
 799:	c3                   	ret    

0000079a <kthread_id>:
SYSCALL(kthread_id)
 79a:	b8 17 00 00 00       	mov    $0x17,%eax
 79f:	cd 40                	int    $0x40
 7a1:	c3                   	ret    

000007a2 <kthread_exit>:
SYSCALL(kthread_exit)
 7a2:	b8 18 00 00 00       	mov    $0x18,%eax
 7a7:	cd 40                	int    $0x40
 7a9:	c3                   	ret    

000007aa <kthread_join>:
SYSCALL(kthread_join)
 7aa:	b8 19 00 00 00       	mov    $0x19,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 7b2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 7ba:	b8 1b 00 00 00       	mov    $0x1b,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 7c2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 7ca:	b8 1d 00 00 00       	mov    $0x1d,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    
 7d2:	66 90                	xchg   %ax,%ax
 7d4:	66 90                	xchg   %ax,%ax
 7d6:	66 90                	xchg   %ax,%ax
 7d8:	66 90                	xchg   %ax,%ax
 7da:	66 90                	xchg   %ax,%ax
 7dc:	66 90                	xchg   %ax,%ax
 7de:	66 90                	xchg   %ax,%ax

000007e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7e9:	85 d2                	test   %edx,%edx
{
 7eb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 7ee:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 7f0:	79 76                	jns    868 <printint+0x88>
 7f2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 7f6:	74 70                	je     868 <printint+0x88>
    x = -xx;
 7f8:	f7 d8                	neg    %eax
    neg = 1;
 7fa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 801:	31 f6                	xor    %esi,%esi
 803:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 806:	eb 0a                	jmp    812 <printint+0x32>
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 810:	89 fe                	mov    %edi,%esi
 812:	31 d2                	xor    %edx,%edx
 814:	8d 7e 01             	lea    0x1(%esi),%edi
 817:	f7 f1                	div    %ecx
 819:	0f b6 92 60 0e 00 00 	movzbl 0xe60(%edx),%edx
  }while((x /= base) != 0);
 820:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 822:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 825:	75 e9                	jne    810 <printint+0x30>
  if(neg)
 827:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 82a:	85 c0                	test   %eax,%eax
 82c:	74 08                	je     836 <printint+0x56>
    buf[i++] = '-';
 82e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 833:	8d 7e 02             	lea    0x2(%esi),%edi
 836:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 83a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 83d:	8d 76 00             	lea    0x0(%esi),%esi
 840:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 843:	83 ec 04             	sub    $0x4,%esp
 846:	83 ee 01             	sub    $0x1,%esi
 849:	6a 01                	push   $0x1
 84b:	53                   	push   %ebx
 84c:	57                   	push   %edi
 84d:	88 45 d7             	mov    %al,-0x29(%ebp)
 850:	e8 bd fe ff ff       	call   712 <write>

  while(--i >= 0)
 855:	83 c4 10             	add    $0x10,%esp
 858:	39 de                	cmp    %ebx,%esi
 85a:	75 e4                	jne    840 <printint+0x60>
    putc(fd, buf[i]);
}
 85c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 85f:	5b                   	pop    %ebx
 860:	5e                   	pop    %esi
 861:	5f                   	pop    %edi
 862:	5d                   	pop    %ebp
 863:	c3                   	ret    
 864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 868:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 86f:	eb 90                	jmp    801 <printint+0x21>
 871:	eb 0d                	jmp    880 <printf>
 873:	90                   	nop
 874:	90                   	nop
 875:	90                   	nop
 876:	90                   	nop
 877:	90                   	nop
 878:	90                   	nop
 879:	90                   	nop
 87a:	90                   	nop
 87b:	90                   	nop
 87c:	90                   	nop
 87d:	90                   	nop
 87e:	90                   	nop
 87f:	90                   	nop

00000880 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 889:	8b 75 0c             	mov    0xc(%ebp),%esi
 88c:	0f b6 1e             	movzbl (%esi),%ebx
 88f:	84 db                	test   %bl,%bl
 891:	0f 84 b3 00 00 00    	je     94a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 897:	8d 45 10             	lea    0x10(%ebp),%eax
 89a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 89d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 89f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8a2:	eb 2f                	jmp    8d3 <printf+0x53>
 8a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 8a8:	83 f8 25             	cmp    $0x25,%eax
 8ab:	0f 84 a7 00 00 00    	je     958 <printf+0xd8>
  write(fd, &c, 1);
 8b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8b4:	83 ec 04             	sub    $0x4,%esp
 8b7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 8ba:	6a 01                	push   $0x1
 8bc:	50                   	push   %eax
 8bd:	ff 75 08             	pushl  0x8(%ebp)
 8c0:	e8 4d fe ff ff       	call   712 <write>
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 8cb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 8cf:	84 db                	test   %bl,%bl
 8d1:	74 77                	je     94a <printf+0xca>
    if(state == 0){
 8d3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 8d5:	0f be cb             	movsbl %bl,%ecx
 8d8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 8db:	74 cb                	je     8a8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8dd:	83 ff 25             	cmp    $0x25,%edi
 8e0:	75 e6                	jne    8c8 <printf+0x48>
      if(c == 'd'){
 8e2:	83 f8 64             	cmp    $0x64,%eax
 8e5:	0f 84 05 01 00 00    	je     9f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 8eb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 8f1:	83 f9 70             	cmp    $0x70,%ecx
 8f4:	74 72                	je     968 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 8f6:	83 f8 73             	cmp    $0x73,%eax
 8f9:	0f 84 99 00 00 00    	je     998 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8ff:	83 f8 63             	cmp    $0x63,%eax
 902:	0f 84 08 01 00 00    	je     a10 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 908:	83 f8 25             	cmp    $0x25,%eax
 90b:	0f 84 ef 00 00 00    	je     a00 <printf+0x180>
  write(fd, &c, 1);
 911:	8d 45 e7             	lea    -0x19(%ebp),%eax
 914:	83 ec 04             	sub    $0x4,%esp
 917:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 91b:	6a 01                	push   $0x1
 91d:	50                   	push   %eax
 91e:	ff 75 08             	pushl  0x8(%ebp)
 921:	e8 ec fd ff ff       	call   712 <write>
 926:	83 c4 0c             	add    $0xc,%esp
 929:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 92c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 92f:	6a 01                	push   $0x1
 931:	50                   	push   %eax
 932:	ff 75 08             	pushl  0x8(%ebp)
 935:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 938:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 93a:	e8 d3 fd ff ff       	call   712 <write>
  for(i = 0; fmt[i]; i++){
 93f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 943:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 946:	84 db                	test   %bl,%bl
 948:	75 89                	jne    8d3 <printf+0x53>
    }
  }
}
 94a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 94d:	5b                   	pop    %ebx
 94e:	5e                   	pop    %esi
 94f:	5f                   	pop    %edi
 950:	5d                   	pop    %ebp
 951:	c3                   	ret    
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 958:	bf 25 00 00 00       	mov    $0x25,%edi
 95d:	e9 66 ff ff ff       	jmp    8c8 <printf+0x48>
 962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 968:	83 ec 0c             	sub    $0xc,%esp
 96b:	b9 10 00 00 00       	mov    $0x10,%ecx
 970:	6a 00                	push   $0x0
 972:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 975:	8b 45 08             	mov    0x8(%ebp),%eax
 978:	8b 17                	mov    (%edi),%edx
 97a:	e8 61 fe ff ff       	call   7e0 <printint>
        ap++;
 97f:	89 f8                	mov    %edi,%eax
 981:	83 c4 10             	add    $0x10,%esp
      state = 0;
 984:	31 ff                	xor    %edi,%edi
        ap++;
 986:	83 c0 04             	add    $0x4,%eax
 989:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 98c:	e9 37 ff ff ff       	jmp    8c8 <printf+0x48>
 991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 998:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 99b:	8b 08                	mov    (%eax),%ecx
        ap++;
 99d:	83 c0 04             	add    $0x4,%eax
 9a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 9a3:	85 c9                	test   %ecx,%ecx
 9a5:	0f 84 8e 00 00 00    	je     a39 <printf+0x1b9>
        while(*s != 0){
 9ab:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 9ae:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 9b0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 9b2:	84 c0                	test   %al,%al
 9b4:	0f 84 0e ff ff ff    	je     8c8 <printf+0x48>
 9ba:	89 75 d0             	mov    %esi,-0x30(%ebp)
 9bd:	89 de                	mov    %ebx,%esi
 9bf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9c2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 9c5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9c8:	83 ec 04             	sub    $0x4,%esp
          s++;
 9cb:	83 c6 01             	add    $0x1,%esi
 9ce:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 9d1:	6a 01                	push   $0x1
 9d3:	57                   	push   %edi
 9d4:	53                   	push   %ebx
 9d5:	e8 38 fd ff ff       	call   712 <write>
        while(*s != 0){
 9da:	0f b6 06             	movzbl (%esi),%eax
 9dd:	83 c4 10             	add    $0x10,%esp
 9e0:	84 c0                	test   %al,%al
 9e2:	75 e4                	jne    9c8 <printf+0x148>
 9e4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 9e7:	31 ff                	xor    %edi,%edi
 9e9:	e9 da fe ff ff       	jmp    8c8 <printf+0x48>
 9ee:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 9f0:	83 ec 0c             	sub    $0xc,%esp
 9f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9f8:	6a 01                	push   $0x1
 9fa:	e9 73 ff ff ff       	jmp    972 <printf+0xf2>
 9ff:	90                   	nop
  write(fd, &c, 1);
 a00:	83 ec 04             	sub    $0x4,%esp
 a03:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a06:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a09:	6a 01                	push   $0x1
 a0b:	e9 21 ff ff ff       	jmp    931 <printf+0xb1>
        putc(fd, *ap);
 a10:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a13:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a16:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a18:	6a 01                	push   $0x1
        ap++;
 a1a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a1d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a20:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a23:	50                   	push   %eax
 a24:	ff 75 08             	pushl  0x8(%ebp)
 a27:	e8 e6 fc ff ff       	call   712 <write>
        ap++;
 a2c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a2f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a32:	31 ff                	xor    %edi,%edi
 a34:	e9 8f fe ff ff       	jmp    8c8 <printf+0x48>
          s = "(null)";
 a39:	bb 58 0e 00 00       	mov    $0xe58,%ebx
        while(*s != 0){
 a3e:	b8 28 00 00 00       	mov    $0x28,%eax
 a43:	e9 72 ff ff ff       	jmp    9ba <printf+0x13a>
 a48:	66 90                	xchg   %ax,%ax
 a4a:	66 90                	xchg   %ax,%ax
 a4c:	66 90                	xchg   %ax,%ax
 a4e:	66 90                	xchg   %ax,%ax

00000a50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a50:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a51:	a1 1c 12 00 00       	mov    0x121c,%eax
{
 a56:	89 e5                	mov    %esp,%ebp
 a58:	57                   	push   %edi
 a59:	56                   	push   %esi
 a5a:	53                   	push   %ebx
 a5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a5e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a68:	39 c8                	cmp    %ecx,%eax
 a6a:	8b 10                	mov    (%eax),%edx
 a6c:	73 32                	jae    aa0 <free+0x50>
 a6e:	39 d1                	cmp    %edx,%ecx
 a70:	72 04                	jb     a76 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a72:	39 d0                	cmp    %edx,%eax
 a74:	72 32                	jb     aa8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a76:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a79:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a7c:	39 fa                	cmp    %edi,%edx
 a7e:	74 30                	je     ab0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a80:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a83:	8b 50 04             	mov    0x4(%eax),%edx
 a86:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a89:	39 f1                	cmp    %esi,%ecx
 a8b:	74 3a                	je     ac7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a8d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a8f:	a3 1c 12 00 00       	mov    %eax,0x121c
}
 a94:	5b                   	pop    %ebx
 a95:	5e                   	pop    %esi
 a96:	5f                   	pop    %edi
 a97:	5d                   	pop    %ebp
 a98:	c3                   	ret    
 a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa0:	39 d0                	cmp    %edx,%eax
 aa2:	72 04                	jb     aa8 <free+0x58>
 aa4:	39 d1                	cmp    %edx,%ecx
 aa6:	72 ce                	jb     a76 <free+0x26>
{
 aa8:	89 d0                	mov    %edx,%eax
 aaa:	eb bc                	jmp    a68 <free+0x18>
 aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ab0:	03 72 04             	add    0x4(%edx),%esi
 ab3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ab6:	8b 10                	mov    (%eax),%edx
 ab8:	8b 12                	mov    (%edx),%edx
 aba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 abd:	8b 50 04             	mov    0x4(%eax),%edx
 ac0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ac3:	39 f1                	cmp    %esi,%ecx
 ac5:	75 c6                	jne    a8d <free+0x3d>
    p->s.size += bp->s.size;
 ac7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 aca:	a3 1c 12 00 00       	mov    %eax,0x121c
    p->s.size += bp->s.size;
 acf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ad2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ad5:	89 10                	mov    %edx,(%eax)
}
 ad7:	5b                   	pop    %ebx
 ad8:	5e                   	pop    %esi
 ad9:	5f                   	pop    %edi
 ada:	5d                   	pop    %ebp
 adb:	c3                   	ret    
 adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	57                   	push   %edi
 ae4:	56                   	push   %esi
 ae5:	53                   	push   %ebx
 ae6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 aec:	8b 15 1c 12 00 00    	mov    0x121c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af2:	8d 78 07             	lea    0x7(%eax),%edi
 af5:	c1 ef 03             	shr    $0x3,%edi
 af8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 afb:	85 d2                	test   %edx,%edx
 afd:	0f 84 9d 00 00 00    	je     ba0 <malloc+0xc0>
 b03:	8b 02                	mov    (%edx),%eax
 b05:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b08:	39 cf                	cmp    %ecx,%edi
 b0a:	76 6c                	jbe    b78 <malloc+0x98>
 b0c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b12:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b17:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b1a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b21:	eb 0e                	jmp    b31 <malloc+0x51>
 b23:	90                   	nop
 b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b28:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b2a:	8b 48 04             	mov    0x4(%eax),%ecx
 b2d:	39 f9                	cmp    %edi,%ecx
 b2f:	73 47                	jae    b78 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b31:	39 05 1c 12 00 00    	cmp    %eax,0x121c
 b37:	89 c2                	mov    %eax,%edx
 b39:	75 ed                	jne    b28 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b3b:	83 ec 0c             	sub    $0xc,%esp
 b3e:	56                   	push   %esi
 b3f:	e8 36 fc ff ff       	call   77a <sbrk>
  if(p == (char*)-1)
 b44:	83 c4 10             	add    $0x10,%esp
 b47:	83 f8 ff             	cmp    $0xffffffff,%eax
 b4a:	74 1c                	je     b68 <malloc+0x88>
  hp->s.size = nu;
 b4c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b4f:	83 ec 0c             	sub    $0xc,%esp
 b52:	83 c0 08             	add    $0x8,%eax
 b55:	50                   	push   %eax
 b56:	e8 f5 fe ff ff       	call   a50 <free>
  return freep;
 b5b:	8b 15 1c 12 00 00    	mov    0x121c,%edx
      if((p = morecore(nunits)) == 0)
 b61:	83 c4 10             	add    $0x10,%esp
 b64:	85 d2                	test   %edx,%edx
 b66:	75 c0                	jne    b28 <malloc+0x48>
        return 0;
  }
}
 b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b6b:	31 c0                	xor    %eax,%eax
}
 b6d:	5b                   	pop    %ebx
 b6e:	5e                   	pop    %esi
 b6f:	5f                   	pop    %edi
 b70:	5d                   	pop    %ebp
 b71:	c3                   	ret    
 b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b78:	39 cf                	cmp    %ecx,%edi
 b7a:	74 54                	je     bd0 <malloc+0xf0>
        p->s.size -= nunits;
 b7c:	29 f9                	sub    %edi,%ecx
 b7e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b81:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b84:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b87:	89 15 1c 12 00 00    	mov    %edx,0x121c
}
 b8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b90:	83 c0 08             	add    $0x8,%eax
}
 b93:	5b                   	pop    %ebx
 b94:	5e                   	pop    %esi
 b95:	5f                   	pop    %edi
 b96:	5d                   	pop    %ebp
 b97:	c3                   	ret    
 b98:	90                   	nop
 b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 ba0:	c7 05 1c 12 00 00 20 	movl   $0x1220,0x121c
 ba7:	12 00 00 
 baa:	c7 05 20 12 00 00 20 	movl   $0x1220,0x1220
 bb1:	12 00 00 
    base.s.size = 0;
 bb4:	b8 20 12 00 00       	mov    $0x1220,%eax
 bb9:	c7 05 24 12 00 00 00 	movl   $0x0,0x1224
 bc0:	00 00 00 
 bc3:	e9 44 ff ff ff       	jmp    b0c <malloc+0x2c>
 bc8:	90                   	nop
 bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 bd0:	8b 08                	mov    (%eax),%ecx
 bd2:	89 0a                	mov    %ecx,(%edx)
 bd4:	eb b1                	jmp    b87 <malloc+0xa7>
