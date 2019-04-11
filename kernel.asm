
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c0 2e 10 80       	mov    $0x80102ec0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 70 10 80       	push   $0x801070e0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 c5 43 00 00       	call   80104420 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 70 10 80       	push   $0x801070e7
80100097:	50                   	push   %eax
80100098:	e8 53 42 00 00       	call   801042f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 77 44 00 00       	call   80104560 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 b9 44 00 00       	call   80104620 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 41 00 00       	call   80104330 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 bd 1f 00 00       	call   80102140 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ee 70 10 80       	push   $0x801070ee
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 1d 42 00 00       	call   801043d0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 77 1f 00 00       	jmp    80102140 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 ff 70 10 80       	push   $0x801070ff
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 dc 41 00 00       	call   801043d0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 41 00 00       	call   80104390 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 50 43 00 00       	call   80104560 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 bf 43 00 00       	jmp    80104620 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 71 10 80       	push   $0x80107106
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 fb 14 00 00       	call   80101780 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 cf 42 00 00       	call   80104560 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 c6 3c 00 00       	call   80103f90 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 70 35 00 00       	call   80103850 <myproc>
801002e0:	8b 40 1c             	mov    0x1c(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 2c 43 00 00       	call   80104620 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 a4 13 00 00       	call   801016a0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 ce 42 00 00       	call   80104620 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 46 13 00 00       	call   801016a0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 a2 23 00 00       	call   80102750 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 0d 71 10 80       	push   $0x8010710d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 57 7a 10 80 	movl   $0x80107a57,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 40 00 00       	call   80104440 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 21 71 10 80       	push   $0x80107121
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 b1 58 00 00       	call   80105cf0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 ff 57 00 00       	call   80105cf0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 f3 57 00 00       	call   80105cf0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 e7 57 00 00       	call   80105cf0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 f7 41 00 00       	call   80104720 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 2a 41 00 00       	call   80104670 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 25 71 10 80       	push   $0x80107125
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 50 71 10 80 	movzbl -0x7fef8eb0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 6c 11 00 00       	call   80101780 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 40 3f 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 d4 3f 00 00       	call   80104620 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 4b 10 00 00       	call   801016a0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 fc 3e 00 00       	call   80104620 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 38 71 10 80       	mov    $0x80107138,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 6b 3d 00 00       	call   80104560 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 3f 71 10 80       	push   $0x8010713f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 38 3d 00 00       	call   80104560 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100856:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 93 3d 00 00       	call   80104620 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100911:	68 a0 ff 10 80       	push   $0x8010ffa0
80100916:	e8 25 38 00 00       	call   80104140 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010093d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100964:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 a4 38 00 00       	jmp    80104240 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 48 71 10 80       	push   $0x80107148
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 4b 3a 00 00       	call   80104420 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 f2 18 00 00       	call   801022f0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "elf.h"
#include "kthread.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 2f 2e 00 00       	call   80103850 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  struct kthread *curthread = mythread();
80100a27:	e8 54 2e 00 00       	call   80103880 <mythread>
80100a2c:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)

  begin_op();
80100a32:	e8 89 21 00 00       	call   80102bc0 <begin_op>

  if((ip = namei(path)) == 0){
80100a37:	83 ec 0c             	sub    $0xc,%esp
80100a3a:	ff 75 08             	pushl  0x8(%ebp)
80100a3d:	e8 be 14 00 00       	call   80101f00 <namei>
80100a42:	83 c4 10             	add    $0x10,%esp
80100a45:	85 c0                	test   %eax,%eax
80100a47:	0f 84 8e 01 00 00    	je     80100bdb <exec+0x1cb>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a4d:	83 ec 0c             	sub    $0xc,%esp
80100a50:	89 c3                	mov    %eax,%ebx
80100a52:	50                   	push   %eax
80100a53:	e8 48 0c 00 00       	call   801016a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a58:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a5e:	6a 34                	push   $0x34
80100a60:	6a 00                	push   $0x0
80100a62:	50                   	push   %eax
80100a63:	53                   	push   %ebx
80100a64:	e8 17 0f 00 00       	call   80101980 <readi>
80100a69:	83 c4 20             	add    $0x20,%esp
80100a6c:	83 f8 34             	cmp    $0x34,%eax
80100a6f:	74 1f                	je     80100a90 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a71:	83 ec 0c             	sub    $0xc,%esp
80100a74:	53                   	push   %ebx
80100a75:	e8 b6 0e 00 00       	call   80101930 <iunlockput>
    end_op();
80100a7a:	e8 b1 21 00 00       	call   80102c30 <end_op>
80100a7f:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a8a:	5b                   	pop    %ebx
80100a8b:	5e                   	pop    %esi
80100a8c:	5f                   	pop    %edi
80100a8d:	5d                   	pop    %ebp
80100a8e:	c3                   	ret    
80100a8f:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100a90:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a97:	45 4c 46 
80100a9a:	75 d5                	jne    80100a71 <exec+0x61>
  if((pgdir = setupkvm()) == 0)
80100a9c:	e8 9f 63 00 00       	call   80106e40 <setupkvm>
80100aa1:	85 c0                	test   %eax,%eax
80100aa3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100aa9:	74 c6                	je     80100a71 <exec+0x61>
  sz = 0;
80100aab:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aad:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ab4:	00 
80100ab5:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100abb:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100ac1:	0f 84 90 02 00 00    	je     80100d57 <exec+0x347>
80100ac7:	31 f6                	xor    %esi,%esi
80100ac9:	eb 7f                	jmp    80100b4a <exec+0x13a>
80100acb:	90                   	nop
80100acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ad0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ad7:	75 63                	jne    80100b3c <exec+0x12c>
    if(ph.memsz < ph.filesz)
80100ad9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100adf:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ae5:	0f 82 86 00 00 00    	jb     80100b71 <exec+0x161>
80100aeb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af1:	72 7e                	jb     80100b71 <exec+0x161>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af3:	83 ec 04             	sub    $0x4,%esp
80100af6:	50                   	push   %eax
80100af7:	57                   	push   %edi
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	e8 5d 61 00 00       	call   80106c60 <allocuvm>
80100b03:	83 c4 10             	add    $0x10,%esp
80100b06:	85 c0                	test   %eax,%eax
80100b08:	89 c7                	mov    %eax,%edi
80100b0a:	74 65                	je     80100b71 <exec+0x161>
    if(ph.vaddr % PGSIZE != 0)
80100b0c:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b12:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b17:	75 58                	jne    80100b71 <exec+0x161>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b19:	83 ec 0c             	sub    $0xc,%esp
80100b1c:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b22:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b28:	53                   	push   %ebx
80100b29:	50                   	push   %eax
80100b2a:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100b30:	e8 6b 60 00 00       	call   80106ba0 <loaduvm>
80100b35:	83 c4 20             	add    $0x20,%esp
80100b38:	85 c0                	test   %eax,%eax
80100b3a:	78 35                	js     80100b71 <exec+0x161>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b3c:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b43:	83 c6 01             	add    $0x1,%esi
80100b46:	39 f0                	cmp    %esi,%eax
80100b48:	7e 3d                	jle    80100b87 <exec+0x177>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b4a:	89 f0                	mov    %esi,%eax
80100b4c:	6a 20                	push   $0x20
80100b4e:	c1 e0 05             	shl    $0x5,%eax
80100b51:	03 85 e8 fe ff ff    	add    -0x118(%ebp),%eax
80100b57:	50                   	push   %eax
80100b58:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b5e:	50                   	push   %eax
80100b5f:	53                   	push   %ebx
80100b60:	e8 1b 0e 00 00       	call   80101980 <readi>
80100b65:	83 c4 10             	add    $0x10,%esp
80100b68:	83 f8 20             	cmp    $0x20,%eax
80100b6b:	0f 84 5f ff ff ff    	je     80100ad0 <exec+0xc0>
    freevm(pgdir);
80100b71:	83 ec 0c             	sub    $0xc,%esp
80100b74:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100b7a:	e8 41 62 00 00       	call   80106dc0 <freevm>
80100b7f:	83 c4 10             	add    $0x10,%esp
80100b82:	e9 ea fe ff ff       	jmp    80100a71 <exec+0x61>
80100b87:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b8d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b93:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b99:	83 ec 0c             	sub    $0xc,%esp
80100b9c:	53                   	push   %ebx
80100b9d:	e8 8e 0d 00 00       	call   80101930 <iunlockput>
  end_op();
80100ba2:	e8 89 20 00 00       	call   80102c30 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ba7:	83 c4 0c             	add    $0xc,%esp
80100baa:	56                   	push   %esi
80100bab:	57                   	push   %edi
80100bac:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100bb2:	e8 a9 60 00 00       	call   80106c60 <allocuvm>
80100bb7:	83 c4 10             	add    $0x10,%esp
80100bba:	85 c0                	test   %eax,%eax
80100bbc:	89 c6                	mov    %eax,%esi
80100bbe:	75 3a                	jne    80100bfa <exec+0x1ea>
    freevm(pgdir);
80100bc0:	83 ec 0c             	sub    $0xc,%esp
80100bc3:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100bc9:	e8 f2 61 00 00       	call   80106dc0 <freevm>
80100bce:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd6:	e9 ac fe ff ff       	jmp    80100a87 <exec+0x77>
    end_op();
80100bdb:	e8 50 20 00 00       	call   80102c30 <end_op>
    cprintf("exec: fail\n");
80100be0:	83 ec 0c             	sub    $0xc,%esp
80100be3:	68 61 71 10 80       	push   $0x80107161
80100be8:	e8 73 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bed:	83 c4 10             	add    $0x10,%esp
80100bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bf5:	e9 8d fe ff ff       	jmp    80100a87 <exec+0x77>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bfa:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c00:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100c03:	31 ff                	xor    %edi,%edi
80100c05:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c07:	50                   	push   %eax
80100c08:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100c0e:	e8 cd 62 00 00       	call   80106ee0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c13:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c16:	83 c4 10             	add    $0x10,%esp
80100c19:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c1f:	8b 00                	mov    (%eax),%eax
80100c21:	85 c0                	test   %eax,%eax
80100c23:	74 70                	je     80100c95 <exec+0x285>
80100c25:	89 b5 e8 fe ff ff    	mov    %esi,-0x118(%ebp)
80100c2b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100c31:	eb 0a                	jmp    80100c3d <exec+0x22d>
80100c33:	90                   	nop
80100c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c38:	83 ff 20             	cmp    $0x20,%edi
80100c3b:	74 83                	je     80100bc0 <exec+0x1b0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3d:	83 ec 0c             	sub    $0xc,%esp
80100c40:	50                   	push   %eax
80100c41:	e8 4a 3c 00 00       	call   80104890 <strlen>
80100c46:	f7 d0                	not    %eax
80100c48:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4d:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c4e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c51:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c54:	e8 37 3c 00 00       	call   80104890 <strlen>
80100c59:	83 c0 01             	add    $0x1,%eax
80100c5c:	50                   	push   %eax
80100c5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c60:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c63:	53                   	push   %ebx
80100c64:	56                   	push   %esi
80100c65:	e8 d6 63 00 00       	call   80107040 <copyout>
80100c6a:	83 c4 20             	add    $0x20,%esp
80100c6d:	85 c0                	test   %eax,%eax
80100c6f:	0f 88 4b ff ff ff    	js     80100bc0 <exec+0x1b0>
  for(argc = 0; argv[argc]; argc++) {
80100c75:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c78:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c7f:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c82:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c8b:	85 c0                	test   %eax,%eax
80100c8d:	75 a9                	jne    80100c38 <exec+0x228>
80100c8f:	8b b5 e8 fe ff ff    	mov    -0x118(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c95:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c9c:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c9e:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100ca5:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca9:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cb0:	ff ff ff 
  ustack[1] = argc;
80100cb3:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb9:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cbb:	83 c0 0c             	add    $0xc,%eax
80100cbe:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc0:	50                   	push   %eax
80100cc1:	52                   	push   %edx
80100cc2:	53                   	push   %ebx
80100cc3:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc9:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ccf:	e8 6c 63 00 00       	call   80107040 <copyout>
80100cd4:	83 c4 10             	add    $0x10,%esp
80100cd7:	85 c0                	test   %eax,%eax
80100cd9:	0f 88 e1 fe ff ff    	js     80100bc0 <exec+0x1b0>
  for(last=s=path; *s; s++)
80100cdf:	8b 45 08             	mov    0x8(%ebp),%eax
80100ce2:	0f b6 00             	movzbl (%eax),%eax
80100ce5:	84 c0                	test   %al,%al
80100ce7:	74 17                	je     80100d00 <exec+0x2f0>
80100ce9:	8b 55 08             	mov    0x8(%ebp),%edx
80100cec:	89 d1                	mov    %edx,%ecx
80100cee:	83 c1 01             	add    $0x1,%ecx
80100cf1:	3c 2f                	cmp    $0x2f,%al
80100cf3:	0f b6 01             	movzbl (%ecx),%eax
80100cf6:	0f 44 d1             	cmove  %ecx,%edx
80100cf9:	84 c0                	test   %al,%al
80100cfb:	75 f1                	jne    80100cee <exec+0x2de>
80100cfd:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d00:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d06:	50                   	push   %eax
80100d07:	6a 10                	push   $0x10
80100d09:	ff 75 08             	pushl  0x8(%ebp)
80100d0c:	8d 47 64             	lea    0x64(%edi),%eax
80100d0f:	50                   	push   %eax
80100d10:	e8 3b 3b 00 00       	call   80104850 <safestrcpy>
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
  curproc->pgdir = pgdir;
80100d17:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  oldpgdir = curproc->pgdir;
80100d1d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d20:	89 31                	mov    %esi,(%ecx)
  curthread->tf->eip = elf.entry;  // main
80100d22:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  curproc->pgdir = pgdir;
80100d28:	89 41 04             	mov    %eax,0x4(%ecx)
  curthread->tf->eip = elf.entry;  // main
80100d2b:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d31:	8b 46 10             	mov    0x10(%esi),%eax
80100d34:	89 50 38             	mov    %edx,0x38(%eax)
  curthread->tf->esp = sp;
80100d37:	8b 46 10             	mov    0x10(%esi),%eax
80100d3a:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d3d:	89 0c 24             	mov    %ecx,(%esp)
80100d40:	e8 cb 5c 00 00       	call   80106a10 <switchuvm>
  freevm(oldpgdir);
80100d45:	89 3c 24             	mov    %edi,(%esp)
80100d48:	e8 73 60 00 00       	call   80106dc0 <freevm>
  return 0;
80100d4d:	83 c4 10             	add    $0x10,%esp
80100d50:	31 c0                	xor    %eax,%eax
80100d52:	e9 30 fd ff ff       	jmp    80100a87 <exec+0x77>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d57:	be 00 20 00 00       	mov    $0x2000,%esi
80100d5c:	e9 38 fe ff ff       	jmp    80100b99 <exec+0x189>
80100d61:	66 90                	xchg   %ax,%ax
80100d63:	66 90                	xchg   %ax,%ax
80100d65:	66 90                	xchg   %ax,%ax
80100d67:	66 90                	xchg   %ax,%ax
80100d69:	66 90                	xchg   %ax,%ax
80100d6b:	66 90                	xchg   %ax,%ax
80100d6d:	66 90                	xchg   %ax,%ax
80100d6f:	90                   	nop

80100d70 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d76:	68 6d 71 10 80       	push   $0x8010716d
80100d7b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d80:	e8 9b 36 00 00       	call   80104420 <initlock>
}
80100d85:	83 c4 10             	add    $0x10,%esp
80100d88:	c9                   	leave  
80100d89:	c3                   	ret    
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d90 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d94:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d99:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d9c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100da1:	e8 ba 37 00 00       	call   80104560 <acquire>
80100da6:	83 c4 10             	add    $0x10,%esp
80100da9:	eb 10                	jmp    80100dbb <filealloc+0x2b>
80100dab:	90                   	nop
80100dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100db0:	83 c3 18             	add    $0x18,%ebx
80100db3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100db9:	73 25                	jae    80100de0 <filealloc+0x50>
    if(f->ref == 0){
80100dbb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dbe:	85 c0                	test   %eax,%eax
80100dc0:	75 ee                	jne    80100db0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100dc2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100dc5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dcc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dd1:	e8 4a 38 00 00       	call   80104620 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dd6:	89 d8                	mov    %ebx,%eax
      return f;
80100dd8:	83 c4 10             	add    $0x10,%esp
}
80100ddb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dde:	c9                   	leave  
80100ddf:	c3                   	ret    
  release(&ftable.lock);
80100de0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100de3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100de5:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dea:	e8 31 38 00 00       	call   80104620 <release>
}
80100def:	89 d8                	mov    %ebx,%eax
  return 0;
80100df1:	83 c4 10             	add    $0x10,%esp
}
80100df4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100df7:	c9                   	leave  
80100df8:	c3                   	ret    
80100df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e00 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
80100e04:	83 ec 10             	sub    $0x10,%esp
80100e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e0a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0f:	e8 4c 37 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e14:	8b 43 04             	mov    0x4(%ebx),%eax
80100e17:	83 c4 10             	add    $0x10,%esp
80100e1a:	85 c0                	test   %eax,%eax
80100e1c:	7e 1a                	jle    80100e38 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e1e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e21:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e24:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e27:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e2c:	e8 ef 37 00 00       	call   80104620 <release>
  return f;
}
80100e31:	89 d8                	mov    %ebx,%eax
80100e33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e36:	c9                   	leave  
80100e37:	c3                   	ret    
    panic("filedup");
80100e38:	83 ec 0c             	sub    $0xc,%esp
80100e3b:	68 74 71 10 80       	push   $0x80107174
80100e40:	e8 4b f5 ff ff       	call   80100390 <panic>
80100e45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e50 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	57                   	push   %edi
80100e54:	56                   	push   %esi
80100e55:	53                   	push   %ebx
80100e56:	83 ec 28             	sub    $0x28,%esp
80100e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e5c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e61:	e8 fa 36 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e66:	8b 43 04             	mov    0x4(%ebx),%eax
80100e69:	83 c4 10             	add    $0x10,%esp
80100e6c:	85 c0                	test   %eax,%eax
80100e6e:	0f 8e 9b 00 00 00    	jle    80100f0f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e74:	83 e8 01             	sub    $0x1,%eax
80100e77:	85 c0                	test   %eax,%eax
80100e79:	89 43 04             	mov    %eax,0x4(%ebx)
80100e7c:	74 1a                	je     80100e98 <fileclose+0x48>
    release(&ftable.lock);
80100e7e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e88:	5b                   	pop    %ebx
80100e89:	5e                   	pop    %esi
80100e8a:	5f                   	pop    %edi
80100e8b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e8c:	e9 8f 37 00 00       	jmp    80104620 <release>
80100e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e98:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e9c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e9e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ea1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ea4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eaa:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ead:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100eb0:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100eb5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100eb8:	e8 63 37 00 00       	call   80104620 <release>
  if(ff.type == FD_PIPE)
80100ebd:	83 c4 10             	add    $0x10,%esp
80100ec0:	83 ff 01             	cmp    $0x1,%edi
80100ec3:	74 13                	je     80100ed8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ec5:	83 ff 02             	cmp    $0x2,%edi
80100ec8:	74 26                	je     80100ef0 <fileclose+0xa0>
}
80100eca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ecd:	5b                   	pop    %ebx
80100ece:	5e                   	pop    %esi
80100ecf:	5f                   	pop    %edi
80100ed0:	5d                   	pop    %ebp
80100ed1:	c3                   	ret    
80100ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ed8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100edc:	83 ec 08             	sub    $0x8,%esp
80100edf:	53                   	push   %ebx
80100ee0:	56                   	push   %esi
80100ee1:	e8 8a 24 00 00       	call   80103370 <pipeclose>
80100ee6:	83 c4 10             	add    $0x10,%esp
80100ee9:	eb df                	jmp    80100eca <fileclose+0x7a>
80100eeb:	90                   	nop
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ef0:	e8 cb 1c 00 00       	call   80102bc0 <begin_op>
    iput(ff.ip);
80100ef5:	83 ec 0c             	sub    $0xc,%esp
80100ef8:	ff 75 e0             	pushl  -0x20(%ebp)
80100efb:	e8 d0 08 00 00       	call   801017d0 <iput>
    end_op();
80100f00:	83 c4 10             	add    $0x10,%esp
}
80100f03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f06:	5b                   	pop    %ebx
80100f07:	5e                   	pop    %esi
80100f08:	5f                   	pop    %edi
80100f09:	5d                   	pop    %ebp
    end_op();
80100f0a:	e9 21 1d 00 00       	jmp    80102c30 <end_op>
    panic("fileclose");
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	68 7c 71 10 80       	push   $0x8010717c
80100f17:	e8 74 f4 ff ff       	call   80100390 <panic>
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f20 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	53                   	push   %ebx
80100f24:	83 ec 04             	sub    $0x4,%esp
80100f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f2a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f2d:	75 31                	jne    80100f60 <filestat+0x40>
    ilock(f->ip);
80100f2f:	83 ec 0c             	sub    $0xc,%esp
80100f32:	ff 73 10             	pushl  0x10(%ebx)
80100f35:	e8 66 07 00 00       	call   801016a0 <ilock>
    stati(f->ip, st);
80100f3a:	58                   	pop    %eax
80100f3b:	5a                   	pop    %edx
80100f3c:	ff 75 0c             	pushl  0xc(%ebp)
80100f3f:	ff 73 10             	pushl  0x10(%ebx)
80100f42:	e8 09 0a 00 00       	call   80101950 <stati>
    iunlock(f->ip);
80100f47:	59                   	pop    %ecx
80100f48:	ff 73 10             	pushl  0x10(%ebx)
80100f4b:	e8 30 08 00 00       	call   80101780 <iunlock>
    return 0;
80100f50:	83 c4 10             	add    $0x10,%esp
80100f53:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f58:	c9                   	leave  
80100f59:	c3                   	ret    
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f65:	eb ee                	jmp    80100f55 <filestat+0x35>
80100f67:	89 f6                	mov    %esi,%esi
80100f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f70 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	57                   	push   %edi
80100f74:	56                   	push   %esi
80100f75:	53                   	push   %ebx
80100f76:	83 ec 0c             	sub    $0xc,%esp
80100f79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f7f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f82:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f86:	74 60                	je     80100fe8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f88:	8b 03                	mov    (%ebx),%eax
80100f8a:	83 f8 01             	cmp    $0x1,%eax
80100f8d:	74 41                	je     80100fd0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f8f:	83 f8 02             	cmp    $0x2,%eax
80100f92:	75 5b                	jne    80100fef <fileread+0x7f>
    ilock(f->ip);
80100f94:	83 ec 0c             	sub    $0xc,%esp
80100f97:	ff 73 10             	pushl  0x10(%ebx)
80100f9a:	e8 01 07 00 00       	call   801016a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f9f:	57                   	push   %edi
80100fa0:	ff 73 14             	pushl  0x14(%ebx)
80100fa3:	56                   	push   %esi
80100fa4:	ff 73 10             	pushl  0x10(%ebx)
80100fa7:	e8 d4 09 00 00       	call   80101980 <readi>
80100fac:	83 c4 20             	add    $0x20,%esp
80100faf:	85 c0                	test   %eax,%eax
80100fb1:	89 c6                	mov    %eax,%esi
80100fb3:	7e 03                	jle    80100fb8 <fileread+0x48>
      f->off += r;
80100fb5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fb8:	83 ec 0c             	sub    $0xc,%esp
80100fbb:	ff 73 10             	pushl  0x10(%ebx)
80100fbe:	e8 bd 07 00 00       	call   80101780 <iunlock>
    return r;
80100fc3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	89 f0                	mov    %esi,%eax
80100fcb:	5b                   	pop    %ebx
80100fcc:	5e                   	pop    %esi
80100fcd:	5f                   	pop    %edi
80100fce:	5d                   	pop    %ebp
80100fcf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fd0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fd3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fd9:	5b                   	pop    %ebx
80100fda:	5e                   	pop    %esi
80100fdb:	5f                   	pop    %edi
80100fdc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fdd:	e9 3e 25 00 00       	jmp    80103520 <piperead>
80100fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fe8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fed:	eb d7                	jmp    80100fc6 <fileread+0x56>
  panic("fileread");
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	68 86 71 10 80       	push   $0x80107186
80100ff7:	e8 94 f3 ff ff       	call   80100390 <panic>
80100ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 1c             	sub    $0x1c,%esp
80101009:	8b 75 08             	mov    0x8(%ebp),%esi
8010100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010100f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101013:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101016:	8b 45 10             	mov    0x10(%ebp),%eax
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010101c:	0f 84 aa 00 00 00    	je     801010cc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101022:	8b 06                	mov    (%esi),%eax
80101024:	83 f8 01             	cmp    $0x1,%eax
80101027:	0f 84 c3 00 00 00    	je     801010f0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010102d:	83 f8 02             	cmp    $0x2,%eax
80101030:	0f 85 d9 00 00 00    	jne    8010110f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101039:	31 ff                	xor    %edi,%edi
    while(i < n){
8010103b:	85 c0                	test   %eax,%eax
8010103d:	7f 34                	jg     80101073 <filewrite+0x73>
8010103f:	e9 9c 00 00 00       	jmp    801010e0 <filewrite+0xe0>
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101048:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101051:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101054:	e8 27 07 00 00       	call   80101780 <iunlock>
      end_op();
80101059:	e8 d2 1b 00 00       	call   80102c30 <end_op>
8010105e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101061:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101064:	39 c3                	cmp    %eax,%ebx
80101066:	0f 85 96 00 00 00    	jne    80101102 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010106c:	01 df                	add    %ebx,%edi
    while(i < n){
8010106e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101071:	7e 6d                	jle    801010e0 <filewrite+0xe0>
      int n1 = n - i;
80101073:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101076:	b8 00 06 00 00       	mov    $0x600,%eax
8010107b:	29 fb                	sub    %edi,%ebx
8010107d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101083:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101086:	e8 35 1b 00 00       	call   80102bc0 <begin_op>
      ilock(f->ip);
8010108b:	83 ec 0c             	sub    $0xc,%esp
8010108e:	ff 76 10             	pushl  0x10(%esi)
80101091:	e8 0a 06 00 00       	call   801016a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101096:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101099:	53                   	push   %ebx
8010109a:	ff 76 14             	pushl  0x14(%esi)
8010109d:	01 f8                	add    %edi,%eax
8010109f:	50                   	push   %eax
801010a0:	ff 76 10             	pushl  0x10(%esi)
801010a3:	e8 d8 09 00 00       	call   80101a80 <writei>
801010a8:	83 c4 20             	add    $0x20,%esp
801010ab:	85 c0                	test   %eax,%eax
801010ad:	7f 99                	jg     80101048 <filewrite+0x48>
      iunlock(f->ip);
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	ff 76 10             	pushl  0x10(%esi)
801010b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010b8:	e8 c3 06 00 00       	call   80101780 <iunlock>
      end_op();
801010bd:	e8 6e 1b 00 00       	call   80102c30 <end_op>
      if(r < 0)
801010c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010c5:	83 c4 10             	add    $0x10,%esp
801010c8:	85 c0                	test   %eax,%eax
801010ca:	74 98                	je     80101064 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010cf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010d4:	89 f8                	mov    %edi,%eax
801010d6:	5b                   	pop    %ebx
801010d7:	5e                   	pop    %esi
801010d8:	5f                   	pop    %edi
801010d9:	5d                   	pop    %ebp
801010da:	c3                   	ret    
801010db:	90                   	nop
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010e0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010e3:	75 e7                	jne    801010cc <filewrite+0xcc>
}
801010e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e8:	89 f8                	mov    %edi,%eax
801010ea:	5b                   	pop    %ebx
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
801010ef:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010f0:	8b 46 0c             	mov    0xc(%esi),%eax
801010f3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010f9:	5b                   	pop    %ebx
801010fa:	5e                   	pop    %esi
801010fb:	5f                   	pop    %edi
801010fc:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010fd:	e9 0e 23 00 00       	jmp    80103410 <pipewrite>
        panic("short filewrite");
80101102:	83 ec 0c             	sub    $0xc,%esp
80101105:	68 8f 71 10 80       	push   $0x8010718f
8010110a:	e8 81 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	68 95 71 10 80       	push   $0x80107195
80101117:	e8 74 f2 ff ff       	call   80100390 <panic>
8010111c:	66 90                	xchg   %ax,%ax
8010111e:	66 90                	xchg   %ax,%ax

80101120 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101129:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010112f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101132:	85 c9                	test   %ecx,%ecx
80101134:	0f 84 87 00 00 00    	je     801011c1 <balloc+0xa1>
8010113a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101141:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101144:	83 ec 08             	sub    $0x8,%esp
80101147:	89 f0                	mov    %esi,%eax
80101149:	c1 f8 0c             	sar    $0xc,%eax
8010114c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101152:	50                   	push   %eax
80101153:	ff 75 d8             	pushl  -0x28(%ebp)
80101156:	e8 75 ef ff ff       	call   801000d0 <bread>
8010115b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010115e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101163:	83 c4 10             	add    $0x10,%esp
80101166:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101169:	31 c0                	xor    %eax,%eax
8010116b:	eb 2f                	jmp    8010119c <balloc+0x7c>
8010116d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101170:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101172:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101175:	bb 01 00 00 00       	mov    $0x1,%ebx
8010117a:	83 e1 07             	and    $0x7,%ecx
8010117d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010117f:	89 c1                	mov    %eax,%ecx
80101181:	c1 f9 03             	sar    $0x3,%ecx
80101184:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101189:	85 df                	test   %ebx,%edi
8010118b:	89 fa                	mov    %edi,%edx
8010118d:	74 41                	je     801011d0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010118f:	83 c0 01             	add    $0x1,%eax
80101192:	83 c6 01             	add    $0x1,%esi
80101195:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010119a:	74 05                	je     801011a1 <balloc+0x81>
8010119c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010119f:	77 cf                	ja     80101170 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011a1:	83 ec 0c             	sub    $0xc,%esp
801011a4:	ff 75 e4             	pushl  -0x1c(%ebp)
801011a7:	e8 34 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011ac:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011b3:	83 c4 10             	add    $0x10,%esp
801011b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b9:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
801011bf:	77 80                	ja     80101141 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c1:	83 ec 0c             	sub    $0xc,%esp
801011c4:	68 9f 71 10 80       	push   $0x8010719f
801011c9:	e8 c2 f1 ff ff       	call   80100390 <panic>
801011ce:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011d3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011d6:	09 da                	or     %ebx,%edx
801011d8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011dc:	57                   	push   %edi
801011dd:	e8 ae 1b 00 00       	call   80102d90 <log_write>
        brelse(bp);
801011e2:	89 3c 24             	mov    %edi,(%esp)
801011e5:	e8 f6 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011ea:	58                   	pop    %eax
801011eb:	5a                   	pop    %edx
801011ec:	56                   	push   %esi
801011ed:	ff 75 d8             	pushl  -0x28(%ebp)
801011f0:	e8 db ee ff ff       	call   801000d0 <bread>
801011f5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011f7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011fa:	83 c4 0c             	add    $0xc,%esp
801011fd:	68 00 02 00 00       	push   $0x200
80101202:	6a 00                	push   $0x0
80101204:	50                   	push   %eax
80101205:	e8 66 34 00 00       	call   80104670 <memset>
  log_write(bp);
8010120a:	89 1c 24             	mov    %ebx,(%esp)
8010120d:	e8 7e 1b 00 00       	call   80102d90 <log_write>
  brelse(bp);
80101212:	89 1c 24             	mov    %ebx,(%esp)
80101215:	e8 c6 ef ff ff       	call   801001e0 <brelse>
}
8010121a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010121d:	89 f0                	mov    %esi,%eax
8010121f:	5b                   	pop    %ebx
80101220:	5e                   	pop    %esi
80101221:	5f                   	pop    %edi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret    
80101224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010122a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101230 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	57                   	push   %edi
80101234:	56                   	push   %esi
80101235:	53                   	push   %ebx
80101236:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101238:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010123a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010123f:	83 ec 28             	sub    $0x28,%esp
80101242:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101245:	68 e0 09 11 80       	push   $0x801109e0
8010124a:	e8 11 33 00 00       	call   80104560 <acquire>
8010124f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101252:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101255:	eb 17                	jmp    8010126e <iget+0x3e>
80101257:	89 f6                	mov    %esi,%esi
80101259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101260:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101266:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010126c:	73 22                	jae    80101290 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010126e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101271:	85 c9                	test   %ecx,%ecx
80101273:	7e 04                	jle    80101279 <iget+0x49>
80101275:	39 3b                	cmp    %edi,(%ebx)
80101277:	74 4f                	je     801012c8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101279:	85 f6                	test   %esi,%esi
8010127b:	75 e3                	jne    80101260 <iget+0x30>
8010127d:	85 c9                	test   %ecx,%ecx
8010127f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101282:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101288:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010128e:	72 de                	jb     8010126e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101290:	85 f6                	test   %esi,%esi
80101292:	74 5b                	je     801012ef <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101294:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101297:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101299:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010129c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012a3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012aa:	68 e0 09 11 80       	push   $0x801109e0
801012af:	e8 6c 33 00 00       	call   80104620 <release>

  return ip;
801012b4:	83 c4 10             	add    $0x10,%esp
}
801012b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ba:	89 f0                	mov    %esi,%eax
801012bc:	5b                   	pop    %ebx
801012bd:	5e                   	pop    %esi
801012be:	5f                   	pop    %edi
801012bf:	5d                   	pop    %ebp
801012c0:	c3                   	ret    
801012c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012c8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012cb:	75 ac                	jne    80101279 <iget+0x49>
      release(&icache.lock);
801012cd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012d0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012d3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012d5:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
801012da:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012dd:	e8 3e 33 00 00       	call   80104620 <release>
      return ip;
801012e2:	83 c4 10             	add    $0x10,%esp
}
801012e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e8:	89 f0                	mov    %esi,%eax
801012ea:	5b                   	pop    %ebx
801012eb:	5e                   	pop    %esi
801012ec:	5f                   	pop    %edi
801012ed:	5d                   	pop    %ebp
801012ee:	c3                   	ret    
    panic("iget: no inodes");
801012ef:	83 ec 0c             	sub    $0xc,%esp
801012f2:	68 b5 71 10 80       	push   $0x801071b5
801012f7:	e8 94 f0 ff ff       	call   80100390 <panic>
801012fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101300 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	89 c6                	mov    %eax,%esi
80101308:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010130b:	83 fa 0b             	cmp    $0xb,%edx
8010130e:	77 18                	ja     80101328 <bmap+0x28>
80101310:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101313:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101316:	85 db                	test   %ebx,%ebx
80101318:	74 76                	je     80101390 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010131a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131d:	89 d8                	mov    %ebx,%eax
8010131f:	5b                   	pop    %ebx
80101320:	5e                   	pop    %esi
80101321:	5f                   	pop    %edi
80101322:	5d                   	pop    %ebp
80101323:	c3                   	ret    
80101324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101328:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010132b:	83 fb 7f             	cmp    $0x7f,%ebx
8010132e:	0f 87 90 00 00 00    	ja     801013c4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101334:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010133a:	8b 00                	mov    (%eax),%eax
8010133c:	85 d2                	test   %edx,%edx
8010133e:	74 70                	je     801013b0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101340:	83 ec 08             	sub    $0x8,%esp
80101343:	52                   	push   %edx
80101344:	50                   	push   %eax
80101345:	e8 86 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010134a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010134e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101351:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101353:	8b 1a                	mov    (%edx),%ebx
80101355:	85 db                	test   %ebx,%ebx
80101357:	75 1d                	jne    80101376 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101359:	8b 06                	mov    (%esi),%eax
8010135b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010135e:	e8 bd fd ff ff       	call   80101120 <balloc>
80101363:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101369:	89 c3                	mov    %eax,%ebx
8010136b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010136d:	57                   	push   %edi
8010136e:	e8 1d 1a 00 00       	call   80102d90 <log_write>
80101373:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101376:	83 ec 0c             	sub    $0xc,%esp
80101379:	57                   	push   %edi
8010137a:	e8 61 ee ff ff       	call   801001e0 <brelse>
8010137f:	83 c4 10             	add    $0x10,%esp
}
80101382:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101385:	89 d8                	mov    %ebx,%eax
80101387:	5b                   	pop    %ebx
80101388:	5e                   	pop    %esi
80101389:	5f                   	pop    %edi
8010138a:	5d                   	pop    %ebp
8010138b:	c3                   	ret    
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101390:	8b 00                	mov    (%eax),%eax
80101392:	e8 89 fd ff ff       	call   80101120 <balloc>
80101397:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010139a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010139d:	89 c3                	mov    %eax,%ebx
}
8010139f:	89 d8                	mov    %ebx,%eax
801013a1:	5b                   	pop    %ebx
801013a2:	5e                   	pop    %esi
801013a3:	5f                   	pop    %edi
801013a4:	5d                   	pop    %ebp
801013a5:	c3                   	ret    
801013a6:	8d 76 00             	lea    0x0(%esi),%esi
801013a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013b0:	e8 6b fd ff ff       	call   80101120 <balloc>
801013b5:	89 c2                	mov    %eax,%edx
801013b7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013bd:	8b 06                	mov    (%esi),%eax
801013bf:	e9 7c ff ff ff       	jmp    80101340 <bmap+0x40>
  panic("bmap: out of range");
801013c4:	83 ec 0c             	sub    $0xc,%esp
801013c7:	68 c5 71 10 80       	push   $0x801071c5
801013cc:	e8 bf ef ff ff       	call   80100390 <panic>
801013d1:	eb 0d                	jmp    801013e0 <readsb>
801013d3:	90                   	nop
801013d4:	90                   	nop
801013d5:	90                   	nop
801013d6:	90                   	nop
801013d7:	90                   	nop
801013d8:	90                   	nop
801013d9:	90                   	nop
801013da:	90                   	nop
801013db:	90                   	nop
801013dc:	90                   	nop
801013dd:	90                   	nop
801013de:	90                   	nop
801013df:	90                   	nop

801013e0 <readsb>:
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	56                   	push   %esi
801013e4:	53                   	push   %ebx
801013e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013e8:	83 ec 08             	sub    $0x8,%esp
801013eb:	6a 01                	push   $0x1
801013ed:	ff 75 08             	pushl  0x8(%ebp)
801013f0:	e8 db ec ff ff       	call   801000d0 <bread>
801013f5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013f7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013fa:	83 c4 0c             	add    $0xc,%esp
801013fd:	6a 1c                	push   $0x1c
801013ff:	50                   	push   %eax
80101400:	56                   	push   %esi
80101401:	e8 1a 33 00 00       	call   80104720 <memmove>
  brelse(bp);
80101406:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101409:	83 c4 10             	add    $0x10,%esp
}
8010140c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010140f:	5b                   	pop    %ebx
80101410:	5e                   	pop    %esi
80101411:	5d                   	pop    %ebp
  brelse(bp);
80101412:	e9 c9 ed ff ff       	jmp    801001e0 <brelse>
80101417:	89 f6                	mov    %esi,%esi
80101419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101420 <bfree>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	89 d3                	mov    %edx,%ebx
80101427:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101429:	83 ec 08             	sub    $0x8,%esp
8010142c:	68 c0 09 11 80       	push   $0x801109c0
80101431:	50                   	push   %eax
80101432:	e8 a9 ff ff ff       	call   801013e0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101437:	58                   	pop    %eax
80101438:	5a                   	pop    %edx
80101439:	89 da                	mov    %ebx,%edx
8010143b:	c1 ea 0c             	shr    $0xc,%edx
8010143e:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101444:	52                   	push   %edx
80101445:	56                   	push   %esi
80101446:	e8 85 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010144b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010144d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101450:	ba 01 00 00 00       	mov    $0x1,%edx
80101455:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101458:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010145e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101461:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101463:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101468:	85 d1                	test   %edx,%ecx
8010146a:	74 25                	je     80101491 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010146c:	f7 d2                	not    %edx
8010146e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101470:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101473:	21 ca                	and    %ecx,%edx
80101475:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101479:	56                   	push   %esi
8010147a:	e8 11 19 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010147f:	89 34 24             	mov    %esi,(%esp)
80101482:	e8 59 ed ff ff       	call   801001e0 <brelse>
}
80101487:	83 c4 10             	add    $0x10,%esp
8010148a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010148d:	5b                   	pop    %ebx
8010148e:	5e                   	pop    %esi
8010148f:	5d                   	pop    %ebp
80101490:	c3                   	ret    
    panic("freeing free block");
80101491:	83 ec 0c             	sub    $0xc,%esp
80101494:	68 d8 71 10 80       	push   $0x801071d8
80101499:	e8 f2 ee ff ff       	call   80100390 <panic>
8010149e:	66 90                	xchg   %ax,%ax

801014a0 <iinit>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	53                   	push   %ebx
801014a4:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
801014a9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801014ac:	68 eb 71 10 80       	push   $0x801071eb
801014b1:	68 e0 09 11 80       	push   $0x801109e0
801014b6:	e8 65 2f 00 00       	call   80104420 <initlock>
801014bb:	83 c4 10             	add    $0x10,%esp
801014be:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014c0:	83 ec 08             	sub    $0x8,%esp
801014c3:	68 f2 71 10 80       	push   $0x801071f2
801014c8:	53                   	push   %ebx
801014c9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014cf:	e8 1c 2e 00 00       	call   801042f0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014d4:	83 c4 10             	add    $0x10,%esp
801014d7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014dd:	75 e1                	jne    801014c0 <iinit+0x20>
  readsb(dev, &sb);
801014df:	83 ec 08             	sub    $0x8,%esp
801014e2:	68 c0 09 11 80       	push   $0x801109c0
801014e7:	ff 75 08             	pushl  0x8(%ebp)
801014ea:	e8 f1 fe ff ff       	call   801013e0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014ef:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014f5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014fb:	ff 35 d0 09 11 80    	pushl  0x801109d0
80101501:	ff 35 cc 09 11 80    	pushl  0x801109cc
80101507:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010150d:	ff 35 c4 09 11 80    	pushl  0x801109c4
80101513:	ff 35 c0 09 11 80    	pushl  0x801109c0
80101519:	68 58 72 10 80       	push   $0x80107258
8010151e:	e8 3d f1 ff ff       	call   80100660 <cprintf>
}
80101523:	83 c4 30             	add    $0x30,%esp
80101526:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101529:	c9                   	leave  
8010152a:	c3                   	ret    
8010152b:	90                   	nop
8010152c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101530 <ialloc>:
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	57                   	push   %edi
80101534:	56                   	push   %esi
80101535:	53                   	push   %ebx
80101536:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101540:	8b 45 0c             	mov    0xc(%ebp),%eax
80101543:	8b 75 08             	mov    0x8(%ebp),%esi
80101546:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101549:	0f 86 91 00 00 00    	jbe    801015e0 <ialloc+0xb0>
8010154f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101554:	eb 21                	jmp    80101577 <ialloc+0x47>
80101556:	8d 76 00             	lea    0x0(%esi),%esi
80101559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101560:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101563:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101566:	57                   	push   %edi
80101567:	e8 74 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010156c:	83 c4 10             	add    $0x10,%esp
8010156f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101575:	76 69                	jbe    801015e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101577:	89 d8                	mov    %ebx,%eax
80101579:	83 ec 08             	sub    $0x8,%esp
8010157c:	c1 e8 03             	shr    $0x3,%eax
8010157f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101585:	50                   	push   %eax
80101586:	56                   	push   %esi
80101587:	e8 44 eb ff ff       	call   801000d0 <bread>
8010158c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010158e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101590:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101593:	83 e0 07             	and    $0x7,%eax
80101596:	c1 e0 06             	shl    $0x6,%eax
80101599:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010159d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015a1:	75 bd                	jne    80101560 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015a3:	83 ec 04             	sub    $0x4,%esp
801015a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015a9:	6a 40                	push   $0x40
801015ab:	6a 00                	push   $0x0
801015ad:	51                   	push   %ecx
801015ae:	e8 bd 30 00 00       	call   80104670 <memset>
      dip->type = type;
801015b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015bd:	89 3c 24             	mov    %edi,(%esp)
801015c0:	e8 cb 17 00 00       	call   80102d90 <log_write>
      brelse(bp);
801015c5:	89 3c 24             	mov    %edi,(%esp)
801015c8:	e8 13 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015cd:	83 c4 10             	add    $0x10,%esp
}
801015d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015d3:	89 da                	mov    %ebx,%edx
801015d5:	89 f0                	mov    %esi,%eax
}
801015d7:	5b                   	pop    %ebx
801015d8:	5e                   	pop    %esi
801015d9:	5f                   	pop    %edi
801015da:	5d                   	pop    %ebp
      return iget(dev, inum);
801015db:	e9 50 fc ff ff       	jmp    80101230 <iget>
  panic("ialloc: no inodes");
801015e0:	83 ec 0c             	sub    $0xc,%esp
801015e3:	68 f8 71 10 80       	push   $0x801071f8
801015e8:	e8 a3 ed ff ff       	call   80100390 <panic>
801015ed:	8d 76 00             	lea    0x0(%esi),%esi

801015f0 <iupdate>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f8:	83 ec 08             	sub    $0x8,%esp
801015fb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fe:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101601:	c1 e8 03             	shr    $0x3,%eax
80101604:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010160a:	50                   	push   %eax
8010160b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010160e:	e8 bd ea ff ff       	call   801000d0 <bread>
80101613:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101615:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101618:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010161f:	83 e0 07             	and    $0x7,%eax
80101622:	c1 e0 06             	shl    $0x6,%eax
80101625:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101629:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010162c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101630:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101633:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101637:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010163b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010163f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101643:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101647:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010164a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010164d:	6a 34                	push   $0x34
8010164f:	53                   	push   %ebx
80101650:	50                   	push   %eax
80101651:	e8 ca 30 00 00       	call   80104720 <memmove>
  log_write(bp);
80101656:	89 34 24             	mov    %esi,(%esp)
80101659:	e8 32 17 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010165e:	89 75 08             	mov    %esi,0x8(%ebp)
80101661:	83 c4 10             	add    $0x10,%esp
}
80101664:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101667:	5b                   	pop    %ebx
80101668:	5e                   	pop    %esi
80101669:	5d                   	pop    %ebp
  brelse(bp);
8010166a:	e9 71 eb ff ff       	jmp    801001e0 <brelse>
8010166f:	90                   	nop

80101670 <idup>:
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	53                   	push   %ebx
80101674:	83 ec 10             	sub    $0x10,%esp
80101677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010167a:	68 e0 09 11 80       	push   $0x801109e0
8010167f:	e8 dc 2e 00 00       	call   80104560 <acquire>
  ip->ref++;
80101684:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101688:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010168f:	e8 8c 2f 00 00       	call   80104620 <release>
}
80101694:	89 d8                	mov    %ebx,%eax
80101696:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101699:	c9                   	leave  
8010169a:	c3                   	ret    
8010169b:	90                   	nop
8010169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016a0 <ilock>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	56                   	push   %esi
801016a4:	53                   	push   %ebx
801016a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016a8:	85 db                	test   %ebx,%ebx
801016aa:	0f 84 b7 00 00 00    	je     80101767 <ilock+0xc7>
801016b0:	8b 53 08             	mov    0x8(%ebx),%edx
801016b3:	85 d2                	test   %edx,%edx
801016b5:	0f 8e ac 00 00 00    	jle    80101767 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016bb:	8d 43 0c             	lea    0xc(%ebx),%eax
801016be:	83 ec 0c             	sub    $0xc,%esp
801016c1:	50                   	push   %eax
801016c2:	e8 69 2c 00 00       	call   80104330 <acquiresleep>
  if(ip->valid == 0){
801016c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ca:	83 c4 10             	add    $0x10,%esp
801016cd:	85 c0                	test   %eax,%eax
801016cf:	74 0f                	je     801016e0 <ilock+0x40>
}
801016d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016d4:	5b                   	pop    %ebx
801016d5:	5e                   	pop    %esi
801016d6:	5d                   	pop    %ebp
801016d7:	c3                   	ret    
801016d8:	90                   	nop
801016d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e0:	8b 43 04             	mov    0x4(%ebx),%eax
801016e3:	83 ec 08             	sub    $0x8,%esp
801016e6:	c1 e8 03             	shr    $0x3,%eax
801016e9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016ef:	50                   	push   %eax
801016f0:	ff 33                	pushl  (%ebx)
801016f2:	e8 d9 e9 ff ff       	call   801000d0 <bread>
801016f7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016f9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ff:	83 e0 07             	and    $0x7,%eax
80101702:	c1 e0 06             	shl    $0x6,%eax
80101705:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101709:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010170c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010170f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101713:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101717:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010171b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010171f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101723:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101727:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010172b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010172e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101731:	6a 34                	push   $0x34
80101733:	50                   	push   %eax
80101734:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101737:	50                   	push   %eax
80101738:	e8 e3 2f 00 00       	call   80104720 <memmove>
    brelse(bp);
8010173d:	89 34 24             	mov    %esi,(%esp)
80101740:	e8 9b ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101745:	83 c4 10             	add    $0x10,%esp
80101748:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010174d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101754:	0f 85 77 ff ff ff    	jne    801016d1 <ilock+0x31>
      panic("ilock: no type");
8010175a:	83 ec 0c             	sub    $0xc,%esp
8010175d:	68 10 72 10 80       	push   $0x80107210
80101762:	e8 29 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101767:	83 ec 0c             	sub    $0xc,%esp
8010176a:	68 0a 72 10 80       	push   $0x8010720a
8010176f:	e8 1c ec ff ff       	call   80100390 <panic>
80101774:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010177a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101780 <iunlock>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101788:	85 db                	test   %ebx,%ebx
8010178a:	74 28                	je     801017b4 <iunlock+0x34>
8010178c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010178f:	83 ec 0c             	sub    $0xc,%esp
80101792:	56                   	push   %esi
80101793:	e8 38 2c 00 00       	call   801043d0 <holdingsleep>
80101798:	83 c4 10             	add    $0x10,%esp
8010179b:	85 c0                	test   %eax,%eax
8010179d:	74 15                	je     801017b4 <iunlock+0x34>
8010179f:	8b 43 08             	mov    0x8(%ebx),%eax
801017a2:	85 c0                	test   %eax,%eax
801017a4:	7e 0e                	jle    801017b4 <iunlock+0x34>
  releasesleep(&ip->lock);
801017a6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017ac:	5b                   	pop    %ebx
801017ad:	5e                   	pop    %esi
801017ae:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017af:	e9 dc 2b 00 00       	jmp    80104390 <releasesleep>
    panic("iunlock");
801017b4:	83 ec 0c             	sub    $0xc,%esp
801017b7:	68 1f 72 10 80       	push   $0x8010721f
801017bc:	e8 cf eb ff ff       	call   80100390 <panic>
801017c1:	eb 0d                	jmp    801017d0 <iput>
801017c3:	90                   	nop
801017c4:	90                   	nop
801017c5:	90                   	nop
801017c6:	90                   	nop
801017c7:	90                   	nop
801017c8:	90                   	nop
801017c9:	90                   	nop
801017ca:	90                   	nop
801017cb:	90                   	nop
801017cc:	90                   	nop
801017cd:	90                   	nop
801017ce:	90                   	nop
801017cf:	90                   	nop

801017d0 <iput>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	83 ec 28             	sub    $0x28,%esp
801017d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017dc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017df:	57                   	push   %edi
801017e0:	e8 4b 2b 00 00       	call   80104330 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017e5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017e8:	83 c4 10             	add    $0x10,%esp
801017eb:	85 d2                	test   %edx,%edx
801017ed:	74 07                	je     801017f6 <iput+0x26>
801017ef:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017f4:	74 32                	je     80101828 <iput+0x58>
  releasesleep(&ip->lock);
801017f6:	83 ec 0c             	sub    $0xc,%esp
801017f9:	57                   	push   %edi
801017fa:	e8 91 2b 00 00       	call   80104390 <releasesleep>
  acquire(&icache.lock);
801017ff:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101806:	e8 55 2d 00 00       	call   80104560 <acquire>
  ip->ref--;
8010180b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010180f:	83 c4 10             	add    $0x10,%esp
80101812:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101819:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010181c:	5b                   	pop    %ebx
8010181d:	5e                   	pop    %esi
8010181e:	5f                   	pop    %edi
8010181f:	5d                   	pop    %ebp
  release(&icache.lock);
80101820:	e9 fb 2d 00 00       	jmp    80104620 <release>
80101825:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101828:	83 ec 0c             	sub    $0xc,%esp
8010182b:	68 e0 09 11 80       	push   $0x801109e0
80101830:	e8 2b 2d 00 00       	call   80104560 <acquire>
    int r = ip->ref;
80101835:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101838:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010183f:	e8 dc 2d 00 00       	call   80104620 <release>
    if(r == 1){
80101844:	83 c4 10             	add    $0x10,%esp
80101847:	83 fe 01             	cmp    $0x1,%esi
8010184a:	75 aa                	jne    801017f6 <iput+0x26>
8010184c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101852:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101855:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101858:	89 cf                	mov    %ecx,%edi
8010185a:	eb 0b                	jmp    80101867 <iput+0x97>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101860:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101863:	39 fe                	cmp    %edi,%esi
80101865:	74 19                	je     80101880 <iput+0xb0>
    if(ip->addrs[i]){
80101867:	8b 16                	mov    (%esi),%edx
80101869:	85 d2                	test   %edx,%edx
8010186b:	74 f3                	je     80101860 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010186d:	8b 03                	mov    (%ebx),%eax
8010186f:	e8 ac fb ff ff       	call   80101420 <bfree>
      ip->addrs[i] = 0;
80101874:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010187a:	eb e4                	jmp    80101860 <iput+0x90>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101880:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101886:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101889:	85 c0                	test   %eax,%eax
8010188b:	75 33                	jne    801018c0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010188d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101890:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101897:	53                   	push   %ebx
80101898:	e8 53 fd ff ff       	call   801015f0 <iupdate>
      ip->type = 0;
8010189d:	31 c0                	xor    %eax,%eax
8010189f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801018a3:	89 1c 24             	mov    %ebx,(%esp)
801018a6:	e8 45 fd ff ff       	call   801015f0 <iupdate>
      ip->valid = 0;
801018ab:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018b2:	83 c4 10             	add    $0x10,%esp
801018b5:	e9 3c ff ff ff       	jmp    801017f6 <iput+0x26>
801018ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018c0:	83 ec 08             	sub    $0x8,%esp
801018c3:	50                   	push   %eax
801018c4:	ff 33                	pushl  (%ebx)
801018c6:	e8 05 e8 ff ff       	call   801000d0 <bread>
801018cb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018d1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018d7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018da:	83 c4 10             	add    $0x10,%esp
801018dd:	89 cf                	mov    %ecx,%edi
801018df:	eb 0e                	jmp    801018ef <iput+0x11f>
801018e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018e8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018eb:	39 fe                	cmp    %edi,%esi
801018ed:	74 0f                	je     801018fe <iput+0x12e>
      if(a[j])
801018ef:	8b 16                	mov    (%esi),%edx
801018f1:	85 d2                	test   %edx,%edx
801018f3:	74 f3                	je     801018e8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018f5:	8b 03                	mov    (%ebx),%eax
801018f7:	e8 24 fb ff ff       	call   80101420 <bfree>
801018fc:	eb ea                	jmp    801018e8 <iput+0x118>
    brelse(bp);
801018fe:	83 ec 0c             	sub    $0xc,%esp
80101901:	ff 75 e4             	pushl  -0x1c(%ebp)
80101904:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101907:	e8 d4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010190c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101912:	8b 03                	mov    (%ebx),%eax
80101914:	e8 07 fb ff ff       	call   80101420 <bfree>
    ip->addrs[NDIRECT] = 0;
80101919:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101920:	00 00 00 
80101923:	83 c4 10             	add    $0x10,%esp
80101926:	e9 62 ff ff ff       	jmp    8010188d <iput+0xbd>
8010192b:	90                   	nop
8010192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101930 <iunlockput>:
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	53                   	push   %ebx
80101934:	83 ec 10             	sub    $0x10,%esp
80101937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010193a:	53                   	push   %ebx
8010193b:	e8 40 fe ff ff       	call   80101780 <iunlock>
  iput(ip);
80101940:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101943:	83 c4 10             	add    $0x10,%esp
}
80101946:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101949:	c9                   	leave  
  iput(ip);
8010194a:	e9 81 fe ff ff       	jmp    801017d0 <iput>
8010194f:	90                   	nop

80101950 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	8b 55 08             	mov    0x8(%ebp),%edx
80101956:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101959:	8b 0a                	mov    (%edx),%ecx
8010195b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010195e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101961:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101964:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101968:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010196b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010196f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101973:	8b 52 58             	mov    0x58(%edx),%edx
80101976:	89 50 10             	mov    %edx,0x10(%eax)
}
80101979:	5d                   	pop    %ebp
8010197a:	c3                   	ret    
8010197b:	90                   	nop
8010197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101980 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	57                   	push   %edi
80101984:	56                   	push   %esi
80101985:	53                   	push   %ebx
80101986:	83 ec 1c             	sub    $0x1c,%esp
80101989:	8b 45 08             	mov    0x8(%ebp),%eax
8010198c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010198f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101992:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101997:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010199a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010199d:	8b 75 10             	mov    0x10(%ebp),%esi
801019a0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019a3:	0f 84 a7 00 00 00    	je     80101a50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019a9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019ac:	8b 40 58             	mov    0x58(%eax),%eax
801019af:	39 c6                	cmp    %eax,%esi
801019b1:	0f 87 ba 00 00 00    	ja     80101a71 <readi+0xf1>
801019b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019ba:	89 f9                	mov    %edi,%ecx
801019bc:	01 f1                	add    %esi,%ecx
801019be:	0f 82 ad 00 00 00    	jb     80101a71 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019c4:	89 c2                	mov    %eax,%edx
801019c6:	29 f2                	sub    %esi,%edx
801019c8:	39 c8                	cmp    %ecx,%eax
801019ca:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019cd:	31 ff                	xor    %edi,%edi
801019cf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019d1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d4:	74 6c                	je     80101a42 <readi+0xc2>
801019d6:	8d 76 00             	lea    0x0(%esi),%esi
801019d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019e3:	89 f2                	mov    %esi,%edx
801019e5:	c1 ea 09             	shr    $0x9,%edx
801019e8:	89 d8                	mov    %ebx,%eax
801019ea:	e8 11 f9 ff ff       	call   80101300 <bmap>
801019ef:	83 ec 08             	sub    $0x8,%esp
801019f2:	50                   	push   %eax
801019f3:	ff 33                	pushl  (%ebx)
801019f5:	e8 d6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019fa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019fd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ff:	89 f0                	mov    %esi,%eax
80101a01:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a06:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a0b:	83 c4 0c             	add    $0xc,%esp
80101a0e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a10:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a14:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a17:	29 fb                	sub    %edi,%ebx
80101a19:	39 d9                	cmp    %ebx,%ecx
80101a1b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a1e:	53                   	push   %ebx
80101a1f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a20:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a22:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a25:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a27:	e8 f4 2c 00 00       	call   80104720 <memmove>
    brelse(bp);
80101a2c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a2f:	89 14 24             	mov    %edx,(%esp)
80101a32:	e8 a9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a37:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a3a:	83 c4 10             	add    $0x10,%esp
80101a3d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a40:	77 9e                	ja     801019e0 <readi+0x60>
  }
  return n;
80101a42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5f                   	pop    %edi
80101a4b:	5d                   	pop    %ebp
80101a4c:	c3                   	ret    
80101a4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a54:	66 83 f8 09          	cmp    $0x9,%ax
80101a58:	77 17                	ja     80101a71 <readi+0xf1>
80101a5a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a61:	85 c0                	test   %eax,%eax
80101a63:	74 0c                	je     80101a71 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a6b:	5b                   	pop    %ebx
80101a6c:	5e                   	pop    %esi
80101a6d:	5f                   	pop    %edi
80101a6e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a6f:	ff e0                	jmp    *%eax
      return -1;
80101a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a76:	eb cd                	jmp    80101a45 <readi+0xc5>
80101a78:	90                   	nop
80101a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	57                   	push   %edi
80101a84:	56                   	push   %esi
80101a85:	53                   	push   %ebx
80101a86:	83 ec 1c             	sub    $0x1c,%esp
80101a89:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a8f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a92:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a97:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a9a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a9d:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101aa3:	0f 84 b7 00 00 00    	je     80101b60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101aa9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aac:	39 70 58             	cmp    %esi,0x58(%eax)
80101aaf:	0f 82 eb 00 00 00    	jb     80101ba0 <writei+0x120>
80101ab5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ab8:	31 d2                	xor    %edx,%edx
80101aba:	89 f8                	mov    %edi,%eax
80101abc:	01 f0                	add    %esi,%eax
80101abe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ac1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ac6:	0f 87 d4 00 00 00    	ja     80101ba0 <writei+0x120>
80101acc:	85 d2                	test   %edx,%edx
80101ace:	0f 85 cc 00 00 00    	jne    80101ba0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad4:	85 ff                	test   %edi,%edi
80101ad6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101add:	74 72                	je     80101b51 <writei+0xd1>
80101adf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ae3:	89 f2                	mov    %esi,%edx
80101ae5:	c1 ea 09             	shr    $0x9,%edx
80101ae8:	89 f8                	mov    %edi,%eax
80101aea:	e8 11 f8 ff ff       	call   80101300 <bmap>
80101aef:	83 ec 08             	sub    $0x8,%esp
80101af2:	50                   	push   %eax
80101af3:	ff 37                	pushl  (%edi)
80101af5:	e8 d6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101afa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101afd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b02:	89 f0                	mov    %esi,%eax
80101b04:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b09:	83 c4 0c             	add    $0xc,%esp
80101b0c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b11:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b13:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b17:	39 d9                	cmp    %ebx,%ecx
80101b19:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b1c:	53                   	push   %ebx
80101b1d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b20:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b22:	50                   	push   %eax
80101b23:	e8 f8 2b 00 00       	call   80104720 <memmove>
    log_write(bp);
80101b28:	89 3c 24             	mov    %edi,(%esp)
80101b2b:	e8 60 12 00 00       	call   80102d90 <log_write>
    brelse(bp);
80101b30:	89 3c 24             	mov    %edi,(%esp)
80101b33:	e8 a8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b38:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b3b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b3e:	83 c4 10             	add    $0x10,%esp
80101b41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b44:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b47:	77 97                	ja     80101ae0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b4c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b4f:	77 37                	ja     80101b88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b51:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b57:	5b                   	pop    %ebx
80101b58:	5e                   	pop    %esi
80101b59:	5f                   	pop    %edi
80101b5a:	5d                   	pop    %ebp
80101b5b:	c3                   	ret    
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 36                	ja     80101ba0 <writei+0x120>
80101b6a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 2b                	je     80101ba0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b7f:	ff e0                	jmp    *%eax
80101b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b88:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b8b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b8e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b91:	50                   	push   %eax
80101b92:	e8 59 fa ff ff       	call   801015f0 <iupdate>
80101b97:	83 c4 10             	add    $0x10,%esp
80101b9a:	eb b5                	jmp    80101b51 <writei+0xd1>
80101b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ba5:	eb ad                	jmp    80101b54 <writei+0xd4>
80101ba7:	89 f6                	mov    %esi,%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bb6:	6a 0e                	push   $0xe
80101bb8:	ff 75 0c             	pushl  0xc(%ebp)
80101bbb:	ff 75 08             	pushl  0x8(%ebp)
80101bbe:	e8 cd 2b 00 00       	call   80104790 <strncmp>
}
80101bc3:	c9                   	leave  
80101bc4:	c3                   	ret    
80101bc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bdc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101be1:	0f 85 85 00 00 00    	jne    80101c6c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101be7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bea:	31 ff                	xor    %edi,%edi
80101bec:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bef:	85 d2                	test   %edx,%edx
80101bf1:	74 3e                	je     80101c31 <dirlookup+0x61>
80101bf3:	90                   	nop
80101bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bf8:	6a 10                	push   $0x10
80101bfa:	57                   	push   %edi
80101bfb:	56                   	push   %esi
80101bfc:	53                   	push   %ebx
80101bfd:	e8 7e fd ff ff       	call   80101980 <readi>
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	83 f8 10             	cmp    $0x10,%eax
80101c08:	75 55                	jne    80101c5f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c0f:	74 18                	je     80101c29 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c11:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c14:	83 ec 04             	sub    $0x4,%esp
80101c17:	6a 0e                	push   $0xe
80101c19:	50                   	push   %eax
80101c1a:	ff 75 0c             	pushl  0xc(%ebp)
80101c1d:	e8 6e 2b 00 00       	call   80104790 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c22:	83 c4 10             	add    $0x10,%esp
80101c25:	85 c0                	test   %eax,%eax
80101c27:	74 17                	je     80101c40 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c29:	83 c7 10             	add    $0x10,%edi
80101c2c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c2f:	72 c7                	jb     80101bf8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c31:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c34:	31 c0                	xor    %eax,%eax
}
80101c36:	5b                   	pop    %ebx
80101c37:	5e                   	pop    %esi
80101c38:	5f                   	pop    %edi
80101c39:	5d                   	pop    %ebp
80101c3a:	c3                   	ret    
80101c3b:	90                   	nop
80101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c40:	8b 45 10             	mov    0x10(%ebp),%eax
80101c43:	85 c0                	test   %eax,%eax
80101c45:	74 05                	je     80101c4c <dirlookup+0x7c>
        *poff = off;
80101c47:	8b 45 10             	mov    0x10(%ebp),%eax
80101c4a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c4c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c50:	8b 03                	mov    (%ebx),%eax
80101c52:	e8 d9 f5 ff ff       	call   80101230 <iget>
}
80101c57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c5a:	5b                   	pop    %ebx
80101c5b:	5e                   	pop    %esi
80101c5c:	5f                   	pop    %edi
80101c5d:	5d                   	pop    %ebp
80101c5e:	c3                   	ret    
      panic("dirlookup read");
80101c5f:	83 ec 0c             	sub    $0xc,%esp
80101c62:	68 39 72 10 80       	push   $0x80107239
80101c67:	e8 24 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c6c:	83 ec 0c             	sub    $0xc,%esp
80101c6f:	68 27 72 10 80       	push   $0x80107227
80101c74:	e8 17 e7 ff ff       	call   80100390 <panic>
80101c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	89 cf                	mov    %ecx,%edi
80101c88:	89 c3                	mov    %eax,%ebx
80101c8a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c8d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c93:	0f 84 67 01 00 00    	je     80101e00 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c99:	e8 b2 1b 00 00       	call   80103850 <myproc>
  acquire(&icache.lock);
80101c9e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ca1:	8b 70 60             	mov    0x60(%eax),%esi
  acquire(&icache.lock);
80101ca4:	68 e0 09 11 80       	push   $0x801109e0
80101ca9:	e8 b2 28 00 00       	call   80104560 <acquire>
  ip->ref++;
80101cae:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cb9:	e8 62 29 00 00       	call   80104620 <release>
80101cbe:	83 c4 10             	add    $0x10,%esp
80101cc1:	eb 08                	jmp    80101ccb <namex+0x4b>
80101cc3:	90                   	nop
80101cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101cc8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ccb:	0f b6 03             	movzbl (%ebx),%eax
80101cce:	3c 2f                	cmp    $0x2f,%al
80101cd0:	74 f6                	je     80101cc8 <namex+0x48>
  if(*path == 0)
80101cd2:	84 c0                	test   %al,%al
80101cd4:	0f 84 ee 00 00 00    	je     80101dc8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cda:	0f b6 03             	movzbl (%ebx),%eax
80101cdd:	3c 2f                	cmp    $0x2f,%al
80101cdf:	0f 84 b3 00 00 00    	je     80101d98 <namex+0x118>
80101ce5:	84 c0                	test   %al,%al
80101ce7:	89 da                	mov    %ebx,%edx
80101ce9:	75 09                	jne    80101cf4 <namex+0x74>
80101ceb:	e9 a8 00 00 00       	jmp    80101d98 <namex+0x118>
80101cf0:	84 c0                	test   %al,%al
80101cf2:	74 0a                	je     80101cfe <namex+0x7e>
    path++;
80101cf4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf7:	0f b6 02             	movzbl (%edx),%eax
80101cfa:	3c 2f                	cmp    $0x2f,%al
80101cfc:	75 f2                	jne    80101cf0 <namex+0x70>
80101cfe:	89 d1                	mov    %edx,%ecx
80101d00:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d02:	83 f9 0d             	cmp    $0xd,%ecx
80101d05:	0f 8e 91 00 00 00    	jle    80101d9c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101d0b:	83 ec 04             	sub    $0x4,%esp
80101d0e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d11:	6a 0e                	push   $0xe
80101d13:	53                   	push   %ebx
80101d14:	57                   	push   %edi
80101d15:	e8 06 2a 00 00       	call   80104720 <memmove>
    path++;
80101d1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d1d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d20:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d22:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d25:	75 11                	jne    80101d38 <namex+0xb8>
80101d27:	89 f6                	mov    %esi,%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	56                   	push   %esi
80101d3c:	e8 5f f9 ff ff       	call   801016a0 <ilock>
    if(ip->type != T_DIR){
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d49:	0f 85 91 00 00 00    	jne    80101de0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d52:	85 d2                	test   %edx,%edx
80101d54:	74 09                	je     80101d5f <namex+0xdf>
80101d56:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d59:	0f 84 b7 00 00 00    	je     80101e16 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5f:	83 ec 04             	sub    $0x4,%esp
80101d62:	6a 00                	push   $0x0
80101d64:	57                   	push   %edi
80101d65:	56                   	push   %esi
80101d66:	e8 65 fe ff ff       	call   80101bd0 <dirlookup>
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	85 c0                	test   %eax,%eax
80101d70:	74 6e                	je     80101de0 <namex+0x160>
  iunlock(ip);
80101d72:	83 ec 0c             	sub    $0xc,%esp
80101d75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d78:	56                   	push   %esi
80101d79:	e8 02 fa ff ff       	call   80101780 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 4a fa ff ff       	call   801017d0 <iput>
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	83 c4 10             	add    $0x10,%esp
80101d8c:	89 c6                	mov    %eax,%esi
80101d8e:	e9 38 ff ff ff       	jmp    80101ccb <namex+0x4b>
80101d93:	90                   	nop
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d98:	89 da                	mov    %ebx,%edx
80101d9a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d9c:	83 ec 04             	sub    $0x4,%esp
80101d9f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da5:	51                   	push   %ecx
80101da6:	53                   	push   %ebx
80101da7:	57                   	push   %edi
80101da8:	e8 73 29 00 00       	call   80104720 <memmove>
    name[len] = 0;
80101dad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db3:	83 c4 10             	add    $0x10,%esp
80101db6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dba:	89 d3                	mov    %edx,%ebx
80101dbc:	e9 61 ff ff ff       	jmp    80101d22 <namex+0xa2>
80101dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dcb:	85 c0                	test   %eax,%eax
80101dcd:	75 5d                	jne    80101e2c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd2:	89 f0                	mov    %esi,%eax
80101dd4:	5b                   	pop    %ebx
80101dd5:	5e                   	pop    %esi
80101dd6:	5f                   	pop    %edi
80101dd7:	5d                   	pop    %ebp
80101dd8:	c3                   	ret    
80101dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	56                   	push   %esi
80101de4:	e8 97 f9 ff ff       	call   80101780 <iunlock>
  iput(ip);
80101de9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dec:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dee:	e8 dd f9 ff ff       	call   801017d0 <iput>
      return 0;
80101df3:	83 c4 10             	add    $0x10,%esp
}
80101df6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df9:	89 f0                	mov    %esi,%eax
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
80101dff:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e00:	ba 01 00 00 00       	mov    $0x1,%edx
80101e05:	b8 01 00 00 00       	mov    $0x1,%eax
80101e0a:	e8 21 f4 ff ff       	call   80101230 <iget>
80101e0f:	89 c6                	mov    %eax,%esi
80101e11:	e9 b5 fe ff ff       	jmp    80101ccb <namex+0x4b>
      iunlock(ip);
80101e16:	83 ec 0c             	sub    $0xc,%esp
80101e19:	56                   	push   %esi
80101e1a:	e8 61 f9 ff ff       	call   80101780 <iunlock>
      return ip;
80101e1f:	83 c4 10             	add    $0x10,%esp
}
80101e22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e25:	89 f0                	mov    %esi,%eax
80101e27:	5b                   	pop    %ebx
80101e28:	5e                   	pop    %esi
80101e29:	5f                   	pop    %edi
80101e2a:	5d                   	pop    %ebp
80101e2b:	c3                   	ret    
    iput(ip);
80101e2c:	83 ec 0c             	sub    $0xc,%esp
80101e2f:	56                   	push   %esi
    return 0;
80101e30:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e32:	e8 99 f9 ff ff       	call   801017d0 <iput>
    return 0;
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	eb 93                	jmp    80101dcf <namex+0x14f>
80101e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlink>:
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 20             	sub    $0x20,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e4c:	6a 00                	push   $0x0
80101e4e:	ff 75 0c             	pushl  0xc(%ebp)
80101e51:	53                   	push   %ebx
80101e52:	e8 79 fd ff ff       	call   80101bd0 <dirlookup>
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	75 67                	jne    80101ec5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e5e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e61:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e64:	85 ff                	test   %edi,%edi
80101e66:	74 29                	je     80101e91 <dirlink+0x51>
80101e68:	31 ff                	xor    %edi,%edi
80101e6a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e6d:	eb 09                	jmp    80101e78 <dirlink+0x38>
80101e6f:	90                   	nop
80101e70:	83 c7 10             	add    $0x10,%edi
80101e73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e76:	73 19                	jae    80101e91 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e78:	6a 10                	push   $0x10
80101e7a:	57                   	push   %edi
80101e7b:	56                   	push   %esi
80101e7c:	53                   	push   %ebx
80101e7d:	e8 fe fa ff ff       	call   80101980 <readi>
80101e82:	83 c4 10             	add    $0x10,%esp
80101e85:	83 f8 10             	cmp    $0x10,%eax
80101e88:	75 4e                	jne    80101ed8 <dirlink+0x98>
    if(de.inum == 0)
80101e8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8f:	75 df                	jne    80101e70 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e91:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e94:	83 ec 04             	sub    $0x4,%esp
80101e97:	6a 0e                	push   $0xe
80101e99:	ff 75 0c             	pushl  0xc(%ebp)
80101e9c:	50                   	push   %eax
80101e9d:	e8 4e 29 00 00       	call   801047f0 <strncpy>
  de.inum = inum;
80101ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ea5:	6a 10                	push   $0x10
80101ea7:	57                   	push   %edi
80101ea8:	56                   	push   %esi
80101ea9:	53                   	push   %ebx
  de.inum = inum;
80101eaa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eae:	e8 cd fb ff ff       	call   80101a80 <writei>
80101eb3:	83 c4 20             	add    $0x20,%esp
80101eb6:	83 f8 10             	cmp    $0x10,%eax
80101eb9:	75 2a                	jne    80101ee5 <dirlink+0xa5>
  return 0;
80101ebb:	31 c0                	xor    %eax,%eax
}
80101ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec0:	5b                   	pop    %ebx
80101ec1:	5e                   	pop    %esi
80101ec2:	5f                   	pop    %edi
80101ec3:	5d                   	pop    %ebp
80101ec4:	c3                   	ret    
    iput(ip);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	50                   	push   %eax
80101ec9:	e8 02 f9 ff ff       	call   801017d0 <iput>
    return -1;
80101ece:	83 c4 10             	add    $0x10,%esp
80101ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ed6:	eb e5                	jmp    80101ebd <dirlink+0x7d>
      panic("dirlink read");
80101ed8:	83 ec 0c             	sub    $0xc,%esp
80101edb:	68 48 72 10 80       	push   $0x80107248
80101ee0:	e8 ab e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 3e 78 10 80       	push   $0x8010783e
80101eed:	e8 9e e4 ff ff       	call   80100390 <panic>
80101ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 6d fd ff ff       	call   80101c80 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 4c fd ff ff       	jmp    80101c80 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	57                   	push   %edi
80101f44:	56                   	push   %esi
80101f45:	53                   	push   %ebx
80101f46:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f49:	85 c0                	test   %eax,%eax
80101f4b:	0f 84 b4 00 00 00    	je     80102005 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f51:	8b 58 08             	mov    0x8(%eax),%ebx
80101f54:	89 c6                	mov    %eax,%esi
80101f56:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f5c:	0f 87 96 00 00 00    	ja     80101ff8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f62:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f67:	89 f6                	mov    %esi,%esi
80101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f70:	89 ca                	mov    %ecx,%edx
80101f72:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f73:	83 e0 c0             	and    $0xffffffc0,%eax
80101f76:	3c 40                	cmp    $0x40,%al
80101f78:	75 f6                	jne    80101f70 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f7a:	31 ff                	xor    %edi,%edi
80101f7c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f81:	89 f8                	mov    %edi,%eax
80101f83:	ee                   	out    %al,(%dx)
80101f84:	b8 01 00 00 00       	mov    $0x1,%eax
80101f89:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f8e:	ee                   	out    %al,(%dx)
80101f8f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f94:	89 d8                	mov    %ebx,%eax
80101f96:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f97:	89 d8                	mov    %ebx,%eax
80101f99:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f9e:	c1 f8 08             	sar    $0x8,%eax
80101fa1:	ee                   	out    %al,(%dx)
80101fa2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fa7:	89 f8                	mov    %edi,%eax
80101fa9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101faa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fae:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb3:	c1 e0 04             	shl    $0x4,%eax
80101fb6:	83 e0 10             	and    $0x10,%eax
80101fb9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fbc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fbd:	f6 06 04             	testb  $0x4,(%esi)
80101fc0:	75 16                	jne    80101fd8 <idestart+0x98>
80101fc2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fc7:	89 ca                	mov    %ecx,%edx
80101fc9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcd:	5b                   	pop    %ebx
80101fce:	5e                   	pop    %esi
80101fcf:	5f                   	pop    %edi
80101fd0:	5d                   	pop    %ebp
80101fd1:	c3                   	ret    
80101fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fd8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fdd:	89 ca                	mov    %ecx,%edx
80101fdf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fe0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fe5:	83 c6 5c             	add    $0x5c,%esi
80101fe8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fed:	fc                   	cld    
80101fee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff3:	5b                   	pop    %ebx
80101ff4:	5e                   	pop    %esi
80101ff5:	5f                   	pop    %edi
80101ff6:	5d                   	pop    %ebp
80101ff7:	c3                   	ret    
    panic("incorrect blockno");
80101ff8:	83 ec 0c             	sub    $0xc,%esp
80101ffb:	68 b4 72 10 80       	push   $0x801072b4
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 ab 72 10 80       	push   $0x801072ab
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102026:	68 c6 72 10 80       	push   $0x801072c6
8010202b:	68 80 a5 10 80       	push   $0x8010a580
80102030:	e8 eb 23 00 00       	call   80104420 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102035:	58                   	pop    %eax
80102036:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010203b:	5a                   	pop    %edx
8010203c:	83 e8 01             	sub    $0x1,%eax
8010203f:	50                   	push   %eax
80102040:	6a 0e                	push   $0xe
80102042:	e8 a9 02 00 00       	call   801022f0 <ioapicenable>
80102047:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010204a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204f:	90                   	nop
80102050:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102051:	83 e0 c0             	and    $0xffffffc0,%eax
80102054:	3c 40                	cmp    $0x40,%al
80102056:	75 f8                	jne    80102050 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102058:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010205d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102062:	ee                   	out    %al,(%dx)
80102063:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102068:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206d:	eb 06                	jmp    80102075 <ideinit+0x55>
8010206f:	90                   	nop
  for(i=0; i<1000; i++){
80102070:	83 e9 01             	sub    $0x1,%ecx
80102073:	74 0f                	je     80102084 <ideinit+0x64>
80102075:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102076:	84 c0                	test   %al,%al
80102078:	74 f6                	je     80102070 <ideinit+0x50>
      havedisk1 = 1;
8010207a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102081:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102084:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102089:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010208e:	ee                   	out    %al,(%dx)
}
8010208f:	c9                   	leave  
80102090:	c3                   	ret    
80102091:	eb 0d                	jmp    801020a0 <ideintr>
80102093:	90                   	nop
80102094:	90                   	nop
80102095:	90                   	nop
80102096:	90                   	nop
80102097:	90                   	nop
80102098:	90                   	nop
80102099:	90                   	nop
8010209a:	90                   	nop
8010209b:	90                   	nop
8010209c:	90                   	nop
8010209d:	90                   	nop
8010209e:	90                   	nop
8010209f:	90                   	nop

801020a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020a9:	68 80 a5 10 80       	push   $0x8010a580
801020ae:	e8 ad 24 00 00       	call   80104560 <acquire>

  if((b = idequeue) == 0){
801020b3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 67                	je     80102127 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020c8:	8b 3b                	mov    (%ebx),%edi
801020ca:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020d0:	75 31                	jne    80102103 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020d7:	89 f6                	mov    %esi,%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e1:	89 c6                	mov    %eax,%esi
801020e3:	83 e6 c0             	and    $0xffffffc0,%esi
801020e6:	89 f1                	mov    %esi,%ecx
801020e8:	80 f9 40             	cmp    $0x40,%cl
801020eb:	75 f3                	jne    801020e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020ed:	a8 21                	test   $0x21,%al
801020ef:	75 12                	jne    80102103 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020f1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020f4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020f9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020fe:	fc                   	cld    
801020ff:	f3 6d                	rep insl (%dx),%es:(%edi)
80102101:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102103:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102106:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102109:	89 f9                	mov    %edi,%ecx
8010210b:	83 c9 02             	or     $0x2,%ecx
8010210e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102110:	53                   	push   %ebx
80102111:	e8 2a 20 00 00       	call   80104140 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102116:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010211b:	83 c4 10             	add    $0x10,%esp
8010211e:	85 c0                	test   %eax,%eax
80102120:	74 05                	je     80102127 <ideintr+0x87>
    idestart(idequeue);
80102122:	e8 19 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
80102127:	83 ec 0c             	sub    $0xc,%esp
8010212a:	68 80 a5 10 80       	push   $0x8010a580
8010212f:	e8 ec 24 00 00       	call   80104620 <release>

  release(&idelock);
}
80102134:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102137:	5b                   	pop    %ebx
80102138:	5e                   	pop    %esi
80102139:	5f                   	pop    %edi
8010213a:	5d                   	pop    %ebp
8010213b:	c3                   	ret    
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	53                   	push   %ebx
80102144:	83 ec 10             	sub    $0x10,%esp
80102147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010214a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010214d:	50                   	push   %eax
8010214e:	e8 7d 22 00 00       	call   801043d0 <holdingsleep>
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	85 c0                	test   %eax,%eax
80102158:	0f 84 c6 00 00 00    	je     80102224 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	0f 84 ab 00 00 00    	je     80102217 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010216c:	8b 53 04             	mov    0x4(%ebx),%edx
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 0d                	je     80102180 <iderw+0x40>
80102173:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 b1 00 00 00    	je     80102231 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 80 a5 10 80       	push   $0x8010a580
80102188:	e8 d3 23 00 00       	call   80104560 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102193:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102196:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	85 d2                	test   %edx,%edx
8010219f:	75 09                	jne    801021aa <iderw+0x6a>
801021a1:	eb 6d                	jmp    80102210 <iderw+0xd0>
801021a3:	90                   	nop
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a8:	89 c2                	mov    %eax,%edx
801021aa:	8b 42 58             	mov    0x58(%edx),%eax
801021ad:	85 c0                	test   %eax,%eax
801021af:	75 f7                	jne    801021a8 <iderw+0x68>
801021b1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021b4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021b6:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021bc:	74 42                	je     80102200 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 e0 06             	and    $0x6,%eax
801021c3:	83 f8 02             	cmp    $0x2,%eax
801021c6:	74 23                	je     801021eb <iderw+0xab>
801021c8:	90                   	nop
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 80 a5 10 80       	push   $0x8010a580
801021d8:	53                   	push   %ebx
801021d9:	e8 b2 1d 00 00       	call   80103f90 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x90>
  }


  release(&idelock);
801021eb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  release(&idelock);
801021f6:	e9 25 24 00 00       	jmp    80104620 <release>
801021fb:	90                   	nop
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102200:	89 d8                	mov    %ebx,%eax
80102202:	e8 39 fd ff ff       	call   80101f40 <idestart>
80102207:	eb b5                	jmp    801021be <iderw+0x7e>
80102209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102210:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102215:	eb 9d                	jmp    801021b4 <iderw+0x74>
    panic("iderw: nothing to do");
80102217:	83 ec 0c             	sub    $0xc,%esp
8010221a:	68 e0 72 10 80       	push   $0x801072e0
8010221f:	e8 6c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 ca 72 10 80       	push   $0x801072ca
8010222c:	e8 5f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 f5 72 10 80       	push   $0x801072f5
80102239:	e8 52 e1 ff ff       	call   80100390 <panic>
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102241:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102248:	00 c0 fe 
{
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	56                   	push   %esi
8010224e:	53                   	push   %ebx
  ioapic->reg = reg;
8010224f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102256:	00 00 00 
  return ioapic->data;
80102259:	a1 34 26 11 80       	mov    0x80112634,%eax
8010225e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102261:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102267:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010226d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102274:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102277:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010227a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010227d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102280:	39 c2                	cmp    %eax,%edx
80102282:	74 16                	je     8010229a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102284:	83 ec 0c             	sub    $0xc,%esp
80102287:	68 14 73 10 80       	push   $0x80107314
8010228c:	e8 cf e3 ff ff       	call   80100660 <cprintf>
80102291:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102297:	83 c4 10             	add    $0x10,%esp
8010229a:	83 c3 21             	add    $0x21,%ebx
{
8010229d:	ba 10 00 00 00       	mov    $0x10,%edx
801022a2:	b8 20 00 00 00       	mov    $0x20,%eax
801022a7:	89 f6                	mov    %esi,%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022b0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022b2:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022b8:	89 c6                	mov    %eax,%esi
801022ba:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022c0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022c3:	89 71 10             	mov    %esi,0x10(%ecx)
801022c6:	8d 72 01             	lea    0x1(%edx),%esi
801022c9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022cc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ce:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022d0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022d6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022dd:	75 d1                	jne    801022b0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e2:	5b                   	pop    %ebx
801022e3:	5e                   	pop    %esi
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	8d 76 00             	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022f0:	55                   	push   %ebp
  ioapic->reg = reg;
801022f1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801022f7:	89 e5                	mov    %esp,%ebp
801022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022fc:	8d 50 20             	lea    0x20(%eax),%edx
801022ff:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102303:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102305:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010230e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102311:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102314:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102316:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010231e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102321:	5d                   	pop    %ebp
80102322:	c3                   	ret    
80102323:	66 90                	xchg   %ax,%ax
80102325:	66 90                	xchg   %ax,%ax
80102327:	66 90                	xchg   %ax,%ax
80102329:	66 90                	xchg   %ax,%ax
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 04             	sub    $0x4,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010233a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102340:	75 70                	jne    801023b2 <kfree+0x82>
80102342:	81 fb c8 c3 11 80    	cmp    $0x8011c3c8,%ebx
80102348:	72 68                	jb     801023b2 <kfree+0x82>
8010234a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102350:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102355:	77 5b                	ja     801023b2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102357:	83 ec 04             	sub    $0x4,%esp
8010235a:	68 00 10 00 00       	push   $0x1000
8010235f:	6a 01                	push   $0x1
80102361:	53                   	push   %ebx
80102362:	e8 09 23 00 00       	call   80104670 <memset>

  if(kmem.use_lock)
80102367:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	85 d2                	test   %edx,%edx
80102372:	75 2c                	jne    801023a0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102374:	a1 78 26 11 80       	mov    0x80112678,%eax
80102379:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010237b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102380:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102386:	85 c0                	test   %eax,%eax
80102388:	75 06                	jne    80102390 <kfree+0x60>
    release(&kmem.lock);
}
8010238a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238d:	c9                   	leave  
8010238e:	c3                   	ret    
8010238f:	90                   	nop
    release(&kmem.lock);
80102390:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239a:	c9                   	leave  
    release(&kmem.lock);
8010239b:	e9 80 22 00 00       	jmp    80104620 <release>
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 40 26 11 80       	push   $0x80112640
801023a8:	e8 b3 21 00 00       	call   80104560 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 46 73 10 80       	push   $0x80107346
801023ba:	e8 d1 df ff ff       	call   80100390 <panic>
801023bf:	90                   	nop

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 23                	jb     80102404 <freerange+0x44>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023f7:	50                   	push   %eax
801023f8:	e8 33 ff ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	39 f3                	cmp    %esi,%ebx
80102402:	76 e4                	jbe    801023e8 <freerange+0x28>
}
80102404:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102407:	5b                   	pop    %ebx
80102408:	5e                   	pop    %esi
80102409:	5d                   	pop    %ebp
8010240a:	c3                   	ret    
8010240b:	90                   	nop
8010240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	68 4c 73 10 80       	push   $0x8010734c
80102420:	68 40 26 11 80       	push   $0x80112640
80102425:	e8 f6 1f 00 00       	call   80104420 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102430:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102437:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102440:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102446:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244c:	39 de                	cmp    %ebx,%esi
8010244e:	72 1c                	jb     8010246c <kinit1+0x5c>
    kfree(p);
80102450:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102456:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102459:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010245f:	50                   	push   %eax
80102460:	e8 cb fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102465:	83 c4 10             	add    $0x10,%esp
80102468:	39 de                	cmp    %ebx,%esi
8010246a:	73 e4                	jae    80102450 <kinit1+0x40>
}
8010246c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010246f:	5b                   	pop    %ebx
80102470:	5e                   	pop    %esi
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102485:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102488:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010248b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102491:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102497:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010249d:	39 de                	cmp    %ebx,%esi
8010249f:	72 23                	jb     801024c4 <kinit2+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ae:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 73 fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 de                	cmp    %ebx,%esi
801024c2:	73 e4                	jae    801024a8 <kinit2+0x28>
  kmem.use_lock = 1;
801024c4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801024cb:	00 00 00 
}
801024ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d1:	5b                   	pop    %ebx
801024d2:	5e                   	pop    %esi
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret    
801024d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024e0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024e0:	a1 74 26 11 80       	mov    0x80112674,%eax
801024e5:	85 c0                	test   %eax,%eax
801024e7:	75 1f                	jne    80102508 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801024ee:	85 c0                	test   %eax,%eax
801024f0:	74 0e                	je     80102500 <kalloc+0x20>
    kmem.freelist = r->next;
801024f2:	8b 10                	mov    (%eax),%edx
801024f4:	89 15 78 26 11 80    	mov    %edx,0x80112678
801024fa:	c3                   	ret    
801024fb:	90                   	nop
801024fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102500:	f3 c3                	repz ret 
80102502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102508:	55                   	push   %ebp
80102509:	89 e5                	mov    %esp,%ebp
8010250b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010250e:	68 40 26 11 80       	push   $0x80112640
80102513:	e8 48 20 00 00       	call   80104560 <acquire>
  r = kmem.freelist;
80102518:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102526:	85 c0                	test   %eax,%eax
80102528:	74 08                	je     80102532 <kalloc+0x52>
    kmem.freelist = r->next;
8010252a:	8b 08                	mov    (%eax),%ecx
8010252c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102532:	85 d2                	test   %edx,%edx
80102534:	74 16                	je     8010254c <kalloc+0x6c>
    release(&kmem.lock);
80102536:	83 ec 0c             	sub    $0xc,%esp
80102539:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010253c:	68 40 26 11 80       	push   $0x80112640
80102541:	e8 da 20 00 00       	call   80104620 <release>
  return (char*)r;
80102546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102549:	83 c4 10             	add    $0x10,%esp
}
8010254c:	c9                   	leave  
8010254d:	c3                   	ret    
8010254e:	66 90                	xchg   %ax,%ax

80102550 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102550:	ba 64 00 00 00       	mov    $0x64,%edx
80102555:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102556:	a8 01                	test   $0x1,%al
80102558:	0f 84 c2 00 00 00    	je     80102620 <kbdgetc+0xd0>
8010255e:	ba 60 00 00 00       	mov    $0x60,%edx
80102563:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102564:	0f b6 d0             	movzbl %al,%edx
80102567:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010256d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102573:	0f 84 7f 00 00 00    	je     801025f8 <kbdgetc+0xa8>
{
80102579:	55                   	push   %ebp
8010257a:	89 e5                	mov    %esp,%ebp
8010257c:	53                   	push   %ebx
8010257d:	89 cb                	mov    %ecx,%ebx
8010257f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102582:	84 c0                	test   %al,%al
80102584:	78 4a                	js     801025d0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102586:	85 db                	test   %ebx,%ebx
80102588:	74 09                	je     80102593 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010258a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010258d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102590:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102593:	0f b6 82 80 74 10 80 	movzbl -0x7fef8b80(%edx),%eax
8010259a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010259c:	0f b6 82 80 73 10 80 	movzbl -0x7fef8c80(%edx),%eax
801025a3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025a7:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025ad:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025b0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b3:	8b 04 85 60 73 10 80 	mov    -0x7fef8ca0(,%eax,4),%eax
801025ba:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025be:	74 31                	je     801025f1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025c0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c3:	83 fa 19             	cmp    $0x19,%edx
801025c6:	77 40                	ja     80102608 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025c8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025cb:	5b                   	pop    %ebx
801025cc:	5d                   	pop    %ebp
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025d0:	83 e0 7f             	and    $0x7f,%eax
801025d3:	85 db                	test   %ebx,%ebx
801025d5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025d8:	0f b6 82 80 74 10 80 	movzbl -0x7fef8b80(%edx),%eax
801025df:	83 c8 40             	or     $0x40,%eax
801025e2:	0f b6 c0             	movzbl %al,%eax
801025e5:	f7 d0                	not    %eax
801025e7:	21 c1                	and    %eax,%ecx
    return 0;
801025e9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025eb:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025f1:	5b                   	pop    %ebx
801025f2:	5d                   	pop    %ebp
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025f8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025fb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025fd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
80102603:	c3                   	ret    
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102608:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010260b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010260e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010260f:	83 f9 1a             	cmp    $0x1a,%ecx
80102612:	0f 42 c2             	cmovb  %edx,%eax
}
80102615:	5d                   	pop    %ebp
80102616:	c3                   	ret    
80102617:	89 f6                	mov    %esi,%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102625:	c3                   	ret    
80102626:	8d 76 00             	lea    0x0(%esi),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kbdintr>:

void
kbdintr(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102636:	68 50 25 10 80       	push   $0x80102550
8010263b:	e8 d0 e1 ff ff       	call   80100810 <consoleintr>
}
80102640:	83 c4 10             	add    $0x10,%esp
80102643:	c9                   	leave  
80102644:	c3                   	ret    
80102645:	66 90                	xchg   %ax,%ax
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102650:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102655:	55                   	push   %ebp
80102656:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102658:	85 c0                	test   %eax,%eax
8010265a:	0f 84 c8 00 00 00    	je     80102728 <lapicinit+0xd8>
  lapic[index] = value;
80102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102691:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ae:	8b 50 30             	mov    0x30(%eax),%edx
801026b1:	c1 ea 10             	shr    $0x10,%edx
801026b4:	80 fa 03             	cmp    $0x3,%dl
801026b7:	77 77                	ja     80102730 <lapicinit+0xe0>
  lapic[index] = value;
801026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026dd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102701:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102704:	8b 50 20             	mov    0x20(%eax),%edx
80102707:	89 f6                	mov    %esi,%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102716:	80 e6 10             	and    $0x10,%dh
80102719:	75 f5                	jne    80102710 <lapicinit+0xc0>
  lapic[index] = value;
8010271b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102722:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102725:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
8010273d:	e9 77 ff ff ff       	jmp    801026b9 <lapicinit+0x69>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102750:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
{
80102756:	55                   	push   %ebp
80102757:	31 c0                	xor    %eax,%eax
80102759:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010275b:	85 d2                	test   %edx,%edx
8010275d:	74 06                	je     80102765 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010275f:	8b 42 20             	mov    0x20(%edx),%eax
80102762:	c1 e8 18             	shr    $0x18,%eax
}
80102765:	5d                   	pop    %ebp
80102766:	c3                   	ret    
80102767:	89 f6                	mov    %esi,%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102770:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102775:	55                   	push   %ebp
80102776:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102778:	85 c0                	test   %eax,%eax
8010277a:	74 0d                	je     80102789 <lapiceoi+0x19>
  lapic[index] = value;
8010277c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102783:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102786:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102789:	5d                   	pop    %ebp
8010278a:	c3                   	ret    
8010278b:	90                   	nop
8010278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102790 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
}
80102793:	5d                   	pop    %ebp
80102794:	c3                   	ret    
80102795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027a0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027a0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027a1:	b8 0f 00 00 00       	mov    $0xf,%eax
801027a6:	ba 70 00 00 00       	mov    $0x70,%edx
801027ab:	89 e5                	mov    %esp,%ebp
801027ad:	53                   	push   %ebx
801027ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027b4:	ee                   	out    %al,(%dx)
801027b5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ba:	ba 71 00 00 00       	mov    $0x71,%edx
801027bf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027c0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027c2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027c5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027cb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027cd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027d0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027d3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027d5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027d8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027de:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801027e3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027f3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102800:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102803:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102806:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010280f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102815:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102818:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102821:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102827:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010282a:	5b                   	pop    %ebx
8010282b:	5d                   	pop    %ebp
8010282c:	c3                   	ret    
8010282d:	8d 76 00             	lea    0x0(%esi),%esi

80102830 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102830:	55                   	push   %ebp
80102831:	b8 0b 00 00 00       	mov    $0xb,%eax
80102836:	ba 70 00 00 00       	mov    $0x70,%edx
8010283b:	89 e5                	mov    %esp,%ebp
8010283d:	57                   	push   %edi
8010283e:	56                   	push   %esi
8010283f:	53                   	push   %ebx
80102840:	83 ec 4c             	sub    $0x4c,%esp
80102843:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102844:	ba 71 00 00 00       	mov    $0x71,%edx
80102849:	ec                   	in     (%dx),%al
8010284a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010284d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102852:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102855:	8d 76 00             	lea    0x0(%esi),%esi
80102858:	31 c0                	xor    %eax,%eax
8010285a:	89 da                	mov    %ebx,%edx
8010285c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102862:	89 ca                	mov    %ecx,%edx
80102864:	ec                   	in     (%dx),%al
80102865:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102868:	89 da                	mov    %ebx,%edx
8010286a:	b8 02 00 00 00       	mov    $0x2,%eax
8010286f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102870:	89 ca                	mov    %ecx,%edx
80102872:	ec                   	in     (%dx),%al
80102873:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102876:	89 da                	mov    %ebx,%edx
80102878:	b8 04 00 00 00       	mov    $0x4,%eax
8010287d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287e:	89 ca                	mov    %ecx,%edx
80102880:	ec                   	in     (%dx),%al
80102881:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102884:	89 da                	mov    %ebx,%edx
80102886:	b8 07 00 00 00       	mov    $0x7,%eax
8010288b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288c:	89 ca                	mov    %ecx,%edx
8010288e:	ec                   	in     (%dx),%al
8010288f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102892:	89 da                	mov    %ebx,%edx
80102894:	b8 08 00 00 00       	mov    $0x8,%eax
80102899:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289a:	89 ca                	mov    %ecx,%edx
8010289c:	ec                   	in     (%dx),%al
8010289d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289f:	89 da                	mov    %ebx,%edx
801028a1:	b8 09 00 00 00       	mov    $0x9,%eax
801028a6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a7:	89 ca                	mov    %ecx,%edx
801028a9:	ec                   	in     (%dx),%al
801028aa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	b8 0a 00 00 00       	mov    $0xa,%eax
801028b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b4:	89 ca                	mov    %ecx,%edx
801028b6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028b7:	84 c0                	test   %al,%al
801028b9:	78 9d                	js     80102858 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028bb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028bf:	89 fa                	mov    %edi,%edx
801028c1:	0f b6 fa             	movzbl %dl,%edi
801028c4:	89 f2                	mov    %esi,%edx
801028c6:	0f b6 f2             	movzbl %dl,%esi
801028c9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028cc:	89 da                	mov    %ebx,%edx
801028ce:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028d1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028d4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028d8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028db:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028df:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028e2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028e9:	31 c0                	xor    %eax,%eax
801028eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ec:	89 ca                	mov    %ecx,%edx
801028ee:	ec                   	in     (%dx),%al
801028ef:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f2:	89 da                	mov    %ebx,%edx
801028f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028f7:	b8 02 00 00 00       	mov    $0x2,%eax
801028fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	89 ca                	mov    %ecx,%edx
801028ff:	ec                   	in     (%dx),%al
80102900:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102903:	89 da                	mov    %ebx,%edx
80102905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102908:	b8 04 00 00 00       	mov    $0x4,%eax
8010290d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290e:	89 ca                	mov    %ecx,%edx
80102910:	ec                   	in     (%dx),%al
80102911:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102914:	89 da                	mov    %ebx,%edx
80102916:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102919:	b8 07 00 00 00       	mov    $0x7,%eax
8010291e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291f:	89 ca                	mov    %ecx,%edx
80102921:	ec                   	in     (%dx),%al
80102922:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102925:	89 da                	mov    %ebx,%edx
80102927:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010292a:	b8 08 00 00 00       	mov    $0x8,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010293b:	b8 09 00 00 00       	mov    $0x9,%eax
80102940:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102941:	89 ca                	mov    %ecx,%edx
80102943:	ec                   	in     (%dx),%al
80102944:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102947:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010294a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102950:	6a 18                	push   $0x18
80102952:	50                   	push   %eax
80102953:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102956:	50                   	push   %eax
80102957:	e8 64 1d 00 00       	call   801046c0 <memcmp>
8010295c:	83 c4 10             	add    $0x10,%esp
8010295f:	85 c0                	test   %eax,%eax
80102961:	0f 85 f1 fe ff ff    	jne    80102858 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102967:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010296b:	75 78                	jne    801029e5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102970:	89 c2                	mov    %eax,%edx
80102972:	83 e0 0f             	and    $0xf,%eax
80102975:	c1 ea 04             	shr    $0x4,%edx
80102978:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102981:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102984:	89 c2                	mov    %eax,%edx
80102986:	83 e0 0f             	and    $0xf,%eax
80102989:	c1 ea 04             	shr    $0x4,%edx
8010298c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102992:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102995:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102998:	89 c2                	mov    %eax,%edx
8010299a:	83 e0 0f             	and    $0xf,%eax
8010299d:	c1 ea 04             	shr    $0x4,%edx
801029a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ac:	89 c2                	mov    %eax,%edx
801029ae:	83 e0 0f             	and    $0xf,%eax
801029b1:	c1 ea 04             	shr    $0x4,%edx
801029b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029c0:	89 c2                	mov    %eax,%edx
801029c2:	83 e0 0f             	and    $0xf,%eax
801029c5:	c1 ea 04             	shr    $0x4,%edx
801029c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ce:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029d1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029d4:	89 c2                	mov    %eax,%edx
801029d6:	83 e0 0f             	and    $0xf,%eax
801029d9:	c1 ea 04             	shr    $0x4,%edx
801029dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029e5:	8b 75 08             	mov    0x8(%ebp),%esi
801029e8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029eb:	89 06                	mov    %eax,(%esi)
801029ed:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029f0:	89 46 04             	mov    %eax,0x4(%esi)
801029f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029f6:	89 46 08             	mov    %eax,0x8(%esi)
801029f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029fc:	89 46 0c             	mov    %eax,0xc(%esi)
801029ff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a02:	89 46 10             	mov    %eax,0x10(%esi)
80102a05:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a08:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a0b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a15:	5b                   	pop    %ebx
80102a16:	5e                   	pop    %esi
80102a17:	5f                   	pop    %edi
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    
80102a1a:	66 90                	xchg   %ax,%ax
80102a1c:	66 90                	xchg   %ax,%ax
80102a1e:	66 90                	xchg   %ax,%ax

80102a20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a20:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102a26:	85 c9                	test   %ecx,%ecx
80102a28:	0f 8e 8a 00 00 00    	jle    80102ab8 <install_trans+0x98>
{
80102a2e:	55                   	push   %ebp
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	57                   	push   %edi
80102a32:	56                   	push   %esi
80102a33:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a34:	31 db                	xor    %ebx,%ebx
{
80102a36:	83 ec 0c             	sub    $0xc,%esp
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a40:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a45:	83 ec 08             	sub    $0x8,%esp
80102a48:	01 d8                	add    %ebx,%eax
80102a4a:	83 c0 01             	add    $0x1,%eax
80102a4d:	50                   	push   %eax
80102a4e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a54:	e8 77 d6 ff ff       	call   801000d0 <bread>
80102a59:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5b:	58                   	pop    %eax
80102a5c:	5a                   	pop    %edx
80102a5d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a64:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a6a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6d:	e8 5e d6 ff ff       	call   801000d0 <bread>
80102a72:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a74:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a77:	83 c4 0c             	add    $0xc,%esp
80102a7a:	68 00 02 00 00       	push   $0x200
80102a7f:	50                   	push   %eax
80102a80:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a83:	50                   	push   %eax
80102a84:	e8 97 1c 00 00       	call   80104720 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 0f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a91:	89 3c 24             	mov    %edi,(%esp)
80102a94:	e8 47 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 3f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102aa1:	83 c4 10             	add    $0x10,%esp
80102aa4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102aaa:	7f 94                	jg     80102a40 <install_trans+0x20>
  }
}
80102aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aaf:	5b                   	pop    %ebx
80102ab0:	5e                   	pop    %esi
80102ab1:	5f                   	pop    %edi
80102ab2:	5d                   	pop    %ebp
80102ab3:	c3                   	ret    
80102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab8:	f3 c3                	repz ret 
80102aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ac0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	56                   	push   %esi
80102ac4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ac5:	83 ec 08             	sub    $0x8,%esp
80102ac8:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102ace:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ad4:	e8 f7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ad9:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102adf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ae2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ae4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ae6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ae9:	7e 16                	jle    80102b01 <write_head+0x41>
80102aeb:	c1 e3 02             	shl    $0x2,%ebx
80102aee:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102af0:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102af6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102afa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102afd:	39 da                	cmp    %ebx,%edx
80102aff:	75 ef                	jne    80102af0 <write_head+0x30>
  }
  bwrite(buf);
80102b01:	83 ec 0c             	sub    $0xc,%esp
80102b04:	56                   	push   %esi
80102b05:	e8 96 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b0a:	89 34 24             	mov    %esi,(%esp)
80102b0d:	e8 ce d6 ff ff       	call   801001e0 <brelse>
}
80102b12:	83 c4 10             	add    $0x10,%esp
80102b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b18:	5b                   	pop    %ebx
80102b19:	5e                   	pop    %esi
80102b1a:	5d                   	pop    %ebp
80102b1b:	c3                   	ret    
80102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b20 <initlog>:
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	53                   	push   %ebx
80102b24:	83 ec 2c             	sub    $0x2c,%esp
80102b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b2a:	68 80 75 10 80       	push   $0x80107580
80102b2f:	68 80 26 11 80       	push   $0x80112680
80102b34:	e8 e7 18 00 00       	call   80104420 <initlock>
  readsb(dev, &sb);
80102b39:	58                   	pop    %eax
80102b3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 9b e8 ff ff       	call   801013e0 <readsb>
  log.size = sb.nlog;
80102b45:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b4b:	59                   	pop    %ecx
  log.dev = dev;
80102b4c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102b52:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102b58:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102b5d:	5a                   	pop    %edx
80102b5e:	50                   	push   %eax
80102b5f:	53                   	push   %ebx
80102b60:	e8 6b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b65:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b68:	83 c4 10             	add    $0x10,%esp
80102b6b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b6d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b73:	7e 1c                	jle    80102b91 <initlog+0x71>
80102b75:	c1 e3 02             	shl    $0x2,%ebx
80102b78:	31 d2                	xor    %edx,%edx
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b80:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b84:	83 c2 04             	add    $0x4,%edx
80102b87:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b8d:	39 d3                	cmp    %edx,%ebx
80102b8f:	75 ef                	jne    80102b80 <initlog+0x60>
  brelse(buf);
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	50                   	push   %eax
80102b95:	e8 46 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b9a:	e8 81 fe ff ff       	call   80102a20 <install_trans>
  log.lh.n = 0;
80102b9f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102ba6:	00 00 00 
  write_head(); // clear the log
80102ba9:	e8 12 ff ff ff       	call   80102ac0 <write_head>
}
80102bae:	83 c4 10             	add    $0x10,%esp
80102bb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bb4:	c9                   	leave  
80102bb5:	c3                   	ret    
80102bb6:	8d 76 00             	lea    0x0(%esi),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bc6:	68 80 26 11 80       	push   $0x80112680
80102bcb:	e8 90 19 00 00       	call   80104560 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 80 26 11 80       	push   $0x80112680
80102be0:	68 80 26 11 80       	push   $0x80112680
80102be5:	e8 a6 13 00 00       	call   80103f90 <sleep>
80102bea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bed:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102bf2:	85 c0                	test   %eax,%eax
80102bf4:	75 e2                	jne    80102bd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bf6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102bfb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102c01:	83 c0 01             	add    $0x1,%eax
80102c04:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c07:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c0a:	83 fa 1e             	cmp    $0x1e,%edx
80102c0d:	7f c9                	jg     80102bd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c0f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c12:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102c17:	68 80 26 11 80       	push   $0x80112680
80102c1c:	e8 ff 19 00 00       	call   80104620 <release>
      break;
    }
  }
}
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	c9                   	leave  
80102c25:	c3                   	ret    
80102c26:	8d 76 00             	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	57                   	push   %edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c39:	68 80 26 11 80       	push   $0x80112680
80102c3e:	e8 1d 19 00 00       	call   80104560 <acquire>
  log.outstanding -= 1;
80102c43:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102c48:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102c4e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c51:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c54:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c56:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102c5c:	0f 85 1a 01 00 00    	jne    80102d7c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c62:	85 db                	test   %ebx,%ebx
80102c64:	0f 85 ee 00 00 00    	jne    80102d58 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c6a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c6d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c74:	00 00 00 
  release(&log.lock);
80102c77:	68 80 26 11 80       	push   $0x80112680
80102c7c:	e8 9f 19 00 00       	call   80104620 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c81:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c87:	83 c4 10             	add    $0x10,%esp
80102c8a:	85 c9                	test   %ecx,%ecx
80102c8c:	0f 8e 85 00 00 00    	jle    80102d17 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c92:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c97:	83 ec 08             	sub    $0x8,%esp
80102c9a:	01 d8                	add    %ebx,%eax
80102c9c:	83 c0 01             	add    $0x1,%eax
80102c9f:	50                   	push   %eax
80102ca0:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ca6:	e8 25 d4 ff ff       	call   801000d0 <bread>
80102cab:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cad:	58                   	pop    %eax
80102cae:	5a                   	pop    %edx
80102caf:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102cb6:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102cbc:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbf:	e8 0c d4 ff ff       	call   801000d0 <bread>
80102cc4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cc6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cc9:	83 c4 0c             	add    $0xc,%esp
80102ccc:	68 00 02 00 00       	push   $0x200
80102cd1:	50                   	push   %eax
80102cd2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cd5:	50                   	push   %eax
80102cd6:	e8 45 1a 00 00       	call   80104720 <memmove>
    bwrite(to);  // write the log
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 bd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ce3:	89 3c 24             	mov    %edi,(%esp)
80102ce6:	e8 f5 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ed d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf3:	83 c4 10             	add    $0x10,%esp
80102cf6:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102cfc:	7c 94                	jl     80102c92 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cfe:	e8 bd fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d03:	e8 18 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d08:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102d0f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d12:	e8 a9 fd ff ff       	call   80102ac0 <write_head>
    acquire(&log.lock);
80102d17:	83 ec 0c             	sub    $0xc,%esp
80102d1a:	68 80 26 11 80       	push   $0x80112680
80102d1f:	e8 3c 18 00 00       	call   80104560 <acquire>
    wakeup(&log);
80102d24:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d2b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d32:	00 00 00 
    wakeup(&log);
80102d35:	e8 06 14 00 00       	call   80104140 <wakeup>
    release(&log.lock);
80102d3a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d41:	e8 da 18 00 00       	call   80104620 <release>
80102d46:	83 c4 10             	add    $0x10,%esp
}
80102d49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d4c:	5b                   	pop    %ebx
80102d4d:	5e                   	pop    %esi
80102d4e:	5f                   	pop    %edi
80102d4f:	5d                   	pop    %ebp
80102d50:	c3                   	ret    
80102d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	68 80 26 11 80       	push   $0x80112680
80102d60:	e8 db 13 00 00       	call   80104140 <wakeup>
  release(&log.lock);
80102d65:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d6c:	e8 af 18 00 00       	call   80104620 <release>
80102d71:	83 c4 10             	add    $0x10,%esp
}
80102d74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d77:	5b                   	pop    %ebx
80102d78:	5e                   	pop    %esi
80102d79:	5f                   	pop    %edi
80102d7a:	5d                   	pop    %ebp
80102d7b:	c3                   	ret    
    panic("log.committing");
80102d7c:	83 ec 0c             	sub    $0xc,%esp
80102d7f:	68 84 75 10 80       	push   $0x80107584
80102d84:	e8 07 d6 ff ff       	call   80100390 <panic>
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	53                   	push   %ebx
80102d94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d97:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102d9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da0:	83 fa 1d             	cmp    $0x1d,%edx
80102da3:	0f 8f 9d 00 00 00    	jg     80102e46 <log_write+0xb6>
80102da9:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102dae:	83 e8 01             	sub    $0x1,%eax
80102db1:	39 c2                	cmp    %eax,%edx
80102db3:	0f 8d 8d 00 00 00    	jge    80102e46 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102db9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102dbe:	85 c0                	test   %eax,%eax
80102dc0:	0f 8e 8d 00 00 00    	jle    80102e53 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	68 80 26 11 80       	push   $0x80112680
80102dce:	e8 8d 17 00 00       	call   80104560 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dd3:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102dd9:	83 c4 10             	add    $0x10,%esp
80102ddc:	83 f9 00             	cmp    $0x0,%ecx
80102ddf:	7e 57                	jle    80102e38 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102de4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de6:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102dec:	75 0b                	jne    80102df9 <log_write+0x69>
80102dee:	eb 38                	jmp    80102e28 <log_write+0x98>
80102df0:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102df7:	74 2f                	je     80102e28 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102df9:	83 c0 01             	add    $0x1,%eax
80102dfc:	39 c1                	cmp    %eax,%ecx
80102dfe:	75 f0                	jne    80102df0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e00:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e07:	83 c0 01             	add    $0x1,%eax
80102e0a:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102e0f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e12:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e1c:	c9                   	leave  
  release(&log.lock);
80102e1d:	e9 fe 17 00 00       	jmp    80104620 <release>
80102e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e28:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102e2f:	eb de                	jmp    80102e0f <log_write+0x7f>
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	8b 43 08             	mov    0x8(%ebx),%eax
80102e3b:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102e40:	75 cd                	jne    80102e0f <log_write+0x7f>
80102e42:	31 c0                	xor    %eax,%eax
80102e44:	eb c1                	jmp    80102e07 <log_write+0x77>
    panic("too big a transaction");
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 93 75 10 80       	push   $0x80107593
80102e4e:	e8 3d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e53:	83 ec 0c             	sub    $0xc,%esp
80102e56:	68 a9 75 10 80       	push   $0x801075a9
80102e5b:	e8 30 d5 ff ff       	call   80100390 <panic>

80102e60 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e67:	e8 c4 09 00 00       	call   80103830 <cpuid>
80102e6c:	89 c3                	mov    %eax,%ebx
80102e6e:	e8 bd 09 00 00       	call   80103830 <cpuid>
80102e73:	83 ec 04             	sub    $0x4,%esp
80102e76:	53                   	push   %ebx
80102e77:	50                   	push   %eax
80102e78:	68 c4 75 10 80       	push   $0x801075c4
80102e7d:	e8 de d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e82:	e8 79 2a 00 00       	call   80105900 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e87:	e8 24 09 00 00       	call   801037b0 <mycpu>
80102e8c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e8e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e93:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e9a:	e8 f1 0c 00 00       	call   80103b90 <scheduler>
80102e9f:	90                   	nop

80102ea0 <mpenter>:
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ea6:	e8 45 3b 00 00       	call   801069f0 <switchkvm>
  seginit();
80102eab:	e8 b0 3a 00 00       	call   80106960 <seginit>
  lapicinit();
80102eb0:	e8 9b f7 ff ff       	call   80102650 <lapicinit>
  mpmain();
80102eb5:	e8 a6 ff ff ff       	call   80102e60 <mpmain>
80102eba:	66 90                	xchg   %ax,%ax
80102ebc:	66 90                	xchg   %ax,%ax
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <main>:
{
80102ec0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ec4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ec7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eca:	55                   	push   %ebp
80102ecb:	89 e5                	mov    %esp,%ebp
80102ecd:	53                   	push   %ebx
80102ece:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ecf:	83 ec 08             	sub    $0x8,%esp
80102ed2:	68 00 00 40 80       	push   $0x80400000
80102ed7:	68 c8 c3 11 80       	push   $0x8011c3c8
80102edc:	e8 2f f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ee1:	e8 da 3f 00 00       	call   80106ec0 <kvmalloc>
  mpinit();        // detect other processors
80102ee6:	e8 75 01 00 00       	call   80103060 <mpinit>
  lapicinit();     // interrupt controller
80102eeb:	e8 60 f7 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102ef0:	e8 6b 3a 00 00       	call   80106960 <seginit>
  picinit();       // disable pic
80102ef5:	e8 46 03 00 00       	call   80103240 <picinit>
  ioapicinit();    // another interrupt controller
80102efa:	e8 41 f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102eff:	e8 bc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f04:	e8 27 2d 00 00       	call   80105c30 <uartinit>
  pinit();         // process table
80102f09:	e8 82 08 00 00       	call   80103790 <pinit>
  tvinit();        // trap vectors
80102f0e:	e8 6d 29 00 00       	call   80105880 <tvinit>
  binit();         // buffer cache
80102f13:	e8 28 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f18:	e8 53 de ff ff       	call   80100d70 <fileinit>
  ideinit();       // disk 
80102f1d:	e8 fe f0 ff ff       	call   80102020 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f22:	83 c4 0c             	add    $0xc,%esp
80102f25:	68 8a 00 00 00       	push   $0x8a
80102f2a:	68 8c a4 10 80       	push   $0x8010a48c
80102f2f:	68 00 70 00 80       	push   $0x80007000
80102f34:	e8 e7 17 00 00       	call   80104720 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f39:	69 05 20 2d 11 80 b4 	imul   $0xb4,0x80112d20,%eax
80102f40:	00 00 00 
80102f43:	83 c4 10             	add    $0x10,%esp
80102f46:	05 80 27 11 80       	add    $0x80112780,%eax
80102f4b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80102f50:	76 71                	jbe    80102fc3 <main+0x103>
80102f52:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102f57:	89 f6                	mov    %esi,%esi
80102f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f60:	e8 4b 08 00 00       	call   801037b0 <mycpu>
80102f65:	39 d8                	cmp    %ebx,%eax
80102f67:	74 41                	je     80102faa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f69:	e8 72 f5 ff ff       	call   801024e0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f6e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f73:	c7 05 f8 6f 00 80 a0 	movl   $0x80102ea0,0x80006ff8
80102f7a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f7d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f84:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f87:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f8c:	0f b6 03             	movzbl (%ebx),%eax
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 70 00 00       	push   $0x7000
80102f97:	50                   	push   %eax
80102f98:	e8 03 f8 ff ff       	call   801027a0 <lapicstartap>
80102f9d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fa0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	74 f6                	je     80102fa0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102faa:	69 05 20 2d 11 80 b4 	imul   $0xb4,0x80112d20,%eax
80102fb1:	00 00 00 
80102fb4:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
80102fba:	05 80 27 11 80       	add    $0x80112780,%eax
80102fbf:	39 c3                	cmp    %eax,%ebx
80102fc1:	72 9d                	jb     80102f60 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fc3:	83 ec 08             	sub    $0x8,%esp
80102fc6:	68 00 00 00 8e       	push   $0x8e000000
80102fcb:	68 00 00 40 80       	push   $0x80400000
80102fd0:	e8 ab f4 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102fd5:	e8 d6 08 00 00       	call   801038b0 <userinit>
  mpmain();        // finish this processor's setup
80102fda:	e8 81 fe ff ff       	call   80102e60 <mpmain>
80102fdf:	90                   	nop

80102fe0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	57                   	push   %edi
80102fe4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fe5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102feb:	53                   	push   %ebx
  e = addr+len;
80102fec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff2:	39 de                	cmp    %ebx,%esi
80102ff4:	72 10                	jb     80103006 <mpsearch1+0x26>
80102ff6:	eb 50                	jmp    80103048 <mpsearch1+0x68>
80102ff8:	90                   	nop
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103000:	39 fb                	cmp    %edi,%ebx
80103002:	89 fe                	mov    %edi,%esi
80103004:	76 42                	jbe    80103048 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103006:	83 ec 04             	sub    $0x4,%esp
80103009:	8d 7e 10             	lea    0x10(%esi),%edi
8010300c:	6a 04                	push   $0x4
8010300e:	68 d8 75 10 80       	push   $0x801075d8
80103013:	56                   	push   %esi
80103014:	e8 a7 16 00 00       	call   801046c0 <memcmp>
80103019:	83 c4 10             	add    $0x10,%esp
8010301c:	85 c0                	test   %eax,%eax
8010301e:	75 e0                	jne    80103000 <mpsearch1+0x20>
80103020:	89 f1                	mov    %esi,%ecx
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103028:	0f b6 11             	movzbl (%ecx),%edx
8010302b:	83 c1 01             	add    $0x1,%ecx
8010302e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103030:	39 f9                	cmp    %edi,%ecx
80103032:	75 f4                	jne    80103028 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103034:	84 c0                	test   %al,%al
80103036:	75 c8                	jne    80103000 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103048:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010304b:	31 f6                	xor    %esi,%esi
}
8010304d:	89 f0                	mov    %esi,%eax
8010304f:	5b                   	pop    %ebx
80103050:	5e                   	pop    %esi
80103051:	5f                   	pop    %edi
80103052:	5d                   	pop    %ebp
80103053:	c3                   	ret    
80103054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010305a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103060 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	57                   	push   %edi
80103064:	56                   	push   %esi
80103065:	53                   	push   %ebx
80103066:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103069:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103070:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103077:	c1 e0 08             	shl    $0x8,%eax
8010307a:	09 d0                	or     %edx,%eax
8010307c:	c1 e0 04             	shl    $0x4,%eax
8010307f:	85 c0                	test   %eax,%eax
80103081:	75 1b                	jne    8010309e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103083:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010308a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103091:	c1 e0 08             	shl    $0x8,%eax
80103094:	09 d0                	or     %edx,%eax
80103096:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103099:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010309e:	ba 00 04 00 00       	mov    $0x400,%edx
801030a3:	e8 38 ff ff ff       	call   80102fe0 <mpsearch1>
801030a8:	85 c0                	test   %eax,%eax
801030aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801030ad:	0f 84 3d 01 00 00    	je     801031f0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030b6:	8b 58 04             	mov    0x4(%eax),%ebx
801030b9:	85 db                	test   %ebx,%ebx
801030bb:	0f 84 4f 01 00 00    	je     80103210 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030c1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030c7:	83 ec 04             	sub    $0x4,%esp
801030ca:	6a 04                	push   $0x4
801030cc:	68 f5 75 10 80       	push   $0x801075f5
801030d1:	56                   	push   %esi
801030d2:	e8 e9 15 00 00       	call   801046c0 <memcmp>
801030d7:	83 c4 10             	add    $0x10,%esp
801030da:	85 c0                	test   %eax,%eax
801030dc:	0f 85 2e 01 00 00    	jne    80103210 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030e2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030e9:	3c 01                	cmp    $0x1,%al
801030eb:	0f 95 c2             	setne  %dl
801030ee:	3c 04                	cmp    $0x4,%al
801030f0:	0f 95 c0             	setne  %al
801030f3:	20 c2                	and    %al,%dl
801030f5:	0f 85 15 01 00 00    	jne    80103210 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030fb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103102:	66 85 ff             	test   %di,%di
80103105:	74 1a                	je     80103121 <mpinit+0xc1>
80103107:	89 f0                	mov    %esi,%eax
80103109:	01 f7                	add    %esi,%edi
  sum = 0;
8010310b:	31 d2                	xor    %edx,%edx
8010310d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103110:	0f b6 08             	movzbl (%eax),%ecx
80103113:	83 c0 01             	add    $0x1,%eax
80103116:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103118:	39 c7                	cmp    %eax,%edi
8010311a:	75 f4                	jne    80103110 <mpinit+0xb0>
8010311c:	84 d2                	test   %dl,%dl
8010311e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103121:	85 f6                	test   %esi,%esi
80103123:	0f 84 e7 00 00 00    	je     80103210 <mpinit+0x1b0>
80103129:	84 d2                	test   %dl,%dl
8010312b:	0f 85 df 00 00 00    	jne    80103210 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103131:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103137:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103143:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103149:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314e:	01 d6                	add    %edx,%esi
80103150:	39 c6                	cmp    %eax,%esi
80103152:	76 23                	jbe    80103177 <mpinit+0x117>
    switch(*p){
80103154:	0f b6 10             	movzbl (%eax),%edx
80103157:	80 fa 04             	cmp    $0x4,%dl
8010315a:	0f 87 ca 00 00 00    	ja     8010322a <mpinit+0x1ca>
80103160:	ff 24 95 1c 76 10 80 	jmp    *-0x7fef89e4(,%edx,4)
80103167:	89 f6                	mov    %esi,%esi
80103169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103170:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103173:	39 c6                	cmp    %eax,%esi
80103175:	77 dd                	ja     80103154 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103177:	85 db                	test   %ebx,%ebx
80103179:	0f 84 9e 00 00 00    	je     8010321d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010317f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103182:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103186:	74 15                	je     8010319d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103188:	b8 70 00 00 00       	mov    $0x70,%eax
8010318d:	ba 22 00 00 00       	mov    $0x22,%edx
80103192:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103193:	ba 23 00 00 00       	mov    $0x23,%edx
80103198:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103199:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010319c:	ee                   	out    %al,(%dx)
  }
}
8010319d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031a0:	5b                   	pop    %ebx
801031a1:	5e                   	pop    %esi
801031a2:	5f                   	pop    %edi
801031a3:	5d                   	pop    %ebp
801031a4:	c3                   	ret    
801031a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801031a8:	8b 0d 20 2d 11 80    	mov    0x80112d20,%ecx
801031ae:	83 f9 07             	cmp    $0x7,%ecx
801031b1:	7f 19                	jg     801031cc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031b7:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
        ncpu++;
801031bd:	83 c1 01             	add    $0x1,%ecx
801031c0:	89 0d 20 2d 11 80    	mov    %ecx,0x80112d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c6:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
801031cc:	83 c0 14             	add    $0x14,%eax
      continue;
801031cf:	e9 7c ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031dc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031df:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
801031e5:	e9 66 ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031f0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031f5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031fa:	e8 e1 fd ff ff       	call   80102fe0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ff:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103201:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103204:	0f 85 a9 fe ff ff    	jne    801030b3 <mpinit+0x53>
8010320a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103210:	83 ec 0c             	sub    $0xc,%esp
80103213:	68 dd 75 10 80       	push   $0x801075dd
80103218:	e8 73 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010321d:	83 ec 0c             	sub    $0xc,%esp
80103220:	68 fc 75 10 80       	push   $0x801075fc
80103225:	e8 66 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010322a:	31 db                	xor    %ebx,%ebx
8010322c:	e9 26 ff ff ff       	jmp    80103157 <mpinit+0xf7>
80103231:	66 90                	xchg   %ax,%ax
80103233:	66 90                	xchg   %ax,%ax
80103235:	66 90                	xchg   %ax,%ax
80103237:	66 90                	xchg   %ax,%ax
80103239:	66 90                	xchg   %ax,%ax
8010323b:	66 90                	xchg   %ax,%ax
8010323d:	66 90                	xchg   %ax,%ax
8010323f:	90                   	nop

80103240 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103240:	55                   	push   %ebp
80103241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103246:	ba 21 00 00 00       	mov    $0x21,%edx
8010324b:	89 e5                	mov    %esp,%ebp
8010324d:	ee                   	out    %al,(%dx)
8010324e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103253:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103254:	5d                   	pop    %ebp
80103255:	c3                   	ret    
80103256:	66 90                	xchg   %ax,%ax
80103258:	66 90                	xchg   %ax,%ax
8010325a:	66 90                	xchg   %ax,%ax
8010325c:	66 90                	xchg   %ax,%ax
8010325e:	66 90                	xchg   %ax,%ax

80103260 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	57                   	push   %edi
80103264:	56                   	push   %esi
80103265:	53                   	push   %ebx
80103266:	83 ec 0c             	sub    $0xc,%esp
80103269:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010326c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010326f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103275:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010327b:	e8 10 db ff ff       	call   80100d90 <filealloc>
80103280:	85 c0                	test   %eax,%eax
80103282:	89 03                	mov    %eax,(%ebx)
80103284:	74 22                	je     801032a8 <pipealloc+0x48>
80103286:	e8 05 db ff ff       	call   80100d90 <filealloc>
8010328b:	85 c0                	test   %eax,%eax
8010328d:	89 06                	mov    %eax,(%esi)
8010328f:	74 3f                	je     801032d0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103291:	e8 4a f2 ff ff       	call   801024e0 <kalloc>
80103296:	85 c0                	test   %eax,%eax
80103298:	89 c7                	mov    %eax,%edi
8010329a:	75 54                	jne    801032f0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010329c:	8b 03                	mov    (%ebx),%eax
8010329e:	85 c0                	test   %eax,%eax
801032a0:	75 34                	jne    801032d6 <pipealloc+0x76>
801032a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801032a8:	8b 06                	mov    (%esi),%eax
801032aa:	85 c0                	test   %eax,%eax
801032ac:	74 0c                	je     801032ba <pipealloc+0x5a>
    fileclose(*f1);
801032ae:	83 ec 0c             	sub    $0xc,%esp
801032b1:	50                   	push   %eax
801032b2:	e8 99 db ff ff       	call   80100e50 <fileclose>
801032b7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032c2:	5b                   	pop    %ebx
801032c3:	5e                   	pop    %esi
801032c4:	5f                   	pop    %edi
801032c5:	5d                   	pop    %ebp
801032c6:	c3                   	ret    
801032c7:	89 f6                	mov    %esi,%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032d0:	8b 03                	mov    (%ebx),%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 e4                	je     801032ba <pipealloc+0x5a>
    fileclose(*f0);
801032d6:	83 ec 0c             	sub    $0xc,%esp
801032d9:	50                   	push   %eax
801032da:	e8 71 db ff ff       	call   80100e50 <fileclose>
  if(*f1)
801032df:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032e1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032e4:	85 c0                	test   %eax,%eax
801032e6:	75 c6                	jne    801032ae <pipealloc+0x4e>
801032e8:	eb d0                	jmp    801032ba <pipealloc+0x5a>
801032ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032f0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032f3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032fa:	00 00 00 
  p->writeopen = 1;
801032fd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103304:	00 00 00 
  p->nwrite = 0;
80103307:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010330e:	00 00 00 
  p->nread = 0;
80103311:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103318:	00 00 00 
  initlock(&p->lock, "pipe");
8010331b:	68 30 76 10 80       	push   $0x80107630
80103320:	50                   	push   %eax
80103321:	e8 fa 10 00 00       	call   80104420 <initlock>
  (*f0)->type = FD_PIPE;
80103326:	8b 03                	mov    (%ebx),%eax
  return 0;
80103328:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010332b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103331:	8b 03                	mov    (%ebx),%eax
80103333:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103337:	8b 03                	mov    (%ebx),%eax
80103339:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010333d:	8b 03                	mov    (%ebx),%eax
8010333f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103342:	8b 06                	mov    (%esi),%eax
80103344:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010334a:	8b 06                	mov    (%esi),%eax
8010334c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103350:	8b 06                	mov    (%esi),%eax
80103352:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103356:	8b 06                	mov    (%esi),%eax
80103358:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010335b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010335e:	31 c0                	xor    %eax,%eax
}
80103360:	5b                   	pop    %ebx
80103361:	5e                   	pop    %esi
80103362:	5f                   	pop    %edi
80103363:	5d                   	pop    %ebp
80103364:	c3                   	ret    
80103365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103370 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	56                   	push   %esi
80103374:	53                   	push   %ebx
80103375:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103378:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010337b:	83 ec 0c             	sub    $0xc,%esp
8010337e:	53                   	push   %ebx
8010337f:	e8 dc 11 00 00       	call   80104560 <acquire>
  if(writable){
80103384:	83 c4 10             	add    $0x10,%esp
80103387:	85 f6                	test   %esi,%esi
80103389:	74 45                	je     801033d0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010338b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103391:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103394:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010339b:	00 00 00 
    wakeup(&p->nread);
8010339e:	50                   	push   %eax
8010339f:	e8 9c 0d 00 00       	call   80104140 <wakeup>
801033a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033ad:	85 d2                	test   %edx,%edx
801033af:	75 0a                	jne    801033bb <pipeclose+0x4b>
801033b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033b7:	85 c0                	test   %eax,%eax
801033b9:	74 35                	je     801033f0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033c1:	5b                   	pop    %ebx
801033c2:	5e                   	pop    %esi
801033c3:	5d                   	pop    %ebp
    release(&p->lock);
801033c4:	e9 57 12 00 00       	jmp    80104620 <release>
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033d0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033d6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033e0:	00 00 00 
    wakeup(&p->nwrite);
801033e3:	50                   	push   %eax
801033e4:	e8 57 0d 00 00       	call   80104140 <wakeup>
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	eb b9                	jmp    801033a7 <pipeclose+0x37>
801033ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033f0:	83 ec 0c             	sub    $0xc,%esp
801033f3:	53                   	push   %ebx
801033f4:	e8 27 12 00 00       	call   80104620 <release>
    kfree((char*)p);
801033f9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033fc:	83 c4 10             	add    $0x10,%esp
}
801033ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103402:	5b                   	pop    %ebx
80103403:	5e                   	pop    %esi
80103404:	5d                   	pop    %ebp
    kfree((char*)p);
80103405:	e9 26 ef ff ff       	jmp    80102330 <kfree>
8010340a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103410 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	57                   	push   %edi
80103414:	56                   	push   %esi
80103415:	53                   	push   %ebx
80103416:	83 ec 28             	sub    $0x28,%esp
80103419:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010341c:	53                   	push   %ebx
8010341d:	e8 3e 11 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++){
80103422:	8b 45 10             	mov    0x10(%ebp),%eax
80103425:	83 c4 10             	add    $0x10,%esp
80103428:	85 c0                	test   %eax,%eax
8010342a:	0f 8e c9 00 00 00    	jle    801034f9 <pipewrite+0xe9>
80103430:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103433:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103439:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010343f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103442:	03 4d 10             	add    0x10(%ebp),%ecx
80103445:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103448:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010344e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103454:	39 d0                	cmp    %edx,%eax
80103456:	75 71                	jne    801034c9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103458:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010345e:	85 c0                	test   %eax,%eax
80103460:	74 4e                	je     801034b0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103462:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103468:	eb 3a                	jmp    801034a4 <pipewrite+0x94>
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103470:	83 ec 0c             	sub    $0xc,%esp
80103473:	57                   	push   %edi
80103474:	e8 c7 0c 00 00       	call   80104140 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103479:	5a                   	pop    %edx
8010347a:	59                   	pop    %ecx
8010347b:	53                   	push   %ebx
8010347c:	56                   	push   %esi
8010347d:	e8 0e 0b 00 00       	call   80103f90 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103482:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103488:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010348e:	83 c4 10             	add    $0x10,%esp
80103491:	05 00 02 00 00       	add    $0x200,%eax
80103496:	39 c2                	cmp    %eax,%edx
80103498:	75 36                	jne    801034d0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010349a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034a0:	85 c0                	test   %eax,%eax
801034a2:	74 0c                	je     801034b0 <pipewrite+0xa0>
801034a4:	e8 a7 03 00 00       	call   80103850 <myproc>
801034a9:	8b 40 1c             	mov    0x1c(%eax),%eax
801034ac:	85 c0                	test   %eax,%eax
801034ae:	74 c0                	je     80103470 <pipewrite+0x60>
        release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 67 11 00 00       	call   80104620 <release>
        return -1;
801034b9:	83 c4 10             	add    $0x10,%esp
801034bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034c4:	5b                   	pop    %ebx
801034c5:	5e                   	pop    %esi
801034c6:	5f                   	pop    %edi
801034c7:	5d                   	pop    %ebp
801034c8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034c9:	89 c2                	mov    %eax,%edx
801034cb:	90                   	nop
801034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034d0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034d3:	8d 42 01             	lea    0x1(%edx),%eax
801034d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034dc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034e2:	83 c6 01             	add    $0x1,%esi
801034e5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034e9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034ec:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034ef:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034f3:	0f 85 4f ff ff ff    	jne    80103448 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034f9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ff:	83 ec 0c             	sub    $0xc,%esp
80103502:	50                   	push   %eax
80103503:	e8 38 0c 00 00       	call   80104140 <wakeup>
  release(&p->lock);
80103508:	89 1c 24             	mov    %ebx,(%esp)
8010350b:	e8 10 11 00 00       	call   80104620 <release>
  return n;
80103510:	83 c4 10             	add    $0x10,%esp
80103513:	8b 45 10             	mov    0x10(%ebp),%eax
80103516:	eb a9                	jmp    801034c1 <pipewrite+0xb1>
80103518:	90                   	nop
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103520 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	53                   	push   %ebx
80103526:	83 ec 18             	sub    $0x18,%esp
80103529:	8b 75 08             	mov    0x8(%ebp),%esi
8010352c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010352f:	56                   	push   %esi
80103530:	e8 2b 10 00 00       	call   80104560 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103535:	83 c4 10             	add    $0x10,%esp
80103538:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010353e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103544:	75 6a                	jne    801035b0 <piperead+0x90>
80103546:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010354c:	85 db                	test   %ebx,%ebx
8010354e:	0f 84 c4 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103554:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010355a:	eb 2d                	jmp    80103589 <piperead+0x69>
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103560:	83 ec 08             	sub    $0x8,%esp
80103563:	56                   	push   %esi
80103564:	53                   	push   %ebx
80103565:	e8 26 0a 00 00       	call   80103f90 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010356a:	83 c4 10             	add    $0x10,%esp
8010356d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103573:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103579:	75 35                	jne    801035b0 <piperead+0x90>
8010357b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103581:	85 d2                	test   %edx,%edx
80103583:	0f 84 8f 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
80103589:	e8 c2 02 00 00       	call   80103850 <myproc>
8010358e:	8b 48 1c             	mov    0x1c(%eax),%ecx
80103591:	85 c9                	test   %ecx,%ecx
80103593:	74 cb                	je     80103560 <piperead+0x40>
      release(&p->lock);
80103595:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103598:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010359d:	56                   	push   %esi
8010359e:	e8 7d 10 00 00       	call   80104620 <release>
      return -1;
801035a3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035a9:	89 d8                	mov    %ebx,%eax
801035ab:	5b                   	pop    %ebx
801035ac:	5e                   	pop    %esi
801035ad:	5f                   	pop    %edi
801035ae:	5d                   	pop    %ebp
801035af:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035b0:	8b 45 10             	mov    0x10(%ebp),%eax
801035b3:	85 c0                	test   %eax,%eax
801035b5:	7e 61                	jle    80103618 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035b7:	31 db                	xor    %ebx,%ebx
801035b9:	eb 13                	jmp    801035ce <piperead+0xae>
801035bb:	90                   	nop
801035bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035c0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035c6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035cc:	74 1f                	je     801035ed <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035ce:	8d 41 01             	lea    0x1(%ecx),%eax
801035d1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035d7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035dd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035e2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035e5:	83 c3 01             	add    $0x1,%ebx
801035e8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035eb:	75 d3                	jne    801035c0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035ed:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035f3:	83 ec 0c             	sub    $0xc,%esp
801035f6:	50                   	push   %eax
801035f7:	e8 44 0b 00 00       	call   80104140 <wakeup>
  release(&p->lock);
801035fc:	89 34 24             	mov    %esi,(%esp)
801035ff:	e8 1c 10 00 00       	call   80104620 <release>
  return i;
80103604:	83 c4 10             	add    $0x10,%esp
}
80103607:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010360a:	89 d8                	mov    %ebx,%eax
8010360c:	5b                   	pop    %ebx
8010360d:	5e                   	pop    %esi
8010360e:	5f                   	pop    %edi
8010360f:	5d                   	pop    %ebp
80103610:	c3                   	ret    
80103611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103618:	31 db                	xor    %ebx,%ebx
8010361a:	eb d1                	jmp    801035ed <piperead+0xcd>
8010361c:	66 90                	xchg   %ax,%ax
8010361e:	66 90                	xchg   %ax,%ax

80103620 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	57                   	push   %edi
80103624:	56                   	push   %esi
80103625:	53                   	push   %ebx
  struct kthread *t; // Main thread
  int i = 0; // Index for the ptable/ttable

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103626:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
8010362b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
8010362e:	68 40 2d 11 80       	push   $0x80112d40
80103633:	e8 28 0f 00 00       	call   80104560 <acquire>
80103638:	83 c4 10             	add    $0x10,%esp
  int i = 0; // Index for the ptable/ttable
8010363b:	31 c0                	xor    %eax,%eax
8010363d:	eb 13                	jmp    80103652 <allocproc+0x32>
8010363f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103640:	83 c3 78             	add    $0x78,%ebx
    if(p->state == UNUSED)
      goto found;
    else
      i++;
80103643:	83 c0 01             	add    $0x1,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103646:	81 fb 74 4b 11 80    	cmp    $0x80114b74,%ebx
8010364c:	0f 83 ae 00 00 00    	jae    80103700 <allocproc+0xe0>
    if(p->state == UNUSED)
80103652:	8b 53 0c             	mov    0xc(%ebx),%edx
80103655:	85 d2                	test   %edx,%edx
80103657:	75 e7                	jne    80103640 <allocproc+0x20>
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->threads = ptable.ttable[i].threads;
80103659:	69 c0 c0 01 00 00    	imul   $0x1c0,%eax,%eax
  p->pid = nextpid++;
8010365f:	8b 15 08 a0 10 80    	mov    0x8010a008,%edx
  t = p->threads; // First thread in the table will be the main process thread
  t->tid = nexttid++;

  release(&ptable.lock);
80103665:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103668:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->threads = ptable.ttable[i].threads;
8010366f:	8d b0 34 1e 00 00    	lea    0x1e34(%eax),%esi
  t->tid = nexttid++;
80103675:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  p->pid = nextpid++;
8010367a:	8d 4a 01             	lea    0x1(%edx),%ecx
8010367d:	89 53 10             	mov    %edx,0x10(%ebx)
  p->threads = ptable.ttable[i].threads;
80103680:	8d be 40 2d 11 80    	lea    -0x7feed2c0(%esi),%edi
  p->pid = nextpid++;
80103686:	89 0d 08 a0 10 80    	mov    %ecx,0x8010a008
  t->tid = nexttid++;
8010368c:	8d 50 01             	lea    0x1(%eax),%edx
  p->threads = ptable.ttable[i].threads;
8010368f:	89 7b 74             	mov    %edi,0x74(%ebx)
  release(&ptable.lock);
80103692:	68 40 2d 11 80       	push   $0x80112d40
  t->tid = nexttid++;
80103697:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
8010369d:	89 47 08             	mov    %eax,0x8(%edi)
  release(&ptable.lock);
801036a0:	e8 7b 0f 00 00       	call   80104620 <release>

  // TODO: check if kstack is needed for process
  // Allocate kernel stack for the process.
  if((p->kstack = kalloc()) == 0){
801036a5:	e8 36 ee ff ff       	call   801024e0 <kalloc>
801036aa:	83 c4 10             	add    $0x10,%esp
801036ad:	85 c0                	test   %eax,%eax
801036af:	89 43 08             	mov    %eax,0x8(%ebx)
801036b2:	74 68                	je     8010371c <allocproc+0xfc>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Allocate kernel stack for the thread.
  if((t->kstack = kalloc()) == 0){
801036b4:	e8 27 ee ff ff       	call   801024e0 <kalloc>
801036b9:	85 c0                	test   %eax,%eax
801036bb:	89 86 40 2d 11 80    	mov    %eax,-0x7feed2c0(%esi)
801036c1:	74 64                	je     80103727 <allocproc+0x107>
    return 0;
  }
  sp = t->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *t->tf;
801036c3:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
801036c9:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *t->context;
801036cc:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *t->tf;
801036d1:	89 57 10             	mov    %edx,0x10(%edi)
  *(uint*)sp = (uint)trapret;
801036d4:	c7 40 14 72 58 10 80 	movl   $0x80105872,0x14(%eax)
  memset(t->context, 0, sizeof *t->context);
801036db:	6a 14                	push   $0x14
801036dd:	6a 00                	push   $0x0
801036df:	50                   	push   %eax
  t->context = (struct context*)sp;
801036e0:	89 47 14             	mov    %eax,0x14(%edi)
  memset(t->context, 0, sizeof *t->context);
801036e3:	e8 88 0f 00 00       	call   80104670 <memset>
  t->context->eip = (uint)forkret;
801036e8:	8b 47 14             	mov    0x14(%edi),%eax

  return p;
801036eb:	83 c4 10             	add    $0x10,%esp
  t->context->eip = (uint)forkret;
801036ee:	c7 40 10 40 37 10 80 	movl   $0x80103740,0x10(%eax)
}
801036f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036f8:	89 d8                	mov    %ebx,%eax
801036fa:	5b                   	pop    %ebx
801036fb:	5e                   	pop    %esi
801036fc:	5f                   	pop    %edi
801036fd:	5d                   	pop    %ebp
801036fe:	c3                   	ret    
801036ff:	90                   	nop
  release(&ptable.lock);
80103700:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103703:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103705:	68 40 2d 11 80       	push   $0x80112d40
8010370a:	e8 11 0f 00 00       	call   80104620 <release>
  return 0;
8010370f:	83 c4 10             	add    $0x10,%esp
}
80103712:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103715:	89 d8                	mov    %ebx,%eax
80103717:	5b                   	pop    %ebx
80103718:	5e                   	pop    %esi
80103719:	5f                   	pop    %edi
8010371a:	5d                   	pop    %ebp
8010371b:	c3                   	ret    
    p->state = UNUSED;
8010371c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103723:	31 db                	xor    %ebx,%ebx
80103725:	eb ce                	jmp    801036f5 <allocproc+0xd5>
    t->state = UNUSED;
80103727:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%edi)
    return 0;
8010372e:	31 db                	xor    %ebx,%ebx
80103730:	eb c3                	jmp    801036f5 <allocproc+0xd5>
80103732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103740 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103746:	68 40 2d 11 80       	push   $0x80112d40
8010374b:	e8 d0 0e 00 00       	call   80104620 <release>

  if (first) {
80103750:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103755:	83 c4 10             	add    $0x10,%esp
80103758:	85 c0                	test   %eax,%eax
8010375a:	75 04                	jne    80103760 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010375c:	c9                   	leave  
8010375d:	c3                   	ret    
8010375e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103760:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103763:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010376a:	00 00 00 
    iinit(ROOTDEV);
8010376d:	6a 01                	push   $0x1
8010376f:	e8 2c dd ff ff       	call   801014a0 <iinit>
    initlog(ROOTDEV);
80103774:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010377b:	e8 a0 f3 ff ff       	call   80102b20 <initlog>
80103780:	83 c4 10             	add    $0x10,%esp
}
80103783:	c9                   	leave  
80103784:	c3                   	ret    
80103785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103790 <pinit>:
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103796:	68 35 76 10 80       	push   $0x80107635
8010379b:	68 40 2d 11 80       	push   $0x80112d40
801037a0:	e8 7b 0c 00 00       	call   80104420 <initlock>
}
801037a5:	83 c4 10             	add    $0x10,%esp
801037a8:	c9                   	leave  
801037a9:	c3                   	ret    
801037aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037b0 <mycpu>:
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	56                   	push   %esi
801037b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037b5:	9c                   	pushf  
801037b6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801037b7:	f6 c4 02             	test   $0x2,%ah
801037ba:	75 5e                	jne    8010381a <mycpu+0x6a>
  apicid = lapicid();
801037bc:	e8 8f ef ff ff       	call   80102750 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801037c1:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
801037c7:	85 f6                	test   %esi,%esi
801037c9:	7e 42                	jle    8010380d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037cb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
801037d2:	39 d0                	cmp    %edx,%eax
801037d4:	74 30                	je     80103806 <mycpu+0x56>
801037d6:	b9 34 28 11 80       	mov    $0x80112834,%ecx
  for (i = 0; i < ncpu; ++i) {
801037db:	31 d2                	xor    %edx,%edx
801037dd:	8d 76 00             	lea    0x0(%esi),%esi
801037e0:	83 c2 01             	add    $0x1,%edx
801037e3:	39 f2                	cmp    %esi,%edx
801037e5:	74 26                	je     8010380d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037e7:	0f b6 19             	movzbl (%ecx),%ebx
801037ea:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
801037f0:	39 c3                	cmp    %eax,%ebx
801037f2:	75 ec                	jne    801037e0 <mycpu+0x30>
801037f4:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
801037fa:	05 80 27 11 80       	add    $0x80112780,%eax
}
801037ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103802:	5b                   	pop    %ebx
80103803:	5e                   	pop    %esi
80103804:	5d                   	pop    %ebp
80103805:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103806:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010380b:	eb f2                	jmp    801037ff <mycpu+0x4f>
  panic("unknown apicid\n");
8010380d:	83 ec 0c             	sub    $0xc,%esp
80103810:	68 3c 76 10 80       	push   $0x8010763c
80103815:	e8 76 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010381a:	83 ec 0c             	sub    $0xc,%esp
8010381d:	68 18 77 10 80       	push   $0x80107718
80103822:	e8 69 cb ff ff       	call   80100390 <panic>
80103827:	89 f6                	mov    %esi,%esi
80103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103830 <cpuid>:
cpuid() {
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103836:	e8 75 ff ff ff       	call   801037b0 <mycpu>
8010383b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103840:	c9                   	leave  
  return mycpu()-cpus;
80103841:	c1 f8 02             	sar    $0x2,%eax
80103844:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
8010384a:	c3                   	ret    
8010384b:	90                   	nop
8010384c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103850 <myproc>:
myproc(void) {
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	53                   	push   %ebx
80103854:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103857:	e8 34 0c 00 00       	call   80104490 <pushcli>
  c = mycpu();
8010385c:	e8 4f ff ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103861:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103867:	e8 64 0c 00 00       	call   801044d0 <popcli>
}
8010386c:	83 c4 04             	add    $0x4,%esp
8010386f:	89 d8                	mov    %ebx,%eax
80103871:	5b                   	pop    %ebx
80103872:	5d                   	pop    %ebp
80103873:	c3                   	ret    
80103874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010387a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103880 <mythread>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103887:	e8 04 0c 00 00       	call   80104490 <pushcli>
  c = mycpu();
8010388c:	e8 1f ff ff ff       	call   801037b0 <mycpu>
  t = c->thread;
80103891:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103897:	e8 34 0c 00 00       	call   801044d0 <popcli>
}
8010389c:	83 c4 04             	add    $0x4,%esp
8010389f:	89 d8                	mov    %ebx,%eax
801038a1:	5b                   	pop    %ebx
801038a2:	5d                   	pop    %ebp
801038a3:	c3                   	ret    
801038a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038b0 <userinit>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	56                   	push   %esi
801038b4:	53                   	push   %ebx
  p = allocproc();
801038b5:	e8 66 fd ff ff       	call   80103620 <allocproc>
801038ba:	89 c6                	mov    %eax,%esi
  initproc = p;
801038bc:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038c1:	e8 7a 35 00 00       	call   80106e40 <setupkvm>
801038c6:	85 c0                	test   %eax,%eax
801038c8:	89 46 04             	mov    %eax,0x4(%esi)
801038cb:	0f 84 c9 00 00 00    	je     8010399a <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038d1:	83 ec 04             	sub    $0x4,%esp
801038d4:	68 2c 00 00 00       	push   $0x2c
801038d9:	68 60 a4 10 80       	push   $0x8010a460
801038de:	50                   	push   %eax
801038df:	e8 3c 32 00 00       	call   80106b20 <inituvm>
  t = p->threads;
801038e4:	8b 5e 74             	mov    0x74(%esi),%ebx
  memset(t->tf, 0, sizeof(*t->tf));
801038e7:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801038ea:	c7 06 00 10 00 00    	movl   $0x1000,(%esi)
  memset(t->tf, 0, sizeof(*t->tf));
801038f0:	6a 4c                	push   $0x4c
801038f2:	6a 00                	push   $0x0
801038f4:	ff 73 10             	pushl  0x10(%ebx)
801038f7:	e8 74 0d 00 00       	call   80104670 <memset>
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038fc:	8b 43 10             	mov    0x10(%ebx),%eax
801038ff:	ba 1b 00 00 00       	mov    $0x1b,%edx
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103904:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103909:	83 c4 0c             	add    $0xc,%esp
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010390c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103910:	8b 43 10             	mov    0x10(%ebx),%eax
80103913:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  t->tf->es = t->tf->ds;
80103917:	8b 43 10             	mov    0x10(%ebx),%eax
8010391a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010391e:	66 89 50 28          	mov    %dx,0x28(%eax)
  t->tf->ss = t->tf->ds;
80103922:	8b 43 10             	mov    0x10(%ebx),%eax
80103925:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103929:	66 89 50 48          	mov    %dx,0x48(%eax)
  t->tf->eflags = FL_IF;
8010392d:	8b 43 10             	mov    0x10(%ebx),%eax
80103930:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  t->tf->esp = PGSIZE;
80103937:	8b 43 10             	mov    0x10(%ebx),%eax
8010393a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  t->tf->eip = 0;  // beginning of initcode.S
80103941:	8b 43 10             	mov    0x10(%ebx),%eax
80103944:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010394b:	8d 46 64             	lea    0x64(%esi),%eax
8010394e:	6a 10                	push   $0x10
80103950:	68 65 76 10 80       	push   $0x80107665
80103955:	50                   	push   %eax
80103956:	e8 f5 0e 00 00       	call   80104850 <safestrcpy>
  p->cwd = namei("/");
8010395b:	c7 04 24 6e 76 10 80 	movl   $0x8010766e,(%esp)
80103962:	e8 99 e5 ff ff       	call   80101f00 <namei>
80103967:	89 46 60             	mov    %eax,0x60(%esi)
  acquire(&ptable.lock);
8010396a:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103971:	e8 ea 0b 00 00       	call   80104560 <acquire>
  p->state = RUNNABLE;
80103976:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  t->state = RUNNABLE;
8010397d:	c7 43 04 03 00 00 00 	movl   $0x3,0x4(%ebx)
  release(&ptable.lock);
80103984:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010398b:	e8 90 0c 00 00       	call   80104620 <release>
}
80103990:	83 c4 10             	add    $0x10,%esp
80103993:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103996:	5b                   	pop    %ebx
80103997:	5e                   	pop    %esi
80103998:	5d                   	pop    %ebp
80103999:	c3                   	ret    
    panic("userinit: out of memory?");
8010399a:	83 ec 0c             	sub    $0xc,%esp
8010399d:	68 4c 76 10 80       	push   $0x8010764c
801039a2:	e8 e9 c9 ff ff       	call   80100390 <panic>
801039a7:	89 f6                	mov    %esi,%esi
801039a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039b0 <growproc>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	56                   	push   %esi
801039b4:	53                   	push   %ebx
801039b5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039b8:	e8 d3 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
801039bd:	e8 ee fd ff ff       	call   801037b0 <mycpu>
  p = c->proc;
801039c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039c8:	e8 03 0b 00 00       	call   801044d0 <popcli>
  if(n > 0){
801039cd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039d0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039d2:	7f 1c                	jg     801039f0 <growproc+0x40>
  } else if(n < 0){
801039d4:	75 3a                	jne    80103a10 <growproc+0x60>
  switchuvm(curproc);
801039d6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039d9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039db:	53                   	push   %ebx
801039dc:	e8 2f 30 00 00       	call   80106a10 <switchuvm>
  return 0;
801039e1:	83 c4 10             	add    $0x10,%esp
801039e4:	31 c0                	xor    %eax,%eax
}
801039e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039e9:	5b                   	pop    %ebx
801039ea:	5e                   	pop    %esi
801039eb:	5d                   	pop    %ebp
801039ec:	c3                   	ret    
801039ed:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039f0:	83 ec 04             	sub    $0x4,%esp
801039f3:	01 c6                	add    %eax,%esi
801039f5:	56                   	push   %esi
801039f6:	50                   	push   %eax
801039f7:	ff 73 04             	pushl  0x4(%ebx)
801039fa:	e8 61 32 00 00       	call   80106c60 <allocuvm>
801039ff:	83 c4 10             	add    $0x10,%esp
80103a02:	85 c0                	test   %eax,%eax
80103a04:	75 d0                	jne    801039d6 <growproc+0x26>
      return -1;
80103a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a0b:	eb d9                	jmp    801039e6 <growproc+0x36>
80103a0d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a10:	83 ec 04             	sub    $0x4,%esp
80103a13:	01 c6                	add    %eax,%esi
80103a15:	56                   	push   %esi
80103a16:	50                   	push   %eax
80103a17:	ff 73 04             	pushl  0x4(%ebx)
80103a1a:	e8 71 33 00 00       	call   80106d90 <deallocuvm>
80103a1f:	83 c4 10             	add    $0x10,%esp
80103a22:	85 c0                	test   %eax,%eax
80103a24:	75 b0                	jne    801039d6 <growproc+0x26>
80103a26:	eb de                	jmp    80103a06 <growproc+0x56>
80103a28:	90                   	nop
80103a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a30 <fork>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	57                   	push   %edi
80103a34:	56                   	push   %esi
80103a35:	53                   	push   %ebx
80103a36:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a39:	e8 52 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103a3e:	e8 6d fd ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103a43:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80103a49:	89 55 e0             	mov    %edx,-0x20(%ebp)
  popcli();
80103a4c:	e8 7f 0a 00 00       	call   801044d0 <popcli>
  pushcli();
80103a51:	e8 3a 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103a56:	e8 55 fd ff ff       	call   801037b0 <mycpu>
  t = c->thread;
80103a5b:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80103a61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80103a64:	e8 67 0a 00 00       	call   801044d0 <popcli>
  if((np = allocproc()) == 0){
80103a69:	e8 b2 fb ff ff       	call   80103620 <allocproc>
80103a6e:	85 c0                	test   %eax,%eax
80103a70:	0f 84 e9 00 00 00    	je     80103b5f <fork+0x12f>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a76:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103a79:	83 ec 08             	sub    $0x8,%esp
80103a7c:	89 c3                	mov    %eax,%ebx
80103a7e:	ff 32                	pushl  (%edx)
80103a80:	ff 72 04             	pushl  0x4(%edx)
80103a83:	e8 88 34 00 00       	call   80106f10 <copyuvm>
80103a88:	83 c4 10             	add    $0x10,%esp
80103a8b:	85 c0                	test   %eax,%eax
80103a8d:	89 43 04             	mov    %eax,0x4(%ebx)
80103a90:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103a93:	0f 84 cd 00 00 00    	je     80103b66 <fork+0x136>
  np->sz = curproc->sz;
80103a99:	8b 02                	mov    (%edx),%eax
  np->parent = curproc;
80103a9b:	89 53 14             	mov    %edx,0x14(%ebx)
  *np->threads->tf = *curthread->tf;
80103a9e:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103aa3:	89 03                	mov    %eax,(%ebx)
  *np->threads->tf = *curthread->tf;
80103aa5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103aa8:	8b 70 10             	mov    0x10(%eax),%esi
80103aab:	8b 43 74             	mov    0x74(%ebx),%eax
80103aae:	8b 40 10             	mov    0x10(%eax),%eax
80103ab1:	89 c7                	mov    %eax,%edi
80103ab3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->threads->kstack = curthread->kstack;
80103ab5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  for(i = 0; i < NOFILE; i++)
80103ab8:	31 f6                	xor    %esi,%esi
80103aba:	89 d7                	mov    %edx,%edi
  np->threads->tproc = np;
80103abc:	8b 43 74             	mov    0x74(%ebx),%eax
80103abf:	89 58 0c             	mov    %ebx,0xc(%eax)
  np->threads->kstack = curthread->kstack;
80103ac2:	8b 43 74             	mov    0x74(%ebx),%eax
80103ac5:	8b 09                	mov    (%ecx),%ecx
80103ac7:	89 08                	mov    %ecx,(%eax)
  np->threads->tf->eax = 0;
80103ac9:	8b 43 74             	mov    0x74(%ebx),%eax
80103acc:	8b 40 10             	mov    0x10(%eax),%eax
80103acf:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103ad6:	8d 76 00             	lea    0x0(%esi),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103ae0:	8b 44 b7 20          	mov    0x20(%edi,%esi,4),%eax
80103ae4:	85 c0                	test   %eax,%eax
80103ae6:	74 10                	je     80103af8 <fork+0xc8>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ae8:	83 ec 0c             	sub    $0xc,%esp
80103aeb:	50                   	push   %eax
80103aec:	e8 0f d3 ff ff       	call   80100e00 <filedup>
80103af1:	83 c4 10             	add    $0x10,%esp
80103af4:	89 44 b3 20          	mov    %eax,0x20(%ebx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103af8:	83 c6 01             	add    $0x1,%esi
80103afb:	83 fe 10             	cmp    $0x10,%esi
80103afe:	75 e0                	jne    80103ae0 <fork+0xb0>
  np->cwd = idup(curproc->cwd);
80103b00:	83 ec 0c             	sub    $0xc,%esp
80103b03:	ff 77 60             	pushl  0x60(%edi)
80103b06:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80103b09:	e8 62 db ff ff       	call   80101670 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b0e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->cwd = idup(curproc->cwd);
80103b11:	89 43 60             	mov    %eax,0x60(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b14:	8d 43 64             	lea    0x64(%ebx),%eax
80103b17:	83 c4 0c             	add    $0xc,%esp
80103b1a:	6a 10                	push   $0x10
80103b1c:	83 c2 64             	add    $0x64,%edx
80103b1f:	52                   	push   %edx
80103b20:	50                   	push   %eax
80103b21:	e8 2a 0d 00 00       	call   80104850 <safestrcpy>
  pid = np->pid;
80103b26:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103b29:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103b30:	e8 2b 0a 00 00       	call   80104560 <acquire>
  np->threads->state = RUNNABLE;
80103b35:	8b 43 74             	mov    0x74(%ebx),%eax
  np->state = RUNNABLE;
80103b38:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  np->threads->state = RUNNABLE;
80103b3f:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
  release(&ptable.lock);
80103b46:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103b4d:	e8 ce 0a 00 00       	call   80104620 <release>
  return pid;
80103b52:	83 c4 10             	add    $0x10,%esp
}
80103b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b58:	89 f0                	mov    %esi,%eax
80103b5a:	5b                   	pop    %ebx
80103b5b:	5e                   	pop    %esi
80103b5c:	5f                   	pop    %edi
80103b5d:	5d                   	pop    %ebp
80103b5e:	c3                   	ret    
    return -1;
80103b5f:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103b64:	eb ef                	jmp    80103b55 <fork+0x125>
    kfree(np->kstack);
80103b66:	83 ec 0c             	sub    $0xc,%esp
80103b69:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103b6c:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103b71:	e8 ba e7 ff ff       	call   80102330 <kfree>
    np->kstack = 0;
80103b76:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b7d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b84:	83 c4 10             	add    $0x10,%esp
80103b87:	eb cc                	jmp    80103b55 <fork+0x125>
80103b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b90 <scheduler>:
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	57                   	push   %edi
80103b94:	56                   	push   %esi
80103b95:	53                   	push   %ebx
          threadReady = 1;
80103b96:	bb 01 00 00 00       	mov    $0x1,%ebx
{
80103b9b:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103b9e:	e8 0d fc ff ff       	call   801037b0 <mycpu>
  c->proc = 0;
80103ba3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103baa:	00 00 00 
  c->thread = 0;
80103bad:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103bb4:	00 00 00 
  struct cpu *c = mycpu();
80103bb7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103bba:	83 c0 04             	add    $0x4,%eax
80103bbd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("sti");
80103bc0:	fb                   	sti    
    acquire(&ptable.lock);
80103bc1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bc4:	be 74 2d 11 80       	mov    $0x80112d74,%esi
    acquire(&ptable.lock);
80103bc9:	68 40 2d 11 80       	push   $0x80112d40
80103bce:	e8 8d 09 00 00       	call   80104560 <acquire>
80103bd3:	83 c4 10             	add    $0x10,%esp
80103bd6:	8d 76 00             	lea    0x0(%esi),%esi
80103bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        t = &p->threads[i];
80103be0:	8b 7e 74             	mov    0x74(%esi),%edi
      int threadReady = 0;
80103be3:	31 d2                	xor    %edx,%edx
80103be5:	8d 47 04             	lea    0x4(%edi),%eax
80103be8:	8d 8f c4 01 00 00    	lea    0x1c4(%edi),%ecx
80103bee:	66 90                	xchg   %ax,%ax
          threadReady = 1;
80103bf0:	83 38 03             	cmpl   $0x3,(%eax)
80103bf3:	0f 44 d3             	cmove  %ebx,%edx
80103bf6:	83 c0 1c             	add    $0x1c,%eax
      for (int i = 0; i < NTHREAD; i++){
80103bf9:	39 c8                	cmp    %ecx,%eax
80103bfb:	75 f3                	jne    80103bf0 <scheduler+0x60>
      if(!threadReady)
80103bfd:	85 d2                	test   %edx,%edx
80103bff:	8d 87 a4 01 00 00    	lea    0x1a4(%edi),%eax
80103c05:	74 58                	je     80103c5f <scheduler+0xcf>
      c->proc = p;
80103c07:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      switchuvm(p);
80103c0a:	83 ec 0c             	sub    $0xc,%esp
      c->thread = t;
80103c0d:	89 81 b0 00 00 00    	mov    %eax,0xb0(%ecx)
      c->proc = p;
80103c13:	89 b1 ac 00 00 00    	mov    %esi,0xac(%ecx)
      switchuvm(p);
80103c19:	56                   	push   %esi
80103c1a:	e8 f1 2d 00 00       	call   80106a10 <switchuvm>
      p->state = RUNNING;
80103c1f:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      t->state = RUNNING;
80103c26:	c7 87 a8 01 00 00 04 	movl   $0x4,0x1a8(%edi)
80103c2d:	00 00 00 
      swtch(&(c->scheduler), t->context);
80103c30:	58                   	pop    %eax
80103c31:	5a                   	pop    %edx
80103c32:	ff b7 b8 01 00 00    	pushl  0x1b8(%edi)
80103c38:	ff 75 e0             	pushl  -0x20(%ebp)
80103c3b:	e8 6b 0c 00 00       	call   801048ab <swtch>
      switchkvm();
80103c40:	e8 ab 2d 00 00       	call   801069f0 <switchkvm>
      c->proc = 0;
80103c45:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      c->thread = 0;
80103c48:	83 c4 10             	add    $0x10,%esp
      c->proc = 0;
80103c4b:	c7 81 ac 00 00 00 00 	movl   $0x0,0xac(%ecx)
80103c52:	00 00 00 
      c->thread = 0;
80103c55:	c7 81 b0 00 00 00 00 	movl   $0x0,0xb0(%ecx)
80103c5c:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c5f:	83 c6 78             	add    $0x78,%esi
80103c62:	81 fe 74 4b 11 80    	cmp    $0x80114b74,%esi
80103c68:	0f 82 72 ff ff ff    	jb     80103be0 <scheduler+0x50>
    release(&ptable.lock);
80103c6e:	83 ec 0c             	sub    $0xc,%esp
80103c71:	68 40 2d 11 80       	push   $0x80112d40
80103c76:	e8 a5 09 00 00       	call   80104620 <release>
    sti();
80103c7b:	83 c4 10             	add    $0x10,%esp
80103c7e:	e9 3d ff ff ff       	jmp    80103bc0 <scheduler+0x30>
80103c83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c90 <sched>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	56                   	push   %esi
80103c94:	53                   	push   %ebx
  pushcli();
80103c95:	e8 f6 07 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103c9a:	e8 11 fb ff ff       	call   801037b0 <mycpu>
  t = c->thread;
80103c9f:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103ca5:	e8 26 08 00 00       	call   801044d0 <popcli>
  if(!holding(&ptable.lock))
80103caa:	83 ec 0c             	sub    $0xc,%esp
80103cad:	68 40 2d 11 80       	push   $0x80112d40
80103cb2:	e8 79 08 00 00       	call   80104530 <holding>
80103cb7:	83 c4 10             	add    $0x10,%esp
80103cba:	85 c0                	test   %eax,%eax
80103cbc:	74 4f                	je     80103d0d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cbe:	e8 ed fa ff ff       	call   801037b0 <mycpu>
80103cc3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cca:	75 68                	jne    80103d34 <sched+0xa4>
  if(t->state == RUNNING)
80103ccc:	83 7b 04 04          	cmpl   $0x4,0x4(%ebx)
80103cd0:	74 55                	je     80103d27 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cd2:	9c                   	pushf  
80103cd3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cd4:	f6 c4 02             	test   $0x2,%ah
80103cd7:	75 41                	jne    80103d1a <sched+0x8a>
  intena = mycpu()->intena;
80103cd9:	e8 d2 fa ff ff       	call   801037b0 <mycpu>
  swtch(&t->context, mycpu()->scheduler);
80103cde:	83 c3 14             	add    $0x14,%ebx
  intena = mycpu()->intena;
80103ce1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&t->context, mycpu()->scheduler);
80103ce7:	e8 c4 fa ff ff       	call   801037b0 <mycpu>
80103cec:	83 ec 08             	sub    $0x8,%esp
80103cef:	ff 70 04             	pushl  0x4(%eax)
80103cf2:	53                   	push   %ebx
80103cf3:	e8 b3 0b 00 00       	call   801048ab <swtch>
  mycpu()->intena = intena;
80103cf8:	e8 b3 fa ff ff       	call   801037b0 <mycpu>
}
80103cfd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d00:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d09:	5b                   	pop    %ebx
80103d0a:	5e                   	pop    %esi
80103d0b:	5d                   	pop    %ebp
80103d0c:	c3                   	ret    
    panic("sched ptable.lock");
80103d0d:	83 ec 0c             	sub    $0xc,%esp
80103d10:	68 70 76 10 80       	push   $0x80107670
80103d15:	e8 76 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d1a:	83 ec 0c             	sub    $0xc,%esp
80103d1d:	68 9c 76 10 80       	push   $0x8010769c
80103d22:	e8 69 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d27:	83 ec 0c             	sub    $0xc,%esp
80103d2a:	68 8e 76 10 80       	push   $0x8010768e
80103d2f:	e8 5c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d34:	83 ec 0c             	sub    $0xc,%esp
80103d37:	68 82 76 10 80       	push   $0x80107682
80103d3c:	e8 4f c6 ff ff       	call   80100390 <panic>
80103d41:	eb 0d                	jmp    80103d50 <exit>
80103d43:	90                   	nop
80103d44:	90                   	nop
80103d45:	90                   	nop
80103d46:	90                   	nop
80103d47:	90                   	nop
80103d48:	90                   	nop
80103d49:	90                   	nop
80103d4a:	90                   	nop
80103d4b:	90                   	nop
80103d4c:	90                   	nop
80103d4d:	90                   	nop
80103d4e:	90                   	nop
80103d4f:	90                   	nop

80103d50 <exit>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	57                   	push   %edi
80103d54:	56                   	push   %esi
80103d55:	53                   	push   %ebx
80103d56:	81 ec dc 01 00 00    	sub    $0x1dc,%esp
  pushcli();
80103d5c:	e8 2f 07 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103d61:	e8 4a fa ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103d66:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d6c:	e8 5f 07 00 00       	call   801044d0 <popcli>
  if(curproc == initproc)
80103d71:	39 1d b8 a5 10 80    	cmp    %ebx,0x8010a5b8
80103d77:	8d 73 20             	lea    0x20(%ebx),%esi
80103d7a:	8d 7b 60             	lea    0x60(%ebx),%edi
80103d7d:	0f 84 ac 01 00 00    	je     80103f2f <exit+0x1df>
    if(curproc->ofile[fd]){
80103d83:	8b 06                	mov    (%esi),%eax
80103d85:	85 c0                	test   %eax,%eax
80103d87:	74 12                	je     80103d9b <exit+0x4b>
      fileclose(curproc->ofile[fd]);
80103d89:	83 ec 0c             	sub    $0xc,%esp
80103d8c:	50                   	push   %eax
80103d8d:	e8 be d0 ff ff       	call   80100e50 <fileclose>
      curproc->ofile[fd] = 0;
80103d92:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103d98:	83 c4 10             	add    $0x10,%esp
80103d9b:	83 c6 04             	add    $0x4,%esi
  for(fd = 0; fd < NOFILE; fd++){
80103d9e:	39 f7                	cmp    %esi,%edi
80103da0:	75 e1                	jne    80103d83 <exit+0x33>
  begin_op();
80103da2:	e8 19 ee ff ff       	call   80102bc0 <begin_op>
  iput(curproc->cwd);
80103da7:	83 ec 0c             	sub    $0xc,%esp
80103daa:	ff 73 60             	pushl  0x60(%ebx)
80103dad:	e8 1e da ff ff       	call   801017d0 <iput>
  end_op();
80103db2:	e8 79 ee ff ff       	call   80102c30 <end_op>
  curproc->cwd = 0;
80103db7:	c7 43 60 00 00 00 00 	movl   $0x0,0x60(%ebx)
  acquire(&ptable.lock);
80103dbe:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103dc5:	e8 96 07 00 00       	call   80104560 <acquire>
  wakeup1(curproc->parent);
80103dca:	8b 73 14             	mov    0x14(%ebx),%esi
80103dcd:	83 c4 10             	add    $0x10,%esp
{
  struct proc *p;
  struct kthread *t;
  int j;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dd0:	b9 74 2d 11 80       	mov    $0x80112d74,%ecx
80103dd5:	8d 76 00             	lea    0x0(%esi),%esi
{
80103dd8:	31 c0                	xor    %eax,%eax
80103dda:	eb 0e                	jmp    80103dea <exit+0x9a>
80103ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103de0:	83 c0 1c             	add    $0x1c,%eax
    for(j = 0; j < NTHREAD; j++){
80103de3:	3d c0 01 00 00       	cmp    $0x1c0,%eax
80103de8:	74 26                	je     80103e10 <exit+0xc0>
      t = &p->threads[j];
80103dea:	8b 51 74             	mov    0x74(%ecx),%edx
80103ded:	01 c2                	add    %eax,%edx
      if(t->state == SLEEPING && t->chan == chan)
80103def:	83 7a 04 02          	cmpl   $0x2,0x4(%edx)
80103df3:	75 eb                	jne    80103de0 <exit+0x90>
80103df5:	3b 72 18             	cmp    0x18(%edx),%esi
80103df8:	75 e6                	jne    80103de0 <exit+0x90>
80103dfa:	83 c0 1c             	add    $0x1c,%eax
        t->state = RUNNABLE;
80103dfd:	c7 42 04 03 00 00 00 	movl   $0x3,0x4(%edx)
    for(j = 0; j < NTHREAD; j++){
80103e04:	3d c0 01 00 00       	cmp    $0x1c0,%eax
80103e09:	75 df                	jne    80103dea <exit+0x9a>
80103e0b:	90                   	nop
80103e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e10:	83 c1 78             	add    $0x78,%ecx
80103e13:	81 f9 74 4b 11 80    	cmp    $0x80114b74,%ecx
80103e19:	72 bd                	jb     80103dd8 <exit+0x88>
      p->parent = initproc;
80103e1b:	8b 35 b8 a5 10 80    	mov    0x8010a5b8,%esi
  int index = 0, j = 0;
80103e21:	c7 85 24 fe ff ff 00 	movl   $0x0,-0x1dc(%ebp)
80103e28:	00 00 00 
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e2b:	bf 74 2d 11 80       	mov    $0x80112d74,%edi
  int index = 0, j = 0;
80103e30:	c7 85 20 fe ff ff 00 	movl   $0x0,-0x1e0(%ebp)
80103e37:	00 00 00 
80103e3a:	eb 1a                	jmp    80103e56 <exit+0x106>
80103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p == curproc)
80103e40:	39 fb                	cmp    %edi,%ebx
80103e42:	74 73                	je     80103eb7 <exit+0x167>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e44:	83 c7 78             	add    $0x78,%edi
      j++;
80103e47:	83 85 24 fe ff ff 01 	addl   $0x1,-0x1dc(%ebp)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e4e:	81 ff 74 4b 11 80    	cmp    $0x80114b74,%edi
80103e54:	73 78                	jae    80103ece <exit+0x17e>
    if(p->parent == curproc){
80103e56:	39 5f 14             	cmp    %ebx,0x14(%edi)
80103e59:	75 e5                	jne    80103e40 <exit+0xf0>
      if(p->state == ZOMBIE)
80103e5b:	83 7f 0c 05          	cmpl   $0x5,0xc(%edi)
      p->parent = initproc;
80103e5f:	89 77 14             	mov    %esi,0x14(%edi)
      if(p->state == ZOMBIE)
80103e62:	75 dc                	jne    80103e40 <exit+0xf0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e64:	b9 74 2d 11 80       	mov    $0x80112d74,%ecx
80103e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e70:	31 c0                	xor    %eax,%eax
80103e72:	eb 0e                	jmp    80103e82 <exit+0x132>
80103e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e78:	83 c0 1c             	add    $0x1c,%eax
    for(j = 0; j < NTHREAD; j++){
80103e7b:	3d c0 01 00 00       	cmp    $0x1c0,%eax
80103e80:	74 26                	je     80103ea8 <exit+0x158>
      t = &p->threads[j];
80103e82:	8b 51 74             	mov    0x74(%ecx),%edx
80103e85:	01 c2                	add    %eax,%edx
      if(t->state == SLEEPING && t->chan == chan)
80103e87:	83 7a 04 02          	cmpl   $0x2,0x4(%edx)
80103e8b:	75 eb                	jne    80103e78 <exit+0x128>
80103e8d:	3b 72 18             	cmp    0x18(%edx),%esi
80103e90:	75 e6                	jne    80103e78 <exit+0x128>
80103e92:	83 c0 1c             	add    $0x1c,%eax
        t->state = RUNNABLE;
80103e95:	c7 42 04 03 00 00 00 	movl   $0x3,0x4(%edx)
    for(j = 0; j < NTHREAD; j++){
80103e9c:	3d c0 01 00 00       	cmp    $0x1c0,%eax
80103ea1:	75 df                	jne    80103e82 <exit+0x132>
80103ea3:	90                   	nop
80103ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ea8:	83 c1 78             	add    $0x78,%ecx
80103eab:	81 f9 74 4b 11 80    	cmp    $0x80114b74,%ecx
80103eb1:	72 bd                	jb     80103e70 <exit+0x120>
    if(p == curproc)
80103eb3:	39 fb                	cmp    %edi,%ebx
80103eb5:	75 8d                	jne    80103e44 <exit+0xf4>
80103eb7:	8b 85 24 fe ff ff    	mov    -0x1dc(%ebp),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ebd:	83 c7 78             	add    $0x78,%edi
80103ec0:	81 ff 74 4b 11 80    	cmp    $0x80114b74,%edi
80103ec6:	89 85 20 fe ff ff    	mov    %eax,-0x1e0(%ebp)
80103ecc:	72 88                	jb     80103e56 <exit+0x106>
  struct threadTable procThreads = ptable.ttable[index];
80103ece:	69 b5 20 fe ff ff c0 	imul   $0x1c0,-0x1e0(%ebp),%esi
80103ed5:	01 00 00 
80103ed8:	8d bd 28 fe ff ff    	lea    -0x1d8(%ebp),%edi
80103ede:	b9 70 00 00 00       	mov    $0x70,%ecx
80103ee3:	81 c6 74 4b 11 80    	add    $0x80114b74,%esi
80103ee9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80103eeb:	8d b5 28 fe ff ff    	lea    -0x1d8(%ebp),%esi
80103ef1:	8d 7d e8             	lea    -0x18(%ebp),%edi
    kfree(t->kstack);
80103ef4:	83 ec 0c             	sub    $0xc,%esp
80103ef7:	ff 36                	pushl  (%esi)
80103ef9:	83 c6 1c             	add    $0x1c,%esi
80103efc:	e8 2f e4 ff ff       	call   80102330 <kfree>
    t->kstack = 0;
80103f01:	c7 46 e4 00 00 00 00 	movl   $0x0,-0x1c(%esi)
  for(j = 0; j < NTHREAD; j++){
80103f08:	83 c4 10             	add    $0x10,%esp
80103f0b:	39 f7                	cmp    %esi,%edi
80103f0d:	75 e5                	jne    80103ef4 <exit+0x1a4>
  curproc->state = ZOMBIE;
80103f0f:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  curproc->threads = 0;
80103f16:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
  sched();
80103f1d:	e8 6e fd ff ff       	call   80103c90 <sched>
  panic("zombie exit");
80103f22:	83 ec 0c             	sub    $0xc,%esp
80103f25:	68 bd 76 10 80       	push   $0x801076bd
80103f2a:	e8 61 c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103f2f:	83 ec 0c             	sub    $0xc,%esp
80103f32:	68 b0 76 10 80       	push   $0x801076b0
80103f37:	e8 54 c4 ff ff       	call   80100390 <panic>
80103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f40 <yield>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f47:	68 40 2d 11 80       	push   $0x80112d40
80103f4c:	e8 0f 06 00 00       	call   80104560 <acquire>
  pushcli();
80103f51:	e8 3a 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103f56:	e8 55 f8 ff ff       	call   801037b0 <mycpu>
  t = c->thread;
80103f5b:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103f61:	e8 6a 05 00 00       	call   801044d0 <popcli>
  mythread()->state = RUNNABLE;
80103f66:	c7 43 04 03 00 00 00 	movl   $0x3,0x4(%ebx)
  sched();
80103f6d:	e8 1e fd ff ff       	call   80103c90 <sched>
  release(&ptable.lock);
80103f72:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f79:	e8 a2 06 00 00       	call   80104620 <release>
}
80103f7e:	83 c4 10             	add    $0x10,%esp
80103f81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f84:	c9                   	leave  
80103f85:	c3                   	ret    
80103f86:	8d 76 00             	lea    0x0(%esi),%esi
80103f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f90 <sleep>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	57                   	push   %edi
80103f94:	56                   	push   %esi
80103f95:	53                   	push   %ebx
80103f96:	83 ec 0c             	sub    $0xc,%esp
80103f99:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103f9f:	e8 ec 04 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103fa4:	e8 07 f8 ff ff       	call   801037b0 <mycpu>
  t = c->thread;
80103fa9:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103faf:	e8 1c 05 00 00       	call   801044d0 <popcli>
  if(t == 0)
80103fb4:	85 db                	test   %ebx,%ebx
80103fb6:	0f 84 87 00 00 00    	je     80104043 <sleep+0xb3>
  if(lk == 0)
80103fbc:	85 f6                	test   %esi,%esi
80103fbe:	74 76                	je     80104036 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103fc0:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103fc6:	74 50                	je     80104018 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103fc8:	83 ec 0c             	sub    $0xc,%esp
80103fcb:	68 40 2d 11 80       	push   $0x80112d40
80103fd0:	e8 8b 05 00 00       	call   80104560 <acquire>
    release(lk);
80103fd5:	89 34 24             	mov    %esi,(%esp)
80103fd8:	e8 43 06 00 00       	call   80104620 <release>
  t->chan = chan;
80103fdd:	89 7b 18             	mov    %edi,0x18(%ebx)
  t->state = SLEEPING;
80103fe0:	c7 43 04 02 00 00 00 	movl   $0x2,0x4(%ebx)
  sched();
80103fe7:	e8 a4 fc ff ff       	call   80103c90 <sched>
  t->chan = 0;
80103fec:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
    release(&ptable.lock);
80103ff3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103ffa:	e8 21 06 00 00       	call   80104620 <release>
    acquire(lk);
80103fff:	89 75 08             	mov    %esi,0x8(%ebp)
80104002:	83 c4 10             	add    $0x10,%esp
}
80104005:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104008:	5b                   	pop    %ebx
80104009:	5e                   	pop    %esi
8010400a:	5f                   	pop    %edi
8010400b:	5d                   	pop    %ebp
    acquire(lk);
8010400c:	e9 4f 05 00 00       	jmp    80104560 <acquire>
80104011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  t->chan = chan;
80104018:	89 7b 18             	mov    %edi,0x18(%ebx)
  t->state = SLEEPING;
8010401b:	c7 43 04 02 00 00 00 	movl   $0x2,0x4(%ebx)
  sched();
80104022:	e8 69 fc ff ff       	call   80103c90 <sched>
  t->chan = 0;
80104027:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
}
8010402e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104031:	5b                   	pop    %ebx
80104032:	5e                   	pop    %esi
80104033:	5f                   	pop    %edi
80104034:	5d                   	pop    %ebp
80104035:	c3                   	ret    
    panic("sleep without lk");
80104036:	83 ec 0c             	sub    $0xc,%esp
80104039:	68 cf 76 10 80       	push   $0x801076cf
8010403e:	e8 4d c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80104043:	83 ec 0c             	sub    $0xc,%esp
80104046:	68 c9 76 10 80       	push   $0x801076c9
8010404b:	e8 40 c3 ff ff       	call   80100390 <panic>

80104050 <wait>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	56                   	push   %esi
80104054:	53                   	push   %ebx
  pushcli();
80104055:	e8 36 04 00 00       	call   80104490 <pushcli>
  c = mycpu();
8010405a:	e8 51 f7 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
8010405f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104065:	e8 66 04 00 00       	call   801044d0 <popcli>
  acquire(&ptable.lock);
8010406a:	83 ec 0c             	sub    $0xc,%esp
8010406d:	68 40 2d 11 80       	push   $0x80112d40
80104072:	e8 e9 04 00 00       	call   80104560 <acquire>
80104077:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010407a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010407c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104081:	eb 10                	jmp    80104093 <wait+0x43>
80104083:	90                   	nop
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104088:	83 c3 78             	add    $0x78,%ebx
8010408b:	81 fb 74 4b 11 80    	cmp    $0x80114b74,%ebx
80104091:	73 1b                	jae    801040ae <wait+0x5e>
      if(p->parent != curproc)
80104093:	39 73 14             	cmp    %esi,0x14(%ebx)
80104096:	75 f0                	jne    80104088 <wait+0x38>
      if(p->state == ZOMBIE){
80104098:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010409c:	74 32                	je     801040d0 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409e:	83 c3 78             	add    $0x78,%ebx
      havekids = 1;
801040a1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040a6:	81 fb 74 4b 11 80    	cmp    $0x80114b74,%ebx
801040ac:	72 e5                	jb     80104093 <wait+0x43>
    if(!havekids || curproc->killed){
801040ae:	85 c0                	test   %eax,%eax
801040b0:	74 74                	je     80104126 <wait+0xd6>
801040b2:	8b 46 1c             	mov    0x1c(%esi),%eax
801040b5:	85 c0                	test   %eax,%eax
801040b7:	75 6d                	jne    80104126 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801040b9:	83 ec 08             	sub    $0x8,%esp
801040bc:	68 40 2d 11 80       	push   $0x80112d40
801040c1:	56                   	push   %esi
801040c2:	e8 c9 fe ff ff       	call   80103f90 <sleep>
    havekids = 0;
801040c7:	83 c4 10             	add    $0x10,%esp
801040ca:	eb ae                	jmp    8010407a <wait+0x2a>
801040cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801040d0:	83 ec 0c             	sub    $0xc,%esp
801040d3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801040d6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801040d9:	e8 52 e2 ff ff       	call   80102330 <kfree>
        freevm(p->pgdir);
801040de:	5a                   	pop    %edx
801040df:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801040e2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801040e9:	e8 d2 2c 00 00       	call   80106dc0 <freevm>
        release(&ptable.lock);
801040ee:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        p->pid = 0;
801040f5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801040fc:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104103:	c6 43 64 00          	movb   $0x0,0x64(%ebx)
        p->killed = 0;
80104107:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
        p->state = UNUSED;
8010410e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104115:	e8 06 05 00 00       	call   80104620 <release>
        return pid;
8010411a:	83 c4 10             	add    $0x10,%esp
}
8010411d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104120:	89 f0                	mov    %esi,%eax
80104122:	5b                   	pop    %ebx
80104123:	5e                   	pop    %esi
80104124:	5d                   	pop    %ebp
80104125:	c3                   	ret    
      release(&ptable.lock);
80104126:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104129:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010412e:	68 40 2d 11 80       	push   $0x80112d40
80104133:	e8 e8 04 00 00       	call   80104620 <release>
      return -1;
80104138:	83 c4 10             	add    $0x10,%esp
8010413b:	eb e0                	jmp    8010411d <wait+0xcd>
8010413d:	8d 76 00             	lea    0x0(%esi),%esi

80104140 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 10             	sub    $0x10,%esp
80104147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010414a:	68 40 2d 11 80       	push   $0x80112d40
8010414f:	e8 0c 04 00 00       	call   80104560 <acquire>
80104154:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104157:	b9 74 2d 11 80       	mov    $0x80112d74,%ecx
8010415c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
80104160:	31 c0                	xor    %eax,%eax
80104162:	eb 0e                	jmp    80104172 <wakeup+0x32>
80104164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104168:	83 c0 1c             	add    $0x1c,%eax
    for(j = 0; j < NTHREAD; j++){
8010416b:	3d c0 01 00 00       	cmp    $0x1c0,%eax
80104170:	74 26                	je     80104198 <wakeup+0x58>
      t = &p->threads[j];
80104172:	8b 51 74             	mov    0x74(%ecx),%edx
80104175:	01 c2                	add    %eax,%edx
      if(t->state == SLEEPING && t->chan == chan)
80104177:	83 7a 04 02          	cmpl   $0x2,0x4(%edx)
8010417b:	75 eb                	jne    80104168 <wakeup+0x28>
8010417d:	3b 5a 18             	cmp    0x18(%edx),%ebx
80104180:	75 e6                	jne    80104168 <wakeup+0x28>
80104182:	83 c0 1c             	add    $0x1c,%eax
        t->state = RUNNABLE;
80104185:	c7 42 04 03 00 00 00 	movl   $0x3,0x4(%edx)
    for(j = 0; j < NTHREAD; j++){
8010418c:	3d c0 01 00 00       	cmp    $0x1c0,%eax
80104191:	75 df                	jne    80104172 <wakeup+0x32>
80104193:	90                   	nop
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104198:	83 c1 78             	add    $0x78,%ecx
8010419b:	81 f9 74 4b 11 80    	cmp    $0x80114b74,%ecx
801041a1:	72 bd                	jb     80104160 <wakeup+0x20>
  wakeup1(chan);
  release(&ptable.lock);
801041a3:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801041aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041ad:	c9                   	leave  
  release(&ptable.lock);
801041ae:	e9 6d 04 00 00       	jmp    80104620 <release>
801041b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041c0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	53                   	push   %ebx
801041c4:	83 ec 10             	sub    $0x10,%esp
801041c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041ca:	68 40 2d 11 80       	push   $0x80112d40
801041cf:	e8 8c 03 00 00       	call   80104560 <acquire>
801041d4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041d7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801041dc:	eb 0c                	jmp    801041ea <kill+0x2a>
801041de:	66 90                	xchg   %ax,%ax
801041e0:	83 c0 78             	add    $0x78,%eax
801041e3:	3d 74 4b 11 80       	cmp    $0x80114b74,%eax
801041e8:	73 36                	jae    80104220 <kill+0x60>
    if(p->pid == pid){
801041ea:	39 58 10             	cmp    %ebx,0x10(%eax)
801041ed:	75 f1                	jne    801041e0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801041ef:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801041f3:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
      if(p->state == SLEEPING)
801041fa:	75 07                	jne    80104203 <kill+0x43>
        p->state = RUNNABLE;
801041fc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104203:	83 ec 0c             	sub    $0xc,%esp
80104206:	68 40 2d 11 80       	push   $0x80112d40
8010420b:	e8 10 04 00 00       	call   80104620 <release>
      return 0;
80104210:	83 c4 10             	add    $0x10,%esp
80104213:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104215:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104218:	c9                   	leave  
80104219:	c3                   	ret    
8010421a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104220:	83 ec 0c             	sub    $0xc,%esp
80104223:	68 40 2d 11 80       	push   $0x80112d40
80104228:	e8 f3 03 00 00       	call   80104620 <release>
  return -1;
8010422d:	83 c4 10             	add    $0x10,%esp
80104230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104235:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104238:	c9                   	leave  
80104239:	c3                   	ret    
8010423a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104240 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	57                   	push   %edi
80104244:	56                   	push   %esi
80104245:	53                   	push   %ebx
80104246:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104249:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
8010424e:	83 ec 3c             	sub    $0x3c,%esp
80104251:	eb 20                	jmp    80104273 <procdump+0x33>
80104253:	90                   	nop
80104254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      //getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104258:	83 ec 0c             	sub    $0xc,%esp
8010425b:	68 57 7a 10 80       	push   $0x80107a57
80104260:	e8 fb c3 ff ff       	call   80100660 <cprintf>
80104265:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104268:	83 c3 78             	add    $0x78,%ebx
8010426b:	81 fb 74 4b 11 80    	cmp    $0x80114b74,%ebx
80104271:	73 6d                	jae    801042e0 <procdump+0xa0>
    if(p->state == UNUSED)
80104273:	8b 43 0c             	mov    0xc(%ebx),%eax
80104276:	85 c0                	test   %eax,%eax
80104278:	74 ee                	je     80104268 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010427a:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
8010427d:	ba e0 76 10 80       	mov    $0x801076e0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104282:	77 11                	ja     80104295 <procdump+0x55>
80104284:	8b 14 85 40 77 10 80 	mov    -0x7fef88c0(,%eax,4),%edx
      state = "???";
8010428b:	b8 e0 76 10 80       	mov    $0x801076e0,%eax
80104290:	85 d2                	test   %edx,%edx
80104292:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104295:	8d 43 64             	lea    0x64(%ebx),%eax
80104298:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010429b:	50                   	push   %eax
8010429c:	52                   	push   %edx
8010429d:	ff 73 10             	pushl  0x10(%ebx)
801042a0:	68 e4 76 10 80       	push   $0x801076e4
801042a5:	e8 b6 c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801042aa:	83 c4 10             	add    $0x10,%esp
801042ad:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801042b1:	75 a5                	jne    80104258 <procdump+0x18>
801042b3:	90                   	nop
801042b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801042b8:	8b 17                	mov    (%edi),%edx
801042ba:	85 d2                	test   %edx,%edx
801042bc:	74 9a                	je     80104258 <procdump+0x18>
        cprintf(" %p", pc[i]);
801042be:	83 ec 08             	sub    $0x8,%esp
801042c1:	83 c7 04             	add    $0x4,%edi
801042c4:	52                   	push   %edx
801042c5:	68 21 71 10 80       	push   $0x80107121
801042ca:	e8 91 c3 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801042cf:	83 c4 10             	add    $0x10,%esp
801042d2:	39 fe                	cmp    %edi,%esi
801042d4:	75 e2                	jne    801042b8 <procdump+0x78>
801042d6:	eb 80                	jmp    80104258 <procdump+0x18>
801042d8:	90                   	nop
801042d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
}
801042e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042e3:	5b                   	pop    %ebx
801042e4:	5e                   	pop    %esi
801042e5:	5f                   	pop    %edi
801042e6:	5d                   	pop    %ebp
801042e7:	c3                   	ret    
801042e8:	66 90                	xchg   %ax,%ax
801042ea:	66 90                	xchg   %ax,%ax
801042ec:	66 90                	xchg   %ax,%ax
801042ee:	66 90                	xchg   %ax,%ax

801042f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801042fa:	68 58 77 10 80       	push   $0x80107758
801042ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104302:	50                   	push   %eax
80104303:	e8 18 01 00 00       	call   80104420 <initlock>
  lk->name = name;
80104308:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010430b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104311:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104314:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010431b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010431e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104321:	c9                   	leave  
80104322:	c3                   	ret    
80104323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	8d 73 04             	lea    0x4(%ebx),%esi
8010433e:	56                   	push   %esi
8010433f:	e8 1c 02 00 00       	call   80104560 <acquire>
  while (lk->locked) {
80104344:	8b 13                	mov    (%ebx),%edx
80104346:	83 c4 10             	add    $0x10,%esp
80104349:	85 d2                	test   %edx,%edx
8010434b:	74 16                	je     80104363 <acquiresleep+0x33>
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104350:	83 ec 08             	sub    $0x8,%esp
80104353:	56                   	push   %esi
80104354:	53                   	push   %ebx
80104355:	e8 36 fc ff ff       	call   80103f90 <sleep>
  while (lk->locked) {
8010435a:	8b 03                	mov    (%ebx),%eax
8010435c:	83 c4 10             	add    $0x10,%esp
8010435f:	85 c0                	test   %eax,%eax
80104361:	75 ed                	jne    80104350 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104363:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104369:	e8 e2 f4 ff ff       	call   80103850 <myproc>
8010436e:	8b 40 10             	mov    0x10(%eax),%eax
80104371:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104374:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104377:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010437a:	5b                   	pop    %ebx
8010437b:	5e                   	pop    %esi
8010437c:	5d                   	pop    %ebp
  release(&lk->lk);
8010437d:	e9 9e 02 00 00       	jmp    80104620 <release>
80104382:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104390 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104398:	83 ec 0c             	sub    $0xc,%esp
8010439b:	8d 73 04             	lea    0x4(%ebx),%esi
8010439e:	56                   	push   %esi
8010439f:	e8 bc 01 00 00       	call   80104560 <acquire>
  lk->locked = 0;
801043a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043b1:	89 1c 24             	mov    %ebx,(%esp)
801043b4:	e8 87 fd ff ff       	call   80104140 <wakeup>
  release(&lk->lk);
801043b9:	89 75 08             	mov    %esi,0x8(%ebp)
801043bc:	83 c4 10             	add    $0x10,%esp
}
801043bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043c2:	5b                   	pop    %ebx
801043c3:	5e                   	pop    %esi
801043c4:	5d                   	pop    %ebp
  release(&lk->lk);
801043c5:	e9 56 02 00 00       	jmp    80104620 <release>
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	57                   	push   %edi
801043d4:	56                   	push   %esi
801043d5:	53                   	push   %ebx
801043d6:	31 ff                	xor    %edi,%edi
801043d8:	83 ec 18             	sub    $0x18,%esp
801043db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801043de:	8d 73 04             	lea    0x4(%ebx),%esi
801043e1:	56                   	push   %esi
801043e2:	e8 79 01 00 00       	call   80104560 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801043e7:	8b 03                	mov    (%ebx),%eax
801043e9:	83 c4 10             	add    $0x10,%esp
801043ec:	85 c0                	test   %eax,%eax
801043ee:	74 13                	je     80104403 <holdingsleep+0x33>
801043f0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801043f3:	e8 58 f4 ff ff       	call   80103850 <myproc>
801043f8:	39 58 10             	cmp    %ebx,0x10(%eax)
801043fb:	0f 94 c0             	sete   %al
801043fe:	0f b6 c0             	movzbl %al,%eax
80104401:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104403:	83 ec 0c             	sub    $0xc,%esp
80104406:	56                   	push   %esi
80104407:	e8 14 02 00 00       	call   80104620 <release>
  return r;
}
8010440c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010440f:	89 f8                	mov    %edi,%eax
80104411:	5b                   	pop    %ebx
80104412:	5e                   	pop    %esi
80104413:	5f                   	pop    %edi
80104414:	5d                   	pop    %ebp
80104415:	c3                   	ret    
80104416:	66 90                	xchg   %ax,%ax
80104418:	66 90                	xchg   %ax,%ax
8010441a:	66 90                	xchg   %ax,%ax
8010441c:	66 90                	xchg   %ax,%ax
8010441e:	66 90                	xchg   %ax,%ax

80104420 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104426:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104429:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010442f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104432:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104439:	5d                   	pop    %ebp
8010443a:	c3                   	ret    
8010443b:	90                   	nop
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104440:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104441:	31 d2                	xor    %edx,%edx
{
80104443:	89 e5                	mov    %esp,%ebp
80104445:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104446:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104449:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010444c:	83 e8 08             	sub    $0x8,%eax
8010444f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104450:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104456:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010445c:	77 1a                	ja     80104478 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010445e:	8b 58 04             	mov    0x4(%eax),%ebx
80104461:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104464:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104467:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104469:	83 fa 0a             	cmp    $0xa,%edx
8010446c:	75 e2                	jne    80104450 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010446e:	5b                   	pop    %ebx
8010446f:	5d                   	pop    %ebp
80104470:	c3                   	ret    
80104471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104478:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010447b:	83 c1 28             	add    $0x28,%ecx
8010447e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104486:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104489:	39 c1                	cmp    %eax,%ecx
8010448b:	75 f3                	jne    80104480 <getcallerpcs+0x40>
}
8010448d:	5b                   	pop    %ebx
8010448e:	5d                   	pop    %ebp
8010448f:	c3                   	ret    

80104490 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp
80104497:	9c                   	pushf  
80104498:	5b                   	pop    %ebx
  asm volatile("cli");
80104499:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010449a:	e8 11 f3 ff ff       	call   801037b0 <mycpu>
8010449f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044a5:	85 c0                	test   %eax,%eax
801044a7:	75 11                	jne    801044ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801044a9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044af:	e8 fc f2 ff ff       	call   801037b0 <mycpu>
801044b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801044ba:	e8 f1 f2 ff ff       	call   801037b0 <mycpu>
801044bf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044c6:	83 c4 04             	add    $0x4,%esp
801044c9:	5b                   	pop    %ebx
801044ca:	5d                   	pop    %ebp
801044cb:	c3                   	ret    
801044cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044d0 <popcli>:

void
popcli(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044d6:	9c                   	pushf  
801044d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044d8:	f6 c4 02             	test   $0x2,%ah
801044db:	75 35                	jne    80104512 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801044dd:	e8 ce f2 ff ff       	call   801037b0 <mycpu>
801044e2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801044e9:	78 34                	js     8010451f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801044eb:	e8 c0 f2 ff ff       	call   801037b0 <mycpu>
801044f0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801044f6:	85 d2                	test   %edx,%edx
801044f8:	74 06                	je     80104500 <popcli+0x30>
    sti();
}
801044fa:	c9                   	leave  
801044fb:	c3                   	ret    
801044fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104500:	e8 ab f2 ff ff       	call   801037b0 <mycpu>
80104505:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010450b:	85 c0                	test   %eax,%eax
8010450d:	74 eb                	je     801044fa <popcli+0x2a>
  asm volatile("sti");
8010450f:	fb                   	sti    
}
80104510:	c9                   	leave  
80104511:	c3                   	ret    
    panic("popcli - interruptible");
80104512:	83 ec 0c             	sub    $0xc,%esp
80104515:	68 63 77 10 80       	push   $0x80107763
8010451a:	e8 71 be ff ff       	call   80100390 <panic>
    panic("popcli");
8010451f:	83 ec 0c             	sub    $0xc,%esp
80104522:	68 7a 77 10 80       	push   $0x8010777a
80104527:	e8 64 be ff ff       	call   80100390 <panic>
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104530 <holding>:
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	56                   	push   %esi
80104534:	53                   	push   %ebx
80104535:	8b 75 08             	mov    0x8(%ebp),%esi
80104538:	31 db                	xor    %ebx,%ebx
  pushcli();
8010453a:	e8 51 ff ff ff       	call   80104490 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010453f:	8b 06                	mov    (%esi),%eax
80104541:	85 c0                	test   %eax,%eax
80104543:	74 10                	je     80104555 <holding+0x25>
80104545:	8b 5e 08             	mov    0x8(%esi),%ebx
80104548:	e8 63 f2 ff ff       	call   801037b0 <mycpu>
8010454d:	39 c3                	cmp    %eax,%ebx
8010454f:	0f 94 c3             	sete   %bl
80104552:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104555:	e8 76 ff ff ff       	call   801044d0 <popcli>
}
8010455a:	89 d8                	mov    %ebx,%eax
8010455c:	5b                   	pop    %ebx
8010455d:	5e                   	pop    %esi
8010455e:	5d                   	pop    %ebp
8010455f:	c3                   	ret    

80104560 <acquire>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104565:	e8 26 ff ff ff       	call   80104490 <pushcli>
  if(holding(lk))
8010456a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010456d:	83 ec 0c             	sub    $0xc,%esp
80104570:	53                   	push   %ebx
80104571:	e8 ba ff ff ff       	call   80104530 <holding>
80104576:	83 c4 10             	add    $0x10,%esp
80104579:	85 c0                	test   %eax,%eax
8010457b:	0f 85 83 00 00 00    	jne    80104604 <acquire+0xa4>
80104581:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104583:	ba 01 00 00 00       	mov    $0x1,%edx
80104588:	eb 09                	jmp    80104593 <acquire+0x33>
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104590:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104593:	89 d0                	mov    %edx,%eax
80104595:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104598:	85 c0                	test   %eax,%eax
8010459a:	75 f4                	jne    80104590 <acquire+0x30>
  __sync_synchronize();
8010459c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801045a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045a4:	e8 07 f2 ff ff       	call   801037b0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801045a9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801045ac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801045af:	89 e8                	mov    %ebp,%eax
801045b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045b8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801045be:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801045c4:	77 1a                	ja     801045e0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801045c6:	8b 48 04             	mov    0x4(%eax),%ecx
801045c9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801045cc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801045cf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045d1:	83 fe 0a             	cmp    $0xa,%esi
801045d4:	75 e2                	jne    801045b8 <acquire+0x58>
}
801045d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d9:	5b                   	pop    %ebx
801045da:	5e                   	pop    %esi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
801045e0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801045e3:	83 c2 28             	add    $0x28,%edx
801045e6:	8d 76 00             	lea    0x0(%esi),%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801045f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045f9:	39 d0                	cmp    %edx,%eax
801045fb:	75 f3                	jne    801045f0 <acquire+0x90>
}
801045fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104600:	5b                   	pop    %ebx
80104601:	5e                   	pop    %esi
80104602:	5d                   	pop    %ebp
80104603:	c3                   	ret    
    panic("acquire");
80104604:	83 ec 0c             	sub    $0xc,%esp
80104607:	68 81 77 10 80       	push   $0x80107781
8010460c:	e8 7f bd ff ff       	call   80100390 <panic>
80104611:	eb 0d                	jmp    80104620 <release>
80104613:	90                   	nop
80104614:	90                   	nop
80104615:	90                   	nop
80104616:	90                   	nop
80104617:	90                   	nop
80104618:	90                   	nop
80104619:	90                   	nop
8010461a:	90                   	nop
8010461b:	90                   	nop
8010461c:	90                   	nop
8010461d:	90                   	nop
8010461e:	90                   	nop
8010461f:	90                   	nop

80104620 <release>:
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 10             	sub    $0x10,%esp
80104627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010462a:	53                   	push   %ebx
8010462b:	e8 00 ff ff ff       	call   80104530 <holding>
80104630:	83 c4 10             	add    $0x10,%esp
80104633:	85 c0                	test   %eax,%eax
80104635:	74 22                	je     80104659 <release+0x39>
  lk->pcs[0] = 0;
80104637:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010463e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104645:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010464a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104650:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104653:	c9                   	leave  
  popcli();
80104654:	e9 77 fe ff ff       	jmp    801044d0 <popcli>
    panic("release");
80104659:	83 ec 0c             	sub    $0xc,%esp
8010465c:	68 89 77 10 80       	push   $0x80107789
80104661:	e8 2a bd ff ff       	call   80100390 <panic>
80104666:	66 90                	xchg   %ax,%ax
80104668:	66 90                	xchg   %ax,%ax
8010466a:	66 90                	xchg   %ax,%ax
8010466c:	66 90                	xchg   %ax,%ax
8010466e:	66 90                	xchg   %ax,%ax

80104670 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	53                   	push   %ebx
80104675:	8b 55 08             	mov    0x8(%ebp),%edx
80104678:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010467b:	f6 c2 03             	test   $0x3,%dl
8010467e:	75 05                	jne    80104685 <memset+0x15>
80104680:	f6 c1 03             	test   $0x3,%cl
80104683:	74 13                	je     80104698 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104685:	89 d7                	mov    %edx,%edi
80104687:	8b 45 0c             	mov    0xc(%ebp),%eax
8010468a:	fc                   	cld    
8010468b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010468d:	5b                   	pop    %ebx
8010468e:	89 d0                	mov    %edx,%eax
80104690:	5f                   	pop    %edi
80104691:	5d                   	pop    %ebp
80104692:	c3                   	ret    
80104693:	90                   	nop
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104698:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010469c:	c1 e9 02             	shr    $0x2,%ecx
8010469f:	89 f8                	mov    %edi,%eax
801046a1:	89 fb                	mov    %edi,%ebx
801046a3:	c1 e0 18             	shl    $0x18,%eax
801046a6:	c1 e3 10             	shl    $0x10,%ebx
801046a9:	09 d8                	or     %ebx,%eax
801046ab:	09 f8                	or     %edi,%eax
801046ad:	c1 e7 08             	shl    $0x8,%edi
801046b0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801046b2:	89 d7                	mov    %edx,%edi
801046b4:	fc                   	cld    
801046b5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801046b7:	5b                   	pop    %ebx
801046b8:	89 d0                	mov    %edx,%eax
801046ba:	5f                   	pop    %edi
801046bb:	5d                   	pop    %ebp
801046bc:	c3                   	ret    
801046bd:	8d 76 00             	lea    0x0(%esi),%esi

801046c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	53                   	push   %ebx
801046c6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801046c9:	8b 75 08             	mov    0x8(%ebp),%esi
801046cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046cf:	85 db                	test   %ebx,%ebx
801046d1:	74 29                	je     801046fc <memcmp+0x3c>
    if(*s1 != *s2)
801046d3:	0f b6 16             	movzbl (%esi),%edx
801046d6:	0f b6 0f             	movzbl (%edi),%ecx
801046d9:	38 d1                	cmp    %dl,%cl
801046db:	75 2b                	jne    80104708 <memcmp+0x48>
801046dd:	b8 01 00 00 00       	mov    $0x1,%eax
801046e2:	eb 14                	jmp    801046f8 <memcmp+0x38>
801046e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046e8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801046ec:	83 c0 01             	add    $0x1,%eax
801046ef:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801046f4:	38 ca                	cmp    %cl,%dl
801046f6:	75 10                	jne    80104708 <memcmp+0x48>
  while(n-- > 0){
801046f8:	39 d8                	cmp    %ebx,%eax
801046fa:	75 ec                	jne    801046e8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046fc:	5b                   	pop    %ebx
  return 0;
801046fd:	31 c0                	xor    %eax,%eax
}
801046ff:	5e                   	pop    %esi
80104700:	5f                   	pop    %edi
80104701:	5d                   	pop    %ebp
80104702:	c3                   	ret    
80104703:	90                   	nop
80104704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104708:	0f b6 c2             	movzbl %dl,%eax
}
8010470b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010470c:	29 c8                	sub    %ecx,%eax
}
8010470e:	5e                   	pop    %esi
8010470f:	5f                   	pop    %edi
80104710:	5d                   	pop    %ebp
80104711:	c3                   	ret    
80104712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 45 08             	mov    0x8(%ebp),%eax
80104728:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010472b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010472e:	39 c3                	cmp    %eax,%ebx
80104730:	73 26                	jae    80104758 <memmove+0x38>
80104732:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104735:	39 c8                	cmp    %ecx,%eax
80104737:	73 1f                	jae    80104758 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104739:	85 f6                	test   %esi,%esi
8010473b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010473e:	74 0f                	je     8010474f <memmove+0x2f>
      *--d = *--s;
80104740:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104744:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104747:	83 ea 01             	sub    $0x1,%edx
8010474a:	83 fa ff             	cmp    $0xffffffff,%edx
8010474d:	75 f1                	jne    80104740 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010474f:	5b                   	pop    %ebx
80104750:	5e                   	pop    %esi
80104751:	5d                   	pop    %ebp
80104752:	c3                   	ret    
80104753:	90                   	nop
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104758:	31 d2                	xor    %edx,%edx
8010475a:	85 f6                	test   %esi,%esi
8010475c:	74 f1                	je     8010474f <memmove+0x2f>
8010475e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104760:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104764:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104767:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010476a:	39 d6                	cmp    %edx,%esi
8010476c:	75 f2                	jne    80104760 <memmove+0x40>
}
8010476e:	5b                   	pop    %ebx
8010476f:	5e                   	pop    %esi
80104770:	5d                   	pop    %ebp
80104771:	c3                   	ret    
80104772:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104783:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104784:	eb 9a                	jmp    80104720 <memmove>
80104786:	8d 76 00             	lea    0x0(%esi),%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104790 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	57                   	push   %edi
80104794:	56                   	push   %esi
80104795:	8b 7d 10             	mov    0x10(%ebp),%edi
80104798:	53                   	push   %ebx
80104799:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010479c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010479f:	85 ff                	test   %edi,%edi
801047a1:	74 2f                	je     801047d2 <strncmp+0x42>
801047a3:	0f b6 01             	movzbl (%ecx),%eax
801047a6:	0f b6 1e             	movzbl (%esi),%ebx
801047a9:	84 c0                	test   %al,%al
801047ab:	74 37                	je     801047e4 <strncmp+0x54>
801047ad:	38 c3                	cmp    %al,%bl
801047af:	75 33                	jne    801047e4 <strncmp+0x54>
801047b1:	01 f7                	add    %esi,%edi
801047b3:	eb 13                	jmp    801047c8 <strncmp+0x38>
801047b5:	8d 76 00             	lea    0x0(%esi),%esi
801047b8:	0f b6 01             	movzbl (%ecx),%eax
801047bb:	84 c0                	test   %al,%al
801047bd:	74 21                	je     801047e0 <strncmp+0x50>
801047bf:	0f b6 1a             	movzbl (%edx),%ebx
801047c2:	89 d6                	mov    %edx,%esi
801047c4:	38 d8                	cmp    %bl,%al
801047c6:	75 1c                	jne    801047e4 <strncmp+0x54>
    n--, p++, q++;
801047c8:	8d 56 01             	lea    0x1(%esi),%edx
801047cb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801047ce:	39 fa                	cmp    %edi,%edx
801047d0:	75 e6                	jne    801047b8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047d2:	5b                   	pop    %ebx
    return 0;
801047d3:	31 c0                	xor    %eax,%eax
}
801047d5:	5e                   	pop    %esi
801047d6:	5f                   	pop    %edi
801047d7:	5d                   	pop    %ebp
801047d8:	c3                   	ret    
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801047e4:	29 d8                	sub    %ebx,%eax
}
801047e6:	5b                   	pop    %ebx
801047e7:	5e                   	pop    %esi
801047e8:	5f                   	pop    %edi
801047e9:	5d                   	pop    %ebp
801047ea:	c3                   	ret    
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	8b 45 08             	mov    0x8(%ebp),%eax
801047f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047fe:	89 c2                	mov    %eax,%edx
80104800:	eb 19                	jmp    8010481b <strncpy+0x2b>
80104802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104808:	83 c3 01             	add    $0x1,%ebx
8010480b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010480f:	83 c2 01             	add    $0x1,%edx
80104812:	84 c9                	test   %cl,%cl
80104814:	88 4a ff             	mov    %cl,-0x1(%edx)
80104817:	74 09                	je     80104822 <strncpy+0x32>
80104819:	89 f1                	mov    %esi,%ecx
8010481b:	85 c9                	test   %ecx,%ecx
8010481d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104820:	7f e6                	jg     80104808 <strncpy+0x18>
    ;
  while(n-- > 0)
80104822:	31 c9                	xor    %ecx,%ecx
80104824:	85 f6                	test   %esi,%esi
80104826:	7e 17                	jle    8010483f <strncpy+0x4f>
80104828:	90                   	nop
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104830:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104834:	89 f3                	mov    %esi,%ebx
80104836:	83 c1 01             	add    $0x1,%ecx
80104839:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010483b:	85 db                	test   %ebx,%ebx
8010483d:	7f f1                	jg     80104830 <strncpy+0x40>
  return os;
}
8010483f:	5b                   	pop    %ebx
80104840:	5e                   	pop    %esi
80104841:	5d                   	pop    %ebp
80104842:	c3                   	ret    
80104843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	53                   	push   %ebx
80104855:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104858:	8b 45 08             	mov    0x8(%ebp),%eax
8010485b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010485e:	85 c9                	test   %ecx,%ecx
80104860:	7e 26                	jle    80104888 <safestrcpy+0x38>
80104862:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104866:	89 c1                	mov    %eax,%ecx
80104868:	eb 17                	jmp    80104881 <safestrcpy+0x31>
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104870:	83 c2 01             	add    $0x1,%edx
80104873:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104877:	83 c1 01             	add    $0x1,%ecx
8010487a:	84 db                	test   %bl,%bl
8010487c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010487f:	74 04                	je     80104885 <safestrcpy+0x35>
80104881:	39 f2                	cmp    %esi,%edx
80104883:	75 eb                	jne    80104870 <safestrcpy+0x20>
    ;
  *s = 0;
80104885:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104888:	5b                   	pop    %ebx
80104889:	5e                   	pop    %esi
8010488a:	5d                   	pop    %ebp
8010488b:	c3                   	ret    
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104890 <strlen>:

int
strlen(const char *s)
{
80104890:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104891:	31 c0                	xor    %eax,%eax
{
80104893:	89 e5                	mov    %esp,%ebp
80104895:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104898:	80 3a 00             	cmpb   $0x0,(%edx)
8010489b:	74 0c                	je     801048a9 <strlen+0x19>
8010489d:	8d 76 00             	lea    0x0(%esi),%esi
801048a0:	83 c0 01             	add    $0x1,%eax
801048a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048a7:	75 f7                	jne    801048a0 <strlen+0x10>
    ;
  return n;
}
801048a9:	5d                   	pop    %ebp
801048aa:	c3                   	ret    

801048ab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801048ab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801048af:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801048b3:	55                   	push   %ebp
  pushl %ebx
801048b4:	53                   	push   %ebx
  pushl %esi
801048b5:	56                   	push   %esi
  pushl %edi
801048b6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801048b7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801048b9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801048bb:	5f                   	pop    %edi
  popl %esi
801048bc:	5e                   	pop    %esi
  popl %ebx
801048bd:	5b                   	pop    %ebx
  popl %ebp
801048be:	5d                   	pop    %ebp
  ret
801048bf:	c3                   	ret    

801048c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	83 ec 04             	sub    $0x4,%esp
801048c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801048ca:	e8 81 ef ff ff       	call   80103850 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048cf:	8b 00                	mov    (%eax),%eax
801048d1:	39 d8                	cmp    %ebx,%eax
801048d3:	76 1b                	jbe    801048f0 <fetchint+0x30>
801048d5:	8d 53 04             	lea    0x4(%ebx),%edx
801048d8:	39 d0                	cmp    %edx,%eax
801048da:	72 14                	jb     801048f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801048dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801048df:	8b 13                	mov    (%ebx),%edx
801048e1:	89 10                	mov    %edx,(%eax)
  return 0;
801048e3:	31 c0                	xor    %eax,%eax
}
801048e5:	83 c4 04             	add    $0x4,%esp
801048e8:	5b                   	pop    %ebx
801048e9:	5d                   	pop    %ebp
801048ea:	c3                   	ret    
801048eb:	90                   	nop
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048f5:	eb ee                	jmp    801048e5 <fetchint+0x25>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
80104907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010490a:	e8 41 ef ff ff       	call   80103850 <myproc>

  if(addr >= curproc->sz)
8010490f:	39 18                	cmp    %ebx,(%eax)
80104911:	76 29                	jbe    8010493c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104913:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104916:	89 da                	mov    %ebx,%edx
80104918:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010491a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010491c:	39 c3                	cmp    %eax,%ebx
8010491e:	73 1c                	jae    8010493c <fetchstr+0x3c>
    if(*s == 0)
80104920:	80 3b 00             	cmpb   $0x0,(%ebx)
80104923:	75 10                	jne    80104935 <fetchstr+0x35>
80104925:	eb 39                	jmp    80104960 <fetchstr+0x60>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104930:	80 3a 00             	cmpb   $0x0,(%edx)
80104933:	74 1b                	je     80104950 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104935:	83 c2 01             	add    $0x1,%edx
80104938:	39 d0                	cmp    %edx,%eax
8010493a:	77 f4                	ja     80104930 <fetchstr+0x30>
    return -1;
8010493c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104941:	83 c4 04             	add    $0x4,%esp
80104944:	5b                   	pop    %ebx
80104945:	5d                   	pop    %ebp
80104946:	c3                   	ret    
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104950:	83 c4 04             	add    $0x4,%esp
80104953:	89 d0                	mov    %edx,%eax
80104955:	29 d8                	sub    %ebx,%eax
80104957:	5b                   	pop    %ebx
80104958:	5d                   	pop    %ebp
80104959:	c3                   	ret    
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104960:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104962:	eb dd                	jmp    80104941 <fetchstr+0x41>
80104964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010496a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104970 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104975:	e8 06 ef ff ff       	call   80103880 <mythread>
8010497a:	8b 40 10             	mov    0x10(%eax),%eax
8010497d:	8b 55 08             	mov    0x8(%ebp),%edx
80104980:	8b 40 44             	mov    0x44(%eax),%eax
80104983:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104986:	e8 c5 ee ff ff       	call   80103850 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010498b:	8b 00                	mov    (%eax),%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
8010498d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104990:	39 c6                	cmp    %eax,%esi
80104992:	73 1c                	jae    801049b0 <argint+0x40>
80104994:	8d 53 08             	lea    0x8(%ebx),%edx
80104997:	39 d0                	cmp    %edx,%eax
80104999:	72 15                	jb     801049b0 <argint+0x40>
  *ip = *(int*)(addr);
8010499b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010499e:	8b 53 04             	mov    0x4(%ebx),%edx
801049a1:	89 10                	mov    %edx,(%eax)
  return 0;
801049a3:	31 c0                	xor    %eax,%eax
}
801049a5:	5b                   	pop    %ebx
801049a6:	5e                   	pop    %esi
801049a7:	5d                   	pop    %ebp
801049a8:	c3                   	ret    
801049a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
801049b5:	eb ee                	jmp    801049a5 <argint+0x35>
801049b7:	89 f6                	mov    %esi,%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
801049c5:	83 ec 10             	sub    $0x10,%esp
801049c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801049cb:	e8 80 ee ff ff       	call   80103850 <myproc>
801049d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801049d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049d5:	83 ec 08             	sub    $0x8,%esp
801049d8:	50                   	push   %eax
801049d9:	ff 75 08             	pushl  0x8(%ebp)
801049dc:	e8 8f ff ff ff       	call   80104970 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049e1:	83 c4 10             	add    $0x10,%esp
801049e4:	85 c0                	test   %eax,%eax
801049e6:	78 28                	js     80104a10 <argptr+0x50>
801049e8:	85 db                	test   %ebx,%ebx
801049ea:	78 24                	js     80104a10 <argptr+0x50>
801049ec:	8b 16                	mov    (%esi),%edx
801049ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f1:	39 c2                	cmp    %eax,%edx
801049f3:	76 1b                	jbe    80104a10 <argptr+0x50>
801049f5:	01 c3                	add    %eax,%ebx
801049f7:	39 da                	cmp    %ebx,%edx
801049f9:	72 15                	jb     80104a10 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801049fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801049fe:	89 02                	mov    %eax,(%edx)
  return 0;
80104a00:	31 c0                	xor    %eax,%eax
}
80104a02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a05:	5b                   	pop    %ebx
80104a06:	5e                   	pop    %esi
80104a07:	5d                   	pop    %ebp
80104a08:	c3                   	ret    
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb eb                	jmp    80104a02 <argptr+0x42>
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a29:	50                   	push   %eax
80104a2a:	ff 75 08             	pushl  0x8(%ebp)
80104a2d:	e8 3e ff ff ff       	call   80104970 <argint>
80104a32:	83 c4 10             	add    $0x10,%esp
80104a35:	85 c0                	test   %eax,%eax
80104a37:	78 17                	js     80104a50 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a39:	83 ec 08             	sub    $0x8,%esp
80104a3c:	ff 75 0c             	pushl  0xc(%ebp)
80104a3f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a42:	e8 b9 fe ff ff       	call   80104900 <fetchstr>
80104a47:	83 c4 10             	add    $0x10,%esp
}
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a55:	c9                   	leave  
80104a56:	c3                   	ret    
80104a57:	89 f6                	mov    %esi,%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104a65:	e8 e6 ed ff ff       	call   80103850 <myproc>
80104a6a:	89 c6                	mov    %eax,%esi
  struct kthread *curthread = mythread();
80104a6c:	e8 0f ee ff ff       	call   80103880 <mythread>
80104a71:	89 c3                	mov    %eax,%ebx

  num = curthread->tf->eax;
80104a73:	8b 40 10             	mov    0x10(%eax),%eax
80104a76:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a79:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a7c:	83 fa 14             	cmp    $0x14,%edx
80104a7f:	77 1f                	ja     80104aa0 <syscall+0x40>
80104a81:	8b 14 85 c0 77 10 80 	mov    -0x7fef8840(,%eax,4),%edx
80104a88:	85 d2                	test   %edx,%edx
80104a8a:	74 14                	je     80104aa0 <syscall+0x40>
    curthread->tf->eax = syscalls[num]();
80104a8c:	ff d2                	call   *%edx
80104a8e:	8b 53 10             	mov    0x10(%ebx),%edx
80104a91:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curthread->tf->eax = -1;
  }
}
80104a94:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a97:	5b                   	pop    %ebx
80104a98:	5e                   	pop    %esi
80104a99:	5d                   	pop    %ebp
80104a9a:	c3                   	ret    
80104a9b:	90                   	nop
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104aa0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104aa1:	8d 46 64             	lea    0x64(%esi),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104aa4:	50                   	push   %eax
80104aa5:	ff 76 10             	pushl  0x10(%esi)
80104aa8:	68 91 77 10 80       	push   $0x80107791
80104aad:	e8 ae bb ff ff       	call   80100660 <cprintf>
    curthread->tf->eax = -1;
80104ab2:	8b 43 10             	mov    0x10(%ebx),%eax
80104ab5:	83 c4 10             	add    $0x10,%esp
80104ab8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104abf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ac2:	5b                   	pop    %ebx
80104ac3:	5e                   	pop    %esi
80104ac4:	5d                   	pop    %ebp
80104ac5:	c3                   	ret    
80104ac6:	66 90                	xchg   %ax,%ax
80104ac8:	66 90                	xchg   %ax,%ax
80104aca:	66 90                	xchg   %ax,%ax
80104acc:	66 90                	xchg   %ax,%ax
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	57                   	push   %edi
80104ad4:	56                   	push   %esi
80104ad5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ad6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104ad9:	83 ec 44             	sub    $0x44,%esp
80104adc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104adf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104ae2:	56                   	push   %esi
80104ae3:	50                   	push   %eax
{
80104ae4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104ae7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104aea:	e8 31 d4 ff ff       	call   80101f20 <nameiparent>
80104aef:	83 c4 10             	add    $0x10,%esp
80104af2:	85 c0                	test   %eax,%eax
80104af4:	0f 84 46 01 00 00    	je     80104c40 <create+0x170>
    return 0;
  ilock(dp);
80104afa:	83 ec 0c             	sub    $0xc,%esp
80104afd:	89 c3                	mov    %eax,%ebx
80104aff:	50                   	push   %eax
80104b00:	e8 9b cb ff ff       	call   801016a0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b05:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b08:	83 c4 0c             	add    $0xc,%esp
80104b0b:	50                   	push   %eax
80104b0c:	56                   	push   %esi
80104b0d:	53                   	push   %ebx
80104b0e:	e8 bd d0 ff ff       	call   80101bd0 <dirlookup>
80104b13:	83 c4 10             	add    $0x10,%esp
80104b16:	85 c0                	test   %eax,%eax
80104b18:	89 c7                	mov    %eax,%edi
80104b1a:	74 34                	je     80104b50 <create+0x80>
    iunlockput(dp);
80104b1c:	83 ec 0c             	sub    $0xc,%esp
80104b1f:	53                   	push   %ebx
80104b20:	e8 0b ce ff ff       	call   80101930 <iunlockput>
    ilock(ip);
80104b25:	89 3c 24             	mov    %edi,(%esp)
80104b28:	e8 73 cb ff ff       	call   801016a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b35:	0f 85 95 00 00 00    	jne    80104bd0 <create+0x100>
80104b3b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104b40:	0f 85 8a 00 00 00    	jne    80104bd0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b49:	89 f8                	mov    %edi,%eax
80104b4b:	5b                   	pop    %ebx
80104b4c:	5e                   	pop    %esi
80104b4d:	5f                   	pop    %edi
80104b4e:	5d                   	pop    %ebp
80104b4f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104b50:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b54:	83 ec 08             	sub    $0x8,%esp
80104b57:	50                   	push   %eax
80104b58:	ff 33                	pushl  (%ebx)
80104b5a:	e8 d1 c9 ff ff       	call   80101530 <ialloc>
80104b5f:	83 c4 10             	add    $0x10,%esp
80104b62:	85 c0                	test   %eax,%eax
80104b64:	89 c7                	mov    %eax,%edi
80104b66:	0f 84 e8 00 00 00    	je     80104c54 <create+0x184>
  ilock(ip);
80104b6c:	83 ec 0c             	sub    $0xc,%esp
80104b6f:	50                   	push   %eax
80104b70:	e8 2b cb ff ff       	call   801016a0 <ilock>
  ip->major = major;
80104b75:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b79:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104b7d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b81:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b85:	b8 01 00 00 00       	mov    $0x1,%eax
80104b8a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b8e:	89 3c 24             	mov    %edi,(%esp)
80104b91:	e8 5a ca ff ff       	call   801015f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104b96:	83 c4 10             	add    $0x10,%esp
80104b99:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b9e:	74 50                	je     80104bf0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104ba0:	83 ec 04             	sub    $0x4,%esp
80104ba3:	ff 77 04             	pushl  0x4(%edi)
80104ba6:	56                   	push   %esi
80104ba7:	53                   	push   %ebx
80104ba8:	e8 93 d2 ff ff       	call   80101e40 <dirlink>
80104bad:	83 c4 10             	add    $0x10,%esp
80104bb0:	85 c0                	test   %eax,%eax
80104bb2:	0f 88 8f 00 00 00    	js     80104c47 <create+0x177>
  iunlockput(dp);
80104bb8:	83 ec 0c             	sub    $0xc,%esp
80104bbb:	53                   	push   %ebx
80104bbc:	e8 6f cd ff ff       	call   80101930 <iunlockput>
  return ip;
80104bc1:	83 c4 10             	add    $0x10,%esp
}
80104bc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc7:	89 f8                	mov    %edi,%eax
80104bc9:	5b                   	pop    %ebx
80104bca:	5e                   	pop    %esi
80104bcb:	5f                   	pop    %edi
80104bcc:	5d                   	pop    %ebp
80104bcd:	c3                   	ret    
80104bce:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104bd0:	83 ec 0c             	sub    $0xc,%esp
80104bd3:	57                   	push   %edi
    return 0;
80104bd4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104bd6:	e8 55 cd ff ff       	call   80101930 <iunlockput>
    return 0;
80104bdb:	83 c4 10             	add    $0x10,%esp
}
80104bde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104be1:	89 f8                	mov    %edi,%eax
80104be3:	5b                   	pop    %ebx
80104be4:	5e                   	pop    %esi
80104be5:	5f                   	pop    %edi
80104be6:	5d                   	pop    %ebp
80104be7:	c3                   	ret    
80104be8:	90                   	nop
80104be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104bf0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104bf5:	83 ec 0c             	sub    $0xc,%esp
80104bf8:	53                   	push   %ebx
80104bf9:	e8 f2 c9 ff ff       	call   801015f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bfe:	83 c4 0c             	add    $0xc,%esp
80104c01:	ff 77 04             	pushl  0x4(%edi)
80104c04:	68 34 78 10 80       	push   $0x80107834
80104c09:	57                   	push   %edi
80104c0a:	e8 31 d2 ff ff       	call   80101e40 <dirlink>
80104c0f:	83 c4 10             	add    $0x10,%esp
80104c12:	85 c0                	test   %eax,%eax
80104c14:	78 1c                	js     80104c32 <create+0x162>
80104c16:	83 ec 04             	sub    $0x4,%esp
80104c19:	ff 73 04             	pushl  0x4(%ebx)
80104c1c:	68 33 78 10 80       	push   $0x80107833
80104c21:	57                   	push   %edi
80104c22:	e8 19 d2 ff ff       	call   80101e40 <dirlink>
80104c27:	83 c4 10             	add    $0x10,%esp
80104c2a:	85 c0                	test   %eax,%eax
80104c2c:	0f 89 6e ff ff ff    	jns    80104ba0 <create+0xd0>
      panic("create dots");
80104c32:	83 ec 0c             	sub    $0xc,%esp
80104c35:	68 27 78 10 80       	push   $0x80107827
80104c3a:	e8 51 b7 ff ff       	call   80100390 <panic>
80104c3f:	90                   	nop
    return 0;
80104c40:	31 ff                	xor    %edi,%edi
80104c42:	e9 ff fe ff ff       	jmp    80104b46 <create+0x76>
    panic("create: dirlink");
80104c47:	83 ec 0c             	sub    $0xc,%esp
80104c4a:	68 36 78 10 80       	push   $0x80107836
80104c4f:	e8 3c b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104c54:	83 ec 0c             	sub    $0xc,%esp
80104c57:	68 18 78 10 80       	push   $0x80107818
80104c5c:	e8 2f b7 ff ff       	call   80100390 <panic>
80104c61:	eb 0d                	jmp    80104c70 <argfd.constprop.0>
80104c63:	90                   	nop
80104c64:	90                   	nop
80104c65:	90                   	nop
80104c66:	90                   	nop
80104c67:	90                   	nop
80104c68:	90                   	nop
80104c69:	90                   	nop
80104c6a:	90                   	nop
80104c6b:	90                   	nop
80104c6c:	90                   	nop
80104c6d:	90                   	nop
80104c6e:	90                   	nop
80104c6f:	90                   	nop

80104c70 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	56                   	push   %esi
80104c74:	53                   	push   %ebx
80104c75:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104c77:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104c7a:	89 d6                	mov    %edx,%esi
80104c7c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104c7f:	50                   	push   %eax
80104c80:	6a 00                	push   $0x0
80104c82:	e8 e9 fc ff ff       	call   80104970 <argint>
80104c87:	83 c4 10             	add    $0x10,%esp
80104c8a:	85 c0                	test   %eax,%eax
80104c8c:	78 2a                	js     80104cb8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c8e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c92:	77 24                	ja     80104cb8 <argfd.constprop.0+0x48>
80104c94:	e8 b7 eb ff ff       	call   80103850 <myproc>
80104c99:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c9c:	8b 44 90 20          	mov    0x20(%eax,%edx,4),%eax
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	74 14                	je     80104cb8 <argfd.constprop.0+0x48>
  if(pfd)
80104ca4:	85 db                	test   %ebx,%ebx
80104ca6:	74 02                	je     80104caa <argfd.constprop.0+0x3a>
    *pfd = fd;
80104ca8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104caa:	89 06                	mov    %eax,(%esi)
  return 0;
80104cac:	31 c0                	xor    %eax,%eax
}
80104cae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cb1:	5b                   	pop    %ebx
80104cb2:	5e                   	pop    %esi
80104cb3:	5d                   	pop    %ebp
80104cb4:	c3                   	ret    
80104cb5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104cb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cbd:	eb ef                	jmp    80104cae <argfd.constprop.0+0x3e>
80104cbf:	90                   	nop

80104cc0 <sys_dup>:
{
80104cc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104cc1:	31 c0                	xor    %eax,%eax
{
80104cc3:	89 e5                	mov    %esp,%ebp
80104cc5:	56                   	push   %esi
80104cc6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104cc7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104cca:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104ccd:	e8 9e ff ff ff       	call   80104c70 <argfd.constprop.0>
80104cd2:	85 c0                	test   %eax,%eax
80104cd4:	78 42                	js     80104d18 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104cd6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104cd9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104cdb:	e8 70 eb ff ff       	call   80103850 <myproc>
80104ce0:	eb 0e                	jmp    80104cf0 <sys_dup+0x30>
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104ce8:	83 c3 01             	add    $0x1,%ebx
80104ceb:	83 fb 10             	cmp    $0x10,%ebx
80104cee:	74 28                	je     80104d18 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104cf0:	8b 54 98 20          	mov    0x20(%eax,%ebx,4),%edx
80104cf4:	85 d2                	test   %edx,%edx
80104cf6:	75 f0                	jne    80104ce8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104cf8:	89 74 98 20          	mov    %esi,0x20(%eax,%ebx,4)
  filedup(f);
80104cfc:	83 ec 0c             	sub    $0xc,%esp
80104cff:	ff 75 f4             	pushl  -0xc(%ebp)
80104d02:	e8 f9 c0 ff ff       	call   80100e00 <filedup>
  return fd;
80104d07:	83 c4 10             	add    $0x10,%esp
}
80104d0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d0d:	89 d8                	mov    %ebx,%eax
80104d0f:	5b                   	pop    %ebx
80104d10:	5e                   	pop    %esi
80104d11:	5d                   	pop    %ebp
80104d12:	c3                   	ret    
80104d13:	90                   	nop
80104d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d18:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d1b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d20:	89 d8                	mov    %ebx,%eax
80104d22:	5b                   	pop    %ebx
80104d23:	5e                   	pop    %esi
80104d24:	5d                   	pop    %ebp
80104d25:	c3                   	ret    
80104d26:	8d 76 00             	lea    0x0(%esi),%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d30 <sys_read>:
{
80104d30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d31:	31 c0                	xor    %eax,%eax
{
80104d33:	89 e5                	mov    %esp,%ebp
80104d35:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d3b:	e8 30 ff ff ff       	call   80104c70 <argfd.constprop.0>
80104d40:	85 c0                	test   %eax,%eax
80104d42:	78 4c                	js     80104d90 <sys_read+0x60>
80104d44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d47:	83 ec 08             	sub    $0x8,%esp
80104d4a:	50                   	push   %eax
80104d4b:	6a 02                	push   $0x2
80104d4d:	e8 1e fc ff ff       	call   80104970 <argint>
80104d52:	83 c4 10             	add    $0x10,%esp
80104d55:	85 c0                	test   %eax,%eax
80104d57:	78 37                	js     80104d90 <sys_read+0x60>
80104d59:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d5c:	83 ec 04             	sub    $0x4,%esp
80104d5f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d62:	50                   	push   %eax
80104d63:	6a 01                	push   $0x1
80104d65:	e8 56 fc ff ff       	call   801049c0 <argptr>
80104d6a:	83 c4 10             	add    $0x10,%esp
80104d6d:	85 c0                	test   %eax,%eax
80104d6f:	78 1f                	js     80104d90 <sys_read+0x60>
  return fileread(f, p, n);
80104d71:	83 ec 04             	sub    $0x4,%esp
80104d74:	ff 75 f0             	pushl  -0x10(%ebp)
80104d77:	ff 75 f4             	pushl  -0xc(%ebp)
80104d7a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d7d:	e8 ee c1 ff ff       	call   80100f70 <fileread>
80104d82:	83 c4 10             	add    $0x10,%esp
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104da0 <sys_write>:
{
80104da0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104da1:	31 c0                	xor    %eax,%eax
{
80104da3:	89 e5                	mov    %esp,%ebp
80104da5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104da8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dab:	e8 c0 fe ff ff       	call   80104c70 <argfd.constprop.0>
80104db0:	85 c0                	test   %eax,%eax
80104db2:	78 4c                	js     80104e00 <sys_write+0x60>
80104db4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104db7:	83 ec 08             	sub    $0x8,%esp
80104dba:	50                   	push   %eax
80104dbb:	6a 02                	push   $0x2
80104dbd:	e8 ae fb ff ff       	call   80104970 <argint>
80104dc2:	83 c4 10             	add    $0x10,%esp
80104dc5:	85 c0                	test   %eax,%eax
80104dc7:	78 37                	js     80104e00 <sys_write+0x60>
80104dc9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dcc:	83 ec 04             	sub    $0x4,%esp
80104dcf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd2:	50                   	push   %eax
80104dd3:	6a 01                	push   $0x1
80104dd5:	e8 e6 fb ff ff       	call   801049c0 <argptr>
80104dda:	83 c4 10             	add    $0x10,%esp
80104ddd:	85 c0                	test   %eax,%eax
80104ddf:	78 1f                	js     80104e00 <sys_write+0x60>
  return filewrite(f, p, n);
80104de1:	83 ec 04             	sub    $0x4,%esp
80104de4:	ff 75 f0             	pushl  -0x10(%ebp)
80104de7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dea:	ff 75 ec             	pushl  -0x14(%ebp)
80104ded:	e8 0e c2 ff ff       	call   80101000 <filewrite>
80104df2:	83 c4 10             	add    $0x10,%esp
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <sys_close>:
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e16:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e19:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e1c:	e8 4f fe ff ff       	call   80104c70 <argfd.constprop.0>
80104e21:	85 c0                	test   %eax,%eax
80104e23:	78 2b                	js     80104e50 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e25:	e8 26 ea ff ff       	call   80103850 <myproc>
80104e2a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e2d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e30:	c7 44 90 20 00 00 00 	movl   $0x0,0x20(%eax,%edx,4)
80104e37:	00 
  fileclose(f);
80104e38:	ff 75 f4             	pushl  -0xc(%ebp)
80104e3b:	e8 10 c0 ff ff       	call   80100e50 <fileclose>
  return 0;
80104e40:	83 c4 10             	add    $0x10,%esp
80104e43:	31 c0                	xor    %eax,%eax
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <sys_fstat>:
{
80104e60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e61:	31 c0                	xor    %eax,%eax
{
80104e63:	89 e5                	mov    %esp,%ebp
80104e65:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e68:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e6b:	e8 00 fe ff ff       	call   80104c70 <argfd.constprop.0>
80104e70:	85 c0                	test   %eax,%eax
80104e72:	78 2c                	js     80104ea0 <sys_fstat+0x40>
80104e74:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e77:	83 ec 04             	sub    $0x4,%esp
80104e7a:	6a 14                	push   $0x14
80104e7c:	50                   	push   %eax
80104e7d:	6a 01                	push   $0x1
80104e7f:	e8 3c fb ff ff       	call   801049c0 <argptr>
80104e84:	83 c4 10             	add    $0x10,%esp
80104e87:	85 c0                	test   %eax,%eax
80104e89:	78 15                	js     80104ea0 <sys_fstat+0x40>
  return filestat(f, st);
80104e8b:	83 ec 08             	sub    $0x8,%esp
80104e8e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e91:	ff 75 f0             	pushl  -0x10(%ebp)
80104e94:	e8 87 c0 ff ff       	call   80100f20 <filestat>
80104e99:	83 c4 10             	add    $0x10,%esp
}
80104e9c:	c9                   	leave  
80104e9d:	c3                   	ret    
80104e9e:	66 90                	xchg   %ax,%ax
    return -1;
80104ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ea5:	c9                   	leave  
80104ea6:	c3                   	ret    
80104ea7:	89 f6                	mov    %esi,%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104eb0 <sys_link>:
{
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	57                   	push   %edi
80104eb4:	56                   	push   %esi
80104eb5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104eb6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104eb9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ebc:	50                   	push   %eax
80104ebd:	6a 00                	push   $0x0
80104ebf:	e8 5c fb ff ff       	call   80104a20 <argstr>
80104ec4:	83 c4 10             	add    $0x10,%esp
80104ec7:	85 c0                	test   %eax,%eax
80104ec9:	0f 88 fb 00 00 00    	js     80104fca <sys_link+0x11a>
80104ecf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ed2:	83 ec 08             	sub    $0x8,%esp
80104ed5:	50                   	push   %eax
80104ed6:	6a 01                	push   $0x1
80104ed8:	e8 43 fb ff ff       	call   80104a20 <argstr>
80104edd:	83 c4 10             	add    $0x10,%esp
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	0f 88 e2 00 00 00    	js     80104fca <sys_link+0x11a>
  begin_op();
80104ee8:	e8 d3 dc ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
80104eed:	83 ec 0c             	sub    $0xc,%esp
80104ef0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ef3:	e8 08 d0 ff ff       	call   80101f00 <namei>
80104ef8:	83 c4 10             	add    $0x10,%esp
80104efb:	85 c0                	test   %eax,%eax
80104efd:	89 c3                	mov    %eax,%ebx
80104eff:	0f 84 ea 00 00 00    	je     80104fef <sys_link+0x13f>
  ilock(ip);
80104f05:	83 ec 0c             	sub    $0xc,%esp
80104f08:	50                   	push   %eax
80104f09:	e8 92 c7 ff ff       	call   801016a0 <ilock>
  if(ip->type == T_DIR){
80104f0e:	83 c4 10             	add    $0x10,%esp
80104f11:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f16:	0f 84 bb 00 00 00    	je     80104fd7 <sys_link+0x127>
  ip->nlink++;
80104f1c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f21:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104f24:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f27:	53                   	push   %ebx
80104f28:	e8 c3 c6 ff ff       	call   801015f0 <iupdate>
  iunlock(ip);
80104f2d:	89 1c 24             	mov    %ebx,(%esp)
80104f30:	e8 4b c8 ff ff       	call   80101780 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f35:	58                   	pop    %eax
80104f36:	5a                   	pop    %edx
80104f37:	57                   	push   %edi
80104f38:	ff 75 d0             	pushl  -0x30(%ebp)
80104f3b:	e8 e0 cf ff ff       	call   80101f20 <nameiparent>
80104f40:	83 c4 10             	add    $0x10,%esp
80104f43:	85 c0                	test   %eax,%eax
80104f45:	89 c6                	mov    %eax,%esi
80104f47:	74 5b                	je     80104fa4 <sys_link+0xf4>
  ilock(dp);
80104f49:	83 ec 0c             	sub    $0xc,%esp
80104f4c:	50                   	push   %eax
80104f4d:	e8 4e c7 ff ff       	call   801016a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f52:	83 c4 10             	add    $0x10,%esp
80104f55:	8b 03                	mov    (%ebx),%eax
80104f57:	39 06                	cmp    %eax,(%esi)
80104f59:	75 3d                	jne    80104f98 <sys_link+0xe8>
80104f5b:	83 ec 04             	sub    $0x4,%esp
80104f5e:	ff 73 04             	pushl  0x4(%ebx)
80104f61:	57                   	push   %edi
80104f62:	56                   	push   %esi
80104f63:	e8 d8 ce ff ff       	call   80101e40 <dirlink>
80104f68:	83 c4 10             	add    $0x10,%esp
80104f6b:	85 c0                	test   %eax,%eax
80104f6d:	78 29                	js     80104f98 <sys_link+0xe8>
  iunlockput(dp);
80104f6f:	83 ec 0c             	sub    $0xc,%esp
80104f72:	56                   	push   %esi
80104f73:	e8 b8 c9 ff ff       	call   80101930 <iunlockput>
  iput(ip);
80104f78:	89 1c 24             	mov    %ebx,(%esp)
80104f7b:	e8 50 c8 ff ff       	call   801017d0 <iput>
  end_op();
80104f80:	e8 ab dc ff ff       	call   80102c30 <end_op>
  return 0;
80104f85:	83 c4 10             	add    $0x10,%esp
80104f88:	31 c0                	xor    %eax,%eax
}
80104f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f8d:	5b                   	pop    %ebx
80104f8e:	5e                   	pop    %esi
80104f8f:	5f                   	pop    %edi
80104f90:	5d                   	pop    %ebp
80104f91:	c3                   	ret    
80104f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f98:	83 ec 0c             	sub    $0xc,%esp
80104f9b:	56                   	push   %esi
80104f9c:	e8 8f c9 ff ff       	call   80101930 <iunlockput>
    goto bad;
80104fa1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	53                   	push   %ebx
80104fa8:	e8 f3 c6 ff ff       	call   801016a0 <ilock>
  ip->nlink--;
80104fad:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fb2:	89 1c 24             	mov    %ebx,(%esp)
80104fb5:	e8 36 c6 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
80104fba:	89 1c 24             	mov    %ebx,(%esp)
80104fbd:	e8 6e c9 ff ff       	call   80101930 <iunlockput>
  end_op();
80104fc2:	e8 69 dc ff ff       	call   80102c30 <end_op>
  return -1;
80104fc7:	83 c4 10             	add    $0x10,%esp
}
80104fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104fcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd2:	5b                   	pop    %ebx
80104fd3:	5e                   	pop    %esi
80104fd4:	5f                   	pop    %edi
80104fd5:	5d                   	pop    %ebp
80104fd6:	c3                   	ret    
    iunlockput(ip);
80104fd7:	83 ec 0c             	sub    $0xc,%esp
80104fda:	53                   	push   %ebx
80104fdb:	e8 50 c9 ff ff       	call   80101930 <iunlockput>
    end_op();
80104fe0:	e8 4b dc ff ff       	call   80102c30 <end_op>
    return -1;
80104fe5:	83 c4 10             	add    $0x10,%esp
80104fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fed:	eb 9b                	jmp    80104f8a <sys_link+0xda>
    end_op();
80104fef:	e8 3c dc ff ff       	call   80102c30 <end_op>
    return -1;
80104ff4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ff9:	eb 8f                	jmp    80104f8a <sys_link+0xda>
80104ffb:	90                   	nop
80104ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105000 <sys_unlink>:
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	57                   	push   %edi
80105004:	56                   	push   %esi
80105005:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105006:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105009:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010500c:	50                   	push   %eax
8010500d:	6a 00                	push   $0x0
8010500f:	e8 0c fa ff ff       	call   80104a20 <argstr>
80105014:	83 c4 10             	add    $0x10,%esp
80105017:	85 c0                	test   %eax,%eax
80105019:	0f 88 77 01 00 00    	js     80105196 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010501f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105022:	e8 99 db ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105027:	83 ec 08             	sub    $0x8,%esp
8010502a:	53                   	push   %ebx
8010502b:	ff 75 c0             	pushl  -0x40(%ebp)
8010502e:	e8 ed ce ff ff       	call   80101f20 <nameiparent>
80105033:	83 c4 10             	add    $0x10,%esp
80105036:	85 c0                	test   %eax,%eax
80105038:	89 c6                	mov    %eax,%esi
8010503a:	0f 84 60 01 00 00    	je     801051a0 <sys_unlink+0x1a0>
  ilock(dp);
80105040:	83 ec 0c             	sub    $0xc,%esp
80105043:	50                   	push   %eax
80105044:	e8 57 c6 ff ff       	call   801016a0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105049:	58                   	pop    %eax
8010504a:	5a                   	pop    %edx
8010504b:	68 34 78 10 80       	push   $0x80107834
80105050:	53                   	push   %ebx
80105051:	e8 5a cb ff ff       	call   80101bb0 <namecmp>
80105056:	83 c4 10             	add    $0x10,%esp
80105059:	85 c0                	test   %eax,%eax
8010505b:	0f 84 03 01 00 00    	je     80105164 <sys_unlink+0x164>
80105061:	83 ec 08             	sub    $0x8,%esp
80105064:	68 33 78 10 80       	push   $0x80107833
80105069:	53                   	push   %ebx
8010506a:	e8 41 cb ff ff       	call   80101bb0 <namecmp>
8010506f:	83 c4 10             	add    $0x10,%esp
80105072:	85 c0                	test   %eax,%eax
80105074:	0f 84 ea 00 00 00    	je     80105164 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010507a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010507d:	83 ec 04             	sub    $0x4,%esp
80105080:	50                   	push   %eax
80105081:	53                   	push   %ebx
80105082:	56                   	push   %esi
80105083:	e8 48 cb ff ff       	call   80101bd0 <dirlookup>
80105088:	83 c4 10             	add    $0x10,%esp
8010508b:	85 c0                	test   %eax,%eax
8010508d:	89 c3                	mov    %eax,%ebx
8010508f:	0f 84 cf 00 00 00    	je     80105164 <sys_unlink+0x164>
  ilock(ip);
80105095:	83 ec 0c             	sub    $0xc,%esp
80105098:	50                   	push   %eax
80105099:	e8 02 c6 ff ff       	call   801016a0 <ilock>
  if(ip->nlink < 1)
8010509e:	83 c4 10             	add    $0x10,%esp
801050a1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801050a6:	0f 8e 10 01 00 00    	jle    801051bc <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801050ac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050b1:	74 6d                	je     80105120 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801050b3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050b6:	83 ec 04             	sub    $0x4,%esp
801050b9:	6a 10                	push   $0x10
801050bb:	6a 00                	push   $0x0
801050bd:	50                   	push   %eax
801050be:	e8 ad f5 ff ff       	call   80104670 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050c3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050c6:	6a 10                	push   $0x10
801050c8:	ff 75 c4             	pushl  -0x3c(%ebp)
801050cb:	50                   	push   %eax
801050cc:	56                   	push   %esi
801050cd:	e8 ae c9 ff ff       	call   80101a80 <writei>
801050d2:	83 c4 20             	add    $0x20,%esp
801050d5:	83 f8 10             	cmp    $0x10,%eax
801050d8:	0f 85 eb 00 00 00    	jne    801051c9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801050de:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050e3:	0f 84 97 00 00 00    	je     80105180 <sys_unlink+0x180>
  iunlockput(dp);
801050e9:	83 ec 0c             	sub    $0xc,%esp
801050ec:	56                   	push   %esi
801050ed:	e8 3e c8 ff ff       	call   80101930 <iunlockput>
  ip->nlink--;
801050f2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050f7:	89 1c 24             	mov    %ebx,(%esp)
801050fa:	e8 f1 c4 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
801050ff:	89 1c 24             	mov    %ebx,(%esp)
80105102:	e8 29 c8 ff ff       	call   80101930 <iunlockput>
  end_op();
80105107:	e8 24 db ff ff       	call   80102c30 <end_op>
  return 0;
8010510c:	83 c4 10             	add    $0x10,%esp
8010510f:	31 c0                	xor    %eax,%eax
}
80105111:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105114:	5b                   	pop    %ebx
80105115:	5e                   	pop    %esi
80105116:	5f                   	pop    %edi
80105117:	5d                   	pop    %ebp
80105118:	c3                   	ret    
80105119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105120:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105124:	76 8d                	jbe    801050b3 <sys_unlink+0xb3>
80105126:	bf 20 00 00 00       	mov    $0x20,%edi
8010512b:	eb 0f                	jmp    8010513c <sys_unlink+0x13c>
8010512d:	8d 76 00             	lea    0x0(%esi),%esi
80105130:	83 c7 10             	add    $0x10,%edi
80105133:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105136:	0f 83 77 ff ff ff    	jae    801050b3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010513c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010513f:	6a 10                	push   $0x10
80105141:	57                   	push   %edi
80105142:	50                   	push   %eax
80105143:	53                   	push   %ebx
80105144:	e8 37 c8 ff ff       	call   80101980 <readi>
80105149:	83 c4 10             	add    $0x10,%esp
8010514c:	83 f8 10             	cmp    $0x10,%eax
8010514f:	75 5e                	jne    801051af <sys_unlink+0x1af>
    if(de.inum != 0)
80105151:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105156:	74 d8                	je     80105130 <sys_unlink+0x130>
    iunlockput(ip);
80105158:	83 ec 0c             	sub    $0xc,%esp
8010515b:	53                   	push   %ebx
8010515c:	e8 cf c7 ff ff       	call   80101930 <iunlockput>
    goto bad;
80105161:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105164:	83 ec 0c             	sub    $0xc,%esp
80105167:	56                   	push   %esi
80105168:	e8 c3 c7 ff ff       	call   80101930 <iunlockput>
  end_op();
8010516d:	e8 be da ff ff       	call   80102c30 <end_op>
  return -1;
80105172:	83 c4 10             	add    $0x10,%esp
80105175:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010517a:	eb 95                	jmp    80105111 <sys_unlink+0x111>
8010517c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105180:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105185:	83 ec 0c             	sub    $0xc,%esp
80105188:	56                   	push   %esi
80105189:	e8 62 c4 ff ff       	call   801015f0 <iupdate>
8010518e:	83 c4 10             	add    $0x10,%esp
80105191:	e9 53 ff ff ff       	jmp    801050e9 <sys_unlink+0xe9>
    return -1;
80105196:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010519b:	e9 71 ff ff ff       	jmp    80105111 <sys_unlink+0x111>
    end_op();
801051a0:	e8 8b da ff ff       	call   80102c30 <end_op>
    return -1;
801051a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051aa:	e9 62 ff ff ff       	jmp    80105111 <sys_unlink+0x111>
      panic("isdirempty: readi");
801051af:	83 ec 0c             	sub    $0xc,%esp
801051b2:	68 58 78 10 80       	push   $0x80107858
801051b7:	e8 d4 b1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801051bc:	83 ec 0c             	sub    $0xc,%esp
801051bf:	68 46 78 10 80       	push   $0x80107846
801051c4:	e8 c7 b1 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801051c9:	83 ec 0c             	sub    $0xc,%esp
801051cc:	68 6a 78 10 80       	push   $0x8010786a
801051d1:	e8 ba b1 ff ff       	call   80100390 <panic>
801051d6:	8d 76 00             	lea    0x0(%esi),%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051e0 <sys_open>:

int
sys_open(void)
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	56                   	push   %esi
801051e5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051e6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801051e9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051ec:	50                   	push   %eax
801051ed:	6a 00                	push   $0x0
801051ef:	e8 2c f8 ff ff       	call   80104a20 <argstr>
801051f4:	83 c4 10             	add    $0x10,%esp
801051f7:	85 c0                	test   %eax,%eax
801051f9:	0f 88 1d 01 00 00    	js     8010531c <sys_open+0x13c>
801051ff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105202:	83 ec 08             	sub    $0x8,%esp
80105205:	50                   	push   %eax
80105206:	6a 01                	push   $0x1
80105208:	e8 63 f7 ff ff       	call   80104970 <argint>
8010520d:	83 c4 10             	add    $0x10,%esp
80105210:	85 c0                	test   %eax,%eax
80105212:	0f 88 04 01 00 00    	js     8010531c <sys_open+0x13c>
    return -1;

  begin_op();
80105218:	e8 a3 d9 ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
8010521d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105221:	0f 85 a9 00 00 00    	jne    801052d0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105227:	83 ec 0c             	sub    $0xc,%esp
8010522a:	ff 75 e0             	pushl  -0x20(%ebp)
8010522d:	e8 ce cc ff ff       	call   80101f00 <namei>
80105232:	83 c4 10             	add    $0x10,%esp
80105235:	85 c0                	test   %eax,%eax
80105237:	89 c6                	mov    %eax,%esi
80105239:	0f 84 b2 00 00 00    	je     801052f1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010523f:	83 ec 0c             	sub    $0xc,%esp
80105242:	50                   	push   %eax
80105243:	e8 58 c4 ff ff       	call   801016a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105248:	83 c4 10             	add    $0x10,%esp
8010524b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105250:	0f 84 aa 00 00 00    	je     80105300 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105256:	e8 35 bb ff ff       	call   80100d90 <filealloc>
8010525b:	85 c0                	test   %eax,%eax
8010525d:	89 c7                	mov    %eax,%edi
8010525f:	0f 84 a6 00 00 00    	je     8010530b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105265:	e8 e6 e5 ff ff       	call   80103850 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010526a:	31 db                	xor    %ebx,%ebx
8010526c:	eb 0e                	jmp    8010527c <sys_open+0x9c>
8010526e:	66 90                	xchg   %ax,%ax
80105270:	83 c3 01             	add    $0x1,%ebx
80105273:	83 fb 10             	cmp    $0x10,%ebx
80105276:	0f 84 ac 00 00 00    	je     80105328 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010527c:	8b 54 98 20          	mov    0x20(%eax,%ebx,4),%edx
80105280:	85 d2                	test   %edx,%edx
80105282:	75 ec                	jne    80105270 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105284:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105287:	89 7c 98 20          	mov    %edi,0x20(%eax,%ebx,4)
  iunlock(ip);
8010528b:	56                   	push   %esi
8010528c:	e8 ef c4 ff ff       	call   80101780 <iunlock>
  end_op();
80105291:	e8 9a d9 ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
80105296:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010529c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010529f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801052a2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801052a5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801052ac:	89 d0                	mov    %edx,%eax
801052ae:	f7 d0                	not    %eax
801052b0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052b3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801052b6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052b9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801052bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052c0:	89 d8                	mov    %ebx,%eax
801052c2:	5b                   	pop    %ebx
801052c3:	5e                   	pop    %esi
801052c4:	5f                   	pop    %edi
801052c5:	5d                   	pop    %ebp
801052c6:	c3                   	ret    
801052c7:	89 f6                	mov    %esi,%esi
801052c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801052d0:	83 ec 0c             	sub    $0xc,%esp
801052d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052d6:	31 c9                	xor    %ecx,%ecx
801052d8:	6a 00                	push   $0x0
801052da:	ba 02 00 00 00       	mov    $0x2,%edx
801052df:	e8 ec f7 ff ff       	call   80104ad0 <create>
    if(ip == 0){
801052e4:	83 c4 10             	add    $0x10,%esp
801052e7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801052e9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801052eb:	0f 85 65 ff ff ff    	jne    80105256 <sys_open+0x76>
      end_op();
801052f1:	e8 3a d9 ff ff       	call   80102c30 <end_op>
      return -1;
801052f6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052fb:	eb c0                	jmp    801052bd <sys_open+0xdd>
801052fd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105300:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105303:	85 c9                	test   %ecx,%ecx
80105305:	0f 84 4b ff ff ff    	je     80105256 <sys_open+0x76>
    iunlockput(ip);
8010530b:	83 ec 0c             	sub    $0xc,%esp
8010530e:	56                   	push   %esi
8010530f:	e8 1c c6 ff ff       	call   80101930 <iunlockput>
    end_op();
80105314:	e8 17 d9 ff ff       	call   80102c30 <end_op>
    return -1;
80105319:	83 c4 10             	add    $0x10,%esp
8010531c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105321:	eb 9a                	jmp    801052bd <sys_open+0xdd>
80105323:	90                   	nop
80105324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105328:	83 ec 0c             	sub    $0xc,%esp
8010532b:	57                   	push   %edi
8010532c:	e8 1f bb ff ff       	call   80100e50 <fileclose>
80105331:	83 c4 10             	add    $0x10,%esp
80105334:	eb d5                	jmp    8010530b <sys_open+0x12b>
80105336:	8d 76 00             	lea    0x0(%esi),%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105340 <sys_mkdir>:

int
sys_mkdir(void)
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105346:	e8 75 d8 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010534b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010534e:	83 ec 08             	sub    $0x8,%esp
80105351:	50                   	push   %eax
80105352:	6a 00                	push   $0x0
80105354:	e8 c7 f6 ff ff       	call   80104a20 <argstr>
80105359:	83 c4 10             	add    $0x10,%esp
8010535c:	85 c0                	test   %eax,%eax
8010535e:	78 30                	js     80105390 <sys_mkdir+0x50>
80105360:	83 ec 0c             	sub    $0xc,%esp
80105363:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105366:	31 c9                	xor    %ecx,%ecx
80105368:	6a 00                	push   $0x0
8010536a:	ba 01 00 00 00       	mov    $0x1,%edx
8010536f:	e8 5c f7 ff ff       	call   80104ad0 <create>
80105374:	83 c4 10             	add    $0x10,%esp
80105377:	85 c0                	test   %eax,%eax
80105379:	74 15                	je     80105390 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010537b:	83 ec 0c             	sub    $0xc,%esp
8010537e:	50                   	push   %eax
8010537f:	e8 ac c5 ff ff       	call   80101930 <iunlockput>
  end_op();
80105384:	e8 a7 d8 ff ff       	call   80102c30 <end_op>
  return 0;
80105389:	83 c4 10             	add    $0x10,%esp
8010538c:	31 c0                	xor    %eax,%eax
}
8010538e:	c9                   	leave  
8010538f:	c3                   	ret    
    end_op();
80105390:	e8 9b d8 ff ff       	call   80102c30 <end_op>
    return -1;
80105395:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010539a:	c9                   	leave  
8010539b:	c3                   	ret    
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_mknod>:

int
sys_mknod(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053a6:	e8 15 d8 ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053ae:	83 ec 08             	sub    $0x8,%esp
801053b1:	50                   	push   %eax
801053b2:	6a 00                	push   $0x0
801053b4:	e8 67 f6 ff ff       	call   80104a20 <argstr>
801053b9:	83 c4 10             	add    $0x10,%esp
801053bc:	85 c0                	test   %eax,%eax
801053be:	78 60                	js     80105420 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053c3:	83 ec 08             	sub    $0x8,%esp
801053c6:	50                   	push   %eax
801053c7:	6a 01                	push   $0x1
801053c9:	e8 a2 f5 ff ff       	call   80104970 <argint>
  if((argstr(0, &path)) < 0 ||
801053ce:	83 c4 10             	add    $0x10,%esp
801053d1:	85 c0                	test   %eax,%eax
801053d3:	78 4b                	js     80105420 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d8:	83 ec 08             	sub    $0x8,%esp
801053db:	50                   	push   %eax
801053dc:	6a 02                	push   $0x2
801053de:	e8 8d f5 ff ff       	call   80104970 <argint>
     argint(1, &major) < 0 ||
801053e3:	83 c4 10             	add    $0x10,%esp
801053e6:	85 c0                	test   %eax,%eax
801053e8:	78 36                	js     80105420 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801053ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801053ee:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801053f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801053f5:	ba 03 00 00 00       	mov    $0x3,%edx
801053fa:	50                   	push   %eax
801053fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053fe:	e8 cd f6 ff ff       	call   80104ad0 <create>
80105403:	83 c4 10             	add    $0x10,%esp
80105406:	85 c0                	test   %eax,%eax
80105408:	74 16                	je     80105420 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010540a:	83 ec 0c             	sub    $0xc,%esp
8010540d:	50                   	push   %eax
8010540e:	e8 1d c5 ff ff       	call   80101930 <iunlockput>
  end_op();
80105413:	e8 18 d8 ff ff       	call   80102c30 <end_op>
  return 0;
80105418:	83 c4 10             	add    $0x10,%esp
8010541b:	31 c0                	xor    %eax,%eax
}
8010541d:	c9                   	leave  
8010541e:	c3                   	ret    
8010541f:	90                   	nop
    end_op();
80105420:	e8 0b d8 ff ff       	call   80102c30 <end_op>
    return -1;
80105425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010542a:	c9                   	leave  
8010542b:	c3                   	ret    
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105430 <sys_chdir>:

int
sys_chdir(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	56                   	push   %esi
80105434:	53                   	push   %ebx
80105435:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105438:	e8 13 e4 ff ff       	call   80103850 <myproc>
8010543d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010543f:	e8 7c d7 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105444:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105447:	83 ec 08             	sub    $0x8,%esp
8010544a:	50                   	push   %eax
8010544b:	6a 00                	push   $0x0
8010544d:	e8 ce f5 ff ff       	call   80104a20 <argstr>
80105452:	83 c4 10             	add    $0x10,%esp
80105455:	85 c0                	test   %eax,%eax
80105457:	78 77                	js     801054d0 <sys_chdir+0xa0>
80105459:	83 ec 0c             	sub    $0xc,%esp
8010545c:	ff 75 f4             	pushl  -0xc(%ebp)
8010545f:	e8 9c ca ff ff       	call   80101f00 <namei>
80105464:	83 c4 10             	add    $0x10,%esp
80105467:	85 c0                	test   %eax,%eax
80105469:	89 c3                	mov    %eax,%ebx
8010546b:	74 63                	je     801054d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010546d:	83 ec 0c             	sub    $0xc,%esp
80105470:	50                   	push   %eax
80105471:	e8 2a c2 ff ff       	call   801016a0 <ilock>
  if(ip->type != T_DIR){
80105476:	83 c4 10             	add    $0x10,%esp
80105479:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010547e:	75 30                	jne    801054b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105480:	83 ec 0c             	sub    $0xc,%esp
80105483:	53                   	push   %ebx
80105484:	e8 f7 c2 ff ff       	call   80101780 <iunlock>
  iput(curproc->cwd);
80105489:	58                   	pop    %eax
8010548a:	ff 76 60             	pushl  0x60(%esi)
8010548d:	e8 3e c3 ff ff       	call   801017d0 <iput>
  end_op();
80105492:	e8 99 d7 ff ff       	call   80102c30 <end_op>
  curproc->cwd = ip;
80105497:	89 5e 60             	mov    %ebx,0x60(%esi)
  return 0;
8010549a:	83 c4 10             	add    $0x10,%esp
8010549d:	31 c0                	xor    %eax,%eax
}
8010549f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054a2:	5b                   	pop    %ebx
801054a3:	5e                   	pop    %esi
801054a4:	5d                   	pop    %ebp
801054a5:	c3                   	ret    
801054a6:	8d 76 00             	lea    0x0(%esi),%esi
801054a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801054b0:	83 ec 0c             	sub    $0xc,%esp
801054b3:	53                   	push   %ebx
801054b4:	e8 77 c4 ff ff       	call   80101930 <iunlockput>
    end_op();
801054b9:	e8 72 d7 ff ff       	call   80102c30 <end_op>
    return -1;
801054be:	83 c4 10             	add    $0x10,%esp
801054c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054c6:	eb d7                	jmp    8010549f <sys_chdir+0x6f>
801054c8:	90                   	nop
801054c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801054d0:	e8 5b d7 ff ff       	call   80102c30 <end_op>
    return -1;
801054d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054da:	eb c3                	jmp    8010549f <sys_chdir+0x6f>
801054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_exec>:

int
sys_exec(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	57                   	push   %edi
801054e4:	56                   	push   %esi
801054e5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054e6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801054ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054f2:	50                   	push   %eax
801054f3:	6a 00                	push   $0x0
801054f5:	e8 26 f5 ff ff       	call   80104a20 <argstr>
801054fa:	83 c4 10             	add    $0x10,%esp
801054fd:	85 c0                	test   %eax,%eax
801054ff:	0f 88 87 00 00 00    	js     8010558c <sys_exec+0xac>
80105505:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010550b:	83 ec 08             	sub    $0x8,%esp
8010550e:	50                   	push   %eax
8010550f:	6a 01                	push   $0x1
80105511:	e8 5a f4 ff ff       	call   80104970 <argint>
80105516:	83 c4 10             	add    $0x10,%esp
80105519:	85 c0                	test   %eax,%eax
8010551b:	78 6f                	js     8010558c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010551d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105523:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105526:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105528:	68 80 00 00 00       	push   $0x80
8010552d:	6a 00                	push   $0x0
8010552f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105535:	50                   	push   %eax
80105536:	e8 35 f1 ff ff       	call   80104670 <memset>
8010553b:	83 c4 10             	add    $0x10,%esp
8010553e:	eb 2c                	jmp    8010556c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105540:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105546:	85 c0                	test   %eax,%eax
80105548:	74 56                	je     801055a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010554a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105550:	83 ec 08             	sub    $0x8,%esp
80105553:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105556:	52                   	push   %edx
80105557:	50                   	push   %eax
80105558:	e8 a3 f3 ff ff       	call   80104900 <fetchstr>
8010555d:	83 c4 10             	add    $0x10,%esp
80105560:	85 c0                	test   %eax,%eax
80105562:	78 28                	js     8010558c <sys_exec+0xac>
  for(i=0;; i++){
80105564:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105567:	83 fb 20             	cmp    $0x20,%ebx
8010556a:	74 20                	je     8010558c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010556c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105572:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105579:	83 ec 08             	sub    $0x8,%esp
8010557c:	57                   	push   %edi
8010557d:	01 f0                	add    %esi,%eax
8010557f:	50                   	push   %eax
80105580:	e8 3b f3 ff ff       	call   801048c0 <fetchint>
80105585:	83 c4 10             	add    $0x10,%esp
80105588:	85 c0                	test   %eax,%eax
8010558a:	79 b4                	jns    80105540 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010558c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010558f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105594:	5b                   	pop    %ebx
80105595:	5e                   	pop    %esi
80105596:	5f                   	pop    %edi
80105597:	5d                   	pop    %ebp
80105598:	c3                   	ret    
80105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801055a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055a6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801055a9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055b0:	00 00 00 00 
  return exec(path, argv);
801055b4:	50                   	push   %eax
801055b5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801055bb:	e8 50 b4 ff ff       	call   80100a10 <exec>
801055c0:	83 c4 10             	add    $0x10,%esp
}
801055c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055c6:	5b                   	pop    %ebx
801055c7:	5e                   	pop    %esi
801055c8:	5f                   	pop    %edi
801055c9:	5d                   	pop    %ebp
801055ca:	c3                   	ret    
801055cb:	90                   	nop
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <sys_pipe>:

int
sys_pipe(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	57                   	push   %edi
801055d4:	56                   	push   %esi
801055d5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055d6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801055d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055dc:	6a 08                	push   $0x8
801055de:	50                   	push   %eax
801055df:	6a 00                	push   $0x0
801055e1:	e8 da f3 ff ff       	call   801049c0 <argptr>
801055e6:	83 c4 10             	add    $0x10,%esp
801055e9:	85 c0                	test   %eax,%eax
801055eb:	0f 88 ae 00 00 00    	js     8010569f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055f1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055f4:	83 ec 08             	sub    $0x8,%esp
801055f7:	50                   	push   %eax
801055f8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055fb:	50                   	push   %eax
801055fc:	e8 5f dc ff ff       	call   80103260 <pipealloc>
80105601:	83 c4 10             	add    $0x10,%esp
80105604:	85 c0                	test   %eax,%eax
80105606:	0f 88 93 00 00 00    	js     8010569f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010560c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010560f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105611:	e8 3a e2 ff ff       	call   80103850 <myproc>
80105616:	eb 10                	jmp    80105628 <sys_pipe+0x58>
80105618:	90                   	nop
80105619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105620:	83 c3 01             	add    $0x1,%ebx
80105623:	83 fb 10             	cmp    $0x10,%ebx
80105626:	74 60                	je     80105688 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105628:	8b 74 98 20          	mov    0x20(%eax,%ebx,4),%esi
8010562c:	85 f6                	test   %esi,%esi
8010562e:	75 f0                	jne    80105620 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105630:	8d 73 08             	lea    0x8(%ebx),%esi
80105633:	89 3c b0             	mov    %edi,(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105636:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105639:	e8 12 e2 ff ff       	call   80103850 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010563e:	31 d2                	xor    %edx,%edx
80105640:	eb 0e                	jmp    80105650 <sys_pipe+0x80>
80105642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105648:	83 c2 01             	add    $0x1,%edx
8010564b:	83 fa 10             	cmp    $0x10,%edx
8010564e:	74 28                	je     80105678 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105650:	8b 4c 90 20          	mov    0x20(%eax,%edx,4),%ecx
80105654:	85 c9                	test   %ecx,%ecx
80105656:	75 f0                	jne    80105648 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105658:	89 7c 90 20          	mov    %edi,0x20(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010565c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010565f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105661:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105664:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105667:	31 c0                	xor    %eax,%eax
}
80105669:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010566c:	5b                   	pop    %ebx
8010566d:	5e                   	pop    %esi
8010566e:	5f                   	pop    %edi
8010566f:	5d                   	pop    %ebp
80105670:	c3                   	ret    
80105671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105678:	e8 d3 e1 ff ff       	call   80103850 <myproc>
8010567d:	c7 04 b0 00 00 00 00 	movl   $0x0,(%eax,%esi,4)
80105684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80105688:	83 ec 0c             	sub    $0xc,%esp
8010568b:	ff 75 e0             	pushl  -0x20(%ebp)
8010568e:	e8 bd b7 ff ff       	call   80100e50 <fileclose>
    fileclose(wf);
80105693:	58                   	pop    %eax
80105694:	ff 75 e4             	pushl  -0x1c(%ebp)
80105697:	e8 b4 b7 ff ff       	call   80100e50 <fileclose>
    return -1;
8010569c:	83 c4 10             	add    $0x10,%esp
8010569f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a4:	eb c3                	jmp    80105669 <sys_pipe+0x99>
801056a6:	66 90                	xchg   %ax,%ax
801056a8:	66 90                	xchg   %ax,%ax
801056aa:	66 90                	xchg   %ax,%ax
801056ac:	66 90                	xchg   %ax,%ax
801056ae:	66 90                	xchg   %ax,%ax

801056b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801056b3:	5d                   	pop    %ebp
  return fork();
801056b4:	e9 77 e3 ff ff       	jmp    80103a30 <fork>
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056c0 <sys_exit>:

int
sys_exit(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801056c6:	e8 85 e6 ff ff       	call   80103d50 <exit>
  return 0;  // not reached
}
801056cb:	31 c0                	xor    %eax,%eax
801056cd:	c9                   	leave  
801056ce:	c3                   	ret    
801056cf:	90                   	nop

801056d0 <sys_wait>:

int
sys_wait(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801056d3:	5d                   	pop    %ebp
  return wait();
801056d4:	e9 77 e9 ff ff       	jmp    80104050 <wait>
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056e0 <sys_kill>:

int
sys_kill(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801056e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056e9:	50                   	push   %eax
801056ea:	6a 00                	push   $0x0
801056ec:	e8 7f f2 ff ff       	call   80104970 <argint>
801056f1:	83 c4 10             	add    $0x10,%esp
801056f4:	85 c0                	test   %eax,%eax
801056f6:	78 18                	js     80105710 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056f8:	83 ec 0c             	sub    $0xc,%esp
801056fb:	ff 75 f4             	pushl  -0xc(%ebp)
801056fe:	e8 bd ea ff ff       	call   801041c0 <kill>
80105703:	83 c4 10             	add    $0x10,%esp
}
80105706:	c9                   	leave  
80105707:	c3                   	ret    
80105708:	90                   	nop
80105709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105715:	c9                   	leave  
80105716:	c3                   	ret    
80105717:	89 f6                	mov    %esi,%esi
80105719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105720 <sys_getpid>:

int
sys_getpid(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105726:	e8 25 e1 ff ff       	call   80103850 <myproc>
8010572b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010572e:	c9                   	leave  
8010572f:	c3                   	ret    

80105730 <sys_sbrk>:

int
sys_sbrk(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105734:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105737:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010573a:	50                   	push   %eax
8010573b:	6a 00                	push   $0x0
8010573d:	e8 2e f2 ff ff       	call   80104970 <argint>
80105742:	83 c4 10             	add    $0x10,%esp
80105745:	85 c0                	test   %eax,%eax
80105747:	78 27                	js     80105770 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105749:	e8 02 e1 ff ff       	call   80103850 <myproc>
  if(growproc(n) < 0)
8010574e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105751:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105753:	ff 75 f4             	pushl  -0xc(%ebp)
80105756:	e8 55 e2 ff ff       	call   801039b0 <growproc>
8010575b:	83 c4 10             	add    $0x10,%esp
8010575e:	85 c0                	test   %eax,%eax
80105760:	78 0e                	js     80105770 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105762:	89 d8                	mov    %ebx,%eax
80105764:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105767:	c9                   	leave  
80105768:	c3                   	ret    
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105770:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105775:	eb eb                	jmp    80105762 <sys_sbrk+0x32>
80105777:	89 f6                	mov    %esi,%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105780 <sys_sleep>:

int
sys_sleep(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105784:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105787:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010578a:	50                   	push   %eax
8010578b:	6a 00                	push   $0x0
8010578d:	e8 de f1 ff ff       	call   80104970 <argint>
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	85 c0                	test   %eax,%eax
80105797:	0f 88 8a 00 00 00    	js     80105827 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	68 80 bb 11 80       	push   $0x8011bb80
801057a5:	e8 b6 ed ff ff       	call   80104560 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057ad:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801057b0:	8b 1d c0 c3 11 80    	mov    0x8011c3c0,%ebx
  while(ticks - ticks0 < n){
801057b6:	85 d2                	test   %edx,%edx
801057b8:	75 27                	jne    801057e1 <sys_sleep+0x61>
801057ba:	eb 54                	jmp    80105810 <sys_sleep+0x90>
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801057c0:	83 ec 08             	sub    $0x8,%esp
801057c3:	68 80 bb 11 80       	push   $0x8011bb80
801057c8:	68 c0 c3 11 80       	push   $0x8011c3c0
801057cd:	e8 be e7 ff ff       	call   80103f90 <sleep>
  while(ticks - ticks0 < n){
801057d2:	a1 c0 c3 11 80       	mov    0x8011c3c0,%eax
801057d7:	83 c4 10             	add    $0x10,%esp
801057da:	29 d8                	sub    %ebx,%eax
801057dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801057df:	73 2f                	jae    80105810 <sys_sleep+0x90>
    if(myproc()->killed){
801057e1:	e8 6a e0 ff ff       	call   80103850 <myproc>
801057e6:	8b 40 1c             	mov    0x1c(%eax),%eax
801057e9:	85 c0                	test   %eax,%eax
801057eb:	74 d3                	je     801057c0 <sys_sleep+0x40>
      release(&tickslock);
801057ed:	83 ec 0c             	sub    $0xc,%esp
801057f0:	68 80 bb 11 80       	push   $0x8011bb80
801057f5:	e8 26 ee ff ff       	call   80104620 <release>
      return -1;
801057fa:	83 c4 10             	add    $0x10,%esp
801057fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105805:	c9                   	leave  
80105806:	c3                   	ret    
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105810:	83 ec 0c             	sub    $0xc,%esp
80105813:	68 80 bb 11 80       	push   $0x8011bb80
80105818:	e8 03 ee ff ff       	call   80104620 <release>
  return 0;
8010581d:	83 c4 10             	add    $0x10,%esp
80105820:	31 c0                	xor    %eax,%eax
}
80105822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105825:	c9                   	leave  
80105826:	c3                   	ret    
    return -1;
80105827:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582c:	eb f4                	jmp    80105822 <sys_sleep+0xa2>
8010582e:	66 90                	xchg   %ax,%ax

80105830 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	53                   	push   %ebx
80105834:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105837:	68 80 bb 11 80       	push   $0x8011bb80
8010583c:	e8 1f ed ff ff       	call   80104560 <acquire>
  xticks = ticks;
80105841:	8b 1d c0 c3 11 80    	mov    0x8011c3c0,%ebx
  release(&tickslock);
80105847:	c7 04 24 80 bb 11 80 	movl   $0x8011bb80,(%esp)
8010584e:	e8 cd ed ff ff       	call   80104620 <release>
  return xticks;
}
80105853:	89 d8                	mov    %ebx,%eax
80105855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105858:	c9                   	leave  
80105859:	c3                   	ret    

8010585a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010585a:	1e                   	push   %ds
  pushl %es
8010585b:	06                   	push   %es
  pushl %fs
8010585c:	0f a0                	push   %fs
  pushl %gs
8010585e:	0f a8                	push   %gs
  pushal
80105860:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105861:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105865:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105867:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105869:	54                   	push   %esp
  call trap
8010586a:	e8 c1 00 00 00       	call   80105930 <trap>
  addl $4, %esp
8010586f:	83 c4 04             	add    $0x4,%esp

80105872 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105872:	61                   	popa   
  popl %gs
80105873:	0f a9                	pop    %gs
  popl %fs
80105875:	0f a1                	pop    %fs
  popl %es
80105877:	07                   	pop    %es
  popl %ds
80105878:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105879:	83 c4 08             	add    $0x8,%esp
  iret
8010587c:	cf                   	iret   
8010587d:	66 90                	xchg   %ax,%ax
8010587f:	90                   	nop

80105880 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105880:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105881:	31 c0                	xor    %eax,%eax
{
80105883:	89 e5                	mov    %esp,%ebp
80105885:	83 ec 08             	sub    $0x8,%esp
80105888:	90                   	nop
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105890:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105897:	c7 04 c5 c2 bb 11 80 	movl   $0x8e000008,-0x7fee443e(,%eax,8)
8010589e:	08 00 00 8e 
801058a2:	66 89 14 c5 c0 bb 11 	mov    %dx,-0x7fee4440(,%eax,8)
801058a9:	80 
801058aa:	c1 ea 10             	shr    $0x10,%edx
801058ad:	66 89 14 c5 c6 bb 11 	mov    %dx,-0x7fee443a(,%eax,8)
801058b4:	80 
  for(i = 0; i < 256; i++)
801058b5:	83 c0 01             	add    $0x1,%eax
801058b8:	3d 00 01 00 00       	cmp    $0x100,%eax
801058bd:	75 d1                	jne    80105890 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801058bf:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
801058c4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801058c7:	c7 05 c2 bd 11 80 08 	movl   $0xef000008,0x8011bdc2
801058ce:	00 00 ef 
  initlock(&tickslock, "time");
801058d1:	68 79 78 10 80       	push   $0x80107879
801058d6:	68 80 bb 11 80       	push   $0x8011bb80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801058db:	66 a3 c0 bd 11 80    	mov    %ax,0x8011bdc0
801058e1:	c1 e8 10             	shr    $0x10,%eax
801058e4:	66 a3 c6 bd 11 80    	mov    %ax,0x8011bdc6
  initlock(&tickslock, "time");
801058ea:	e8 31 eb ff ff       	call   80104420 <initlock>
}
801058ef:	83 c4 10             	add    $0x10,%esp
801058f2:	c9                   	leave  
801058f3:	c3                   	ret    
801058f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105900 <idtinit>:

void
idtinit(void)
{
80105900:	55                   	push   %ebp
  pd[0] = size-1;
80105901:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105906:	89 e5                	mov    %esp,%ebp
80105908:	83 ec 10             	sub    $0x10,%esp
8010590b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010590f:	b8 c0 bb 11 80       	mov    $0x8011bbc0,%eax
80105914:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105918:	c1 e8 10             	shr    $0x10,%eax
8010591b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010591f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105922:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105925:	c9                   	leave  
80105926:	c3                   	ret    
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105930 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	57                   	push   %edi
80105934:	56                   	push   %esi
80105935:	53                   	push   %ebx
80105936:	83 ec 1c             	sub    $0x1c,%esp
80105939:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010593c:	8b 47 30             	mov    0x30(%edi),%eax
8010593f:	83 f8 40             	cmp    $0x40,%eax
80105942:	0f 84 f0 00 00 00    	je     80105a38 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105948:	83 e8 20             	sub    $0x20,%eax
8010594b:	83 f8 1f             	cmp    $0x1f,%eax
8010594e:	77 10                	ja     80105960 <trap+0x30>
80105950:	ff 24 85 20 79 10 80 	jmp    *-0x7fef86e0(,%eax,4)
80105957:	89 f6                	mov    %esi,%esi
80105959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105960:	e8 eb de ff ff       	call   80103850 <myproc>
80105965:	85 c0                	test   %eax,%eax
80105967:	8b 5f 38             	mov    0x38(%edi),%ebx
8010596a:	0f 84 14 02 00 00    	je     80105b84 <trap+0x254>
80105970:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105974:	0f 84 0a 02 00 00    	je     80105b84 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010597a:	0f 20 d1             	mov    %cr2,%ecx
8010597d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105980:	e8 ab de ff ff       	call   80103830 <cpuid>
80105985:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105988:	8b 47 34             	mov    0x34(%edi),%eax
8010598b:	8b 77 30             	mov    0x30(%edi),%esi
8010598e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105991:	e8 ba de ff ff       	call   80103850 <myproc>
80105996:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105999:	e8 b2 de ff ff       	call   80103850 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010599e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801059a1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801059a4:	51                   	push   %ecx
801059a5:	53                   	push   %ebx
801059a6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801059a7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059aa:	ff 75 e4             	pushl  -0x1c(%ebp)
801059ad:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801059ae:	83 c2 64             	add    $0x64,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059b1:	52                   	push   %edx
801059b2:	ff 70 10             	pushl  0x10(%eax)
801059b5:	68 dc 78 10 80       	push   $0x801078dc
801059ba:	e8 a1 ac ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801059bf:	83 c4 20             	add    $0x20,%esp
801059c2:	e8 89 de ff ff       	call   80103850 <myproc>
801059c7:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059ce:	e8 7d de ff ff       	call   80103850 <myproc>
801059d3:	85 c0                	test   %eax,%eax
801059d5:	74 1d                	je     801059f4 <trap+0xc4>
801059d7:	e8 74 de ff ff       	call   80103850 <myproc>
801059dc:	8b 50 1c             	mov    0x1c(%eax),%edx
801059df:	85 d2                	test   %edx,%edx
801059e1:	74 11                	je     801059f4 <trap+0xc4>
801059e3:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059e7:	83 e0 03             	and    $0x3,%eax
801059ea:	66 83 f8 03          	cmp    $0x3,%ax
801059ee:	0f 84 4c 01 00 00    	je     80105b40 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059f4:	e8 57 de ff ff       	call   80103850 <myproc>
801059f9:	85 c0                	test   %eax,%eax
801059fb:	74 0b                	je     80105a08 <trap+0xd8>
801059fd:	e8 4e de ff ff       	call   80103850 <myproc>
80105a02:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a06:	74 68                	je     80105a70 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a08:	e8 43 de ff ff       	call   80103850 <myproc>
80105a0d:	85 c0                	test   %eax,%eax
80105a0f:	74 19                	je     80105a2a <trap+0xfa>
80105a11:	e8 3a de ff ff       	call   80103850 <myproc>
80105a16:	8b 40 1c             	mov    0x1c(%eax),%eax
80105a19:	85 c0                	test   %eax,%eax
80105a1b:	74 0d                	je     80105a2a <trap+0xfa>
80105a1d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105a21:	83 e0 03             	and    $0x3,%eax
80105a24:	66 83 f8 03          	cmp    $0x3,%ax
80105a28:	74 37                	je     80105a61 <trap+0x131>
    exit();
}
80105a2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a2d:	5b                   	pop    %ebx
80105a2e:	5e                   	pop    %esi
80105a2f:	5f                   	pop    %edi
80105a30:	5d                   	pop    %ebp
80105a31:	c3                   	ret    
80105a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105a38:	e8 13 de ff ff       	call   80103850 <myproc>
80105a3d:	8b 58 1c             	mov    0x1c(%eax),%ebx
80105a40:	85 db                	test   %ebx,%ebx
80105a42:	0f 85 e8 00 00 00    	jne    80105b30 <trap+0x200>
    mythread()->tf = tf;
80105a48:	e8 33 de ff ff       	call   80103880 <mythread>
80105a4d:	89 78 10             	mov    %edi,0x10(%eax)
    syscall();
80105a50:	e8 0b f0 ff ff       	call   80104a60 <syscall>
    if(myproc()->killed)
80105a55:	e8 f6 dd ff ff       	call   80103850 <myproc>
80105a5a:	8b 48 1c             	mov    0x1c(%eax),%ecx
80105a5d:	85 c9                	test   %ecx,%ecx
80105a5f:	74 c9                	je     80105a2a <trap+0xfa>
}
80105a61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a64:	5b                   	pop    %ebx
80105a65:	5e                   	pop    %esi
80105a66:	5f                   	pop    %edi
80105a67:	5d                   	pop    %ebp
      exit();
80105a68:	e9 e3 e2 ff ff       	jmp    80103d50 <exit>
80105a6d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105a70:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105a74:	75 92                	jne    80105a08 <trap+0xd8>
    yield();
80105a76:	e8 c5 e4 ff ff       	call   80103f40 <yield>
80105a7b:	eb 8b                	jmp    80105a08 <trap+0xd8>
80105a7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105a80:	e8 ab dd ff ff       	call   80103830 <cpuid>
80105a85:	85 c0                	test   %eax,%eax
80105a87:	0f 84 c3 00 00 00    	je     80105b50 <trap+0x220>
    lapiceoi();
80105a8d:	e8 de cc ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a92:	e8 b9 dd ff ff       	call   80103850 <myproc>
80105a97:	85 c0                	test   %eax,%eax
80105a99:	0f 85 38 ff ff ff    	jne    801059d7 <trap+0xa7>
80105a9f:	e9 50 ff ff ff       	jmp    801059f4 <trap+0xc4>
80105aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105aa8:	e8 83 cb ff ff       	call   80102630 <kbdintr>
    lapiceoi();
80105aad:	e8 be cc ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ab2:	e8 99 dd ff ff       	call   80103850 <myproc>
80105ab7:	85 c0                	test   %eax,%eax
80105ab9:	0f 85 18 ff ff ff    	jne    801059d7 <trap+0xa7>
80105abf:	e9 30 ff ff ff       	jmp    801059f4 <trap+0xc4>
80105ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105ac8:	e8 53 02 00 00       	call   80105d20 <uartintr>
    lapiceoi();
80105acd:	e8 9e cc ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ad2:	e8 79 dd ff ff       	call   80103850 <myproc>
80105ad7:	85 c0                	test   %eax,%eax
80105ad9:	0f 85 f8 fe ff ff    	jne    801059d7 <trap+0xa7>
80105adf:	e9 10 ff ff ff       	jmp    801059f4 <trap+0xc4>
80105ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ae8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105aec:	8b 77 38             	mov    0x38(%edi),%esi
80105aef:	e8 3c dd ff ff       	call   80103830 <cpuid>
80105af4:	56                   	push   %esi
80105af5:	53                   	push   %ebx
80105af6:	50                   	push   %eax
80105af7:	68 84 78 10 80       	push   $0x80107884
80105afc:	e8 5f ab ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105b01:	e8 6a cc ff ff       	call   80102770 <lapiceoi>
    break;
80105b06:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b09:	e8 42 dd ff ff       	call   80103850 <myproc>
80105b0e:	85 c0                	test   %eax,%eax
80105b10:	0f 85 c1 fe ff ff    	jne    801059d7 <trap+0xa7>
80105b16:	e9 d9 fe ff ff       	jmp    801059f4 <trap+0xc4>
80105b1b:	90                   	nop
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105b20:	e8 7b c5 ff ff       	call   801020a0 <ideintr>
80105b25:	e9 63 ff ff ff       	jmp    80105a8d <trap+0x15d>
80105b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105b30:	e8 1b e2 ff ff       	call   80103d50 <exit>
80105b35:	e9 0e ff ff ff       	jmp    80105a48 <trap+0x118>
80105b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105b40:	e8 0b e2 ff ff       	call   80103d50 <exit>
80105b45:	e9 aa fe ff ff       	jmp    801059f4 <trap+0xc4>
80105b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105b50:	83 ec 0c             	sub    $0xc,%esp
80105b53:	68 80 bb 11 80       	push   $0x8011bb80
80105b58:	e8 03 ea ff ff       	call   80104560 <acquire>
      wakeup(&ticks);
80105b5d:	c7 04 24 c0 c3 11 80 	movl   $0x8011c3c0,(%esp)
      ticks++;
80105b64:	83 05 c0 c3 11 80 01 	addl   $0x1,0x8011c3c0
      wakeup(&ticks);
80105b6b:	e8 d0 e5 ff ff       	call   80104140 <wakeup>
      release(&tickslock);
80105b70:	c7 04 24 80 bb 11 80 	movl   $0x8011bb80,(%esp)
80105b77:	e8 a4 ea ff ff       	call   80104620 <release>
80105b7c:	83 c4 10             	add    $0x10,%esp
80105b7f:	e9 09 ff ff ff       	jmp    80105a8d <trap+0x15d>
80105b84:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105b87:	e8 a4 dc ff ff       	call   80103830 <cpuid>
80105b8c:	83 ec 0c             	sub    $0xc,%esp
80105b8f:	56                   	push   %esi
80105b90:	53                   	push   %ebx
80105b91:	50                   	push   %eax
80105b92:	ff 77 30             	pushl  0x30(%edi)
80105b95:	68 a8 78 10 80       	push   $0x801078a8
80105b9a:	e8 c1 aa ff ff       	call   80100660 <cprintf>
      panic("trap");
80105b9f:	83 c4 14             	add    $0x14,%esp
80105ba2:	68 7e 78 10 80       	push   $0x8010787e
80105ba7:	e8 e4 a7 ff ff       	call   80100390 <panic>
80105bac:	66 90                	xchg   %ax,%ax
80105bae:	66 90                	xchg   %ax,%ax

80105bb0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105bb0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105bb5:	55                   	push   %ebp
80105bb6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105bb8:	85 c0                	test   %eax,%eax
80105bba:	74 1c                	je     80105bd8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105bbc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105bc1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105bc2:	a8 01                	test   $0x1,%al
80105bc4:	74 12                	je     80105bd8 <uartgetc+0x28>
80105bc6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bcb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105bcc:	0f b6 c0             	movzbl %al,%eax
}
80105bcf:	5d                   	pop    %ebp
80105bd0:	c3                   	ret    
80105bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105bd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bdd:	5d                   	pop    %ebp
80105bde:	c3                   	ret    
80105bdf:	90                   	nop

80105be0 <uartputc.part.0>:
uartputc(int c)
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
80105be5:	53                   	push   %ebx
80105be6:	89 c7                	mov    %eax,%edi
80105be8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105bed:	be fd 03 00 00       	mov    $0x3fd,%esi
80105bf2:	83 ec 0c             	sub    $0xc,%esp
80105bf5:	eb 1b                	jmp    80105c12 <uartputc.part.0+0x32>
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105c00:	83 ec 0c             	sub    $0xc,%esp
80105c03:	6a 0a                	push   $0xa
80105c05:	e8 86 cb ff ff       	call   80102790 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c0a:	83 c4 10             	add    $0x10,%esp
80105c0d:	83 eb 01             	sub    $0x1,%ebx
80105c10:	74 07                	je     80105c19 <uartputc.part.0+0x39>
80105c12:	89 f2                	mov    %esi,%edx
80105c14:	ec                   	in     (%dx),%al
80105c15:	a8 20                	test   $0x20,%al
80105c17:	74 e7                	je     80105c00 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c19:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c1e:	89 f8                	mov    %edi,%eax
80105c20:	ee                   	out    %al,(%dx)
}
80105c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c24:	5b                   	pop    %ebx
80105c25:	5e                   	pop    %esi
80105c26:	5f                   	pop    %edi
80105c27:	5d                   	pop    %ebp
80105c28:	c3                   	ret    
80105c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c30 <uartinit>:
{
80105c30:	55                   	push   %ebp
80105c31:	31 c9                	xor    %ecx,%ecx
80105c33:	89 c8                	mov    %ecx,%eax
80105c35:	89 e5                	mov    %esp,%ebp
80105c37:	57                   	push   %edi
80105c38:	56                   	push   %esi
80105c39:	53                   	push   %ebx
80105c3a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105c3f:	89 da                	mov    %ebx,%edx
80105c41:	83 ec 0c             	sub    $0xc,%esp
80105c44:	ee                   	out    %al,(%dx)
80105c45:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105c4a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105c4f:	89 fa                	mov    %edi,%edx
80105c51:	ee                   	out    %al,(%dx)
80105c52:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c57:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c5c:	ee                   	out    %al,(%dx)
80105c5d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105c62:	89 c8                	mov    %ecx,%eax
80105c64:	89 f2                	mov    %esi,%edx
80105c66:	ee                   	out    %al,(%dx)
80105c67:	b8 03 00 00 00       	mov    $0x3,%eax
80105c6c:	89 fa                	mov    %edi,%edx
80105c6e:	ee                   	out    %al,(%dx)
80105c6f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c74:	89 c8                	mov    %ecx,%eax
80105c76:	ee                   	out    %al,(%dx)
80105c77:	b8 01 00 00 00       	mov    $0x1,%eax
80105c7c:	89 f2                	mov    %esi,%edx
80105c7e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c7f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c84:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105c85:	3c ff                	cmp    $0xff,%al
80105c87:	74 5a                	je     80105ce3 <uartinit+0xb3>
  uart = 1;
80105c89:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c90:	00 00 00 
80105c93:	89 da                	mov    %ebx,%edx
80105c95:	ec                   	in     (%dx),%al
80105c96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c9b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c9c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c9f:	bb a0 79 10 80       	mov    $0x801079a0,%ebx
  ioapicenable(IRQ_COM1, 0);
80105ca4:	6a 00                	push   $0x0
80105ca6:	6a 04                	push   $0x4
80105ca8:	e8 43 c6 ff ff       	call   801022f0 <ioapicenable>
80105cad:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105cb0:	b8 78 00 00 00       	mov    $0x78,%eax
80105cb5:	eb 13                	jmp    80105cca <uartinit+0x9a>
80105cb7:	89 f6                	mov    %esi,%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105cc0:	83 c3 01             	add    $0x1,%ebx
80105cc3:	0f be 03             	movsbl (%ebx),%eax
80105cc6:	84 c0                	test   %al,%al
80105cc8:	74 19                	je     80105ce3 <uartinit+0xb3>
  if(!uart)
80105cca:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105cd0:	85 d2                	test   %edx,%edx
80105cd2:	74 ec                	je     80105cc0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105cd4:	83 c3 01             	add    $0x1,%ebx
80105cd7:	e8 04 ff ff ff       	call   80105be0 <uartputc.part.0>
80105cdc:	0f be 03             	movsbl (%ebx),%eax
80105cdf:	84 c0                	test   %al,%al
80105ce1:	75 e7                	jne    80105cca <uartinit+0x9a>
}
80105ce3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ce6:	5b                   	pop    %ebx
80105ce7:	5e                   	pop    %esi
80105ce8:	5f                   	pop    %edi
80105ce9:	5d                   	pop    %ebp
80105cea:	c3                   	ret    
80105ceb:	90                   	nop
80105cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cf0 <uartputc>:
  if(!uart)
80105cf0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105cf6:	55                   	push   %ebp
80105cf7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105cf9:	85 d2                	test   %edx,%edx
{
80105cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105cfe:	74 10                	je     80105d10 <uartputc+0x20>
}
80105d00:	5d                   	pop    %ebp
80105d01:	e9 da fe ff ff       	jmp    80105be0 <uartputc.part.0>
80105d06:	8d 76 00             	lea    0x0(%esi),%esi
80105d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d10:	5d                   	pop    %ebp
80105d11:	c3                   	ret    
80105d12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d20 <uartintr>:

void
uartintr(void)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105d26:	68 b0 5b 10 80       	push   $0x80105bb0
80105d2b:	e8 e0 aa ff ff       	call   80100810 <consoleintr>
}
80105d30:	83 c4 10             	add    $0x10,%esp
80105d33:	c9                   	leave  
80105d34:	c3                   	ret    

80105d35 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105d35:	6a 00                	push   $0x0
  pushl $0
80105d37:	6a 00                	push   $0x0
  jmp alltraps
80105d39:	e9 1c fb ff ff       	jmp    8010585a <alltraps>

80105d3e <vector1>:
.globl vector1
vector1:
  pushl $0
80105d3e:	6a 00                	push   $0x0
  pushl $1
80105d40:	6a 01                	push   $0x1
  jmp alltraps
80105d42:	e9 13 fb ff ff       	jmp    8010585a <alltraps>

80105d47 <vector2>:
.globl vector2
vector2:
  pushl $0
80105d47:	6a 00                	push   $0x0
  pushl $2
80105d49:	6a 02                	push   $0x2
  jmp alltraps
80105d4b:	e9 0a fb ff ff       	jmp    8010585a <alltraps>

80105d50 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d50:	6a 00                	push   $0x0
  pushl $3
80105d52:	6a 03                	push   $0x3
  jmp alltraps
80105d54:	e9 01 fb ff ff       	jmp    8010585a <alltraps>

80105d59 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d59:	6a 00                	push   $0x0
  pushl $4
80105d5b:	6a 04                	push   $0x4
  jmp alltraps
80105d5d:	e9 f8 fa ff ff       	jmp    8010585a <alltraps>

80105d62 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d62:	6a 00                	push   $0x0
  pushl $5
80105d64:	6a 05                	push   $0x5
  jmp alltraps
80105d66:	e9 ef fa ff ff       	jmp    8010585a <alltraps>

80105d6b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d6b:	6a 00                	push   $0x0
  pushl $6
80105d6d:	6a 06                	push   $0x6
  jmp alltraps
80105d6f:	e9 e6 fa ff ff       	jmp    8010585a <alltraps>

80105d74 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d74:	6a 00                	push   $0x0
  pushl $7
80105d76:	6a 07                	push   $0x7
  jmp alltraps
80105d78:	e9 dd fa ff ff       	jmp    8010585a <alltraps>

80105d7d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d7d:	6a 08                	push   $0x8
  jmp alltraps
80105d7f:	e9 d6 fa ff ff       	jmp    8010585a <alltraps>

80105d84 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d84:	6a 00                	push   $0x0
  pushl $9
80105d86:	6a 09                	push   $0x9
  jmp alltraps
80105d88:	e9 cd fa ff ff       	jmp    8010585a <alltraps>

80105d8d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d8d:	6a 0a                	push   $0xa
  jmp alltraps
80105d8f:	e9 c6 fa ff ff       	jmp    8010585a <alltraps>

80105d94 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d94:	6a 0b                	push   $0xb
  jmp alltraps
80105d96:	e9 bf fa ff ff       	jmp    8010585a <alltraps>

80105d9b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d9b:	6a 0c                	push   $0xc
  jmp alltraps
80105d9d:	e9 b8 fa ff ff       	jmp    8010585a <alltraps>

80105da2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105da2:	6a 0d                	push   $0xd
  jmp alltraps
80105da4:	e9 b1 fa ff ff       	jmp    8010585a <alltraps>

80105da9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105da9:	6a 0e                	push   $0xe
  jmp alltraps
80105dab:	e9 aa fa ff ff       	jmp    8010585a <alltraps>

80105db0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105db0:	6a 00                	push   $0x0
  pushl $15
80105db2:	6a 0f                	push   $0xf
  jmp alltraps
80105db4:	e9 a1 fa ff ff       	jmp    8010585a <alltraps>

80105db9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105db9:	6a 00                	push   $0x0
  pushl $16
80105dbb:	6a 10                	push   $0x10
  jmp alltraps
80105dbd:	e9 98 fa ff ff       	jmp    8010585a <alltraps>

80105dc2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105dc2:	6a 11                	push   $0x11
  jmp alltraps
80105dc4:	e9 91 fa ff ff       	jmp    8010585a <alltraps>

80105dc9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105dc9:	6a 00                	push   $0x0
  pushl $18
80105dcb:	6a 12                	push   $0x12
  jmp alltraps
80105dcd:	e9 88 fa ff ff       	jmp    8010585a <alltraps>

80105dd2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105dd2:	6a 00                	push   $0x0
  pushl $19
80105dd4:	6a 13                	push   $0x13
  jmp alltraps
80105dd6:	e9 7f fa ff ff       	jmp    8010585a <alltraps>

80105ddb <vector20>:
.globl vector20
vector20:
  pushl $0
80105ddb:	6a 00                	push   $0x0
  pushl $20
80105ddd:	6a 14                	push   $0x14
  jmp alltraps
80105ddf:	e9 76 fa ff ff       	jmp    8010585a <alltraps>

80105de4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105de4:	6a 00                	push   $0x0
  pushl $21
80105de6:	6a 15                	push   $0x15
  jmp alltraps
80105de8:	e9 6d fa ff ff       	jmp    8010585a <alltraps>

80105ded <vector22>:
.globl vector22
vector22:
  pushl $0
80105ded:	6a 00                	push   $0x0
  pushl $22
80105def:	6a 16                	push   $0x16
  jmp alltraps
80105df1:	e9 64 fa ff ff       	jmp    8010585a <alltraps>

80105df6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105df6:	6a 00                	push   $0x0
  pushl $23
80105df8:	6a 17                	push   $0x17
  jmp alltraps
80105dfa:	e9 5b fa ff ff       	jmp    8010585a <alltraps>

80105dff <vector24>:
.globl vector24
vector24:
  pushl $0
80105dff:	6a 00                	push   $0x0
  pushl $24
80105e01:	6a 18                	push   $0x18
  jmp alltraps
80105e03:	e9 52 fa ff ff       	jmp    8010585a <alltraps>

80105e08 <vector25>:
.globl vector25
vector25:
  pushl $0
80105e08:	6a 00                	push   $0x0
  pushl $25
80105e0a:	6a 19                	push   $0x19
  jmp alltraps
80105e0c:	e9 49 fa ff ff       	jmp    8010585a <alltraps>

80105e11 <vector26>:
.globl vector26
vector26:
  pushl $0
80105e11:	6a 00                	push   $0x0
  pushl $26
80105e13:	6a 1a                	push   $0x1a
  jmp alltraps
80105e15:	e9 40 fa ff ff       	jmp    8010585a <alltraps>

80105e1a <vector27>:
.globl vector27
vector27:
  pushl $0
80105e1a:	6a 00                	push   $0x0
  pushl $27
80105e1c:	6a 1b                	push   $0x1b
  jmp alltraps
80105e1e:	e9 37 fa ff ff       	jmp    8010585a <alltraps>

80105e23 <vector28>:
.globl vector28
vector28:
  pushl $0
80105e23:	6a 00                	push   $0x0
  pushl $28
80105e25:	6a 1c                	push   $0x1c
  jmp alltraps
80105e27:	e9 2e fa ff ff       	jmp    8010585a <alltraps>

80105e2c <vector29>:
.globl vector29
vector29:
  pushl $0
80105e2c:	6a 00                	push   $0x0
  pushl $29
80105e2e:	6a 1d                	push   $0x1d
  jmp alltraps
80105e30:	e9 25 fa ff ff       	jmp    8010585a <alltraps>

80105e35 <vector30>:
.globl vector30
vector30:
  pushl $0
80105e35:	6a 00                	push   $0x0
  pushl $30
80105e37:	6a 1e                	push   $0x1e
  jmp alltraps
80105e39:	e9 1c fa ff ff       	jmp    8010585a <alltraps>

80105e3e <vector31>:
.globl vector31
vector31:
  pushl $0
80105e3e:	6a 00                	push   $0x0
  pushl $31
80105e40:	6a 1f                	push   $0x1f
  jmp alltraps
80105e42:	e9 13 fa ff ff       	jmp    8010585a <alltraps>

80105e47 <vector32>:
.globl vector32
vector32:
  pushl $0
80105e47:	6a 00                	push   $0x0
  pushl $32
80105e49:	6a 20                	push   $0x20
  jmp alltraps
80105e4b:	e9 0a fa ff ff       	jmp    8010585a <alltraps>

80105e50 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e50:	6a 00                	push   $0x0
  pushl $33
80105e52:	6a 21                	push   $0x21
  jmp alltraps
80105e54:	e9 01 fa ff ff       	jmp    8010585a <alltraps>

80105e59 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e59:	6a 00                	push   $0x0
  pushl $34
80105e5b:	6a 22                	push   $0x22
  jmp alltraps
80105e5d:	e9 f8 f9 ff ff       	jmp    8010585a <alltraps>

80105e62 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e62:	6a 00                	push   $0x0
  pushl $35
80105e64:	6a 23                	push   $0x23
  jmp alltraps
80105e66:	e9 ef f9 ff ff       	jmp    8010585a <alltraps>

80105e6b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e6b:	6a 00                	push   $0x0
  pushl $36
80105e6d:	6a 24                	push   $0x24
  jmp alltraps
80105e6f:	e9 e6 f9 ff ff       	jmp    8010585a <alltraps>

80105e74 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $37
80105e76:	6a 25                	push   $0x25
  jmp alltraps
80105e78:	e9 dd f9 ff ff       	jmp    8010585a <alltraps>

80105e7d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e7d:	6a 00                	push   $0x0
  pushl $38
80105e7f:	6a 26                	push   $0x26
  jmp alltraps
80105e81:	e9 d4 f9 ff ff       	jmp    8010585a <alltraps>

80105e86 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e86:	6a 00                	push   $0x0
  pushl $39
80105e88:	6a 27                	push   $0x27
  jmp alltraps
80105e8a:	e9 cb f9 ff ff       	jmp    8010585a <alltraps>

80105e8f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e8f:	6a 00                	push   $0x0
  pushl $40
80105e91:	6a 28                	push   $0x28
  jmp alltraps
80105e93:	e9 c2 f9 ff ff       	jmp    8010585a <alltraps>

80105e98 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e98:	6a 00                	push   $0x0
  pushl $41
80105e9a:	6a 29                	push   $0x29
  jmp alltraps
80105e9c:	e9 b9 f9 ff ff       	jmp    8010585a <alltraps>

80105ea1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ea1:	6a 00                	push   $0x0
  pushl $42
80105ea3:	6a 2a                	push   $0x2a
  jmp alltraps
80105ea5:	e9 b0 f9 ff ff       	jmp    8010585a <alltraps>

80105eaa <vector43>:
.globl vector43
vector43:
  pushl $0
80105eaa:	6a 00                	push   $0x0
  pushl $43
80105eac:	6a 2b                	push   $0x2b
  jmp alltraps
80105eae:	e9 a7 f9 ff ff       	jmp    8010585a <alltraps>

80105eb3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105eb3:	6a 00                	push   $0x0
  pushl $44
80105eb5:	6a 2c                	push   $0x2c
  jmp alltraps
80105eb7:	e9 9e f9 ff ff       	jmp    8010585a <alltraps>

80105ebc <vector45>:
.globl vector45
vector45:
  pushl $0
80105ebc:	6a 00                	push   $0x0
  pushl $45
80105ebe:	6a 2d                	push   $0x2d
  jmp alltraps
80105ec0:	e9 95 f9 ff ff       	jmp    8010585a <alltraps>

80105ec5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105ec5:	6a 00                	push   $0x0
  pushl $46
80105ec7:	6a 2e                	push   $0x2e
  jmp alltraps
80105ec9:	e9 8c f9 ff ff       	jmp    8010585a <alltraps>

80105ece <vector47>:
.globl vector47
vector47:
  pushl $0
80105ece:	6a 00                	push   $0x0
  pushl $47
80105ed0:	6a 2f                	push   $0x2f
  jmp alltraps
80105ed2:	e9 83 f9 ff ff       	jmp    8010585a <alltraps>

80105ed7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105ed7:	6a 00                	push   $0x0
  pushl $48
80105ed9:	6a 30                	push   $0x30
  jmp alltraps
80105edb:	e9 7a f9 ff ff       	jmp    8010585a <alltraps>

80105ee0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $49
80105ee2:	6a 31                	push   $0x31
  jmp alltraps
80105ee4:	e9 71 f9 ff ff       	jmp    8010585a <alltraps>

80105ee9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $50
80105eeb:	6a 32                	push   $0x32
  jmp alltraps
80105eed:	e9 68 f9 ff ff       	jmp    8010585a <alltraps>

80105ef2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105ef2:	6a 00                	push   $0x0
  pushl $51
80105ef4:	6a 33                	push   $0x33
  jmp alltraps
80105ef6:	e9 5f f9 ff ff       	jmp    8010585a <alltraps>

80105efb <vector52>:
.globl vector52
vector52:
  pushl $0
80105efb:	6a 00                	push   $0x0
  pushl $52
80105efd:	6a 34                	push   $0x34
  jmp alltraps
80105eff:	e9 56 f9 ff ff       	jmp    8010585a <alltraps>

80105f04 <vector53>:
.globl vector53
vector53:
  pushl $0
80105f04:	6a 00                	push   $0x0
  pushl $53
80105f06:	6a 35                	push   $0x35
  jmp alltraps
80105f08:	e9 4d f9 ff ff       	jmp    8010585a <alltraps>

80105f0d <vector54>:
.globl vector54
vector54:
  pushl $0
80105f0d:	6a 00                	push   $0x0
  pushl $54
80105f0f:	6a 36                	push   $0x36
  jmp alltraps
80105f11:	e9 44 f9 ff ff       	jmp    8010585a <alltraps>

80105f16 <vector55>:
.globl vector55
vector55:
  pushl $0
80105f16:	6a 00                	push   $0x0
  pushl $55
80105f18:	6a 37                	push   $0x37
  jmp alltraps
80105f1a:	e9 3b f9 ff ff       	jmp    8010585a <alltraps>

80105f1f <vector56>:
.globl vector56
vector56:
  pushl $0
80105f1f:	6a 00                	push   $0x0
  pushl $56
80105f21:	6a 38                	push   $0x38
  jmp alltraps
80105f23:	e9 32 f9 ff ff       	jmp    8010585a <alltraps>

80105f28 <vector57>:
.globl vector57
vector57:
  pushl $0
80105f28:	6a 00                	push   $0x0
  pushl $57
80105f2a:	6a 39                	push   $0x39
  jmp alltraps
80105f2c:	e9 29 f9 ff ff       	jmp    8010585a <alltraps>

80105f31 <vector58>:
.globl vector58
vector58:
  pushl $0
80105f31:	6a 00                	push   $0x0
  pushl $58
80105f33:	6a 3a                	push   $0x3a
  jmp alltraps
80105f35:	e9 20 f9 ff ff       	jmp    8010585a <alltraps>

80105f3a <vector59>:
.globl vector59
vector59:
  pushl $0
80105f3a:	6a 00                	push   $0x0
  pushl $59
80105f3c:	6a 3b                	push   $0x3b
  jmp alltraps
80105f3e:	e9 17 f9 ff ff       	jmp    8010585a <alltraps>

80105f43 <vector60>:
.globl vector60
vector60:
  pushl $0
80105f43:	6a 00                	push   $0x0
  pushl $60
80105f45:	6a 3c                	push   $0x3c
  jmp alltraps
80105f47:	e9 0e f9 ff ff       	jmp    8010585a <alltraps>

80105f4c <vector61>:
.globl vector61
vector61:
  pushl $0
80105f4c:	6a 00                	push   $0x0
  pushl $61
80105f4e:	6a 3d                	push   $0x3d
  jmp alltraps
80105f50:	e9 05 f9 ff ff       	jmp    8010585a <alltraps>

80105f55 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f55:	6a 00                	push   $0x0
  pushl $62
80105f57:	6a 3e                	push   $0x3e
  jmp alltraps
80105f59:	e9 fc f8 ff ff       	jmp    8010585a <alltraps>

80105f5e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f5e:	6a 00                	push   $0x0
  pushl $63
80105f60:	6a 3f                	push   $0x3f
  jmp alltraps
80105f62:	e9 f3 f8 ff ff       	jmp    8010585a <alltraps>

80105f67 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f67:	6a 00                	push   $0x0
  pushl $64
80105f69:	6a 40                	push   $0x40
  jmp alltraps
80105f6b:	e9 ea f8 ff ff       	jmp    8010585a <alltraps>

80105f70 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f70:	6a 00                	push   $0x0
  pushl $65
80105f72:	6a 41                	push   $0x41
  jmp alltraps
80105f74:	e9 e1 f8 ff ff       	jmp    8010585a <alltraps>

80105f79 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f79:	6a 00                	push   $0x0
  pushl $66
80105f7b:	6a 42                	push   $0x42
  jmp alltraps
80105f7d:	e9 d8 f8 ff ff       	jmp    8010585a <alltraps>

80105f82 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f82:	6a 00                	push   $0x0
  pushl $67
80105f84:	6a 43                	push   $0x43
  jmp alltraps
80105f86:	e9 cf f8 ff ff       	jmp    8010585a <alltraps>

80105f8b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f8b:	6a 00                	push   $0x0
  pushl $68
80105f8d:	6a 44                	push   $0x44
  jmp alltraps
80105f8f:	e9 c6 f8 ff ff       	jmp    8010585a <alltraps>

80105f94 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f94:	6a 00                	push   $0x0
  pushl $69
80105f96:	6a 45                	push   $0x45
  jmp alltraps
80105f98:	e9 bd f8 ff ff       	jmp    8010585a <alltraps>

80105f9d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f9d:	6a 00                	push   $0x0
  pushl $70
80105f9f:	6a 46                	push   $0x46
  jmp alltraps
80105fa1:	e9 b4 f8 ff ff       	jmp    8010585a <alltraps>

80105fa6 <vector71>:
.globl vector71
vector71:
  pushl $0
80105fa6:	6a 00                	push   $0x0
  pushl $71
80105fa8:	6a 47                	push   $0x47
  jmp alltraps
80105faa:	e9 ab f8 ff ff       	jmp    8010585a <alltraps>

80105faf <vector72>:
.globl vector72
vector72:
  pushl $0
80105faf:	6a 00                	push   $0x0
  pushl $72
80105fb1:	6a 48                	push   $0x48
  jmp alltraps
80105fb3:	e9 a2 f8 ff ff       	jmp    8010585a <alltraps>

80105fb8 <vector73>:
.globl vector73
vector73:
  pushl $0
80105fb8:	6a 00                	push   $0x0
  pushl $73
80105fba:	6a 49                	push   $0x49
  jmp alltraps
80105fbc:	e9 99 f8 ff ff       	jmp    8010585a <alltraps>

80105fc1 <vector74>:
.globl vector74
vector74:
  pushl $0
80105fc1:	6a 00                	push   $0x0
  pushl $74
80105fc3:	6a 4a                	push   $0x4a
  jmp alltraps
80105fc5:	e9 90 f8 ff ff       	jmp    8010585a <alltraps>

80105fca <vector75>:
.globl vector75
vector75:
  pushl $0
80105fca:	6a 00                	push   $0x0
  pushl $75
80105fcc:	6a 4b                	push   $0x4b
  jmp alltraps
80105fce:	e9 87 f8 ff ff       	jmp    8010585a <alltraps>

80105fd3 <vector76>:
.globl vector76
vector76:
  pushl $0
80105fd3:	6a 00                	push   $0x0
  pushl $76
80105fd5:	6a 4c                	push   $0x4c
  jmp alltraps
80105fd7:	e9 7e f8 ff ff       	jmp    8010585a <alltraps>

80105fdc <vector77>:
.globl vector77
vector77:
  pushl $0
80105fdc:	6a 00                	push   $0x0
  pushl $77
80105fde:	6a 4d                	push   $0x4d
  jmp alltraps
80105fe0:	e9 75 f8 ff ff       	jmp    8010585a <alltraps>

80105fe5 <vector78>:
.globl vector78
vector78:
  pushl $0
80105fe5:	6a 00                	push   $0x0
  pushl $78
80105fe7:	6a 4e                	push   $0x4e
  jmp alltraps
80105fe9:	e9 6c f8 ff ff       	jmp    8010585a <alltraps>

80105fee <vector79>:
.globl vector79
vector79:
  pushl $0
80105fee:	6a 00                	push   $0x0
  pushl $79
80105ff0:	6a 4f                	push   $0x4f
  jmp alltraps
80105ff2:	e9 63 f8 ff ff       	jmp    8010585a <alltraps>

80105ff7 <vector80>:
.globl vector80
vector80:
  pushl $0
80105ff7:	6a 00                	push   $0x0
  pushl $80
80105ff9:	6a 50                	push   $0x50
  jmp alltraps
80105ffb:	e9 5a f8 ff ff       	jmp    8010585a <alltraps>

80106000 <vector81>:
.globl vector81
vector81:
  pushl $0
80106000:	6a 00                	push   $0x0
  pushl $81
80106002:	6a 51                	push   $0x51
  jmp alltraps
80106004:	e9 51 f8 ff ff       	jmp    8010585a <alltraps>

80106009 <vector82>:
.globl vector82
vector82:
  pushl $0
80106009:	6a 00                	push   $0x0
  pushl $82
8010600b:	6a 52                	push   $0x52
  jmp alltraps
8010600d:	e9 48 f8 ff ff       	jmp    8010585a <alltraps>

80106012 <vector83>:
.globl vector83
vector83:
  pushl $0
80106012:	6a 00                	push   $0x0
  pushl $83
80106014:	6a 53                	push   $0x53
  jmp alltraps
80106016:	e9 3f f8 ff ff       	jmp    8010585a <alltraps>

8010601b <vector84>:
.globl vector84
vector84:
  pushl $0
8010601b:	6a 00                	push   $0x0
  pushl $84
8010601d:	6a 54                	push   $0x54
  jmp alltraps
8010601f:	e9 36 f8 ff ff       	jmp    8010585a <alltraps>

80106024 <vector85>:
.globl vector85
vector85:
  pushl $0
80106024:	6a 00                	push   $0x0
  pushl $85
80106026:	6a 55                	push   $0x55
  jmp alltraps
80106028:	e9 2d f8 ff ff       	jmp    8010585a <alltraps>

8010602d <vector86>:
.globl vector86
vector86:
  pushl $0
8010602d:	6a 00                	push   $0x0
  pushl $86
8010602f:	6a 56                	push   $0x56
  jmp alltraps
80106031:	e9 24 f8 ff ff       	jmp    8010585a <alltraps>

80106036 <vector87>:
.globl vector87
vector87:
  pushl $0
80106036:	6a 00                	push   $0x0
  pushl $87
80106038:	6a 57                	push   $0x57
  jmp alltraps
8010603a:	e9 1b f8 ff ff       	jmp    8010585a <alltraps>

8010603f <vector88>:
.globl vector88
vector88:
  pushl $0
8010603f:	6a 00                	push   $0x0
  pushl $88
80106041:	6a 58                	push   $0x58
  jmp alltraps
80106043:	e9 12 f8 ff ff       	jmp    8010585a <alltraps>

80106048 <vector89>:
.globl vector89
vector89:
  pushl $0
80106048:	6a 00                	push   $0x0
  pushl $89
8010604a:	6a 59                	push   $0x59
  jmp alltraps
8010604c:	e9 09 f8 ff ff       	jmp    8010585a <alltraps>

80106051 <vector90>:
.globl vector90
vector90:
  pushl $0
80106051:	6a 00                	push   $0x0
  pushl $90
80106053:	6a 5a                	push   $0x5a
  jmp alltraps
80106055:	e9 00 f8 ff ff       	jmp    8010585a <alltraps>

8010605a <vector91>:
.globl vector91
vector91:
  pushl $0
8010605a:	6a 00                	push   $0x0
  pushl $91
8010605c:	6a 5b                	push   $0x5b
  jmp alltraps
8010605e:	e9 f7 f7 ff ff       	jmp    8010585a <alltraps>

80106063 <vector92>:
.globl vector92
vector92:
  pushl $0
80106063:	6a 00                	push   $0x0
  pushl $92
80106065:	6a 5c                	push   $0x5c
  jmp alltraps
80106067:	e9 ee f7 ff ff       	jmp    8010585a <alltraps>

8010606c <vector93>:
.globl vector93
vector93:
  pushl $0
8010606c:	6a 00                	push   $0x0
  pushl $93
8010606e:	6a 5d                	push   $0x5d
  jmp alltraps
80106070:	e9 e5 f7 ff ff       	jmp    8010585a <alltraps>

80106075 <vector94>:
.globl vector94
vector94:
  pushl $0
80106075:	6a 00                	push   $0x0
  pushl $94
80106077:	6a 5e                	push   $0x5e
  jmp alltraps
80106079:	e9 dc f7 ff ff       	jmp    8010585a <alltraps>

8010607e <vector95>:
.globl vector95
vector95:
  pushl $0
8010607e:	6a 00                	push   $0x0
  pushl $95
80106080:	6a 5f                	push   $0x5f
  jmp alltraps
80106082:	e9 d3 f7 ff ff       	jmp    8010585a <alltraps>

80106087 <vector96>:
.globl vector96
vector96:
  pushl $0
80106087:	6a 00                	push   $0x0
  pushl $96
80106089:	6a 60                	push   $0x60
  jmp alltraps
8010608b:	e9 ca f7 ff ff       	jmp    8010585a <alltraps>

80106090 <vector97>:
.globl vector97
vector97:
  pushl $0
80106090:	6a 00                	push   $0x0
  pushl $97
80106092:	6a 61                	push   $0x61
  jmp alltraps
80106094:	e9 c1 f7 ff ff       	jmp    8010585a <alltraps>

80106099 <vector98>:
.globl vector98
vector98:
  pushl $0
80106099:	6a 00                	push   $0x0
  pushl $98
8010609b:	6a 62                	push   $0x62
  jmp alltraps
8010609d:	e9 b8 f7 ff ff       	jmp    8010585a <alltraps>

801060a2 <vector99>:
.globl vector99
vector99:
  pushl $0
801060a2:	6a 00                	push   $0x0
  pushl $99
801060a4:	6a 63                	push   $0x63
  jmp alltraps
801060a6:	e9 af f7 ff ff       	jmp    8010585a <alltraps>

801060ab <vector100>:
.globl vector100
vector100:
  pushl $0
801060ab:	6a 00                	push   $0x0
  pushl $100
801060ad:	6a 64                	push   $0x64
  jmp alltraps
801060af:	e9 a6 f7 ff ff       	jmp    8010585a <alltraps>

801060b4 <vector101>:
.globl vector101
vector101:
  pushl $0
801060b4:	6a 00                	push   $0x0
  pushl $101
801060b6:	6a 65                	push   $0x65
  jmp alltraps
801060b8:	e9 9d f7 ff ff       	jmp    8010585a <alltraps>

801060bd <vector102>:
.globl vector102
vector102:
  pushl $0
801060bd:	6a 00                	push   $0x0
  pushl $102
801060bf:	6a 66                	push   $0x66
  jmp alltraps
801060c1:	e9 94 f7 ff ff       	jmp    8010585a <alltraps>

801060c6 <vector103>:
.globl vector103
vector103:
  pushl $0
801060c6:	6a 00                	push   $0x0
  pushl $103
801060c8:	6a 67                	push   $0x67
  jmp alltraps
801060ca:	e9 8b f7 ff ff       	jmp    8010585a <alltraps>

801060cf <vector104>:
.globl vector104
vector104:
  pushl $0
801060cf:	6a 00                	push   $0x0
  pushl $104
801060d1:	6a 68                	push   $0x68
  jmp alltraps
801060d3:	e9 82 f7 ff ff       	jmp    8010585a <alltraps>

801060d8 <vector105>:
.globl vector105
vector105:
  pushl $0
801060d8:	6a 00                	push   $0x0
  pushl $105
801060da:	6a 69                	push   $0x69
  jmp alltraps
801060dc:	e9 79 f7 ff ff       	jmp    8010585a <alltraps>

801060e1 <vector106>:
.globl vector106
vector106:
  pushl $0
801060e1:	6a 00                	push   $0x0
  pushl $106
801060e3:	6a 6a                	push   $0x6a
  jmp alltraps
801060e5:	e9 70 f7 ff ff       	jmp    8010585a <alltraps>

801060ea <vector107>:
.globl vector107
vector107:
  pushl $0
801060ea:	6a 00                	push   $0x0
  pushl $107
801060ec:	6a 6b                	push   $0x6b
  jmp alltraps
801060ee:	e9 67 f7 ff ff       	jmp    8010585a <alltraps>

801060f3 <vector108>:
.globl vector108
vector108:
  pushl $0
801060f3:	6a 00                	push   $0x0
  pushl $108
801060f5:	6a 6c                	push   $0x6c
  jmp alltraps
801060f7:	e9 5e f7 ff ff       	jmp    8010585a <alltraps>

801060fc <vector109>:
.globl vector109
vector109:
  pushl $0
801060fc:	6a 00                	push   $0x0
  pushl $109
801060fe:	6a 6d                	push   $0x6d
  jmp alltraps
80106100:	e9 55 f7 ff ff       	jmp    8010585a <alltraps>

80106105 <vector110>:
.globl vector110
vector110:
  pushl $0
80106105:	6a 00                	push   $0x0
  pushl $110
80106107:	6a 6e                	push   $0x6e
  jmp alltraps
80106109:	e9 4c f7 ff ff       	jmp    8010585a <alltraps>

8010610e <vector111>:
.globl vector111
vector111:
  pushl $0
8010610e:	6a 00                	push   $0x0
  pushl $111
80106110:	6a 6f                	push   $0x6f
  jmp alltraps
80106112:	e9 43 f7 ff ff       	jmp    8010585a <alltraps>

80106117 <vector112>:
.globl vector112
vector112:
  pushl $0
80106117:	6a 00                	push   $0x0
  pushl $112
80106119:	6a 70                	push   $0x70
  jmp alltraps
8010611b:	e9 3a f7 ff ff       	jmp    8010585a <alltraps>

80106120 <vector113>:
.globl vector113
vector113:
  pushl $0
80106120:	6a 00                	push   $0x0
  pushl $113
80106122:	6a 71                	push   $0x71
  jmp alltraps
80106124:	e9 31 f7 ff ff       	jmp    8010585a <alltraps>

80106129 <vector114>:
.globl vector114
vector114:
  pushl $0
80106129:	6a 00                	push   $0x0
  pushl $114
8010612b:	6a 72                	push   $0x72
  jmp alltraps
8010612d:	e9 28 f7 ff ff       	jmp    8010585a <alltraps>

80106132 <vector115>:
.globl vector115
vector115:
  pushl $0
80106132:	6a 00                	push   $0x0
  pushl $115
80106134:	6a 73                	push   $0x73
  jmp alltraps
80106136:	e9 1f f7 ff ff       	jmp    8010585a <alltraps>

8010613b <vector116>:
.globl vector116
vector116:
  pushl $0
8010613b:	6a 00                	push   $0x0
  pushl $116
8010613d:	6a 74                	push   $0x74
  jmp alltraps
8010613f:	e9 16 f7 ff ff       	jmp    8010585a <alltraps>

80106144 <vector117>:
.globl vector117
vector117:
  pushl $0
80106144:	6a 00                	push   $0x0
  pushl $117
80106146:	6a 75                	push   $0x75
  jmp alltraps
80106148:	e9 0d f7 ff ff       	jmp    8010585a <alltraps>

8010614d <vector118>:
.globl vector118
vector118:
  pushl $0
8010614d:	6a 00                	push   $0x0
  pushl $118
8010614f:	6a 76                	push   $0x76
  jmp alltraps
80106151:	e9 04 f7 ff ff       	jmp    8010585a <alltraps>

80106156 <vector119>:
.globl vector119
vector119:
  pushl $0
80106156:	6a 00                	push   $0x0
  pushl $119
80106158:	6a 77                	push   $0x77
  jmp alltraps
8010615a:	e9 fb f6 ff ff       	jmp    8010585a <alltraps>

8010615f <vector120>:
.globl vector120
vector120:
  pushl $0
8010615f:	6a 00                	push   $0x0
  pushl $120
80106161:	6a 78                	push   $0x78
  jmp alltraps
80106163:	e9 f2 f6 ff ff       	jmp    8010585a <alltraps>

80106168 <vector121>:
.globl vector121
vector121:
  pushl $0
80106168:	6a 00                	push   $0x0
  pushl $121
8010616a:	6a 79                	push   $0x79
  jmp alltraps
8010616c:	e9 e9 f6 ff ff       	jmp    8010585a <alltraps>

80106171 <vector122>:
.globl vector122
vector122:
  pushl $0
80106171:	6a 00                	push   $0x0
  pushl $122
80106173:	6a 7a                	push   $0x7a
  jmp alltraps
80106175:	e9 e0 f6 ff ff       	jmp    8010585a <alltraps>

8010617a <vector123>:
.globl vector123
vector123:
  pushl $0
8010617a:	6a 00                	push   $0x0
  pushl $123
8010617c:	6a 7b                	push   $0x7b
  jmp alltraps
8010617e:	e9 d7 f6 ff ff       	jmp    8010585a <alltraps>

80106183 <vector124>:
.globl vector124
vector124:
  pushl $0
80106183:	6a 00                	push   $0x0
  pushl $124
80106185:	6a 7c                	push   $0x7c
  jmp alltraps
80106187:	e9 ce f6 ff ff       	jmp    8010585a <alltraps>

8010618c <vector125>:
.globl vector125
vector125:
  pushl $0
8010618c:	6a 00                	push   $0x0
  pushl $125
8010618e:	6a 7d                	push   $0x7d
  jmp alltraps
80106190:	e9 c5 f6 ff ff       	jmp    8010585a <alltraps>

80106195 <vector126>:
.globl vector126
vector126:
  pushl $0
80106195:	6a 00                	push   $0x0
  pushl $126
80106197:	6a 7e                	push   $0x7e
  jmp alltraps
80106199:	e9 bc f6 ff ff       	jmp    8010585a <alltraps>

8010619e <vector127>:
.globl vector127
vector127:
  pushl $0
8010619e:	6a 00                	push   $0x0
  pushl $127
801061a0:	6a 7f                	push   $0x7f
  jmp alltraps
801061a2:	e9 b3 f6 ff ff       	jmp    8010585a <alltraps>

801061a7 <vector128>:
.globl vector128
vector128:
  pushl $0
801061a7:	6a 00                	push   $0x0
  pushl $128
801061a9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801061ae:	e9 a7 f6 ff ff       	jmp    8010585a <alltraps>

801061b3 <vector129>:
.globl vector129
vector129:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $129
801061b5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801061ba:	e9 9b f6 ff ff       	jmp    8010585a <alltraps>

801061bf <vector130>:
.globl vector130
vector130:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $130
801061c1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801061c6:	e9 8f f6 ff ff       	jmp    8010585a <alltraps>

801061cb <vector131>:
.globl vector131
vector131:
  pushl $0
801061cb:	6a 00                	push   $0x0
  pushl $131
801061cd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801061d2:	e9 83 f6 ff ff       	jmp    8010585a <alltraps>

801061d7 <vector132>:
.globl vector132
vector132:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $132
801061d9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801061de:	e9 77 f6 ff ff       	jmp    8010585a <alltraps>

801061e3 <vector133>:
.globl vector133
vector133:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $133
801061e5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801061ea:	e9 6b f6 ff ff       	jmp    8010585a <alltraps>

801061ef <vector134>:
.globl vector134
vector134:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $134
801061f1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801061f6:	e9 5f f6 ff ff       	jmp    8010585a <alltraps>

801061fb <vector135>:
.globl vector135
vector135:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $135
801061fd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106202:	e9 53 f6 ff ff       	jmp    8010585a <alltraps>

80106207 <vector136>:
.globl vector136
vector136:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $136
80106209:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010620e:	e9 47 f6 ff ff       	jmp    8010585a <alltraps>

80106213 <vector137>:
.globl vector137
vector137:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $137
80106215:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010621a:	e9 3b f6 ff ff       	jmp    8010585a <alltraps>

8010621f <vector138>:
.globl vector138
vector138:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $138
80106221:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106226:	e9 2f f6 ff ff       	jmp    8010585a <alltraps>

8010622b <vector139>:
.globl vector139
vector139:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $139
8010622d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106232:	e9 23 f6 ff ff       	jmp    8010585a <alltraps>

80106237 <vector140>:
.globl vector140
vector140:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $140
80106239:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010623e:	e9 17 f6 ff ff       	jmp    8010585a <alltraps>

80106243 <vector141>:
.globl vector141
vector141:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $141
80106245:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010624a:	e9 0b f6 ff ff       	jmp    8010585a <alltraps>

8010624f <vector142>:
.globl vector142
vector142:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $142
80106251:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106256:	e9 ff f5 ff ff       	jmp    8010585a <alltraps>

8010625b <vector143>:
.globl vector143
vector143:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $143
8010625d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106262:	e9 f3 f5 ff ff       	jmp    8010585a <alltraps>

80106267 <vector144>:
.globl vector144
vector144:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $144
80106269:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010626e:	e9 e7 f5 ff ff       	jmp    8010585a <alltraps>

80106273 <vector145>:
.globl vector145
vector145:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $145
80106275:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010627a:	e9 db f5 ff ff       	jmp    8010585a <alltraps>

8010627f <vector146>:
.globl vector146
vector146:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $146
80106281:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106286:	e9 cf f5 ff ff       	jmp    8010585a <alltraps>

8010628b <vector147>:
.globl vector147
vector147:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $147
8010628d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106292:	e9 c3 f5 ff ff       	jmp    8010585a <alltraps>

80106297 <vector148>:
.globl vector148
vector148:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $148
80106299:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010629e:	e9 b7 f5 ff ff       	jmp    8010585a <alltraps>

801062a3 <vector149>:
.globl vector149
vector149:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $149
801062a5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801062aa:	e9 ab f5 ff ff       	jmp    8010585a <alltraps>

801062af <vector150>:
.globl vector150
vector150:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $150
801062b1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801062b6:	e9 9f f5 ff ff       	jmp    8010585a <alltraps>

801062bb <vector151>:
.globl vector151
vector151:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $151
801062bd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801062c2:	e9 93 f5 ff ff       	jmp    8010585a <alltraps>

801062c7 <vector152>:
.globl vector152
vector152:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $152
801062c9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801062ce:	e9 87 f5 ff ff       	jmp    8010585a <alltraps>

801062d3 <vector153>:
.globl vector153
vector153:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $153
801062d5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801062da:	e9 7b f5 ff ff       	jmp    8010585a <alltraps>

801062df <vector154>:
.globl vector154
vector154:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $154
801062e1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801062e6:	e9 6f f5 ff ff       	jmp    8010585a <alltraps>

801062eb <vector155>:
.globl vector155
vector155:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $155
801062ed:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801062f2:	e9 63 f5 ff ff       	jmp    8010585a <alltraps>

801062f7 <vector156>:
.globl vector156
vector156:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $156
801062f9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801062fe:	e9 57 f5 ff ff       	jmp    8010585a <alltraps>

80106303 <vector157>:
.globl vector157
vector157:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $157
80106305:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010630a:	e9 4b f5 ff ff       	jmp    8010585a <alltraps>

8010630f <vector158>:
.globl vector158
vector158:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $158
80106311:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106316:	e9 3f f5 ff ff       	jmp    8010585a <alltraps>

8010631b <vector159>:
.globl vector159
vector159:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $159
8010631d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106322:	e9 33 f5 ff ff       	jmp    8010585a <alltraps>

80106327 <vector160>:
.globl vector160
vector160:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $160
80106329:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010632e:	e9 27 f5 ff ff       	jmp    8010585a <alltraps>

80106333 <vector161>:
.globl vector161
vector161:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $161
80106335:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010633a:	e9 1b f5 ff ff       	jmp    8010585a <alltraps>

8010633f <vector162>:
.globl vector162
vector162:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $162
80106341:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106346:	e9 0f f5 ff ff       	jmp    8010585a <alltraps>

8010634b <vector163>:
.globl vector163
vector163:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $163
8010634d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106352:	e9 03 f5 ff ff       	jmp    8010585a <alltraps>

80106357 <vector164>:
.globl vector164
vector164:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $164
80106359:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010635e:	e9 f7 f4 ff ff       	jmp    8010585a <alltraps>

80106363 <vector165>:
.globl vector165
vector165:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $165
80106365:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010636a:	e9 eb f4 ff ff       	jmp    8010585a <alltraps>

8010636f <vector166>:
.globl vector166
vector166:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $166
80106371:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106376:	e9 df f4 ff ff       	jmp    8010585a <alltraps>

8010637b <vector167>:
.globl vector167
vector167:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $167
8010637d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106382:	e9 d3 f4 ff ff       	jmp    8010585a <alltraps>

80106387 <vector168>:
.globl vector168
vector168:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $168
80106389:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010638e:	e9 c7 f4 ff ff       	jmp    8010585a <alltraps>

80106393 <vector169>:
.globl vector169
vector169:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $169
80106395:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010639a:	e9 bb f4 ff ff       	jmp    8010585a <alltraps>

8010639f <vector170>:
.globl vector170
vector170:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $170
801063a1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801063a6:	e9 af f4 ff ff       	jmp    8010585a <alltraps>

801063ab <vector171>:
.globl vector171
vector171:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $171
801063ad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801063b2:	e9 a3 f4 ff ff       	jmp    8010585a <alltraps>

801063b7 <vector172>:
.globl vector172
vector172:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $172
801063b9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801063be:	e9 97 f4 ff ff       	jmp    8010585a <alltraps>

801063c3 <vector173>:
.globl vector173
vector173:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $173
801063c5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801063ca:	e9 8b f4 ff ff       	jmp    8010585a <alltraps>

801063cf <vector174>:
.globl vector174
vector174:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $174
801063d1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801063d6:	e9 7f f4 ff ff       	jmp    8010585a <alltraps>

801063db <vector175>:
.globl vector175
vector175:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $175
801063dd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801063e2:	e9 73 f4 ff ff       	jmp    8010585a <alltraps>

801063e7 <vector176>:
.globl vector176
vector176:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $176
801063e9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801063ee:	e9 67 f4 ff ff       	jmp    8010585a <alltraps>

801063f3 <vector177>:
.globl vector177
vector177:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $177
801063f5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801063fa:	e9 5b f4 ff ff       	jmp    8010585a <alltraps>

801063ff <vector178>:
.globl vector178
vector178:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $178
80106401:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106406:	e9 4f f4 ff ff       	jmp    8010585a <alltraps>

8010640b <vector179>:
.globl vector179
vector179:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $179
8010640d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106412:	e9 43 f4 ff ff       	jmp    8010585a <alltraps>

80106417 <vector180>:
.globl vector180
vector180:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $180
80106419:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010641e:	e9 37 f4 ff ff       	jmp    8010585a <alltraps>

80106423 <vector181>:
.globl vector181
vector181:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $181
80106425:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010642a:	e9 2b f4 ff ff       	jmp    8010585a <alltraps>

8010642f <vector182>:
.globl vector182
vector182:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $182
80106431:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106436:	e9 1f f4 ff ff       	jmp    8010585a <alltraps>

8010643b <vector183>:
.globl vector183
vector183:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $183
8010643d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106442:	e9 13 f4 ff ff       	jmp    8010585a <alltraps>

80106447 <vector184>:
.globl vector184
vector184:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $184
80106449:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010644e:	e9 07 f4 ff ff       	jmp    8010585a <alltraps>

80106453 <vector185>:
.globl vector185
vector185:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $185
80106455:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010645a:	e9 fb f3 ff ff       	jmp    8010585a <alltraps>

8010645f <vector186>:
.globl vector186
vector186:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $186
80106461:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106466:	e9 ef f3 ff ff       	jmp    8010585a <alltraps>

8010646b <vector187>:
.globl vector187
vector187:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $187
8010646d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106472:	e9 e3 f3 ff ff       	jmp    8010585a <alltraps>

80106477 <vector188>:
.globl vector188
vector188:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $188
80106479:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010647e:	e9 d7 f3 ff ff       	jmp    8010585a <alltraps>

80106483 <vector189>:
.globl vector189
vector189:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $189
80106485:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010648a:	e9 cb f3 ff ff       	jmp    8010585a <alltraps>

8010648f <vector190>:
.globl vector190
vector190:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $190
80106491:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106496:	e9 bf f3 ff ff       	jmp    8010585a <alltraps>

8010649b <vector191>:
.globl vector191
vector191:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $191
8010649d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801064a2:	e9 b3 f3 ff ff       	jmp    8010585a <alltraps>

801064a7 <vector192>:
.globl vector192
vector192:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $192
801064a9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801064ae:	e9 a7 f3 ff ff       	jmp    8010585a <alltraps>

801064b3 <vector193>:
.globl vector193
vector193:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $193
801064b5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801064ba:	e9 9b f3 ff ff       	jmp    8010585a <alltraps>

801064bf <vector194>:
.globl vector194
vector194:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $194
801064c1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801064c6:	e9 8f f3 ff ff       	jmp    8010585a <alltraps>

801064cb <vector195>:
.globl vector195
vector195:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $195
801064cd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801064d2:	e9 83 f3 ff ff       	jmp    8010585a <alltraps>

801064d7 <vector196>:
.globl vector196
vector196:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $196
801064d9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801064de:	e9 77 f3 ff ff       	jmp    8010585a <alltraps>

801064e3 <vector197>:
.globl vector197
vector197:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $197
801064e5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801064ea:	e9 6b f3 ff ff       	jmp    8010585a <alltraps>

801064ef <vector198>:
.globl vector198
vector198:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $198
801064f1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801064f6:	e9 5f f3 ff ff       	jmp    8010585a <alltraps>

801064fb <vector199>:
.globl vector199
vector199:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $199
801064fd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106502:	e9 53 f3 ff ff       	jmp    8010585a <alltraps>

80106507 <vector200>:
.globl vector200
vector200:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $200
80106509:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010650e:	e9 47 f3 ff ff       	jmp    8010585a <alltraps>

80106513 <vector201>:
.globl vector201
vector201:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $201
80106515:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010651a:	e9 3b f3 ff ff       	jmp    8010585a <alltraps>

8010651f <vector202>:
.globl vector202
vector202:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $202
80106521:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106526:	e9 2f f3 ff ff       	jmp    8010585a <alltraps>

8010652b <vector203>:
.globl vector203
vector203:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $203
8010652d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106532:	e9 23 f3 ff ff       	jmp    8010585a <alltraps>

80106537 <vector204>:
.globl vector204
vector204:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $204
80106539:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010653e:	e9 17 f3 ff ff       	jmp    8010585a <alltraps>

80106543 <vector205>:
.globl vector205
vector205:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $205
80106545:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010654a:	e9 0b f3 ff ff       	jmp    8010585a <alltraps>

8010654f <vector206>:
.globl vector206
vector206:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $206
80106551:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106556:	e9 ff f2 ff ff       	jmp    8010585a <alltraps>

8010655b <vector207>:
.globl vector207
vector207:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $207
8010655d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106562:	e9 f3 f2 ff ff       	jmp    8010585a <alltraps>

80106567 <vector208>:
.globl vector208
vector208:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $208
80106569:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010656e:	e9 e7 f2 ff ff       	jmp    8010585a <alltraps>

80106573 <vector209>:
.globl vector209
vector209:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $209
80106575:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010657a:	e9 db f2 ff ff       	jmp    8010585a <alltraps>

8010657f <vector210>:
.globl vector210
vector210:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $210
80106581:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106586:	e9 cf f2 ff ff       	jmp    8010585a <alltraps>

8010658b <vector211>:
.globl vector211
vector211:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $211
8010658d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106592:	e9 c3 f2 ff ff       	jmp    8010585a <alltraps>

80106597 <vector212>:
.globl vector212
vector212:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $212
80106599:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010659e:	e9 b7 f2 ff ff       	jmp    8010585a <alltraps>

801065a3 <vector213>:
.globl vector213
vector213:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $213
801065a5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801065aa:	e9 ab f2 ff ff       	jmp    8010585a <alltraps>

801065af <vector214>:
.globl vector214
vector214:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $214
801065b1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801065b6:	e9 9f f2 ff ff       	jmp    8010585a <alltraps>

801065bb <vector215>:
.globl vector215
vector215:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $215
801065bd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801065c2:	e9 93 f2 ff ff       	jmp    8010585a <alltraps>

801065c7 <vector216>:
.globl vector216
vector216:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $216
801065c9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801065ce:	e9 87 f2 ff ff       	jmp    8010585a <alltraps>

801065d3 <vector217>:
.globl vector217
vector217:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $217
801065d5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801065da:	e9 7b f2 ff ff       	jmp    8010585a <alltraps>

801065df <vector218>:
.globl vector218
vector218:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $218
801065e1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801065e6:	e9 6f f2 ff ff       	jmp    8010585a <alltraps>

801065eb <vector219>:
.globl vector219
vector219:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $219
801065ed:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801065f2:	e9 63 f2 ff ff       	jmp    8010585a <alltraps>

801065f7 <vector220>:
.globl vector220
vector220:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $220
801065f9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801065fe:	e9 57 f2 ff ff       	jmp    8010585a <alltraps>

80106603 <vector221>:
.globl vector221
vector221:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $221
80106605:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010660a:	e9 4b f2 ff ff       	jmp    8010585a <alltraps>

8010660f <vector222>:
.globl vector222
vector222:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $222
80106611:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106616:	e9 3f f2 ff ff       	jmp    8010585a <alltraps>

8010661b <vector223>:
.globl vector223
vector223:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $223
8010661d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106622:	e9 33 f2 ff ff       	jmp    8010585a <alltraps>

80106627 <vector224>:
.globl vector224
vector224:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $224
80106629:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010662e:	e9 27 f2 ff ff       	jmp    8010585a <alltraps>

80106633 <vector225>:
.globl vector225
vector225:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $225
80106635:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010663a:	e9 1b f2 ff ff       	jmp    8010585a <alltraps>

8010663f <vector226>:
.globl vector226
vector226:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $226
80106641:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106646:	e9 0f f2 ff ff       	jmp    8010585a <alltraps>

8010664b <vector227>:
.globl vector227
vector227:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $227
8010664d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106652:	e9 03 f2 ff ff       	jmp    8010585a <alltraps>

80106657 <vector228>:
.globl vector228
vector228:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $228
80106659:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010665e:	e9 f7 f1 ff ff       	jmp    8010585a <alltraps>

80106663 <vector229>:
.globl vector229
vector229:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $229
80106665:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010666a:	e9 eb f1 ff ff       	jmp    8010585a <alltraps>

8010666f <vector230>:
.globl vector230
vector230:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $230
80106671:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106676:	e9 df f1 ff ff       	jmp    8010585a <alltraps>

8010667b <vector231>:
.globl vector231
vector231:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $231
8010667d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106682:	e9 d3 f1 ff ff       	jmp    8010585a <alltraps>

80106687 <vector232>:
.globl vector232
vector232:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $232
80106689:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010668e:	e9 c7 f1 ff ff       	jmp    8010585a <alltraps>

80106693 <vector233>:
.globl vector233
vector233:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $233
80106695:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010669a:	e9 bb f1 ff ff       	jmp    8010585a <alltraps>

8010669f <vector234>:
.globl vector234
vector234:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $234
801066a1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801066a6:	e9 af f1 ff ff       	jmp    8010585a <alltraps>

801066ab <vector235>:
.globl vector235
vector235:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $235
801066ad:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801066b2:	e9 a3 f1 ff ff       	jmp    8010585a <alltraps>

801066b7 <vector236>:
.globl vector236
vector236:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $236
801066b9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801066be:	e9 97 f1 ff ff       	jmp    8010585a <alltraps>

801066c3 <vector237>:
.globl vector237
vector237:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $237
801066c5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801066ca:	e9 8b f1 ff ff       	jmp    8010585a <alltraps>

801066cf <vector238>:
.globl vector238
vector238:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $238
801066d1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801066d6:	e9 7f f1 ff ff       	jmp    8010585a <alltraps>

801066db <vector239>:
.globl vector239
vector239:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $239
801066dd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801066e2:	e9 73 f1 ff ff       	jmp    8010585a <alltraps>

801066e7 <vector240>:
.globl vector240
vector240:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $240
801066e9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801066ee:	e9 67 f1 ff ff       	jmp    8010585a <alltraps>

801066f3 <vector241>:
.globl vector241
vector241:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $241
801066f5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801066fa:	e9 5b f1 ff ff       	jmp    8010585a <alltraps>

801066ff <vector242>:
.globl vector242
vector242:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $242
80106701:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106706:	e9 4f f1 ff ff       	jmp    8010585a <alltraps>

8010670b <vector243>:
.globl vector243
vector243:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $243
8010670d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106712:	e9 43 f1 ff ff       	jmp    8010585a <alltraps>

80106717 <vector244>:
.globl vector244
vector244:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $244
80106719:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010671e:	e9 37 f1 ff ff       	jmp    8010585a <alltraps>

80106723 <vector245>:
.globl vector245
vector245:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $245
80106725:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010672a:	e9 2b f1 ff ff       	jmp    8010585a <alltraps>

8010672f <vector246>:
.globl vector246
vector246:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $246
80106731:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106736:	e9 1f f1 ff ff       	jmp    8010585a <alltraps>

8010673b <vector247>:
.globl vector247
vector247:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $247
8010673d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106742:	e9 13 f1 ff ff       	jmp    8010585a <alltraps>

80106747 <vector248>:
.globl vector248
vector248:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $248
80106749:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010674e:	e9 07 f1 ff ff       	jmp    8010585a <alltraps>

80106753 <vector249>:
.globl vector249
vector249:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $249
80106755:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010675a:	e9 fb f0 ff ff       	jmp    8010585a <alltraps>

8010675f <vector250>:
.globl vector250
vector250:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $250
80106761:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106766:	e9 ef f0 ff ff       	jmp    8010585a <alltraps>

8010676b <vector251>:
.globl vector251
vector251:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $251
8010676d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106772:	e9 e3 f0 ff ff       	jmp    8010585a <alltraps>

80106777 <vector252>:
.globl vector252
vector252:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $252
80106779:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010677e:	e9 d7 f0 ff ff       	jmp    8010585a <alltraps>

80106783 <vector253>:
.globl vector253
vector253:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $253
80106785:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010678a:	e9 cb f0 ff ff       	jmp    8010585a <alltraps>

8010678f <vector254>:
.globl vector254
vector254:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $254
80106791:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106796:	e9 bf f0 ff ff       	jmp    8010585a <alltraps>

8010679b <vector255>:
.globl vector255
vector255:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $255
8010679d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801067a2:	e9 b3 f0 ff ff       	jmp    8010585a <alltraps>
801067a7:	66 90                	xchg   %ax,%ax
801067a9:	66 90                	xchg   %ax,%ax
801067ab:	66 90                	xchg   %ax,%ax
801067ad:	66 90                	xchg   %ax,%ax
801067af:	90                   	nop

801067b0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	57                   	push   %edi
801067b4:	56                   	push   %esi
801067b5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801067b6:	89 d3                	mov    %edx,%ebx
{
801067b8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
801067ba:	c1 eb 16             	shr    $0x16,%ebx
801067bd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801067c0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801067c3:	8b 06                	mov    (%esi),%eax
801067c5:	a8 01                	test   $0x1,%al
801067c7:	74 27                	je     801067f0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801067c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067ce:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801067d4:	c1 ef 0a             	shr    $0xa,%edi
}
801067d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801067da:	89 fa                	mov    %edi,%edx
801067dc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801067e2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801067e5:	5b                   	pop    %ebx
801067e6:	5e                   	pop    %esi
801067e7:	5f                   	pop    %edi
801067e8:	5d                   	pop    %ebp
801067e9:	c3                   	ret    
801067ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801067f0:	85 c9                	test   %ecx,%ecx
801067f2:	74 2c                	je     80106820 <walkpgdir+0x70>
801067f4:	e8 e7 bc ff ff       	call   801024e0 <kalloc>
801067f9:	85 c0                	test   %eax,%eax
801067fb:	89 c3                	mov    %eax,%ebx
801067fd:	74 21                	je     80106820 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801067ff:	83 ec 04             	sub    $0x4,%esp
80106802:	68 00 10 00 00       	push   $0x1000
80106807:	6a 00                	push   $0x0
80106809:	50                   	push   %eax
8010680a:	e8 61 de ff ff       	call   80104670 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010680f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106815:	83 c4 10             	add    $0x10,%esp
80106818:	83 c8 07             	or     $0x7,%eax
8010681b:	89 06                	mov    %eax,(%esi)
8010681d:	eb b5                	jmp    801067d4 <walkpgdir+0x24>
8010681f:	90                   	nop
}
80106820:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106823:	31 c0                	xor    %eax,%eax
}
80106825:	5b                   	pop    %ebx
80106826:	5e                   	pop    %esi
80106827:	5f                   	pop    %edi
80106828:	5d                   	pop    %ebp
80106829:	c3                   	ret    
8010682a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106830 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106830:	55                   	push   %ebp
80106831:	89 e5                	mov    %esp,%ebp
80106833:	57                   	push   %edi
80106834:	56                   	push   %esi
80106835:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106836:	89 d3                	mov    %edx,%ebx
80106838:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010683e:	83 ec 1c             	sub    $0x1c,%esp
80106841:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106844:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106848:	8b 7d 08             	mov    0x8(%ebp),%edi
8010684b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106850:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106853:	8b 45 0c             	mov    0xc(%ebp),%eax
80106856:	29 df                	sub    %ebx,%edi
80106858:	83 c8 01             	or     $0x1,%eax
8010685b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010685e:	eb 15                	jmp    80106875 <mappages+0x45>
    if(*pte & PTE_P)
80106860:	f6 00 01             	testb  $0x1,(%eax)
80106863:	75 45                	jne    801068aa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106865:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106868:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010686b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010686d:	74 31                	je     801068a0 <mappages+0x70>
      break;
    a += PGSIZE;
8010686f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106875:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106878:	b9 01 00 00 00       	mov    $0x1,%ecx
8010687d:	89 da                	mov    %ebx,%edx
8010687f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106882:	e8 29 ff ff ff       	call   801067b0 <walkpgdir>
80106887:	85 c0                	test   %eax,%eax
80106889:	75 d5                	jne    80106860 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010688b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010688e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106893:	5b                   	pop    %ebx
80106894:	5e                   	pop    %esi
80106895:	5f                   	pop    %edi
80106896:	5d                   	pop    %ebp
80106897:	c3                   	ret    
80106898:	90                   	nop
80106899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801068a3:	31 c0                	xor    %eax,%eax
}
801068a5:	5b                   	pop    %ebx
801068a6:	5e                   	pop    %esi
801068a7:	5f                   	pop    %edi
801068a8:	5d                   	pop    %ebp
801068a9:	c3                   	ret    
      panic("remap");
801068aa:	83 ec 0c             	sub    $0xc,%esp
801068ad:	68 a8 79 10 80       	push   $0x801079a8
801068b2:	e8 d9 9a ff ff       	call   80100390 <panic>
801068b7:	89 f6                	mov    %esi,%esi
801068b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	56                   	push   %esi
801068c5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801068c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068cc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
801068ce:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068d4:	83 ec 1c             	sub    $0x1c,%esp
801068d7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801068da:	39 d3                	cmp    %edx,%ebx
801068dc:	73 66                	jae    80106944 <deallocuvm.part.0+0x84>
801068de:	89 d6                	mov    %edx,%esi
801068e0:	eb 3d                	jmp    8010691f <deallocuvm.part.0+0x5f>
801068e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801068e8:	8b 10                	mov    (%eax),%edx
801068ea:	f6 c2 01             	test   $0x1,%dl
801068ed:	74 26                	je     80106915 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801068ef:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068f5:	74 58                	je     8010694f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801068f7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801068fa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106900:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106903:	52                   	push   %edx
80106904:	e8 27 ba ff ff       	call   80102330 <kfree>
      *pte = 0;
80106909:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010690c:	83 c4 10             	add    $0x10,%esp
8010690f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106915:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010691b:	39 f3                	cmp    %esi,%ebx
8010691d:	73 25                	jae    80106944 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010691f:	31 c9                	xor    %ecx,%ecx
80106921:	89 da                	mov    %ebx,%edx
80106923:	89 f8                	mov    %edi,%eax
80106925:	e8 86 fe ff ff       	call   801067b0 <walkpgdir>
    if(!pte)
8010692a:	85 c0                	test   %eax,%eax
8010692c:	75 ba                	jne    801068e8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010692e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106934:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010693a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106940:	39 f3                	cmp    %esi,%ebx
80106942:	72 db                	jb     8010691f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106944:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106947:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010694a:	5b                   	pop    %ebx
8010694b:	5e                   	pop    %esi
8010694c:	5f                   	pop    %edi
8010694d:	5d                   	pop    %ebp
8010694e:	c3                   	ret    
        panic("kfree");
8010694f:	83 ec 0c             	sub    $0xc,%esp
80106952:	68 46 73 10 80       	push   $0x80107346
80106957:	e8 34 9a ff ff       	call   80100390 <panic>
8010695c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106960 <seginit>:
{
80106960:	55                   	push   %ebp
80106961:	89 e5                	mov    %esp,%ebp
80106963:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106966:	e8 c5 ce ff ff       	call   80103830 <cpuid>
8010696b:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
80106971:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106976:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010697a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106981:	ff 00 00 
80106984:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
8010698b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010698e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106995:	ff 00 00 
80106998:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
8010699f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801069a2:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
801069a9:	ff 00 00 
801069ac:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
801069b3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801069b6:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
801069bd:	ff 00 00 
801069c0:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
801069c7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801069ca:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
801069cf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801069d3:	c1 e8 10             	shr    $0x10,%eax
801069d6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801069da:	8d 45 f2             	lea    -0xe(%ebp),%eax
801069dd:	0f 01 10             	lgdtl  (%eax)
}
801069e0:	c9                   	leave  
801069e1:	c3                   	ret    
801069e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069f0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069f0:	a1 c4 c3 11 80       	mov    0x8011c3c4,%eax
{
801069f5:	55                   	push   %ebp
801069f6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069f8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069fd:	0f 22 d8             	mov    %eax,%cr3
}
80106a00:	5d                   	pop    %ebp
80106a01:	c3                   	ret    
80106a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a10 <switchuvm>:
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	53                   	push   %ebx
80106a16:	83 ec 1c             	sub    $0x1c,%esp
80106a19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106a1c:	85 db                	test   %ebx,%ebx
80106a1e:	0f 84 cb 00 00 00    	je     80106aef <switchuvm+0xdf>
  if(p->kstack == 0)
80106a24:	8b 43 08             	mov    0x8(%ebx),%eax
80106a27:	85 c0                	test   %eax,%eax
80106a29:	0f 84 da 00 00 00    	je     80106b09 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106a2f:	8b 43 04             	mov    0x4(%ebx),%eax
80106a32:	85 c0                	test   %eax,%eax
80106a34:	0f 84 c2 00 00 00    	je     80106afc <switchuvm+0xec>
  pushcli();
80106a3a:	e8 51 da ff ff       	call   80104490 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a3f:	e8 6c cd ff ff       	call   801037b0 <mycpu>
80106a44:	89 c6                	mov    %eax,%esi
80106a46:	e8 65 cd ff ff       	call   801037b0 <mycpu>
80106a4b:	89 c7                	mov    %eax,%edi
80106a4d:	e8 5e cd ff ff       	call   801037b0 <mycpu>
80106a52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a55:	83 c7 08             	add    $0x8,%edi
80106a58:	e8 53 cd ff ff       	call   801037b0 <mycpu>
80106a5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a60:	83 c0 08             	add    $0x8,%eax
80106a63:	ba 67 00 00 00       	mov    $0x67,%edx
80106a68:	c1 e8 18             	shr    $0x18,%eax
80106a6b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106a72:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106a79:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a7f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a84:	83 c1 08             	add    $0x8,%ecx
80106a87:	c1 e9 10             	shr    $0x10,%ecx
80106a8a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a90:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a95:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a9c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106aa1:	e8 0a cd ff ff       	call   801037b0 <mycpu>
80106aa6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106aad:	e8 fe cc ff ff       	call   801037b0 <mycpu>
80106ab2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106ab6:	8b 73 08             	mov    0x8(%ebx),%esi
80106ab9:	e8 f2 cc ff ff       	call   801037b0 <mycpu>
80106abe:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106ac4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ac7:	e8 e4 cc ff ff       	call   801037b0 <mycpu>
80106acc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106ad0:	b8 28 00 00 00       	mov    $0x28,%eax
80106ad5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106ad8:	8b 43 04             	mov    0x4(%ebx),%eax
80106adb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ae0:	0f 22 d8             	mov    %eax,%cr3
}
80106ae3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ae6:	5b                   	pop    %ebx
80106ae7:	5e                   	pop    %esi
80106ae8:	5f                   	pop    %edi
80106ae9:	5d                   	pop    %ebp
  popcli();
80106aea:	e9 e1 d9 ff ff       	jmp    801044d0 <popcli>
    panic("switchuvm: no process");
80106aef:	83 ec 0c             	sub    $0xc,%esp
80106af2:	68 ae 79 10 80       	push   $0x801079ae
80106af7:	e8 94 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106afc:	83 ec 0c             	sub    $0xc,%esp
80106aff:	68 d9 79 10 80       	push   $0x801079d9
80106b04:	e8 87 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106b09:	83 ec 0c             	sub    $0xc,%esp
80106b0c:	68 c4 79 10 80       	push   $0x801079c4
80106b11:	e8 7a 98 ff ff       	call   80100390 <panic>
80106b16:	8d 76 00             	lea    0x0(%esi),%esi
80106b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b20 <inituvm>:
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	57                   	push   %edi
80106b24:	56                   	push   %esi
80106b25:	53                   	push   %ebx
80106b26:	83 ec 1c             	sub    $0x1c,%esp
80106b29:	8b 75 10             	mov    0x10(%ebp),%esi
80106b2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106b32:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106b38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106b3b:	77 49                	ja     80106b86 <inituvm+0x66>
  mem = kalloc();
80106b3d:	e8 9e b9 ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
80106b42:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106b45:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b47:	68 00 10 00 00       	push   $0x1000
80106b4c:	6a 00                	push   $0x0
80106b4e:	50                   	push   %eax
80106b4f:	e8 1c db ff ff       	call   80104670 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b54:	58                   	pop    %eax
80106b55:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b5b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b60:	5a                   	pop    %edx
80106b61:	6a 06                	push   $0x6
80106b63:	50                   	push   %eax
80106b64:	31 d2                	xor    %edx,%edx
80106b66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b69:	e8 c2 fc ff ff       	call   80106830 <mappages>
  memmove(mem, init, sz);
80106b6e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b71:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b74:	83 c4 10             	add    $0x10,%esp
80106b77:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b7d:	5b                   	pop    %ebx
80106b7e:	5e                   	pop    %esi
80106b7f:	5f                   	pop    %edi
80106b80:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106b81:	e9 9a db ff ff       	jmp    80104720 <memmove>
    panic("inituvm: more than a page");
80106b86:	83 ec 0c             	sub    $0xc,%esp
80106b89:	68 ed 79 10 80       	push   $0x801079ed
80106b8e:	e8 fd 97 ff ff       	call   80100390 <panic>
80106b93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ba0 <loaduvm>:
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	57                   	push   %edi
80106ba4:	56                   	push   %esi
80106ba5:	53                   	push   %ebx
80106ba6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106ba9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106bb0:	0f 85 91 00 00 00    	jne    80106c47 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106bb6:	8b 75 18             	mov    0x18(%ebp),%esi
80106bb9:	31 db                	xor    %ebx,%ebx
80106bbb:	85 f6                	test   %esi,%esi
80106bbd:	75 1a                	jne    80106bd9 <loaduvm+0x39>
80106bbf:	eb 6f                	jmp    80106c30 <loaduvm+0x90>
80106bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bc8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106bd4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106bd7:	76 57                	jbe    80106c30 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106bd9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bdc:	8b 45 08             	mov    0x8(%ebp),%eax
80106bdf:	31 c9                	xor    %ecx,%ecx
80106be1:	01 da                	add    %ebx,%edx
80106be3:	e8 c8 fb ff ff       	call   801067b0 <walkpgdir>
80106be8:	85 c0                	test   %eax,%eax
80106bea:	74 4e                	je     80106c3a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106bec:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bee:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106bf1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106bf6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106bfb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106c01:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c04:	01 d9                	add    %ebx,%ecx
80106c06:	05 00 00 00 80       	add    $0x80000000,%eax
80106c0b:	57                   	push   %edi
80106c0c:	51                   	push   %ecx
80106c0d:	50                   	push   %eax
80106c0e:	ff 75 10             	pushl  0x10(%ebp)
80106c11:	e8 6a ad ff ff       	call   80101980 <readi>
80106c16:	83 c4 10             	add    $0x10,%esp
80106c19:	39 f8                	cmp    %edi,%eax
80106c1b:	74 ab                	je     80106bc8 <loaduvm+0x28>
}
80106c1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c25:	5b                   	pop    %ebx
80106c26:	5e                   	pop    %esi
80106c27:	5f                   	pop    %edi
80106c28:	5d                   	pop    %ebp
80106c29:	c3                   	ret    
80106c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106c33:	31 c0                	xor    %eax,%eax
}
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
      panic("loaduvm: address should exist");
80106c3a:	83 ec 0c             	sub    $0xc,%esp
80106c3d:	68 07 7a 10 80       	push   $0x80107a07
80106c42:	e8 49 97 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106c47:	83 ec 0c             	sub    $0xc,%esp
80106c4a:	68 a8 7a 10 80       	push   $0x80107aa8
80106c4f:	e8 3c 97 ff ff       	call   80100390 <panic>
80106c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c60 <allocuvm>:
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106c69:	8b 7d 10             	mov    0x10(%ebp),%edi
80106c6c:	85 ff                	test   %edi,%edi
80106c6e:	0f 88 8e 00 00 00    	js     80106d02 <allocuvm+0xa2>
  if(newsz < oldsz)
80106c74:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c77:	0f 82 93 00 00 00    	jb     80106d10 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c80:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c86:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c8c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c8f:	0f 86 7e 00 00 00    	jbe    80106d13 <allocuvm+0xb3>
80106c95:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c98:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c9b:	eb 42                	jmp    80106cdf <allocuvm+0x7f>
80106c9d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106ca0:	83 ec 04             	sub    $0x4,%esp
80106ca3:	68 00 10 00 00       	push   $0x1000
80106ca8:	6a 00                	push   $0x0
80106caa:	50                   	push   %eax
80106cab:	e8 c0 d9 ff ff       	call   80104670 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106cb0:	58                   	pop    %eax
80106cb1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106cb7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106cbc:	5a                   	pop    %edx
80106cbd:	6a 06                	push   $0x6
80106cbf:	50                   	push   %eax
80106cc0:	89 da                	mov    %ebx,%edx
80106cc2:	89 f8                	mov    %edi,%eax
80106cc4:	e8 67 fb ff ff       	call   80106830 <mappages>
80106cc9:	83 c4 10             	add    $0x10,%esp
80106ccc:	85 c0                	test   %eax,%eax
80106cce:	78 50                	js     80106d20 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106cd0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cd6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106cd9:	0f 86 81 00 00 00    	jbe    80106d60 <allocuvm+0x100>
    mem = kalloc();
80106cdf:	e8 fc b7 ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
80106ce4:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106ce6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106ce8:	75 b6                	jne    80106ca0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106cea:	83 ec 0c             	sub    $0xc,%esp
80106ced:	68 25 7a 10 80       	push   $0x80107a25
80106cf2:	e8 69 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106cf7:	83 c4 10             	add    $0x10,%esp
80106cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cfd:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d00:	77 6e                	ja     80106d70 <allocuvm+0x110>
}
80106d02:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106d05:	31 ff                	xor    %edi,%edi
}
80106d07:	89 f8                	mov    %edi,%eax
80106d09:	5b                   	pop    %ebx
80106d0a:	5e                   	pop    %esi
80106d0b:	5f                   	pop    %edi
80106d0c:	5d                   	pop    %ebp
80106d0d:	c3                   	ret    
80106d0e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106d10:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d16:	89 f8                	mov    %edi,%eax
80106d18:	5b                   	pop    %ebx
80106d19:	5e                   	pop    %esi
80106d1a:	5f                   	pop    %edi
80106d1b:	5d                   	pop    %ebp
80106d1c:	c3                   	ret    
80106d1d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106d20:	83 ec 0c             	sub    $0xc,%esp
80106d23:	68 3d 7a 10 80       	push   $0x80107a3d
80106d28:	e8 33 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106d2d:	83 c4 10             	add    $0x10,%esp
80106d30:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d33:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d36:	76 0d                	jbe    80106d45 <allocuvm+0xe5>
80106d38:	89 c1                	mov    %eax,%ecx
80106d3a:	8b 55 10             	mov    0x10(%ebp),%edx
80106d3d:	8b 45 08             	mov    0x8(%ebp),%eax
80106d40:	e8 7b fb ff ff       	call   801068c0 <deallocuvm.part.0>
      kfree(mem);
80106d45:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106d48:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106d4a:	56                   	push   %esi
80106d4b:	e8 e0 b5 ff ff       	call   80102330 <kfree>
      return 0;
80106d50:	83 c4 10             	add    $0x10,%esp
}
80106d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d56:	89 f8                	mov    %edi,%eax
80106d58:	5b                   	pop    %ebx
80106d59:	5e                   	pop    %esi
80106d5a:	5f                   	pop    %edi
80106d5b:	5d                   	pop    %ebp
80106d5c:	c3                   	ret    
80106d5d:	8d 76 00             	lea    0x0(%esi),%esi
80106d60:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106d63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d66:	5b                   	pop    %ebx
80106d67:	89 f8                	mov    %edi,%eax
80106d69:	5e                   	pop    %esi
80106d6a:	5f                   	pop    %edi
80106d6b:	5d                   	pop    %ebp
80106d6c:	c3                   	ret    
80106d6d:	8d 76 00             	lea    0x0(%esi),%esi
80106d70:	89 c1                	mov    %eax,%ecx
80106d72:	8b 55 10             	mov    0x10(%ebp),%edx
80106d75:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d78:	31 ff                	xor    %edi,%edi
80106d7a:	e8 41 fb ff ff       	call   801068c0 <deallocuvm.part.0>
80106d7f:	eb 92                	jmp    80106d13 <allocuvm+0xb3>
80106d81:	eb 0d                	jmp    80106d90 <deallocuvm>
80106d83:	90                   	nop
80106d84:	90                   	nop
80106d85:	90                   	nop
80106d86:	90                   	nop
80106d87:	90                   	nop
80106d88:	90                   	nop
80106d89:	90                   	nop
80106d8a:	90                   	nop
80106d8b:	90                   	nop
80106d8c:	90                   	nop
80106d8d:	90                   	nop
80106d8e:	90                   	nop
80106d8f:	90                   	nop

80106d90 <deallocuvm>:
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d96:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d99:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d9c:	39 d1                	cmp    %edx,%ecx
80106d9e:	73 10                	jae    80106db0 <deallocuvm+0x20>
}
80106da0:	5d                   	pop    %ebp
80106da1:	e9 1a fb ff ff       	jmp    801068c0 <deallocuvm.part.0>
80106da6:	8d 76 00             	lea    0x0(%esi),%esi
80106da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106db0:	89 d0                	mov    %edx,%eax
80106db2:	5d                   	pop    %ebp
80106db3:	c3                   	ret    
80106db4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106dc0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	57                   	push   %edi
80106dc4:	56                   	push   %esi
80106dc5:	53                   	push   %ebx
80106dc6:	83 ec 0c             	sub    $0xc,%esp
80106dc9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106dcc:	85 f6                	test   %esi,%esi
80106dce:	74 59                	je     80106e29 <freevm+0x69>
80106dd0:	31 c9                	xor    %ecx,%ecx
80106dd2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106dd7:	89 f0                	mov    %esi,%eax
80106dd9:	e8 e2 fa ff ff       	call   801068c0 <deallocuvm.part.0>
80106dde:	89 f3                	mov    %esi,%ebx
80106de0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106de6:	eb 0f                	jmp    80106df7 <freevm+0x37>
80106de8:	90                   	nop
80106de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106df0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106df3:	39 fb                	cmp    %edi,%ebx
80106df5:	74 23                	je     80106e1a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106df7:	8b 03                	mov    (%ebx),%eax
80106df9:	a8 01                	test   $0x1,%al
80106dfb:	74 f3                	je     80106df0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106dfd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106e02:	83 ec 0c             	sub    $0xc,%esp
80106e05:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e08:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106e0d:	50                   	push   %eax
80106e0e:	e8 1d b5 ff ff       	call   80102330 <kfree>
80106e13:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106e16:	39 fb                	cmp    %edi,%ebx
80106e18:	75 dd                	jne    80106df7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106e1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106e1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e20:	5b                   	pop    %ebx
80106e21:	5e                   	pop    %esi
80106e22:	5f                   	pop    %edi
80106e23:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106e24:	e9 07 b5 ff ff       	jmp    80102330 <kfree>
    panic("freevm: no pgdir");
80106e29:	83 ec 0c             	sub    $0xc,%esp
80106e2c:	68 59 7a 10 80       	push   $0x80107a59
80106e31:	e8 5a 95 ff ff       	call   80100390 <panic>
80106e36:	8d 76 00             	lea    0x0(%esi),%esi
80106e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e40 <setupkvm>:
{
80106e40:	55                   	push   %ebp
80106e41:	89 e5                	mov    %esp,%ebp
80106e43:	56                   	push   %esi
80106e44:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106e45:	e8 96 b6 ff ff       	call   801024e0 <kalloc>
80106e4a:	85 c0                	test   %eax,%eax
80106e4c:	89 c6                	mov    %eax,%esi
80106e4e:	74 42                	je     80106e92 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106e50:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e53:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106e58:	68 00 10 00 00       	push   $0x1000
80106e5d:	6a 00                	push   $0x0
80106e5f:	50                   	push   %eax
80106e60:	e8 0b d8 ff ff       	call   80104670 <memset>
80106e65:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106e68:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e6b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e6e:	83 ec 08             	sub    $0x8,%esp
80106e71:	8b 13                	mov    (%ebx),%edx
80106e73:	ff 73 0c             	pushl  0xc(%ebx)
80106e76:	50                   	push   %eax
80106e77:	29 c1                	sub    %eax,%ecx
80106e79:	89 f0                	mov    %esi,%eax
80106e7b:	e8 b0 f9 ff ff       	call   80106830 <mappages>
80106e80:	83 c4 10             	add    $0x10,%esp
80106e83:	85 c0                	test   %eax,%eax
80106e85:	78 19                	js     80106ea0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e87:	83 c3 10             	add    $0x10,%ebx
80106e8a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e90:	75 d6                	jne    80106e68 <setupkvm+0x28>
}
80106e92:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e95:	89 f0                	mov    %esi,%eax
80106e97:	5b                   	pop    %ebx
80106e98:	5e                   	pop    %esi
80106e99:	5d                   	pop    %ebp
80106e9a:	c3                   	ret    
80106e9b:	90                   	nop
80106e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106ea0:	83 ec 0c             	sub    $0xc,%esp
80106ea3:	56                   	push   %esi
      return 0;
80106ea4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106ea6:	e8 15 ff ff ff       	call   80106dc0 <freevm>
      return 0;
80106eab:	83 c4 10             	add    $0x10,%esp
}
80106eae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106eb1:	89 f0                	mov    %esi,%eax
80106eb3:	5b                   	pop    %ebx
80106eb4:	5e                   	pop    %esi
80106eb5:	5d                   	pop    %ebp
80106eb6:	c3                   	ret    
80106eb7:	89 f6                	mov    %esi,%esi
80106eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ec0 <kvmalloc>:
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106ec6:	e8 75 ff ff ff       	call   80106e40 <setupkvm>
80106ecb:	a3 c4 c3 11 80       	mov    %eax,0x8011c3c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ed0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ed5:	0f 22 d8             	mov    %eax,%cr3
}
80106ed8:	c9                   	leave  
80106ed9:	c3                   	ret    
80106eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ee0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106ee0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ee1:	31 c9                	xor    %ecx,%ecx
{
80106ee3:	89 e5                	mov    %esp,%ebp
80106ee5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106ee8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106eeb:	8b 45 08             	mov    0x8(%ebp),%eax
80106eee:	e8 bd f8 ff ff       	call   801067b0 <walkpgdir>
  if(pte == 0)
80106ef3:	85 c0                	test   %eax,%eax
80106ef5:	74 05                	je     80106efc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ef7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106efa:	c9                   	leave  
80106efb:	c3                   	ret    
    panic("clearpteu");
80106efc:	83 ec 0c             	sub    $0xc,%esp
80106eff:	68 6a 7a 10 80       	push   $0x80107a6a
80106f04:	e8 87 94 ff ff       	call   80100390 <panic>
80106f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f10 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	57                   	push   %edi
80106f14:	56                   	push   %esi
80106f15:	53                   	push   %ebx
80106f16:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106f19:	e8 22 ff ff ff       	call   80106e40 <setupkvm>
80106f1e:	85 c0                	test   %eax,%eax
80106f20:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f23:	0f 84 9f 00 00 00    	je     80106fc8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f29:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f2c:	85 c9                	test   %ecx,%ecx
80106f2e:	0f 84 94 00 00 00    	je     80106fc8 <copyuvm+0xb8>
80106f34:	31 ff                	xor    %edi,%edi
80106f36:	eb 4a                	jmp    80106f82 <copyuvm+0x72>
80106f38:	90                   	nop
80106f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106f40:	83 ec 04             	sub    $0x4,%esp
80106f43:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106f49:	68 00 10 00 00       	push   $0x1000
80106f4e:	53                   	push   %ebx
80106f4f:	50                   	push   %eax
80106f50:	e8 cb d7 ff ff       	call   80104720 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106f55:	58                   	pop    %eax
80106f56:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f5c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f61:	5a                   	pop    %edx
80106f62:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f65:	50                   	push   %eax
80106f66:	89 fa                	mov    %edi,%edx
80106f68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f6b:	e8 c0 f8 ff ff       	call   80106830 <mappages>
80106f70:	83 c4 10             	add    $0x10,%esp
80106f73:	85 c0                	test   %eax,%eax
80106f75:	78 61                	js     80106fd8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f77:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f7d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106f80:	76 46                	jbe    80106fc8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f82:	8b 45 08             	mov    0x8(%ebp),%eax
80106f85:	31 c9                	xor    %ecx,%ecx
80106f87:	89 fa                	mov    %edi,%edx
80106f89:	e8 22 f8 ff ff       	call   801067b0 <walkpgdir>
80106f8e:	85 c0                	test   %eax,%eax
80106f90:	74 61                	je     80106ff3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f92:	8b 00                	mov    (%eax),%eax
80106f94:	a8 01                	test   $0x1,%al
80106f96:	74 4e                	je     80106fe6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f98:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f9a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f9f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106fa5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106fa8:	e8 33 b5 ff ff       	call   801024e0 <kalloc>
80106fad:	85 c0                	test   %eax,%eax
80106faf:	89 c6                	mov    %eax,%esi
80106fb1:	75 8d                	jne    80106f40 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106fb3:	83 ec 0c             	sub    $0xc,%esp
80106fb6:	ff 75 e0             	pushl  -0x20(%ebp)
80106fb9:	e8 02 fe ff ff       	call   80106dc0 <freevm>
  return 0;
80106fbe:	83 c4 10             	add    $0x10,%esp
80106fc1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106fc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fce:	5b                   	pop    %ebx
80106fcf:	5e                   	pop    %esi
80106fd0:	5f                   	pop    %edi
80106fd1:	5d                   	pop    %ebp
80106fd2:	c3                   	ret    
80106fd3:	90                   	nop
80106fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106fd8:	83 ec 0c             	sub    $0xc,%esp
80106fdb:	56                   	push   %esi
80106fdc:	e8 4f b3 ff ff       	call   80102330 <kfree>
      goto bad;
80106fe1:	83 c4 10             	add    $0x10,%esp
80106fe4:	eb cd                	jmp    80106fb3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106fe6:	83 ec 0c             	sub    $0xc,%esp
80106fe9:	68 8e 7a 10 80       	push   $0x80107a8e
80106fee:	e8 9d 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80106ff3:	83 ec 0c             	sub    $0xc,%esp
80106ff6:	68 74 7a 10 80       	push   $0x80107a74
80106ffb:	e8 90 93 ff ff       	call   80100390 <panic>

80107000 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107000:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107001:	31 c9                	xor    %ecx,%ecx
{
80107003:	89 e5                	mov    %esp,%ebp
80107005:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107008:	8b 55 0c             	mov    0xc(%ebp),%edx
8010700b:	8b 45 08             	mov    0x8(%ebp),%eax
8010700e:	e8 9d f7 ff ff       	call   801067b0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107013:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107015:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107016:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107018:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010701d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107020:	05 00 00 00 80       	add    $0x80000000,%eax
80107025:	83 fa 05             	cmp    $0x5,%edx
80107028:	ba 00 00 00 00       	mov    $0x0,%edx
8010702d:	0f 45 c2             	cmovne %edx,%eax
}
80107030:	c3                   	ret    
80107031:	eb 0d                	jmp    80107040 <copyout>
80107033:	90                   	nop
80107034:	90                   	nop
80107035:	90                   	nop
80107036:	90                   	nop
80107037:	90                   	nop
80107038:	90                   	nop
80107039:	90                   	nop
8010703a:	90                   	nop
8010703b:	90                   	nop
8010703c:	90                   	nop
8010703d:	90                   	nop
8010703e:	90                   	nop
8010703f:	90                   	nop

80107040 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	57                   	push   %edi
80107044:	56                   	push   %esi
80107045:	53                   	push   %ebx
80107046:	83 ec 1c             	sub    $0x1c,%esp
80107049:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010704c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010704f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107052:	85 db                	test   %ebx,%ebx
80107054:	75 40                	jne    80107096 <copyout+0x56>
80107056:	eb 70                	jmp    801070c8 <copyout+0x88>
80107058:	90                   	nop
80107059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107060:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107063:	89 f1                	mov    %esi,%ecx
80107065:	29 d1                	sub    %edx,%ecx
80107067:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010706d:	39 d9                	cmp    %ebx,%ecx
8010706f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107072:	29 f2                	sub    %esi,%edx
80107074:	83 ec 04             	sub    $0x4,%esp
80107077:	01 d0                	add    %edx,%eax
80107079:	51                   	push   %ecx
8010707a:	57                   	push   %edi
8010707b:	50                   	push   %eax
8010707c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010707f:	e8 9c d6 ff ff       	call   80104720 <memmove>
    len -= n;
    buf += n;
80107084:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107087:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010708a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107090:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107092:	29 cb                	sub    %ecx,%ebx
80107094:	74 32                	je     801070c8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107096:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107098:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010709b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010709e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801070a4:	56                   	push   %esi
801070a5:	ff 75 08             	pushl  0x8(%ebp)
801070a8:	e8 53 ff ff ff       	call   80107000 <uva2ka>
    if(pa0 == 0)
801070ad:	83 c4 10             	add    $0x10,%esp
801070b0:	85 c0                	test   %eax,%eax
801070b2:	75 ac                	jne    80107060 <copyout+0x20>
  }
  return 0;
}
801070b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070bc:	5b                   	pop    %ebx
801070bd:	5e                   	pop    %esi
801070be:	5f                   	pop    %edi
801070bf:	5d                   	pop    %ebp
801070c0:	c3                   	ret    
801070c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070cb:	31 c0                	xor    %eax,%eax
}
801070cd:	5b                   	pop    %ebx
801070ce:	5e                   	pop    %esi
801070cf:	5f                   	pop    %edi
801070d0:	5d                   	pop    %ebp
801070d1:	c3                   	ret    
