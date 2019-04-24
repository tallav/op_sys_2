
_kt_sys6:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
     threadStart_29,
     threadStart_30,
     threadStart_31,
     threadStart_32};

int main(int argc, char *argv[]){
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	57                   	push   %edi
       e:	56                   	push   %esi
       f:	53                   	push   %ebx
      10:	51                   	push   %ecx
      11:	81 ec 84 01 00 00    	sub    $0x184,%esp
    int pids[THREAD_NUM*2];

    THREAD_STACK(threadStack_1)
      17:	68 f4 01 00 00       	push   $0x1f4
      1c:	e8 2f 15 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_2)
      21:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_1)
      28:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
    THREAD_STACK(threadStack_2)
      2e:	e8 1d 15 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_3)
      33:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_2)
      3a:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
    THREAD_STACK(threadStack_3)
      40:	e8 0b 15 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_4)
      45:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_3)
      4c:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
    THREAD_STACK(threadStack_4)
      52:	e8 f9 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_5)
      57:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_4)
      5e:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
    THREAD_STACK(threadStack_5)
      64:	e8 e7 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_6)
      69:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_5)
      70:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
    THREAD_STACK(threadStack_6)
      76:	e8 d5 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_7)
      7b:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_6)
      82:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
    THREAD_STACK(threadStack_7)
      88:	e8 c3 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_8)
      8d:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_7)
      94:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
    THREAD_STACK(threadStack_8)
      9a:	e8 b1 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_9)
      9f:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_8)
      a6:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
    THREAD_STACK(threadStack_9)
      ac:	e8 9f 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_10)
      b1:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_9)
      b8:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
    THREAD_STACK(threadStack_10)
      be:	e8 8d 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_11)
      c3:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_10)
      ca:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
    THREAD_STACK(threadStack_11)
      d0:	e8 7b 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_12)
      d5:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_11)
      dc:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
    THREAD_STACK(threadStack_12)
      e2:	e8 69 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_13)
      e7:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_12)
      ee:	89 85 b8 fe ff ff    	mov    %eax,-0x148(%ebp)
    THREAD_STACK(threadStack_13)
      f4:	e8 57 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_14)
      f9:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_13)
     100:	89 c7                	mov    %eax,%edi
    THREAD_STACK(threadStack_14)
     102:	e8 49 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_15)
     107:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_14)
     10e:	89 85 b4 fe ff ff    	mov    %eax,-0x14c(%ebp)
    THREAD_STACK(threadStack_15)
     114:	e8 37 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_16)
     119:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_15)
     120:	89 85 b0 fe ff ff    	mov    %eax,-0x150(%ebp)
    THREAD_STACK(threadStack_16)
     126:	e8 25 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_17)
     12b:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_16)
     132:	89 85 ac fe ff ff    	mov    %eax,-0x154(%ebp)
    THREAD_STACK(threadStack_17)
     138:	e8 13 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_18)
     13d:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_17)
     144:	89 85 a8 fe ff ff    	mov    %eax,-0x158(%ebp)
    THREAD_STACK(threadStack_18)
     14a:	e8 01 14 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_19)
     14f:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_18)
     156:	89 85 a4 fe ff ff    	mov    %eax,-0x15c(%ebp)
    THREAD_STACK(threadStack_19)
     15c:	e8 ef 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_20)
     161:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_19)
     168:	89 85 a0 fe ff ff    	mov    %eax,-0x160(%ebp)
    THREAD_STACK(threadStack_20)
     16e:	e8 dd 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_21)
     173:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_20)
     17a:	89 85 9c fe ff ff    	mov    %eax,-0x164(%ebp)
    THREAD_STACK(threadStack_21)
     180:	e8 cb 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_22)
     185:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_21)
     18c:	89 85 98 fe ff ff    	mov    %eax,-0x168(%ebp)
    THREAD_STACK(threadStack_22)
     192:	e8 b9 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_23)
     197:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_22)
     19e:	89 85 94 fe ff ff    	mov    %eax,-0x16c(%ebp)
    THREAD_STACK(threadStack_23)
     1a4:	e8 a7 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_24)
     1a9:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_23)
     1b0:	89 85 90 fe ff ff    	mov    %eax,-0x170(%ebp)
    THREAD_STACK(threadStack_24)
     1b6:	e8 95 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_25)
     1bb:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_24)
     1c2:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
    THREAD_STACK(threadStack_25)
     1c8:	e8 83 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_26)
     1cd:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_25)
     1d4:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
    THREAD_STACK(threadStack_26)
     1da:	e8 71 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_27)
     1df:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_26)
     1e6:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
    THREAD_STACK(threadStack_27)
     1ec:	e8 5f 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_28)
     1f1:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_27)
     1f8:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
    THREAD_STACK(threadStack_28)
     1fe:	e8 4d 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_29)
     203:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_28)
     20a:	89 85 7c fe ff ff    	mov    %eax,-0x184(%ebp)
    THREAD_STACK(threadStack_29)
     210:	e8 3b 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_30)
     215:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_29)
     21c:	89 85 78 fe ff ff    	mov    %eax,-0x188(%ebp)
    THREAD_STACK(threadStack_30)
     222:	e8 29 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_31)
     227:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_30)
     22e:	89 c6                	mov    %eax,%esi
    THREAD_STACK(threadStack_31)
     230:	e8 1b 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_32)
     235:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    THREAD_STACK(threadStack_31)
     23c:	89 c3                	mov    %eax,%ebx
    THREAD_STACK(threadStack_13)
     23e:	81 c7 f4 01 00 00    	add    $0x1f4,%edi
    THREAD_STACK(threadStack_32)
     244:	e8 07 13 00 00       	call   1550 <malloc>
    THREAD_STACK(threadStack_2)
     249:	8b 8d e0 fe ff ff    	mov    -0x120(%ebp),%ecx
    THREAD_STACK(threadStack_1)
     24f:	8b 95 e4 fe ff ff    	mov    -0x11c(%ebp),%edx
    THREAD_STACK(threadStack_30)
     255:	81 c6 f4 01 00 00    	add    $0x1f4,%esi
    THREAD_STACK(threadStack_13)
     25b:	89 7d 98             	mov    %edi,-0x68(%ebp)
    THREAD_STACK(threadStack_17)
     25e:	8b bd a8 fe ff ff    	mov    -0x158(%ebp),%edi
    THREAD_STACK(threadStack_2)
     264:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
    THREAD_STACK(threadStack_1)
     26a:	81 c2 f4 01 00 00    	add    $0x1f4,%edx
    THREAD_STACK(threadStack_2)
     270:	89 8d 6c ff ff ff    	mov    %ecx,-0x94(%ebp)
    THREAD_STACK(threadStack_3)
     276:	8b 8d dc fe ff ff    	mov    -0x124(%ebp),%ecx
    THREAD_STACK(threadStack_17)
     27c:	81 c7 f4 01 00 00    	add    $0x1f4,%edi

    void (*threads_stacks[])(void) = 
     282:	89 95 68 ff ff ff    	mov    %edx,-0x98(%ebp)
    THREAD_STACK(threadStack_3)
     288:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     28e:	89 8d 70 ff ff ff    	mov    %ecx,-0x90(%ebp)
    THREAD_STACK(threadStack_4)
     294:	8b 8d d8 fe ff ff    	mov    -0x128(%ebp),%ecx
     29a:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     2a0:	89 8d 74 ff ff ff    	mov    %ecx,-0x8c(%ebp)
    THREAD_STACK(threadStack_5)
     2a6:	8b 8d d4 fe ff ff    	mov    -0x12c(%ebp),%ecx
     2ac:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     2b2:	89 8d 78 ff ff ff    	mov    %ecx,-0x88(%ebp)
    THREAD_STACK(threadStack_6)
     2b8:	8b 8d d0 fe ff ff    	mov    -0x130(%ebp),%ecx
     2be:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     2c4:	89 8d 7c ff ff ff    	mov    %ecx,-0x84(%ebp)
    THREAD_STACK(threadStack_7)
     2ca:	8b 8d cc fe ff ff    	mov    -0x134(%ebp),%ecx
     2d0:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     2d6:	89 4d 80             	mov    %ecx,-0x80(%ebp)
    THREAD_STACK(threadStack_8)
     2d9:	8b 8d c8 fe ff ff    	mov    -0x138(%ebp),%ecx
     2df:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     2e5:	89 4d 84             	mov    %ecx,-0x7c(%ebp)
    THREAD_STACK(threadStack_9)
     2e8:	8b 8d c4 fe ff ff    	mov    -0x13c(%ebp),%ecx
     2ee:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     2f4:	89 4d 88             	mov    %ecx,-0x78(%ebp)
    THREAD_STACK(threadStack_10)
     2f7:	8b 8d c0 fe ff ff    	mov    -0x140(%ebp),%ecx
     2fd:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     303:	89 4d 8c             	mov    %ecx,-0x74(%ebp)
    THREAD_STACK(threadStack_11)
     306:	8b 8d bc fe ff ff    	mov    -0x144(%ebp),%ecx
     30c:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     312:	89 4d 90             	mov    %ecx,-0x70(%ebp)
    THREAD_STACK(threadStack_12)
     315:	8b 8d b8 fe ff ff    	mov    -0x148(%ebp),%ecx
     31b:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     321:	89 4d 94             	mov    %ecx,-0x6c(%ebp)
    THREAD_STACK(threadStack_14)
     324:	8b 8d b4 fe ff ff    	mov    -0x14c(%ebp),%ecx
     32a:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     330:	89 4d 9c             	mov    %ecx,-0x64(%ebp)
    THREAD_STACK(threadStack_15)
     333:	8b 8d b0 fe ff ff    	mov    -0x150(%ebp),%ecx
     339:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     33f:	89 4d a0             	mov    %ecx,-0x60(%ebp)
    THREAD_STACK(threadStack_16)
     342:	8b 8d ac fe ff ff    	mov    -0x154(%ebp),%ecx
     348:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     34e:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
    void (*threads_stacks[])(void) = 
     351:	89 7d a8             	mov    %edi,-0x58(%ebp)
    THREAD_STACK(threadStack_18)
     354:	8b 8d a4 fe ff ff    	mov    -0x15c(%ebp),%ecx
    THREAD_STACK(threadStack_30)
     35a:	89 75 dc             	mov    %esi,-0x24(%ebp)
    THREAD_STACK(threadStack_18)
     35d:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     363:	89 4d ac             	mov    %ecx,-0x54(%ebp)
    THREAD_STACK(threadStack_19)
     366:	8b 8d a0 fe ff ff    	mov    -0x160(%ebp),%ecx
     36c:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     372:	89 4d b0             	mov    %ecx,-0x50(%ebp)
    THREAD_STACK(threadStack_20)
     375:	8b 8d 9c fe ff ff    	mov    -0x164(%ebp),%ecx
     37b:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     381:	89 4d b4             	mov    %ecx,-0x4c(%ebp)
    THREAD_STACK(threadStack_21)
     384:	8b 8d 98 fe ff ff    	mov    -0x168(%ebp),%ecx
     38a:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     390:	89 4d b8             	mov    %ecx,-0x48(%ebp)
    THREAD_STACK(threadStack_22)
     393:	8b 8d 94 fe ff ff    	mov    -0x16c(%ebp),%ecx
     399:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     39f:	89 4d bc             	mov    %ecx,-0x44(%ebp)
    THREAD_STACK(threadStack_23)
     3a2:	8b 8d 90 fe ff ff    	mov    -0x170(%ebp),%ecx
     3a8:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     3ae:	89 4d c0             	mov    %ecx,-0x40(%ebp)
    THREAD_STACK(threadStack_24)
     3b1:	8b 8d 8c fe ff ff    	mov    -0x174(%ebp),%ecx
     3b7:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     3bd:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
    THREAD_STACK(threadStack_25)
     3c0:	8b 8d 88 fe ff ff    	mov    -0x178(%ebp),%ecx
     3c6:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     3cc:	89 4d c8             	mov    %ecx,-0x38(%ebp)
    THREAD_STACK(threadStack_26)
     3cf:	8b 8d 84 fe ff ff    	mov    -0x17c(%ebp),%ecx
     3d5:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     3db:	89 4d cc             	mov    %ecx,-0x34(%ebp)
    THREAD_STACK(threadStack_27)
     3de:	8b 8d 80 fe ff ff    	mov    -0x180(%ebp),%ecx
     3e4:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     3ea:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    THREAD_STACK(threadStack_28)
     3ed:	8b 8d 7c fe ff ff    	mov    -0x184(%ebp),%ecx
     3f3:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
     3f9:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    THREAD_STACK(threadStack_29)
     3fc:	8b 8d 78 fe ff ff    	mov    -0x188(%ebp),%ecx
     402:	81 c1 f4 01 00 00    	add    $0x1f4,%ecx
    THREAD_STACK(threadStack_31)
     408:	81 c3 f4 01 00 00    	add    $0x1f4,%ebx
    THREAD_STACK(threadStack_32)
     40e:	05 f4 01 00 00       	add    $0x1f4,%eax
    THREAD_STACK(threadStack_31)
     413:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    THREAD_STACK(threadStack_29)
     416:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    void (*threads_stacks[])(void) = 
     419:	83 c4 10             	add    $0x10,%esp
    THREAD_STACK(threadStack_32)
     41c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     threadStack_29,
     threadStack_30,
     threadStack_31,
     threadStack_32};

    for(int i = 0;i < THREAD_NUM;i++){
     41f:	31 db                	xor    %ebx,%ebx
     421:	eb 24                	jmp    447 <main+0x447>
     423:	90                   	nop
     424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pids[i] = kthread_create(threads_starts[i], threads_stacks[i]);

        if(pids[i] > 0){
            printf(1,"Created thread %d successfully\n",i+1);
     428:	83 ec 04             	sub    $0x4,%esp
     42b:	53                   	push   %ebx
     42c:	68 c4 16 00 00       	push   $0x16c4
     431:	6a 01                	push   $0x1
     433:	e8 b8 0e 00 00       	call   12f0 <printf>
     438:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < THREAD_NUM;i++){
     43b:	83 fb 10             	cmp    $0x10,%ebx
     43e:	74 40                	je     480 <main+0x480>
     440:	8b 94 9d 68 ff ff ff 	mov    -0x98(%ebp,%ebx,4),%edx
        pids[i] = kthread_create(threads_starts[i], threads_stacks[i]);
     447:	83 ec 08             	sub    $0x8,%esp
     44a:	52                   	push   %edx
     44b:	ff 34 9d a0 1e 00 00 	pushl  0x1ea0(,%ebx,4)
     452:	e8 ab 0d 00 00       	call   1202 <kthread_create>
        if(pids[i] > 0){
     457:	83 c4 10             	add    $0x10,%esp
        pids[i] = kthread_create(threads_starts[i], threads_stacks[i]);
     45a:	89 84 9d e8 fe ff ff 	mov    %eax,-0x118(%ebp,%ebx,4)
     461:	83 c3 01             	add    $0x1,%ebx
        if(pids[i] > 0){
     464:	85 c0                	test   %eax,%eax
     466:	7f c0                	jg     428 <main+0x428>
        }
        else{
            printf(1,"Created thread %d unsuccessfully\n",i+1);
     468:	83 ec 04             	sub    $0x4,%esp
     46b:	53                   	push   %ebx
     46c:	68 e4 16 00 00       	push   $0x16e4
     471:	6a 01                	push   $0x1
     473:	e8 78 0e 00 00       	call   12f0 <printf>
     478:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < THREAD_NUM;i++){
     47b:	83 fb 10             	cmp    $0x10,%ebx
     47e:	75 c0                	jne    440 <main+0x440>
        }
    }

    printf(1,"Starting joining threads, should indicate when each thread was sucessfully joined soon\n");
     480:	83 ec 08             	sub    $0x8,%esp

    for(int i = 0;i < THREAD_NUM;i++){
     483:	31 db                	xor    %ebx,%ebx
    printf(1,"Starting joining threads, should indicate when each thread was sucessfully joined soon\n");
     485:	68 08 17 00 00       	push   $0x1708
     48a:	6a 01                	push   $0x1
     48c:	e8 5f 0e 00 00       	call   12f0 <printf>
     491:	83 c4 10             	add    $0x10,%esp
     494:	eb 2a                	jmp    4c0 <main+0x4c0>
     496:	8d 76 00             	lea    0x0(%esi),%esi
     499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Finished joing thread %d\n",i+1);
        }
        else if(result == -1){
     4a0:	83 f8 ff             	cmp    $0xffffffff,%eax
     4a3:	0f 84 87 01 00 00    	je     630 <main+0x630>
            printf(1,"Error in joing thread %d\n",i+1);
        }
         else{
            printf(1,"Unknown result code from join\n");
     4a9:	83 ec 08             	sub    $0x8,%esp
     4ac:	68 60 17 00 00       	push   $0x1760
     4b1:	6a 01                	push   $0x1
     4b3:	e8 38 0e 00 00       	call   12f0 <printf>
     4b8:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < THREAD_NUM;i++){
     4bb:	83 fb 10             	cmp    $0x10,%ebx
     4be:	74 3f                	je     4ff <main+0x4ff>
        printf(1,"Attempting to join thread %d\n",i+1);
     4c0:	83 ec 04             	sub    $0x4,%esp
     4c3:	83 c3 01             	add    $0x1,%ebx
     4c6:	53                   	push   %ebx
     4c7:	68 6f 16 00 00       	push   $0x166f
     4cc:	6a 01                	push   $0x1
     4ce:	e8 1d 0e 00 00       	call   12f0 <printf>
        int result = kthread_join(pids[i]);
     4d3:	5e                   	pop    %esi
     4d4:	ff b4 9d e4 fe ff ff 	pushl  -0x11c(%ebp,%ebx,4)
     4db:	e8 3a 0d 00 00       	call   121a <kthread_join>
        if(result == 0){
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	85 c0                	test   %eax,%eax
     4e5:	75 b9                	jne    4a0 <main+0x4a0>
            printf(1,"Finished joing thread %d\n",i+1);
     4e7:	83 ec 04             	sub    $0x4,%esp
     4ea:	53                   	push   %ebx
     4eb:	68 8d 16 00 00       	push   $0x168d
     4f0:	6a 01                	push   $0x1
     4f2:	e8 f9 0d 00 00       	call   12f0 <printf>
     4f7:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < THREAD_NUM;i++){
     4fa:	83 fb 10             	cmp    $0x10,%ebx
     4fd:	75 c1                	jne    4c0 <main+0x4c0>
        }
    }

    
    for(int i = 0;i < THREAD_NUM;i++){
     4ff:	31 db                	xor    %ebx,%ebx
     501:	eb 25                	jmp    528 <main+0x528>
     503:	90                   	nop
     504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Thread %d shouldn't be my thread anymore\n",i+1);
        }
        else if(result == -1){
     508:	83 f8 ff             	cmp    $0xffffffff,%eax
     50b:	0f 84 3f 01 00 00    	je     650 <main+0x650>
            printf(1,"Thread %d isn't my thread anymore, as it should be\n",i+1);
        }
        else{
            printf(1,"Unknown result code from join\n");
     511:	83 ec 08             	sub    $0x8,%esp
     514:	68 60 17 00 00       	push   $0x1760
     519:	6a 01                	push   $0x1
     51b:	e8 d0 0d 00 00       	call   12f0 <printf>
     520:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < THREAD_NUM;i++){
     523:	83 fb 10             	cmp    $0x10,%ebx
     526:	74 3f                	je     567 <main+0x567>
        printf(1,"Attempting to join thread %d\n",i+1);
     528:	83 ec 04             	sub    $0x4,%esp
     52b:	83 c3 01             	add    $0x1,%ebx
     52e:	53                   	push   %ebx
     52f:	68 6f 16 00 00       	push   $0x166f
     534:	6a 01                	push   $0x1
     536:	e8 b5 0d 00 00       	call   12f0 <printf>
        int result = kthread_join(pids[i]);
     53b:	59                   	pop    %ecx
     53c:	ff b4 9d e4 fe ff ff 	pushl  -0x11c(%ebp,%ebx,4)
     543:	e8 d2 0c 00 00       	call   121a <kthread_join>
        if(result == 0){
     548:	83 c4 10             	add    $0x10,%esp
     54b:	85 c0                	test   %eax,%eax
     54d:	75 b9                	jne    508 <main+0x508>
            printf(1,"Thread %d shouldn't be my thread anymore\n",i+1);
     54f:	83 ec 04             	sub    $0x4,%esp
     552:	53                   	push   %ebx
     553:	68 80 17 00 00       	push   $0x1780
     558:	6a 01                	push   $0x1
     55a:	e8 91 0d 00 00       	call   12f0 <printf>
     55f:	83 c4 10             	add    $0x10,%esp
    for(int i = 0;i < THREAD_NUM;i++){
     562:	83 fb 10             	cmp    $0x10,%ebx
     565:	75 c1                	jne    528 <main+0x528>
        }
    }    

    for(int i = 16;i < THREAD_NUM*2;i++){
     567:	be 10 00 00 00       	mov    $0x10,%esi
     56c:	eb 21                	jmp    58f <main+0x58f>
     56e:	66 90                	xchg   %ax,%ax
        pids[i] = kthread_create(threads_starts[i], threads_stacks[i]);

        if(pids[i] > 0){
            printf(1,"Created thread %d successfully\n",i+1);
     570:	83 ec 04             	sub    $0x4,%esp
     573:	56                   	push   %esi
     574:	68 c4 16 00 00       	push   $0x16c4
     579:	6a 01                	push   $0x1
     57b:	e8 70 0d 00 00       	call   12f0 <printf>
     580:	83 c4 10             	add    $0x10,%esp
    for(int i = 16;i < THREAD_NUM*2;i++){
     583:	83 fe 20             	cmp    $0x20,%esi
     586:	74 40                	je     5c8 <main+0x5c8>
     588:	8b bc b5 68 ff ff ff 	mov    -0x98(%ebp,%esi,4),%edi
        pids[i] = kthread_create(threads_starts[i], threads_stacks[i]);
     58f:	83 ec 08             	sub    $0x8,%esp
     592:	57                   	push   %edi
     593:	ff 34 b5 a0 1e 00 00 	pushl  0x1ea0(,%esi,4)
     59a:	e8 63 0c 00 00       	call   1202 <kthread_create>
        if(pids[i] > 0){
     59f:	83 c4 10             	add    $0x10,%esp
        pids[i] = kthread_create(threads_starts[i], threads_stacks[i]);
     5a2:	89 84 b5 e8 fe ff ff 	mov    %eax,-0x118(%ebp,%esi,4)
     5a9:	83 c6 01             	add    $0x1,%esi
        if(pids[i] > 0){
     5ac:	85 c0                	test   %eax,%eax
     5ae:	7f c0                	jg     570 <main+0x570>
        }
        else{
            printf(1,"Created thread %d unsuccessfully\n",i+1);
     5b0:	83 ec 04             	sub    $0x4,%esp
     5b3:	56                   	push   %esi
     5b4:	68 e4 16 00 00       	push   $0x16e4
     5b9:	6a 01                	push   $0x1
     5bb:	e8 30 0d 00 00       	call   12f0 <printf>
     5c0:	83 c4 10             	add    $0x10,%esp
    for(int i = 16;i < THREAD_NUM*2;i++){
     5c3:	83 fe 20             	cmp    $0x20,%esi
     5c6:	75 c0                	jne    588 <main+0x588>
        }
    }

    for(int i = 16;i < THREAD_NUM*2;i++){
     5c8:	be 10 00 00 00       	mov    $0x10,%esi
     5cd:	eb 25                	jmp    5f4 <main+0x5f4>
     5cf:	90                   	nop

        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Finished joing thread %d\n",i+1);
        }
        else if(result == -1){
     5d0:	83 f8 ff             	cmp    $0xffffffff,%eax
     5d3:	0f 84 f7 00 00 00    	je     6d0 <main+0x6d0>
            printf(1,"Error in joing thread %d\n",i+1);
        }
        else{
            printf(1,"Unknown result code from join\n");
     5d9:	83 ec 08             	sub    $0x8,%esp
     5dc:	68 60 17 00 00       	push   $0x1760
     5e1:	6a 01                	push   $0x1
     5e3:	e8 08 0d 00 00       	call   12f0 <printf>
     5e8:	83 c4 10             	add    $0x10,%esp
    for(int i = 16;i < THREAD_NUM*2;i++){
     5eb:	83 fe 20             	cmp    $0x20,%esi
     5ee:	0f 84 98 00 00 00    	je     68c <main+0x68c>
        printf(1,"Attempting to join thread %d\n",i+1);
     5f4:	83 ec 04             	sub    $0x4,%esp
     5f7:	83 c6 01             	add    $0x1,%esi
     5fa:	56                   	push   %esi
     5fb:	68 6f 16 00 00       	push   $0x166f
     600:	6a 01                	push   $0x1
     602:	e8 e9 0c 00 00       	call   12f0 <printf>
        int result = kthread_join(pids[i]);
     607:	5a                   	pop    %edx
     608:	ff b4 b5 e4 fe ff ff 	pushl  -0x11c(%ebp,%esi,4)
     60f:	e8 06 0c 00 00       	call   121a <kthread_join>
        if(result == 0){
     614:	83 c4 10             	add    $0x10,%esp
     617:	85 c0                	test   %eax,%eax
     619:	75 b5                	jne    5d0 <main+0x5d0>
            printf(1,"Finished joing thread %d\n",i+1);
     61b:	83 ec 04             	sub    $0x4,%esp
     61e:	56                   	push   %esi
     61f:	68 8d 16 00 00       	push   $0x168d
     624:	6a 01                	push   $0x1
     626:	e8 c5 0c 00 00       	call   12f0 <printf>
     62b:	83 c4 10             	add    $0x10,%esp
     62e:	eb bb                	jmp    5eb <main+0x5eb>
            printf(1,"Error in joing thread %d\n",i+1);
     630:	83 ec 04             	sub    $0x4,%esp
     633:	53                   	push   %ebx
     634:	68 a7 16 00 00       	push   $0x16a7
     639:	6a 01                	push   $0x1
     63b:	e8 b0 0c 00 00       	call   12f0 <printf>
     640:	83 c4 10             	add    $0x10,%esp
     643:	e9 73 fe ff ff       	jmp    4bb <main+0x4bb>
     648:	90                   	nop
     649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Thread %d isn't my thread anymore, as it should be\n",i+1);
     650:	83 ec 04             	sub    $0x4,%esp
     653:	53                   	push   %ebx
     654:	68 ac 17 00 00       	push   $0x17ac
     659:	6a 01                	push   $0x1
     65b:	e8 90 0c 00 00       	call   12f0 <printf>
     660:	83 c4 10             	add    $0x10,%esp
     663:	e9 bb fe ff ff       	jmp    523 <main+0x523>
     668:	90                   	nop
     669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

        int result = kthread_join(pids[i]);
        if(result == 0){
            printf(1,"Thread %d shouldn't be my thread anymore\n",i+1);
        }
        else if(result == -1){
     670:	83 f8 ff             	cmp    $0xffffffff,%eax
     673:	74 7b                	je     6f0 <main+0x6f0>
            printf(1,"Thread %d isn't my thread anymore, as it should be\n",i+1);
        }
        else{
            printf(1,"Unknown result code from join\n");
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 60 17 00 00       	push   $0x1760
     67d:	6a 01                	push   $0x1
     67f:	e8 6c 0c 00 00       	call   12f0 <printf>
     684:	83 c4 10             	add    $0x10,%esp
    for(int i = 16;i < THREAD_NUM*2;i++){
     687:	83 fb 20             	cmp    $0x20,%ebx
     68a:	74 3f                	je     6cb <main+0x6cb>
        printf(1,"Attempting to join thread %d\n",i+1);
     68c:	83 ec 04             	sub    $0x4,%esp
     68f:	83 c3 01             	add    $0x1,%ebx
     692:	53                   	push   %ebx
     693:	68 6f 16 00 00       	push   $0x166f
     698:	6a 01                	push   $0x1
     69a:	e8 51 0c 00 00       	call   12f0 <printf>
        int result = kthread_join(pids[i]);
     69f:	58                   	pop    %eax
     6a0:	ff b4 9d e4 fe ff ff 	pushl  -0x11c(%ebp,%ebx,4)
     6a7:	e8 6e 0b 00 00       	call   121a <kthread_join>
        if(result == 0){
     6ac:	83 c4 10             	add    $0x10,%esp
     6af:	85 c0                	test   %eax,%eax
     6b1:	75 bd                	jne    670 <main+0x670>
            printf(1,"Thread %d shouldn't be my thread anymore\n",i+1);
     6b3:	83 ec 04             	sub    $0x4,%esp
     6b6:	53                   	push   %ebx
     6b7:	68 80 17 00 00       	push   $0x1780
     6bc:	6a 01                	push   $0x1
     6be:	e8 2d 0c 00 00       	call   12f0 <printf>
     6c3:	83 c4 10             	add    $0x10,%esp
    for(int i = 16;i < THREAD_NUM*2;i++){
     6c6:	83 fb 20             	cmp    $0x20,%ebx
     6c9:	75 c1                	jne    68c <main+0x68c>
        }
    } 

    exit();
     6cb:	e8 92 0a 00 00       	call   1162 <exit>
            printf(1,"Error in joing thread %d\n",i+1);
     6d0:	83 ec 04             	sub    $0x4,%esp
     6d3:	56                   	push   %esi
     6d4:	68 a7 16 00 00       	push   $0x16a7
     6d9:	6a 01                	push   $0x1
     6db:	e8 10 0c 00 00       	call   12f0 <printf>
     6e0:	83 c4 10             	add    $0x10,%esp
     6e3:	e9 03 ff ff ff       	jmp    5eb <main+0x5eb>
     6e8:	90                   	nop
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf(1,"Thread %d isn't my thread anymore, as it should be\n",i+1);
     6f0:	83 ec 04             	sub    $0x4,%esp
     6f3:	53                   	push   %ebx
     6f4:	68 ac 17 00 00       	push   $0x17ac
     6f9:	6a 01                	push   $0x1
     6fb:	e8 f0 0b 00 00       	call   12f0 <printf>
     700:	83 c4 10             	add    $0x10,%esp
     703:	eb 82                	jmp    687 <main+0x687>
     705:	66 90                	xchg   %ax,%ax
     707:	66 90                	xchg   %ax,%ax
     709:	66 90                	xchg   %ax,%ax
     70b:	66 90                	xchg   %ax,%ax
     70d:	66 90                	xchg   %ax,%ax
     70f:	90                   	nop

00000710 <threadStart_1>:
THREAD_START(threadStart_1, 1)
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	83 ec 14             	sub    $0x14,%esp
     716:	68 c8 00 00 00       	push   $0xc8
     71b:	e8 d2 0a 00 00       	call   11f2 <sleep>
     720:	83 c4 0c             	add    $0xc,%esp
     723:	6a 01                	push   $0x1
     725:	68 48 16 00 00       	push   $0x1648
     72a:	6a 01                	push   $0x1
     72c:	e8 bf 0b 00 00       	call   12f0 <printf>
     731:	83 c4 0c             	add    $0xc,%esp
     734:	6a 01                	push   $0x1
     736:	68 5c 16 00 00       	push   $0x165c
     73b:	6a 01                	push   $0x1
     73d:	e8 ae 0b 00 00       	call   12f0 <printf>
     742:	83 c4 10             	add    $0x10,%esp
     745:	c9                   	leave  
     746:	e9 c7 0a 00 00       	jmp    1212 <kthread_exit>
     74b:	90                   	nop
     74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <threadStart_2>:
THREAD_START(threadStart_2, 2)
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	83 ec 14             	sub    $0x14,%esp
     756:	68 90 01 00 00       	push   $0x190
     75b:	e8 92 0a 00 00       	call   11f2 <sleep>
     760:	83 c4 0c             	add    $0xc,%esp
     763:	6a 02                	push   $0x2
     765:	68 48 16 00 00       	push   $0x1648
     76a:	6a 01                	push   $0x1
     76c:	e8 7f 0b 00 00       	call   12f0 <printf>
     771:	83 c4 0c             	add    $0xc,%esp
     774:	6a 02                	push   $0x2
     776:	68 5c 16 00 00       	push   $0x165c
     77b:	6a 01                	push   $0x1
     77d:	e8 6e 0b 00 00       	call   12f0 <printf>
     782:	83 c4 10             	add    $0x10,%esp
     785:	c9                   	leave  
     786:	e9 87 0a 00 00       	jmp    1212 <kthread_exit>
     78b:	90                   	nop
     78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <threadStart_3>:
THREAD_START(threadStart_3, 3)
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	83 ec 14             	sub    $0x14,%esp
     796:	68 58 02 00 00       	push   $0x258
     79b:	e8 52 0a 00 00       	call   11f2 <sleep>
     7a0:	83 c4 0c             	add    $0xc,%esp
     7a3:	6a 03                	push   $0x3
     7a5:	68 48 16 00 00       	push   $0x1648
     7aa:	6a 01                	push   $0x1
     7ac:	e8 3f 0b 00 00       	call   12f0 <printf>
     7b1:	83 c4 0c             	add    $0xc,%esp
     7b4:	6a 03                	push   $0x3
     7b6:	68 5c 16 00 00       	push   $0x165c
     7bb:	6a 01                	push   $0x1
     7bd:	e8 2e 0b 00 00       	call   12f0 <printf>
     7c2:	83 c4 10             	add    $0x10,%esp
     7c5:	c9                   	leave  
     7c6:	e9 47 0a 00 00       	jmp    1212 <kthread_exit>
     7cb:	90                   	nop
     7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007d0 <threadStart_4>:
THREAD_START(threadStart_4, 4)
     7d0:	55                   	push   %ebp
     7d1:	89 e5                	mov    %esp,%ebp
     7d3:	83 ec 14             	sub    $0x14,%esp
     7d6:	68 20 03 00 00       	push   $0x320
     7db:	e8 12 0a 00 00       	call   11f2 <sleep>
     7e0:	83 c4 0c             	add    $0xc,%esp
     7e3:	6a 04                	push   $0x4
     7e5:	68 48 16 00 00       	push   $0x1648
     7ea:	6a 01                	push   $0x1
     7ec:	e8 ff 0a 00 00       	call   12f0 <printf>
     7f1:	83 c4 0c             	add    $0xc,%esp
     7f4:	6a 04                	push   $0x4
     7f6:	68 5c 16 00 00       	push   $0x165c
     7fb:	6a 01                	push   $0x1
     7fd:	e8 ee 0a 00 00       	call   12f0 <printf>
     802:	83 c4 10             	add    $0x10,%esp
     805:	c9                   	leave  
     806:	e9 07 0a 00 00       	jmp    1212 <kthread_exit>
     80b:	90                   	nop
     80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000810 <threadStart_5>:
THREAD_START(threadStart_5, 5)
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	83 ec 14             	sub    $0x14,%esp
     816:	68 e8 03 00 00       	push   $0x3e8
     81b:	e8 d2 09 00 00       	call   11f2 <sleep>
     820:	83 c4 0c             	add    $0xc,%esp
     823:	6a 05                	push   $0x5
     825:	68 48 16 00 00       	push   $0x1648
     82a:	6a 01                	push   $0x1
     82c:	e8 bf 0a 00 00       	call   12f0 <printf>
     831:	83 c4 0c             	add    $0xc,%esp
     834:	6a 05                	push   $0x5
     836:	68 5c 16 00 00       	push   $0x165c
     83b:	6a 01                	push   $0x1
     83d:	e8 ae 0a 00 00       	call   12f0 <printf>
     842:	83 c4 10             	add    $0x10,%esp
     845:	c9                   	leave  
     846:	e9 c7 09 00 00       	jmp    1212 <kthread_exit>
     84b:	90                   	nop
     84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000850 <threadStart_6>:
THREAD_START(threadStart_6, 6)
     850:	55                   	push   %ebp
     851:	89 e5                	mov    %esp,%ebp
     853:	83 ec 14             	sub    $0x14,%esp
     856:	68 b0 04 00 00       	push   $0x4b0
     85b:	e8 92 09 00 00       	call   11f2 <sleep>
     860:	83 c4 0c             	add    $0xc,%esp
     863:	6a 06                	push   $0x6
     865:	68 48 16 00 00       	push   $0x1648
     86a:	6a 01                	push   $0x1
     86c:	e8 7f 0a 00 00       	call   12f0 <printf>
     871:	83 c4 0c             	add    $0xc,%esp
     874:	6a 06                	push   $0x6
     876:	68 5c 16 00 00       	push   $0x165c
     87b:	6a 01                	push   $0x1
     87d:	e8 6e 0a 00 00       	call   12f0 <printf>
     882:	83 c4 10             	add    $0x10,%esp
     885:	c9                   	leave  
     886:	e9 87 09 00 00       	jmp    1212 <kthread_exit>
     88b:	90                   	nop
     88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000890 <threadStart_7>:
THREAD_START(threadStart_7, 7)
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	83 ec 14             	sub    $0x14,%esp
     896:	68 78 05 00 00       	push   $0x578
     89b:	e8 52 09 00 00       	call   11f2 <sleep>
     8a0:	83 c4 0c             	add    $0xc,%esp
     8a3:	6a 07                	push   $0x7
     8a5:	68 48 16 00 00       	push   $0x1648
     8aa:	6a 01                	push   $0x1
     8ac:	e8 3f 0a 00 00       	call   12f0 <printf>
     8b1:	83 c4 0c             	add    $0xc,%esp
     8b4:	6a 07                	push   $0x7
     8b6:	68 5c 16 00 00       	push   $0x165c
     8bb:	6a 01                	push   $0x1
     8bd:	e8 2e 0a 00 00       	call   12f0 <printf>
     8c2:	83 c4 10             	add    $0x10,%esp
     8c5:	c9                   	leave  
     8c6:	e9 47 09 00 00       	jmp    1212 <kthread_exit>
     8cb:	90                   	nop
     8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008d0 <threadStart_8>:
THREAD_START(threadStart_8, 8)
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	83 ec 14             	sub    $0x14,%esp
     8d6:	68 40 06 00 00       	push   $0x640
     8db:	e8 12 09 00 00       	call   11f2 <sleep>
     8e0:	83 c4 0c             	add    $0xc,%esp
     8e3:	6a 08                	push   $0x8
     8e5:	68 48 16 00 00       	push   $0x1648
     8ea:	6a 01                	push   $0x1
     8ec:	e8 ff 09 00 00       	call   12f0 <printf>
     8f1:	83 c4 0c             	add    $0xc,%esp
     8f4:	6a 08                	push   $0x8
     8f6:	68 5c 16 00 00       	push   $0x165c
     8fb:	6a 01                	push   $0x1
     8fd:	e8 ee 09 00 00       	call   12f0 <printf>
     902:	83 c4 10             	add    $0x10,%esp
     905:	c9                   	leave  
     906:	e9 07 09 00 00       	jmp    1212 <kthread_exit>
     90b:	90                   	nop
     90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000910 <threadStart_9>:
THREAD_START(threadStart_9, 9)
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	83 ec 14             	sub    $0x14,%esp
     916:	68 08 07 00 00       	push   $0x708
     91b:	e8 d2 08 00 00       	call   11f2 <sleep>
     920:	83 c4 0c             	add    $0xc,%esp
     923:	6a 09                	push   $0x9
     925:	68 48 16 00 00       	push   $0x1648
     92a:	6a 01                	push   $0x1
     92c:	e8 bf 09 00 00       	call   12f0 <printf>
     931:	83 c4 0c             	add    $0xc,%esp
     934:	6a 09                	push   $0x9
     936:	68 5c 16 00 00       	push   $0x165c
     93b:	6a 01                	push   $0x1
     93d:	e8 ae 09 00 00       	call   12f0 <printf>
     942:	83 c4 10             	add    $0x10,%esp
     945:	c9                   	leave  
     946:	e9 c7 08 00 00       	jmp    1212 <kthread_exit>
     94b:	90                   	nop
     94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000950 <threadStart_10>:
THREAD_START(threadStart_10, 10)
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	83 ec 14             	sub    $0x14,%esp
     956:	68 d0 07 00 00       	push   $0x7d0
     95b:	e8 92 08 00 00       	call   11f2 <sleep>
     960:	83 c4 0c             	add    $0xc,%esp
     963:	6a 0a                	push   $0xa
     965:	68 48 16 00 00       	push   $0x1648
     96a:	6a 01                	push   $0x1
     96c:	e8 7f 09 00 00       	call   12f0 <printf>
     971:	83 c4 0c             	add    $0xc,%esp
     974:	6a 0a                	push   $0xa
     976:	68 5c 16 00 00       	push   $0x165c
     97b:	6a 01                	push   $0x1
     97d:	e8 6e 09 00 00       	call   12f0 <printf>
     982:	83 c4 10             	add    $0x10,%esp
     985:	c9                   	leave  
     986:	e9 87 08 00 00       	jmp    1212 <kthread_exit>
     98b:	90                   	nop
     98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000990 <threadStart_11>:
THREAD_START(threadStart_11, 11)
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	83 ec 14             	sub    $0x14,%esp
     996:	68 98 08 00 00       	push   $0x898
     99b:	e8 52 08 00 00       	call   11f2 <sleep>
     9a0:	83 c4 0c             	add    $0xc,%esp
     9a3:	6a 0b                	push   $0xb
     9a5:	68 48 16 00 00       	push   $0x1648
     9aa:	6a 01                	push   $0x1
     9ac:	e8 3f 09 00 00       	call   12f0 <printf>
     9b1:	83 c4 0c             	add    $0xc,%esp
     9b4:	6a 0b                	push   $0xb
     9b6:	68 5c 16 00 00       	push   $0x165c
     9bb:	6a 01                	push   $0x1
     9bd:	e8 2e 09 00 00       	call   12f0 <printf>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	c9                   	leave  
     9c6:	e9 47 08 00 00       	jmp    1212 <kthread_exit>
     9cb:	90                   	nop
     9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009d0 <threadStart_12>:
THREAD_START(threadStart_12, 12)
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 14             	sub    $0x14,%esp
     9d6:	68 60 09 00 00       	push   $0x960
     9db:	e8 12 08 00 00       	call   11f2 <sleep>
     9e0:	83 c4 0c             	add    $0xc,%esp
     9e3:	6a 0c                	push   $0xc
     9e5:	68 48 16 00 00       	push   $0x1648
     9ea:	6a 01                	push   $0x1
     9ec:	e8 ff 08 00 00       	call   12f0 <printf>
     9f1:	83 c4 0c             	add    $0xc,%esp
     9f4:	6a 0c                	push   $0xc
     9f6:	68 5c 16 00 00       	push   $0x165c
     9fb:	6a 01                	push   $0x1
     9fd:	e8 ee 08 00 00       	call   12f0 <printf>
     a02:	83 c4 10             	add    $0x10,%esp
     a05:	c9                   	leave  
     a06:	e9 07 08 00 00       	jmp    1212 <kthread_exit>
     a0b:	90                   	nop
     a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a10 <threadStart_13>:
THREAD_START(threadStart_13, 13)
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	83 ec 14             	sub    $0x14,%esp
     a16:	68 28 0a 00 00       	push   $0xa28
     a1b:	e8 d2 07 00 00       	call   11f2 <sleep>
     a20:	83 c4 0c             	add    $0xc,%esp
     a23:	6a 0d                	push   $0xd
     a25:	68 48 16 00 00       	push   $0x1648
     a2a:	6a 01                	push   $0x1
     a2c:	e8 bf 08 00 00       	call   12f0 <printf>
     a31:	83 c4 0c             	add    $0xc,%esp
     a34:	6a 0d                	push   $0xd
     a36:	68 5c 16 00 00       	push   $0x165c
     a3b:	6a 01                	push   $0x1
     a3d:	e8 ae 08 00 00       	call   12f0 <printf>
     a42:	83 c4 10             	add    $0x10,%esp
     a45:	c9                   	leave  
     a46:	e9 c7 07 00 00       	jmp    1212 <kthread_exit>
     a4b:	90                   	nop
     a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <threadStart_14>:
THREAD_START(threadStart_14, 14)
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	83 ec 14             	sub    $0x14,%esp
     a56:	68 f0 0a 00 00       	push   $0xaf0
     a5b:	e8 92 07 00 00       	call   11f2 <sleep>
     a60:	83 c4 0c             	add    $0xc,%esp
     a63:	6a 0e                	push   $0xe
     a65:	68 48 16 00 00       	push   $0x1648
     a6a:	6a 01                	push   $0x1
     a6c:	e8 7f 08 00 00       	call   12f0 <printf>
     a71:	83 c4 0c             	add    $0xc,%esp
     a74:	6a 0e                	push   $0xe
     a76:	68 5c 16 00 00       	push   $0x165c
     a7b:	6a 01                	push   $0x1
     a7d:	e8 6e 08 00 00       	call   12f0 <printf>
     a82:	83 c4 10             	add    $0x10,%esp
     a85:	c9                   	leave  
     a86:	e9 87 07 00 00       	jmp    1212 <kthread_exit>
     a8b:	90                   	nop
     a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a90 <threadStart_15>:
THREAD_START(threadStart_15, 15)
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	83 ec 14             	sub    $0x14,%esp
     a96:	68 b8 0b 00 00       	push   $0xbb8
     a9b:	e8 52 07 00 00       	call   11f2 <sleep>
     aa0:	83 c4 0c             	add    $0xc,%esp
     aa3:	6a 0f                	push   $0xf
     aa5:	68 48 16 00 00       	push   $0x1648
     aaa:	6a 01                	push   $0x1
     aac:	e8 3f 08 00 00       	call   12f0 <printf>
     ab1:	83 c4 0c             	add    $0xc,%esp
     ab4:	6a 0f                	push   $0xf
     ab6:	68 5c 16 00 00       	push   $0x165c
     abb:	6a 01                	push   $0x1
     abd:	e8 2e 08 00 00       	call   12f0 <printf>
     ac2:	83 c4 10             	add    $0x10,%esp
     ac5:	c9                   	leave  
     ac6:	e9 47 07 00 00       	jmp    1212 <kthread_exit>
     acb:	90                   	nop
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ad0 <threadStart_16>:
THREAD_START(threadStart_16, 16)
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	83 ec 14             	sub    $0x14,%esp
     ad6:	68 80 0c 00 00       	push   $0xc80
     adb:	e8 12 07 00 00       	call   11f2 <sleep>
     ae0:	83 c4 0c             	add    $0xc,%esp
     ae3:	6a 10                	push   $0x10
     ae5:	68 48 16 00 00       	push   $0x1648
     aea:	6a 01                	push   $0x1
     aec:	e8 ff 07 00 00       	call   12f0 <printf>
     af1:	83 c4 0c             	add    $0xc,%esp
     af4:	6a 10                	push   $0x10
     af6:	68 5c 16 00 00       	push   $0x165c
     afb:	6a 01                	push   $0x1
     afd:	e8 ee 07 00 00       	call   12f0 <printf>
     b02:	83 c4 10             	add    $0x10,%esp
     b05:	c9                   	leave  
     b06:	e9 07 07 00 00       	jmp    1212 <kthread_exit>
     b0b:	90                   	nop
     b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b10 <threadStart_17>:
THREAD_START(threadStart_17, 17)
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	83 ec 14             	sub    $0x14,%esp
     b16:	68 48 0d 00 00       	push   $0xd48
     b1b:	e8 d2 06 00 00       	call   11f2 <sleep>
     b20:	83 c4 0c             	add    $0xc,%esp
     b23:	6a 11                	push   $0x11
     b25:	68 48 16 00 00       	push   $0x1648
     b2a:	6a 01                	push   $0x1
     b2c:	e8 bf 07 00 00       	call   12f0 <printf>
     b31:	83 c4 0c             	add    $0xc,%esp
     b34:	6a 11                	push   $0x11
     b36:	68 5c 16 00 00       	push   $0x165c
     b3b:	6a 01                	push   $0x1
     b3d:	e8 ae 07 00 00       	call   12f0 <printf>
     b42:	83 c4 10             	add    $0x10,%esp
     b45:	c9                   	leave  
     b46:	e9 c7 06 00 00       	jmp    1212 <kthread_exit>
     b4b:	90                   	nop
     b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b50 <threadStart_18>:
THREAD_START(threadStart_18, 18)
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	83 ec 14             	sub    $0x14,%esp
     b56:	68 10 0e 00 00       	push   $0xe10
     b5b:	e8 92 06 00 00       	call   11f2 <sleep>
     b60:	83 c4 0c             	add    $0xc,%esp
     b63:	6a 12                	push   $0x12
     b65:	68 48 16 00 00       	push   $0x1648
     b6a:	6a 01                	push   $0x1
     b6c:	e8 7f 07 00 00       	call   12f0 <printf>
     b71:	83 c4 0c             	add    $0xc,%esp
     b74:	6a 12                	push   $0x12
     b76:	68 5c 16 00 00       	push   $0x165c
     b7b:	6a 01                	push   $0x1
     b7d:	e8 6e 07 00 00       	call   12f0 <printf>
     b82:	83 c4 10             	add    $0x10,%esp
     b85:	c9                   	leave  
     b86:	e9 87 06 00 00       	jmp    1212 <kthread_exit>
     b8b:	90                   	nop
     b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b90 <threadStart_19>:
THREAD_START(threadStart_19, 19)
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	83 ec 14             	sub    $0x14,%esp
     b96:	68 d8 0e 00 00       	push   $0xed8
     b9b:	e8 52 06 00 00       	call   11f2 <sleep>
     ba0:	83 c4 0c             	add    $0xc,%esp
     ba3:	6a 13                	push   $0x13
     ba5:	68 48 16 00 00       	push   $0x1648
     baa:	6a 01                	push   $0x1
     bac:	e8 3f 07 00 00       	call   12f0 <printf>
     bb1:	83 c4 0c             	add    $0xc,%esp
     bb4:	6a 13                	push   $0x13
     bb6:	68 5c 16 00 00       	push   $0x165c
     bbb:	6a 01                	push   $0x1
     bbd:	e8 2e 07 00 00       	call   12f0 <printf>
     bc2:	83 c4 10             	add    $0x10,%esp
     bc5:	c9                   	leave  
     bc6:	e9 47 06 00 00       	jmp    1212 <kthread_exit>
     bcb:	90                   	nop
     bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000bd0 <threadStart_20>:
THREAD_START(threadStart_20, 20)
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	83 ec 14             	sub    $0x14,%esp
     bd6:	68 a0 0f 00 00       	push   $0xfa0
     bdb:	e8 12 06 00 00       	call   11f2 <sleep>
     be0:	83 c4 0c             	add    $0xc,%esp
     be3:	6a 14                	push   $0x14
     be5:	68 48 16 00 00       	push   $0x1648
     bea:	6a 01                	push   $0x1
     bec:	e8 ff 06 00 00       	call   12f0 <printf>
     bf1:	83 c4 0c             	add    $0xc,%esp
     bf4:	6a 14                	push   $0x14
     bf6:	68 5c 16 00 00       	push   $0x165c
     bfb:	6a 01                	push   $0x1
     bfd:	e8 ee 06 00 00       	call   12f0 <printf>
     c02:	83 c4 10             	add    $0x10,%esp
     c05:	c9                   	leave  
     c06:	e9 07 06 00 00       	jmp    1212 <kthread_exit>
     c0b:	90                   	nop
     c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c10 <threadStart_21>:
THREAD_START(threadStart_21, 21)
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	83 ec 14             	sub    $0x14,%esp
     c16:	68 68 10 00 00       	push   $0x1068
     c1b:	e8 d2 05 00 00       	call   11f2 <sleep>
     c20:	83 c4 0c             	add    $0xc,%esp
     c23:	6a 15                	push   $0x15
     c25:	68 48 16 00 00       	push   $0x1648
     c2a:	6a 01                	push   $0x1
     c2c:	e8 bf 06 00 00       	call   12f0 <printf>
     c31:	83 c4 0c             	add    $0xc,%esp
     c34:	6a 15                	push   $0x15
     c36:	68 5c 16 00 00       	push   $0x165c
     c3b:	6a 01                	push   $0x1
     c3d:	e8 ae 06 00 00       	call   12f0 <printf>
     c42:	83 c4 10             	add    $0x10,%esp
     c45:	c9                   	leave  
     c46:	e9 c7 05 00 00       	jmp    1212 <kthread_exit>
     c4b:	90                   	nop
     c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c50 <threadStart_22>:
THREAD_START(threadStart_22, 22)
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	83 ec 14             	sub    $0x14,%esp
     c56:	68 30 11 00 00       	push   $0x1130
     c5b:	e8 92 05 00 00       	call   11f2 <sleep>
     c60:	83 c4 0c             	add    $0xc,%esp
     c63:	6a 16                	push   $0x16
     c65:	68 48 16 00 00       	push   $0x1648
     c6a:	6a 01                	push   $0x1
     c6c:	e8 7f 06 00 00       	call   12f0 <printf>
     c71:	83 c4 0c             	add    $0xc,%esp
     c74:	6a 16                	push   $0x16
     c76:	68 5c 16 00 00       	push   $0x165c
     c7b:	6a 01                	push   $0x1
     c7d:	e8 6e 06 00 00       	call   12f0 <printf>
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	c9                   	leave  
     c86:	e9 87 05 00 00       	jmp    1212 <kthread_exit>
     c8b:	90                   	nop
     c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c90 <threadStart_23>:
THREAD_START(threadStart_23, 23)
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	83 ec 14             	sub    $0x14,%esp
     c96:	68 f8 11 00 00       	push   $0x11f8
     c9b:	e8 52 05 00 00       	call   11f2 <sleep>
     ca0:	83 c4 0c             	add    $0xc,%esp
     ca3:	6a 17                	push   $0x17
     ca5:	68 48 16 00 00       	push   $0x1648
     caa:	6a 01                	push   $0x1
     cac:	e8 3f 06 00 00       	call   12f0 <printf>
     cb1:	83 c4 0c             	add    $0xc,%esp
     cb4:	6a 17                	push   $0x17
     cb6:	68 5c 16 00 00       	push   $0x165c
     cbb:	6a 01                	push   $0x1
     cbd:	e8 2e 06 00 00       	call   12f0 <printf>
     cc2:	83 c4 10             	add    $0x10,%esp
     cc5:	c9                   	leave  
     cc6:	e9 47 05 00 00       	jmp    1212 <kthread_exit>
     ccb:	90                   	nop
     ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cd0 <threadStart_24>:
THREAD_START(threadStart_24, 24)
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	83 ec 14             	sub    $0x14,%esp
     cd6:	68 c0 12 00 00       	push   $0x12c0
     cdb:	e8 12 05 00 00       	call   11f2 <sleep>
     ce0:	83 c4 0c             	add    $0xc,%esp
     ce3:	6a 18                	push   $0x18
     ce5:	68 48 16 00 00       	push   $0x1648
     cea:	6a 01                	push   $0x1
     cec:	e8 ff 05 00 00       	call   12f0 <printf>
     cf1:	83 c4 0c             	add    $0xc,%esp
     cf4:	6a 18                	push   $0x18
     cf6:	68 5c 16 00 00       	push   $0x165c
     cfb:	6a 01                	push   $0x1
     cfd:	e8 ee 05 00 00       	call   12f0 <printf>
     d02:	83 c4 10             	add    $0x10,%esp
     d05:	c9                   	leave  
     d06:	e9 07 05 00 00       	jmp    1212 <kthread_exit>
     d0b:	90                   	nop
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d10 <threadStart_25>:
THREAD_START(threadStart_25, 25)
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	83 ec 14             	sub    $0x14,%esp
     d16:	68 88 13 00 00       	push   $0x1388
     d1b:	e8 d2 04 00 00       	call   11f2 <sleep>
     d20:	83 c4 0c             	add    $0xc,%esp
     d23:	6a 19                	push   $0x19
     d25:	68 48 16 00 00       	push   $0x1648
     d2a:	6a 01                	push   $0x1
     d2c:	e8 bf 05 00 00       	call   12f0 <printf>
     d31:	83 c4 0c             	add    $0xc,%esp
     d34:	6a 19                	push   $0x19
     d36:	68 5c 16 00 00       	push   $0x165c
     d3b:	6a 01                	push   $0x1
     d3d:	e8 ae 05 00 00       	call   12f0 <printf>
     d42:	83 c4 10             	add    $0x10,%esp
     d45:	c9                   	leave  
     d46:	e9 c7 04 00 00       	jmp    1212 <kthread_exit>
     d4b:	90                   	nop
     d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d50 <threadStart_26>:
THREAD_START(threadStart_26, 26)
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	83 ec 14             	sub    $0x14,%esp
     d56:	68 50 14 00 00       	push   $0x1450
     d5b:	e8 92 04 00 00       	call   11f2 <sleep>
     d60:	83 c4 0c             	add    $0xc,%esp
     d63:	6a 1a                	push   $0x1a
     d65:	68 48 16 00 00       	push   $0x1648
     d6a:	6a 01                	push   $0x1
     d6c:	e8 7f 05 00 00       	call   12f0 <printf>
     d71:	83 c4 0c             	add    $0xc,%esp
     d74:	6a 1a                	push   $0x1a
     d76:	68 5c 16 00 00       	push   $0x165c
     d7b:	6a 01                	push   $0x1
     d7d:	e8 6e 05 00 00       	call   12f0 <printf>
     d82:	83 c4 10             	add    $0x10,%esp
     d85:	c9                   	leave  
     d86:	e9 87 04 00 00       	jmp    1212 <kthread_exit>
     d8b:	90                   	nop
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d90 <threadStart_27>:
THREAD_START(threadStart_27, 27)
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	83 ec 14             	sub    $0x14,%esp
     d96:	68 18 15 00 00       	push   $0x1518
     d9b:	e8 52 04 00 00       	call   11f2 <sleep>
     da0:	83 c4 0c             	add    $0xc,%esp
     da3:	6a 1b                	push   $0x1b
     da5:	68 48 16 00 00       	push   $0x1648
     daa:	6a 01                	push   $0x1
     dac:	e8 3f 05 00 00       	call   12f0 <printf>
     db1:	83 c4 0c             	add    $0xc,%esp
     db4:	6a 1b                	push   $0x1b
     db6:	68 5c 16 00 00       	push   $0x165c
     dbb:	6a 01                	push   $0x1
     dbd:	e8 2e 05 00 00       	call   12f0 <printf>
     dc2:	83 c4 10             	add    $0x10,%esp
     dc5:	c9                   	leave  
     dc6:	e9 47 04 00 00       	jmp    1212 <kthread_exit>
     dcb:	90                   	nop
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000dd0 <threadStart_28>:
THREAD_START(threadStart_28, 28)
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	83 ec 14             	sub    $0x14,%esp
     dd6:	68 e0 15 00 00       	push   $0x15e0
     ddb:	e8 12 04 00 00       	call   11f2 <sleep>
     de0:	83 c4 0c             	add    $0xc,%esp
     de3:	6a 1c                	push   $0x1c
     de5:	68 48 16 00 00       	push   $0x1648
     dea:	6a 01                	push   $0x1
     dec:	e8 ff 04 00 00       	call   12f0 <printf>
     df1:	83 c4 0c             	add    $0xc,%esp
     df4:	6a 1c                	push   $0x1c
     df6:	68 5c 16 00 00       	push   $0x165c
     dfb:	6a 01                	push   $0x1
     dfd:	e8 ee 04 00 00       	call   12f0 <printf>
     e02:	83 c4 10             	add    $0x10,%esp
     e05:	c9                   	leave  
     e06:	e9 07 04 00 00       	jmp    1212 <kthread_exit>
     e0b:	90                   	nop
     e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e10 <threadStart_29>:
THREAD_START(threadStart_29, 29)
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	83 ec 14             	sub    $0x14,%esp
     e16:	68 a8 16 00 00       	push   $0x16a8
     e1b:	e8 d2 03 00 00       	call   11f2 <sleep>
     e20:	83 c4 0c             	add    $0xc,%esp
     e23:	6a 1d                	push   $0x1d
     e25:	68 48 16 00 00       	push   $0x1648
     e2a:	6a 01                	push   $0x1
     e2c:	e8 bf 04 00 00       	call   12f0 <printf>
     e31:	83 c4 0c             	add    $0xc,%esp
     e34:	6a 1d                	push   $0x1d
     e36:	68 5c 16 00 00       	push   $0x165c
     e3b:	6a 01                	push   $0x1
     e3d:	e8 ae 04 00 00       	call   12f0 <printf>
     e42:	83 c4 10             	add    $0x10,%esp
     e45:	c9                   	leave  
     e46:	e9 c7 03 00 00       	jmp    1212 <kthread_exit>
     e4b:	90                   	nop
     e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e50 <threadStart_30>:
THREAD_START(threadStart_30, 30)
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	83 ec 14             	sub    $0x14,%esp
     e56:	68 70 17 00 00       	push   $0x1770
     e5b:	e8 92 03 00 00       	call   11f2 <sleep>
     e60:	83 c4 0c             	add    $0xc,%esp
     e63:	6a 1e                	push   $0x1e
     e65:	68 48 16 00 00       	push   $0x1648
     e6a:	6a 01                	push   $0x1
     e6c:	e8 7f 04 00 00       	call   12f0 <printf>
     e71:	83 c4 0c             	add    $0xc,%esp
     e74:	6a 1e                	push   $0x1e
     e76:	68 5c 16 00 00       	push   $0x165c
     e7b:	6a 01                	push   $0x1
     e7d:	e8 6e 04 00 00       	call   12f0 <printf>
     e82:	83 c4 10             	add    $0x10,%esp
     e85:	c9                   	leave  
     e86:	e9 87 03 00 00       	jmp    1212 <kthread_exit>
     e8b:	90                   	nop
     e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e90 <threadStart_31>:
THREAD_START(threadStart_31, 31)
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	83 ec 14             	sub    $0x14,%esp
     e96:	68 38 18 00 00       	push   $0x1838
     e9b:	e8 52 03 00 00       	call   11f2 <sleep>
     ea0:	83 c4 0c             	add    $0xc,%esp
     ea3:	6a 1f                	push   $0x1f
     ea5:	68 48 16 00 00       	push   $0x1648
     eaa:	6a 01                	push   $0x1
     eac:	e8 3f 04 00 00       	call   12f0 <printf>
     eb1:	83 c4 0c             	add    $0xc,%esp
     eb4:	6a 1f                	push   $0x1f
     eb6:	68 5c 16 00 00       	push   $0x165c
     ebb:	6a 01                	push   $0x1
     ebd:	e8 2e 04 00 00       	call   12f0 <printf>
     ec2:	83 c4 10             	add    $0x10,%esp
     ec5:	c9                   	leave  
     ec6:	e9 47 03 00 00       	jmp    1212 <kthread_exit>
     ecb:	90                   	nop
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ed0 <threadStart_32>:
THREAD_START(threadStart_32, 32)
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	83 ec 14             	sub    $0x14,%esp
     ed6:	68 00 19 00 00       	push   $0x1900
     edb:	e8 12 03 00 00       	call   11f2 <sleep>
     ee0:	83 c4 0c             	add    $0xc,%esp
     ee3:	6a 20                	push   $0x20
     ee5:	68 48 16 00 00       	push   $0x1648
     eea:	6a 01                	push   $0x1
     eec:	e8 ff 03 00 00       	call   12f0 <printf>
     ef1:	83 c4 0c             	add    $0xc,%esp
     ef4:	6a 20                	push   $0x20
     ef6:	68 5c 16 00 00       	push   $0x165c
     efb:	6a 01                	push   $0x1
     efd:	e8 ee 03 00 00       	call   12f0 <printf>
     f02:	83 c4 10             	add    $0x10,%esp
     f05:	c9                   	leave  
     f06:	e9 07 03 00 00       	jmp    1212 <kthread_exit>
     f0b:	66 90                	xchg   %ax,%ax
     f0d:	66 90                	xchg   %ax,%ax
     f0f:	90                   	nop

00000f10 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	53                   	push   %ebx
     f14:	8b 45 08             	mov    0x8(%ebp),%eax
     f17:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f1a:	89 c2                	mov    %eax,%edx
     f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f20:	83 c1 01             	add    $0x1,%ecx
     f23:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     f27:	83 c2 01             	add    $0x1,%edx
     f2a:	84 db                	test   %bl,%bl
     f2c:	88 5a ff             	mov    %bl,-0x1(%edx)
     f2f:	75 ef                	jne    f20 <strcpy+0x10>
    ;
  return os;
}
     f31:	5b                   	pop    %ebx
     f32:	5d                   	pop    %ebp
     f33:	c3                   	ret    
     f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000f40 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	53                   	push   %ebx
     f44:	8b 55 08             	mov    0x8(%ebp),%edx
     f47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     f4a:	0f b6 02             	movzbl (%edx),%eax
     f4d:	0f b6 19             	movzbl (%ecx),%ebx
     f50:	84 c0                	test   %al,%al
     f52:	75 1c                	jne    f70 <strcmp+0x30>
     f54:	eb 2a                	jmp    f80 <strcmp+0x40>
     f56:	8d 76 00             	lea    0x0(%esi),%esi
     f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     f60:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     f63:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     f66:	83 c1 01             	add    $0x1,%ecx
     f69:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     f6c:	84 c0                	test   %al,%al
     f6e:	74 10                	je     f80 <strcmp+0x40>
     f70:	38 d8                	cmp    %bl,%al
     f72:	74 ec                	je     f60 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     f74:	29 d8                	sub    %ebx,%eax
}
     f76:	5b                   	pop    %ebx
     f77:	5d                   	pop    %ebp
     f78:	c3                   	ret    
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f80:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     f82:	29 d8                	sub    %ebx,%eax
}
     f84:	5b                   	pop    %ebx
     f85:	5d                   	pop    %ebp
     f86:	c3                   	ret    
     f87:	89 f6                	mov    %esi,%esi
     f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f90 <strlen>:

uint
strlen(const char *s)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     f96:	80 39 00             	cmpb   $0x0,(%ecx)
     f99:	74 15                	je     fb0 <strlen+0x20>
     f9b:	31 d2                	xor    %edx,%edx
     f9d:	8d 76 00             	lea    0x0(%esi),%esi
     fa0:	83 c2 01             	add    $0x1,%edx
     fa3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     fa7:	89 d0                	mov    %edx,%eax
     fa9:	75 f5                	jne    fa0 <strlen+0x10>
    ;
  return n;
}
     fab:	5d                   	pop    %ebp
     fac:	c3                   	ret    
     fad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     fb0:	31 c0                	xor    %eax,%eax
}
     fb2:	5d                   	pop    %ebp
     fb3:	c3                   	ret    
     fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fc0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	57                   	push   %edi
     fc4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     fc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fca:	8b 45 0c             	mov    0xc(%ebp),%eax
     fcd:	89 d7                	mov    %edx,%edi
     fcf:	fc                   	cld    
     fd0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     fd2:	89 d0                	mov    %edx,%eax
     fd4:	5f                   	pop    %edi
     fd5:	5d                   	pop    %ebp
     fd6:	c3                   	ret    
     fd7:	89 f6                	mov    %esi,%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fe0 <strchr>:

char*
strchr(const char *s, char c)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	53                   	push   %ebx
     fe4:	8b 45 08             	mov    0x8(%ebp),%eax
     fe7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     fea:	0f b6 10             	movzbl (%eax),%edx
     fed:	84 d2                	test   %dl,%dl
     fef:	74 1d                	je     100e <strchr+0x2e>
    if(*s == c)
     ff1:	38 d3                	cmp    %dl,%bl
     ff3:	89 d9                	mov    %ebx,%ecx
     ff5:	75 0d                	jne    1004 <strchr+0x24>
     ff7:	eb 17                	jmp    1010 <strchr+0x30>
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1000:	38 ca                	cmp    %cl,%dl
    1002:	74 0c                	je     1010 <strchr+0x30>
  for(; *s; s++)
    1004:	83 c0 01             	add    $0x1,%eax
    1007:	0f b6 10             	movzbl (%eax),%edx
    100a:	84 d2                	test   %dl,%dl
    100c:	75 f2                	jne    1000 <strchr+0x20>
      return (char*)s;
  return 0;
    100e:	31 c0                	xor    %eax,%eax
}
    1010:	5b                   	pop    %ebx
    1011:	5d                   	pop    %ebp
    1012:	c3                   	ret    
    1013:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001020 <gets>:

char*
gets(char *buf, int max)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
    1025:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1026:	31 f6                	xor    %esi,%esi
    1028:	89 f3                	mov    %esi,%ebx
{
    102a:	83 ec 1c             	sub    $0x1c,%esp
    102d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1030:	eb 2f                	jmp    1061 <gets+0x41>
    1032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1038:	8d 45 e7             	lea    -0x19(%ebp),%eax
    103b:	83 ec 04             	sub    $0x4,%esp
    103e:	6a 01                	push   $0x1
    1040:	50                   	push   %eax
    1041:	6a 00                	push   $0x0
    1043:	e8 32 01 00 00       	call   117a <read>
    if(cc < 1)
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	85 c0                	test   %eax,%eax
    104d:	7e 1c                	jle    106b <gets+0x4b>
      break;
    buf[i++] = c;
    104f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1053:	83 c7 01             	add    $0x1,%edi
    1056:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1059:	3c 0a                	cmp    $0xa,%al
    105b:	74 23                	je     1080 <gets+0x60>
    105d:	3c 0d                	cmp    $0xd,%al
    105f:	74 1f                	je     1080 <gets+0x60>
  for(i=0; i+1 < max; ){
    1061:	83 c3 01             	add    $0x1,%ebx
    1064:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1067:	89 fe                	mov    %edi,%esi
    1069:	7c cd                	jl     1038 <gets+0x18>
    106b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    106d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1070:	c6 03 00             	movb   $0x0,(%ebx)
}
    1073:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1076:	5b                   	pop    %ebx
    1077:	5e                   	pop    %esi
    1078:	5f                   	pop    %edi
    1079:	5d                   	pop    %ebp
    107a:	c3                   	ret    
    107b:	90                   	nop
    107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1080:	8b 75 08             	mov    0x8(%ebp),%esi
    1083:	8b 45 08             	mov    0x8(%ebp),%eax
    1086:	01 de                	add    %ebx,%esi
    1088:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    108a:	c6 03 00             	movb   $0x0,(%ebx)
}
    108d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1090:	5b                   	pop    %ebx
    1091:	5e                   	pop    %esi
    1092:	5f                   	pop    %edi
    1093:	5d                   	pop    %ebp
    1094:	c3                   	ret    
    1095:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010a0 <stat>:

int
stat(const char *n, struct stat *st)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	56                   	push   %esi
    10a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10a5:	83 ec 08             	sub    $0x8,%esp
    10a8:	6a 00                	push   $0x0
    10aa:	ff 75 08             	pushl  0x8(%ebp)
    10ad:	e8 f0 00 00 00       	call   11a2 <open>
  if(fd < 0)
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	85 c0                	test   %eax,%eax
    10b7:	78 27                	js     10e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    10b9:	83 ec 08             	sub    $0x8,%esp
    10bc:	ff 75 0c             	pushl  0xc(%ebp)
    10bf:	89 c3                	mov    %eax,%ebx
    10c1:	50                   	push   %eax
    10c2:	e8 f3 00 00 00       	call   11ba <fstat>
  close(fd);
    10c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    10ca:	89 c6                	mov    %eax,%esi
  close(fd);
    10cc:	e8 b9 00 00 00       	call   118a <close>
  return r;
    10d1:	83 c4 10             	add    $0x10,%esp
}
    10d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10d7:	89 f0                	mov    %esi,%eax
    10d9:	5b                   	pop    %ebx
    10da:	5e                   	pop    %esi
    10db:	5d                   	pop    %ebp
    10dc:	c3                   	ret    
    10dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    10e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    10e5:	eb ed                	jmp    10d4 <stat+0x34>
    10e7:	89 f6                	mov    %esi,%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <atoi>:

int
atoi(const char *s)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	53                   	push   %ebx
    10f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    10f7:	0f be 11             	movsbl (%ecx),%edx
    10fa:	8d 42 d0             	lea    -0x30(%edx),%eax
    10fd:	3c 09                	cmp    $0x9,%al
  n = 0;
    10ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1104:	77 1f                	ja     1125 <atoi+0x35>
    1106:	8d 76 00             	lea    0x0(%esi),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1110:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1113:	83 c1 01             	add    $0x1,%ecx
    1116:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    111a:	0f be 11             	movsbl (%ecx),%edx
    111d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1120:	80 fb 09             	cmp    $0x9,%bl
    1123:	76 eb                	jbe    1110 <atoi+0x20>
  return n;
}
    1125:	5b                   	pop    %ebx
    1126:	5d                   	pop    %ebp
    1127:	c3                   	ret    
    1128:	90                   	nop
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001130 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	56                   	push   %esi
    1134:	53                   	push   %ebx
    1135:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1138:	8b 45 08             	mov    0x8(%ebp),%eax
    113b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    113e:	85 db                	test   %ebx,%ebx
    1140:	7e 14                	jle    1156 <memmove+0x26>
    1142:	31 d2                	xor    %edx,%edx
    1144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1148:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    114c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    114f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1152:	39 d3                	cmp    %edx,%ebx
    1154:	75 f2                	jne    1148 <memmove+0x18>
  return vdst;
}
    1156:	5b                   	pop    %ebx
    1157:	5e                   	pop    %esi
    1158:	5d                   	pop    %ebp
    1159:	c3                   	ret    

0000115a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    115a:	b8 01 00 00 00       	mov    $0x1,%eax
    115f:	cd 40                	int    $0x40
    1161:	c3                   	ret    

00001162 <exit>:
SYSCALL(exit)
    1162:	b8 02 00 00 00       	mov    $0x2,%eax
    1167:	cd 40                	int    $0x40
    1169:	c3                   	ret    

0000116a <wait>:
SYSCALL(wait)
    116a:	b8 03 00 00 00       	mov    $0x3,%eax
    116f:	cd 40                	int    $0x40
    1171:	c3                   	ret    

00001172 <pipe>:
SYSCALL(pipe)
    1172:	b8 04 00 00 00       	mov    $0x4,%eax
    1177:	cd 40                	int    $0x40
    1179:	c3                   	ret    

0000117a <read>:
SYSCALL(read)
    117a:	b8 05 00 00 00       	mov    $0x5,%eax
    117f:	cd 40                	int    $0x40
    1181:	c3                   	ret    

00001182 <write>:
SYSCALL(write)
    1182:	b8 10 00 00 00       	mov    $0x10,%eax
    1187:	cd 40                	int    $0x40
    1189:	c3                   	ret    

0000118a <close>:
SYSCALL(close)
    118a:	b8 15 00 00 00       	mov    $0x15,%eax
    118f:	cd 40                	int    $0x40
    1191:	c3                   	ret    

00001192 <kill>:
SYSCALL(kill)
    1192:	b8 06 00 00 00       	mov    $0x6,%eax
    1197:	cd 40                	int    $0x40
    1199:	c3                   	ret    

0000119a <exec>:
SYSCALL(exec)
    119a:	b8 07 00 00 00       	mov    $0x7,%eax
    119f:	cd 40                	int    $0x40
    11a1:	c3                   	ret    

000011a2 <open>:
SYSCALL(open)
    11a2:	b8 0f 00 00 00       	mov    $0xf,%eax
    11a7:	cd 40                	int    $0x40
    11a9:	c3                   	ret    

000011aa <mknod>:
SYSCALL(mknod)
    11aa:	b8 11 00 00 00       	mov    $0x11,%eax
    11af:	cd 40                	int    $0x40
    11b1:	c3                   	ret    

000011b2 <unlink>:
SYSCALL(unlink)
    11b2:	b8 12 00 00 00       	mov    $0x12,%eax
    11b7:	cd 40                	int    $0x40
    11b9:	c3                   	ret    

000011ba <fstat>:
SYSCALL(fstat)
    11ba:	b8 08 00 00 00       	mov    $0x8,%eax
    11bf:	cd 40                	int    $0x40
    11c1:	c3                   	ret    

000011c2 <link>:
SYSCALL(link)
    11c2:	b8 13 00 00 00       	mov    $0x13,%eax
    11c7:	cd 40                	int    $0x40
    11c9:	c3                   	ret    

000011ca <mkdir>:
SYSCALL(mkdir)
    11ca:	b8 14 00 00 00       	mov    $0x14,%eax
    11cf:	cd 40                	int    $0x40
    11d1:	c3                   	ret    

000011d2 <chdir>:
SYSCALL(chdir)
    11d2:	b8 09 00 00 00       	mov    $0x9,%eax
    11d7:	cd 40                	int    $0x40
    11d9:	c3                   	ret    

000011da <dup>:
SYSCALL(dup)
    11da:	b8 0a 00 00 00       	mov    $0xa,%eax
    11df:	cd 40                	int    $0x40
    11e1:	c3                   	ret    

000011e2 <getpid>:
SYSCALL(getpid)
    11e2:	b8 0b 00 00 00       	mov    $0xb,%eax
    11e7:	cd 40                	int    $0x40
    11e9:	c3                   	ret    

000011ea <sbrk>:
SYSCALL(sbrk)
    11ea:	b8 0c 00 00 00       	mov    $0xc,%eax
    11ef:	cd 40                	int    $0x40
    11f1:	c3                   	ret    

000011f2 <sleep>:
SYSCALL(sleep)
    11f2:	b8 0d 00 00 00       	mov    $0xd,%eax
    11f7:	cd 40                	int    $0x40
    11f9:	c3                   	ret    

000011fa <uptime>:
SYSCALL(uptime)
    11fa:	b8 0e 00 00 00       	mov    $0xe,%eax
    11ff:	cd 40                	int    $0x40
    1201:	c3                   	ret    

00001202 <kthread_create>:
SYSCALL(kthread_create)
    1202:	b8 16 00 00 00       	mov    $0x16,%eax
    1207:	cd 40                	int    $0x40
    1209:	c3                   	ret    

0000120a <kthread_id>:
SYSCALL(kthread_id)
    120a:	b8 17 00 00 00       	mov    $0x17,%eax
    120f:	cd 40                	int    $0x40
    1211:	c3                   	ret    

00001212 <kthread_exit>:
SYSCALL(kthread_exit)
    1212:	b8 18 00 00 00       	mov    $0x18,%eax
    1217:	cd 40                	int    $0x40
    1219:	c3                   	ret    

0000121a <kthread_join>:
SYSCALL(kthread_join)
    121a:	b8 19 00 00 00       	mov    $0x19,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
    1222:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
    122a:	b8 1b 00 00 00       	mov    $0x1b,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
    1232:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
    123a:	b8 1d 00 00 00       	mov    $0x1d,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    
    1242:	66 90                	xchg   %ax,%ax
    1244:	66 90                	xchg   %ax,%ax
    1246:	66 90                	xchg   %ax,%ax
    1248:	66 90                	xchg   %ax,%ax
    124a:	66 90                	xchg   %ax,%ax
    124c:	66 90                	xchg   %ax,%ax
    124e:	66 90                	xchg   %ax,%ax

00001250 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	57                   	push   %edi
    1254:	56                   	push   %esi
    1255:	53                   	push   %ebx
    1256:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1259:	85 d2                	test   %edx,%edx
{
    125b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    125e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1260:	79 76                	jns    12d8 <printint+0x88>
    1262:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1266:	74 70                	je     12d8 <printint+0x88>
    x = -xx;
    1268:	f7 d8                	neg    %eax
    neg = 1;
    126a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1271:	31 f6                	xor    %esi,%esi
    1273:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1276:	eb 0a                	jmp    1282 <printint+0x32>
    1278:	90                   	nop
    1279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1280:	89 fe                	mov    %edi,%esi
    1282:	31 d2                	xor    %edx,%edx
    1284:	8d 7e 01             	lea    0x1(%esi),%edi
    1287:	f7 f1                	div    %ecx
    1289:	0f b6 92 e8 17 00 00 	movzbl 0x17e8(%edx),%edx
  }while((x /= base) != 0);
    1290:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1292:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1295:	75 e9                	jne    1280 <printint+0x30>
  if(neg)
    1297:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    129a:	85 c0                	test   %eax,%eax
    129c:	74 08                	je     12a6 <printint+0x56>
    buf[i++] = '-';
    129e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    12a3:	8d 7e 02             	lea    0x2(%esi),%edi
    12a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    12aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
    12ad:	8d 76 00             	lea    0x0(%esi),%esi
    12b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    12b3:	83 ec 04             	sub    $0x4,%esp
    12b6:	83 ee 01             	sub    $0x1,%esi
    12b9:	6a 01                	push   $0x1
    12bb:	53                   	push   %ebx
    12bc:	57                   	push   %edi
    12bd:	88 45 d7             	mov    %al,-0x29(%ebp)
    12c0:	e8 bd fe ff ff       	call   1182 <write>

  while(--i >= 0)
    12c5:	83 c4 10             	add    $0x10,%esp
    12c8:	39 de                	cmp    %ebx,%esi
    12ca:	75 e4                	jne    12b0 <printint+0x60>
    putc(fd, buf[i]);
}
    12cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12cf:	5b                   	pop    %ebx
    12d0:	5e                   	pop    %esi
    12d1:	5f                   	pop    %edi
    12d2:	5d                   	pop    %ebp
    12d3:	c3                   	ret    
    12d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    12d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    12df:	eb 90                	jmp    1271 <printint+0x21>
    12e1:	eb 0d                	jmp    12f0 <printf>
    12e3:	90                   	nop
    12e4:	90                   	nop
    12e5:	90                   	nop
    12e6:	90                   	nop
    12e7:	90                   	nop
    12e8:	90                   	nop
    12e9:	90                   	nop
    12ea:	90                   	nop
    12eb:	90                   	nop
    12ec:	90                   	nop
    12ed:	90                   	nop
    12ee:	90                   	nop
    12ef:	90                   	nop

000012f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	57                   	push   %edi
    12f4:	56                   	push   %esi
    12f5:	53                   	push   %ebx
    12f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12f9:	8b 75 0c             	mov    0xc(%ebp),%esi
    12fc:	0f b6 1e             	movzbl (%esi),%ebx
    12ff:	84 db                	test   %bl,%bl
    1301:	0f 84 b3 00 00 00    	je     13ba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1307:	8d 45 10             	lea    0x10(%ebp),%eax
    130a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    130d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    130f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1312:	eb 2f                	jmp    1343 <printf+0x53>
    1314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1318:	83 f8 25             	cmp    $0x25,%eax
    131b:	0f 84 a7 00 00 00    	je     13c8 <printf+0xd8>
  write(fd, &c, 1);
    1321:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1324:	83 ec 04             	sub    $0x4,%esp
    1327:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    132a:	6a 01                	push   $0x1
    132c:	50                   	push   %eax
    132d:	ff 75 08             	pushl  0x8(%ebp)
    1330:	e8 4d fe ff ff       	call   1182 <write>
    1335:	83 c4 10             	add    $0x10,%esp
    1338:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    133b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    133f:	84 db                	test   %bl,%bl
    1341:	74 77                	je     13ba <printf+0xca>
    if(state == 0){
    1343:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1345:	0f be cb             	movsbl %bl,%ecx
    1348:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    134b:	74 cb                	je     1318 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    134d:	83 ff 25             	cmp    $0x25,%edi
    1350:	75 e6                	jne    1338 <printf+0x48>
      if(c == 'd'){
    1352:	83 f8 64             	cmp    $0x64,%eax
    1355:	0f 84 05 01 00 00    	je     1460 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    135b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1361:	83 f9 70             	cmp    $0x70,%ecx
    1364:	74 72                	je     13d8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1366:	83 f8 73             	cmp    $0x73,%eax
    1369:	0f 84 99 00 00 00    	je     1408 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    136f:	83 f8 63             	cmp    $0x63,%eax
    1372:	0f 84 08 01 00 00    	je     1480 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1378:	83 f8 25             	cmp    $0x25,%eax
    137b:	0f 84 ef 00 00 00    	je     1470 <printf+0x180>
  write(fd, &c, 1);
    1381:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1384:	83 ec 04             	sub    $0x4,%esp
    1387:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    138b:	6a 01                	push   $0x1
    138d:	50                   	push   %eax
    138e:	ff 75 08             	pushl  0x8(%ebp)
    1391:	e8 ec fd ff ff       	call   1182 <write>
    1396:	83 c4 0c             	add    $0xc,%esp
    1399:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    139c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    139f:	6a 01                	push   $0x1
    13a1:	50                   	push   %eax
    13a2:	ff 75 08             	pushl  0x8(%ebp)
    13a5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13a8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    13aa:	e8 d3 fd ff ff       	call   1182 <write>
  for(i = 0; fmt[i]; i++){
    13af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    13b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    13b6:	84 db                	test   %bl,%bl
    13b8:	75 89                	jne    1343 <printf+0x53>
    }
  }
}
    13ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13bd:	5b                   	pop    %ebx
    13be:	5e                   	pop    %esi
    13bf:	5f                   	pop    %edi
    13c0:	5d                   	pop    %ebp
    13c1:	c3                   	ret    
    13c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    13c8:	bf 25 00 00 00       	mov    $0x25,%edi
    13cd:	e9 66 ff ff ff       	jmp    1338 <printf+0x48>
    13d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    13d8:	83 ec 0c             	sub    $0xc,%esp
    13db:	b9 10 00 00 00       	mov    $0x10,%ecx
    13e0:	6a 00                	push   $0x0
    13e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    13e5:	8b 45 08             	mov    0x8(%ebp),%eax
    13e8:	8b 17                	mov    (%edi),%edx
    13ea:	e8 61 fe ff ff       	call   1250 <printint>
        ap++;
    13ef:	89 f8                	mov    %edi,%eax
    13f1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    13f4:	31 ff                	xor    %edi,%edi
        ap++;
    13f6:	83 c0 04             	add    $0x4,%eax
    13f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    13fc:	e9 37 ff ff ff       	jmp    1338 <printf+0x48>
    1401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1408:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    140b:	8b 08                	mov    (%eax),%ecx
        ap++;
    140d:	83 c0 04             	add    $0x4,%eax
    1410:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1413:	85 c9                	test   %ecx,%ecx
    1415:	0f 84 8e 00 00 00    	je     14a9 <printf+0x1b9>
        while(*s != 0){
    141b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    141e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1420:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1422:	84 c0                	test   %al,%al
    1424:	0f 84 0e ff ff ff    	je     1338 <printf+0x48>
    142a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    142d:	89 de                	mov    %ebx,%esi
    142f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1432:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1435:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1438:	83 ec 04             	sub    $0x4,%esp
          s++;
    143b:	83 c6 01             	add    $0x1,%esi
    143e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1441:	6a 01                	push   $0x1
    1443:	57                   	push   %edi
    1444:	53                   	push   %ebx
    1445:	e8 38 fd ff ff       	call   1182 <write>
        while(*s != 0){
    144a:	0f b6 06             	movzbl (%esi),%eax
    144d:	83 c4 10             	add    $0x10,%esp
    1450:	84 c0                	test   %al,%al
    1452:	75 e4                	jne    1438 <printf+0x148>
    1454:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1457:	31 ff                	xor    %edi,%edi
    1459:	e9 da fe ff ff       	jmp    1338 <printf+0x48>
    145e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1460:	83 ec 0c             	sub    $0xc,%esp
    1463:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1468:	6a 01                	push   $0x1
    146a:	e9 73 ff ff ff       	jmp    13e2 <printf+0xf2>
    146f:	90                   	nop
  write(fd, &c, 1);
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1476:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1479:	6a 01                	push   $0x1
    147b:	e9 21 ff ff ff       	jmp    13a1 <printf+0xb1>
        putc(fd, *ap);
    1480:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1483:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1486:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1488:	6a 01                	push   $0x1
        ap++;
    148a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    148d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1490:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1493:	50                   	push   %eax
    1494:	ff 75 08             	pushl  0x8(%ebp)
    1497:	e8 e6 fc ff ff       	call   1182 <write>
        ap++;
    149c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    149f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    14a2:	31 ff                	xor    %edi,%edi
    14a4:	e9 8f fe ff ff       	jmp    1338 <printf+0x48>
          s = "(null)";
    14a9:	bb e0 17 00 00       	mov    $0x17e0,%ebx
        while(*s != 0){
    14ae:	b8 28 00 00 00       	mov    $0x28,%eax
    14b3:	e9 72 ff ff ff       	jmp    142a <printf+0x13a>
    14b8:	66 90                	xchg   %ax,%ax
    14ba:	66 90                	xchg   %ax,%ax
    14bc:	66 90                	xchg   %ax,%ax
    14be:	66 90                	xchg   %ax,%ax

000014c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c1:	a1 20 1f 00 00       	mov    0x1f20,%eax
{
    14c6:	89 e5                	mov    %esp,%ebp
    14c8:	57                   	push   %edi
    14c9:	56                   	push   %esi
    14ca:	53                   	push   %ebx
    14cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    14ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    14d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d8:	39 c8                	cmp    %ecx,%eax
    14da:	8b 10                	mov    (%eax),%edx
    14dc:	73 32                	jae    1510 <free+0x50>
    14de:	39 d1                	cmp    %edx,%ecx
    14e0:	72 04                	jb     14e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14e2:	39 d0                	cmp    %edx,%eax
    14e4:	72 32                	jb     1518 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14ec:	39 fa                	cmp    %edi,%edx
    14ee:	74 30                	je     1520 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14f3:	8b 50 04             	mov    0x4(%eax),%edx
    14f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14f9:	39 f1                	cmp    %esi,%ecx
    14fb:	74 3a                	je     1537 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    14ff:	a3 20 1f 00 00       	mov    %eax,0x1f20
}
    1504:	5b                   	pop    %ebx
    1505:	5e                   	pop    %esi
    1506:	5f                   	pop    %edi
    1507:	5d                   	pop    %ebp
    1508:	c3                   	ret    
    1509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1510:	39 d0                	cmp    %edx,%eax
    1512:	72 04                	jb     1518 <free+0x58>
    1514:	39 d1                	cmp    %edx,%ecx
    1516:	72 ce                	jb     14e6 <free+0x26>
{
    1518:	89 d0                	mov    %edx,%eax
    151a:	eb bc                	jmp    14d8 <free+0x18>
    151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1520:	03 72 04             	add    0x4(%edx),%esi
    1523:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1526:	8b 10                	mov    (%eax),%edx
    1528:	8b 12                	mov    (%edx),%edx
    152a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    152d:	8b 50 04             	mov    0x4(%eax),%edx
    1530:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1533:	39 f1                	cmp    %esi,%ecx
    1535:	75 c6                	jne    14fd <free+0x3d>
    p->s.size += bp->s.size;
    1537:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    153a:	a3 20 1f 00 00       	mov    %eax,0x1f20
    p->s.size += bp->s.size;
    153f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1542:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1545:	89 10                	mov    %edx,(%eax)
}
    1547:	5b                   	pop    %ebx
    1548:	5e                   	pop    %esi
    1549:	5f                   	pop    %edi
    154a:	5d                   	pop    %ebp
    154b:	c3                   	ret    
    154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001550 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	57                   	push   %edi
    1554:	56                   	push   %esi
    1555:	53                   	push   %ebx
    1556:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1559:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    155c:	8b 15 20 1f 00 00    	mov    0x1f20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1562:	8d 78 07             	lea    0x7(%eax),%edi
    1565:	c1 ef 03             	shr    $0x3,%edi
    1568:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    156b:	85 d2                	test   %edx,%edx
    156d:	0f 84 9d 00 00 00    	je     1610 <malloc+0xc0>
    1573:	8b 02                	mov    (%edx),%eax
    1575:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1578:	39 cf                	cmp    %ecx,%edi
    157a:	76 6c                	jbe    15e8 <malloc+0x98>
    157c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1582:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1587:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    158a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1591:	eb 0e                	jmp    15a1 <malloc+0x51>
    1593:	90                   	nop
    1594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1598:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    159a:	8b 48 04             	mov    0x4(%eax),%ecx
    159d:	39 f9                	cmp    %edi,%ecx
    159f:	73 47                	jae    15e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    15a1:	39 05 20 1f 00 00    	cmp    %eax,0x1f20
    15a7:	89 c2                	mov    %eax,%edx
    15a9:	75 ed                	jne    1598 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    15ab:	83 ec 0c             	sub    $0xc,%esp
    15ae:	56                   	push   %esi
    15af:	e8 36 fc ff ff       	call   11ea <sbrk>
  if(p == (char*)-1)
    15b4:	83 c4 10             	add    $0x10,%esp
    15b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    15ba:	74 1c                	je     15d8 <malloc+0x88>
  hp->s.size = nu;
    15bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15bf:	83 ec 0c             	sub    $0xc,%esp
    15c2:	83 c0 08             	add    $0x8,%eax
    15c5:	50                   	push   %eax
    15c6:	e8 f5 fe ff ff       	call   14c0 <free>
  return freep;
    15cb:	8b 15 20 1f 00 00    	mov    0x1f20,%edx
      if((p = morecore(nunits)) == 0)
    15d1:	83 c4 10             	add    $0x10,%esp
    15d4:	85 d2                	test   %edx,%edx
    15d6:	75 c0                	jne    1598 <malloc+0x48>
        return 0;
  }
}
    15d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    15db:	31 c0                	xor    %eax,%eax
}
    15dd:	5b                   	pop    %ebx
    15de:	5e                   	pop    %esi
    15df:	5f                   	pop    %edi
    15e0:	5d                   	pop    %ebp
    15e1:	c3                   	ret    
    15e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    15e8:	39 cf                	cmp    %ecx,%edi
    15ea:	74 54                	je     1640 <malloc+0xf0>
        p->s.size -= nunits;
    15ec:	29 f9                	sub    %edi,%ecx
    15ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    15f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    15f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    15f7:	89 15 20 1f 00 00    	mov    %edx,0x1f20
}
    15fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1600:	83 c0 08             	add    $0x8,%eax
}
    1603:	5b                   	pop    %ebx
    1604:	5e                   	pop    %esi
    1605:	5f                   	pop    %edi
    1606:	5d                   	pop    %ebp
    1607:	c3                   	ret    
    1608:	90                   	nop
    1609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1610:	c7 05 20 1f 00 00 24 	movl   $0x1f24,0x1f20
    1617:	1f 00 00 
    161a:	c7 05 24 1f 00 00 24 	movl   $0x1f24,0x1f24
    1621:	1f 00 00 
    base.s.size = 0;
    1624:	b8 24 1f 00 00       	mov    $0x1f24,%eax
    1629:	c7 05 28 1f 00 00 00 	movl   $0x0,0x1f28
    1630:	00 00 00 
    1633:	e9 44 ff ff ff       	jmp    157c <malloc+0x2c>
    1638:	90                   	nop
    1639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1640:	8b 08                	mov    (%eax),%ecx
    1642:	89 0a                	mov    %ecx,(%edx)
    1644:	eb b1                	jmp    15f7 <malloc+0xa7>
