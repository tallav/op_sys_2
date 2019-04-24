
_myprog2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }

  printf(1, "%s test PASS!\n", __FUNCTION__);
}

int main(){
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 10             	sub    $0x10,%esp
  senaty(64);
      11:	6a 40                	push   $0x40
      13:	e8 48 08 00 00       	call   860 <senaty>
  stressTest1(15);
      18:	c7 04 24 0f 00 00 00 	movl   $0xf,(%esp)
      1f:	e8 7c 02 00 00       	call   2a0 <stressTest1>
  stressTest2Fail(15);
      24:	c7 04 24 0f 00 00 00 	movl   $0xf,(%esp)
      2b:	e8 c0 04 00 00       	call   4f0 <stressTest2Fail>
 // stressTest3toMuchTreads(14); //this test must be the last

  exit();
      30:	e8 3d 0e 00 00       	call   e72 <exit>
      35:	66 90                	xchg   %ax,%ax
      37:	66 90                	xchg   %ax,%ax
      39:	66 90                	xchg   %ax,%ax
      3b:	66 90                	xchg   %ax,%ax
      3d:	66 90                	xchg   %ax,%ax
      3f:	90                   	nop

00000040 <loopThread>:
void* loopThread(){
      40:	55                   	push   %ebp
      41:	89 e5                	mov    %esp,%ebp
      43:	eb fe                	jmp    43 <loopThread+0x3>
      45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000050 <safeThread>:
void* safeThread(){
      50:	55                   	push   %ebp
      51:	89 e5                	mov    %esp,%ebp
      53:	53                   	push   %ebx
      54:	83 ec 10             	sub    $0x10,%esp
  ASSERT((kthread_mutex_lock(mutex1) == -1), "kthread_mutex_lock(%d) fail", mutex1);
      57:	ff 35 90 1b 00 00    	pushl  0x1b90
      5d:	e8 e0 0e 00 00       	call   f42 <kthread_mutex_lock>
      62:	83 c4 10             	add    $0x10,%esp
      65:	83 f8 ff             	cmp    $0xffffffff,%eax
      68:	0f 84 e2 00 00 00    	je     150 <safeThread+0x100>
  resource1[0] = kthread_id();
      6e:	e8 a7 0e 00 00       	call   f1a <kthread_id>
  for(i = 1 ;i < 20; i++){
      73:	bb 01 00 00 00       	mov    $0x1,%ebx
  resource1[0] = kthread_id();
      78:	a3 40 1b 00 00       	mov    %eax,0x1b40
      7d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(i % 2);   // make some more troubles
      80:	89 d8                	mov    %ebx,%eax
      82:	83 ec 0c             	sub    $0xc,%esp
      85:	83 e0 01             	and    $0x1,%eax
      88:	50                   	push   %eax
      89:	e8 74 0e 00 00       	call   f02 <sleep>
    resource1[i] = resource1[i-1];
      8e:	8b 04 9d 3c 1b 00 00 	mov    0x1b3c(,%ebx,4),%eax
  for(i = 1 ;i < 20; i++){
      95:	83 c4 10             	add    $0x10,%esp
    resource1[i] = resource1[i-1];
      98:	89 04 9d 40 1b 00 00 	mov    %eax,0x1b40(,%ebx,4)
  for(i = 1 ;i < 20; i++){
      9f:	83 c3 01             	add    $0x1,%ebx
      a2:	83 fb 14             	cmp    $0x14,%ebx
      a5:	75 d9                	jne    80 <safeThread+0x30>
  sleep(kthread_id() % 2);   // make some more troubles
      a7:	e8 6e 0e 00 00       	call   f1a <kthread_id>
      ac:	89 c2                	mov    %eax,%edx
      ae:	83 ec 0c             	sub    $0xc,%esp
      b1:	c1 ea 1f             	shr    $0x1f,%edx
      b4:	01 d0                	add    %edx,%eax
      b6:	83 e0 01             	and    $0x1,%eax
      b9:	29 d0                	sub    %edx,%eax
      bb:	50                   	push   %eax
      bc:	e8 41 0e 00 00       	call   f02 <sleep>
  ASSERT((resource1[i-1] != kthread_id()), "(resource1[%d] != kthread_id:%d) fail", i, kthread_id());
      c1:	8b 1d 8c 1b 00 00    	mov    0x1b8c,%ebx
      c7:	e8 4e 0e 00 00       	call   f1a <kthread_id>
      cc:	83 c4 10             	add    $0x10,%esp
      cf:	39 c3                	cmp    %eax,%ebx
      d1:	0f 85 18 01 00 00    	jne    1ef <safeThread+0x19f>
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
      d7:	83 ec 0c             	sub    $0xc,%esp
      da:	ff 35 90 1b 00 00    	pushl  0x1b90
      e0:	e8 65 0e 00 00       	call   f4a <kthread_mutex_unlock>
      e5:	83 c4 10             	add    $0x10,%esp
      e8:	83 f8 ff             	cmp    $0xffffffff,%eax
      eb:	0f 84 e0 00 00 00    	je     1d1 <safeThread+0x181>
  ASSERT((kthread_mutex_lock(mutex2) == -1), "kthread_mutex_lock(%d) fail", mutex2);
      f1:	83 ec 0c             	sub    $0xc,%esp
      f4:	ff 35 20 1b 00 00    	pushl  0x1b20
      fa:	e8 43 0e 00 00       	call   f42 <kthread_mutex_lock>
      ff:	83 c4 10             	add    $0x10,%esp
     102:	83 f8 ff             	cmp    $0xffffffff,%eax
     105:	0f 84 a3 00 00 00    	je     1ae <safeThread+0x15e>
  sleep(kthread_id() % 2);   // make some more troubles
     10b:	e8 0a 0e 00 00       	call   f1a <kthread_id>
     110:	89 c2                	mov    %eax,%edx
     112:	83 ec 0c             	sub    $0xc,%esp
     115:	c1 ea 1f             	shr    $0x1f,%edx
     118:	01 d0                	add    %edx,%eax
     11a:	83 e0 01             	and    $0x1,%eax
     11d:	29 d0                	sub    %edx,%eax
     11f:	50                   	push   %eax
     120:	e8 dd 0d 00 00       	call   f02 <sleep>
  resource2 = resource2 + kthread_id();
     125:	e8 f0 0d 00 00       	call   f1a <kthread_id>
     12a:	01 05 24 1b 00 00    	add    %eax,0x1b24
  ASSERT((kthread_mutex_unlock(mutex2) == -1), "kthread_mutex_unlock(%d) fail", mutex2);
     130:	58                   	pop    %eax
     131:	ff 35 20 1b 00 00    	pushl  0x1b20
     137:	e8 0e 0e 00 00       	call   f4a <kthread_mutex_unlock>
     13c:	83 c4 10             	add    $0x10,%esp
     13f:	83 f8 ff             	cmp    $0xffffffff,%eax
     142:	74 47                	je     18b <safeThread+0x13b>
  kthread_exit();
     144:	e8 d9 0d 00 00       	call   f22 <kthread_exit>
}
     149:	31 c0                	xor    %eax,%eax
     14b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     14e:	c9                   	leave  
     14f:	c3                   	ret    
  ASSERT((kthread_mutex_lock(mutex1) == -1), "kthread_mutex_lock(%d) fail", mutex1);
     150:	6a 24                	push   $0x24
     152:	68 04 17 00 00       	push   $0x1704
     157:	68 58 13 00 00       	push   $0x1358
     15c:	6a 02                	push   $0x2
     15e:	e8 9d 0e 00 00       	call   1000 <printf>
     163:	83 c4 0c             	add    $0xc,%esp
     166:	ff 35 90 1b 00 00    	pushl  0x1b90
     16c:	68 69 13 00 00       	push   $0x1369
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
     171:	6a 02                	push   $0x2
     173:	e8 88 0e 00 00       	call   1000 <printf>
     178:	5a                   	pop    %edx
     179:	59                   	pop    %ecx
     17a:	68 3c 14 00 00       	push   $0x143c
     17f:	6a 02                	push   $0x2
     181:	e8 7a 0e 00 00       	call   1000 <printf>
     186:	e8 e7 0c 00 00       	call   e72 <exit>
  ASSERT((kthread_mutex_unlock(mutex2) == -1), "kthread_mutex_unlock(%d) fail", mutex2);
     18b:	6a 34                	push   $0x34
     18d:	68 04 17 00 00       	push   $0x1704
     192:	68 58 13 00 00       	push   $0x1358
     197:	6a 02                	push   $0x2
     199:	e8 62 0e 00 00       	call   1000 <printf>
     19e:	83 c4 0c             	add    $0xc,%esp
     1a1:	ff 35 20 1b 00 00    	pushl  0x1b20
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
     1a7:	68 85 13 00 00       	push   $0x1385
     1ac:	eb c3                	jmp    171 <safeThread+0x121>
  ASSERT((kthread_mutex_lock(mutex2) == -1), "kthread_mutex_lock(%d) fail", mutex2);
     1ae:	6a 31                	push   $0x31
     1b0:	68 04 17 00 00       	push   $0x1704
     1b5:	68 58 13 00 00       	push   $0x1358
     1ba:	6a 02                	push   $0x2
     1bc:	e8 3f 0e 00 00       	call   1000 <printf>
     1c1:	83 c4 0c             	add    $0xc,%esp
     1c4:	ff 35 20 1b 00 00    	pushl  0x1b20
     1ca:	68 69 13 00 00       	push   $0x1369
     1cf:	eb a0                	jmp    171 <safeThread+0x121>
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
     1d1:	6a 2e                	push   $0x2e
     1d3:	68 04 17 00 00       	push   $0x1704
     1d8:	68 58 13 00 00       	push   $0x1358
     1dd:	6a 02                	push   $0x2
     1df:	e8 1c 0e 00 00       	call   1000 <printf>
     1e4:	83 c4 0c             	add    $0xc,%esp
     1e7:	ff 35 90 1b 00 00    	pushl  0x1b90
     1ed:	eb b8                	jmp    1a7 <safeThread+0x157>
  ASSERT((resource1[i-1] != kthread_id()), "(resource1[%d] != kthread_id:%d) fail", i, kthread_id());
     1ef:	6a 2c                	push   $0x2c
     1f1:	68 04 17 00 00       	push   $0x1704
     1f6:	68 58 13 00 00       	push   $0x1358
     1fb:	6a 02                	push   $0x2
     1fd:	e8 fe 0d 00 00       	call   1000 <printf>
     202:	e8 13 0d 00 00       	call   f1a <kthread_id>
     207:	50                   	push   %eax
     208:	6a 14                	push   $0x14
     20a:	68 40 14 00 00       	push   $0x1440
     20f:	6a 02                	push   $0x2
     211:	e8 ea 0d 00 00       	call   1000 <printf>
     216:	83 c4 18             	add    $0x18,%esp
     219:	68 3c 14 00 00       	push   $0x143c
     21e:	6a 02                	push   $0x2
     220:	e8 db 0d 00 00       	call   1000 <printf>
     225:	e8 48 0c 00 00       	call   e72 <exit>
     22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000230 <unsafeThread>:
void* unsafeThread(){
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	53                   	push   %ebx
  for(i = 1 ;i < 20; i++){
     234:	bb 01 00 00 00       	mov    $0x1,%ebx
void* unsafeThread(){
     239:	83 ec 04             	sub    $0x4,%esp
  resource1[0] = kthread_id();
     23c:	e8 d9 0c 00 00       	call   f1a <kthread_id>
     241:	a3 40 1b 00 00       	mov    %eax,0x1b40
     246:	8d 76 00             	lea    0x0(%esi),%esi
     249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    sleep(i % 2);   // make some more troubles
     250:	89 d8                	mov    %ebx,%eax
     252:	83 ec 0c             	sub    $0xc,%esp
     255:	83 e0 01             	and    $0x1,%eax
     258:	50                   	push   %eax
     259:	e8 a4 0c 00 00       	call   f02 <sleep>
    resource1[i] = resource1[i-1];
     25e:	8b 04 9d 3c 1b 00 00 	mov    0x1b3c(,%ebx,4),%eax
  for(i = 1 ;i < 20; i++){
     265:	83 c4 10             	add    $0x10,%esp
    resource1[i] = resource1[i-1];
     268:	89 04 9d 40 1b 00 00 	mov    %eax,0x1b40(,%ebx,4)
  for(i = 1 ;i < 20; i++){
     26f:	83 c3 01             	add    $0x1,%ebx
     272:	83 fb 14             	cmp    $0x14,%ebx
     275:	75 d9                	jne    250 <unsafeThread+0x20>
  sleep(kthread_id());   // make some more troubles
     277:	e8 9e 0c 00 00       	call   f1a <kthread_id>
     27c:	83 ec 0c             	sub    $0xc,%esp
     27f:	50                   	push   %eax
     280:	e8 7d 0c 00 00       	call   f02 <sleep>
  resource2 = resource2 + resource1[i-1];
     285:	a1 8c 1b 00 00       	mov    0x1b8c,%eax
     28a:	01 05 24 1b 00 00    	add    %eax,0x1b24
  kthread_exit();
     290:	e8 8d 0c 00 00       	call   f22 <kthread_exit>
}
     295:	31 c0                	xor    %eax,%eax
     297:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     29a:	c9                   	leave  
     29b:	c3                   	ret    
     29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <stressTest1>:
void stressTest1(int count){
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	57                   	push   %edi
     2a4:	56                   	push   %esi
     2a5:	53                   	push   %ebx
     2a6:	83 ec 1c             	sub    $0x1c,%esp
     2a9:	8b 7d 08             	mov    0x8(%ebp),%edi
  int tid[count];
     2ac:	8d 04 bd 12 00 00 00 	lea    0x12(,%edi,4),%eax
     2b3:	83 e0 f0             	and    $0xfffffff0,%eax
     2b6:	29 c4                	sub    %eax,%esp
     2b8:	89 e6                	mov    %esp,%esi
  printf(1, "starting %s test\n", __FUNCTION__);
     2ba:	83 ec 04             	sub    $0x4,%esp
     2bd:	68 f8 16 00 00       	push   $0x16f8
     2c2:	68 a3 13 00 00       	push   $0x13a3
     2c7:	6a 01                	push   $0x1
     2c9:	e8 32 0d 00 00       	call   1000 <printf>
     2ce:	b8 40 1b 00 00       	mov    $0x1b40,%eax
     2d3:	83 c4 10             	add    $0x10,%esp
     2d6:	8d 76 00             	lea    0x0(%esi),%esi
     2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    resource1[i] = 0;
     2e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
     2e6:	83 c0 04             	add    $0x4,%eax
  for (i = 0 ; i < 20; i++)
     2e9:	3d 90 1b 00 00       	cmp    $0x1b90,%eax
     2ee:	75 f0                	jne    2e0 <stressTest1+0x40>
  resource2 = 0;
     2f0:	c7 05 24 1b 00 00 00 	movl   $0x0,0x1b24
     2f7:	00 00 00 
  mutex1 = kthread_mutex_alloc();
     2fa:	e8 33 0c 00 00       	call   f32 <kthread_mutex_alloc>
     2ff:	a3 90 1b 00 00       	mov    %eax,0x1b90
  mutex2 = kthread_mutex_alloc();
     304:	e8 29 0c 00 00       	call   f32 <kthread_mutex_alloc>
  ASSERT((mutex1 == mutex2), "(mutex1 == mutex2)");
     309:	8b 15 90 1b 00 00    	mov    0x1b90,%edx
  mutex2 = kthread_mutex_alloc();
     30f:	a3 20 1b 00 00       	mov    %eax,0x1b20
  ASSERT((mutex1 == mutex2), "(mutex1 == mutex2)");
     314:	39 d0                	cmp    %edx,%eax
     316:	0f 84 b2 01 00 00    	je     4ce <stressTest1+0x22e>
  for (i = 0 ; i < count; i++){
     31c:	31 db                	xor    %ebx,%ebx
     31e:	85 ff                	test   %edi,%edi
  int c=0;
     320:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for (i = 0 ; i < count; i++){
     327:	7e 7e                	jle    3a7 <stressTest1+0x107>
     329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    stack = malloc(STACK_SIZE);
     330:	83 ec 0c             	sub    $0xc,%esp
     333:	68 e8 03 00 00       	push   $0x3e8
     338:	e8 23 0f 00 00       	call   1260 <malloc>
    tid[i] = kthread_create((void*) safeThread, stack);
     33d:	5a                   	pop    %edx
     33e:	59                   	pop    %ecx
     33f:	50                   	push   %eax
     340:	68 50 00 00 00       	push   $0x50
     345:	e8 c8 0b 00 00       	call   f12 <kthread_create>
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     34a:	83 c4 10             	add    $0x10,%esp
     34d:	85 c0                	test   %eax,%eax
    tid[i] = kthread_create((void*) safeThread, stack);
     34f:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     352:	0f 8e bb 00 00 00    	jle    413 <stressTest1+0x173>
    c += tid[i];
     358:	01 45 e0             	add    %eax,-0x20(%ebp)
    sleep(i % 2);   // make some more troubles
     35b:	89 d8                	mov    %ebx,%eax
     35d:	83 ec 0c             	sub    $0xc,%esp
     360:	83 e0 01             	and    $0x1,%eax
  for (i = 0 ; i < count; i++){
     363:	83 c3 01             	add    $0x1,%ebx
    sleep(i % 2);   // make some more troubles
     366:	50                   	push   %eax
     367:	e8 96 0b 00 00       	call   f02 <sleep>
  for (i = 0 ; i < count; i++){
     36c:	83 c4 10             	add    $0x10,%esp
     36f:	39 df                	cmp    %ebx,%edi
     371:	75 bd                	jne    330 <stressTest1+0x90>
  for (i = 0 ; i < count; i++){
     373:	31 d2                	xor    %edx,%edx
     375:	8d 76 00             	lea    0x0(%esi),%esi
    ans = kthread_join(tid[i]);
     378:	8b 3c 96             	mov    (%esi,%edx,4),%edi
     37b:	83 ec 0c             	sub    $0xc,%esp
     37e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     381:	57                   	push   %edi
     382:	e8 a3 0b 00 00       	call   f2a <kthread_join>
    ASSERT((ans != 0), "kthread_join(%d) return with: %d", tid[i], ans)
     387:	83 c4 10             	add    $0x10,%esp
     38a:	85 c0                	test   %eax,%eax
     38c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     38f:	0f 85 b9 00 00 00    	jne    44e <stressTest1+0x1ae>
  for (i = 0 ; i < count; i++){
     395:	83 c2 01             	add    $0x1,%edx
     398:	39 da                	cmp    %ebx,%edx
     39a:	75 dc                	jne    378 <stressTest1+0xd8>
     39c:	a1 20 1b 00 00       	mov    0x1b20,%eax
     3a1:	8b 15 90 1b 00 00    	mov    0x1b90,%edx
    printf(1, "free mutexes with id: %d, %d\n", mutex1, mutex2);  
     3a7:	50                   	push   %eax
     3a8:	52                   	push   %edx
     3a9:	68 c8 13 00 00       	push   $0x13c8
     3ae:	6a 01                	push   $0x1
     3b0:	e8 4b 0c 00 00       	call   1000 <printf>
  ASSERT( (kthread_mutex_dealloc(mutex1) != 0), "dealloc");
     3b5:	5e                   	pop    %esi
     3b6:	ff 35 90 1b 00 00    	pushl  0x1b90
     3bc:	e8 79 0b 00 00       	call   f3a <kthread_mutex_dealloc>
     3c1:	83 c4 10             	add    $0x10,%esp
     3c4:	85 c0                	test   %eax,%eax
     3c6:	0f 85 a4 00 00 00    	jne    470 <stressTest1+0x1d0>
  ASSERT( (kthread_mutex_dealloc(mutex2) != 0), "dealloc");
     3cc:	83 ec 0c             	sub    $0xc,%esp
     3cf:	ff 35 20 1b 00 00    	pushl  0x1b20
     3d5:	e8 60 0b 00 00       	call   f3a <kthread_mutex_dealloc>
     3da:	83 c4 10             	add    $0x10,%esp
     3dd:	85 c0                	test   %eax,%eax
     3df:	0f 85 bf 00 00 00    	jne    4a4 <stressTest1+0x204>
  ASSERT((c != resource2), "(c != resource2) : (%d != %d)" , c, resource2);
     3e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     3e8:	39 05 24 1b 00 00    	cmp    %eax,0x1b24
     3ee:	0f 85 b4 00 00 00    	jne    4a8 <stressTest1+0x208>
  printf(1, "%s test PASS!\n", __FUNCTION__);
     3f4:	83 ec 04             	sub    $0x4,%esp
     3f7:	68 f8 16 00 00       	push   $0x16f8
     3fc:	68 0c 14 00 00       	push   $0x140c
     401:	6a 01                	push   $0x1
     403:	e8 f8 0b 00 00       	call   1000 <printf>
}
     408:	83 c4 10             	add    $0x10,%esp
     40b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     40e:	5b                   	pop    %ebx
     40f:	5e                   	pop    %esi
     410:	5f                   	pop    %edi
     411:	5d                   	pop    %ebp
     412:	c3                   	ret    
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     413:	6a 64                	push   $0x64
     415:	68 f8 16 00 00       	push   $0x16f8
     41a:	68 58 13 00 00       	push   $0x1358
     41f:	6a 02                	push   $0x2
     421:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     424:	e8 d7 0b 00 00       	call   1000 <printf>
     429:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     42c:	53                   	push   %ebx
     42d:	50                   	push   %eax
     42e:	68 68 14 00 00       	push   $0x1468
  ASSERT((c != resource2), "(c != resource2) : (%d != %d)" , c, resource2);
     433:	6a 02                	push   $0x2
     435:	e8 c6 0b 00 00       	call   1000 <printf>
     43a:	83 c4 18             	add    $0x18,%esp
     43d:	68 3c 14 00 00       	push   $0x143c
     442:	6a 02                	push   $0x2
     444:	e8 b7 0b 00 00       	call   1000 <printf>
     449:	e8 24 0a 00 00       	call   e72 <exit>
    ASSERT((ans != 0), "kthread_join(%d) return with: %d", tid[i], ans)
     44e:	6a 6c                	push   $0x6c
     450:	68 f8 16 00 00       	push   $0x16f8
     455:	68 58 13 00 00       	push   $0x1358
     45a:	6a 02                	push   $0x2
     45c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     45f:	e8 9c 0b 00 00       	call   1000 <printf>
     464:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     467:	50                   	push   %eax
     468:	57                   	push   %edi
     469:	68 98 14 00 00       	push   $0x1498
     46e:	eb c3                	jmp    433 <stressTest1+0x193>
  ASSERT( (kthread_mutex_dealloc(mutex1) != 0), "dealloc");
     470:	6a 71                	push   $0x71
     472:	68 f8 16 00 00       	push   $0x16f8
     477:	68 58 13 00 00       	push   $0x1358
     47c:	6a 02                	push   $0x2
     47e:	e8 7d 0b 00 00       	call   1000 <printf>
     483:	59                   	pop    %ecx
     484:	5b                   	pop    %ebx
     485:	68 e6 13 00 00       	push   $0x13e6
     48a:	6a 02                	push   $0x2
     48c:	e8 6f 0b 00 00       	call   1000 <printf>
     491:	58                   	pop    %eax
     492:	5a                   	pop    %edx
     493:	68 3c 14 00 00       	push   $0x143c
     498:	6a 02                	push   $0x2
     49a:	e8 61 0b 00 00       	call   1000 <printf>
     49f:	e8 ce 09 00 00       	call   e72 <exit>
  ASSERT( (kthread_mutex_dealloc(mutex2) != 0), "dealloc");
     4a4:	6a 72                	push   $0x72
     4a6:	eb ca                	jmp    472 <stressTest1+0x1d2>
  ASSERT((c != resource2), "(c != resource2) : (%d != %d)" , c, resource2);
     4a8:	6a 74                	push   $0x74
     4aa:	68 f8 16 00 00       	push   $0x16f8
     4af:	68 58 13 00 00       	push   $0x1358
     4b4:	6a 02                	push   $0x2
     4b6:	e8 45 0b 00 00       	call   1000 <printf>
     4bb:	ff 35 24 1b 00 00    	pushl  0x1b24
     4c1:	ff 75 e0             	pushl  -0x20(%ebp)
     4c4:	68 ee 13 00 00       	push   $0x13ee
     4c9:	e9 65 ff ff ff       	jmp    433 <stressTest1+0x193>
  ASSERT((mutex1 == mutex2), "(mutex1 == mutex2)");
     4ce:	6a 5f                	push   $0x5f
     4d0:	68 f8 16 00 00       	push   $0x16f8
     4d5:	68 58 13 00 00       	push   $0x1358
     4da:	6a 02                	push   $0x2
     4dc:	e8 1f 0b 00 00       	call   1000 <printf>
     4e1:	5b                   	pop    %ebx
     4e2:	5e                   	pop    %esi
     4e3:	68 b5 13 00 00       	push   $0x13b5
     4e8:	eb a0                	jmp    48a <stressTest1+0x1ea>
     4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004f0 <stressTest2Fail>:
void stressTest2Fail(int count){
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	57                   	push   %edi
     4f4:	56                   	push   %esi
     4f5:	53                   	push   %ebx
     4f6:	83 ec 1c             	sub    $0x1c,%esp
  int tid[count];
     4f9:	8b 45 08             	mov    0x8(%ebp),%eax
     4fc:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     503:	83 e0 f0             	and    $0xfffffff0,%eax
     506:	29 c4                	sub    %eax,%esp
     508:	89 e6                	mov    %esp,%esi
  printf(1, "starting %s test\n", __FUNCTION__);
     50a:	83 ec 04             	sub    $0x4,%esp
     50d:	68 e8 16 00 00       	push   $0x16e8
     512:	68 a3 13 00 00       	push   $0x13a3
     517:	6a 01                	push   $0x1
     519:	e8 e2 0a 00 00       	call   1000 <printf>
     51e:	b8 40 1b 00 00       	mov    $0x1b40,%eax
     523:	83 c4 10             	add    $0x10,%esp
     526:	8d 76 00             	lea    0x0(%esi),%esi
     529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    resource1[i] = 0;
     530:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
     536:	83 c0 04             	add    $0x4,%eax
  for (i = 0 ; i < 20; i++)
     539:	3d 90 1b 00 00       	cmp    $0x1b90,%eax
     53e:	75 f0                	jne    530 <stressTest2Fail+0x40>
  for (i = 0 ; i < count; i++){
     540:	8b 7d 08             	mov    0x8(%ebp),%edi
     543:	31 db                	xor    %ebx,%ebx
  resource2 = 0;
     545:	c7 05 24 1b 00 00 00 	movl   $0x0,0x1b24
     54c:	00 00 00 
  for (i = 0 ; i < count; i++){
     54f:	85 ff                	test   %edi,%edi
     551:	0f 8e 0b 01 00 00    	jle    662 <stressTest2Fail+0x172>
  int c=0;
     557:	31 ff                	xor    %edi,%edi
    sleep(i %3);   // make some more troubles
     559:	89 75 e4             	mov    %esi,-0x1c(%ebp)
     55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    stack = malloc(STACK_SIZE);
     560:	83 ec 0c             	sub    $0xc,%esp
     563:	68 e8 03 00 00       	push   $0x3e8
     568:	e8 f3 0c 00 00       	call   1260 <malloc>
    tid[i] = kthread_create((void*)unsafeThread, stack);
     56d:	5a                   	pop    %edx
     56e:	59                   	pop    %ecx
     56f:	50                   	push   %eax
     570:	68 30 02 00 00       	push   $0x230
     575:	e8 98 09 00 00       	call   f12 <kthread_create>
     57a:	89 c6                	mov    %eax,%esi
     57c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    sleep(i %3);   // make some more troubles
     57f:	89 d9                	mov    %ebx,%ecx
    tid[i] = kthread_create((void*)unsafeThread, stack);
     581:	89 34 98             	mov    %esi,(%eax,%ebx,4)
    sleep(i %3);   // make some more troubles
     584:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
     589:	f7 e3                	mul    %ebx
     58b:	d1 ea                	shr    %edx
     58d:	8d 04 52             	lea    (%edx,%edx,2),%eax
     590:	29 c1                	sub    %eax,%ecx
     592:	89 0c 24             	mov    %ecx,(%esp)
     595:	e8 68 09 00 00       	call   f02 <sleep>
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     59a:	83 c4 10             	add    $0x10,%esp
     59d:	85 f6                	test   %esi,%esi
     59f:	7e 64                	jle    605 <stressTest2Fail+0x115>
    c += tid[i];
     5a1:	01 f7                	add    %esi,%edi
  for (i = 0 ; i < count; i++){
     5a3:	83 c3 01             	add    $0x1,%ebx
     5a6:	39 5d 08             	cmp    %ebx,0x8(%ebp)
     5a9:	75 b5                	jne    560 <stressTest2Fail+0x70>
  for (i = 0 ; i < count; i++){
     5ab:	31 d2                	xor    %edx,%edx
     5ad:	89 7d e0             	mov    %edi,-0x20(%ebp)
     5b0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
     5b3:	89 d7                	mov    %edx,%edi
     5b5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
     5b8:	90                   	nop
     5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ans = kthread_join(tid[i]);
     5c0:	8b 1c be             	mov    (%esi,%edi,4),%ebx
     5c3:	83 ec 0c             	sub    $0xc,%esp
     5c6:	53                   	push   %ebx
     5c7:	e8 5e 09 00 00       	call   f2a <kthread_join>
    ASSERT((ans != 0), "kthread_join(%d) return with: %d", tid[i], ans)
     5cc:	83 c4 10             	add    $0x10,%esp
     5cf:	85 c0                	test   %eax,%eax
     5d1:	75 6a                	jne    63d <stressTest2Fail+0x14d>
  for (i = 0 ; i < count; i++){
     5d3:	83 c7 01             	add    $0x1,%edi
     5d6:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
     5d9:	75 e5                	jne    5c0 <stressTest2Fail+0xd0>
     5db:	8b 1d 24 1b 00 00    	mov    0x1b24,%ebx
  ASSERT((c == resource2), "(c == resource2) : (%d != %d), we expect to fail here!!" , c, resource2);
     5e1:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
     5e4:	74 7c                	je     662 <stressTest2Fail+0x172>
  printf(1, "%s test PASS!\n", __FUNCTION__);
     5e6:	83 ec 04             	sub    $0x4,%esp
     5e9:	68 e8 16 00 00       	push   $0x16e8
     5ee:	68 0c 14 00 00       	push   $0x140c
     5f3:	6a 01                	push   $0x1
     5f5:	e8 06 0a 00 00       	call   1000 <printf>
}
     5fa:	83 c4 10             	add    $0x10,%esp
     5fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     600:	5b                   	pop    %ebx
     601:	5e                   	pop    %esi
     602:	5f                   	pop    %edi
     603:	5d                   	pop    %ebp
     604:	c3                   	ret    
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     605:	68 8b 00 00 00       	push   $0x8b
     60a:	68 e8 16 00 00       	push   $0x16e8
     60f:	68 58 13 00 00       	push   $0x1358
     614:	6a 02                	push   $0x2
     616:	e8 e5 09 00 00       	call   1000 <printf>
     61b:	53                   	push   %ebx
     61c:	56                   	push   %esi
     61d:	68 68 14 00 00       	push   $0x1468
    ASSERT((ans != 0), "kthread_join(%d) return with: %d", tid[i], ans)
     622:	6a 02                	push   $0x2
     624:	e8 d7 09 00 00       	call   1000 <printf>
     629:	83 c4 18             	add    $0x18,%esp
     62c:	68 3c 14 00 00       	push   $0x143c
     631:	6a 02                	push   $0x2
     633:	e8 c8 09 00 00       	call   1000 <printf>
     638:	e8 35 08 00 00       	call   e72 <exit>
     63d:	68 92 00 00 00       	push   $0x92
     642:	68 e8 16 00 00       	push   $0x16e8
     647:	68 58 13 00 00       	push   $0x1358
     64c:	6a 02                	push   $0x2
     64e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     651:	e8 aa 09 00 00       	call   1000 <printf>
     656:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     659:	50                   	push   %eax
     65a:	53                   	push   %ebx
     65b:	68 98 14 00 00       	push   $0x1498
     660:	eb c0                	jmp    622 <stressTest2Fail+0x132>
  ASSERT((c == resource2), "(c == resource2) : (%d != %d), we expect to fail here!!" , c, resource2);
     662:	68 95 00 00 00       	push   $0x95
     667:	68 e8 16 00 00       	push   $0x16e8
     66c:	68 58 13 00 00       	push   $0x1358
     671:	6a 02                	push   $0x2
     673:	e8 88 09 00 00       	call   1000 <printf>
     678:	ff 35 24 1b 00 00    	pushl  0x1b24
     67e:	53                   	push   %ebx
     67f:	68 bc 14 00 00       	push   $0x14bc
     684:	eb 9c                	jmp    622 <stressTest2Fail+0x132>
     686:	8d 76 00             	lea    0x0(%esi),%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <stressTest3toMuchTreads>:
void stressTest3toMuchTreads(int count){
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
     696:	83 ec 1c             	sub    $0x1c,%esp
  int tid[count*2];
     699:	8b 45 08             	mov    0x8(%ebp),%eax
     69c:	8d 04 c5 12 00 00 00 	lea    0x12(,%eax,8),%eax
     6a3:	83 e0 f0             	and    $0xfffffff0,%eax
     6a6:	29 c4                	sub    %eax,%esp
     6a8:	89 65 e4             	mov    %esp,-0x1c(%ebp)
  printf(1, "starting %s test\n", __FUNCTION__);
     6ab:	83 ec 04             	sub    $0x4,%esp
     6ae:	68 d0 16 00 00       	push   $0x16d0
     6b3:	68 a3 13 00 00       	push   $0x13a3
     6b8:	6a 01                	push   $0x1
     6ba:	e8 41 09 00 00       	call   1000 <printf>
  for (i = 0 ; i < count; i++){
     6bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
     6c2:	83 c4 10             	add    $0x10,%esp
     6c5:	85 c9                	test   %ecx,%ecx
     6c7:	0f 8e 97 00 00 00    	jle    764 <stressTest3toMuchTreads+0xd4>
     6cd:	31 db                	xor    %ebx,%ebx
     6cf:	eb 26                	jmp    6f7 <stressTest3toMuchTreads+0x67>
     6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s test PASS!\n", __FUNCTION__);
     6d8:	83 ec 04             	sub    $0x4,%esp
  for (i = 0 ; i < count; i++){
     6db:	83 c3 01             	add    $0x1,%ebx
    printf(1, "%s test PASS!\n", __FUNCTION__);
     6de:	68 d0 16 00 00       	push   $0x16d0
     6e3:	68 0c 14 00 00       	push   $0x140c
     6e8:	6a 01                	push   $0x1
     6ea:	e8 11 09 00 00       	call   1000 <printf>
     6ef:	83 c4 10             	add    $0x10,%esp
  for (i = 0 ; i < count; i++){
     6f2:	39 5d 08             	cmp    %ebx,0x8(%ebp)
     6f5:	74 6d                	je     764 <stressTest3toMuchTreads+0xd4>
    stack = malloc(STACK_SIZE);
     6f7:	83 ec 0c             	sub    $0xc,%esp
     6fa:	68 e8 03 00 00       	push   $0x3e8
     6ff:	e8 5c 0b 00 00       	call   1260 <malloc>
     704:	89 c7                	mov    %eax,%edi
    tid[i] = kthread_create((void*)loopThread, stack);
     706:	58                   	pop    %eax
     707:	5a                   	pop    %edx
     708:	57                   	push   %edi
     709:	68 40 00 00 00       	push   $0x40
     70e:	e8 ff 07 00 00       	call   f12 <kthread_create>
     713:	89 c6                	mov    %eax,%esi
     715:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     718:	89 34 98             	mov    %esi,(%eax,%ebx,4)
    printf(1,"i: %d thread id %d\n",i, tid[i]);
     71b:	56                   	push   %esi
     71c:	53                   	push   %ebx
     71d:	68 1b 14 00 00       	push   $0x141b
     722:	6a 01                	push   $0x1
     724:	e8 d7 08 00 00       	call   1000 <printf>
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     729:	83 c4 20             	add    $0x20,%esp
     72c:	85 f6                	test   %esi,%esi
     72e:	7e 39                	jle    769 <stressTest3toMuchTreads+0xd9>
  if(kthread_create((void*)loopThread, stack) <= 0)
     730:	83 ec 08             	sub    $0x8,%esp
     733:	57                   	push   %edi
     734:	68 40 00 00 00       	push   $0x40
     739:	e8 d4 07 00 00       	call   f12 <kthread_create>
     73e:	83 c4 10             	add    $0x10,%esp
     741:	85 c0                	test   %eax,%eax
     743:	7f 93                	jg     6d8 <stressTest3toMuchTreads+0x48>
    printf(1, "%s test FAIL!\n", __FUNCTION__);
     745:	83 ec 04             	sub    $0x4,%esp
  for (i = 0 ; i < count; i++){
     748:	83 c3 01             	add    $0x1,%ebx
    printf(1, "%s test FAIL!\n", __FUNCTION__);
     74b:	68 d0 16 00 00       	push   $0x16d0
     750:	68 2f 14 00 00       	push   $0x142f
     755:	6a 01                	push   $0x1
     757:	e8 a4 08 00 00       	call   1000 <printf>
     75c:	83 c4 10             	add    $0x10,%esp
  for (i = 0 ; i < count; i++){
     75f:	39 5d 08             	cmp    %ebx,0x8(%ebp)
     762:	75 93                	jne    6f7 <stressTest3toMuchTreads+0x67>
  exit();
     764:	e8 09 07 00 00       	call   e72 <exit>
    ASSERT((tid[i] <= 0), "kthread_create return with: %d, for index:%d", tid[i], i);
     769:	68 a7 00 00 00       	push   $0xa7
     76e:	68 d0 16 00 00       	push   $0x16d0
     773:	68 58 13 00 00       	push   $0x1358
     778:	6a 02                	push   $0x2
     77a:	e8 81 08 00 00       	call   1000 <printf>
     77f:	53                   	push   %ebx
     780:	56                   	push   %esi
     781:	68 68 14 00 00       	push   $0x1468
     786:	6a 02                	push   $0x2
     788:	e8 73 08 00 00       	call   1000 <printf>
     78d:	83 c4 18             	add    $0x18,%esp
     790:	68 3c 14 00 00       	push   $0x143c
     795:	6a 02                	push   $0x2
     797:	e8 64 08 00 00       	call   1000 <printf>
     79c:	e8 d1 06 00 00       	call   e72 <exit>
     7a1:	eb 0d                	jmp    7b0 <trubleThread>
     7a3:	90                   	nop
     7a4:	90                   	nop
     7a5:	90                   	nop
     7a6:	90                   	nop
     7a7:	90                   	nop
     7a8:	90                   	nop
     7a9:	90                   	nop
     7aa:	90                   	nop
     7ab:	90                   	nop
     7ac:	90                   	nop
     7ad:	90                   	nop
     7ae:	90                   	nop
     7af:	90                   	nop

000007b0 <trubleThread>:
void* trubleThread(){
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	83 ec 14             	sub    $0x14,%esp
  ASSERT((kthread_mutex_lock(mutex1) == -1), "kthread_mutex_lock(%d) fail", mutex1);
     7b6:	ff 35 90 1b 00 00    	pushl  0x1b90
     7bc:	e8 81 07 00 00       	call   f42 <kthread_mutex_lock>
     7c1:	83 c4 10             	add    $0x10,%esp
     7c4:	83 f8 ff             	cmp    $0xffffffff,%eax
     7c7:	74 29                	je     7f2 <trubleThread+0x42>
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
     7c9:	83 ec 0c             	sub    $0xc,%esp
     7cc:	ff 35 90 1b 00 00    	pushl  0x1b90
  resource2 = -10;
     7d2:	c7 05 24 1b 00 00 f6 	movl   $0xfffffff6,0x1b24
     7d9:	ff ff ff 
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
     7dc:	e8 69 07 00 00       	call   f4a <kthread_mutex_unlock>
     7e1:	83 c4 10             	add    $0x10,%esp
     7e4:	83 f8 ff             	cmp    $0xffffffff,%eax
     7e7:	74 47                	je     830 <trubleThread+0x80>
  kthread_exit();
     7e9:	e8 34 07 00 00       	call   f22 <kthread_exit>
}
     7ee:	31 c0                	xor    %eax,%eax
     7f0:	c9                   	leave  
     7f1:	c3                   	ret    
  ASSERT((kthread_mutex_lock(mutex1) == -1), "kthread_mutex_lock(%d) fail", mutex1);
     7f2:	68 bc 00 00 00       	push   $0xbc
     7f7:	68 c0 16 00 00       	push   $0x16c0
     7fc:	68 58 13 00 00       	push   $0x1358
     801:	6a 02                	push   $0x2
     803:	e8 f8 07 00 00       	call   1000 <printf>
     808:	83 c4 0c             	add    $0xc,%esp
     80b:	ff 35 90 1b 00 00    	pushl  0x1b90
     811:	68 69 13 00 00       	push   $0x1369
  ASSERT((kthread_mutex_unlock(mutex1) == -1), "kthread_mutex_unlock(%d) fail", mutex1);
     816:	6a 02                	push   $0x2
     818:	e8 e3 07 00 00       	call   1000 <printf>
     81d:	58                   	pop    %eax
     81e:	5a                   	pop    %edx
     81f:	68 3c 14 00 00       	push   $0x143c
     824:	6a 02                	push   $0x2
     826:	e8 d5 07 00 00       	call   1000 <printf>
     82b:	e8 42 06 00 00       	call   e72 <exit>
     830:	68 bf 00 00 00       	push   $0xbf
     835:	68 c0 16 00 00       	push   $0x16c0
     83a:	68 58 13 00 00       	push   $0x1358
     83f:	6a 02                	push   $0x2
     841:	e8 ba 07 00 00       	call   1000 <printf>
     846:	83 c4 0c             	add    $0xc,%esp
     849:	ff 35 90 1b 00 00    	pushl  0x1b90
     84f:	68 85 13 00 00       	push   $0x1385
     854:	eb c0                	jmp    816 <trubleThread+0x66>
     856:	8d 76 00             	lea    0x0(%esi),%esi
     859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000860 <senaty>:
void senaty(int count){
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
     866:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
     86c:	81 ec 20 01 00 00    	sub    $0x120,%esp
     872:	8b 7d 08             	mov    0x8(%ebp),%edi
  printf(1, "starting %s test\n", __FUNCTION__);
     875:	68 b8 16 00 00       	push   $0x16b8
     87a:	68 a3 13 00 00       	push   $0x13a3
     87f:	6a 01                	push   $0x1
     881:	e8 7a 07 00 00       	call   1000 <printf>
    for(i=0 ; i < count ; i++){
     886:	83 c4 10             	add    $0x10,%esp
     889:	85 ff                	test   %edi,%edi
     88b:	0f 8e 61 01 00 00    	jle    9f2 <senaty+0x192>
     891:	31 c0                	xor    %eax,%eax
     893:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
     899:	89 7d 08             	mov    %edi,0x8(%ebp)
     89c:	89 c7                	mov    %eax,%edi
     89e:	66 90                	xchg   %ax,%ax
      mutex[i] = kthread_mutex_alloc();
     8a0:	e8 8d 06 00 00       	call   f32 <kthread_mutex_alloc>
      ASSERT((mutex[i] == -1), "kthread_mutex_alloc fail, i=%d", i);
     8a5:	83 f8 ff             	cmp    $0xffffffff,%eax
      mutex[i] = kthread_mutex_alloc();
     8a8:	89 c6                	mov    %eax,%esi
     8aa:	89 04 bb             	mov    %eax,(%ebx,%edi,4)
      ASSERT((mutex[i] == -1), "kthread_mutex_alloc fail, i=%d", i);
     8ad:	0f 84 c0 02 00 00    	je     b73 <senaty+0x313>
      ASSERT((kthread_mutex_lock(mutex[i]) == -1), "kthread_mutex_lock(%d) fail", mutex[i]);
     8b3:	83 ec 0c             	sub    $0xc,%esp
     8b6:	50                   	push   %eax
     8b7:	e8 86 06 00 00       	call   f42 <kthread_mutex_lock>
     8bc:	83 c4 10             	add    $0x10,%esp
     8bf:	83 f8 ff             	cmp    $0xffffffff,%eax
     8c2:	0f 84 87 02 00 00    	je     b4f <senaty+0x2ef>
      ASSERT((kthread_mutex_unlock(mutex[i]) == -1), "kthread_mutex_unlock(%d) fail", mutex[i]);
     8c8:	83 ec 0c             	sub    $0xc,%esp
     8cb:	56                   	push   %esi
     8cc:	e8 79 06 00 00       	call   f4a <kthread_mutex_unlock>
     8d1:	83 c4 10             	add    $0x10,%esp
     8d4:	83 f8 ff             	cmp    $0xffffffff,%eax
     8d7:	0f 84 0f 02 00 00    	je     aec <senaty+0x28c>
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "second kthread_mutex_unlock(%d) didn't fail as expected", mutex[i]);
     8dd:	83 ec 0c             	sub    $0xc,%esp
     8e0:	56                   	push   %esi
     8e1:	e8 64 06 00 00       	call   f4a <kthread_mutex_unlock>
     8e6:	83 c4 10             	add    $0x10,%esp
     8e9:	83 f8 ff             	cmp    $0xffffffff,%eax
     8ec:	0f 85 a5 02 00 00    	jne    b97 <senaty+0x337>
    for(i=0 ; i < count ; i++){
     8f2:	83 c7 01             	add    $0x1,%edi
     8f5:	39 7d 08             	cmp    %edi,0x8(%ebp)
     8f8:	75 a6                	jne    8a0 <senaty+0x40>
     8fa:	89 f8                	mov    %edi,%eax
     8fc:	89 bd e4 fe ff ff    	mov    %edi,-0x11c(%ebp)
     902:	89 9d e0 fe ff ff    	mov    %ebx,-0x120(%ebp)
     908:	8d 34 83             	lea    (%ebx,%eax,4),%esi
     90b:	89 9d dc fe ff ff    	mov    %ebx,-0x124(%ebp)
     911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ASSERT((kthread_mutex_lock(mutex[i]) == -1), "kthread_mutex_lock(%d) fail", mutex[i]);
     918:	8b 3b                	mov    (%ebx),%edi
     91a:	83 ec 0c             	sub    $0xc,%esp
     91d:	57                   	push   %edi
     91e:	e8 1f 06 00 00       	call   f42 <kthread_mutex_lock>
     923:	83 c4 10             	add    $0x10,%esp
     926:	83 f8 ff             	cmp    $0xffffffff,%eax
     929:	0f 84 c1 02 00 00    	je     bf0 <senaty+0x390>
     92f:	83 c3 04             	add    $0x4,%ebx
    for(i=0 ; i < count ; i++){
     932:	39 de                	cmp    %ebx,%esi
     934:	75 e2                	jne    918 <senaty+0xb8>
     936:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
     93c:	8b bd e0 fe ff ff    	mov    -0x120(%ebp),%edi
     942:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
     948:	90                   	nop
     949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ASSERT((kthread_mutex_unlock(mutex[i]) == -1), "kthread_mutex_unlock(%d) fail", mutex[i]);
     950:	8b 37                	mov    (%edi),%esi
     952:	83 ec 0c             	sub    $0xc,%esp
     955:	56                   	push   %esi
     956:	e8 ef 05 00 00       	call   f4a <kthread_mutex_unlock>
     95b:	83 c4 10             	add    $0x10,%esp
     95e:	83 f8 ff             	cmp    $0xffffffff,%eax
     961:	0f 84 7f 02 00 00    	je     be6 <senaty+0x386>
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "second kthread_mutex_unlock(%d) didn't fail as expected", mutex[i]);
     967:	83 ec 0c             	sub    $0xc,%esp
     96a:	56                   	push   %esi
     96b:	e8 da 05 00 00       	call   f4a <kthread_mutex_unlock>
     970:	83 c4 10             	add    $0x10,%esp
     973:	83 f8 ff             	cmp    $0xffffffff,%eax
     976:	0f 85 63 02 00 00    	jne    bdf <senaty+0x37f>
     97c:	83 c7 04             	add    $0x4,%edi
    for(i=0 ; i < count ; i++){
     97f:	39 df                	cmp    %ebx,%edi
     981:	75 cd                	jne    950 <senaty+0xf0>
     983:	8b 9d e0 fe ff ff    	mov    -0x120(%ebp),%ebx
    for(i=0 ; i < count ; i++){
     989:	31 ff                	xor    %edi,%edi
     98b:	90                   	nop
     98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ASSERT((kthread_mutex_dealloc(mutex[i]) == -1), "kthread_mutex_dealloc(%d) fail", mutex[i]);
     990:	8b 34 bb             	mov    (%ebx,%edi,4),%esi
     993:	83 ec 0c             	sub    $0xc,%esp
     996:	56                   	push   %esi
     997:	e8 9e 05 00 00       	call   f3a <kthread_mutex_dealloc>
     99c:	83 c4 10             	add    $0x10,%esp
     99f:	83 f8 ff             	cmp    $0xffffffff,%eax
     9a2:	0f 84 65 01 00 00    	je     b0d <senaty+0x2ad>
      ASSERT((kthread_mutex_dealloc(mutex[i]) != -1), "second kthread_mutex_dealloc(%d) didn't fail as expected", mutex[i]);
     9a8:	83 ec 0c             	sub    $0xc,%esp
     9ab:	56                   	push   %esi
     9ac:	e8 89 05 00 00       	call   f3a <kthread_mutex_dealloc>
     9b1:	83 c4 10             	add    $0x10,%esp
     9b4:	83 f8 ff             	cmp    $0xffffffff,%eax
     9b7:	0f 85 fe 01 00 00    	jne    bbb <senaty+0x35b>
      ASSERT((kthread_mutex_lock(mutex[i]) != -1), "kthread_mutex_lock(%d) didn't fail after dealloc", mutex[i]);
     9bd:	83 ec 0c             	sub    $0xc,%esp
     9c0:	56                   	push   %esi
     9c1:	e8 7c 05 00 00       	call   f42 <kthread_mutex_lock>
     9c6:	83 c4 10             	add    $0x10,%esp
     9c9:	83 f8 ff             	cmp    $0xffffffff,%eax
     9cc:	0f 85 5c 01 00 00    	jne    b2e <senaty+0x2ce>
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "kthread_mutex_unlock(%d) didn't fail after dealloc", mutex[i]);
     9d2:	83 ec 0c             	sub    $0xc,%esp
     9d5:	56                   	push   %esi
     9d6:	e8 6f 05 00 00       	call   f4a <kthread_mutex_unlock>
     9db:	83 c4 10             	add    $0x10,%esp
     9de:	83 f8 ff             	cmp    $0xffffffff,%eax
     9e1:	0f 85 cc 00 00 00    	jne    ab3 <senaty+0x253>
    for(i=0 ; i < count ; i++){
     9e7:	83 c7 01             	add    $0x1,%edi
     9ea:	3b bd e4 fe ff ff    	cmp    -0x11c(%ebp),%edi
     9f0:	7c 9e                	jl     990 <senaty+0x130>
     9f2:	31 f6                	xor    %esi,%esi
     9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    mutex[i] = kthread_mutex_alloc();
     9f8:	e8 35 05 00 00       	call   f32 <kthread_mutex_alloc>
    ASSERT((mutex[i] == -1), "kthread_mutex_alloc (limit) fail, i=%d, expected fail at:%d", i, 64);
     9fd:	83 f8 ff             	cmp    $0xffffffff,%eax
    mutex[i] = kthread_mutex_alloc();
     a00:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    ASSERT((mutex[i] == -1), "kthread_mutex_alloc (limit) fail, i=%d, expected fail at:%d", i, 64);
     a03:	74 56                	je     a5b <senaty+0x1fb>
  for (i=0 ; i<64 ; i++){
     a05:	83 c6 01             	add    $0x1,%esi
     a08:	83 fe 40             	cmp    $0x40,%esi
     a0b:	75 eb                	jne    9f8 <senaty+0x198>
  ASSERT((kthread_mutex_alloc() != -1), "limit test didn't fail as expected create %d mutexes instad of %d", i+1, 64);
     a0d:	e8 20 05 00 00       	call   f32 <kthread_mutex_alloc>
     a12:	83 f8 ff             	cmp    $0xffffffff,%eax
     a15:	0f 85 e1 01 00 00    	jne    bfc <senaty+0x39c>
  for (i=0 ; i<64 ; i++){
     a1b:	31 f6                	xor    %esi,%esi
     a1d:	8d 76 00             	lea    0x0(%esi),%esi
    ASSERT((kthread_mutex_dealloc(mutex[i]) == -1), "kthread_mutex_dealloc(%d) fail, i=%d", mutex[i], i);
     a20:	8b 3c b3             	mov    (%ebx,%esi,4),%edi
     a23:	83 ec 0c             	sub    $0xc,%esp
     a26:	57                   	push   %edi
     a27:	e8 0e 05 00 00       	call   f3a <kthread_mutex_dealloc>
     a2c:	83 c4 10             	add    $0x10,%esp
     a2f:	83 f8 ff             	cmp    $0xffffffff,%eax
     a32:	74 60                	je     a94 <senaty+0x234>
  for (i=0 ; i<64 ; i++){
     a34:	83 c6 01             	add    $0x1,%esi
     a37:	83 fe 40             	cmp    $0x40,%esi
     a3a:	75 e4                	jne    a20 <senaty+0x1c0>
  printf(1, "%s test PASS!\n", __FUNCTION__);
     a3c:	83 ec 04             	sub    $0x4,%esp
     a3f:	68 b8 16 00 00       	push   $0x16b8
     a44:	68 0c 14 00 00       	push   $0x140c
     a49:	6a 01                	push   $0x1
     a4b:	e8 b0 05 00 00       	call   1000 <printf>
}
     a50:	83 c4 10             	add    $0x10,%esp
     a53:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a56:	5b                   	pop    %ebx
     a57:	5e                   	pop    %esi
     a58:	5f                   	pop    %edi
     a59:	5d                   	pop    %ebp
     a5a:	c3                   	ret    
    ASSERT((mutex[i] == -1), "kthread_mutex_alloc (limit) fail, i=%d, expected fail at:%d", i, 64);
     a5b:	68 e9 00 00 00       	push   $0xe9
     a60:	68 b8 16 00 00       	push   $0x16b8
     a65:	68 58 13 00 00       	push   $0x1358
     a6a:	6a 02                	push   $0x2
     a6c:	e8 8f 05 00 00       	call   1000 <printf>
     a71:	6a 40                	push   $0x40
     a73:	56                   	push   %esi
     a74:	68 10 16 00 00       	push   $0x1610
    ASSERT((kthread_mutex_dealloc(mutex[i]) == -1), "kthread_mutex_dealloc(%d) fail, i=%d", mutex[i], i);
     a79:	6a 02                	push   $0x2
     a7b:	e8 80 05 00 00       	call   1000 <printf>
     a80:	83 c4 18             	add    $0x18,%esp
     a83:	68 3c 14 00 00       	push   $0x143c
     a88:	6a 02                	push   $0x2
     a8a:	e8 71 05 00 00       	call   1000 <printf>
     a8f:	e8 de 03 00 00       	call   e72 <exit>
     a94:	68 f0 00 00 00       	push   $0xf0
     a99:	68 b8 16 00 00       	push   $0x16b8
     a9e:	68 58 13 00 00       	push   $0x1358
     aa3:	6a 02                	push   $0x2
     aa5:	e8 56 05 00 00       	call   1000 <printf>
     aaa:	56                   	push   %esi
     aab:	57                   	push   %edi
     aac:	68 90 16 00 00       	push   $0x1690
     ab1:	eb c6                	jmp    a79 <senaty+0x219>
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "kthread_mutex_unlock(%d) didn't fail after dealloc", mutex[i]);
     ab3:	68 e2 00 00 00       	push   $0xe2
     ab8:	68 b8 16 00 00       	push   $0x16b8
     abd:	68 58 13 00 00       	push   $0x1358
     ac2:	6a 02                	push   $0x2
     ac4:	e8 37 05 00 00       	call   1000 <printf>
     ac9:	83 c4 0c             	add    $0xc,%esp
     acc:	56                   	push   %esi
     acd:	68 dc 15 00 00       	push   $0x15dc
      ASSERT((kthread_mutex_lock(mutex[i]) == -1), "kthread_mutex_lock(%d) fail", mutex[i]);
     ad2:	6a 02                	push   $0x2
     ad4:	e8 27 05 00 00       	call   1000 <printf>
     ad9:	58                   	pop    %eax
     ada:	5a                   	pop    %edx
     adb:	68 3c 14 00 00       	push   $0x143c
     ae0:	6a 02                	push   $0x2
     ae2:	e8 19 05 00 00       	call   1000 <printf>
     ae7:	e8 86 03 00 00       	call   e72 <exit>
      ASSERT((kthread_mutex_unlock(mutex[i]) == -1), "kthread_mutex_unlock(%d) fail", mutex[i]);
     aec:	68 d1 00 00 00       	push   $0xd1
      ASSERT((kthread_mutex_unlock(mutex[i]) == -1), "kthread_mutex_unlock(%d) fail", mutex[i]);
     af1:	68 b8 16 00 00       	push   $0x16b8
     af6:	68 58 13 00 00       	push   $0x1358
     afb:	6a 02                	push   $0x2
     afd:	e8 fe 04 00 00       	call   1000 <printf>
     b02:	83 c4 0c             	add    $0xc,%esp
     b05:	56                   	push   %esi
     b06:	68 85 13 00 00       	push   $0x1385
     b0b:	eb c5                	jmp    ad2 <senaty+0x272>
      ASSERT((kthread_mutex_dealloc(mutex[i]) == -1), "kthread_mutex_dealloc(%d) fail", mutex[i]);
     b0d:	68 df 00 00 00       	push   $0xdf
     b12:	68 b8 16 00 00       	push   $0x16b8
     b17:	68 58 13 00 00       	push   $0x1358
     b1c:	6a 02                	push   $0x2
     b1e:	e8 dd 04 00 00       	call   1000 <printf>
     b23:	83 c4 0c             	add    $0xc,%esp
     b26:	56                   	push   %esi
     b27:	68 4c 15 00 00       	push   $0x154c
     b2c:	eb a4                	jmp    ad2 <senaty+0x272>
      ASSERT((kthread_mutex_lock(mutex[i]) != -1), "kthread_mutex_lock(%d) didn't fail after dealloc", mutex[i]);
     b2e:	68 e1 00 00 00       	push   $0xe1
     b33:	68 b8 16 00 00       	push   $0x16b8
     b38:	68 58 13 00 00       	push   $0x1358
     b3d:	6a 02                	push   $0x2
     b3f:	e8 bc 04 00 00       	call   1000 <printf>
     b44:	83 c4 0c             	add    $0xc,%esp
     b47:	56                   	push   %esi
     b48:	68 a8 15 00 00       	push   $0x15a8
     b4d:	eb 83                	jmp    ad2 <senaty+0x272>
      ASSERT((kthread_mutex_lock(mutex[i]) == -1), "kthread_mutex_lock(%d) fail", mutex[i]);
     b4f:	68 d0 00 00 00       	push   $0xd0
     b54:	68 b8 16 00 00       	push   $0x16b8
     b59:	68 58 13 00 00       	push   $0x1358
     b5e:	6a 02                	push   $0x2
     b60:	e8 9b 04 00 00       	call   1000 <printf>
     b65:	83 c4 0c             	add    $0xc,%esp
     b68:	56                   	push   %esi
     b69:	68 69 13 00 00       	push   $0x1369
     b6e:	e9 5f ff ff ff       	jmp    ad2 <senaty+0x272>
      ASSERT((mutex[i] == -1), "kthread_mutex_alloc fail, i=%d", i);
     b73:	68 cf 00 00 00       	push   $0xcf
     b78:	68 b8 16 00 00       	push   $0x16b8
     b7d:	68 58 13 00 00       	push   $0x1358
     b82:	6a 02                	push   $0x2
     b84:	e8 77 04 00 00       	call   1000 <printf>
     b89:	83 c4 0c             	add    $0xc,%esp
     b8c:	57                   	push   %edi
     b8d:	68 f4 14 00 00       	push   $0x14f4
     b92:	e9 3b ff ff ff       	jmp    ad2 <senaty+0x272>
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "second kthread_mutex_unlock(%d) didn't fail as expected", mutex[i]);
     b97:	68 d2 00 00 00       	push   $0xd2
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "second kthread_mutex_unlock(%d) didn't fail as expected", mutex[i]);
     b9c:	68 b8 16 00 00       	push   $0x16b8
     ba1:	68 58 13 00 00       	push   $0x1358
     ba6:	6a 02                	push   $0x2
     ba8:	e8 53 04 00 00       	call   1000 <printf>
     bad:	83 c4 0c             	add    $0xc,%esp
     bb0:	56                   	push   %esi
     bb1:	68 14 15 00 00       	push   $0x1514
     bb6:	e9 17 ff ff ff       	jmp    ad2 <senaty+0x272>
      ASSERT((kthread_mutex_dealloc(mutex[i]) != -1), "second kthread_mutex_dealloc(%d) didn't fail as expected", mutex[i]);
     bbb:	68 e0 00 00 00       	push   $0xe0
     bc0:	68 b8 16 00 00       	push   $0x16b8
     bc5:	68 58 13 00 00       	push   $0x1358
     bca:	6a 02                	push   $0x2
     bcc:	e8 2f 04 00 00       	call   1000 <printf>
     bd1:	83 c4 0c             	add    $0xc,%esp
     bd4:	56                   	push   %esi
     bd5:	68 6c 15 00 00       	push   $0x156c
     bda:	e9 f3 fe ff ff       	jmp    ad2 <senaty+0x272>
      ASSERT((kthread_mutex_unlock(mutex[i]) != -1), "second kthread_mutex_unlock(%d) didn't fail as expected", mutex[i]);
     bdf:	68 db 00 00 00       	push   $0xdb
     be4:	eb b6                	jmp    b9c <senaty+0x33c>
      ASSERT((kthread_mutex_unlock(mutex[i]) == -1), "kthread_mutex_unlock(%d) fail", mutex[i]);
     be6:	68 da 00 00 00       	push   $0xda
     beb:	e9 01 ff ff ff       	jmp    af1 <senaty+0x291>
     bf0:	89 fe                	mov    %edi,%esi
      ASSERT((kthread_mutex_lock(mutex[i]) == -1), "kthread_mutex_lock(%d) fail", mutex[i]);
     bf2:	68 d6 00 00 00       	push   $0xd6
     bf7:	e9 58 ff ff ff       	jmp    b54 <senaty+0x2f4>
  ASSERT((kthread_mutex_alloc() != -1), "limit test didn't fail as expected create %d mutexes instad of %d", i+1, 64);
     bfc:	68 ec 00 00 00       	push   $0xec
     c01:	68 b8 16 00 00       	push   $0x16b8
     c06:	68 58 13 00 00       	push   $0x1358
     c0b:	6a 02                	push   $0x2
     c0d:	e8 ee 03 00 00       	call   1000 <printf>
     c12:	6a 40                	push   $0x40
     c14:	6a 41                	push   $0x41
     c16:	68 4c 16 00 00       	push   $0x164c
     c1b:	e9 59 fe ff ff       	jmp    a79 <senaty+0x219>

00000c20 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	53                   	push   %ebx
     c24:	8b 45 08             	mov    0x8(%ebp),%eax
     c27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c2a:	89 c2                	mov    %eax,%edx
     c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c30:	83 c1 01             	add    $0x1,%ecx
     c33:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     c37:	83 c2 01             	add    $0x1,%edx
     c3a:	84 db                	test   %bl,%bl
     c3c:	88 5a ff             	mov    %bl,-0x1(%edx)
     c3f:	75 ef                	jne    c30 <strcpy+0x10>
    ;
  return os;
}
     c41:	5b                   	pop    %ebx
     c42:	5d                   	pop    %ebp
     c43:	c3                   	ret    
     c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000c50 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	53                   	push   %ebx
     c54:	8b 55 08             	mov    0x8(%ebp),%edx
     c57:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     c5a:	0f b6 02             	movzbl (%edx),%eax
     c5d:	0f b6 19             	movzbl (%ecx),%ebx
     c60:	84 c0                	test   %al,%al
     c62:	75 1c                	jne    c80 <strcmp+0x30>
     c64:	eb 2a                	jmp    c90 <strcmp+0x40>
     c66:	8d 76 00             	lea    0x0(%esi),%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     c70:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     c73:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     c76:	83 c1 01             	add    $0x1,%ecx
     c79:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     c7c:	84 c0                	test   %al,%al
     c7e:	74 10                	je     c90 <strcmp+0x40>
     c80:	38 d8                	cmp    %bl,%al
     c82:	74 ec                	je     c70 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     c84:	29 d8                	sub    %ebx,%eax
}
     c86:	5b                   	pop    %ebx
     c87:	5d                   	pop    %ebp
     c88:	c3                   	ret    
     c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c90:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     c92:	29 d8                	sub    %ebx,%eax
}
     c94:	5b                   	pop    %ebx
     c95:	5d                   	pop    %ebp
     c96:	c3                   	ret    
     c97:	89 f6                	mov    %esi,%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <strlen>:

uint
strlen(const char *s)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ca6:	80 39 00             	cmpb   $0x0,(%ecx)
     ca9:	74 15                	je     cc0 <strlen+0x20>
     cab:	31 d2                	xor    %edx,%edx
     cad:	8d 76 00             	lea    0x0(%esi),%esi
     cb0:	83 c2 01             	add    $0x1,%edx
     cb3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     cb7:	89 d0                	mov    %edx,%eax
     cb9:	75 f5                	jne    cb0 <strlen+0x10>
    ;
  return n;
}
     cbb:	5d                   	pop    %ebp
     cbc:	c3                   	ret    
     cbd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     cc0:	31 c0                	xor    %eax,%eax
}
     cc2:	5d                   	pop    %ebp
     cc3:	c3                   	ret    
     cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000cd0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	57                   	push   %edi
     cd4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     cd7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     cda:	8b 45 0c             	mov    0xc(%ebp),%eax
     cdd:	89 d7                	mov    %edx,%edi
     cdf:	fc                   	cld    
     ce0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ce2:	89 d0                	mov    %edx,%eax
     ce4:	5f                   	pop    %edi
     ce5:	5d                   	pop    %ebp
     ce6:	c3                   	ret    
     ce7:	89 f6                	mov    %esi,%esi
     ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cf0 <strchr>:

char*
strchr(const char *s, char c)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	53                   	push   %ebx
     cf4:	8b 45 08             	mov    0x8(%ebp),%eax
     cf7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     cfa:	0f b6 10             	movzbl (%eax),%edx
     cfd:	84 d2                	test   %dl,%dl
     cff:	74 1d                	je     d1e <strchr+0x2e>
    if(*s == c)
     d01:	38 d3                	cmp    %dl,%bl
     d03:	89 d9                	mov    %ebx,%ecx
     d05:	75 0d                	jne    d14 <strchr+0x24>
     d07:	eb 17                	jmp    d20 <strchr+0x30>
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d10:	38 ca                	cmp    %cl,%dl
     d12:	74 0c                	je     d20 <strchr+0x30>
  for(; *s; s++)
     d14:	83 c0 01             	add    $0x1,%eax
     d17:	0f b6 10             	movzbl (%eax),%edx
     d1a:	84 d2                	test   %dl,%dl
     d1c:	75 f2                	jne    d10 <strchr+0x20>
      return (char*)s;
  return 0;
     d1e:	31 c0                	xor    %eax,%eax
}
     d20:	5b                   	pop    %ebx
     d21:	5d                   	pop    %ebp
     d22:	c3                   	ret    
     d23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d30 <gets>:

char*
gets(char *buf, int max)
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	57                   	push   %edi
     d34:	56                   	push   %esi
     d35:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d36:	31 f6                	xor    %esi,%esi
     d38:	89 f3                	mov    %esi,%ebx
{
     d3a:	83 ec 1c             	sub    $0x1c,%esp
     d3d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     d40:	eb 2f                	jmp    d71 <gets+0x41>
     d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     d48:	8d 45 e7             	lea    -0x19(%ebp),%eax
     d4b:	83 ec 04             	sub    $0x4,%esp
     d4e:	6a 01                	push   $0x1
     d50:	50                   	push   %eax
     d51:	6a 00                	push   $0x0
     d53:	e8 32 01 00 00       	call   e8a <read>
    if(cc < 1)
     d58:	83 c4 10             	add    $0x10,%esp
     d5b:	85 c0                	test   %eax,%eax
     d5d:	7e 1c                	jle    d7b <gets+0x4b>
      break;
    buf[i++] = c;
     d5f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     d63:	83 c7 01             	add    $0x1,%edi
     d66:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     d69:	3c 0a                	cmp    $0xa,%al
     d6b:	74 23                	je     d90 <gets+0x60>
     d6d:	3c 0d                	cmp    $0xd,%al
     d6f:	74 1f                	je     d90 <gets+0x60>
  for(i=0; i+1 < max; ){
     d71:	83 c3 01             	add    $0x1,%ebx
     d74:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     d77:	89 fe                	mov    %edi,%esi
     d79:	7c cd                	jl     d48 <gets+0x18>
     d7b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     d80:	c6 03 00             	movb   $0x0,(%ebx)
}
     d83:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d86:	5b                   	pop    %ebx
     d87:	5e                   	pop    %esi
     d88:	5f                   	pop    %edi
     d89:	5d                   	pop    %ebp
     d8a:	c3                   	ret    
     d8b:	90                   	nop
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d90:	8b 75 08             	mov    0x8(%ebp),%esi
     d93:	8b 45 08             	mov    0x8(%ebp),%eax
     d96:	01 de                	add    %ebx,%esi
     d98:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     d9a:	c6 03 00             	movb   $0x0,(%ebx)
}
     d9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     da0:	5b                   	pop    %ebx
     da1:	5e                   	pop    %esi
     da2:	5f                   	pop    %edi
     da3:	5d                   	pop    %ebp
     da4:	c3                   	ret    
     da5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000db0 <stat>:

int
stat(const char *n, struct stat *st)
{
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	56                   	push   %esi
     db4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     db5:	83 ec 08             	sub    $0x8,%esp
     db8:	6a 00                	push   $0x0
     dba:	ff 75 08             	pushl  0x8(%ebp)
     dbd:	e8 f0 00 00 00       	call   eb2 <open>
  if(fd < 0)
     dc2:	83 c4 10             	add    $0x10,%esp
     dc5:	85 c0                	test   %eax,%eax
     dc7:	78 27                	js     df0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     dc9:	83 ec 08             	sub    $0x8,%esp
     dcc:	ff 75 0c             	pushl  0xc(%ebp)
     dcf:	89 c3                	mov    %eax,%ebx
     dd1:	50                   	push   %eax
     dd2:	e8 f3 00 00 00       	call   eca <fstat>
  close(fd);
     dd7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     dda:	89 c6                	mov    %eax,%esi
  close(fd);
     ddc:	e8 b9 00 00 00       	call   e9a <close>
  return r;
     de1:	83 c4 10             	add    $0x10,%esp
}
     de4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     de7:	89 f0                	mov    %esi,%eax
     de9:	5b                   	pop    %ebx
     dea:	5e                   	pop    %esi
     deb:	5d                   	pop    %ebp
     dec:	c3                   	ret    
     ded:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     df0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     df5:	eb ed                	jmp    de4 <stat+0x34>
     df7:	89 f6                	mov    %esi,%esi
     df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e00 <atoi>:

int
atoi(const char *s)
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	53                   	push   %ebx
     e04:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e07:	0f be 11             	movsbl (%ecx),%edx
     e0a:	8d 42 d0             	lea    -0x30(%edx),%eax
     e0d:	3c 09                	cmp    $0x9,%al
  n = 0;
     e0f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     e14:	77 1f                	ja     e35 <atoi+0x35>
     e16:	8d 76 00             	lea    0x0(%esi),%esi
     e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     e20:	8d 04 80             	lea    (%eax,%eax,4),%eax
     e23:	83 c1 01             	add    $0x1,%ecx
     e26:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     e2a:	0f be 11             	movsbl (%ecx),%edx
     e2d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     e30:	80 fb 09             	cmp    $0x9,%bl
     e33:	76 eb                	jbe    e20 <atoi+0x20>
  return n;
}
     e35:	5b                   	pop    %ebx
     e36:	5d                   	pop    %ebp
     e37:	c3                   	ret    
     e38:	90                   	nop
     e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e40 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	56                   	push   %esi
     e44:	53                   	push   %ebx
     e45:	8b 5d 10             	mov    0x10(%ebp),%ebx
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e4e:	85 db                	test   %ebx,%ebx
     e50:	7e 14                	jle    e66 <memmove+0x26>
     e52:	31 d2                	xor    %edx,%edx
     e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     e58:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     e5c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     e5f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     e62:	39 d3                	cmp    %edx,%ebx
     e64:	75 f2                	jne    e58 <memmove+0x18>
  return vdst;
}
     e66:	5b                   	pop    %ebx
     e67:	5e                   	pop    %esi
     e68:	5d                   	pop    %ebp
     e69:	c3                   	ret    

00000e6a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e6a:	b8 01 00 00 00       	mov    $0x1,%eax
     e6f:	cd 40                	int    $0x40
     e71:	c3                   	ret    

00000e72 <exit>:
SYSCALL(exit)
     e72:	b8 02 00 00 00       	mov    $0x2,%eax
     e77:	cd 40                	int    $0x40
     e79:	c3                   	ret    

00000e7a <wait>:
SYSCALL(wait)
     e7a:	b8 03 00 00 00       	mov    $0x3,%eax
     e7f:	cd 40                	int    $0x40
     e81:	c3                   	ret    

00000e82 <pipe>:
SYSCALL(pipe)
     e82:	b8 04 00 00 00       	mov    $0x4,%eax
     e87:	cd 40                	int    $0x40
     e89:	c3                   	ret    

00000e8a <read>:
SYSCALL(read)
     e8a:	b8 05 00 00 00       	mov    $0x5,%eax
     e8f:	cd 40                	int    $0x40
     e91:	c3                   	ret    

00000e92 <write>:
SYSCALL(write)
     e92:	b8 10 00 00 00       	mov    $0x10,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    

00000e9a <close>:
SYSCALL(close)
     e9a:	b8 15 00 00 00       	mov    $0x15,%eax
     e9f:	cd 40                	int    $0x40
     ea1:	c3                   	ret    

00000ea2 <kill>:
SYSCALL(kill)
     ea2:	b8 06 00 00 00       	mov    $0x6,%eax
     ea7:	cd 40                	int    $0x40
     ea9:	c3                   	ret    

00000eaa <exec>:
SYSCALL(exec)
     eaa:	b8 07 00 00 00       	mov    $0x7,%eax
     eaf:	cd 40                	int    $0x40
     eb1:	c3                   	ret    

00000eb2 <open>:
SYSCALL(open)
     eb2:	b8 0f 00 00 00       	mov    $0xf,%eax
     eb7:	cd 40                	int    $0x40
     eb9:	c3                   	ret    

00000eba <mknod>:
SYSCALL(mknod)
     eba:	b8 11 00 00 00       	mov    $0x11,%eax
     ebf:	cd 40                	int    $0x40
     ec1:	c3                   	ret    

00000ec2 <unlink>:
SYSCALL(unlink)
     ec2:	b8 12 00 00 00       	mov    $0x12,%eax
     ec7:	cd 40                	int    $0x40
     ec9:	c3                   	ret    

00000eca <fstat>:
SYSCALL(fstat)
     eca:	b8 08 00 00 00       	mov    $0x8,%eax
     ecf:	cd 40                	int    $0x40
     ed1:	c3                   	ret    

00000ed2 <link>:
SYSCALL(link)
     ed2:	b8 13 00 00 00       	mov    $0x13,%eax
     ed7:	cd 40                	int    $0x40
     ed9:	c3                   	ret    

00000eda <mkdir>:
SYSCALL(mkdir)
     eda:	b8 14 00 00 00       	mov    $0x14,%eax
     edf:	cd 40                	int    $0x40
     ee1:	c3                   	ret    

00000ee2 <chdir>:
SYSCALL(chdir)
     ee2:	b8 09 00 00 00       	mov    $0x9,%eax
     ee7:	cd 40                	int    $0x40
     ee9:	c3                   	ret    

00000eea <dup>:
SYSCALL(dup)
     eea:	b8 0a 00 00 00       	mov    $0xa,%eax
     eef:	cd 40                	int    $0x40
     ef1:	c3                   	ret    

00000ef2 <getpid>:
SYSCALL(getpid)
     ef2:	b8 0b 00 00 00       	mov    $0xb,%eax
     ef7:	cd 40                	int    $0x40
     ef9:	c3                   	ret    

00000efa <sbrk>:
SYSCALL(sbrk)
     efa:	b8 0c 00 00 00       	mov    $0xc,%eax
     eff:	cd 40                	int    $0x40
     f01:	c3                   	ret    

00000f02 <sleep>:
SYSCALL(sleep)
     f02:	b8 0d 00 00 00       	mov    $0xd,%eax
     f07:	cd 40                	int    $0x40
     f09:	c3                   	ret    

00000f0a <uptime>:
SYSCALL(uptime)
     f0a:	b8 0e 00 00 00       	mov    $0xe,%eax
     f0f:	cd 40                	int    $0x40
     f11:	c3                   	ret    

00000f12 <kthread_create>:
SYSCALL(kthread_create)
     f12:	b8 16 00 00 00       	mov    $0x16,%eax
     f17:	cd 40                	int    $0x40
     f19:	c3                   	ret    

00000f1a <kthread_id>:
SYSCALL(kthread_id)
     f1a:	b8 17 00 00 00       	mov    $0x17,%eax
     f1f:	cd 40                	int    $0x40
     f21:	c3                   	ret    

00000f22 <kthread_exit>:
SYSCALL(kthread_exit)
     f22:	b8 18 00 00 00       	mov    $0x18,%eax
     f27:	cd 40                	int    $0x40
     f29:	c3                   	ret    

00000f2a <kthread_join>:
SYSCALL(kthread_join)
     f2a:	b8 19 00 00 00       	mov    $0x19,%eax
     f2f:	cd 40                	int    $0x40
     f31:	c3                   	ret    

00000f32 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
     f32:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f37:	cd 40                	int    $0x40
     f39:	c3                   	ret    

00000f3a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
     f3a:	b8 1b 00 00 00       	mov    $0x1b,%eax
     f3f:	cd 40                	int    $0x40
     f41:	c3                   	ret    

00000f42 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
     f42:	b8 1c 00 00 00       	mov    $0x1c,%eax
     f47:	cd 40                	int    $0x40
     f49:	c3                   	ret    

00000f4a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
     f4a:	b8 1d 00 00 00       	mov    $0x1d,%eax
     f4f:	cd 40                	int    $0x40
     f51:	c3                   	ret    
     f52:	66 90                	xchg   %ax,%ax
     f54:	66 90                	xchg   %ax,%ax
     f56:	66 90                	xchg   %ax,%ax
     f58:	66 90                	xchg   %ax,%ax
     f5a:	66 90                	xchg   %ax,%ax
     f5c:	66 90                	xchg   %ax,%ax
     f5e:	66 90                	xchg   %ax,%ax

00000f60 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	57                   	push   %edi
     f64:	56                   	push   %esi
     f65:	53                   	push   %ebx
     f66:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f69:	85 d2                	test   %edx,%edx
{
     f6b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     f6e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     f70:	79 76                	jns    fe8 <printint+0x88>
     f72:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     f76:	74 70                	je     fe8 <printint+0x88>
    x = -xx;
     f78:	f7 d8                	neg    %eax
    neg = 1;
     f7a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     f81:	31 f6                	xor    %esi,%esi
     f83:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     f86:	eb 0a                	jmp    f92 <printint+0x32>
     f88:	90                   	nop
     f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     f90:	89 fe                	mov    %edi,%esi
     f92:	31 d2                	xor    %edx,%edx
     f94:	8d 7e 01             	lea    0x1(%esi),%edi
     f97:	f7 f1                	div    %ecx
     f99:	0f b6 92 18 17 00 00 	movzbl 0x1718(%edx),%edx
  }while((x /= base) != 0);
     fa0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     fa2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     fa5:	75 e9                	jne    f90 <printint+0x30>
  if(neg)
     fa7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     faa:	85 c0                	test   %eax,%eax
     fac:	74 08                	je     fb6 <printint+0x56>
    buf[i++] = '-';
     fae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     fb3:	8d 7e 02             	lea    0x2(%esi),%edi
     fb6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     fba:	8b 7d c0             	mov    -0x40(%ebp),%edi
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
     fc0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     fc3:	83 ec 04             	sub    $0x4,%esp
     fc6:	83 ee 01             	sub    $0x1,%esi
     fc9:	6a 01                	push   $0x1
     fcb:	53                   	push   %ebx
     fcc:	57                   	push   %edi
     fcd:	88 45 d7             	mov    %al,-0x29(%ebp)
     fd0:	e8 bd fe ff ff       	call   e92 <write>

  while(--i >= 0)
     fd5:	83 c4 10             	add    $0x10,%esp
     fd8:	39 de                	cmp    %ebx,%esi
     fda:	75 e4                	jne    fc0 <printint+0x60>
    putc(fd, buf[i]);
}
     fdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdf:	5b                   	pop    %ebx
     fe0:	5e                   	pop    %esi
     fe1:	5f                   	pop    %edi
     fe2:	5d                   	pop    %ebp
     fe3:	c3                   	ret    
     fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     fe8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     fef:	eb 90                	jmp    f81 <printint+0x21>
     ff1:	eb 0d                	jmp    1000 <printf>
     ff3:	90                   	nop
     ff4:	90                   	nop
     ff5:	90                   	nop
     ff6:	90                   	nop
     ff7:	90                   	nop
     ff8:	90                   	nop
     ff9:	90                   	nop
     ffa:	90                   	nop
     ffb:	90                   	nop
     ffc:	90                   	nop
     ffd:	90                   	nop
     ffe:	90                   	nop
     fff:	90                   	nop

00001000 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1009:	8b 75 0c             	mov    0xc(%ebp),%esi
    100c:	0f b6 1e             	movzbl (%esi),%ebx
    100f:	84 db                	test   %bl,%bl
    1011:	0f 84 b3 00 00 00    	je     10ca <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1017:	8d 45 10             	lea    0x10(%ebp),%eax
    101a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    101d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    101f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1022:	eb 2f                	jmp    1053 <printf+0x53>
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1028:	83 f8 25             	cmp    $0x25,%eax
    102b:	0f 84 a7 00 00 00    	je     10d8 <printf+0xd8>
  write(fd, &c, 1);
    1031:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1034:	83 ec 04             	sub    $0x4,%esp
    1037:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    103a:	6a 01                	push   $0x1
    103c:	50                   	push   %eax
    103d:	ff 75 08             	pushl  0x8(%ebp)
    1040:	e8 4d fe ff ff       	call   e92 <write>
    1045:	83 c4 10             	add    $0x10,%esp
    1048:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    104b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    104f:	84 db                	test   %bl,%bl
    1051:	74 77                	je     10ca <printf+0xca>
    if(state == 0){
    1053:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1055:	0f be cb             	movsbl %bl,%ecx
    1058:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    105b:	74 cb                	je     1028 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    105d:	83 ff 25             	cmp    $0x25,%edi
    1060:	75 e6                	jne    1048 <printf+0x48>
      if(c == 'd'){
    1062:	83 f8 64             	cmp    $0x64,%eax
    1065:	0f 84 05 01 00 00    	je     1170 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    106b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1071:	83 f9 70             	cmp    $0x70,%ecx
    1074:	74 72                	je     10e8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1076:	83 f8 73             	cmp    $0x73,%eax
    1079:	0f 84 99 00 00 00    	je     1118 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    107f:	83 f8 63             	cmp    $0x63,%eax
    1082:	0f 84 08 01 00 00    	je     1190 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1088:	83 f8 25             	cmp    $0x25,%eax
    108b:	0f 84 ef 00 00 00    	je     1180 <printf+0x180>
  write(fd, &c, 1);
    1091:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1094:	83 ec 04             	sub    $0x4,%esp
    1097:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    109b:	6a 01                	push   $0x1
    109d:	50                   	push   %eax
    109e:	ff 75 08             	pushl  0x8(%ebp)
    10a1:	e8 ec fd ff ff       	call   e92 <write>
    10a6:	83 c4 0c             	add    $0xc,%esp
    10a9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    10ac:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    10af:	6a 01                	push   $0x1
    10b1:	50                   	push   %eax
    10b2:	ff 75 08             	pushl  0x8(%ebp)
    10b5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10b8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    10ba:	e8 d3 fd ff ff       	call   e92 <write>
  for(i = 0; fmt[i]; i++){
    10bf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    10c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    10c6:	84 db                	test   %bl,%bl
    10c8:	75 89                	jne    1053 <printf+0x53>
    }
  }
}
    10ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10cd:	5b                   	pop    %ebx
    10ce:	5e                   	pop    %esi
    10cf:	5f                   	pop    %edi
    10d0:	5d                   	pop    %ebp
    10d1:	c3                   	ret    
    10d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    10d8:	bf 25 00 00 00       	mov    $0x25,%edi
    10dd:	e9 66 ff ff ff       	jmp    1048 <printf+0x48>
    10e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    10e8:	83 ec 0c             	sub    $0xc,%esp
    10eb:	b9 10 00 00 00       	mov    $0x10,%ecx
    10f0:	6a 00                	push   $0x0
    10f2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    10f5:	8b 45 08             	mov    0x8(%ebp),%eax
    10f8:	8b 17                	mov    (%edi),%edx
    10fa:	e8 61 fe ff ff       	call   f60 <printint>
        ap++;
    10ff:	89 f8                	mov    %edi,%eax
    1101:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1104:	31 ff                	xor    %edi,%edi
        ap++;
    1106:	83 c0 04             	add    $0x4,%eax
    1109:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    110c:	e9 37 ff ff ff       	jmp    1048 <printf+0x48>
    1111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1118:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    111b:	8b 08                	mov    (%eax),%ecx
        ap++;
    111d:	83 c0 04             	add    $0x4,%eax
    1120:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1123:	85 c9                	test   %ecx,%ecx
    1125:	0f 84 8e 00 00 00    	je     11b9 <printf+0x1b9>
        while(*s != 0){
    112b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    112e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1130:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1132:	84 c0                	test   %al,%al
    1134:	0f 84 0e ff ff ff    	je     1048 <printf+0x48>
    113a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    113d:	89 de                	mov    %ebx,%esi
    113f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1142:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1145:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1148:	83 ec 04             	sub    $0x4,%esp
          s++;
    114b:	83 c6 01             	add    $0x1,%esi
    114e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1151:	6a 01                	push   $0x1
    1153:	57                   	push   %edi
    1154:	53                   	push   %ebx
    1155:	e8 38 fd ff ff       	call   e92 <write>
        while(*s != 0){
    115a:	0f b6 06             	movzbl (%esi),%eax
    115d:	83 c4 10             	add    $0x10,%esp
    1160:	84 c0                	test   %al,%al
    1162:	75 e4                	jne    1148 <printf+0x148>
    1164:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1167:	31 ff                	xor    %edi,%edi
    1169:	e9 da fe ff ff       	jmp    1048 <printf+0x48>
    116e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1170:	83 ec 0c             	sub    $0xc,%esp
    1173:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1178:	6a 01                	push   $0x1
    117a:	e9 73 ff ff ff       	jmp    10f2 <printf+0xf2>
    117f:	90                   	nop
  write(fd, &c, 1);
    1180:	83 ec 04             	sub    $0x4,%esp
    1183:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1186:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1189:	6a 01                	push   $0x1
    118b:	e9 21 ff ff ff       	jmp    10b1 <printf+0xb1>
        putc(fd, *ap);
    1190:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1193:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1196:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1198:	6a 01                	push   $0x1
        ap++;
    119a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    119d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    11a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    11a3:	50                   	push   %eax
    11a4:	ff 75 08             	pushl  0x8(%ebp)
    11a7:	e8 e6 fc ff ff       	call   e92 <write>
        ap++;
    11ac:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    11af:	83 c4 10             	add    $0x10,%esp
      state = 0;
    11b2:	31 ff                	xor    %edi,%edi
    11b4:	e9 8f fe ff ff       	jmp    1048 <printf+0x48>
          s = "(null)";
    11b9:	bb 0f 17 00 00       	mov    $0x170f,%ebx
        while(*s != 0){
    11be:	b8 28 00 00 00       	mov    $0x28,%eax
    11c3:	e9 72 ff ff ff       	jmp    113a <printf+0x13a>
    11c8:	66 90                	xchg   %ax,%ax
    11ca:	66 90                	xchg   %ax,%ax
    11cc:	66 90                	xchg   %ax,%ax
    11ce:	66 90                	xchg   %ax,%ax

000011d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d1:	a1 00 1b 00 00       	mov    0x1b00,%eax
{
    11d6:	89 e5                	mov    %esp,%ebp
    11d8:	57                   	push   %edi
    11d9:	56                   	push   %esi
    11da:	53                   	push   %ebx
    11db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    11de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    11e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11e8:	39 c8                	cmp    %ecx,%eax
    11ea:	8b 10                	mov    (%eax),%edx
    11ec:	73 32                	jae    1220 <free+0x50>
    11ee:	39 d1                	cmp    %edx,%ecx
    11f0:	72 04                	jb     11f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11f2:	39 d0                	cmp    %edx,%eax
    11f4:	72 32                	jb     1228 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    11f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    11fc:	39 fa                	cmp    %edi,%edx
    11fe:	74 30                	je     1230 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1200:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1203:	8b 50 04             	mov    0x4(%eax),%edx
    1206:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1209:	39 f1                	cmp    %esi,%ecx
    120b:	74 3a                	je     1247 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    120d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    120f:	a3 00 1b 00 00       	mov    %eax,0x1b00
}
    1214:	5b                   	pop    %ebx
    1215:	5e                   	pop    %esi
    1216:	5f                   	pop    %edi
    1217:	5d                   	pop    %ebp
    1218:	c3                   	ret    
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1220:	39 d0                	cmp    %edx,%eax
    1222:	72 04                	jb     1228 <free+0x58>
    1224:	39 d1                	cmp    %edx,%ecx
    1226:	72 ce                	jb     11f6 <free+0x26>
{
    1228:	89 d0                	mov    %edx,%eax
    122a:	eb bc                	jmp    11e8 <free+0x18>
    122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1230:	03 72 04             	add    0x4(%edx),%esi
    1233:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1236:	8b 10                	mov    (%eax),%edx
    1238:	8b 12                	mov    (%edx),%edx
    123a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    123d:	8b 50 04             	mov    0x4(%eax),%edx
    1240:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1243:	39 f1                	cmp    %esi,%ecx
    1245:	75 c6                	jne    120d <free+0x3d>
    p->s.size += bp->s.size;
    1247:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    124a:	a3 00 1b 00 00       	mov    %eax,0x1b00
    p->s.size += bp->s.size;
    124f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1252:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1255:	89 10                	mov    %edx,(%eax)
}
    1257:	5b                   	pop    %ebx
    1258:	5e                   	pop    %esi
    1259:	5f                   	pop    %edi
    125a:	5d                   	pop    %ebp
    125b:	c3                   	ret    
    125c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001260 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	56                   	push   %esi
    1265:	53                   	push   %ebx
    1266:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1269:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    126c:	8b 15 00 1b 00 00    	mov    0x1b00,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1272:	8d 78 07             	lea    0x7(%eax),%edi
    1275:	c1 ef 03             	shr    $0x3,%edi
    1278:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    127b:	85 d2                	test   %edx,%edx
    127d:	0f 84 9d 00 00 00    	je     1320 <malloc+0xc0>
    1283:	8b 02                	mov    (%edx),%eax
    1285:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1288:	39 cf                	cmp    %ecx,%edi
    128a:	76 6c                	jbe    12f8 <malloc+0x98>
    128c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1292:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1297:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    129a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    12a1:	eb 0e                	jmp    12b1 <malloc+0x51>
    12a3:	90                   	nop
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    12aa:	8b 48 04             	mov    0x4(%eax),%ecx
    12ad:	39 f9                	cmp    %edi,%ecx
    12af:	73 47                	jae    12f8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12b1:	39 05 00 1b 00 00    	cmp    %eax,0x1b00
    12b7:	89 c2                	mov    %eax,%edx
    12b9:	75 ed                	jne    12a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    12bb:	83 ec 0c             	sub    $0xc,%esp
    12be:	56                   	push   %esi
    12bf:	e8 36 fc ff ff       	call   efa <sbrk>
  if(p == (char*)-1)
    12c4:	83 c4 10             	add    $0x10,%esp
    12c7:	83 f8 ff             	cmp    $0xffffffff,%eax
    12ca:	74 1c                	je     12e8 <malloc+0x88>
  hp->s.size = nu;
    12cc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    12cf:	83 ec 0c             	sub    $0xc,%esp
    12d2:	83 c0 08             	add    $0x8,%eax
    12d5:	50                   	push   %eax
    12d6:	e8 f5 fe ff ff       	call   11d0 <free>
  return freep;
    12db:	8b 15 00 1b 00 00    	mov    0x1b00,%edx
      if((p = morecore(nunits)) == 0)
    12e1:	83 c4 10             	add    $0x10,%esp
    12e4:	85 d2                	test   %edx,%edx
    12e6:	75 c0                	jne    12a8 <malloc+0x48>
        return 0;
  }
}
    12e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    12eb:	31 c0                	xor    %eax,%eax
}
    12ed:	5b                   	pop    %ebx
    12ee:	5e                   	pop    %esi
    12ef:	5f                   	pop    %edi
    12f0:	5d                   	pop    %ebp
    12f1:	c3                   	ret    
    12f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    12f8:	39 cf                	cmp    %ecx,%edi
    12fa:	74 54                	je     1350 <malloc+0xf0>
        p->s.size -= nunits;
    12fc:	29 f9                	sub    %edi,%ecx
    12fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1301:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1304:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1307:	89 15 00 1b 00 00    	mov    %edx,0x1b00
}
    130d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1310:	83 c0 08             	add    $0x8,%eax
}
    1313:	5b                   	pop    %ebx
    1314:	5e                   	pop    %esi
    1315:	5f                   	pop    %edi
    1316:	5d                   	pop    %ebp
    1317:	c3                   	ret    
    1318:	90                   	nop
    1319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1320:	c7 05 00 1b 00 00 04 	movl   $0x1b04,0x1b00
    1327:	1b 00 00 
    132a:	c7 05 04 1b 00 00 04 	movl   $0x1b04,0x1b04
    1331:	1b 00 00 
    base.s.size = 0;
    1334:	b8 04 1b 00 00       	mov    $0x1b04,%eax
    1339:	c7 05 08 1b 00 00 00 	movl   $0x0,0x1b08
    1340:	00 00 00 
    1343:	e9 44 ff ff ff       	jmp    128c <malloc+0x2c>
    1348:	90                   	nop
    1349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1350:	8b 08                	mov    (%eax),%ecx
    1352:	89 0a                	mov    %ecx,(%edx)
    1354:	eb b1                	jmp    1307 <malloc+0xa7>
