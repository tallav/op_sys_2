
_myprog:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  //exit();
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
	for(int i = 0; i < 200; i++){
   f:	31 db                	xor    %ebx,%ebx
  11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		printf(1, "loop - %d\n", i);
  18:	83 ec 04             	sub    $0x4,%esp
  1b:	53                   	push   %ebx
  1c:	68 1e 11 00 00       	push   $0x111e
	for(int i = 0; i < 200; i++){
  21:	83 c3 01             	add    $0x1,%ebx
		printf(1, "loop - %d\n", i);
  24:	6a 01                	push   $0x1
  26:	e8 c5 0a 00 00       	call   af0 <printf>
    	mutexTest();
  2b:	e8 a0 01 00 00       	call   1d0 <mutexTest>
	for(int i = 0; i < 200; i++){
  30:	83 c4 10             	add    $0x10,%esp
  33:	81 fb c8 00 00 00    	cmp    $0xc8,%ebx
  39:	75 dd                	jne    18 <main+0x18>
	}
	for(int i = 0 ; i < 10; i++){
		threadTest3();
	}
	*/
    exit();
  3b:	e8 22 09 00 00       	call   962 <exit>

00000040 <printer>:
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 14             	sub    $0x14,%esp
	int input = kthread_mutex_lock(mutex);
  46:	ff 35 68 15 00 00    	pushl  0x1568
  4c:	e8 e1 09 00 00       	call   a32 <kthread_mutex_lock>
	if(input<0)
  51:	83 c4 10             	add    $0x10,%esp
  54:	85 c0                	test   %eax,%eax
  56:	78 68                	js     c0 <printer+0x80>
	printf(1,"thread %d said hi\n",kthread_id());
  58:	e8 ad 09 00 00       	call   a0a <kthread_id>
  5d:	83 ec 04             	sub    $0x4,%esp
  60:	50                   	push   %eax
  61:	68 a4 0f 00 00       	push   $0xfa4
  66:	6a 01                	push   $0x1
  68:	e8 83 0a 00 00       	call   af0 <printf>
	input = kthread_mutex_unlock(mutex);
  6d:	58                   	pop    %eax
  6e:	ff 35 68 15 00 00    	pushl  0x1568
	test=1;
  74:	c7 05 6c 15 00 00 01 	movl   $0x1,0x156c
  7b:	00 00 00 
	input = kthread_mutex_unlock(mutex);
  7e:	e8 b7 09 00 00       	call   a3a <kthread_mutex_unlock>
	if(input<0)
  83:	83 c4 10             	add    $0x10,%esp
  86:	85 c0                	test   %eax,%eax
  88:	78 1e                	js     a8 <printer+0x68>
	kthread_exit();
  8a:	e8 83 09 00 00       	call   a12 <kthread_exit>
	printf(1,"Error: returned from exit !!");
  8f:	83 ec 08             	sub    $0x8,%esp
  92:	68 b7 0f 00 00       	push   $0xfb7
  97:	6a 01                	push   $0x1
  99:	e8 52 0a 00 00       	call   af0 <printf>
}
  9e:	83 c4 10             	add    $0x10,%esp
  a1:	c9                   	leave  
  a2:	c3                   	ret    
  a3:	90                   	nop
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: thread mutex didnt unlock!");
  a8:	83 ec 08             	sub    $0x8,%esp
  ab:	68 68 0e 00 00       	push   $0xe68
  b0:	6a 01                	push   $0x1
  b2:	e8 39 0a 00 00       	call   af0 <printf>
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	eb ce                	jmp    8a <printer+0x4a>
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: thread mutex didnt lock!");
  c0:	83 ec 08             	sub    $0x8,%esp
  c3:	68 48 0e 00 00       	push   $0xe48
  c8:	6a 01                	push   $0x1
  ca:	e8 21 0a 00 00       	call   af0 <printf>
  cf:	83 c4 10             	add    $0x10,%esp
  d2:	eb 84                	jmp    58 <printer+0x18>
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <printme>:
void printme() {
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	83 ec 08             	sub    $0x8,%esp
  printf(1,"Thread %d running !\n", kthread_id());
  e6:	e8 1f 09 00 00       	call   a0a <kthread_id>
  eb:	83 ec 04             	sub    $0x4,%esp
  ee:	50                   	push   %eax
  ef:	68 d4 0f 00 00       	push   $0xfd4
  f4:	6a 01                	push   $0x1
  f6:	e8 f5 09 00 00       	call   af0 <printf>
  kthread_exit();
  fb:	83 c4 10             	add    $0x10,%esp
}
  fe:	c9                   	leave  
  kthread_exit();
  ff:	e9 0e 09 00 00       	jmp    a12 <kthread_exit>
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <run>:
void run(){
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	83 ec 04             	sub    $0x4,%esp
	int id = kthread_id();
 117:	e8 ee 08 00 00       	call   a0a <kthread_id>
 11c:	89 c3                	mov    %eax,%ebx
	printf(1, "my id: %d\n", id);
 11e:	83 ec 04             	sub    $0x4,%esp
	sleep(id*100);
 121:	6b db 64             	imul   $0x64,%ebx,%ebx
	printf(1, "my id: %d\n", id);
 124:	50                   	push   %eax
 125:	68 e9 0f 00 00       	push   $0xfe9
 12a:	6a 01                	push   $0x1
 12c:	e8 bf 09 00 00       	call   af0 <printf>
	sleep(id*100);
 131:	89 1c 24             	mov    %ebx,(%esp)
 134:	e8 b9 08 00 00       	call   9f2 <sleep>
	printf(1,"hello\n");
 139:	58                   	pop    %eax
 13a:	5a                   	pop    %edx
 13b:	68 f4 0f 00 00       	push   $0xff4
 140:	6a 01                	push   $0x1
 142:	e8 a9 09 00 00       	call   af0 <printf>
	kthread_exit();
 147:	83 c4 10             	add    $0x10,%esp
}
 14a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 14d:	c9                   	leave  
	kthread_exit();
 14e:	e9 bf 08 00 00       	jmp    a12 <kthread_exit>
 153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <print_id>:
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 08             	sub    $0x8,%esp
	printf(1,"Thread id is: %d\n",kthread_id());
 166:	e8 9f 08 00 00       	call   a0a <kthread_id>
 16b:	83 ec 04             	sub    $0x4,%esp
 16e:	50                   	push   %eax
 16f:	68 fb 0f 00 00       	push   $0xffb
 174:	6a 01                	push   $0x1
 176:	e8 75 09 00 00       	call   af0 <printf>
	sleep(1000);
 17b:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
 182:	e8 6b 08 00 00       	call   9f2 <sleep>
	printf(1,"Thread is exiting.\n");
 187:	58                   	pop    %eax
 188:	5a                   	pop    %edx
 189:	68 0d 10 00 00       	push   $0x100d
 18e:	6a 01                	push   $0x1
 190:	e8 5b 09 00 00       	call   af0 <printf>
	kthread_exit();
 195:	83 c4 10             	add    $0x10,%esp
}
 198:	c9                   	leave  
	kthread_exit();
 199:	e9 74 08 00 00       	jmp    a12 <kthread_exit>
 19e:	66 90                	xchg   %ax,%ax

000001a0 <printBLABLA>:
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	83 ec 10             	sub    $0x10,%esp
	printf(1,"blabla.\n");
 1a6:	68 21 10 00 00       	push   $0x1021
 1ab:	6a 01                	push   $0x1
 1ad:	e8 3e 09 00 00       	call   af0 <printf>
	sleep(500);
 1b2:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
 1b9:	e8 34 08 00 00       	call   9f2 <sleep>
	kthread_exit();
 1be:	83 c4 10             	add    $0x10,%esp
}
 1c1:	c9                   	leave  
	kthread_exit();
 1c2:	e9 4b 08 00 00       	jmp    a12 <kthread_exit>
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <mutexTest>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
	printf(1,"~~~~~~~~~~~~~~~~~~\ntest starts\nIf it ends without Errors you win! : )\n~~~~~~~~~~~~~~~~~~\n");
 1d5:	83 ec 08             	sub    $0x8,%esp
 1d8:	68 8c 0e 00 00       	push   $0xe8c
 1dd:	6a 01                	push   $0x1
 1df:	e8 0c 09 00 00       	call   af0 <printf>
	mutex = kthread_mutex_alloc();
 1e4:	e8 39 08 00 00       	call   a22 <kthread_mutex_alloc>
	printf(1,"the mutex: %d\n",mutex);
 1e9:	83 c4 0c             	add    $0xc,%esp
	mutex = kthread_mutex_alloc();
 1ec:	a3 68 15 00 00       	mov    %eax,0x1568
	printf(1,"the mutex: %d\n",mutex);
 1f1:	50                   	push   %eax
 1f2:	68 2a 10 00 00       	push   $0x102a
 1f7:	6a 01                	push   $0x1
 1f9:	e8 f2 08 00 00       	call   af0 <printf>
	if(mutex<0)
 1fe:	a1 68 15 00 00       	mov    0x1568,%eax
 203:	83 c4 10             	add    $0x10,%esp
 206:	85 c0                	test   %eax,%eax
 208:	0f 88 92 01 00 00    	js     3a0 <mutexTest+0x1d0>
{
 20e:	31 f6                	xor    %esi,%esi
 210:	eb 57                	jmp    269 <mutexTest+0x99>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		input = kthread_mutex_unlock(mutex);
 218:	83 ec 0c             	sub    $0xc,%esp
 21b:	ff 35 68 15 00 00    	pushl  0x1568
 221:	e8 14 08 00 00       	call   a3a <kthread_mutex_unlock>
		if(input<0) printf(1,"Error: mutex didnt unlock!\n");
 226:	83 c4 10             	add    $0x10,%esp
 229:	85 c0                	test   %eax,%eax
 22b:	0f 88 07 01 00 00    	js     338 <mutexTest+0x168>
		kthread_join(tid);
 231:	83 ec 0c             	sub    $0xc,%esp
 234:	53                   	push   %ebx
 235:	e8 e0 07 00 00       	call   a1a <kthread_join>
		if(!test) printf(1,"Error: thread didnt run!\n");
 23a:	8b 15 6c 15 00 00    	mov    0x156c,%edx
 240:	83 c4 10             	add    $0x10,%esp
 243:	85 d2                	test   %edx,%edx
 245:	0f 84 b5 00 00 00    	je     300 <mutexTest+0x130>
		printf(1,"finished join\n");
 24b:	83 ec 08             	sub    $0x8,%esp
	for(i = 0; i<20; i++){
 24e:	83 c6 01             	add    $0x1,%esi
		printf(1,"finished join\n");
 251:	68 7a 10 00 00       	push   $0x107a
 256:	6a 01                	push   $0x1
 258:	e8 93 08 00 00       	call   af0 <printf>
	for(i = 0; i<20; i++){
 25d:	83 c4 10             	add    $0x10,%esp
 260:	83 fe 14             	cmp    $0x14,%esi
 263:	0f 84 07 01 00 00    	je     370 <mutexTest+0x1a0>
        printf(1,"index: %d\n",i);
 269:	83 ec 04             	sub    $0x4,%esp
 26c:	56                   	push   %esi
 26d:	68 39 10 00 00       	push   $0x1039
 272:	6a 01                	push   $0x1
 274:	e8 77 08 00 00       	call   af0 <printf>
		input = kthread_mutex_lock(mutex);
 279:	59                   	pop    %ecx
 27a:	ff 35 68 15 00 00    	pushl  0x1568
		test=0;
 280:	c7 05 6c 15 00 00 00 	movl   $0x0,0x156c
 287:	00 00 00 
		input = kthread_mutex_lock(mutex);
 28a:	e8 a3 07 00 00       	call   a32 <kthread_mutex_lock>
		if(input<0) printf(1,"Error: mutex didnt lock! (%d)\n",input);
 28f:	83 c4 10             	add    $0x10,%esp
 292:	85 c0                	test   %eax,%eax
 294:	0f 88 b6 00 00 00    	js     350 <mutexTest+0x180>
		char* stack =  ((char *) malloc(STACK_SIZE * sizeof(char))) + STACK_SIZE;
 29a:	83 ec 0c             	sub    $0xc,%esp
 29d:	68 f4 01 00 00       	push   $0x1f4
 2a2:	e8 a9 0a 00 00       	call   d50 <malloc>
		int tid = kthread_create ((void*)printer, stack);
 2a7:	5b                   	pop    %ebx
 2a8:	5a                   	pop    %edx
		char* stack =  ((char *) malloc(STACK_SIZE * sizeof(char))) + STACK_SIZE;
 2a9:	05 f4 01 00 00       	add    $0x1f4,%eax
		int tid = kthread_create ((void*)printer, stack);
 2ae:	50                   	push   %eax
 2af:	68 40 00 00 00       	push   $0x40
 2b4:	e8 49 07 00 00       	call   a02 <kthread_create>
		printf(1, "process id=%d, created thread with id: %d\n", tid);
 2b9:	83 c4 0c             	add    $0xc,%esp
		int tid = kthread_create ((void*)printer, stack);
 2bc:	89 c3                	mov    %eax,%ebx
		printf(1, "process id=%d, created thread with id: %d\n", tid);
 2be:	50                   	push   %eax
 2bf:	68 28 0f 00 00       	push   $0xf28
 2c4:	6a 01                	push   $0x1
 2c6:	e8 25 08 00 00       	call   af0 <printf>
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
 2cb:	83 c4 10             	add    $0x10,%esp
 2ce:	85 db                	test   %ebx,%ebx
 2d0:	78 4e                	js     320 <mutexTest+0x150>
		if(test)printf(1,"Error: mutex didnt prevent writing!\n");
 2d2:	8b 0d 6c 15 00 00    	mov    0x156c,%ecx
 2d8:	85 c9                	test   %ecx,%ecx
 2da:	0f 84 38 ff ff ff    	je     218 <mutexTest+0x48>
 2e0:	83 ec 08             	sub    $0x8,%esp
 2e3:	68 7c 0f 00 00       	push   $0xf7c
 2e8:	6a 01                	push   $0x1
 2ea:	e8 01 08 00 00       	call   af0 <printf>
 2ef:	83 c4 10             	add    $0x10,%esp
 2f2:	e9 21 ff ff ff       	jmp    218 <mutexTest+0x48>
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(!test) printf(1,"Error: thread didnt run!\n");
 300:	83 ec 08             	sub    $0x8,%esp
 303:	68 60 10 00 00       	push   $0x1060
 308:	6a 01                	push   $0x1
 30a:	e8 e1 07 00 00       	call   af0 <printf>
 30f:	83 c4 10             	add    $0x10,%esp
 312:	e9 34 ff ff ff       	jmp    24b <mutexTest+0x7b>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(tid<0) printf(1,"Thread wasnt created correctly! (%d)\n",tid);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	53                   	push   %ebx
 324:	68 54 0f 00 00       	push   $0xf54
 329:	6a 01                	push   $0x1
 32b:	e8 c0 07 00 00       	call   af0 <printf>
 330:	83 c4 10             	add    $0x10,%esp
 333:	eb 9d                	jmp    2d2 <mutexTest+0x102>
 335:	8d 76 00             	lea    0x0(%esi),%esi
		if(input<0) printf(1,"Error: mutex didnt unlock!\n");
 338:	83 ec 08             	sub    $0x8,%esp
 33b:	68 44 10 00 00       	push   $0x1044
 340:	6a 01                	push   $0x1
 342:	e8 a9 07 00 00       	call   af0 <printf>
 347:	83 c4 10             	add    $0x10,%esp
 34a:	e9 e2 fe ff ff       	jmp    231 <mutexTest+0x61>
 34f:	90                   	nop
		if(input<0) printf(1,"Error: mutex didnt lock! (%d)\n",input);
 350:	83 ec 04             	sub    $0x4,%esp
 353:	50                   	push   %eax
 354:	68 08 0f 00 00       	push   $0xf08
 359:	6a 01                	push   $0x1
 35b:	e8 90 07 00 00       	call   af0 <printf>
 360:	83 c4 10             	add    $0x10,%esp
 363:	e9 32 ff ff ff       	jmp    29a <mutexTest+0xca>
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	printf(1,"Exiting\n");
 370:	83 ec 08             	sub    $0x8,%esp
 373:	68 89 10 00 00       	push   $0x1089
 378:	6a 01                	push   $0x1
 37a:	e8 71 07 00 00       	call   af0 <printf>
	input = kthread_mutex_dealloc(mutex);
 37f:	58                   	pop    %eax
 380:	ff 35 68 15 00 00    	pushl  0x1568
 386:	e8 9f 06 00 00       	call   a2a <kthread_mutex_dealloc>
	if(input<0)
 38b:	83 c4 10             	add    $0x10,%esp
 38e:	85 c0                	test   %eax,%eax
 390:	78 2e                	js     3c0 <mutexTest+0x1f0>
}
 392:	8d 65 f8             	lea    -0x8(%ebp),%esp
 395:	5b                   	pop    %ebx
 396:	5e                   	pop    %esi
 397:	5d                   	pop    %ebp
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
 3a0:	83 ec 04             	sub    $0x4,%esp
 3a3:	50                   	push   %eax
 3a4:	68 e8 0e 00 00       	push   $0xee8
 3a9:	6a 01                	push   $0x1
 3ab:	e8 40 07 00 00       	call   af0 <printf>
 3b0:	83 c4 10             	add    $0x10,%esp
 3b3:	e9 56 fe ff ff       	jmp    20e <mutexTest+0x3e>
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: mutex didnt dealloc!\n");
 3c0:	83 ec 08             	sub    $0x8,%esp
 3c3:	68 92 10 00 00       	push   $0x1092
 3c8:	6a 01                	push   $0x1
 3ca:	e8 21 07 00 00       	call   af0 <printf>
 3cf:	83 c4 10             	add    $0x10,%esp
}
 3d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3d5:	5b                   	pop    %ebx
 3d6:	5e                   	pop    %esi
 3d7:	5d                   	pop    %ebp
 3d8:	c3                   	ret    
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003e0 <threadTest>:
void threadTest(){
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	83 ec 10             	sub    $0x10,%esp
	void* stack = (void*)malloc(4000);
 3e7:	68 a0 0f 00 00       	push   $0xfa0
 3ec:	e8 5f 09 00 00       	call   d50 <malloc>
 3f1:	89 c3                	mov    %eax,%ebx
	int pid = getpid();
 3f3:	e8 ea 05 00 00       	call   9e2 <getpid>
	printf(1, "%d\n",pid);
 3f8:	83 c4 0c             	add    $0xc,%esp
 3fb:	50                   	push   %eax
 3fc:	68 25 11 00 00       	push   $0x1125
 401:	6a 01                	push   $0x1
 403:	e8 e8 06 00 00       	call   af0 <printf>
	int tid = kthread_create((void*)run, stack);
 408:	58                   	pop    %eax
 409:	5a                   	pop    %edx
 40a:	53                   	push   %ebx
 40b:	68 10 01 00 00       	push   $0x110
 410:	e8 ed 05 00 00       	call   a02 <kthread_create>
 415:	89 c3                	mov    %eax,%ebx
	int res = kthread_join(tid);
 417:	89 04 24             	mov    %eax,(%esp)
 41a:	e8 fb 05 00 00       	call   a1a <kthread_join>
	printf(1, "result: %d, tid: %d\n", res, tid);
 41f:	53                   	push   %ebx
 420:	50                   	push   %eax
 421:	68 af 10 00 00       	push   $0x10af
 426:	6a 01                	push   $0x1
 428:	e8 c3 06 00 00       	call   af0 <printf>
}
 42d:	83 c4 20             	add    $0x20,%esp
 430:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 433:	c9                   	leave  
 434:	c3                   	ret    
 435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <threadTest1>:
void threadTest1(){
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	56                   	push   %esi
 444:	53                   	push   %ebx
	void* stack1 = (void*)malloc(4000);
 445:	83 ec 0c             	sub    $0xc,%esp
 448:	68 a0 0f 00 00       	push   $0xfa0
 44d:	e8 fe 08 00 00       	call   d50 <malloc>
	void* stack2 = (void*)malloc(4000);	
 452:	c7 04 24 a0 0f 00 00 	movl   $0xfa0,(%esp)
	void* stack1 = (void*)malloc(4000);
 459:	89 c6                	mov    %eax,%esi
	void* stack2 = (void*)malloc(4000);	
 45b:	e8 f0 08 00 00       	call   d50 <malloc>
 460:	89 c3                	mov    %eax,%ebx
	tid1=kthread_create((void*)print_id,stack1);
 462:	58                   	pop    %eax
 463:	5a                   	pop    %edx
 464:	56                   	push   %esi
 465:	68 60 01 00 00       	push   $0x160
 46a:	e8 93 05 00 00       	call   a02 <kthread_create>
	tid2=kthread_create((void*)print_id,stack2);
 46f:	59                   	pop    %ecx
	tid1=kthread_create((void*)print_id,stack1);
 470:	89 c6                	mov    %eax,%esi
	tid2=kthread_create((void*)print_id,stack2);
 472:	58                   	pop    %eax
 473:	53                   	push   %ebx
 474:	68 60 01 00 00       	push   $0x160
 479:	e8 84 05 00 00       	call   a02 <kthread_create>
	kthread_join(tid1);
 47e:	89 34 24             	mov    %esi,(%esp)
	tid2=kthread_create((void*)print_id,stack2);
 481:	89 c3                	mov    %eax,%ebx
	kthread_join(tid1);
 483:	e8 92 05 00 00       	call   a1a <kthread_join>
	printf(1,"Got id : %d \n",tid1);
 488:	83 c4 0c             	add    $0xc,%esp
 48b:	56                   	push   %esi
 48c:	68 c4 10 00 00       	push   $0x10c4
 491:	6a 01                	push   $0x1
 493:	e8 58 06 00 00       	call   af0 <printf>
	kthread_join(tid2);
 498:	89 1c 24             	mov    %ebx,(%esp)
 49b:	e8 7a 05 00 00       	call   a1a <kthread_join>
	printf(1,"Got id : %d \n",tid2);
 4a0:	83 c4 0c             	add    $0xc,%esp
 4a3:	53                   	push   %ebx
 4a4:	68 c4 10 00 00       	push   $0x10c4
 4a9:	6a 01                	push   $0x1
 4ab:	e8 40 06 00 00       	call   af0 <printf>
	printf(1,"Finished.\n");
 4b0:	58                   	pop    %eax
 4b1:	5a                   	pop    %edx
 4b2:	68 d2 10 00 00       	push   $0x10d2
 4b7:	6a 01                	push   $0x1
 4b9:	e8 32 06 00 00       	call   af0 <printf>
	sleep(500);
 4be:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
 4c5:	e8 28 05 00 00       	call   9f2 <sleep>
}
 4ca:	83 c4 10             	add    $0x10,%esp
 4cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4d0:	5b                   	pop    %ebx
 4d1:	5e                   	pop    %esi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004e0 <threadTest2>:
void threadTest2(){
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	56                   	push   %esi
 4e4:	53                   	push   %ebx
	void* stack1 = (void*)malloc(4000);
 4e5:	83 ec 0c             	sub    $0xc,%esp
 4e8:	68 a0 0f 00 00       	push   $0xfa0
 4ed:	e8 5e 08 00 00       	call   d50 <malloc>
	void* stack2 = (void*)malloc(4000);	
 4f2:	c7 04 24 a0 0f 00 00 	movl   $0xfa0,(%esp)
	void* stack1 = (void*)malloc(4000);
 4f9:	89 c6                	mov    %eax,%esi
	void* stack2 = (void*)malloc(4000);	
 4fb:	e8 50 08 00 00       	call   d50 <malloc>
 500:	89 c3                	mov    %eax,%ebx
	kthread_create((void*)printBLABLA,stack1);
 502:	58                   	pop    %eax
 503:	5a                   	pop    %edx
 504:	56                   	push   %esi
 505:	68 a0 01 00 00       	push   $0x1a0
 50a:	e8 f3 04 00 00       	call   a02 <kthread_create>
	kthread_create((void*)printBLABLA,stack2);
 50f:	59                   	pop    %ecx
 510:	5e                   	pop    %esi
 511:	53                   	push   %ebx
 512:	68 a0 01 00 00       	push   $0x1a0
 517:	e8 e6 04 00 00       	call   a02 <kthread_create>
	sleep(500);
 51c:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
 523:	e8 ca 04 00 00       	call   9f2 <sleep>
}
 528:	83 c4 10             	add    $0x10,%esp
 52b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 52e:	5b                   	pop    %ebx
 52f:	5e                   	pop    %esi
 530:	5d                   	pop    %ebp
 531:	c3                   	ret    
 532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000540 <threadTest3>:
void threadTest3(){
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 18             	sub    $0x18,%esp
  stack = malloc(MAX_STACK);
 549:	68 a0 0f 00 00       	push   $0xfa0
 54e:	e8 fd 07 00 00       	call   d50 <malloc>
  memset(stack, 0, sizeof(*stack));
 553:	83 c4 0c             	add    $0xc,%esp
  stack = malloc(MAX_STACK);
 556:	89 c3                	mov    %eax,%ebx
  memset(stack, 0, sizeof(*stack));
 558:	6a 04                	push   $0x4
 55a:	6a 00                	push   $0x0
 55c:	50                   	push   %eax
 55d:	e8 5e 02 00 00       	call   7c0 <memset>
  if ((tid = (kthread_create((void*)printme, stack))) < 0) {
 562:	5f                   	pop    %edi
 563:	58                   	pop    %eax
 564:	53                   	push   %ebx
 565:	68 e0 00 00 00       	push   $0xe0
 56a:	e8 93 04 00 00       	call   a02 <kthread_create>
 56f:	83 c4 10             	add    $0x10,%esp
 572:	85 c0                	test   %eax,%eax
 574:	89 c7                	mov    %eax,%edi
 576:	0f 88 74 01 00 00    	js     6f0 <threadTest3+0x1b0>
  stack1  = malloc(MAX_STACK);
 57c:	83 ec 0c             	sub    $0xc,%esp
 57f:	68 a0 0f 00 00       	push   $0xfa0
 584:	e8 c7 07 00 00       	call   d50 <malloc>
  memset(stack1, 0, sizeof(*stack1));
 589:	83 c4 0c             	add    $0xc,%esp
  stack1  = malloc(MAX_STACK);
 58c:	89 c3                	mov    %eax,%ebx
  memset(stack1, 0, sizeof(*stack1));
 58e:	6a 04                	push   $0x4
 590:	6a 00                	push   $0x0
 592:	50                   	push   %eax
 593:	e8 28 02 00 00       	call   7c0 <memset>
  if ((tid1 = (kthread_create((void*)printme, stack1))) < 0) {
 598:	59                   	pop    %ecx
 599:	5e                   	pop    %esi
 59a:	53                   	push   %ebx
 59b:	68 e0 00 00 00       	push   $0xe0
 5a0:	e8 5d 04 00 00       	call   a02 <kthread_create>
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	85 c0                	test   %eax,%eax
 5aa:	89 c6                	mov    %eax,%esi
 5ac:	0f 88 1e 01 00 00    	js     6d0 <threadTest3+0x190>
  stack2  = malloc(MAX_STACK);
 5b2:	83 ec 0c             	sub    $0xc,%esp
 5b5:	68 a0 0f 00 00       	push   $0xfa0
 5ba:	e8 91 07 00 00       	call   d50 <malloc>
  memset(stack2, 0, sizeof(*stack2));
 5bf:	83 c4 0c             	add    $0xc,%esp
  stack2  = malloc(MAX_STACK);
 5c2:	89 c3                	mov    %eax,%ebx
  memset(stack2, 0, sizeof(*stack2));
 5c4:	6a 04                	push   $0x4
 5c6:	6a 00                	push   $0x0
 5c8:	50                   	push   %eax
 5c9:	e8 f2 01 00 00       	call   7c0 <memset>
  if ((tid2 = (kthread_create((void*)printme, stack2))) < 0) {
 5ce:	58                   	pop    %eax
 5cf:	5a                   	pop    %edx
 5d0:	53                   	push   %ebx
 5d1:	68 e0 00 00 00       	push   $0xe0
 5d6:	e8 27 04 00 00       	call   a02 <kthread_create>
 5db:	83 c4 10             	add    $0x10,%esp
 5de:	85 c0                	test   %eax,%eax
 5e0:	89 c3                	mov    %eax,%ebx
 5e2:	0f 88 c8 00 00 00    	js     6b0 <threadTest3+0x170>
  printf(1, "Joining %d\n", tid);
 5e8:	83 ec 04             	sub    $0x4,%esp
 5eb:	57                   	push   %edi
 5ec:	68 f2 10 00 00       	push   $0x10f2
 5f1:	6a 01                	push   $0x1
 5f3:	e8 f8 04 00 00       	call   af0 <printf>
  if (kthread_join(tid) < 0) {
 5f8:	89 3c 24             	mov    %edi,(%esp)
 5fb:	e8 1a 04 00 00       	call   a1a <kthread_join>
 600:	83 c4 10             	add    $0x10,%esp
 603:	85 c0                	test   %eax,%eax
 605:	0f 88 8d 00 00 00    	js     698 <threadTest3+0x158>
  printf(1, "Joining %d\n", tid1);
 60b:	83 ec 04             	sub    $0x4,%esp
 60e:	56                   	push   %esi
 60f:	68 f2 10 00 00       	push   $0x10f2
 614:	6a 01                	push   $0x1
 616:	e8 d5 04 00 00       	call   af0 <printf>
  if (kthread_join(tid1) < 0) {
 61b:	89 34 24             	mov    %esi,(%esp)
 61e:	e8 f7 03 00 00       	call   a1a <kthread_join>
 623:	83 c4 10             	add    $0x10,%esp
 626:	85 c0                	test   %eax,%eax
 628:	78 56                	js     680 <threadTest3+0x140>
  printf(1, "Joining %d\n", tid2);
 62a:	83 ec 04             	sub    $0x4,%esp
 62d:	53                   	push   %ebx
 62e:	68 f2 10 00 00       	push   $0x10f2
 633:	6a 01                	push   $0x1
 635:	e8 b6 04 00 00       	call   af0 <printf>
  if (kthread_join(tid2) < 0) {
 63a:	89 1c 24             	mov    %ebx,(%esp)
 63d:	e8 d8 03 00 00       	call   a1a <kthread_join>
 642:	83 c4 10             	add    $0x10,%esp
 645:	85 c0                	test   %eax,%eax
 647:	78 1f                	js     668 <threadTest3+0x128>
  printf(1, "\nAll threads done!\n");
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	68 0a 11 00 00       	push   $0x110a
 651:	6a 01                	push   $0x1
 653:	e8 98 04 00 00       	call   af0 <printf>
}
 658:	83 c4 10             	add    $0x10,%esp
 65b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 65e:	5b                   	pop    %ebx
 65f:	5e                   	pop    %esi
 660:	5f                   	pop    %edi
 661:	5d                   	pop    %ebp
 662:	c3                   	ret    
 663:	90                   	nop
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "join error\n");
 668:	83 ec 08             	sub    $0x8,%esp
 66b:	68 fe 10 00 00       	push   $0x10fe
 670:	6a 02                	push   $0x2
 672:	e8 79 04 00 00       	call   af0 <printf>
 677:	83 c4 10             	add    $0x10,%esp
 67a:	eb cd                	jmp    649 <threadTest3+0x109>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "join error\n");
 680:	83 ec 08             	sub    $0x8,%esp
 683:	68 fe 10 00 00       	push   $0x10fe
 688:	6a 02                	push   $0x2
 68a:	e8 61 04 00 00       	call   af0 <printf>
 68f:	83 c4 10             	add    $0x10,%esp
 692:	eb 96                	jmp    62a <threadTest3+0xea>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "join error\n");
 698:	83 ec 08             	sub    $0x8,%esp
 69b:	68 fe 10 00 00       	push   $0x10fe
 6a0:	6a 02                	push   $0x2
 6a2:	e8 49 04 00 00       	call   af0 <printf>
 6a7:	83 c4 10             	add    $0x10,%esp
 6aa:	e9 5c ff ff ff       	jmp    60b <threadTest3+0xcb>
 6af:	90                   	nop
    printf(2, "thread_create error\n");
 6b0:	83 ec 08             	sub    $0x8,%esp
 6b3:	68 dd 10 00 00       	push   $0x10dd
 6b8:	6a 02                	push   $0x2
 6ba:	e8 31 04 00 00       	call   af0 <printf>
 6bf:	83 c4 10             	add    $0x10,%esp
 6c2:	e9 21 ff ff ff       	jmp    5e8 <threadTest3+0xa8>
 6c7:	89 f6                	mov    %esi,%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "thread_create error\n");
 6d0:	83 ec 08             	sub    $0x8,%esp
 6d3:	68 dd 10 00 00       	push   $0x10dd
 6d8:	6a 02                	push   $0x2
 6da:	e8 11 04 00 00       	call   af0 <printf>
 6df:	83 c4 10             	add    $0x10,%esp
 6e2:	e9 cb fe ff ff       	jmp    5b2 <threadTest3+0x72>
 6e7:	89 f6                	mov    %esi,%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "thread_create error\n");
 6f0:	83 ec 08             	sub    $0x8,%esp
 6f3:	68 dd 10 00 00       	push   $0x10dd
 6f8:	6a 02                	push   $0x2
 6fa:	e8 f1 03 00 00       	call   af0 <printf>
 6ff:	83 c4 10             	add    $0x10,%esp
 702:	e9 75 fe ff ff       	jmp    57c <threadTest3+0x3c>
 707:	66 90                	xchg   %ax,%ax
 709:	66 90                	xchg   %ax,%ax
 70b:	66 90                	xchg   %ax,%ax
 70d:	66 90                	xchg   %ax,%ax
 70f:	90                   	nop

00000710 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	53                   	push   %ebx
 714:	8b 45 08             	mov    0x8(%ebp),%eax
 717:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 71a:	89 c2                	mov    %eax,%edx
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 720:	83 c1 01             	add    $0x1,%ecx
 723:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 727:	83 c2 01             	add    $0x1,%edx
 72a:	84 db                	test   %bl,%bl
 72c:	88 5a ff             	mov    %bl,-0x1(%edx)
 72f:	75 ef                	jne    720 <strcpy+0x10>
    ;
  return os;
}
 731:	5b                   	pop    %ebx
 732:	5d                   	pop    %ebp
 733:	c3                   	ret    
 734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 73a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000740 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	53                   	push   %ebx
 744:	8b 55 08             	mov    0x8(%ebp),%edx
 747:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 74a:	0f b6 02             	movzbl (%edx),%eax
 74d:	0f b6 19             	movzbl (%ecx),%ebx
 750:	84 c0                	test   %al,%al
 752:	75 1c                	jne    770 <strcmp+0x30>
 754:	eb 2a                	jmp    780 <strcmp+0x40>
 756:	8d 76 00             	lea    0x0(%esi),%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 760:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 763:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 766:	83 c1 01             	add    $0x1,%ecx
 769:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 76c:	84 c0                	test   %al,%al
 76e:	74 10                	je     780 <strcmp+0x40>
 770:	38 d8                	cmp    %bl,%al
 772:	74 ec                	je     760 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 774:	29 d8                	sub    %ebx,%eax
}
 776:	5b                   	pop    %ebx
 777:	5d                   	pop    %ebp
 778:	c3                   	ret    
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 780:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 782:	29 d8                	sub    %ebx,%eax
}
 784:	5b                   	pop    %ebx
 785:	5d                   	pop    %ebp
 786:	c3                   	ret    
 787:	89 f6                	mov    %esi,%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <strlen>:

uint
strlen(const char *s)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 796:	80 39 00             	cmpb   $0x0,(%ecx)
 799:	74 15                	je     7b0 <strlen+0x20>
 79b:	31 d2                	xor    %edx,%edx
 79d:	8d 76 00             	lea    0x0(%esi),%esi
 7a0:	83 c2 01             	add    $0x1,%edx
 7a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 7a7:	89 d0                	mov    %edx,%eax
 7a9:	75 f5                	jne    7a0 <strlen+0x10>
    ;
  return n;
}
 7ab:	5d                   	pop    %ebp
 7ac:	c3                   	ret    
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 7b0:	31 c0                	xor    %eax,%eax
}
 7b2:	5d                   	pop    %ebp
 7b3:	c3                   	ret    
 7b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 7c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 7ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 7cd:	89 d7                	mov    %edx,%edi
 7cf:	fc                   	cld    
 7d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 7d2:	89 d0                	mov    %edx,%eax
 7d4:	5f                   	pop    %edi
 7d5:	5d                   	pop    %ebp
 7d6:	c3                   	ret    
 7d7:	89 f6                	mov    %esi,%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007e0 <strchr>:

char*
strchr(const char *s, char c)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	53                   	push   %ebx
 7e4:	8b 45 08             	mov    0x8(%ebp),%eax
 7e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 7ea:	0f b6 10             	movzbl (%eax),%edx
 7ed:	84 d2                	test   %dl,%dl
 7ef:	74 1d                	je     80e <strchr+0x2e>
    if(*s == c)
 7f1:	38 d3                	cmp    %dl,%bl
 7f3:	89 d9                	mov    %ebx,%ecx
 7f5:	75 0d                	jne    804 <strchr+0x24>
 7f7:	eb 17                	jmp    810 <strchr+0x30>
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 800:	38 ca                	cmp    %cl,%dl
 802:	74 0c                	je     810 <strchr+0x30>
  for(; *s; s++)
 804:	83 c0 01             	add    $0x1,%eax
 807:	0f b6 10             	movzbl (%eax),%edx
 80a:	84 d2                	test   %dl,%dl
 80c:	75 f2                	jne    800 <strchr+0x20>
      return (char*)s;
  return 0;
 80e:	31 c0                	xor    %eax,%eax
}
 810:	5b                   	pop    %ebx
 811:	5d                   	pop    %ebp
 812:	c3                   	ret    
 813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000820 <gets>:

char*
gets(char *buf, int max)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 826:	31 f6                	xor    %esi,%esi
 828:	89 f3                	mov    %esi,%ebx
{
 82a:	83 ec 1c             	sub    $0x1c,%esp
 82d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 830:	eb 2f                	jmp    861 <gets+0x41>
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 838:	8d 45 e7             	lea    -0x19(%ebp),%eax
 83b:	83 ec 04             	sub    $0x4,%esp
 83e:	6a 01                	push   $0x1
 840:	50                   	push   %eax
 841:	6a 00                	push   $0x0
 843:	e8 32 01 00 00       	call   97a <read>
    if(cc < 1)
 848:	83 c4 10             	add    $0x10,%esp
 84b:	85 c0                	test   %eax,%eax
 84d:	7e 1c                	jle    86b <gets+0x4b>
      break;
    buf[i++] = c;
 84f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 853:	83 c7 01             	add    $0x1,%edi
 856:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 859:	3c 0a                	cmp    $0xa,%al
 85b:	74 23                	je     880 <gets+0x60>
 85d:	3c 0d                	cmp    $0xd,%al
 85f:	74 1f                	je     880 <gets+0x60>
  for(i=0; i+1 < max; ){
 861:	83 c3 01             	add    $0x1,%ebx
 864:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 867:	89 fe                	mov    %edi,%esi
 869:	7c cd                	jl     838 <gets+0x18>
 86b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 86d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 870:	c6 03 00             	movb   $0x0,(%ebx)
}
 873:	8d 65 f4             	lea    -0xc(%ebp),%esp
 876:	5b                   	pop    %ebx
 877:	5e                   	pop    %esi
 878:	5f                   	pop    %edi
 879:	5d                   	pop    %ebp
 87a:	c3                   	ret    
 87b:	90                   	nop
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 880:	8b 75 08             	mov    0x8(%ebp),%esi
 883:	8b 45 08             	mov    0x8(%ebp),%eax
 886:	01 de                	add    %ebx,%esi
 888:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 88a:	c6 03 00             	movb   $0x0,(%ebx)
}
 88d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 890:	5b                   	pop    %ebx
 891:	5e                   	pop    %esi
 892:	5f                   	pop    %edi
 893:	5d                   	pop    %ebp
 894:	c3                   	ret    
 895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	56                   	push   %esi
 8a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 8a5:	83 ec 08             	sub    $0x8,%esp
 8a8:	6a 00                	push   $0x0
 8aa:	ff 75 08             	pushl  0x8(%ebp)
 8ad:	e8 f0 00 00 00       	call   9a2 <open>
  if(fd < 0)
 8b2:	83 c4 10             	add    $0x10,%esp
 8b5:	85 c0                	test   %eax,%eax
 8b7:	78 27                	js     8e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 8b9:	83 ec 08             	sub    $0x8,%esp
 8bc:	ff 75 0c             	pushl  0xc(%ebp)
 8bf:	89 c3                	mov    %eax,%ebx
 8c1:	50                   	push   %eax
 8c2:	e8 f3 00 00 00       	call   9ba <fstat>
  close(fd);
 8c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 8ca:	89 c6                	mov    %eax,%esi
  close(fd);
 8cc:	e8 b9 00 00 00       	call   98a <close>
  return r;
 8d1:	83 c4 10             	add    $0x10,%esp
}
 8d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8d7:	89 f0                	mov    %esi,%eax
 8d9:	5b                   	pop    %ebx
 8da:	5e                   	pop    %esi
 8db:	5d                   	pop    %ebp
 8dc:	c3                   	ret    
 8dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 8e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 8e5:	eb ed                	jmp    8d4 <stat+0x34>
 8e7:	89 f6                	mov    %esi,%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008f0 <atoi>:

int
atoi(const char *s)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	53                   	push   %ebx
 8f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 8f7:	0f be 11             	movsbl (%ecx),%edx
 8fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 8fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 8ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 904:	77 1f                	ja     925 <atoi+0x35>
 906:	8d 76 00             	lea    0x0(%esi),%esi
 909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 910:	8d 04 80             	lea    (%eax,%eax,4),%eax
 913:	83 c1 01             	add    $0x1,%ecx
 916:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 91a:	0f be 11             	movsbl (%ecx),%edx
 91d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 920:	80 fb 09             	cmp    $0x9,%bl
 923:	76 eb                	jbe    910 <atoi+0x20>
  return n;
}
 925:	5b                   	pop    %ebx
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
 928:	90                   	nop
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000930 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	56                   	push   %esi
 934:	53                   	push   %ebx
 935:	8b 5d 10             	mov    0x10(%ebp),%ebx
 938:	8b 45 08             	mov    0x8(%ebp),%eax
 93b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 93e:	85 db                	test   %ebx,%ebx
 940:	7e 14                	jle    956 <memmove+0x26>
 942:	31 d2                	xor    %edx,%edx
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 948:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 94c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 94f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 952:	39 d3                	cmp    %edx,%ebx
 954:	75 f2                	jne    948 <memmove+0x18>
  return vdst;
}
 956:	5b                   	pop    %ebx
 957:	5e                   	pop    %esi
 958:	5d                   	pop    %ebp
 959:	c3                   	ret    

0000095a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 95a:	b8 01 00 00 00       	mov    $0x1,%eax
 95f:	cd 40                	int    $0x40
 961:	c3                   	ret    

00000962 <exit>:
SYSCALL(exit)
 962:	b8 02 00 00 00       	mov    $0x2,%eax
 967:	cd 40                	int    $0x40
 969:	c3                   	ret    

0000096a <wait>:
SYSCALL(wait)
 96a:	b8 03 00 00 00       	mov    $0x3,%eax
 96f:	cd 40                	int    $0x40
 971:	c3                   	ret    

00000972 <pipe>:
SYSCALL(pipe)
 972:	b8 04 00 00 00       	mov    $0x4,%eax
 977:	cd 40                	int    $0x40
 979:	c3                   	ret    

0000097a <read>:
SYSCALL(read)
 97a:	b8 05 00 00 00       	mov    $0x5,%eax
 97f:	cd 40                	int    $0x40
 981:	c3                   	ret    

00000982 <write>:
SYSCALL(write)
 982:	b8 10 00 00 00       	mov    $0x10,%eax
 987:	cd 40                	int    $0x40
 989:	c3                   	ret    

0000098a <close>:
SYSCALL(close)
 98a:	b8 15 00 00 00       	mov    $0x15,%eax
 98f:	cd 40                	int    $0x40
 991:	c3                   	ret    

00000992 <kill>:
SYSCALL(kill)
 992:	b8 06 00 00 00       	mov    $0x6,%eax
 997:	cd 40                	int    $0x40
 999:	c3                   	ret    

0000099a <exec>:
SYSCALL(exec)
 99a:	b8 07 00 00 00       	mov    $0x7,%eax
 99f:	cd 40                	int    $0x40
 9a1:	c3                   	ret    

000009a2 <open>:
SYSCALL(open)
 9a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 9a7:	cd 40                	int    $0x40
 9a9:	c3                   	ret    

000009aa <mknod>:
SYSCALL(mknod)
 9aa:	b8 11 00 00 00       	mov    $0x11,%eax
 9af:	cd 40                	int    $0x40
 9b1:	c3                   	ret    

000009b2 <unlink>:
SYSCALL(unlink)
 9b2:	b8 12 00 00 00       	mov    $0x12,%eax
 9b7:	cd 40                	int    $0x40
 9b9:	c3                   	ret    

000009ba <fstat>:
SYSCALL(fstat)
 9ba:	b8 08 00 00 00       	mov    $0x8,%eax
 9bf:	cd 40                	int    $0x40
 9c1:	c3                   	ret    

000009c2 <link>:
SYSCALL(link)
 9c2:	b8 13 00 00 00       	mov    $0x13,%eax
 9c7:	cd 40                	int    $0x40
 9c9:	c3                   	ret    

000009ca <mkdir>:
SYSCALL(mkdir)
 9ca:	b8 14 00 00 00       	mov    $0x14,%eax
 9cf:	cd 40                	int    $0x40
 9d1:	c3                   	ret    

000009d2 <chdir>:
SYSCALL(chdir)
 9d2:	b8 09 00 00 00       	mov    $0x9,%eax
 9d7:	cd 40                	int    $0x40
 9d9:	c3                   	ret    

000009da <dup>:
SYSCALL(dup)
 9da:	b8 0a 00 00 00       	mov    $0xa,%eax
 9df:	cd 40                	int    $0x40
 9e1:	c3                   	ret    

000009e2 <getpid>:
SYSCALL(getpid)
 9e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 9e7:	cd 40                	int    $0x40
 9e9:	c3                   	ret    

000009ea <sbrk>:
SYSCALL(sbrk)
 9ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 9ef:	cd 40                	int    $0x40
 9f1:	c3                   	ret    

000009f2 <sleep>:
SYSCALL(sleep)
 9f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 9f7:	cd 40                	int    $0x40
 9f9:	c3                   	ret    

000009fa <uptime>:
SYSCALL(uptime)
 9fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 9ff:	cd 40                	int    $0x40
 a01:	c3                   	ret    

00000a02 <kthread_create>:
SYSCALL(kthread_create)
 a02:	b8 16 00 00 00       	mov    $0x16,%eax
 a07:	cd 40                	int    $0x40
 a09:	c3                   	ret    

00000a0a <kthread_id>:
SYSCALL(kthread_id)
 a0a:	b8 17 00 00 00       	mov    $0x17,%eax
 a0f:	cd 40                	int    $0x40
 a11:	c3                   	ret    

00000a12 <kthread_exit>:
SYSCALL(kthread_exit)
 a12:	b8 18 00 00 00       	mov    $0x18,%eax
 a17:	cd 40                	int    $0x40
 a19:	c3                   	ret    

00000a1a <kthread_join>:
SYSCALL(kthread_join)
 a1a:	b8 19 00 00 00       	mov    $0x19,%eax
 a1f:	cd 40                	int    $0x40
 a21:	c3                   	ret    

00000a22 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 a22:	b8 1a 00 00 00       	mov    $0x1a,%eax
 a27:	cd 40                	int    $0x40
 a29:	c3                   	ret    

00000a2a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 a2a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 a2f:	cd 40                	int    $0x40
 a31:	c3                   	ret    

00000a32 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 a32:	b8 1c 00 00 00       	mov    $0x1c,%eax
 a37:	cd 40                	int    $0x40
 a39:	c3                   	ret    

00000a3a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 a3a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 a3f:	cd 40                	int    $0x40
 a41:	c3                   	ret    
 a42:	66 90                	xchg   %ax,%ax
 a44:	66 90                	xchg   %ax,%ax
 a46:	66 90                	xchg   %ax,%ax
 a48:	66 90                	xchg   %ax,%ax
 a4a:	66 90                	xchg   %ax,%ax
 a4c:	66 90                	xchg   %ax,%ax
 a4e:	66 90                	xchg   %ax,%ax

00000a50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a59:	85 d2                	test   %edx,%edx
{
 a5b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 a5e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 a60:	79 76                	jns    ad8 <printint+0x88>
 a62:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 a66:	74 70                	je     ad8 <printint+0x88>
    x = -xx;
 a68:	f7 d8                	neg    %eax
    neg = 1;
 a6a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 a71:	31 f6                	xor    %esi,%esi
 a73:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 a76:	eb 0a                	jmp    a82 <printint+0x32>
 a78:	90                   	nop
 a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 a80:	89 fe                	mov    %edi,%esi
 a82:	31 d2                	xor    %edx,%edx
 a84:	8d 7e 01             	lea    0x1(%esi),%edi
 a87:	f7 f1                	div    %ecx
 a89:	0f b6 92 30 11 00 00 	movzbl 0x1130(%edx),%edx
  }while((x /= base) != 0);
 a90:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 a92:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 a95:	75 e9                	jne    a80 <printint+0x30>
  if(neg)
 a97:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 a9a:	85 c0                	test   %eax,%eax
 a9c:	74 08                	je     aa6 <printint+0x56>
    buf[i++] = '-';
 a9e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 aa3:	8d 7e 02             	lea    0x2(%esi),%edi
 aa6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 aaa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 aad:	8d 76 00             	lea    0x0(%esi),%esi
 ab0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 ab3:	83 ec 04             	sub    $0x4,%esp
 ab6:	83 ee 01             	sub    $0x1,%esi
 ab9:	6a 01                	push   $0x1
 abb:	53                   	push   %ebx
 abc:	57                   	push   %edi
 abd:	88 45 d7             	mov    %al,-0x29(%ebp)
 ac0:	e8 bd fe ff ff       	call   982 <write>

  while(--i >= 0)
 ac5:	83 c4 10             	add    $0x10,%esp
 ac8:	39 de                	cmp    %ebx,%esi
 aca:	75 e4                	jne    ab0 <printint+0x60>
    putc(fd, buf[i]);
}
 acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 acf:	5b                   	pop    %ebx
 ad0:	5e                   	pop    %esi
 ad1:	5f                   	pop    %edi
 ad2:	5d                   	pop    %ebp
 ad3:	c3                   	ret    
 ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 ad8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 adf:	eb 90                	jmp    a71 <printint+0x21>
 ae1:	eb 0d                	jmp    af0 <printf>
 ae3:	90                   	nop
 ae4:	90                   	nop
 ae5:	90                   	nop
 ae6:	90                   	nop
 ae7:	90                   	nop
 ae8:	90                   	nop
 ae9:	90                   	nop
 aea:	90                   	nop
 aeb:	90                   	nop
 aec:	90                   	nop
 aed:	90                   	nop
 aee:	90                   	nop
 aef:	90                   	nop

00000af0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 af0:	55                   	push   %ebp
 af1:	89 e5                	mov    %esp,%ebp
 af3:	57                   	push   %edi
 af4:	56                   	push   %esi
 af5:	53                   	push   %ebx
 af6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 af9:	8b 75 0c             	mov    0xc(%ebp),%esi
 afc:	0f b6 1e             	movzbl (%esi),%ebx
 aff:	84 db                	test   %bl,%bl
 b01:	0f 84 b3 00 00 00    	je     bba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 b07:	8d 45 10             	lea    0x10(%ebp),%eax
 b0a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 b0d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 b0f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 b12:	eb 2f                	jmp    b43 <printf+0x53>
 b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 b18:	83 f8 25             	cmp    $0x25,%eax
 b1b:	0f 84 a7 00 00 00    	je     bc8 <printf+0xd8>
  write(fd, &c, 1);
 b21:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 b24:	83 ec 04             	sub    $0x4,%esp
 b27:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 b2a:	6a 01                	push   $0x1
 b2c:	50                   	push   %eax
 b2d:	ff 75 08             	pushl  0x8(%ebp)
 b30:	e8 4d fe ff ff       	call   982 <write>
 b35:	83 c4 10             	add    $0x10,%esp
 b38:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 b3b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 b3f:	84 db                	test   %bl,%bl
 b41:	74 77                	je     bba <printf+0xca>
    if(state == 0){
 b43:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 b45:	0f be cb             	movsbl %bl,%ecx
 b48:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 b4b:	74 cb                	je     b18 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b4d:	83 ff 25             	cmp    $0x25,%edi
 b50:	75 e6                	jne    b38 <printf+0x48>
      if(c == 'd'){
 b52:	83 f8 64             	cmp    $0x64,%eax
 b55:	0f 84 05 01 00 00    	je     c60 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 b5b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 b61:	83 f9 70             	cmp    $0x70,%ecx
 b64:	74 72                	je     bd8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 b66:	83 f8 73             	cmp    $0x73,%eax
 b69:	0f 84 99 00 00 00    	je     c08 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 b6f:	83 f8 63             	cmp    $0x63,%eax
 b72:	0f 84 08 01 00 00    	je     c80 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 b78:	83 f8 25             	cmp    $0x25,%eax
 b7b:	0f 84 ef 00 00 00    	je     c70 <printf+0x180>
  write(fd, &c, 1);
 b81:	8d 45 e7             	lea    -0x19(%ebp),%eax
 b84:	83 ec 04             	sub    $0x4,%esp
 b87:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 b8b:	6a 01                	push   $0x1
 b8d:	50                   	push   %eax
 b8e:	ff 75 08             	pushl  0x8(%ebp)
 b91:	e8 ec fd ff ff       	call   982 <write>
 b96:	83 c4 0c             	add    $0xc,%esp
 b99:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 b9c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 b9f:	6a 01                	push   $0x1
 ba1:	50                   	push   %eax
 ba2:	ff 75 08             	pushl  0x8(%ebp)
 ba5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 ba8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 baa:	e8 d3 fd ff ff       	call   982 <write>
  for(i = 0; fmt[i]; i++){
 baf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 bb3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 bb6:	84 db                	test   %bl,%bl
 bb8:	75 89                	jne    b43 <printf+0x53>
    }
  }
}
 bba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bbd:	5b                   	pop    %ebx
 bbe:	5e                   	pop    %esi
 bbf:	5f                   	pop    %edi
 bc0:	5d                   	pop    %ebp
 bc1:	c3                   	ret    
 bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 bc8:	bf 25 00 00 00       	mov    $0x25,%edi
 bcd:	e9 66 ff ff ff       	jmp    b38 <printf+0x48>
 bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 bd8:	83 ec 0c             	sub    $0xc,%esp
 bdb:	b9 10 00 00 00       	mov    $0x10,%ecx
 be0:	6a 00                	push   $0x0
 be2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 be5:	8b 45 08             	mov    0x8(%ebp),%eax
 be8:	8b 17                	mov    (%edi),%edx
 bea:	e8 61 fe ff ff       	call   a50 <printint>
        ap++;
 bef:	89 f8                	mov    %edi,%eax
 bf1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bf4:	31 ff                	xor    %edi,%edi
        ap++;
 bf6:	83 c0 04             	add    $0x4,%eax
 bf9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 bfc:	e9 37 ff ff ff       	jmp    b38 <printf+0x48>
 c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 c08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 c0b:	8b 08                	mov    (%eax),%ecx
        ap++;
 c0d:	83 c0 04             	add    $0x4,%eax
 c10:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 c13:	85 c9                	test   %ecx,%ecx
 c15:	0f 84 8e 00 00 00    	je     ca9 <printf+0x1b9>
        while(*s != 0){
 c1b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 c1e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 c20:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 c22:	84 c0                	test   %al,%al
 c24:	0f 84 0e ff ff ff    	je     b38 <printf+0x48>
 c2a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 c2d:	89 de                	mov    %ebx,%esi
 c2f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 c32:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 c35:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 c38:	83 ec 04             	sub    $0x4,%esp
          s++;
 c3b:	83 c6 01             	add    $0x1,%esi
 c3e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 c41:	6a 01                	push   $0x1
 c43:	57                   	push   %edi
 c44:	53                   	push   %ebx
 c45:	e8 38 fd ff ff       	call   982 <write>
        while(*s != 0){
 c4a:	0f b6 06             	movzbl (%esi),%eax
 c4d:	83 c4 10             	add    $0x10,%esp
 c50:	84 c0                	test   %al,%al
 c52:	75 e4                	jne    c38 <printf+0x148>
 c54:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 c57:	31 ff                	xor    %edi,%edi
 c59:	e9 da fe ff ff       	jmp    b38 <printf+0x48>
 c5e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 c60:	83 ec 0c             	sub    $0xc,%esp
 c63:	b9 0a 00 00 00       	mov    $0xa,%ecx
 c68:	6a 01                	push   $0x1
 c6a:	e9 73 ff ff ff       	jmp    be2 <printf+0xf2>
 c6f:	90                   	nop
  write(fd, &c, 1);
 c70:	83 ec 04             	sub    $0x4,%esp
 c73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 c76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 c79:	6a 01                	push   $0x1
 c7b:	e9 21 ff ff ff       	jmp    ba1 <printf+0xb1>
        putc(fd, *ap);
 c80:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 c83:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 c86:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 c88:	6a 01                	push   $0x1
        ap++;
 c8a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 c8d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 c90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 c93:	50                   	push   %eax
 c94:	ff 75 08             	pushl  0x8(%ebp)
 c97:	e8 e6 fc ff ff       	call   982 <write>
        ap++;
 c9c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 c9f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 ca2:	31 ff                	xor    %edi,%edi
 ca4:	e9 8f fe ff ff       	jmp    b38 <printf+0x48>
          s = "(null)";
 ca9:	bb 29 11 00 00       	mov    $0x1129,%ebx
        while(*s != 0){
 cae:	b8 28 00 00 00       	mov    $0x28,%eax
 cb3:	e9 72 ff ff ff       	jmp    c2a <printf+0x13a>
 cb8:	66 90                	xchg   %ax,%ax
 cba:	66 90                	xchg   %ax,%ax
 cbc:	66 90                	xchg   %ax,%ax
 cbe:	66 90                	xchg   %ax,%ax

00000cc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cc0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cc1:	a1 5c 15 00 00       	mov    0x155c,%eax
{
 cc6:	89 e5                	mov    %esp,%ebp
 cc8:	57                   	push   %edi
 cc9:	56                   	push   %esi
 cca:	53                   	push   %ebx
 ccb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 cce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cd8:	39 c8                	cmp    %ecx,%eax
 cda:	8b 10                	mov    (%eax),%edx
 cdc:	73 32                	jae    d10 <free+0x50>
 cde:	39 d1                	cmp    %edx,%ecx
 ce0:	72 04                	jb     ce6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ce2:	39 d0                	cmp    %edx,%eax
 ce4:	72 32                	jb     d18 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ce6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ce9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 cec:	39 fa                	cmp    %edi,%edx
 cee:	74 30                	je     d20 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 cf0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 cf3:	8b 50 04             	mov    0x4(%eax),%edx
 cf6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 cf9:	39 f1                	cmp    %esi,%ecx
 cfb:	74 3a                	je     d37 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 cfd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 cff:	a3 5c 15 00 00       	mov    %eax,0x155c
}
 d04:	5b                   	pop    %ebx
 d05:	5e                   	pop    %esi
 d06:	5f                   	pop    %edi
 d07:	5d                   	pop    %ebp
 d08:	c3                   	ret    
 d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d10:	39 d0                	cmp    %edx,%eax
 d12:	72 04                	jb     d18 <free+0x58>
 d14:	39 d1                	cmp    %edx,%ecx
 d16:	72 ce                	jb     ce6 <free+0x26>
{
 d18:	89 d0                	mov    %edx,%eax
 d1a:	eb bc                	jmp    cd8 <free+0x18>
 d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 d20:	03 72 04             	add    0x4(%edx),%esi
 d23:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 d26:	8b 10                	mov    (%eax),%edx
 d28:	8b 12                	mov    (%edx),%edx
 d2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d2d:	8b 50 04             	mov    0x4(%eax),%edx
 d30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d33:	39 f1                	cmp    %esi,%ecx
 d35:	75 c6                	jne    cfd <free+0x3d>
    p->s.size += bp->s.size;
 d37:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 d3a:	a3 5c 15 00 00       	mov    %eax,0x155c
    p->s.size += bp->s.size;
 d3f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 d42:	8b 53 f8             	mov    -0x8(%ebx),%edx
 d45:	89 10                	mov    %edx,(%eax)
}
 d47:	5b                   	pop    %ebx
 d48:	5e                   	pop    %esi
 d49:	5f                   	pop    %edi
 d4a:	5d                   	pop    %ebp
 d4b:	c3                   	ret    
 d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d50:	55                   	push   %ebp
 d51:	89 e5                	mov    %esp,%ebp
 d53:	57                   	push   %edi
 d54:	56                   	push   %esi
 d55:	53                   	push   %ebx
 d56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d5c:	8b 15 5c 15 00 00    	mov    0x155c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d62:	8d 78 07             	lea    0x7(%eax),%edi
 d65:	c1 ef 03             	shr    $0x3,%edi
 d68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 d6b:	85 d2                	test   %edx,%edx
 d6d:	0f 84 9d 00 00 00    	je     e10 <malloc+0xc0>
 d73:	8b 02                	mov    (%edx),%eax
 d75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 d78:	39 cf                	cmp    %ecx,%edi
 d7a:	76 6c                	jbe    de8 <malloc+0x98>
 d7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 d82:	bb 00 10 00 00       	mov    $0x1000,%ebx
 d87:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 d8a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 d91:	eb 0e                	jmp    da1 <malloc+0x51>
 d93:	90                   	nop
 d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d98:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 d9a:	8b 48 04             	mov    0x4(%eax),%ecx
 d9d:	39 f9                	cmp    %edi,%ecx
 d9f:	73 47                	jae    de8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 da1:	39 05 5c 15 00 00    	cmp    %eax,0x155c
 da7:	89 c2                	mov    %eax,%edx
 da9:	75 ed                	jne    d98 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 dab:	83 ec 0c             	sub    $0xc,%esp
 dae:	56                   	push   %esi
 daf:	e8 36 fc ff ff       	call   9ea <sbrk>
  if(p == (char*)-1)
 db4:	83 c4 10             	add    $0x10,%esp
 db7:	83 f8 ff             	cmp    $0xffffffff,%eax
 dba:	74 1c                	je     dd8 <malloc+0x88>
  hp->s.size = nu;
 dbc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 dbf:	83 ec 0c             	sub    $0xc,%esp
 dc2:	83 c0 08             	add    $0x8,%eax
 dc5:	50                   	push   %eax
 dc6:	e8 f5 fe ff ff       	call   cc0 <free>
  return freep;
 dcb:	8b 15 5c 15 00 00    	mov    0x155c,%edx
      if((p = morecore(nunits)) == 0)
 dd1:	83 c4 10             	add    $0x10,%esp
 dd4:	85 d2                	test   %edx,%edx
 dd6:	75 c0                	jne    d98 <malloc+0x48>
        return 0;
  }
}
 dd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 ddb:	31 c0                	xor    %eax,%eax
}
 ddd:	5b                   	pop    %ebx
 dde:	5e                   	pop    %esi
 ddf:	5f                   	pop    %edi
 de0:	5d                   	pop    %ebp
 de1:	c3                   	ret    
 de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 de8:	39 cf                	cmp    %ecx,%edi
 dea:	74 54                	je     e40 <malloc+0xf0>
        p->s.size -= nunits;
 dec:	29 f9                	sub    %edi,%ecx
 dee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 df1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 df4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 df7:	89 15 5c 15 00 00    	mov    %edx,0x155c
}
 dfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 e00:	83 c0 08             	add    $0x8,%eax
}
 e03:	5b                   	pop    %ebx
 e04:	5e                   	pop    %esi
 e05:	5f                   	pop    %edi
 e06:	5d                   	pop    %ebp
 e07:	c3                   	ret    
 e08:	90                   	nop
 e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 e10:	c7 05 5c 15 00 00 60 	movl   $0x1560,0x155c
 e17:	15 00 00 
 e1a:	c7 05 60 15 00 00 60 	movl   $0x1560,0x1560
 e21:	15 00 00 
    base.s.size = 0;
 e24:	b8 60 15 00 00       	mov    $0x1560,%eax
 e29:	c7 05 64 15 00 00 00 	movl   $0x0,0x1564
 e30:	00 00 00 
 e33:	e9 44 ff ff ff       	jmp    d7c <malloc+0x2c>
 e38:	90                   	nop
 e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 e40:	8b 08                	mov    (%eax),%ecx
 e42:	89 0a                	mov    %ecx,(%edx)
 e44:	eb b1                	jmp    df7 <malloc+0xa7>
