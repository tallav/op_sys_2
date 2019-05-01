
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit();
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
    if(argc < 2){
      11:	83 39 01             	cmpl   $0x1,(%ecx)
{
      14:	8b 41 04             	mov    0x4(%ecx),%eax
    if(argc < 2){
      17:	7e 45                	jle    5e <main+0x5e>
		printf(1, "test num missing\n");
		exit();
	}
    int test_num = atoi(argv[1]);
      19:	83 ec 0c             	sub    $0xc,%esp
      1c:	ff 70 04             	pushl  0x4(%eax)
      1f:	e8 ac 12 00 00       	call   12d0 <atoi>
    if(test_num == 1)
      24:	83 c4 10             	add    $0x10,%esp
      27:	83 f8 01             	cmp    $0x1,%eax
      2a:	74 4f                	je     7b <main+0x7b>
        test_kthread1(10);
    if(test_num == 2)
      2c:	83 f8 02             	cmp    $0x2,%eax
      2f:	74 40                	je     71 <main+0x71>
        test_kthread2(10);
    if(test_num == 3)
      31:	83 f8 03             	cmp    $0x3,%eax
      34:	74 4f                	je     85 <main+0x85>
        test_kthread3(16);
    // TODO: not an intresting test
    if(test_num == 4)
      36:	83 f8 04             	cmp    $0x4,%eax
      39:	74 54                	je     8f <main+0x8f>
        test_mutex1(5, run2);
    if(test_num == 5)
      3b:	83 f8 05             	cmp    $0x5,%eax
      3e:	74 5d                	je     9d <main+0x9d>
        test_mutex1(2, run3);
    // TODO: test_mutex2 not creating the first thread???
    if(test_num == 6)
      40:	83 f8 06             	cmp    $0x6,%eax
      43:	74 66                	je     ab <main+0xab>
        test_mutex2(4);
    if(test_num == 7)
      45:	83 f8 07             	cmp    $0x7,%eax
      48:	74 6b                	je     b5 <main+0xb5>
        test_tree1();
    if(test_num == 8)
      4a:	83 f8 08             	cmp    $0x8,%eax
      4d:	74 7c                	je     cb <main+0xcb>
        test_tree2();
    if(test_num == 9)
      4f:	83 f8 09             	cmp    $0x9,%eax
      52:	74 7c                	je     d0 <main+0xd0>
        test_tree3(run6, run7);
    if(test_num == 10)
      54:	83 f8 0a             	cmp    $0xa,%eax
      57:	74 61                	je     ba <main+0xba>
        test_tree3(run6, run6);

    exit();
      59:	e8 e4 12 00 00       	call   1342 <exit>
		printf(1, "test num missing\n");
      5e:	50                   	push   %eax
      5f:	50                   	push   %eax
      60:	68 29 1e 00 00       	push   $0x1e29
      65:	6a 01                	push   $0x1
      67:	e8 64 14 00 00       	call   14d0 <printf>
		exit();
      6c:	e8 d1 12 00 00       	call   1342 <exit>
        test_kthread2(10);
      71:	83 ec 0c             	sub    $0xc,%esp
      74:	6a 0a                	push   $0xa
      76:	e8 a5 06 00 00       	call   720 <test_kthread2>
        test_kthread1(10);
      7b:	83 ec 0c             	sub    $0xc,%esp
      7e:	6a 0a                	push   $0xa
      80:	e8 fb 05 00 00       	call   680 <test_kthread1>
        test_kthread3(16);
      85:	83 ec 0c             	sub    $0xc,%esp
      88:	6a 10                	push   $0x10
      8a:	e8 11 08 00 00       	call   8a0 <test_kthread3>
        test_mutex1(5, run2);
      8f:	50                   	push   %eax
      90:	50                   	push   %eax
      91:	68 20 02 00 00       	push   $0x220
      96:	6a 05                	push   $0x5
      98:	e8 63 09 00 00       	call   a00 <test_mutex1>
        test_mutex1(2, run3);
      9d:	51                   	push   %ecx
      9e:	51                   	push   %ecx
      9f:	68 90 03 00 00       	push   $0x390
      a4:	6a 02                	push   $0x2
      a6:	e8 55 09 00 00       	call   a00 <test_mutex1>
        test_mutex2(4);
      ab:	83 ec 0c             	sub    $0xc,%esp
      ae:	6a 04                	push   $0x4
      b0:	e8 6b 0a 00 00       	call   b20 <test_mutex2>
        test_tree1();
      b5:	e8 56 0c 00 00       	call   d10 <test_tree1>
        test_tree3(run6, run6);
      ba:	50                   	push   %eax
      bb:	50                   	push   %eax
      bc:	68 90 05 00 00       	push   $0x590
      c1:	68 90 05 00 00       	push   $0x590
      c6:	e8 f5 0e 00 00       	call   fc0 <test_tree3>
        test_tree2();
      cb:	e8 c0 0c 00 00       	call   d90 <test_tree2>
        test_tree3(run6, run7);
      d0:	52                   	push   %edx
      d1:	52                   	push   %edx
      d2:	68 a0 04 00 00       	push   $0x4a0
      d7:	68 90 05 00 00       	push   $0x590
      dc:	e8 df 0e 00 00       	call   fc0 <test_tree3>
      e1:	66 90                	xchg   %ax,%ax
      e3:	66 90                	xchg   %ax,%ax
      e5:	66 90                	xchg   %ax,%ax
      e7:	66 90                	xchg   %ax,%ax
      e9:	66 90                	xchg   %ax,%ax
      eb:	66 90                	xchg   %ax,%ax
      ed:	66 90                	xchg   %ax,%ax
      ef:	90                   	nop

000000f0 <run1>:
void run1(){ 
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	53                   	push   %ebx
      f4:	83 ec 04             	sub    $0x4,%esp
    int id = kthread_id();
      f7:	e8 ee 12 00 00       	call   13ea <kthread_id>
      fc:	89 c3                	mov    %eax,%ebx
    sleep(id * 100); 
      fe:	83 ec 0c             	sub    $0xc,%esp
     101:	6b c0 64             	imul   $0x64,%eax,%eax
     104:	50                   	push   %eax
     105:	e8 c8 12 00 00       	call   13d2 <sleep>
    printf(1,"thread %d entering\n", id); 
     10a:	83 c4 0c             	add    $0xc,%esp
     10d:	53                   	push   %ebx
     10e:	68 44 1c 00 00       	push   $0x1c44
     113:	6a 01                	push   $0x1
     115:	e8 b6 13 00 00       	call   14d0 <printf>
    printf(1,"thread %d exiting\n", id); 
     11a:	83 c4 0c             	add    $0xc,%esp
     11d:	53                   	push   %ebx
     11e:	68 58 1c 00 00       	push   $0x1c58
     123:	6a 01                	push   $0x1
     125:	e8 a6 13 00 00       	call   14d0 <printf>
    kthread_exit(); 
     12a:	83 c4 10             	add    $0x10,%esp
}
     12d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     130:	c9                   	leave  
    kthread_exit(); 
     131:	e9 bc 12 00 00       	jmp    13f2 <kthread_exit>
     136:	8d 76 00             	lea    0x0(%esi),%esi
     139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <run5>:
void run5(){ 
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	83 ec 08             	sub    $0x8,%esp
    int id = kthread_id();
     146:	e8 9f 12 00 00       	call   13ea <kthread_id>
    sleep(id); 
     14b:	83 ec 0c             	sub    $0xc,%esp
     14e:	50                   	push   %eax
     14f:	e8 7e 12 00 00       	call   13d2 <sleep>
    kthread_exit(); 
     154:	83 c4 10             	add    $0x10,%esp
}
     157:	c9                   	leave  
    kthread_exit(); 
     158:	e9 95 12 00 00       	jmp    13f2 <kthread_exit>
     15d:	8d 76 00             	lea    0x0(%esi),%esi

00000160 <run4>:
void run4(){
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	56                   	push   %esi
     164:	53                   	push   %ebx
     165:	8d 76 00             	lea    0x0(%esi),%esi
    while(waitFlag){};
     168:	a1 44 28 00 00       	mov    0x2844,%eax
     16d:	85 c0                	test   %eax,%eax
     16f:	75 f7                	jne    168 <run4+0x8>
    result = kthread_mutex_lock(mid); 
     171:	83 ec 0c             	sub    $0xc,%esp
     174:	ff 35 24 28 00 00    	pushl  0x2824
     17a:	e8 93 12 00 00       	call   1412 <kthread_mutex_lock>
    if(result == -1){  
     17f:	83 c4 10             	add    $0x10,%esp
     182:	83 f8 ff             	cmp    $0xffffffff,%eax
     185:	74 6f                	je     1f6 <run4+0x96>
     187:	8b 35 2c 28 00 00    	mov    0x282c,%esi
     18d:	8d 5e 01             	lea    0x1(%esi),%ebx
     190:	83 c6 65             	add    $0x65,%esi
     193:	90                   	nop
     194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sleep(1); 
     198:	83 ec 0c             	sub    $0xc,%esp
     19b:	6a 01                	push   $0x1
     19d:	e8 30 12 00 00       	call   13d2 <sleep>
        num = temp; 
     1a2:	89 1d 2c 28 00 00    	mov    %ebx,0x282c
     1a8:	83 c3 01             	add    $0x1,%ebx
    for(int i = 0;i < 100;i++){ 
     1ab:	83 c4 10             	add    $0x10,%esp
     1ae:	39 f3                	cmp    %esi,%ebx
     1b0:	75 e6                	jne    198 <run4+0x38>
    result = kthread_mutex_unlock(mid); 
     1b2:	83 ec 0c             	sub    $0xc,%esp
     1b5:	ff 35 24 28 00 00    	pushl  0x2824
     1bb:	e8 5a 12 00 00       	call   141a <kthread_mutex_unlock>
    if(result == -1){ 
     1c0:	83 c4 10             	add    $0x10,%esp
     1c3:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c6:	74 0b                	je     1d3 <run4+0x73>
} 
     1c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1cb:	5b                   	pop    %ebx
     1cc:	5e                   	pop    %esi
     1cd:	5d                   	pop    %ebp
    kthread_exit(); 
     1ce:	e9 1f 12 00 00       	jmp    13f2 <kthread_exit>
        printf(1,"Error - mutex unlock, mid=%d\n", mid); 
     1d3:	83 ec 04             	sub    $0x4,%esp
     1d6:	ff 35 24 28 00 00    	pushl  0x2824
     1dc:	68 87 1c 00 00       	push   $0x1c87
     1e1:	6a 01                	push   $0x1
     1e3:	e8 e8 12 00 00       	call   14d0 <printf>
     1e8:	83 c4 10             	add    $0x10,%esp
} 
     1eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1ee:	5b                   	pop    %ebx
     1ef:	5e                   	pop    %esi
     1f0:	5d                   	pop    %ebp
    kthread_exit(); 
     1f1:	e9 fc 11 00 00       	jmp    13f2 <kthread_exit>
        printf(1,"Error - mutex lock, mid=%d\n", mid); 
     1f6:	83 ec 04             	sub    $0x4,%esp
     1f9:	ff 35 24 28 00 00    	pushl  0x2824
     1ff:	68 6b 1c 00 00       	push   $0x1c6b
     204:	6a 01                	push   $0x1
     206:	e8 c5 12 00 00       	call   14d0 <printf>
     20b:	83 c4 10             	add    $0x10,%esp
     20e:	e9 74 ff ff ff       	jmp    187 <run4+0x27>
     213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <run2>:
void run2(){ 
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	53                   	push   %ebx
     224:	83 ec 04             	sub    $0x4,%esp
    mid = kthread_mutex_alloc(); 
     227:	e8 d6 11 00 00       	call   1402 <kthread_mutex_alloc>
    if(mid < 0){ 
     22c:	85 c0                	test   %eax,%eax
    mid = kthread_mutex_alloc(); 
     22e:	89 c3                	mov    %eax,%ebx
    if(mid < 0){ 
     230:	0f 88 0a 01 00 00    	js     340 <run2+0x120>
        printf(1,"OK - mutex allocate, mid=%d\n", mid);
     236:	83 ec 04             	sub    $0x4,%esp
     239:	50                   	push   %eax
     23a:	68 bd 1c 00 00       	push   $0x1cbd
     23f:	6a 01                	push   $0x1
     241:	e8 8a 12 00 00       	call   14d0 <printf>
     246:	83 c4 10             	add    $0x10,%esp
    result = kthread_mutex_lock(mid); 
     249:	83 ec 0c             	sub    $0xc,%esp
     24c:	53                   	push   %ebx
     24d:	e8 c0 11 00 00       	call   1412 <kthread_mutex_lock>
    if(result == 0){ 
     252:	83 c4 10             	add    $0x10,%esp
     255:	85 c0                	test   %eax,%eax
     257:	0f 84 0e 01 00 00    	je     36b <run2+0x14b>
    if(result == -1){
     25d:	83 f8 ff             	cmp    $0xffffffff,%eax
     260:	0f 84 9a 00 00 00    	je     300 <run2+0xe0>
    result = kthread_mutex_unlock(mid); 
     266:	83 ec 0c             	sub    $0xc,%esp
     269:	53                   	push   %ebx
     26a:	e8 ab 11 00 00       	call   141a <kthread_mutex_unlock>
    if(result == 0){ 
     26f:	83 c4 10             	add    $0x10,%esp
     272:	85 c0                	test   %eax,%eax
     274:	0f 84 ad 00 00 00    	je     327 <run2+0x107>
    if(result == -1){
     27a:	83 f8 ff             	cmp    $0xffffffff,%eax
     27d:	74 41                	je     2c0 <run2+0xa0>
    result = kthread_mutex_dealloc(mid); 
     27f:	83 ec 0c             	sub    $0xc,%esp
     282:	53                   	push   %ebx
     283:	e8 82 11 00 00       	call   140a <kthread_mutex_dealloc>
    if(result == 0){ 
     288:	83 c4 10             	add    $0x10,%esp
     28b:	85 c0                	test   %eax,%eax
     28d:	74 54                	je     2e3 <run2+0xc3>
    if(result == -1){ 
     28f:	83 f8 ff             	cmp    $0xffffffff,%eax
     292:	74 0c                	je     2a0 <run2+0x80>
}
     294:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     297:	c9                   	leave  
    kthread_exit(); 
     298:	e9 55 11 00 00       	jmp    13f2 <kthread_exit>
     29d:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1,"Error - mutex deallocate, mid=%d\n", mid); 
     2a0:	83 ec 04             	sub    $0x4,%esp
     2a3:	53                   	push   %ebx
     2a4:	68 5c 1e 00 00       	push   $0x1e5c
     2a9:	6a 01                	push   $0x1
     2ab:	e8 20 12 00 00       	call   14d0 <printf>
     2b0:	83 c4 10             	add    $0x10,%esp
}
     2b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2b6:	c9                   	leave  
    kthread_exit(); 
     2b7:	e9 36 11 00 00       	jmp    13f2 <kthread_exit>
     2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"Error - mutex unlock, mid=%d\n", mid); 
     2c0:	83 ec 04             	sub    $0x4,%esp
     2c3:	53                   	push   %ebx
     2c4:	68 87 1c 00 00       	push   $0x1c87
     2c9:	6a 01                	push   $0x1
     2cb:	e8 00 12 00 00       	call   14d0 <printf>
     2d0:	83 c4 10             	add    $0x10,%esp
    result = kthread_mutex_dealloc(mid); 
     2d3:	83 ec 0c             	sub    $0xc,%esp
     2d6:	53                   	push   %ebx
     2d7:	e8 2e 11 00 00       	call   140a <kthread_mutex_dealloc>
    if(result == 0){ 
     2dc:	83 c4 10             	add    $0x10,%esp
     2df:	85 c0                	test   %eax,%eax
     2e1:	75 ac                	jne    28f <run2+0x6f>
        printf(1,"OK - mutex deallocate, mid=%d\n", mid); 
     2e3:	83 ec 04             	sub    $0x4,%esp
     2e6:	53                   	push   %ebx
     2e7:	68 3c 1e 00 00       	push   $0x1e3c
     2ec:	6a 01                	push   $0x1
     2ee:	e8 dd 11 00 00       	call   14d0 <printf>
     2f3:	83 c4 10             	add    $0x10,%esp
}
     2f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2f9:	c9                   	leave  
    kthread_exit(); 
     2fa:	e9 f3 10 00 00       	jmp    13f2 <kthread_exit>
     2ff:	90                   	nop
        printf(1,"Error - mutex lock, mid=%d\n", mid); 
     300:	83 ec 04             	sub    $0x4,%esp
     303:	53                   	push   %ebx
     304:	68 6b 1c 00 00       	push   $0x1c6b
     309:	6a 01                	push   $0x1
     30b:	e8 c0 11 00 00       	call   14d0 <printf>
     310:	83 c4 10             	add    $0x10,%esp
    result = kthread_mutex_unlock(mid); 
     313:	83 ec 0c             	sub    $0xc,%esp
     316:	53                   	push   %ebx
     317:	e8 fe 10 00 00       	call   141a <kthread_mutex_unlock>
    if(result == 0){ 
     31c:	83 c4 10             	add    $0x10,%esp
     31f:	85 c0                	test   %eax,%eax
     321:	0f 85 53 ff ff ff    	jne    27a <run2+0x5a>
        printf(1,"OK - mutex unlock, mid=%d\n", mid); 
     327:	83 ec 04             	sub    $0x4,%esp
     32a:	53                   	push   %ebx
     32b:	68 f3 1c 00 00       	push   $0x1cf3
     330:	6a 01                	push   $0x1
     332:	e8 99 11 00 00       	call   14d0 <printf>
     337:	83 c4 10             	add    $0x10,%esp
     33a:	e9 40 ff ff ff       	jmp    27f <run2+0x5f>
     33f:	90                   	nop
        printf(1,"Error - mutex allocate\n"); 
     340:	83 ec 08             	sub    $0x8,%esp
     343:	68 a5 1c 00 00       	push   $0x1ca5
     348:	6a 01                	push   $0x1
     34a:	e8 81 11 00 00       	call   14d0 <printf>
        kthread_exit();
     34f:	e8 9e 10 00 00       	call   13f2 <kthread_exit>
     354:	83 c4 10             	add    $0x10,%esp
    result = kthread_mutex_lock(mid); 
     357:	83 ec 0c             	sub    $0xc,%esp
     35a:	53                   	push   %ebx
     35b:	e8 b2 10 00 00       	call   1412 <kthread_mutex_lock>
    if(result == 0){ 
     360:	83 c4 10             	add    $0x10,%esp
     363:	85 c0                	test   %eax,%eax
     365:	0f 85 f2 fe ff ff    	jne    25d <run2+0x3d>
        printf(1,"OK - mutex lock, mid=%d\n", mid); 
     36b:	83 ec 04             	sub    $0x4,%esp
     36e:	53                   	push   %ebx
     36f:	68 da 1c 00 00       	push   $0x1cda
     374:	6a 01                	push   $0x1
     376:	e8 55 11 00 00       	call   14d0 <printf>
     37b:	83 c4 10             	add    $0x10,%esp
     37e:	e9 e3 fe ff ff       	jmp    266 <run2+0x46>
     383:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <run3>:
void run3(){ 
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	56                   	push   %esi
     394:	be 0a 00 00 00       	mov    $0xa,%esi
     399:	53                   	push   %ebx
     39a:	eb 4d                	jmp    3e9 <run3+0x59>
     39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"OK - mutex allocate\n");
     3a0:	83 ec 08             	sub    $0x8,%esp
     3a3:	68 0e 1d 00 00       	push   $0x1d0e
     3a8:	6a 01                	push   $0x1
     3aa:	e8 21 11 00 00       	call   14d0 <printf>
     3af:	83 c4 10             	add    $0x10,%esp
        result = kthread_mutex_dealloc(mid); 
     3b2:	83 ec 0c             	sub    $0xc,%esp
     3b5:	53                   	push   %ebx
     3b6:	e8 4f 10 00 00       	call   140a <kthread_mutex_dealloc>
        if(result == 0){ 
     3bb:	83 c4 10             	add    $0x10,%esp
     3be:	85 c0                	test   %eax,%eax
     3c0:	74 59                	je     41b <run3+0x8b>
        if(result == -1){ 
     3c2:	83 f8 ff             	cmp    $0xffffffff,%eax
     3c5:	0f 84 95 00 00 00    	je     460 <run3+0xd0>
        result = kthread_mutex_dealloc(mid); 
     3cb:	83 ec 0c             	sub    $0xc,%esp
     3ce:	53                   	push   %ebx
     3cf:	e8 36 10 00 00       	call   140a <kthread_mutex_dealloc>
        if(result == 0){ 
     3d4:	83 c4 10             	add    $0x10,%esp
     3d7:	85 c0                	test   %eax,%eax
     3d9:	74 62                	je     43d <run3+0xad>
        if(result == -1){ 
     3db:	83 f8 ff             	cmp    $0xffffffff,%eax
     3de:	0f 84 9c 00 00 00    	je     480 <run3+0xf0>
    for(int i = 0;i < 10;i++){ 
     3e4:	83 ee 01             	sub    $0x1,%esi
     3e7:	74 6b                	je     454 <run3+0xc4>
        mid = kthread_mutex_alloc(); 
     3e9:	e8 14 10 00 00       	call   1402 <kthread_mutex_alloc>
        if(mid < 0){ 
     3ee:	85 c0                	test   %eax,%eax
        mid = kthread_mutex_alloc(); 
     3f0:	89 c3                	mov    %eax,%ebx
        if(mid < 0){ 
     3f2:	79 ac                	jns    3a0 <run3+0x10>
            printf(1,"Error - mutex allocate\n"); 
     3f4:	83 ec 08             	sub    $0x8,%esp
     3f7:	68 a5 1c 00 00       	push   $0x1ca5
     3fc:	6a 01                	push   $0x1
     3fe:	e8 cd 10 00 00       	call   14d0 <printf>
            kthread_exit();
     403:	e8 ea 0f 00 00       	call   13f2 <kthread_exit>
     408:	83 c4 10             	add    $0x10,%esp
        result = kthread_mutex_dealloc(mid); 
     40b:	83 ec 0c             	sub    $0xc,%esp
     40e:	53                   	push   %ebx
     40f:	e8 f6 0f 00 00       	call   140a <kthread_mutex_dealloc>
        if(result == 0){ 
     414:	83 c4 10             	add    $0x10,%esp
     417:	85 c0                	test   %eax,%eax
     419:	75 a7                	jne    3c2 <run3+0x32>
            printf(1,"OK - mutex deallocate\n"); 
     41b:	83 ec 08             	sub    $0x8,%esp
     41e:	68 23 1d 00 00       	push   $0x1d23
     423:	6a 01                	push   $0x1
     425:	e8 a6 10 00 00       	call   14d0 <printf>
     42a:	83 c4 10             	add    $0x10,%esp
        result = kthread_mutex_dealloc(mid); 
     42d:	83 ec 0c             	sub    $0xc,%esp
     430:	53                   	push   %ebx
     431:	e8 d4 0f 00 00       	call   140a <kthread_mutex_dealloc>
        if(result == 0){ 
     436:	83 c4 10             	add    $0x10,%esp
     439:	85 c0                	test   %eax,%eax
     43b:	75 9e                	jne    3db <run3+0x4b>
        printf(1,"Error - mutex deallocate (mutex already deallocated)\n"); 
     43d:	83 ec 08             	sub    $0x8,%esp
     440:	68 80 1e 00 00       	push   $0x1e80
     445:	6a 01                	push   $0x1
     447:	e8 84 10 00 00       	call   14d0 <printf>
     44c:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < 10;i++){ 
     44f:	83 ee 01             	sub    $0x1,%esi
     452:	75 95                	jne    3e9 <run3+0x59>
}
     454:	8d 65 f8             	lea    -0x8(%ebp),%esp
     457:	5b                   	pop    %ebx
     458:	5e                   	pop    %esi
     459:	5d                   	pop    %ebp
    kthread_exit(); 
     45a:	e9 93 0f 00 00       	jmp    13f2 <kthread_exit>
     45f:	90                   	nop
            printf(1,"Error - mutex deallocate\n"); 
     460:	83 ec 08             	sub    $0x8,%esp
     463:	68 3a 1d 00 00       	push   $0x1d3a
     468:	6a 01                	push   $0x1
     46a:	e8 61 10 00 00       	call   14d0 <printf>
     46f:	83 c4 10             	add    $0x10,%esp
     472:	e9 54 ff ff ff       	jmp    3cb <run3+0x3b>
     477:	89 f6                	mov    %esi,%esi
     479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            printf(1,"OK - mutex deallocate\n"); 
     480:	83 ec 08             	sub    $0x8,%esp
     483:	68 23 1d 00 00       	push   $0x1d23
     488:	6a 01                	push   $0x1
     48a:	e8 41 10 00 00       	call   14d0 <printf>
     48f:	83 c4 10             	add    $0x10,%esp
     492:	e9 4d ff ff ff       	jmp    3e4 <run3+0x54>
     497:	89 f6                	mov    %esi,%esi
     499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <run7>:
void run7(){
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	83 ec 08             	sub    $0x8,%esp
     4a6:	8d 76 00             	lea    0x0(%esi),%esi
     4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(waitFlag2){} 
     4b0:	a1 48 28 00 00       	mov    0x2848,%eax
     4b5:	85 c0                	test   %eax,%eax
     4b7:	75 f7                	jne    4b0 <run7+0x10>
    sleep(200);
     4b9:	83 ec 0c             	sub    $0xc,%esp
     4bc:	68 c8 00 00 00       	push   $0xc8
     4c1:	e8 0c 0f 00 00       	call   13d2 <sleep>
    result = trnmnt_tree_dealloc(tree); 
     4c6:	5a                   	pop    %edx
     4c7:	ff 35 50 28 00 00    	pushl  0x2850
     4cd:	e8 ee 15 00 00       	call   1ac0 <trnmnt_tree_dealloc>
    if(result == 0){
     4d2:	83 c4 10             	add    $0x10,%esp
     4d5:	85 c0                	test   %eax,%eax
     4d7:	0f 84 93 00 00 00    	je     570 <run7+0xd0>
    if(result == -1){
     4dd:	83 f8 ff             	cmp    $0xffffffff,%eax
     4e0:	74 4e                	je     530 <run7+0x90>
    sleep(600);
     4e2:	83 ec 0c             	sub    $0xc,%esp
     4e5:	68 58 02 00 00       	push   $0x258
     4ea:	e8 e3 0e 00 00       	call   13d2 <sleep>
    result = trnmnt_tree_dealloc(tree); 
     4ef:	58                   	pop    %eax
     4f0:	ff 35 50 28 00 00    	pushl  0x2850
     4f6:	e8 c5 15 00 00       	call   1ac0 <trnmnt_tree_dealloc>
    if(result == 0){
     4fb:	83 c4 10             	add    $0x10,%esp
     4fe:	85 c0                	test   %eax,%eax
     500:	74 4e                	je     550 <run7+0xb0>
    if(result == -1){
     502:	83 f8 ff             	cmp    $0xffffffff,%eax
     505:	74 09                	je     510 <run7+0x70>
}
     507:	c9                   	leave  
    kthread_exit(); 
     508:	e9 e5 0e 00 00       	jmp    13f2 <kthread_exit>
     50d:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1,"Error - trnmnt_tree deallocate by thread %d\n", kthread_id()); 
     510:	e8 d5 0e 00 00       	call   13ea <kthread_id>
     515:	83 ec 04             	sub    $0x4,%esp
     518:	50                   	push   %eax
     519:	68 b8 1e 00 00       	push   $0x1eb8
     51e:	6a 01                	push   $0x1
     520:	e8 ab 0f 00 00       	call   14d0 <printf>
     525:	83 c4 10             	add    $0x10,%esp
}
     528:	c9                   	leave  
    kthread_exit(); 
     529:	e9 c4 0e 00 00       	jmp    13f2 <kthread_exit>
     52e:	66 90                	xchg   %ax,%ax
        printf(1,"OK - trnmnt_tree deallocate should be -1 by thread %d\n", kthread_id());
     530:	e8 b5 0e 00 00       	call   13ea <kthread_id>
     535:	83 ec 04             	sub    $0x4,%esp
     538:	50                   	push   %eax
     539:	68 e8 1e 00 00       	push   $0x1ee8
     53e:	6a 01                	push   $0x1
     540:	e8 8b 0f 00 00       	call   14d0 <printf>
     545:	83 c4 10             	add    $0x10,%esp
     548:	eb 98                	jmp    4e2 <run7+0x42>
     54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"OK - trnmnt_tree deallocate should be 0 by thread %d\n", kthread_id());
     550:	e8 95 0e 00 00       	call   13ea <kthread_id>
     555:	83 ec 04             	sub    $0x4,%esp
     558:	50                   	push   %eax
     559:	68 20 1f 00 00       	push   $0x1f20
     55e:	6a 01                	push   $0x1
     560:	e8 6b 0f 00 00       	call   14d0 <printf>
     565:	83 c4 10             	add    $0x10,%esp
}
     568:	c9                   	leave  
    kthread_exit(); 
     569:	e9 84 0e 00 00       	jmp    13f2 <kthread_exit>
     56e:	66 90                	xchg   %ax,%ax
        printf(1,"Error - trnmnt_tree deallocate by thread %d\n", kthread_id()); 
     570:	e8 75 0e 00 00       	call   13ea <kthread_id>
     575:	83 ec 04             	sub    $0x4,%esp
     578:	50                   	push   %eax
     579:	68 b8 1e 00 00       	push   $0x1eb8
     57e:	6a 01                	push   $0x1
     580:	e8 4b 0f 00 00       	call   14d0 <printf>
     585:	83 c4 10             	add    $0x10,%esp
     588:	e9 55 ff ff ff       	jmp    4e2 <run7+0x42>
     58d:	8d 76 00             	lea    0x0(%esi),%esi

00000590 <run6>:
void run6(){
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	83 ec 08             	sub    $0x8,%esp
     596:	8d 76 00             	lea    0x0(%esi),%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(waitFlag2){} 
     5a0:	a1 48 28 00 00       	mov    0x2848,%eax
     5a5:	85 c0                	test   %eax,%eax
     5a7:	75 f7                	jne    5a0 <run6+0x10>
    result6 = trnmnt_tree_acquire(tree, 0); 
     5a9:	83 ec 08             	sub    $0x8,%esp
     5ac:	6a 00                	push   $0x0
     5ae:	ff 35 50 28 00 00    	pushl  0x2850
     5b4:	e8 b7 15 00 00       	call   1b70 <trnmnt_tree_acquire>
    if(result6 == 0){  
     5b9:	83 c4 10             	add    $0x10,%esp
     5bc:	85 c0                	test   %eax,%eax
     5be:	74 60                	je     620 <run6+0x90>
    if(result6 == -1){  
     5c0:	83 f8 ff             	cmp    $0xffffffff,%eax
     5c3:	74 3b                	je     600 <run6+0x70>
    sleep(400);
     5c5:	83 ec 0c             	sub    $0xc,%esp
     5c8:	68 90 01 00 00       	push   $0x190
     5cd:	e8 00 0e 00 00       	call   13d2 <sleep>
    result6 = trnmnt_tree_release(tree, 0); 
     5d2:	58                   	pop    %eax
     5d3:	5a                   	pop    %edx
     5d4:	6a 00                	push   $0x0
     5d6:	ff 35 50 28 00 00    	pushl  0x2850
     5dc:	e8 ef 15 00 00       	call   1bd0 <trnmnt_tree_release>
    if(result == 0){  
     5e1:	a1 4c 28 00 00       	mov    0x284c,%eax
     5e6:	83 c4 10             	add    $0x10,%esp
     5e9:	85 c0                	test   %eax,%eax
     5eb:	74 53                	je     640 <run6+0xb0>
    if(result == -1){  
     5ed:	83 f8 ff             	cmp    $0xffffffff,%eax
     5f0:	74 70                	je     662 <run6+0xd2>
}
     5f2:	c9                   	leave  
    kthread_exit(); 
     5f3:	e9 fa 0d 00 00       	jmp    13f2 <kthread_exit>
     5f8:	90                   	nop
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"Error - trnmnt_tree_acquire by thread %d\n", kthread_id()); 
     600:	e8 e5 0d 00 00       	call   13ea <kthread_id>
     605:	83 ec 04             	sub    $0x4,%esp
     608:	50                   	push   %eax
     609:	68 80 1f 00 00       	push   $0x1f80
     60e:	6a 01                	push   $0x1
     610:	e8 bb 0e 00 00       	call   14d0 <printf>
     615:	83 c4 10             	add    $0x10,%esp
     618:	eb ab                	jmp    5c5 <run6+0x35>
     61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"OK - trnmnt_tree_acquire by thread %d\n", kthread_id()); 
     620:	e8 c5 0d 00 00       	call   13ea <kthread_id>
     625:	83 ec 04             	sub    $0x4,%esp
     628:	50                   	push   %eax
     629:	68 58 1f 00 00       	push   $0x1f58
     62e:	6a 01                	push   $0x1
     630:	e8 9b 0e 00 00       	call   14d0 <printf>
     635:	83 c4 10             	add    $0x10,%esp
     638:	eb 8b                	jmp    5c5 <run6+0x35>
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"OK - trnmnt_tree_release by thread %d\n", kthread_id()); 
     640:	e8 a5 0d 00 00       	call   13ea <kthread_id>
     645:	83 ec 04             	sub    $0x4,%esp
     648:	50                   	push   %eax
     649:	68 ac 1f 00 00       	push   $0x1fac
     64e:	6a 01                	push   $0x1
     650:	e8 7b 0e 00 00       	call   14d0 <printf>
     655:	a1 4c 28 00 00       	mov    0x284c,%eax
     65a:	83 c4 10             	add    $0x10,%esp
    if(result == -1){  
     65d:	83 f8 ff             	cmp    $0xffffffff,%eax
     660:	75 90                	jne    5f2 <run6+0x62>
        printf(1,"Error - trnmnt_tree_release by thread %d\n", kthread_id()); 
     662:	e8 83 0d 00 00       	call   13ea <kthread_id>
     667:	83 ec 04             	sub    $0x4,%esp
     66a:	50                   	push   %eax
     66b:	68 d4 1f 00 00       	push   $0x1fd4
     670:	6a 01                	push   $0x1
     672:	e8 59 0e 00 00       	call   14d0 <printf>
     677:	83 c4 10             	add    $0x10,%esp
}
     67a:	c9                   	leave  
    kthread_exit(); 
     67b:	e9 72 0d 00 00       	jmp    13f2 <kthread_exit>

00000680 <test_kthread1>:
void test_kthread1(int threadsNum){
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	57                   	push   %edi
     684:	56                   	push   %esi
     685:	53                   	push   %ebx
     686:	83 ec 0c             	sub    $0xc,%esp
     689:	8b 5d 08             	mov    0x8(%ebp),%ebx
    void* stacks[threadsNum];
     68c:	8d 04 9d 12 00 00 00 	lea    0x12(,%ebx,4),%eax
     693:	83 e0 f0             	and    $0xfffffff0,%eax
     696:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < threadsNum; i++){
     698:	85 db                	test   %ebx,%ebx
     69a:	7e 65                	jle    701 <test_kthread1+0x81>
     69c:	89 e7                	mov    %esp,%edi
     69e:	31 f6                	xor    %esi,%esi
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
     6a0:	83 ec 0c             	sub    $0xc,%esp
     6a3:	68 a0 0f 00 00       	push   $0xfa0
     6a8:	e8 83 10 00 00       	call   1730 <malloc>
     6ad:	05 a0 0f 00 00       	add    $0xfa0,%eax
        stacks[i] = stack;
     6b2:	89 04 b7             	mov    %eax,(%edi,%esi,4)
    for(int i = 0; i < threadsNum; i++){
     6b5:	83 c6 01             	add    $0x1,%esi
        kthread_create(run1, stack);
     6b8:	5a                   	pop    %edx
     6b9:	59                   	pop    %ecx
     6ba:	50                   	push   %eax
     6bb:	68 f0 00 00 00       	push   $0xf0
     6c0:	e8 1d 0d 00 00       	call   13e2 <kthread_create>
    for(int i = 0; i < threadsNum; i++){
     6c5:	83 c4 10             	add    $0x10,%esp
     6c8:	39 f3                	cmp    %esi,%ebx
     6ca:	75 d4                	jne    6a0 <test_kthread1+0x20>
    sleep(2000);
     6cc:	83 ec 0c             	sub    $0xc,%esp
    for(int i = 0; i < threadsNum; i++){
     6cf:	31 db                	xor    %ebx,%ebx
    sleep(2000);
     6d1:	68 d0 07 00 00       	push   $0x7d0
     6d6:	e8 f7 0c 00 00       	call   13d2 <sleep>
     6db:	83 c4 10             	add    $0x10,%esp
     6de:	66 90                	xchg   %ax,%ax
        free(stacks[i]);
     6e0:	83 ec 0c             	sub    $0xc,%esp
     6e3:	ff 34 9f             	pushl  (%edi,%ebx,4)
     6e6:	e8 b5 0f 00 00       	call   16a0 <free>
        stacks[i] = 0;
     6eb:	c7 04 9f 00 00 00 00 	movl   $0x0,(%edi,%ebx,4)
    for(int i = 0; i < threadsNum; i++){
     6f2:	83 c3 01             	add    $0x1,%ebx
     6f5:	83 c4 10             	add    $0x10,%esp
     6f8:	39 f3                	cmp    %esi,%ebx
     6fa:	75 e4                	jne    6e0 <test_kthread1+0x60>
    exit();
     6fc:	e8 41 0c 00 00       	call   1342 <exit>
    sleep(2000);
     701:	83 ec 0c             	sub    $0xc,%esp
     704:	68 d0 07 00 00       	push   $0x7d0
     709:	e8 c4 0c 00 00       	call   13d2 <sleep>
     70e:	83 c4 10             	add    $0x10,%esp
     711:	eb e9                	jmp    6fc <test_kthread1+0x7c>
     713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <test_kthread2>:
void test_kthread2(int threadsNum){
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	83 ec 1c             	sub    $0x1c,%esp
    void* stacks[threadsNum];
     729:	8b 45 08             	mov    0x8(%ebp),%eax
    for(int i = 0;i < threadsNum;i++){
     72c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    void* stacks[threadsNum];
     72f:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     736:	83 e0 f0             	and    $0xfffffff0,%eax
     739:	29 c4                	sub    %eax,%esp
     73b:	89 e6                	mov    %esp,%esi
    int tids[threadsNum];
     73d:	29 c4                	sub    %eax,%esp
    for(int i = 0;i < threadsNum;i++){
     73f:	85 db                	test   %ebx,%ebx
     741:	0f 8e 0d 01 00 00    	jle    854 <test_kthread2+0x134>
     747:	89 e7                	mov    %esp,%edi
     749:	31 db                	xor    %ebx,%ebx
     74b:	90                   	nop
     74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
     750:	83 ec 0c             	sub    $0xc,%esp
     753:	68 a0 0f 00 00       	push   $0xfa0
     758:	e8 d3 0f 00 00       	call   1730 <malloc>
     75d:	05 a0 0f 00 00       	add    $0xfa0,%eax
        stacks[i] = stack;
     762:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
        tids[i] = kthread_create(run1, stack);
     765:	5a                   	pop    %edx
     766:	59                   	pop    %ecx
     767:	50                   	push   %eax
     768:	68 f0 00 00 00       	push   $0xf0
     76d:	e8 70 0c 00 00       	call   13e2 <kthread_create>
    for(int i = 0;i < threadsNum;i++){
     772:	83 c4 10             	add    $0x10,%esp
        tids[i] = kthread_create(run1, stack);
     775:	89 04 9f             	mov    %eax,(%edi,%ebx,4)
    for(int i = 0;i < threadsNum;i++){
     778:	83 c3 01             	add    $0x1,%ebx
     77b:	39 5d 08             	cmp    %ebx,0x8(%ebp)
     77e:	75 d0                	jne    750 <test_kthread2+0x30>
    for(int i = 0;i < threadsNum;i++){
     780:	31 d2                	xor    %edx,%edx
     782:	eb 14                	jmp    798 <test_kthread2+0x78>
     784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(result == -1){
     788:	83 f8 ff             	cmp    $0xffffffff,%eax
     78b:	0f 84 cf 00 00 00    	je     860 <test_kthread2+0x140>
    for(int i = 0;i < threadsNum;i++){
     791:	83 c2 01             	add    $0x1,%edx
     794:	39 da                	cmp    %ebx,%edx
     796:	74 3f                	je     7d7 <test_kthread2+0xb7>
        int result = kthread_join(tids[i]);
     798:	8b 0c 97             	mov    (%edi,%edx,4),%ecx
     79b:	83 ec 0c             	sub    $0xc,%esp
     79e:	89 55 e0             	mov    %edx,-0x20(%ebp)
     7a1:	51                   	push   %ecx
     7a2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
     7a5:	e8 50 0c 00 00       	call   13fa <kthread_join>
        if(result == 0){
     7aa:	83 c4 10             	add    $0x10,%esp
     7ad:	85 c0                	test   %eax,%eax
     7af:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     7b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
     7b5:	75 d1                	jne    788 <test_kthread2+0x68>
            printf(1,"OK - join thread %d\n",tids[i]);
     7b7:	83 ec 04             	sub    $0x4,%esp
     7ba:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     7bd:	51                   	push   %ecx
     7be:	68 54 1d 00 00       	push   $0x1d54
     7c3:	6a 01                	push   $0x1
     7c5:	e8 06 0d 00 00       	call   14d0 <printf>
     7ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7cd:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     7d0:	83 c2 01             	add    $0x1,%edx
     7d3:	39 da                	cmp    %ebx,%edx
     7d5:	75 c1                	jne    798 <test_kthread2+0x78>
     7d7:	31 d2                	xor    %edx,%edx
     7d9:	eb 15                	jmp    7f0 <test_kthread2+0xd0>
     7db:	90                   	nop
     7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(result == -1){
     7e0:	83 f8 ff             	cmp    $0xffffffff,%eax
     7e3:	0f 84 97 00 00 00    	je     880 <test_kthread2+0x160>
    for(int i = 0;i < threadsNum;i++){
     7e9:	83 c2 01             	add    $0x1,%edx
     7ec:	39 da                	cmp    %ebx,%edx
     7ee:	74 3f                	je     82f <test_kthread2+0x10f>
        int result = kthread_join(tids[i]);
     7f0:	8b 0c 97             	mov    (%edi,%edx,4),%ecx
     7f3:	83 ec 0c             	sub    $0xc,%esp
     7f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
     7f9:	51                   	push   %ecx
     7fa:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
     7fd:	e8 f8 0b 00 00       	call   13fa <kthread_join>
        if(result == 0){
     802:	83 c4 10             	add    $0x10,%esp
     805:	85 c0                	test   %eax,%eax
     807:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     80a:	8b 55 e0             	mov    -0x20(%ebp),%edx
     80d:	75 d1                	jne    7e0 <test_kthread2+0xc0>
            printf(1,"Error - join thread %d\n",tids[i]);
     80f:	83 ec 04             	sub    $0x4,%esp
     812:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     815:	51                   	push   %ecx
     816:	68 69 1d 00 00       	push   $0x1d69
     81b:	6a 01                	push   $0x1
     81d:	e8 ae 0c 00 00       	call   14d0 <printf>
     822:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     825:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     828:	83 c2 01             	add    $0x1,%edx
     82b:	39 da                	cmp    %ebx,%edx
     82d:	75 c1                	jne    7f0 <test_kthread2+0xd0>
    for(int i = 0; i < threadsNum; i++){
     82f:	31 ff                	xor    %edi,%edi
     831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        free(stacks[i]);
     838:	83 ec 0c             	sub    $0xc,%esp
     83b:	ff 34 be             	pushl  (%esi,%edi,4)
     83e:	e8 5d 0e 00 00       	call   16a0 <free>
        stacks[i] = 0;
     843:	c7 04 be 00 00 00 00 	movl   $0x0,(%esi,%edi,4)
    for(int i = 0; i < threadsNum; i++){
     84a:	83 c7 01             	add    $0x1,%edi
     84d:	83 c4 10             	add    $0x10,%esp
     850:	39 df                	cmp    %ebx,%edi
     852:	75 e4                	jne    838 <test_kthread2+0x118>
    exit();
     854:	e8 e9 0a 00 00       	call   1342 <exit>
     859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - join thread %d\n",tids[i]);
     860:	83 ec 04             	sub    $0x4,%esp
     863:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     866:	51                   	push   %ecx
     867:	68 69 1d 00 00       	push   $0x1d69
     86c:	6a 01                	push   $0x1
     86e:	e8 5d 0c 00 00       	call   14d0 <printf>
     873:	83 c4 10             	add    $0x10,%esp
     876:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     879:	e9 13 ff ff ff       	jmp    791 <test_kthread2+0x71>
     87e:	66 90                	xchg   %ax,%ax
            printf(1,"OK - join thread %d\n",tids[i]);
     880:	83 ec 04             	sub    $0x4,%esp
     883:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     886:	51                   	push   %ecx
     887:	68 54 1d 00 00       	push   $0x1d54
     88c:	6a 01                	push   $0x1
     88e:	e8 3d 0c 00 00       	call   14d0 <printf>
     893:	83 c4 10             	add    $0x10,%esp
     896:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     899:	e9 4b ff ff ff       	jmp    7e9 <test_kthread2+0xc9>
     89e:	66 90                	xchg   %ax,%ax

000008a0 <test_kthread3>:
void test_kthread3(int threadsNum){
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	57                   	push   %edi
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
     8a6:	83 ec 1c             	sub    $0x1c,%esp
    void* stacks[threadsNum];
     8a9:	8b 45 08             	mov    0x8(%ebp),%eax
    for(int i = 0;i < threadsNum;i++){
     8ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
    void* stacks[threadsNum];
     8af:	83 e8 01             	sub    $0x1,%eax
     8b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     8b5:	8b 45 08             	mov    0x8(%ebp),%eax
     8b8:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     8bf:	83 e0 f0             	and    $0xfffffff0,%eax
     8c2:	29 c4                	sub    %eax,%esp
     8c4:	89 e6                	mov    %esp,%esi
    int tids[threadsNum];
     8c6:	29 c4                	sub    %eax,%esp
    for(int i = 0;i < threadsNum;i++){
     8c8:	85 c9                	test   %ecx,%ecx
    int tids[threadsNum];
     8ca:	89 e7                	mov    %esp,%edi
    for(int i = 0;i < threadsNum;i++){
     8cc:	0f 8e 1e 01 00 00    	jle    9f0 <test_kthread3+0x150>
     8d2:	8b 45 08             	mov    0x8(%ebp),%eax
     8d5:	bb 02 00 00 00       	mov    $0x2,%ebx
     8da:	83 c0 02             	add    $0x2,%eax
     8dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
     8e0:	eb 21                	jmp    903 <test_kthread3+0x63>
     8e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printf(1,"create thread %d succeed\n",i+2);
     8e8:	83 ec 04             	sub    $0x4,%esp
     8eb:	53                   	push   %ebx
     8ec:	68 81 1d 00 00       	push   $0x1d81
     8f1:	83 c3 01             	add    $0x1,%ebx
     8f4:	6a 01                	push   $0x1
     8f6:	e8 d5 0b 00 00       	call   14d0 <printf>
     8fb:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     8fe:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
     901:	74 49                	je     94c <test_kthread3+0xac>
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	68 a0 0f 00 00       	push   $0xfa0
     90b:	e8 20 0e 00 00       	call   1730 <malloc>
     910:	05 a0 0f 00 00       	add    $0xfa0,%eax
        stacks[i] = stack;
     915:	89 44 9e f8          	mov    %eax,-0x8(%esi,%ebx,4)
        tids[i] = kthread_create(run5, stacks[i]);
     919:	59                   	pop    %ecx
     91a:	5a                   	pop    %edx
     91b:	50                   	push   %eax
     91c:	68 40 01 00 00       	push   $0x140
     921:	e8 bc 0a 00 00       	call   13e2 <kthread_create>
        if(tids[i] > 0){
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
        tids[i] = kthread_create(run5, stacks[i]);
     92b:	89 44 9f f8          	mov    %eax,-0x8(%edi,%ebx,4)
        if(tids[i] > 0){
     92f:	7f b7                	jg     8e8 <test_kthread3+0x48>
            printf(1,"create thread %d failed\n",i+2);
     931:	83 ec 04             	sub    $0x4,%esp
     934:	53                   	push   %ebx
     935:	68 9b 1d 00 00       	push   $0x1d9b
     93a:	83 c3 01             	add    $0x1,%ebx
     93d:	6a 01                	push   $0x1
     93f:	e8 8c 0b 00 00       	call   14d0 <printf>
     944:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     947:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
     94a:	75 b7                	jne    903 <test_kthread3+0x63>
    for(int i = 0;i < threadsNum-1;i++){
     94c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     94f:	85 c0                	test   %eax,%eax
     951:	7e 52                	jle    9a5 <test_kthread3+0x105>
    for(int i = 0;i < threadsNum;i++){
     953:	31 db                	xor    %ebx,%ebx
     955:	89 75 e0             	mov    %esi,-0x20(%ebp)
     958:	89 de                	mov    %ebx,%esi
     95a:	eb 11                	jmp    96d <test_kthread3+0xcd>
     95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(result == -1){
     960:	83 f8 ff             	cmp    $0xffffffff,%eax
     963:	74 73                	je     9d8 <test_kthread3+0x138>
    for(int i = 0;i < threadsNum-1;i++){
     965:	83 c6 01             	add    $0x1,%esi
     968:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
     96b:	7e 2e                	jle    99b <test_kthread3+0xfb>
        int result = kthread_join(tids[i]);
     96d:	8b 1c b7             	mov    (%edi,%esi,4),%ebx
     970:	83 ec 0c             	sub    $0xc,%esp
     973:	53                   	push   %ebx
     974:	e8 81 0a 00 00       	call   13fa <kthread_join>
        if(result == 0){
     979:	83 c4 10             	add    $0x10,%esp
     97c:	85 c0                	test   %eax,%eax
     97e:	75 e0                	jne    960 <test_kthread3+0xc0>
            printf(1,"OK - join thread %d\n",tids[i]);
     980:	83 ec 04             	sub    $0x4,%esp
    for(int i = 0;i < threadsNum-1;i++){
     983:	83 c6 01             	add    $0x1,%esi
            printf(1,"OK - join thread %d\n",tids[i]);
     986:	53                   	push   %ebx
     987:	68 54 1d 00 00       	push   $0x1d54
     98c:	6a 01                	push   $0x1
     98e:	e8 3d 0b 00 00       	call   14d0 <printf>
     993:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum-1;i++){
     996:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
     999:	7f d2                	jg     96d <test_kthread3+0xcd>
    for(int i = 0; i < threadsNum; i++){
     99b:	8b 55 08             	mov    0x8(%ebp),%edx
     99e:	8b 75 e0             	mov    -0x20(%ebp),%esi
     9a1:	85 d2                	test   %edx,%edx
     9a3:	7e 27                	jle    9cc <test_kthread3+0x12c>
    for(int i = 0;i < threadsNum;i++){
     9a5:	8b 7d 08             	mov    0x8(%ebp),%edi
     9a8:	31 db                	xor    %ebx,%ebx
     9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        free(stacks[i]);
     9b0:	83 ec 0c             	sub    $0xc,%esp
     9b3:	ff 34 9e             	pushl  (%esi,%ebx,4)
     9b6:	e8 e5 0c 00 00       	call   16a0 <free>
        stacks[i] = 0;
     9bb:	c7 04 9e 00 00 00 00 	movl   $0x0,(%esi,%ebx,4)
    for(int i = 0; i < threadsNum; i++){
     9c2:	83 c3 01             	add    $0x1,%ebx
     9c5:	83 c4 10             	add    $0x10,%esp
     9c8:	39 df                	cmp    %ebx,%edi
     9ca:	7f e4                	jg     9b0 <test_kthread3+0x110>
    exit();
     9cc:	e8 71 09 00 00       	call   1342 <exit>
     9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - join thread %d\n",tids[i]);
     9d8:	83 ec 04             	sub    $0x4,%esp
     9db:	53                   	push   %ebx
     9dc:	68 69 1d 00 00       	push   $0x1d69
     9e1:	6a 01                	push   $0x1
     9e3:	e8 e8 0a 00 00       	call   14d0 <printf>
     9e8:	83 c4 10             	add    $0x10,%esp
     9eb:	e9 75 ff ff ff       	jmp    965 <test_kthread3+0xc5>
    for(int i = 0;i < threadsNum-1;i++){
     9f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     9f4:	7e d6                	jle    9cc <test_kthread3+0x12c>
     9f6:	e9 58 ff ff ff       	jmp    953 <test_kthread3+0xb3>
     9fb:	90                   	nop
     9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a00 <test_mutex1>:
void test_mutex1(int threadsNum, void (*func)()){
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	57                   	push   %edi
     a04:	56                   	push   %esi
     a05:	53                   	push   %ebx
     a06:	83 ec 1c             	sub    $0x1c,%esp
     a09:	8b 75 08             	mov    0x8(%ebp),%esi
    void* stacks[threadsNum];
     a0c:	8d 04 b5 12 00 00 00 	lea    0x12(,%esi,4),%eax
     a13:	83 e0 f0             	and    $0xfffffff0,%eax
     a16:	29 c4                	sub    %eax,%esp
     a18:	89 e7                	mov    %esp,%edi
    int tids[threadsNum];
     a1a:	29 c4                	sub    %eax,%esp
    for(int i = 0;i < threadsNum;i++){
     a1c:	85 f6                	test   %esi,%esi
    int tids[threadsNum];
     a1e:	89 65 e4             	mov    %esp,-0x1c(%ebp)
    for(int i = 0;i < threadsNum;i++){
     a21:	0f 8e c5 00 00 00    	jle    aec <test_mutex1+0xec>
     a27:	31 db                	xor    %ebx,%ebx
     a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
     a30:	83 ec 0c             	sub    $0xc,%esp
     a33:	68 a0 0f 00 00       	push   $0xfa0
     a38:	e8 f3 0c 00 00       	call   1730 <malloc>
     a3d:	05 a0 0f 00 00       	add    $0xfa0,%eax
        stacks[i] = stack;
     a42:	89 04 9f             	mov    %eax,(%edi,%ebx,4)
        tids[i] = kthread_create(func, stack);
     a45:	5a                   	pop    %edx
     a46:	59                   	pop    %ecx
     a47:	50                   	push   %eax
     a48:	ff 75 0c             	pushl  0xc(%ebp)
     a4b:	e8 92 09 00 00       	call   13e2 <kthread_create>
     a50:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     a53:	89 04 99             	mov    %eax,(%ecx,%ebx,4)
    for(int i = 0;i < threadsNum;i++){
     a56:	83 c3 01             	add    $0x1,%ebx
        sleep(100);
     a59:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     a60:	e8 6d 09 00 00       	call   13d2 <sleep>
    for(int i = 0;i < threadsNum;i++){
     a65:	83 c4 10             	add    $0x10,%esp
     a68:	39 de                	cmp    %ebx,%esi
     a6a:	75 c4                	jne    a30 <test_mutex1+0x30>
    for(int i = 0;i < threadsNum;i++){
     a6c:	31 d2                	xor    %edx,%edx
     a6e:	eb 10                	jmp    a80 <test_mutex1+0x80>
        if(result == -1){
     a70:	83 f8 ff             	cmp    $0xffffffff,%eax
     a73:	0f 84 7f 00 00 00    	je     af8 <test_mutex1+0xf8>
    for(int i = 0;i < threadsNum;i++){
     a79:	83 c2 01             	add    $0x1,%edx
     a7c:	39 da                	cmp    %ebx,%edx
     a7e:	74 48                	je     ac8 <test_mutex1+0xc8>
        printf(1,"trying to join thread %d\n",tids[i]);
     a80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a83:	83 ec 04             	sub    $0x4,%esp
     a86:	89 55 e0             	mov    %edx,-0x20(%ebp)
     a89:	8b 34 90             	mov    (%eax,%edx,4),%esi
     a8c:	56                   	push   %esi
     a8d:	68 b4 1d 00 00       	push   $0x1db4
     a92:	6a 01                	push   $0x1
     a94:	e8 37 0a 00 00       	call   14d0 <printf>
        int result = kthread_join(tids[i]);
     a99:	89 34 24             	mov    %esi,(%esp)
     a9c:	e8 59 09 00 00       	call   13fa <kthread_join>
        if(result == 0){
     aa1:	83 c4 10             	add    $0x10,%esp
     aa4:	85 c0                	test   %eax,%eax
     aa6:	8b 55 e0             	mov    -0x20(%ebp),%edx
     aa9:	75 c5                	jne    a70 <test_mutex1+0x70>
            printf(1,"OK - join thread %d\n",tids[i]);
     aab:	83 ec 04             	sub    $0x4,%esp
     aae:	56                   	push   %esi
     aaf:	68 54 1d 00 00       	push   $0x1d54
     ab4:	6a 01                	push   $0x1
     ab6:	e8 15 0a 00 00       	call   14d0 <printf>
     abb:	8b 55 e0             	mov    -0x20(%ebp),%edx
     abe:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     ac1:	83 c2 01             	add    $0x1,%edx
     ac4:	39 da                	cmp    %ebx,%edx
     ac6:	75 b8                	jne    a80 <test_mutex1+0x80>
     ac8:	31 f6                	xor    %esi,%esi
     aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        free(stacks[i]);
     ad0:	83 ec 0c             	sub    $0xc,%esp
     ad3:	ff 34 b7             	pushl  (%edi,%esi,4)
     ad6:	e8 c5 0b 00 00       	call   16a0 <free>
        stacks[i] = 0;
     adb:	c7 04 b7 00 00 00 00 	movl   $0x0,(%edi,%esi,4)
    for(int i = 0; i < threadsNum; i++){
     ae2:	83 c6 01             	add    $0x1,%esi
     ae5:	83 c4 10             	add    $0x10,%esp
     ae8:	39 de                	cmp    %ebx,%esi
     aea:	75 e4                	jne    ad0 <test_mutex1+0xd0>
    exit();
     aec:	e8 51 08 00 00       	call   1342 <exit>
     af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - join thread %d\n",tids[i]);
     af8:	83 ec 04             	sub    $0x4,%esp
     afb:	89 55 e0             	mov    %edx,-0x20(%ebp)
     afe:	56                   	push   %esi
     aff:	68 69 1d 00 00       	push   $0x1d69
     b04:	6a 01                	push   $0x1
     b06:	e8 c5 09 00 00       	call   14d0 <printf>
     b0b:	83 c4 10             	add    $0x10,%esp
     b0e:	8b 55 e0             	mov    -0x20(%ebp),%edx
     b11:	e9 63 ff ff ff       	jmp    a79 <test_mutex1+0x79>
     b16:	8d 76 00             	lea    0x0(%esi),%esi
     b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b20 <test_mutex2>:
void test_mutex2(int threadsNum){
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	57                   	push   %edi
     b24:	56                   	push   %esi
     b25:	53                   	push   %ebx
     b26:	83 ec 1c             	sub    $0x1c,%esp
    int tids[threadsNum];
     b29:	8b 45 08             	mov    0x8(%ebp),%eax
    waitFlag = 1;
     b2c:	c7 05 44 28 00 00 01 	movl   $0x1,0x2844
     b33:	00 00 00 
    int tids[threadsNum];
     b36:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     b3d:	83 e0 f0             	and    $0xfffffff0,%eax
     b40:	29 c4                	sub    %eax,%esp
     b42:	89 65 e4             	mov    %esp,-0x1c(%ebp)
    void* stacks[threadsNum];
     b45:	29 c4                	sub    %eax,%esp
    mid = kthread_mutex_alloc(); 
     b47:	e8 b6 08 00 00       	call   1402 <kthread_mutex_alloc>
    if(mid == -1){ 
     b4c:	83 f8 ff             	cmp    $0xffffffff,%eax
    void* stacks[threadsNum];
     b4f:	89 e7                	mov    %esp,%edi
    mid = kthread_mutex_alloc(); 
     b51:	a3 24 28 00 00       	mov    %eax,0x2824
    if(mid == -1){ 
     b56:	0f 84 24 01 00 00    	je     c80 <test_mutex2+0x160>
    for(int i = 0;i < threadsNum;i++){
     b5c:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b5f:	85 c9                	test   %ecx,%ecx
     b61:	0f 8e 61 01 00 00    	jle    cc8 <test_mutex2+0x1a8>
     b67:	31 db                	xor    %ebx,%ebx
     b69:	89 de                	mov    %ebx,%esi
     b6b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
     b6e:	66 90                	xchg   %ax,%ax
        void* stack = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
     b70:	83 ec 0c             	sub    $0xc,%esp
     b73:	68 a0 0f 00 00       	push   $0xfa0
     b78:	e8 b3 0b 00 00       	call   1730 <malloc>
     b7d:	05 a0 0f 00 00       	add    $0xfa0,%eax
        stacks[i] = stack;
     b82:	89 04 b7             	mov    %eax,(%edi,%esi,4)
        tids[i] = kthread_create(run4, stack);
     b85:	59                   	pop    %ecx
     b86:	5a                   	pop    %edx
     b87:	50                   	push   %eax
     b88:	68 60 01 00 00       	push   $0x160
     b8d:	e8 50 08 00 00       	call   13e2 <kthread_create>
    for(int i = 0;i < threadsNum;i++){
     b92:	83 c4 10             	add    $0x10,%esp
        tids[i] = kthread_create(run4, stack);
     b95:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    for(int i = 0;i < threadsNum;i++){
     b98:	83 c6 01             	add    $0x1,%esi
     b9b:	39 75 08             	cmp    %esi,0x8(%ebp)
     b9e:	75 d0                	jne    b70 <test_mutex2+0x50>
    for(int i = 0;i < threadsNum;i++){
     ba0:	31 d2                	xor    %edx,%edx
     ba2:	89 7d e0             	mov    %edi,-0x20(%ebp)
     ba5:	89 f3                	mov    %esi,%ebx
    waitFlag = 0;
     ba7:	c7 05 44 28 00 00 00 	movl   $0x0,0x2844
     bae:	00 00 00 
     bb1:	89 d7                	mov    %edx,%edi
     bb3:	eb 13                	jmp    bc8 <test_mutex2+0xa8>
     bb5:	8d 76 00             	lea    0x0(%esi),%esi
        if(result == -1){
     bb8:	83 f8 ff             	cmp    $0xffffffff,%eax
     bbb:	0f 84 a7 00 00 00    	je     c68 <test_mutex2+0x148>
    for(int i = 0;i < threadsNum;i++){
     bc1:	83 c7 01             	add    $0x1,%edi
     bc4:	39 df                	cmp    %ebx,%edi
     bc6:	74 3f                	je     c07 <test_mutex2+0xe7>
        printf(1,"trying to join thread %d\n",tids[i]);
     bc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bcb:	83 ec 04             	sub    $0x4,%esp
     bce:	8b 34 b8             	mov    (%eax,%edi,4),%esi
     bd1:	56                   	push   %esi
     bd2:	68 b4 1d 00 00       	push   $0x1db4
     bd7:	6a 01                	push   $0x1
     bd9:	e8 f2 08 00 00       	call   14d0 <printf>
        int result = kthread_join(tids[i]);
     bde:	89 34 24             	mov    %esi,(%esp)
     be1:	e8 14 08 00 00       	call   13fa <kthread_join>
        if(result == 0){
     be6:	83 c4 10             	add    $0x10,%esp
     be9:	85 c0                	test   %eax,%eax
     beb:	75 cb                	jne    bb8 <test_mutex2+0x98>
            printf(1,"OK - join thread %d\n",tids[i]);
     bed:	83 ec 04             	sub    $0x4,%esp
    for(int i = 0;i < threadsNum;i++){
     bf0:	83 c7 01             	add    $0x1,%edi
            printf(1,"OK - join thread %d\n",tids[i]);
     bf3:	56                   	push   %esi
     bf4:	68 54 1d 00 00       	push   $0x1d54
     bf9:	6a 01                	push   $0x1
     bfb:	e8 d0 08 00 00       	call   14d0 <printf>
     c00:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     c03:	39 df                	cmp    %ebx,%edi
     c05:	75 c1                	jne    bc8 <test_mutex2+0xa8>
    result = kthread_mutex_dealloc(mid); 
     c07:	83 ec 0c             	sub    $0xc,%esp
     c0a:	ff 35 24 28 00 00    	pushl  0x2824
     c10:	8b 7d e0             	mov    -0x20(%ebp),%edi
     c13:	e8 f2 07 00 00       	call   140a <kthread_mutex_dealloc>
    if(result == -1){ 
     c18:	83 c4 10             	add    $0x10,%esp
     c1b:	83 f8 ff             	cmp    $0xffffffff,%eax
     c1e:	74 76                	je     c96 <test_mutex2+0x176>
    printf(1,"num is %d\n",num);
     c20:	83 ec 04             	sub    $0x4,%esp
     c23:	ff 35 2c 28 00 00    	pushl  0x282c
     c29:	68 e9 1d 00 00       	push   $0x1de9
     c2e:	6a 01                	push   $0x1
     c30:	e8 9b 08 00 00       	call   14d0 <printf>
     c35:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < threadsNum;i++){
     c38:	8b 75 08             	mov    0x8(%ebp),%esi
     c3b:	31 db                	xor    %ebx,%ebx
     c3d:	8d 76 00             	lea    0x0(%esi),%esi
        free(stacks[i]);
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	ff 34 9f             	pushl  (%edi,%ebx,4)
     c46:	e8 55 0a 00 00       	call   16a0 <free>
        stacks[i] = 0;
     c4b:	c7 04 9f 00 00 00 00 	movl   $0x0,(%edi,%ebx,4)
    for(int i = 0; i < threadsNum; i++){
     c52:	83 c3 01             	add    $0x1,%ebx
     c55:	83 c4 10             	add    $0x10,%esp
     c58:	39 de                	cmp    %ebx,%esi
     c5a:	7f e4                	jg     c40 <test_mutex2+0x120>
    exit();
     c5c:	e8 e1 06 00 00       	call   1342 <exit>
     c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - join thread %d\n",tids[i]);
     c68:	83 ec 04             	sub    $0x4,%esp
     c6b:	56                   	push   %esi
     c6c:	68 69 1d 00 00       	push   $0x1d69
     c71:	6a 01                	push   $0x1
     c73:	e8 58 08 00 00       	call   14d0 <printf>
     c78:	83 c4 10             	add    $0x10,%esp
     c7b:	e9 41 ff ff ff       	jmp    bc1 <test_mutex2+0xa1>
        printf(1,"mutex allocated unsuccessfully\n"); 
     c80:	53                   	push   %ebx
     c81:	53                   	push   %ebx
     c82:	68 00 20 00 00       	push   $0x2000
     c87:	6a 01                	push   $0x1
     c89:	e8 42 08 00 00       	call   14d0 <printf>
     c8e:	83 c4 10             	add    $0x10,%esp
     c91:	e9 c6 fe ff ff       	jmp    b5c <test_mutex2+0x3c>
        printf(1,"Error - mutex deallocated\n"); 
     c96:	52                   	push   %edx
     c97:	52                   	push   %edx
     c98:	68 ce 1d 00 00       	push   $0x1dce
     c9d:	6a 01                	push   $0x1
     c9f:	e8 2c 08 00 00       	call   14d0 <printf>
    printf(1,"num is %d\n",num);
     ca4:	83 c4 0c             	add    $0xc,%esp
     ca7:	ff 35 2c 28 00 00    	pushl  0x282c
     cad:	68 e9 1d 00 00       	push   $0x1de9
     cb2:	6a 01                	push   $0x1
     cb4:	e8 17 08 00 00       	call   14d0 <printf>
    for(int i = 0; i < threadsNum; i++){
     cb9:	83 c4 10             	add    $0x10,%esp
     cbc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     cc0:	0f 8f 72 ff ff ff    	jg     c38 <test_mutex2+0x118>
     cc6:	eb 94                	jmp    c5c <test_mutex2+0x13c>
    result = kthread_mutex_dealloc(mid); 
     cc8:	83 ec 0c             	sub    $0xc,%esp
     ccb:	ff 35 24 28 00 00    	pushl  0x2824
    waitFlag = 0;
     cd1:	c7 05 44 28 00 00 00 	movl   $0x0,0x2844
     cd8:	00 00 00 
    result = kthread_mutex_dealloc(mid); 
     cdb:	e8 2a 07 00 00       	call   140a <kthread_mutex_dealloc>
    if(result == -1){ 
     ce0:	83 c4 10             	add    $0x10,%esp
     ce3:	83 c0 01             	add    $0x1,%eax
     ce6:	74 ae                	je     c96 <test_mutex2+0x176>
    printf(1,"num is %d\n",num);
     ce8:	50                   	push   %eax
     ce9:	ff 35 2c 28 00 00    	pushl  0x282c
     cef:	68 e9 1d 00 00       	push   $0x1de9
     cf4:	6a 01                	push   $0x1
     cf6:	e8 d5 07 00 00       	call   14d0 <printf>
     cfb:	83 c4 10             	add    $0x10,%esp
     cfe:	e9 59 ff ff ff       	jmp    c5c <test_mutex2+0x13c>
     d03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d10 <test_tree1>:
void test_tree1(){
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	53                   	push   %ebx
    for(int i = 1; i < 5; i++){
     d15:	bb 01 00 00 00       	mov    $0x1,%ebx
        tree = trnmnt_tree_alloc(i); 
     d1a:	83 ec 0c             	sub    $0xc,%esp
     d1d:	53                   	push   %ebx
     d1e:	e8 ed 0b 00 00       	call   1910 <trnmnt_tree_alloc>
        if(tree == 0){ 
     d23:	83 c4 10             	add    $0x10,%esp
     d26:	85 c0                	test   %eax,%eax
        tree = trnmnt_tree_alloc(i); 
     d28:	89 c6                	mov    %eax,%esi
        if(tree == 0){ 
     d2a:	74 4c                	je     d78 <test_tree1+0x68>
        print_tree(tree);
     d2c:	83 ec 0c             	sub    $0xc,%esp
     d2f:	56                   	push   %esi
     d30:	e8 eb 0c 00 00       	call   1a20 <print_tree>
        printf(1, "\n--------------------------------\n");
     d35:	58                   	pop    %eax
     d36:	5a                   	pop    %edx
     d37:	68 20 20 00 00       	push   $0x2020
     d3c:	6a 01                	push   $0x1
     d3e:	e8 8d 07 00 00       	call   14d0 <printf>
        result = trnmnt_tree_dealloc(tree); 
     d43:	89 34 24             	mov    %esi,(%esp)
     d46:	e8 75 0d 00 00       	call   1ac0 <trnmnt_tree_dealloc>
        if(result == -1){ 
     d4b:	83 c4 10             	add    $0x10,%esp
     d4e:	83 f8 ff             	cmp    $0xffffffff,%eax
     d51:	74 0d                	je     d60 <test_tree1+0x50>
    for(int i = 1; i < 5; i++){
     d53:	83 c3 01             	add    $0x1,%ebx
     d56:	83 fb 05             	cmp    $0x5,%ebx
     d59:	75 bf                	jne    d1a <test_tree1+0xa>
    exit();
     d5b:	e8 e2 05 00 00       	call   1342 <exit>
            printf(1,"Error - trnmnt_tree deallocate\n"); 
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	68 44 20 00 00       	push   $0x2044
     d68:	6a 01                	push   $0x1
     d6a:	e8 61 07 00 00       	call   14d0 <printf>
     d6f:	83 c4 10             	add    $0x10,%esp
     d72:	eb df                	jmp    d53 <test_tree1+0x43>
     d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - trnmnt_tree allocate\n"); 
     d78:	83 ec 08             	sub    $0x8,%esp
     d7b:	68 f4 1d 00 00       	push   $0x1df4
     d80:	6a 01                	push   $0x1
     d82:	e8 49 07 00 00       	call   14d0 <printf>
     d87:	83 c4 10             	add    $0x10,%esp
     d8a:	eb a0                	jmp    d2c <test_tree1+0x1c>
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d90 <test_tree2>:
void test_tree2(){
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	56                   	push   %esi
     d95:	53                   	push   %ebx
     d96:	83 ec 1c             	sub    $0x1c,%esp
    for(depth = 1; depth < 5; depth++){
     d99:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
        tree = trnmnt_tree_alloc(depth); 
     da0:	83 ec 0c             	sub    $0xc,%esp
     da3:	ff 75 e4             	pushl  -0x1c(%ebp)
     da6:	e8 65 0b 00 00       	call   1910 <trnmnt_tree_alloc>
        if(tree == 0){ 
     dab:	83 c4 10             	add    $0x10,%esp
     dae:	85 c0                	test   %eax,%eax
        tree = trnmnt_tree_alloc(depth); 
     db0:	89 c6                	mov    %eax,%esi
        if(tree == 0){ 
     db2:	0f 84 10 01 00 00    	je     ec8 <test_tree2+0x138>
    for(depth = 1; depth < 5; depth++){
     db8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
     dbb:	bb 01 00 00 00       	mov    $0x1,%ebx
     dc0:	01 db                	add    %ebx,%ebx
}

// power calculation
int findPower(int base, int power) {
   if (power == 0)
     dc2:	83 ef 01             	sub    $0x1,%edi
     dc5:	75 f9                	jne    dc0 <test_tree2+0x30>
        int maxIndex = findPower(2,depth)-1;
     dc7:	8d 43 ff             	lea    -0x1(%ebx),%eax
        printf(1, "depth=%d, maxIndex=%d\n", depth, maxIndex);
     dca:	50                   	push   %eax
     dcb:	ff 75 e4             	pushl  -0x1c(%ebp)
     dce:	68 12 1e 00 00       	push   $0x1e12
     dd3:	6a 01                	push   $0x1
     dd5:	e8 f6 06 00 00       	call   14d0 <printf>
     dda:	83 c4 10             	add    $0x10,%esp
     ddd:	eb 2b                	jmp    e0a <test_tree2+0x7a>
     ddf:	90                   	nop
            if(result == -1){  
     de0:	83 f8 ff             	cmp    $0xffffffff,%eax
     de3:	0f 84 87 00 00 00    	je     e70 <test_tree2+0xe0>
            result = trnmnt_tree_release(tree, index); 
     de9:	83 ec 08             	sub    $0x8,%esp
     dec:	57                   	push   %edi
     ded:	56                   	push   %esi
     dee:	e8 dd 0d 00 00       	call   1bd0 <trnmnt_tree_release>
            if(result == 0){  
     df3:	83 c4 10             	add    $0x10,%esp
     df6:	85 c0                	test   %eax,%eax
     df8:	74 36                	je     e30 <test_tree2+0xa0>
            if(result == -1){  
     dfa:	83 f8 ff             	cmp    $0xffffffff,%eax
     dfd:	0f 84 8d 00 00 00    	je     e90 <test_tree2+0x100>
        for(int index = 0; index <= maxIndex; index++){
     e03:	83 c7 01             	add    $0x1,%edi
     e06:	39 df                	cmp    %ebx,%edi
     e08:	74 40                	je     e4a <test_tree2+0xba>
            result = trnmnt_tree_acquire(tree, index); 
     e0a:	83 ec 08             	sub    $0x8,%esp
     e0d:	57                   	push   %edi
     e0e:	56                   	push   %esi
     e0f:	e8 5c 0d 00 00       	call   1b70 <trnmnt_tree_acquire>
            if(result == 0){  
     e14:	83 c4 10             	add    $0x10,%esp
     e17:	85 c0                	test   %eax,%eax
     e19:	75 c5                	jne    de0 <test_tree2+0x50>
                printf(1,"OK - trnmnt_tree lock by ID=%d\n", index); 
     e1b:	83 ec 04             	sub    $0x4,%esp
     e1e:	57                   	push   %edi
     e1f:	68 64 20 00 00       	push   $0x2064
     e24:	6a 01                	push   $0x1
     e26:	e8 a5 06 00 00       	call   14d0 <printf>
     e2b:	83 c4 10             	add    $0x10,%esp
     e2e:	eb b9                	jmp    de9 <test_tree2+0x59>
                printf(1,"OK - trnmnt_tree unlock by ID=%d\n", index); 
     e30:	83 ec 04             	sub    $0x4,%esp
     e33:	57                   	push   %edi
     e34:	68 a8 20 00 00       	push   $0x20a8
        for(int index = 0; index <= maxIndex; index++){
     e39:	83 c7 01             	add    $0x1,%edi
                printf(1,"OK - trnmnt_tree unlock by ID=%d\n", index); 
     e3c:	6a 01                	push   $0x1
     e3e:	e8 8d 06 00 00       	call   14d0 <printf>
     e43:	83 c4 10             	add    $0x10,%esp
        for(int index = 0; index <= maxIndex; index++){
     e46:	39 df                	cmp    %ebx,%edi
     e48:	75 c0                	jne    e0a <test_tree2+0x7a>
        result = trnmnt_tree_dealloc(tree); 
     e4a:	83 ec 0c             	sub    $0xc,%esp
     e4d:	56                   	push   %esi
     e4e:	e8 6d 0c 00 00       	call   1ac0 <trnmnt_tree_dealloc>
        if(result == -1){ 
     e53:	83 c4 10             	add    $0x10,%esp
     e56:	83 f8 ff             	cmp    $0xffffffff,%eax
     e59:	74 55                	je     eb0 <test_tree2+0x120>
    for(depth = 1; depth < 5; depth++){
     e5b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     e5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e62:	83 f8 05             	cmp    $0x5,%eax
     e65:	0f 85 35 ff ff ff    	jne    da0 <test_tree2+0x10>
    exit();
     e6b:	e8 d2 04 00 00       	call   1342 <exit>
                printf(1,"Error - trnmnt_tree lock by ID=%d\n", index); 
     e70:	83 ec 04             	sub    $0x4,%esp
     e73:	57                   	push   %edi
     e74:	68 84 20 00 00       	push   $0x2084
     e79:	6a 01                	push   $0x1
     e7b:	e8 50 06 00 00       	call   14d0 <printf>
     e80:	83 c4 10             	add    $0x10,%esp
     e83:	e9 61 ff ff ff       	jmp    de9 <test_tree2+0x59>
     e88:	90                   	nop
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                printf(1,"Error - trnmnt_tree unlock by ID=%d\n", index); 
     e90:	83 ec 04             	sub    $0x4,%esp
     e93:	57                   	push   %edi
     e94:	68 cc 20 00 00       	push   $0x20cc
     e99:	6a 01                	push   $0x1
     e9b:	e8 30 06 00 00       	call   14d0 <printf>
     ea0:	83 c4 10             	add    $0x10,%esp
     ea3:	e9 5b ff ff ff       	jmp    e03 <test_tree2+0x73>
     ea8:	90                   	nop
     ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - trnmnt_tree deallocate\n"); 
     eb0:	83 ec 08             	sub    $0x8,%esp
     eb3:	68 44 20 00 00       	push   $0x2044
     eb8:	6a 01                	push   $0x1
     eba:	e8 11 06 00 00       	call   14d0 <printf>
     ebf:	83 c4 10             	add    $0x10,%esp
     ec2:	eb 97                	jmp    e5b <test_tree2+0xcb>
     ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Error - trnmnt_tree allocate\n"); 
     ec8:	83 ec 08             	sub    $0x8,%esp
     ecb:	68 f4 1d 00 00       	push   $0x1df4
     ed0:	6a 01                	push   $0x1
     ed2:	e8 f9 05 00 00       	call   14d0 <printf>
     ed7:	83 c4 10             	add    $0x10,%esp
     eda:	e9 d9 fe ff ff       	jmp    db8 <test_tree2+0x28>
     edf:	90                   	nop

00000ee0 <run8>:
void run8(){
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	83 ec 08             	sub    $0x8,%esp
     ee6:	8d 76 00             	lea    0x0(%esi),%esi
     ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(waitFlag2){} 
     ef0:	a1 48 28 00 00       	mov    0x2848,%eax
     ef5:	85 c0                	test   %eax,%eax
     ef7:	75 f7                	jne    ef0 <run8+0x10>
    result6 = trnmnt_tree_acquire(tree, 6); 
     ef9:	83 ec 08             	sub    $0x8,%esp
     efc:	6a 06                	push   $0x6
     efe:	ff 35 50 28 00 00    	pushl  0x2850
     f04:	e8 67 0c 00 00       	call   1b70 <trnmnt_tree_acquire>
    if(result6 == 0){  
     f09:	83 c4 10             	add    $0x10,%esp
     f0c:	85 c0                	test   %eax,%eax
     f0e:	74 50                	je     f60 <run8+0x80>
    if(result6 == -1){  
     f10:	83 f8 ff             	cmp    $0xffffffff,%eax
     f13:	74 2b                	je     f40 <run8+0x60>
    result6 = trnmnt_tree_release(tree, 6); 
     f15:	83 ec 08             	sub    $0x8,%esp
     f18:	6a 06                	push   $0x6
     f1a:	ff 35 50 28 00 00    	pushl  0x2850
     f20:	e8 ab 0c 00 00       	call   1bd0 <trnmnt_tree_release>
    if(result == 0){  
     f25:	a1 4c 28 00 00       	mov    0x284c,%eax
     f2a:	83 c4 10             	add    $0x10,%esp
     f2d:	85 c0                	test   %eax,%eax
     f2f:	74 4f                	je     f80 <run8+0xa0>
    if(result == -1){  
     f31:	83 f8 ff             	cmp    $0xffffffff,%eax
     f34:	74 6c                	je     fa2 <run8+0xc2>
}
     f36:	c9                   	leave  
    kthread_exit(); 
     f37:	e9 b6 04 00 00       	jmp    13f2 <kthread_exit>
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"Error - trnmnt_tree_acquire by thread %d\n", kthread_id()); 
     f40:	e8 a5 04 00 00       	call   13ea <kthread_id>
     f45:	83 ec 04             	sub    $0x4,%esp
     f48:	50                   	push   %eax
     f49:	68 80 1f 00 00       	push   $0x1f80
     f4e:	6a 01                	push   $0x1
     f50:	e8 7b 05 00 00       	call   14d0 <printf>
     f55:	83 c4 10             	add    $0x10,%esp
     f58:	eb bb                	jmp    f15 <run8+0x35>
     f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"OK - trnmnt_tree_acquire thread %d should succeed after release\n", kthread_id()); 
     f60:	e8 85 04 00 00       	call   13ea <kthread_id>
     f65:	83 ec 04             	sub    $0x4,%esp
     f68:	50                   	push   %eax
     f69:	68 f4 20 00 00       	push   $0x20f4
     f6e:	6a 01                	push   $0x1
     f70:	e8 5b 05 00 00       	call   14d0 <printf>
     f75:	83 c4 10             	add    $0x10,%esp
     f78:	eb 9b                	jmp    f15 <run8+0x35>
     f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"OK - trnmnt_tree_release by thread %d\n", kthread_id()); 
     f80:	e8 65 04 00 00       	call   13ea <kthread_id>
     f85:	83 ec 04             	sub    $0x4,%esp
     f88:	50                   	push   %eax
     f89:	68 ac 1f 00 00       	push   $0x1fac
     f8e:	6a 01                	push   $0x1
     f90:	e8 3b 05 00 00       	call   14d0 <printf>
     f95:	a1 4c 28 00 00       	mov    0x284c,%eax
     f9a:	83 c4 10             	add    $0x10,%esp
    if(result == -1){  
     f9d:	83 f8 ff             	cmp    $0xffffffff,%eax
     fa0:	75 94                	jne    f36 <run8+0x56>
        printf(1,"Error - trnmnt_tree_release by thread %d\n", kthread_id()); 
     fa2:	e8 43 04 00 00       	call   13ea <kthread_id>
     fa7:	83 ec 04             	sub    $0x4,%esp
     faa:	50                   	push   %eax
     fab:	68 d4 1f 00 00       	push   $0x1fd4
     fb0:	6a 01                	push   $0x1
     fb2:	e8 19 05 00 00       	call   14d0 <printf>
     fb7:	83 c4 10             	add    $0x10,%esp
}
     fba:	c9                   	leave  
    kthread_exit(); 
     fbb:	e9 32 04 00 00       	jmp    13f2 <kthread_exit>

00000fc0 <test_tree3>:
void test_tree3(void (*func1)(), void (*func2)()){
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	57                   	push   %edi
     fc4:	56                   	push   %esi
     fc5:	53                   	push   %ebx
     fc6:	83 ec 28             	sub    $0x28,%esp
    waitFlag2 = 1;
     fc9:	c7 05 48 28 00 00 01 	movl   $0x1,0x2848
     fd0:	00 00 00 
    tree = trnmnt_tree_alloc(3); 
     fd3:	6a 03                	push   $0x3
     fd5:	e8 36 09 00 00       	call   1910 <trnmnt_tree_alloc>
    if(tree == 0){ 
     fda:	83 c4 10             	add    $0x10,%esp
     fdd:	85 c0                	test   %eax,%eax
    tree = trnmnt_tree_alloc(3); 
     fdf:	a3 50 28 00 00       	mov    %eax,0x2850
    if(tree == 0){ 
     fe4:	0f 84 b3 00 00 00    	je     109d <test_tree3+0xdd>
    print_tree(tree);
     fea:	83 ec 0c             	sub    $0xc,%esp
     fed:	50                   	push   %eax
     fee:	e8 2d 0a 00 00       	call   1a20 <print_tree>
        stacks[i] = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
     ff3:	c7 04 24 a0 0f 00 00 	movl   $0xfa0,(%esp)
     ffa:	e8 31 07 00 00       	call   1730 <malloc>
     fff:	c7 04 24 a0 0f 00 00 	movl   $0xfa0,(%esp)
    1006:	8d b0 a0 0f 00 00    	lea    0xfa0(%eax),%esi
    100c:	e8 1f 07 00 00       	call   1730 <malloc>
    tids[0] = kthread_create(func1, stacks[0]);
    1011:	59                   	pop    %ecx
    1012:	5f                   	pop    %edi
    1013:	56                   	push   %esi
    1014:	ff 75 08             	pushl  0x8(%ebp)
        stacks[i] = ((char*) malloc(MAX_STACK_SIZE*sizeof(char))) + MAX_STACK_SIZE;
    1017:	8d 98 a0 0f 00 00    	lea    0xfa0(%eax),%ebx
    tids[0] = kthread_create(func1, stacks[0]);
    101d:	e8 c0 03 00 00       	call   13e2 <kthread_create>
    1022:	89 c7                	mov    %eax,%edi
    tids[1] = kthread_create(func2, stacks[1]);
    1024:	58                   	pop    %eax
    1025:	5a                   	pop    %edx
    1026:	53                   	push   %ebx
    1027:	ff 75 0c             	pushl  0xc(%ebp)
    102a:	e8 b3 03 00 00       	call   13e2 <kthread_create>
        int result = kthread_join(tids[i]);
    102f:	89 3c 24             	mov    %edi,(%esp)
    tids[1] = kthread_create(func2, stacks[1]);
    1032:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    waitFlag2 = 0;
    1035:	c7 05 48 28 00 00 00 	movl   $0x0,0x2848
    103c:	00 00 00 
        int result = kthread_join(tids[i]);
    103f:	e8 b6 03 00 00       	call   13fa <kthread_join>
        if(result == -1){
    1044:	83 c4 10             	add    $0x10,%esp
    1047:	83 f8 ff             	cmp    $0xffffffff,%eax
    104a:	74 29                	je     1075 <test_tree3+0xb5>
        int result = kthread_join(tids[i]);
    104c:	83 ec 0c             	sub    $0xc,%esp
    104f:	ff 75 e4             	pushl  -0x1c(%ebp)
    1052:	e8 a3 03 00 00       	call   13fa <kthread_join>
        if(result == -1){
    1057:	83 c4 10             	add    $0x10,%esp
    105a:	83 f8 ff             	cmp    $0xffffffff,%eax
    105d:	74 29                	je     1088 <test_tree3+0xc8>
        free(stacks[i]);
    105f:	83 ec 0c             	sub    $0xc,%esp
    1062:	56                   	push   %esi
    1063:	e8 38 06 00 00       	call   16a0 <free>
    1068:	89 1c 24             	mov    %ebx,(%esp)
    106b:	e8 30 06 00 00       	call   16a0 <free>
    exit();
    1070:	e8 cd 02 00 00       	call   1342 <exit>
            printf(1,"Error - join thread %d\n",tids[i]);
    1075:	52                   	push   %edx
    1076:	57                   	push   %edi
    1077:	68 69 1d 00 00       	push   $0x1d69
    107c:	6a 01                	push   $0x1
    107e:	e8 4d 04 00 00       	call   14d0 <printf>
    1083:	83 c4 10             	add    $0x10,%esp
    1086:	eb c4                	jmp    104c <test_tree3+0x8c>
    1088:	50                   	push   %eax
    1089:	ff 75 e4             	pushl  -0x1c(%ebp)
    108c:	68 69 1d 00 00       	push   $0x1d69
    1091:	6a 01                	push   $0x1
    1093:	e8 38 04 00 00       	call   14d0 <printf>
    1098:	83 c4 10             	add    $0x10,%esp
    109b:	eb c2                	jmp    105f <test_tree3+0x9f>
        printf(1,"Error - trnmnt_tree allocate\n"); 
    109d:	51                   	push   %ecx
    109e:	51                   	push   %ecx
    109f:	68 f4 1d 00 00       	push   $0x1df4
    10a4:	6a 01                	push   $0x1
    10a6:	e8 25 04 00 00       	call   14d0 <printf>
    10ab:	a1 50 28 00 00       	mov    0x2850,%eax
    10b0:	83 c4 10             	add    $0x10,%esp
    10b3:	e9 32 ff ff ff       	jmp    fea <test_tree3+0x2a>
    10b8:	90                   	nop
    10b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010c0 <findPower>:
int findPower(int base, int power) {
    10c0:	55                   	push   %ebp
   if (power == 0)
    10c1:	b8 01 00 00 00       	mov    $0x1,%eax
int findPower(int base, int power) {
    10c6:	89 e5                	mov    %esp,%ebp
    10c8:	8b 55 0c             	mov    0xc(%ebp),%edx
    10cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
   if (power == 0)
    10ce:	85 d2                	test   %edx,%edx
    10d0:	74 0e                	je     10e0 <findPower+0x20>
    10d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10d8:	0f af c1             	imul   %ecx,%eax
    10db:	83 ea 01             	sub    $0x1,%edx
    10de:	75 f8                	jne    10d8 <findPower+0x18>
      return 1;
   else
      return (base * findPower(base, power-1));
}  
    10e0:	5d                   	pop    %ebp
    10e1:	c3                   	ret    
    10e2:	66 90                	xchg   %ax,%ax
    10e4:	66 90                	xchg   %ax,%ax
    10e6:	66 90                	xchg   %ax,%ax
    10e8:	66 90                	xchg   %ax,%ax
    10ea:	66 90                	xchg   %ax,%ax
    10ec:	66 90                	xchg   %ax,%ax
    10ee:	66 90                	xchg   %ax,%ax

000010f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	53                   	push   %ebx
    10f4:	8b 45 08             	mov    0x8(%ebp),%eax
    10f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10fa:	89 c2                	mov    %eax,%edx
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1100:	83 c1 01             	add    $0x1,%ecx
    1103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1107:	83 c2 01             	add    $0x1,%edx
    110a:	84 db                	test   %bl,%bl
    110c:	88 5a ff             	mov    %bl,-0x1(%edx)
    110f:	75 ef                	jne    1100 <strcpy+0x10>
    ;
  return os;
}
    1111:	5b                   	pop    %ebx
    1112:	5d                   	pop    %ebp
    1113:	c3                   	ret    
    1114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    111a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	53                   	push   %ebx
    1124:	8b 55 08             	mov    0x8(%ebp),%edx
    1127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    112a:	0f b6 02             	movzbl (%edx),%eax
    112d:	0f b6 19             	movzbl (%ecx),%ebx
    1130:	84 c0                	test   %al,%al
    1132:	75 1c                	jne    1150 <strcmp+0x30>
    1134:	eb 2a                	jmp    1160 <strcmp+0x40>
    1136:	8d 76 00             	lea    0x0(%esi),%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1146:	83 c1 01             	add    $0x1,%ecx
    1149:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    114c:	84 c0                	test   %al,%al
    114e:	74 10                	je     1160 <strcmp+0x40>
    1150:	38 d8                	cmp    %bl,%al
    1152:	74 ec                	je     1140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1154:	29 d8                	sub    %ebx,%eax
}
    1156:	5b                   	pop    %ebx
    1157:	5d                   	pop    %ebp
    1158:	c3                   	ret    
    1159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1162:	29 d8                	sub    %ebx,%eax
}
    1164:	5b                   	pop    %ebx
    1165:	5d                   	pop    %ebp
    1166:	c3                   	ret    
    1167:	89 f6                	mov    %esi,%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001170 <strlen>:

uint
strlen(const char *s)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1176:	80 39 00             	cmpb   $0x0,(%ecx)
    1179:	74 15                	je     1190 <strlen+0x20>
    117b:	31 d2                	xor    %edx,%edx
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	83 c2 01             	add    $0x1,%edx
    1183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1187:	89 d0                	mov    %edx,%eax
    1189:	75 f5                	jne    1180 <strlen+0x10>
    ;
  return n;
}
    118b:	5d                   	pop    %ebp
    118c:	c3                   	ret    
    118d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1190:	31 c0                	xor    %eax,%eax
}
    1192:	5d                   	pop    %ebp
    1193:	c3                   	ret    
    1194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    119a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	57                   	push   %edi
    11a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ad:	89 d7                	mov    %edx,%edi
    11af:	fc                   	cld    
    11b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11b2:	89 d0                	mov    %edx,%eax
    11b4:	5f                   	pop    %edi
    11b5:	5d                   	pop    %ebp
    11b6:	c3                   	ret    
    11b7:	89 f6                	mov    %esi,%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011c0 <strchr>:

char*
strchr(const char *s, char c)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	53                   	push   %ebx
    11c4:	8b 45 08             	mov    0x8(%ebp),%eax
    11c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    11ca:	0f b6 10             	movzbl (%eax),%edx
    11cd:	84 d2                	test   %dl,%dl
    11cf:	74 1d                	je     11ee <strchr+0x2e>
    if(*s == c)
    11d1:	38 d3                	cmp    %dl,%bl
    11d3:	89 d9                	mov    %ebx,%ecx
    11d5:	75 0d                	jne    11e4 <strchr+0x24>
    11d7:	eb 17                	jmp    11f0 <strchr+0x30>
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11e0:	38 ca                	cmp    %cl,%dl
    11e2:	74 0c                	je     11f0 <strchr+0x30>
  for(; *s; s++)
    11e4:	83 c0 01             	add    $0x1,%eax
    11e7:	0f b6 10             	movzbl (%eax),%edx
    11ea:	84 d2                	test   %dl,%dl
    11ec:	75 f2                	jne    11e0 <strchr+0x20>
      return (char*)s;
  return 0;
    11ee:	31 c0                	xor    %eax,%eax
}
    11f0:	5b                   	pop    %ebx
    11f1:	5d                   	pop    %ebp
    11f2:	c3                   	ret    
    11f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <gets>:

char*
gets(char *buf, int max)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1206:	31 f6                	xor    %esi,%esi
    1208:	89 f3                	mov    %esi,%ebx
{
    120a:	83 ec 1c             	sub    $0x1c,%esp
    120d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1210:	eb 2f                	jmp    1241 <gets+0x41>
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1218:	8d 45 e7             	lea    -0x19(%ebp),%eax
    121b:	83 ec 04             	sub    $0x4,%esp
    121e:	6a 01                	push   $0x1
    1220:	50                   	push   %eax
    1221:	6a 00                	push   $0x0
    1223:	e8 32 01 00 00       	call   135a <read>
    if(cc < 1)
    1228:	83 c4 10             	add    $0x10,%esp
    122b:	85 c0                	test   %eax,%eax
    122d:	7e 1c                	jle    124b <gets+0x4b>
      break;
    buf[i++] = c;
    122f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1233:	83 c7 01             	add    $0x1,%edi
    1236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1239:	3c 0a                	cmp    $0xa,%al
    123b:	74 23                	je     1260 <gets+0x60>
    123d:	3c 0d                	cmp    $0xd,%al
    123f:	74 1f                	je     1260 <gets+0x60>
  for(i=0; i+1 < max; ){
    1241:	83 c3 01             	add    $0x1,%ebx
    1244:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1247:	89 fe                	mov    %edi,%esi
    1249:	7c cd                	jl     1218 <gets+0x18>
    124b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1250:	c6 03 00             	movb   $0x0,(%ebx)
}
    1253:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1256:	5b                   	pop    %ebx
    1257:	5e                   	pop    %esi
    1258:	5f                   	pop    %edi
    1259:	5d                   	pop    %ebp
    125a:	c3                   	ret    
    125b:	90                   	nop
    125c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1260:	8b 75 08             	mov    0x8(%ebp),%esi
    1263:	8b 45 08             	mov    0x8(%ebp),%eax
    1266:	01 de                	add    %ebx,%esi
    1268:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    126a:	c6 03 00             	movb   $0x0,(%ebx)
}
    126d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1270:	5b                   	pop    %ebx
    1271:	5e                   	pop    %esi
    1272:	5f                   	pop    %edi
    1273:	5d                   	pop    %ebp
    1274:	c3                   	ret    
    1275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <stat>:

int
stat(const char *n, struct stat *st)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	56                   	push   %esi
    1284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1285:	83 ec 08             	sub    $0x8,%esp
    1288:	6a 00                	push   $0x0
    128a:	ff 75 08             	pushl  0x8(%ebp)
    128d:	e8 f0 00 00 00       	call   1382 <open>
  if(fd < 0)
    1292:	83 c4 10             	add    $0x10,%esp
    1295:	85 c0                	test   %eax,%eax
    1297:	78 27                	js     12c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1299:	83 ec 08             	sub    $0x8,%esp
    129c:	ff 75 0c             	pushl  0xc(%ebp)
    129f:	89 c3                	mov    %eax,%ebx
    12a1:	50                   	push   %eax
    12a2:	e8 f3 00 00 00       	call   139a <fstat>
  close(fd);
    12a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12aa:	89 c6                	mov    %eax,%esi
  close(fd);
    12ac:	e8 b9 00 00 00       	call   136a <close>
  return r;
    12b1:	83 c4 10             	add    $0x10,%esp
}
    12b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12b7:	89 f0                	mov    %esi,%eax
    12b9:	5b                   	pop    %ebx
    12ba:	5e                   	pop    %esi
    12bb:	5d                   	pop    %ebp
    12bc:	c3                   	ret    
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12c5:	eb ed                	jmp    12b4 <stat+0x34>
    12c7:	89 f6                	mov    %esi,%esi
    12c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012d0 <atoi>:

int
atoi(const char *s)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	53                   	push   %ebx
    12d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12d7:	0f be 11             	movsbl (%ecx),%edx
    12da:	8d 42 d0             	lea    -0x30(%edx),%eax
    12dd:	3c 09                	cmp    $0x9,%al
  n = 0;
    12df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    12e4:	77 1f                	ja     1305 <atoi+0x35>
    12e6:	8d 76 00             	lea    0x0(%esi),%esi
    12e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    12f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12f3:	83 c1 01             	add    $0x1,%ecx
    12f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    12fa:	0f be 11             	movsbl (%ecx),%edx
    12fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1300:	80 fb 09             	cmp    $0x9,%bl
    1303:	76 eb                	jbe    12f0 <atoi+0x20>
  return n;
}
    1305:	5b                   	pop    %ebx
    1306:	5d                   	pop    %ebp
    1307:	c3                   	ret    
    1308:	90                   	nop
    1309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	56                   	push   %esi
    1314:	53                   	push   %ebx
    1315:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
    131b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    131e:	85 db                	test   %ebx,%ebx
    1320:	7e 14                	jle    1336 <memmove+0x26>
    1322:	31 d2                	xor    %edx,%edx
    1324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    132c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    132f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1332:	39 d3                	cmp    %edx,%ebx
    1334:	75 f2                	jne    1328 <memmove+0x18>
  return vdst;
}
    1336:	5b                   	pop    %ebx
    1337:	5e                   	pop    %esi
    1338:	5d                   	pop    %ebp
    1339:	c3                   	ret    

0000133a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    133a:	b8 01 00 00 00       	mov    $0x1,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <exit>:
SYSCALL(exit)
    1342:	b8 02 00 00 00       	mov    $0x2,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <wait>:
SYSCALL(wait)
    134a:	b8 03 00 00 00       	mov    $0x3,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <pipe>:
SYSCALL(pipe)
    1352:	b8 04 00 00 00       	mov    $0x4,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <read>:
SYSCALL(read)
    135a:	b8 05 00 00 00       	mov    $0x5,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <write>:
SYSCALL(write)
    1362:	b8 10 00 00 00       	mov    $0x10,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <close>:
SYSCALL(close)
    136a:	b8 15 00 00 00       	mov    $0x15,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <kill>:
SYSCALL(kill)
    1372:	b8 06 00 00 00       	mov    $0x6,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <exec>:
SYSCALL(exec)
    137a:	b8 07 00 00 00       	mov    $0x7,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <open>:
SYSCALL(open)
    1382:	b8 0f 00 00 00       	mov    $0xf,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <mknod>:
SYSCALL(mknod)
    138a:	b8 11 00 00 00       	mov    $0x11,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <unlink>:
SYSCALL(unlink)
    1392:	b8 12 00 00 00       	mov    $0x12,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <fstat>:
SYSCALL(fstat)
    139a:	b8 08 00 00 00       	mov    $0x8,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <link>:
SYSCALL(link)
    13a2:	b8 13 00 00 00       	mov    $0x13,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <mkdir>:
SYSCALL(mkdir)
    13aa:	b8 14 00 00 00       	mov    $0x14,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <chdir>:
SYSCALL(chdir)
    13b2:	b8 09 00 00 00       	mov    $0x9,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <dup>:
SYSCALL(dup)
    13ba:	b8 0a 00 00 00       	mov    $0xa,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <getpid>:
SYSCALL(getpid)
    13c2:	b8 0b 00 00 00       	mov    $0xb,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <sbrk>:
SYSCALL(sbrk)
    13ca:	b8 0c 00 00 00       	mov    $0xc,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <sleep>:
SYSCALL(sleep)
    13d2:	b8 0d 00 00 00       	mov    $0xd,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <uptime>:
SYSCALL(uptime)
    13da:	b8 0e 00 00 00       	mov    $0xe,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    

000013e2 <kthread_create>:
SYSCALL(kthread_create)
    13e2:	b8 16 00 00 00       	mov    $0x16,%eax
    13e7:	cd 40                	int    $0x40
    13e9:	c3                   	ret    

000013ea <kthread_id>:
SYSCALL(kthread_id)
    13ea:	b8 17 00 00 00       	mov    $0x17,%eax
    13ef:	cd 40                	int    $0x40
    13f1:	c3                   	ret    

000013f2 <kthread_exit>:
SYSCALL(kthread_exit)
    13f2:	b8 18 00 00 00       	mov    $0x18,%eax
    13f7:	cd 40                	int    $0x40
    13f9:	c3                   	ret    

000013fa <kthread_join>:
SYSCALL(kthread_join)
    13fa:	b8 19 00 00 00       	mov    $0x19,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    

00001402 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
    1402:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1407:	cd 40                	int    $0x40
    1409:	c3                   	ret    

0000140a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
    140a:	b8 1b 00 00 00       	mov    $0x1b,%eax
    140f:	cd 40                	int    $0x40
    1411:	c3                   	ret    

00001412 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
    1412:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1417:	cd 40                	int    $0x40
    1419:	c3                   	ret    

0000141a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
    141a:	b8 1d 00 00 00       	mov    $0x1d,%eax
    141f:	cd 40                	int    $0x40
    1421:	c3                   	ret    
    1422:	66 90                	xchg   %ax,%ax
    1424:	66 90                	xchg   %ax,%ax
    1426:	66 90                	xchg   %ax,%ax
    1428:	66 90                	xchg   %ax,%ax
    142a:	66 90                	xchg   %ax,%ax
    142c:	66 90                	xchg   %ax,%ax
    142e:	66 90                	xchg   %ax,%ax

00001430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	57                   	push   %edi
    1434:	56                   	push   %esi
    1435:	53                   	push   %ebx
    1436:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1439:	85 d2                	test   %edx,%edx
{
    143b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    143e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1440:	79 76                	jns    14b8 <printint+0x88>
    1442:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1446:	74 70                	je     14b8 <printint+0x88>
    x = -xx;
    1448:	f7 d8                	neg    %eax
    neg = 1;
    144a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1451:	31 f6                	xor    %esi,%esi
    1453:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1456:	eb 0a                	jmp    1462 <printint+0x32>
    1458:	90                   	nop
    1459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1460:	89 fe                	mov    %edi,%esi
    1462:	31 d2                	xor    %edx,%edx
    1464:	8d 7e 01             	lea    0x1(%esi),%edi
    1467:	f7 f1                	div    %ecx
    1469:	0f b6 92 40 21 00 00 	movzbl 0x2140(%edx),%edx
  }while((x /= base) != 0);
    1470:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1472:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1475:	75 e9                	jne    1460 <printint+0x30>
  if(neg)
    1477:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    147a:	85 c0                	test   %eax,%eax
    147c:	74 08                	je     1486 <printint+0x56>
    buf[i++] = '-';
    147e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1483:	8d 7e 02             	lea    0x2(%esi),%edi
    1486:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    148a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    148d:	8d 76 00             	lea    0x0(%esi),%esi
    1490:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1493:	83 ec 04             	sub    $0x4,%esp
    1496:	83 ee 01             	sub    $0x1,%esi
    1499:	6a 01                	push   $0x1
    149b:	53                   	push   %ebx
    149c:	57                   	push   %edi
    149d:	88 45 d7             	mov    %al,-0x29(%ebp)
    14a0:	e8 bd fe ff ff       	call   1362 <write>

  while(--i >= 0)
    14a5:	83 c4 10             	add    $0x10,%esp
    14a8:	39 de                	cmp    %ebx,%esi
    14aa:	75 e4                	jne    1490 <printint+0x60>
    putc(fd, buf[i]);
}
    14ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14af:	5b                   	pop    %ebx
    14b0:	5e                   	pop    %esi
    14b1:	5f                   	pop    %edi
    14b2:	5d                   	pop    %ebp
    14b3:	c3                   	ret    
    14b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    14b8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    14bf:	eb 90                	jmp    1451 <printint+0x21>
    14c1:	eb 0d                	jmp    14d0 <printf>
    14c3:	90                   	nop
    14c4:	90                   	nop
    14c5:	90                   	nop
    14c6:	90                   	nop
    14c7:	90                   	nop
    14c8:	90                   	nop
    14c9:	90                   	nop
    14ca:	90                   	nop
    14cb:	90                   	nop
    14cc:	90                   	nop
    14cd:	90                   	nop
    14ce:	90                   	nop
    14cf:	90                   	nop

000014d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	57                   	push   %edi
    14d4:	56                   	push   %esi
    14d5:	53                   	push   %ebx
    14d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14d9:	8b 75 0c             	mov    0xc(%ebp),%esi
    14dc:	0f b6 1e             	movzbl (%esi),%ebx
    14df:	84 db                	test   %bl,%bl
    14e1:	0f 84 b3 00 00 00    	je     159a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    14e7:	8d 45 10             	lea    0x10(%ebp),%eax
    14ea:	83 c6 01             	add    $0x1,%esi
  state = 0;
    14ed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    14ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14f2:	eb 2f                	jmp    1523 <printf+0x53>
    14f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14f8:	83 f8 25             	cmp    $0x25,%eax
    14fb:	0f 84 a7 00 00 00    	je     15a8 <printf+0xd8>
  write(fd, &c, 1);
    1501:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1504:	83 ec 04             	sub    $0x4,%esp
    1507:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    150a:	6a 01                	push   $0x1
    150c:	50                   	push   %eax
    150d:	ff 75 08             	pushl  0x8(%ebp)
    1510:	e8 4d fe ff ff       	call   1362 <write>
    1515:	83 c4 10             	add    $0x10,%esp
    1518:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    151b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    151f:	84 db                	test   %bl,%bl
    1521:	74 77                	je     159a <printf+0xca>
    if(state == 0){
    1523:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1525:	0f be cb             	movsbl %bl,%ecx
    1528:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    152b:	74 cb                	je     14f8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    152d:	83 ff 25             	cmp    $0x25,%edi
    1530:	75 e6                	jne    1518 <printf+0x48>
      if(c == 'd'){
    1532:	83 f8 64             	cmp    $0x64,%eax
    1535:	0f 84 05 01 00 00    	je     1640 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    153b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1541:	83 f9 70             	cmp    $0x70,%ecx
    1544:	74 72                	je     15b8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1546:	83 f8 73             	cmp    $0x73,%eax
    1549:	0f 84 99 00 00 00    	je     15e8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    154f:	83 f8 63             	cmp    $0x63,%eax
    1552:	0f 84 08 01 00 00    	je     1660 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1558:	83 f8 25             	cmp    $0x25,%eax
    155b:	0f 84 ef 00 00 00    	je     1650 <printf+0x180>
  write(fd, &c, 1);
    1561:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    156b:	6a 01                	push   $0x1
    156d:	50                   	push   %eax
    156e:	ff 75 08             	pushl  0x8(%ebp)
    1571:	e8 ec fd ff ff       	call   1362 <write>
    1576:	83 c4 0c             	add    $0xc,%esp
    1579:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    157c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    157f:	6a 01                	push   $0x1
    1581:	50                   	push   %eax
    1582:	ff 75 08             	pushl  0x8(%ebp)
    1585:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1588:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    158a:	e8 d3 fd ff ff       	call   1362 <write>
  for(i = 0; fmt[i]; i++){
    158f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1593:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1596:	84 db                	test   %bl,%bl
    1598:	75 89                	jne    1523 <printf+0x53>
    }
  }
}
    159a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    159d:	5b                   	pop    %ebx
    159e:	5e                   	pop    %esi
    159f:	5f                   	pop    %edi
    15a0:	5d                   	pop    %ebp
    15a1:	c3                   	ret    
    15a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    15a8:	bf 25 00 00 00       	mov    $0x25,%edi
    15ad:	e9 66 ff ff ff       	jmp    1518 <printf+0x48>
    15b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    15b8:	83 ec 0c             	sub    $0xc,%esp
    15bb:	b9 10 00 00 00       	mov    $0x10,%ecx
    15c0:	6a 00                	push   $0x0
    15c2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    15c5:	8b 45 08             	mov    0x8(%ebp),%eax
    15c8:	8b 17                	mov    (%edi),%edx
    15ca:	e8 61 fe ff ff       	call   1430 <printint>
        ap++;
    15cf:	89 f8                	mov    %edi,%eax
    15d1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15d4:	31 ff                	xor    %edi,%edi
        ap++;
    15d6:	83 c0 04             	add    $0x4,%eax
    15d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15dc:	e9 37 ff ff ff       	jmp    1518 <printf+0x48>
    15e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    15e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15eb:	8b 08                	mov    (%eax),%ecx
        ap++;
    15ed:	83 c0 04             	add    $0x4,%eax
    15f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    15f3:	85 c9                	test   %ecx,%ecx
    15f5:	0f 84 8e 00 00 00    	je     1689 <printf+0x1b9>
        while(*s != 0){
    15fb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    15fe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1600:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1602:	84 c0                	test   %al,%al
    1604:	0f 84 0e ff ff ff    	je     1518 <printf+0x48>
    160a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    160d:	89 de                	mov    %ebx,%esi
    160f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1612:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1615:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1618:	83 ec 04             	sub    $0x4,%esp
          s++;
    161b:	83 c6 01             	add    $0x1,%esi
    161e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1621:	6a 01                	push   $0x1
    1623:	57                   	push   %edi
    1624:	53                   	push   %ebx
    1625:	e8 38 fd ff ff       	call   1362 <write>
        while(*s != 0){
    162a:	0f b6 06             	movzbl (%esi),%eax
    162d:	83 c4 10             	add    $0x10,%esp
    1630:	84 c0                	test   %al,%al
    1632:	75 e4                	jne    1618 <printf+0x148>
    1634:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1637:	31 ff                	xor    %edi,%edi
    1639:	e9 da fe ff ff       	jmp    1518 <printf+0x48>
    163e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1640:	83 ec 0c             	sub    $0xc,%esp
    1643:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1648:	6a 01                	push   $0x1
    164a:	e9 73 ff ff ff       	jmp    15c2 <printf+0xf2>
    164f:	90                   	nop
  write(fd, &c, 1);
    1650:	83 ec 04             	sub    $0x4,%esp
    1653:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1656:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1659:	6a 01                	push   $0x1
    165b:	e9 21 ff ff ff       	jmp    1581 <printf+0xb1>
        putc(fd, *ap);
    1660:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1663:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1666:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1668:	6a 01                	push   $0x1
        ap++;
    166a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    166d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1670:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1673:	50                   	push   %eax
    1674:	ff 75 08             	pushl  0x8(%ebp)
    1677:	e8 e6 fc ff ff       	call   1362 <write>
        ap++;
    167c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    167f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1682:	31 ff                	xor    %edi,%edi
    1684:	e9 8f fe ff ff       	jmp    1518 <printf+0x48>
          s = "(null)";
    1689:	bb 38 21 00 00       	mov    $0x2138,%ebx
        while(*s != 0){
    168e:	b8 28 00 00 00       	mov    $0x28,%eax
    1693:	e9 72 ff ff ff       	jmp    160a <printf+0x13a>
    1698:	66 90                	xchg   %ax,%ax
    169a:	66 90                	xchg   %ax,%ax
    169c:	66 90                	xchg   %ax,%ax
    169e:	66 90                	xchg   %ax,%ax

000016a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a1:	a1 30 28 00 00       	mov    0x2830,%eax
{
    16a6:	89 e5                	mov    %esp,%ebp
    16a8:	57                   	push   %edi
    16a9:	56                   	push   %esi
    16aa:	53                   	push   %ebx
    16ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    16ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    16b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b8:	39 c8                	cmp    %ecx,%eax
    16ba:	8b 10                	mov    (%eax),%edx
    16bc:	73 32                	jae    16f0 <free+0x50>
    16be:	39 d1                	cmp    %edx,%ecx
    16c0:	72 04                	jb     16c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16c2:	39 d0                	cmp    %edx,%eax
    16c4:	72 32                	jb     16f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16cc:	39 fa                	cmp    %edi,%edx
    16ce:	74 30                	je     1700 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16d3:	8b 50 04             	mov    0x4(%eax),%edx
    16d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16d9:	39 f1                	cmp    %esi,%ecx
    16db:	74 3a                	je     1717 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16dd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    16df:	a3 30 28 00 00       	mov    %eax,0x2830
}
    16e4:	5b                   	pop    %ebx
    16e5:	5e                   	pop    %esi
    16e6:	5f                   	pop    %edi
    16e7:	5d                   	pop    %ebp
    16e8:	c3                   	ret    
    16e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16f0:	39 d0                	cmp    %edx,%eax
    16f2:	72 04                	jb     16f8 <free+0x58>
    16f4:	39 d1                	cmp    %edx,%ecx
    16f6:	72 ce                	jb     16c6 <free+0x26>
{
    16f8:	89 d0                	mov    %edx,%eax
    16fa:	eb bc                	jmp    16b8 <free+0x18>
    16fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1700:	03 72 04             	add    0x4(%edx),%esi
    1703:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1706:	8b 10                	mov    (%eax),%edx
    1708:	8b 12                	mov    (%edx),%edx
    170a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    170d:	8b 50 04             	mov    0x4(%eax),%edx
    1710:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1713:	39 f1                	cmp    %esi,%ecx
    1715:	75 c6                	jne    16dd <free+0x3d>
    p->s.size += bp->s.size;
    1717:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    171a:	a3 30 28 00 00       	mov    %eax,0x2830
    p->s.size += bp->s.size;
    171f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1722:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1725:	89 10                	mov    %edx,(%eax)
}
    1727:	5b                   	pop    %ebx
    1728:	5e                   	pop    %esi
    1729:	5f                   	pop    %edi
    172a:	5d                   	pop    %ebp
    172b:	c3                   	ret    
    172c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1730:	55                   	push   %ebp
    1731:	89 e5                	mov    %esp,%ebp
    1733:	57                   	push   %edi
    1734:	56                   	push   %esi
    1735:	53                   	push   %ebx
    1736:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    173c:	8b 15 30 28 00 00    	mov    0x2830,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1742:	8d 78 07             	lea    0x7(%eax),%edi
    1745:	c1 ef 03             	shr    $0x3,%edi
    1748:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    174b:	85 d2                	test   %edx,%edx
    174d:	0f 84 9d 00 00 00    	je     17f0 <malloc+0xc0>
    1753:	8b 02                	mov    (%edx),%eax
    1755:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1758:	39 cf                	cmp    %ecx,%edi
    175a:	76 6c                	jbe    17c8 <malloc+0x98>
    175c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1762:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1767:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    176a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1771:	eb 0e                	jmp    1781 <malloc+0x51>
    1773:	90                   	nop
    1774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1778:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    177a:	8b 48 04             	mov    0x4(%eax),%ecx
    177d:	39 f9                	cmp    %edi,%ecx
    177f:	73 47                	jae    17c8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1781:	39 05 30 28 00 00    	cmp    %eax,0x2830
    1787:	89 c2                	mov    %eax,%edx
    1789:	75 ed                	jne    1778 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    178b:	83 ec 0c             	sub    $0xc,%esp
    178e:	56                   	push   %esi
    178f:	e8 36 fc ff ff       	call   13ca <sbrk>
  if(p == (char*)-1)
    1794:	83 c4 10             	add    $0x10,%esp
    1797:	83 f8 ff             	cmp    $0xffffffff,%eax
    179a:	74 1c                	je     17b8 <malloc+0x88>
  hp->s.size = nu;
    179c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    179f:	83 ec 0c             	sub    $0xc,%esp
    17a2:	83 c0 08             	add    $0x8,%eax
    17a5:	50                   	push   %eax
    17a6:	e8 f5 fe ff ff       	call   16a0 <free>
  return freep;
    17ab:	8b 15 30 28 00 00    	mov    0x2830,%edx
      if((p = morecore(nunits)) == 0)
    17b1:	83 c4 10             	add    $0x10,%esp
    17b4:	85 d2                	test   %edx,%edx
    17b6:	75 c0                	jne    1778 <malloc+0x48>
        return 0;
  }
}
    17b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    17bb:	31 c0                	xor    %eax,%eax
}
    17bd:	5b                   	pop    %ebx
    17be:	5e                   	pop    %esi
    17bf:	5f                   	pop    %edi
    17c0:	5d                   	pop    %ebp
    17c1:	c3                   	ret    
    17c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    17c8:	39 cf                	cmp    %ecx,%edi
    17ca:	74 54                	je     1820 <malloc+0xf0>
        p->s.size -= nunits;
    17cc:	29 f9                	sub    %edi,%ecx
    17ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    17d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    17d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    17d7:	89 15 30 28 00 00    	mov    %edx,0x2830
}
    17dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17e0:	83 c0 08             	add    $0x8,%eax
}
    17e3:	5b                   	pop    %ebx
    17e4:	5e                   	pop    %esi
    17e5:	5f                   	pop    %edi
    17e6:	5d                   	pop    %ebp
    17e7:	c3                   	ret    
    17e8:	90                   	nop
    17e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    17f0:	c7 05 30 28 00 00 34 	movl   $0x2834,0x2830
    17f7:	28 00 00 
    17fa:	c7 05 34 28 00 00 34 	movl   $0x2834,0x2834
    1801:	28 00 00 
    base.s.size = 0;
    1804:	b8 34 28 00 00       	mov    $0x2834,%eax
    1809:	c7 05 38 28 00 00 00 	movl   $0x0,0x2838
    1810:	00 00 00 
    1813:	e9 44 ff ff ff       	jmp    175c <malloc+0x2c>
    1818:	90                   	nop
    1819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1820:	8b 08                	mov    (%eax),%ecx
    1822:	89 0a                	mov    %ecx,(%edx)
    1824:	eb b1                	jmp    17d7 <malloc+0xa7>
    1826:	66 90                	xchg   %ax,%ax
    1828:	66 90                	xchg   %ax,%ax
    182a:	66 90                	xchg   %ax,%ax
    182c:	66 90                	xchg   %ax,%ax
    182e:	66 90                	xchg   %ax,%ax

00001830 <create_tree>:
}

int index = 0;
int curLevel = -2;

void create_tree(struct tree_node* node, int depth){
    1830:	55                   	push   %ebp
    1831:	89 e5                	mov    %esp,%ebp
    1833:	57                   	push   %edi
    1834:	56                   	push   %esi
    1835:	53                   	push   %ebx
    1836:	83 ec 1c             	sub    $0x1c,%esp
    1839:	8b 75 0c             	mov    0xc(%ebp),%esi
    183c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
    183f:	85 f6                	test   %esi,%esi
    1841:	0f 84 8a 00 00 00    	je     18d1 <create_tree+0xa1>
    1847:	8d 04 b5 fc ff ff ff 	lea    -0x4(,%esi,4),%eax
    184e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1851:	8d 4e fe             	lea    -0x2(%esi),%ecx
    1854:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1857:	03 15 54 28 00 00    	add    0x2854,%edx
        return;
    }
    if(curLevel != depth-2){
    185d:	39 0d 28 28 00 00    	cmp    %ecx,0x2828
    1863:	a1 3c 28 00 00       	mov    0x283c,%eax
    1868:	74 08                	je     1872 <create_tree+0x42>
        index = level_index[depth-1];
    186a:	8b 02                	mov    (%edx),%eax
        curLevel = depth-2;
    186c:	89 0d 28 28 00 00    	mov    %ecx,0x2828
    }
    node->level = curLevel;
    node->index = index;
    1872:	89 43 10             	mov    %eax,0x10(%ebx)
    index++;
    1875:	83 c0 01             	add    $0x1,%eax
    level_index[depth-1] = index;
    if(depth == 1){
    1878:	83 fe 01             	cmp    $0x1,%esi
    node->level = curLevel;
    187b:	89 4b 14             	mov    %ecx,0x14(%ebx)
    index++;
    187e:	a3 3c 28 00 00       	mov    %eax,0x283c
    level_index[depth-1] = index;
    1883:	89 02                	mov    %eax,(%edx)
    if(depth == 1){
    1885:	74 59                	je     18e0 <create_tree+0xb0>
        node->left_child = 0;
        node->right_child = 0;
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    }else{
        struct tree_node *left = malloc(sizeof(struct tree_node));
    1887:	83 ec 0c             	sub    $0xc,%esp
        left->parent = node;
        right->parent = node;
        node->left_child = left;
        node->right_child = right;
        node->mutex_id = kthread_mutex_alloc();
        create_tree(left, depth-1);
    188a:	83 ee 01             	sub    $0x1,%esi
        struct tree_node *left = malloc(sizeof(struct tree_node));
    188d:	6a 1c                	push   $0x1c
    188f:	e8 9c fe ff ff       	call   1730 <malloc>
    1894:	89 c7                	mov    %eax,%edi
        struct tree_node *right = malloc(sizeof(struct tree_node));
    1896:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    189d:	e8 8e fe ff ff       	call   1730 <malloc>
        left->parent = node;
    18a2:	89 5f 08             	mov    %ebx,0x8(%edi)
        right->parent = node;
    18a5:	89 58 08             	mov    %ebx,0x8(%eax)
        node->left_child = left;
    18a8:	89 3b                	mov    %edi,(%ebx)
        node->right_child = right;
    18aa:	89 43 04             	mov    %eax,0x4(%ebx)
    18ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
        node->mutex_id = kthread_mutex_alloc();
    18b0:	e8 4d fb ff ff       	call   1402 <kthread_mutex_alloc>
    18b5:	89 43 0c             	mov    %eax,0xc(%ebx)
        create_tree(left, depth-1);
    18b8:	58                   	pop    %eax
    18b9:	5a                   	pop    %edx
    18ba:	56                   	push   %esi
    18bb:	57                   	push   %edi
    18bc:	e8 6f ff ff ff       	call   1830 <create_tree>
    18c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    18c4:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
    if(depth == 0){
    18c8:	83 c4 10             	add    $0x10,%esp
    18cb:	85 f6                	test   %esi,%esi
    18cd:	89 d3                	mov    %edx,%ebx
    18cf:	75 80                	jne    1851 <create_tree+0x21>
        create_tree(right, depth-1);
    }
    return;
}
    18d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18d4:	5b                   	pop    %ebx
    18d5:	5e                   	pop    %esi
    18d6:	5f                   	pop    %edi
    18d7:	5d                   	pop    %ebp
    18d8:	c3                   	ret    
    18d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        node->left_child = 0;
    18e0:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    18e6:	a1 40 28 00 00       	mov    0x2840,%eax
    18eb:	83 ec 0c             	sub    $0xc,%esp
        node->right_child = 0;
    18ee:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    18f5:	c1 e0 02             	shl    $0x2,%eax
    18f8:	50                   	push   %eax
    18f9:	e8 32 fe ff ff       	call   1730 <malloc>
    18fe:	83 c4 10             	add    $0x10,%esp
    1901:	89 43 18             	mov    %eax,0x18(%ebx)
}
    1904:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1907:	5b                   	pop    %ebx
    1908:	5e                   	pop    %esi
    1909:	5f                   	pop    %edi
    190a:	5d                   	pop    %ebp
    190b:	c3                   	ret    
    190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001910 <trnmnt_tree_alloc>:
trnmnt_tree* trnmnt_tree_alloc(int depth){
    1910:	55                   	push   %ebp
    1911:	89 e5                	mov    %esp,%ebp
    1913:	56                   	push   %esi
    1914:	53                   	push   %ebx
    1915:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth < 1) // illegal depth
    1918:	85 db                	test   %ebx,%ebx
    191a:	7e 74                	jle    1990 <trnmnt_tree_alloc+0x80>
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
    191c:	83 ec 0c             	sub    $0xc,%esp
    191f:	6a 08                	push   $0x8
    1921:	e8 0a fe ff ff       	call   1730 <malloc>
    struct tree_node *root = malloc(sizeof(struct tree_node));
    1926:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
    192d:	89 c6                	mov    %eax,%esi
    struct tree_node *root = malloc(sizeof(struct tree_node));
    192f:	e8 fc fd ff ff       	call   1730 <malloc>
    int arr[depth+1];
    1934:	8d 53 01             	lea    0x1(%ebx),%edx
    treeDepth = depth;
    1937:	89 1d 40 28 00 00    	mov    %ebx,0x2840
    tree->depth = depth;
    193d:	89 5e 04             	mov    %ebx,0x4(%esi)
    tree->root = root;
    1940:	89 06                	mov    %eax,(%esi)
    root->parent = 0;
    1942:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    int arr[depth+1];
    1949:	83 c4 10             	add    $0x10,%esp
    194c:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
    1953:	83 e0 f0             	and    $0xfffffff0,%eax
    1956:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < depth+1; i++)
    1958:	31 c0                	xor    %eax,%eax
    int arr[depth+1];
    195a:	89 e1                	mov    %esp,%ecx
    195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        arr[i] = 0;
    1960:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    for(int i = 0; i < depth+1; i++)
    1967:	83 c0 01             	add    $0x1,%eax
    196a:	39 c2                	cmp    %eax,%edx
    196c:	75 f2                	jne    1960 <trnmnt_tree_alloc+0x50>
    create_tree(tree->root, depth+1);
    196e:	83 ec 08             	sub    $0x8,%esp
    level_index = arr;
    1971:	89 0d 54 28 00 00    	mov    %ecx,0x2854
    create_tree(tree->root, depth+1);
    1977:	52                   	push   %edx
    1978:	ff 36                	pushl  (%esi)
    197a:	e8 b1 fe ff ff       	call   1830 <create_tree>
    return tree;
    197f:	83 c4 10             	add    $0x10,%esp
}
    1982:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1985:	89 f0                	mov    %esi,%eax
    1987:	5b                   	pop    %ebx
    1988:	5e                   	pop    %esi
    1989:	5d                   	pop    %ebp
    198a:	c3                   	ret    
    198b:	90                   	nop
    198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1990:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return 0;
    1993:	31 f6                	xor    %esi,%esi
}
    1995:	89 f0                	mov    %esi,%eax
    1997:	5b                   	pop    %ebx
    1998:	5e                   	pop    %esi
    1999:	5d                   	pop    %ebp
    199a:	c3                   	ret    
    199b:	90                   	nop
    199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000019a0 <print_node>:

void print_node(struct tree_node *n,int l){
    19a0:	55                   	push   %ebp
    19a1:	89 e5                	mov    %esp,%ebp
    19a3:	57                   	push   %edi
    19a4:	56                   	push   %esi
    19a5:	53                   	push   %ebx
    19a6:	83 ec 1c             	sub    $0x1c,%esp
    19a9:	8b 75 08             	mov    0x8(%ebp),%esi
    19ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
    19af:	85 f6                	test   %esi,%esi
    19b1:	74 5a                	je     1a0d <print_node+0x6d>
    int i;
	print_node(n->right_child,l+1);
    19b3:	8d 43 01             	lea    0x1(%ebx),%eax
    19b6:	83 ec 08             	sub    $0x8,%esp
    19b9:	50                   	push   %eax
    19ba:	ff 76 04             	pushl  0x4(%esi)
    19bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    19c0:	e8 db ff ff ff       	call   19a0 <print_node>
	for(i=0;i<l;++i){
    19c5:	83 c4 10             	add    $0x10,%esp
    19c8:	85 db                	test   %ebx,%ebx
    19ca:	7e 1d                	jle    19e9 <print_node+0x49>
    19cc:	31 ff                	xor    %edi,%edi
    19ce:	66 90                	xchg   %ax,%ax
		printf(1,"    ");
    19d0:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
    19d3:	83 c7 01             	add    $0x1,%edi
		printf(1,"    ");
    19d6:	68 51 21 00 00       	push   $0x2151
    19db:	6a 01                	push   $0x1
    19dd:	e8 ee fa ff ff       	call   14d0 <printf>
	for(i=0;i<l;++i){
    19e2:	83 c4 10             	add    $0x10,%esp
    19e5:	39 df                	cmp    %ebx,%edi
    19e7:	75 e7                	jne    19d0 <print_node+0x30>
    }
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
    19e9:	83 ec 0c             	sub    $0xc,%esp
    19ec:	ff 76 0c             	pushl  0xc(%esi)
    19ef:	ff 76 10             	pushl  0x10(%esi)
    19f2:	ff 76 14             	pushl  0x14(%esi)
    19f5:	68 56 21 00 00       	push   $0x2156
    19fa:	6a 01                	push   $0x1
    19fc:	e8 cf fa ff ff       	call   14d0 <printf>
	print_node(n->left_child,l+1);
    1a01:	8b 36                	mov    (%esi),%esi
	if(!n) return;
    1a03:	83 c4 20             	add    $0x20,%esp
	print_node(n->left_child,l+1);
    1a06:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
    1a09:	85 f6                	test   %esi,%esi
    1a0b:	75 a6                	jne    19b3 <print_node+0x13>
}
    1a0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a10:	5b                   	pop    %ebx
    1a11:	5e                   	pop    %esi
    1a12:	5f                   	pop    %edi
    1a13:	5d                   	pop    %ebp
    1a14:	c3                   	ret    
    1a15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001a20 <print_tree>:

void print_tree(trnmnt_tree *t){
    1a20:	55                   	push   %ebp
    1a21:	89 e5                	mov    %esp,%ebp
    1a23:	83 ec 08             	sub    $0x8,%esp
    1a26:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
    1a29:	85 c0                	test   %eax,%eax
    1a2b:	74 0f                	je     1a3c <print_tree+0x1c>
	print_node(t->root,0);
    1a2d:	83 ec 08             	sub    $0x8,%esp
    1a30:	6a 00                	push   $0x0
    1a32:	ff 30                	pushl  (%eax)
    1a34:	e8 67 ff ff ff       	call   19a0 <print_node>
    1a39:	83 c4 10             	add    $0x10,%esp
}
    1a3c:	c9                   	leave  
    1a3d:	c3                   	ret    
    1a3e:	66 90                	xchg   %ax,%ax

00001a40 <delete_node>:

int delete_node(struct tree_node *node){
    1a40:	55                   	push   %ebp
            node->lockPath = 0;
        }
        // then delete the node
        free(node); 
    }
    return 0;
    1a41:	31 c0                	xor    %eax,%eax
int delete_node(struct tree_node *node){
    1a43:	89 e5                	mov    %esp,%ebp
    1a45:	53                   	push   %ebx
    1a46:	83 ec 04             	sub    $0x4,%esp
    1a49:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (node != 0){ 
    1a4c:	85 db                	test   %ebx,%ebx
    1a4e:	74 5e                	je     1aae <delete_node+0x6e>
        if(kthread_mutex_dealloc(node->mutex_id) == -1){
    1a50:	83 ec 0c             	sub    $0xc,%esp
    1a53:	ff 73 0c             	pushl  0xc(%ebx)
    1a56:	e8 af f9 ff ff       	call   140a <kthread_mutex_dealloc>
    1a5b:	83 c4 10             	add    $0x10,%esp
    1a5e:	83 f8 ff             	cmp    $0xffffffff,%eax
    1a61:	74 4b                	je     1aae <delete_node+0x6e>
        delete_node(node->left_child); 
    1a63:	83 ec 0c             	sub    $0xc,%esp
    1a66:	ff 33                	pushl  (%ebx)
    1a68:	e8 d3 ff ff ff       	call   1a40 <delete_node>
        delete_node(node->right_child); 
    1a6d:	58                   	pop    %eax
    1a6e:	ff 73 04             	pushl  0x4(%ebx)
    1a71:	e8 ca ff ff ff       	call   1a40 <delete_node>
        if(node->lockPath){
    1a76:	8b 43 18             	mov    0x18(%ebx),%eax
    1a79:	83 c4 10             	add    $0x10,%esp
        node->left_child = 0;
    1a7c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
    1a82:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        if(node->lockPath){
    1a89:	85 c0                	test   %eax,%eax
    1a8b:	74 13                	je     1aa0 <delete_node+0x60>
            free(node->lockPath);
    1a8d:	83 ec 0c             	sub    $0xc,%esp
    1a90:	50                   	push   %eax
    1a91:	e8 0a fc ff ff       	call   16a0 <free>
            node->lockPath = 0;
    1a96:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
    1a9d:	83 c4 10             	add    $0x10,%esp
        free(node); 
    1aa0:	83 ec 0c             	sub    $0xc,%esp
    1aa3:	53                   	push   %ebx
    1aa4:	e8 f7 fb ff ff       	call   16a0 <free>
    1aa9:	83 c4 10             	add    $0x10,%esp
    1aac:	31 c0                	xor    %eax,%eax
}
    1aae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ab1:	c9                   	leave  
    1ab2:	c3                   	ret    
    1ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001ac0 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(trnmnt_tree* tree){
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	56                   	push   %esi
    1ac4:	53                   	push   %ebx
    1ac5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
    1ac8:	83 ec 0c             	sub    $0xc,%esp
    1acb:	ff 33                	pushl  (%ebx)
    1acd:	e8 6e ff ff ff       	call   1a40 <delete_node>
    1ad2:	83 c4 10             	add    $0x10,%esp
    1ad5:	85 c0                	test   %eax,%eax
    1ad7:	75 27                	jne    1b00 <trnmnt_tree_dealloc+0x40>
        tree->root = 0;
        free(tree);
    1ad9:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
    1adc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    1ae2:	89 c6                	mov    %eax,%esi
        free(tree);
    1ae4:	53                   	push   %ebx
    1ae5:	e8 b6 fb ff ff       	call   16a0 <free>
        tree = 0;
        return 0;
    1aea:	83 c4 10             	add    $0x10,%esp
    }else{
        return -1;
    }
}
    1aed:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1af0:	89 f0                	mov    %esi,%eax
    1af2:	5b                   	pop    %ebx
    1af3:	5e                   	pop    %esi
    1af4:	5d                   	pop    %ebp
    1af5:	c3                   	ret    
    1af6:	8d 76 00             	lea    0x0(%esi),%esi
    1af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
    1b00:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1b05:	eb e6                	jmp    1aed <trnmnt_tree_dealloc+0x2d>
    1b07:	89 f6                	mov    %esi,%esi
    1b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b10 <find_leaf>:
        leaf->lockPath[i] = 0;
    }
    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
    1b10:	55                   	push   %ebp
    1b11:	89 e5                	mov    %esp,%ebp
    1b13:	57                   	push   %edi
    1b14:	56                   	push   %esi
    1b15:	53                   	push   %ebx
    1b16:	83 ec 0c             	sub    $0xc,%esp
    1b19:	8b 55 08             	mov    0x8(%ebp),%edx
    1b1c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if(node->right_child == 0 && node->left_child == 0){ 
    1b1f:	8b 72 04             	mov    0x4(%edx),%esi
    1b22:	8b 02                	mov    (%edx),%eax
    1b24:	85 f6                	test   %esi,%esi
    1b26:	75 18                	jne    1b40 <find_leaf+0x30>
    1b28:	85 c0                	test   %eax,%eax
    1b2a:	75 14                	jne    1b40 <find_leaf+0x30>
        if(ID == node->index){
    1b2c:	39 5a 10             	cmp    %ebx,0x10(%edx)
    1b2f:	0f 44 c2             	cmove  %edx,%eax
        if(leaf1)
            return leaf1;
        else
            return leaf2;
    }
} 
    1b32:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b35:	5b                   	pop    %ebx
    1b36:	5e                   	pop    %esi
    1b37:	5f                   	pop    %edi
    1b38:	5d                   	pop    %ebp
    1b39:	c3                   	ret    
    1b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
    1b40:	83 ec 08             	sub    $0x8,%esp
    1b43:	53                   	push   %ebx
    1b44:	50                   	push   %eax
    1b45:	e8 c6 ff ff ff       	call   1b10 <find_leaf>
    1b4a:	5a                   	pop    %edx
    1b4b:	59                   	pop    %ecx
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
    1b4c:	53                   	push   %ebx
    1b4d:	56                   	push   %esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
    1b4e:	89 c7                	mov    %eax,%edi
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
    1b50:	e8 bb ff ff ff       	call   1b10 <find_leaf>
    1b55:	83 c4 10             	add    $0x10,%esp
        if(leaf1)
    1b58:	85 ff                	test   %edi,%edi
    1b5a:	0f 45 c7             	cmovne %edi,%eax
} 
    1b5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b60:	5b                   	pop    %ebx
    1b61:	5e                   	pop    %esi
    1b62:	5f                   	pop    %edi
    1b63:	5d                   	pop    %ebp
    1b64:	c3                   	ret    
    1b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b70 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
    1b70:	55                   	push   %ebp
    1b71:	89 e5                	mov    %esp,%ebp
    1b73:	57                   	push   %edi
    1b74:	56                   	push   %esi
    1b75:	53                   	push   %ebx
    1b76:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
    1b79:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7c:	ff 75 0c             	pushl  0xc(%ebp)
    1b7f:	ff 30                	pushl  (%eax)
    1b81:	e8 8a ff ff ff       	call   1b10 <find_leaf>
    1b86:	8b 50 08             	mov    0x8(%eax),%edx
    1b89:	83 c4 10             	add    $0x10,%esp
    1b8c:	89 c7                	mov    %eax,%edi
    while(curNode->parent){
    1b8e:	89 c3                	mov    %eax,%ebx
    1b90:	85 d2                	test   %edx,%edx
    1b92:	74 32                	je     1bc6 <trnmnt_tree_acquire+0x56>
        int level = curNode->parent->level;
    1b94:	8b 72 14             	mov    0x14(%edx),%esi
        int mutex_lock = kthread_mutex_lock(mutexID);
    1b97:	83 ec 0c             	sub    $0xc,%esp
    1b9a:	ff 72 0c             	pushl  0xc(%edx)
    1b9d:	e8 70 f8 ff ff       	call   1412 <kthread_mutex_lock>
        leaf->lockPath[level] = curNode->parent->mutex_id;
    1ba2:	8b 53 08             	mov    0x8(%ebx),%edx
        if(mutex_lock == -1){
    1ba5:	83 c4 10             	add    $0x10,%esp
    1ba8:	83 f8 ff             	cmp    $0xffffffff,%eax
        leaf->lockPath[level] = curNode->parent->mutex_id;
    1bab:	8b 4a 0c             	mov    0xc(%edx),%ecx
    1bae:	8b 57 18             	mov    0x18(%edi),%edx
    1bb1:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
        if(mutex_lock == -1){
    1bb4:	74 12                	je     1bc8 <trnmnt_tree_acquire+0x58>
        if(mutex_lock == 0){
    1bb6:	85 c0                	test   %eax,%eax
    1bb8:	8b 53 08             	mov    0x8(%ebx),%edx
    1bbb:	75 d3                	jne    1b90 <trnmnt_tree_acquire+0x20>
    1bbd:	89 d3                	mov    %edx,%ebx
    1bbf:	8b 52 08             	mov    0x8(%edx),%edx
    while(curNode->parent){
    1bc2:	85 d2                	test   %edx,%edx
    1bc4:	75 ce                	jne    1b94 <trnmnt_tree_acquire+0x24>
    return 0;
    1bc6:	31 c0                	xor    %eax,%eax
}
    1bc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bcb:	5b                   	pop    %ebx
    1bcc:	5e                   	pop    %esi
    1bcd:	5f                   	pop    %edi
    1bce:	5d                   	pop    %ebp
    1bcf:	c3                   	ret    

00001bd0 <trnmnt_tree_release>:
int trnmnt_tree_release(trnmnt_tree* tree,int ID){
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	57                   	push   %edi
    1bd4:	56                   	push   %esi
    1bd5:	53                   	push   %ebx
    1bd6:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
    1bd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdc:	ff 75 0c             	pushl  0xc(%ebp)
    1bdf:	ff 30                	pushl  (%eax)
    1be1:	e8 2a ff ff ff       	call   1b10 <find_leaf>
    for(int i = treeDepth-1; i >= 0; i--){
    1be6:	8b 35 40 28 00 00    	mov    0x2840,%esi
    struct tree_node* leaf = find_leaf(tree->root, ID);
    1bec:	83 c4 10             	add    $0x10,%esp
    for(int i = treeDepth-1; i >= 0; i--){
    1bef:	83 ee 01             	sub    $0x1,%esi
    1bf2:	78 44                	js     1c38 <trnmnt_tree_release+0x68>
    1bf4:	89 c7                	mov    %eax,%edi
    1bf6:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
    1bfd:	eb 16                	jmp    1c15 <trnmnt_tree_release+0x45>
    1bff:	90                   	nop
        leaf->lockPath[i] = 0;
    1c00:	8b 47 18             	mov    0x18(%edi),%eax
    for(int i = treeDepth-1; i >= 0; i--){
    1c03:	83 ee 01             	sub    $0x1,%esi
        leaf->lockPath[i] = 0;
    1c06:	c7 04 18 00 00 00 00 	movl   $0x0,(%eax,%ebx,1)
    1c0d:	83 eb 04             	sub    $0x4,%ebx
    for(int i = treeDepth-1; i >= 0; i--){
    1c10:	83 fe ff             	cmp    $0xffffffff,%esi
    1c13:	74 23                	je     1c38 <trnmnt_tree_release+0x68>
        int res = kthread_mutex_unlock(leaf->lockPath[i]);
    1c15:	8b 47 18             	mov    0x18(%edi),%eax
    1c18:	83 ec 0c             	sub    $0xc,%esp
    1c1b:	ff 34 18             	pushl  (%eax,%ebx,1)
    1c1e:	e8 f7 f7 ff ff       	call   141a <kthread_mutex_unlock>
        if(res == -1){
    1c23:	83 c4 10             	add    $0x10,%esp
    1c26:	83 f8 ff             	cmp    $0xffffffff,%eax
    1c29:	75 d5                	jne    1c00 <trnmnt_tree_release+0x30>
}
    1c2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c2e:	5b                   	pop    %ebx
    1c2f:	5e                   	pop    %esi
    1c30:	5f                   	pop    %edi
    1c31:	5d                   	pop    %ebp
    1c32:	c3                   	ret    
    1c33:	90                   	nop
    1c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1c38:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
    1c3b:	31 c0                	xor    %eax,%eax
}
    1c3d:	5b                   	pop    %ebx
    1c3e:	5e                   	pop    %esi
    1c3f:	5f                   	pop    %edi
    1c40:	5d                   	pop    %ebp
    1c41:	c3                   	ret    
