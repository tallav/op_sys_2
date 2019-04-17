
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
8010004c:	68 e0 73 10 80       	push   $0x801073e0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 15 46 00 00       	call   80104670 <initlock>
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
80100092:	68 e7 73 10 80       	push   $0x801073e7
80100097:	50                   	push   %eax
80100098:	e8 a3 44 00 00       	call   80104540 <initsleeplock>
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
801000e4:	e8 c7 46 00 00       	call   801047b0 <acquire>
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
80100162:	e8 09 47 00 00       	call   80104870 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 0e 44 00 00       	call   80104580 <acquiresleep>
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
80100193:	68 ee 73 10 80       	push   $0x801073ee
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
801001ae:	e8 6d 44 00 00       	call   80104620 <holdingsleep>
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
801001cc:	68 ff 73 10 80       	push   $0x801073ff
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
801001ef:	e8 2c 44 00 00       	call   80104620 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 dc 43 00 00       	call   801045e0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 a0 45 00 00       	call   801047b0 <acquire>
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
8010025c:	e9 0f 46 00 00       	jmp    80104870 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 74 10 80       	push   $0x80107406
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
8010028c:	e8 1f 45 00 00       	call   801047b0 <acquire>
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
801002c5:	e8 76 3c 00 00       	call   80103f40 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 d0 35 00 00       	call   801038b0 <myproc>
801002e0:	8b 40 18             	mov    0x18(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 7c 45 00 00       	call   80104870 <release>
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
8010034d:	e8 1e 45 00 00       	call   80104870 <release>
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
801003b2:	68 0d 74 10 80       	push   $0x8010740d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 a7 7d 10 80 	movl   $0x80107da7,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 b3 42 00 00       	call   80104690 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 21 74 10 80       	push   $0x80107421
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
8010043a:	e8 b1 5b 00 00       	call   80105ff0 <uartputc>
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
801004ec:	e8 ff 5a 00 00       	call   80105ff0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 f3 5a 00 00       	call   80105ff0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 e7 5a 00 00       	call   80105ff0 <uartputc>
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
80100524:	e8 47 44 00 00       	call   80104970 <memmove>
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
80100541:	e8 7a 43 00 00       	call   801048c0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 25 74 10 80       	push   $0x80107425
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
801005b1:	0f b6 92 50 74 10 80 	movzbl -0x7fef8bb0(%edx),%edx
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
8010061b:	e8 90 41 00 00       	call   801047b0 <acquire>
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
80100647:	e8 24 42 00 00       	call   80104870 <release>
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
8010071f:	e8 4c 41 00 00       	call   80104870 <release>
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
801007d0:	ba 38 74 10 80       	mov    $0x80107438,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 bb 3f 00 00       	call   801047b0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 3f 74 10 80       	push   $0x8010743f
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
80100823:	e8 88 3f 00 00       	call   801047b0 <acquire>
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
80100888:	e8 e3 3f 00 00       	call   80104870 <release>
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
80100916:	e8 65 38 00 00       	call   80104180 <wakeup>
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
80100997:	e9 84 38 00 00       	jmp    80104220 <procdump>
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
801009c6:	68 48 74 10 80       	push   $0x80107448
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 9b 3c 00 00       	call   80104670 <initlock>

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
80100a1c:	e8 8f 2e 00 00       	call   801038b0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  struct kthread *curthread = mythread();
80100a27:	e8 b4 2e 00 00       	call   801038e0 <mythread>
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
80100a9c:	e8 9f 66 00 00       	call   80107140 <setupkvm>
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
80100afe:	e8 5d 64 00 00       	call   80106f60 <allocuvm>
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
80100b30:	e8 6b 63 00 00       	call   80106ea0 <loaduvm>
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
80100b7a:	e8 41 65 00 00       	call   801070c0 <freevm>
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
80100bb2:	e8 a9 63 00 00       	call   80106f60 <allocuvm>
80100bb7:	83 c4 10             	add    $0x10,%esp
80100bba:	85 c0                	test   %eax,%eax
80100bbc:	89 c6                	mov    %eax,%esi
80100bbe:	75 3a                	jne    80100bfa <exec+0x1ea>
    freevm(pgdir);
80100bc0:	83 ec 0c             	sub    $0xc,%esp
80100bc3:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100bc9:	e8 f2 64 00 00       	call   801070c0 <freevm>
80100bce:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd6:	e9 ac fe ff ff       	jmp    80100a87 <exec+0x77>
    end_op();
80100bdb:	e8 50 20 00 00       	call   80102c30 <end_op>
    cprintf("exec: fail\n");
80100be0:	83 ec 0c             	sub    $0xc,%esp
80100be3:	68 61 74 10 80       	push   $0x80107461
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
80100c0e:	e8 cd 65 00 00       	call   801071e0 <clearpteu>
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
80100c41:	e8 9a 3e 00 00       	call   80104ae0 <strlen>
80100c46:	f7 d0                	not    %eax
80100c48:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4d:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c4e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c51:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c54:	e8 87 3e 00 00       	call   80104ae0 <strlen>
80100c59:	83 c0 01             	add    $0x1,%eax
80100c5c:	50                   	push   %eax
80100c5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c60:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c63:	53                   	push   %ebx
80100c64:	56                   	push   %esi
80100c65:	e8 d6 66 00 00       	call   80107340 <copyout>
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
80100ccf:	e8 6c 66 00 00       	call   80107340 <copyout>
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
80100d0c:	8d 47 5c             	lea    0x5c(%edi),%eax
80100d0f:	50                   	push   %eax
80100d10:	e8 8b 3d 00 00       	call   80104aa0 <safestrcpy>
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
80100d31:	8b 46 14             	mov    0x14(%esi),%eax
80100d34:	89 50 38             	mov    %edx,0x38(%eax)
  curthread->tf->esp = sp;
80100d37:	8b 46 14             	mov    0x14(%esi),%eax
80100d3a:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d3d:	89 0c 24             	mov    %ecx,(%esp)
80100d40:	e8 cb 5f 00 00       	call   80106d10 <switchuvm>
  freevm(oldpgdir);
80100d45:	89 3c 24             	mov    %edi,(%esp)
80100d48:	e8 73 63 00 00       	call   801070c0 <freevm>
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
80100d76:	68 6d 74 10 80       	push   $0x8010746d
80100d7b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d80:	e8 eb 38 00 00       	call   80104670 <initlock>
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
80100da1:	e8 0a 3a 00 00       	call   801047b0 <acquire>
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
80100dd1:	e8 9a 3a 00 00       	call   80104870 <release>
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
80100dea:	e8 81 3a 00 00       	call   80104870 <release>
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
80100e0f:	e8 9c 39 00 00       	call   801047b0 <acquire>
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
80100e2c:	e8 3f 3a 00 00       	call   80104870 <release>
  return f;
}
80100e31:	89 d8                	mov    %ebx,%eax
80100e33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e36:	c9                   	leave  
80100e37:	c3                   	ret    
    panic("filedup");
80100e38:	83 ec 0c             	sub    $0xc,%esp
80100e3b:	68 74 74 10 80       	push   $0x80107474
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
80100e61:	e8 4a 39 00 00       	call   801047b0 <acquire>
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
80100e8c:	e9 df 39 00 00       	jmp    80104870 <release>
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
80100eb8:	e8 b3 39 00 00       	call   80104870 <release>
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
80100f12:	68 7c 74 10 80       	push   $0x8010747c
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
80100ff2:	68 86 74 10 80       	push   $0x80107486
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
80101105:	68 8f 74 10 80       	push   $0x8010748f
8010110a:	e8 81 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	68 95 74 10 80       	push   $0x80107495
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
801011c4:	68 9f 74 10 80       	push   $0x8010749f
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
80101205:	e8 b6 36 00 00       	call   801048c0 <memset>
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
8010124a:	e8 61 35 00 00       	call   801047b0 <acquire>
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
801012af:	e8 bc 35 00 00       	call   80104870 <release>

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
801012dd:	e8 8e 35 00 00       	call   80104870 <release>
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
801012f2:	68 b5 74 10 80       	push   $0x801074b5
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
801013c7:	68 c5 74 10 80       	push   $0x801074c5
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
80101401:	e8 6a 35 00 00       	call   80104970 <memmove>
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
80101494:	68 d8 74 10 80       	push   $0x801074d8
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
801014ac:	68 eb 74 10 80       	push   $0x801074eb
801014b1:	68 e0 09 11 80       	push   $0x801109e0
801014b6:	e8 b5 31 00 00       	call   80104670 <initlock>
801014bb:	83 c4 10             	add    $0x10,%esp
801014be:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014c0:	83 ec 08             	sub    $0x8,%esp
801014c3:	68 f2 74 10 80       	push   $0x801074f2
801014c8:	53                   	push   %ebx
801014c9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014cf:	e8 6c 30 00 00       	call   80104540 <initsleeplock>
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
80101519:	68 58 75 10 80       	push   $0x80107558
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
801015ae:	e8 0d 33 00 00       	call   801048c0 <memset>
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
801015e3:	68 f8 74 10 80       	push   $0x801074f8
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
80101651:	e8 1a 33 00 00       	call   80104970 <memmove>
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
8010167f:	e8 2c 31 00 00       	call   801047b0 <acquire>
  ip->ref++;
80101684:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101688:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010168f:	e8 dc 31 00 00       	call   80104870 <release>
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
801016c2:	e8 b9 2e 00 00       	call   80104580 <acquiresleep>
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
80101738:	e8 33 32 00 00       	call   80104970 <memmove>
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
8010175d:	68 10 75 10 80       	push   $0x80107510
80101762:	e8 29 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101767:	83 ec 0c             	sub    $0xc,%esp
8010176a:	68 0a 75 10 80       	push   $0x8010750a
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
80101793:	e8 88 2e 00 00       	call   80104620 <holdingsleep>
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
801017af:	e9 2c 2e 00 00       	jmp    801045e0 <releasesleep>
    panic("iunlock");
801017b4:	83 ec 0c             	sub    $0xc,%esp
801017b7:	68 1f 75 10 80       	push   $0x8010751f
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
801017e0:	e8 9b 2d 00 00       	call   80104580 <acquiresleep>
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
801017fa:	e8 e1 2d 00 00       	call   801045e0 <releasesleep>
  acquire(&icache.lock);
801017ff:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101806:	e8 a5 2f 00 00       	call   801047b0 <acquire>
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
80101820:	e9 4b 30 00 00       	jmp    80104870 <release>
80101825:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101828:	83 ec 0c             	sub    $0xc,%esp
8010182b:	68 e0 09 11 80       	push   $0x801109e0
80101830:	e8 7b 2f 00 00       	call   801047b0 <acquire>
    int r = ip->ref;
80101835:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101838:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010183f:	e8 2c 30 00 00       	call   80104870 <release>
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
80101a27:	e8 44 2f 00 00       	call   80104970 <memmove>
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
80101b23:	e8 48 2e 00 00       	call   80104970 <memmove>
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
80101bbe:	e8 1d 2e 00 00       	call   801049e0 <strncmp>
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
80101c1d:	e8 be 2d 00 00       	call   801049e0 <strncmp>
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
80101c62:	68 39 75 10 80       	push   $0x80107539
80101c67:	e8 24 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c6c:	83 ec 0c             	sub    $0xc,%esp
80101c6f:	68 27 75 10 80       	push   $0x80107527
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
    ip = idup(mythread()->cwd);
80101c99:	e8 42 1c 00 00       	call   801038e0 <mythread>
  acquire(&icache.lock);
80101c9e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(mythread()->cwd);
80101ca1:	8b 70 24             	mov    0x24(%eax),%esi
  acquire(&icache.lock);
80101ca4:	68 e0 09 11 80       	push   $0x801109e0
80101ca9:	e8 02 2b 00 00       	call   801047b0 <acquire>
  ip->ref++;
80101cae:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cb9:	e8 b2 2b 00 00       	call   80104870 <release>
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
80101d15:	e8 56 2c 00 00       	call   80104970 <memmove>
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
80101da8:	e8 c3 2b 00 00       	call   80104970 <memmove>
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
80101e9d:	e8 9e 2b 00 00       	call   80104a40 <strncpy>
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
80101edb:	68 48 75 10 80       	push   $0x80107548
80101ee0:	e8 ab e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 8e 7b 10 80       	push   $0x80107b8e
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
80101ffb:	68 b4 75 10 80       	push   $0x801075b4
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 ab 75 10 80       	push   $0x801075ab
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102026:	68 c6 75 10 80       	push   $0x801075c6
8010202b:	68 80 a5 10 80       	push   $0x8010a580
80102030:	e8 3b 26 00 00       	call   80104670 <initlock>
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
801020ae:	e8 fd 26 00 00       	call   801047b0 <acquire>

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
80102111:	e8 6a 20 00 00       	call   80104180 <wakeup>

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
8010212f:	e8 3c 27 00 00       	call   80104870 <release>

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
8010214e:	e8 cd 24 00 00       	call   80104620 <holdingsleep>
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
80102188:	e8 23 26 00 00       	call   801047b0 <acquire>

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
801021d9:	e8 62 1d 00 00       	call   80103f40 <sleep>
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
801021f6:	e9 75 26 00 00       	jmp    80104870 <release>
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
8010221a:	68 e0 75 10 80       	push   $0x801075e0
8010221f:	e8 6c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 ca 75 10 80       	push   $0x801075ca
8010222c:	e8 5f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 f5 75 10 80       	push   $0x801075f5
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
80102287:	68 14 76 10 80       	push   $0x80107614
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
80102342:	81 fb c8 f1 11 80    	cmp    $0x8011f1c8,%ebx
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
80102362:	e8 59 25 00 00       	call   801048c0 <memset>

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
8010239b:	e9 d0 24 00 00       	jmp    80104870 <release>
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 40 26 11 80       	push   $0x80112640
801023a8:	e8 03 24 00 00       	call   801047b0 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 46 76 10 80       	push   $0x80107646
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
8010241b:	68 4c 76 10 80       	push   $0x8010764c
80102420:	68 40 26 11 80       	push   $0x80112640
80102425:	e8 46 22 00 00       	call   80104670 <initlock>
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
80102513:	e8 98 22 00 00       	call   801047b0 <acquire>
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
80102541:	e8 2a 23 00 00       	call   80104870 <release>
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
80102593:	0f b6 82 80 77 10 80 	movzbl -0x7fef8880(%edx),%eax
8010259a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010259c:	0f b6 82 80 76 10 80 	movzbl -0x7fef8980(%edx),%eax
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
801025b3:	8b 04 85 60 76 10 80 	mov    -0x7fef89a0(,%eax,4),%eax
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
801025d8:	0f b6 82 80 77 10 80 	movzbl -0x7fef8880(%edx),%eax
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
80102957:	e8 b4 1f 00 00       	call   80104910 <memcmp>
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
80102a84:	e8 e7 1e 00 00       	call   80104970 <memmove>
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
80102b2a:	68 80 78 10 80       	push   $0x80107880
80102b2f:	68 80 26 11 80       	push   $0x80112680
80102b34:	e8 37 1b 00 00       	call   80104670 <initlock>
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
80102bcb:	e8 e0 1b 00 00       	call   801047b0 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 80 26 11 80       	push   $0x80112680
80102be0:	68 80 26 11 80       	push   $0x80112680
80102be5:	e8 56 13 00 00       	call   80103f40 <sleep>
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
80102c1c:	e8 4f 1c 00 00       	call   80104870 <release>
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
80102c3e:	e8 6d 1b 00 00       	call   801047b0 <acquire>
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
80102c7c:	e8 ef 1b 00 00       	call   80104870 <release>
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
80102cd6:	e8 95 1c 00 00       	call   80104970 <memmove>
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
80102d1f:	e8 8c 1a 00 00       	call   801047b0 <acquire>
    wakeup(&log);
80102d24:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d2b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d32:	00 00 00 
    wakeup(&log);
80102d35:	e8 46 14 00 00       	call   80104180 <wakeup>
    release(&log.lock);
80102d3a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d41:	e8 2a 1b 00 00       	call   80104870 <release>
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
80102d60:	e8 1b 14 00 00       	call   80104180 <wakeup>
  release(&log.lock);
80102d65:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d6c:	e8 ff 1a 00 00       	call   80104870 <release>
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
80102d7f:	68 84 78 10 80       	push   $0x80107884
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
80102dce:	e8 dd 19 00 00       	call   801047b0 <acquire>
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
80102e1d:	e9 4e 1a 00 00       	jmp    80104870 <release>
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
80102e49:	68 93 78 10 80       	push   $0x80107893
80102e4e:	e8 3d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e53:	83 ec 0c             	sub    $0xc,%esp
80102e56:	68 a9 78 10 80       	push   $0x801078a9
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
80102e67:	e8 24 0a 00 00       	call   80103890 <cpuid>
80102e6c:	89 c3                	mov    %eax,%ebx
80102e6e:	e8 1d 0a 00 00       	call   80103890 <cpuid>
80102e73:	83 ec 04             	sub    $0x4,%esp
80102e76:	53                   	push   %ebx
80102e77:	50                   	push   %eax
80102e78:	68 c4 78 10 80       	push   $0x801078c4
80102e7d:	e8 de d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e82:	e8 79 2d 00 00       	call   80105c00 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e87:	e8 84 09 00 00       	call   80103810 <mycpu>
80102e8c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e8e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e93:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e9a:	e8 81 0d 00 00       	call   80103c20 <scheduler>
80102e9f:	90                   	nop

80102ea0 <mpenter>:
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ea6:	e8 45 3e 00 00       	call   80106cf0 <switchkvm>
  seginit();
80102eab:	e8 b0 3d 00 00       	call   80106c60 <seginit>
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
80102ed7:	68 c8 f1 11 80       	push   $0x8011f1c8
80102edc:	e8 2f f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ee1:	e8 da 42 00 00       	call   801071c0 <kvmalloc>
  mpinit();        // detect other processors
80102ee6:	e8 75 01 00 00       	call   80103060 <mpinit>
  lapicinit();     // interrupt controller
80102eeb:	e8 60 f7 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102ef0:	e8 6b 3d 00 00       	call   80106c60 <seginit>
  picinit();       // disable pic
80102ef5:	e8 46 03 00 00       	call   80103240 <picinit>
  ioapicinit();    // another interrupt controller
80102efa:	e8 41 f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102eff:	e8 bc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f04:	e8 27 30 00 00       	call   80105f30 <uartinit>
  pinit();         // process table
80102f09:	e8 e2 08 00 00       	call   801037f0 <pinit>
  tvinit();        // trap vectors
80102f0e:	e8 6d 2c 00 00       	call   80105b80 <tvinit>
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
80102f34:	e8 37 1a 00 00       	call   80104970 <memmove>

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
80102f60:	e8 ab 08 00 00       	call   80103810 <mycpu>
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
80102fd5:	e8 36 09 00 00       	call   80103910 <userinit>
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
8010300e:	68 d8 78 10 80       	push   $0x801078d8
80103013:	56                   	push   %esi
80103014:	e8 f7 18 00 00       	call   80104910 <memcmp>
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
801030cc:	68 f5 78 10 80       	push   $0x801078f5
801030d1:	56                   	push   %esi
801030d2:	e8 39 18 00 00       	call   80104910 <memcmp>
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
80103160:	ff 24 95 1c 79 10 80 	jmp    *-0x7fef86e4(,%edx,4)
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
80103213:	68 dd 78 10 80       	push   $0x801078dd
80103218:	e8 73 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010321d:	83 ec 0c             	sub    $0xc,%esp
80103220:	68 fc 78 10 80       	push   $0x801078fc
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
8010331b:	68 30 79 10 80       	push   $0x80107930
80103320:	50                   	push   %eax
80103321:	e8 4a 13 00 00       	call   80104670 <initlock>
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
8010337f:	e8 2c 14 00 00       	call   801047b0 <acquire>
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
8010339f:	e8 dc 0d 00 00       	call   80104180 <wakeup>
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
801033c4:	e9 a7 14 00 00       	jmp    80104870 <release>
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033d0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033d6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033e0:	00 00 00 
    wakeup(&p->nwrite);
801033e3:	50                   	push   %eax
801033e4:	e8 97 0d 00 00       	call   80104180 <wakeup>
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	eb b9                	jmp    801033a7 <pipeclose+0x37>
801033ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033f0:	83 ec 0c             	sub    $0xc,%esp
801033f3:	53                   	push   %ebx
801033f4:	e8 77 14 00 00       	call   80104870 <release>
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
8010341d:	e8 8e 13 00 00       	call   801047b0 <acquire>
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
80103474:	e8 07 0d 00 00       	call   80104180 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103479:	5a                   	pop    %edx
8010347a:	59                   	pop    %ecx
8010347b:	53                   	push   %ebx
8010347c:	56                   	push   %esi
8010347d:	e8 be 0a 00 00       	call   80103f40 <sleep>
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
801034a4:	e8 07 04 00 00       	call   801038b0 <myproc>
801034a9:	8b 40 18             	mov    0x18(%eax),%eax
801034ac:	85 c0                	test   %eax,%eax
801034ae:	74 c0                	je     80103470 <pipewrite+0x60>
        release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 b7 13 00 00       	call   80104870 <release>
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
80103503:	e8 78 0c 00 00       	call   80104180 <wakeup>
  release(&p->lock);
80103508:	89 1c 24             	mov    %ebx,(%esp)
8010350b:	e8 60 13 00 00       	call   80104870 <release>
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
80103530:	e8 7b 12 00 00       	call   801047b0 <acquire>
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
80103565:	e8 d6 09 00 00       	call   80103f40 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010356a:	83 c4 10             	add    $0x10,%esp
8010356d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103573:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103579:	75 35                	jne    801035b0 <piperead+0x90>
8010357b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103581:	85 d2                	test   %edx,%edx
80103583:	0f 84 8f 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
80103589:	e8 22 03 00 00       	call   801038b0 <myproc>
8010358e:	8b 48 18             	mov    0x18(%eax),%ecx
80103591:	85 c9                	test   %ecx,%ecx
80103593:	74 cb                	je     80103560 <piperead+0x40>
      release(&p->lock);
80103595:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103598:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010359d:	56                   	push   %esi
8010359e:	e8 cd 12 00 00       	call   80104870 <release>
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
801035f7:	e8 84 0b 00 00       	call   80104180 <wakeup>
  release(&p->lock);
801035fc:	89 34 24             	mov    %esi,(%esp)
801035ff:	e8 6c 12 00 00       	call   80104870 <release>
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

80103620 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	56                   	push   %esi
80103624:	53                   	push   %ebx
  //cprintf("entered wakeup1: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103625:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
8010362a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == UNUSED){
80103630:	8b 53 0c             	mov    0xc(%ebx),%edx
80103633:	85 d2                	test   %edx,%edx
80103635:	74 39                	je     80103670 <wakeup1+0x50>
      continue;
    }
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103637:	8b 73 6c             	mov    0x6c(%ebx),%esi
8010363a:	89 f2                	mov    %esi,%edx
8010363c:	eb 0f                	jmp    8010364d <wakeup1+0x2d>
8010363e:	66 90                	xchg   %ax,%ax
80103640:	8d 8e 80 02 00 00    	lea    0x280(%esi),%ecx
80103646:	83 c2 28             	add    $0x28,%edx
80103649:	39 ca                	cmp    %ecx,%edx
8010364b:	73 23                	jae    80103670 <wakeup1+0x50>
      if(t->state == SLEEPING && t->chan == chan){
8010364d:	83 7a 08 01          	cmpl   $0x1,0x8(%edx)
80103651:	75 ed                	jne    80103640 <wakeup1+0x20>
80103653:	39 42 1c             	cmp    %eax,0x1c(%edx)
80103656:	75 e8                	jne    80103640 <wakeup1+0x20>
        //p->state = RUNNABLE;  
        t->state = RUNNABLE;
80103658:	c7 42 08 02 00 00 00 	movl   $0x2,0x8(%edx)
8010365f:	8b 73 6c             	mov    0x6c(%ebx),%esi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103662:	83 c2 28             	add    $0x28,%edx
80103665:	8d 8e 80 02 00 00    	lea    0x280(%esi),%ecx
8010366b:	39 ca                	cmp    %ecx,%edx
8010366d:	72 de                	jb     8010364d <wakeup1+0x2d>
8010366f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103670:	83 c3 70             	add    $0x70,%ebx
80103673:	81 fb 74 49 11 80    	cmp    $0x80114974,%ebx
80103679:	72 b5                	jb     80103630 <wakeup1+0x10>
      }
    }
  }
}
8010367b:	5b                   	pop    %ebx
8010367c:	5e                   	pop    %esi
8010367d:	5d                   	pop    %ebp
8010367e:	c3                   	ret    
8010367f:	90                   	nop

80103680 <allocproc>:
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	57                   	push   %edi
80103684:	56                   	push   %esi
80103685:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103686:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
8010368b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
8010368e:	68 40 2d 11 80       	push   $0x80112d40
80103693:	e8 18 11 00 00       	call   801047b0 <acquire>
80103698:	83 c4 10             	add    $0x10,%esp
  int i = 0; // Index for the ptable/ttable
8010369b:	31 c0                	xor    %eax,%eax
8010369d:	eb 13                	jmp    801036b2 <allocproc+0x32>
8010369f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036a0:	83 c3 70             	add    $0x70,%ebx
      i++;
801036a3:	83 c0 01             	add    $0x1,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036a6:	81 fb 74 49 11 80    	cmp    $0x80114974,%ebx
801036ac:	0f 83 b6 00 00 00    	jae    80103768 <allocproc+0xe8>
    if(p->state == UNUSED)
801036b2:	8b 53 0c             	mov    0xc(%ebx),%edx
801036b5:	85 d2                	test   %edx,%edx
801036b7:	75 e7                	jne    801036a0 <allocproc+0x20>
  p->threads = ptable.ttable[i].threads;
801036b9:	8d 34 80             	lea    (%eax,%eax,4),%esi
  p->pid = nextpid++;
801036bc:	8b 15 08 a0 10 80    	mov    0x8010a008,%edx
  t->tid = nexttid++;
801036c2:	a1 04 a0 10 80       	mov    0x8010a004,%eax
  release(&ptable.lock);
801036c7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801036ca:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->threads = ptable.ttable[i].threads;
801036d1:	c1 e6 07             	shl    $0x7,%esi
801036d4:	81 c6 34 1c 00 00    	add    $0x1c34,%esi
  p->pid = nextpid++;
801036da:	89 53 10             	mov    %edx,0x10(%ebx)
801036dd:	8d 4a 01             	lea    0x1(%edx),%ecx
  p->threads = ptable.ttable[i].threads;
801036e0:	8d be 40 2d 11 80    	lea    -0x7feed2c0(%esi),%edi
  t->tid = nexttid++;
801036e6:	8d 50 01             	lea    0x1(%eax),%edx
  p->pid = nextpid++;
801036e9:	89 0d 08 a0 10 80    	mov    %ecx,0x8010a008
  p->threads = ptable.ttable[i].threads;
801036ef:	89 7b 6c             	mov    %edi,0x6c(%ebx)
  release(&ptable.lock);
801036f2:	68 40 2d 11 80       	push   $0x80112d40
  t->tid = nexttid++;
801036f7:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
801036fd:	89 47 0c             	mov    %eax,0xc(%edi)
  t->tproc = p;
80103700:	89 5f 10             	mov    %ebx,0x10(%edi)
  release(&ptable.lock);
80103703:	e8 68 11 00 00       	call   80104870 <release>
  if((p->kstack = kalloc()) == 0){
80103708:	e8 d3 ed ff ff       	call   801024e0 <kalloc>
8010370d:	83 c4 10             	add    $0x10,%esp
80103710:	85 c0                	test   %eax,%eax
80103712:	89 43 08             	mov    %eax,0x8(%ebx)
80103715:	74 6d                	je     80103784 <allocproc+0x104>
  if((t->kstack = kalloc()) == 0){
80103717:	e8 c4 ed ff ff       	call   801024e0 <kalloc>
8010371c:	85 c0                	test   %eax,%eax
8010371e:	89 86 40 2d 11 80    	mov    %eax,-0x7feed2c0(%esi)
80103724:	74 69                	je     8010378f <allocproc+0x10f>
  sp -= sizeof *t->tf;
80103726:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(t->context, 0, sizeof *t->context);
8010372c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *t->context;
8010372f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *t->tf;
80103734:	89 57 14             	mov    %edx,0x14(%edi)
  *(uint*)sp = (uint)trapret;
80103737:	c7 40 14 6f 5b 10 80 	movl   $0x80105b6f,0x14(%eax)
  memset(t->context, 0, sizeof *t->context);
8010373e:	6a 14                	push   $0x14
80103740:	6a 00                	push   $0x0
80103742:	50                   	push   %eax
  t->context = (struct context*)sp;
80103743:	89 47 18             	mov    %eax,0x18(%edi)
  memset(t->context, 0, sizeof *t->context);
80103746:	e8 75 11 00 00       	call   801048c0 <memset>
  t->context->eip = (uint)forkret;
8010374b:	8b 47 18             	mov    0x18(%edi),%eax
  return p;
8010374e:	83 c4 10             	add    $0x10,%esp
  t->context->eip = (uint)forkret;
80103751:	c7 40 10 a0 37 10 80 	movl   $0x801037a0,0x10(%eax)
}
80103758:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010375b:	89 d8                	mov    %ebx,%eax
8010375d:	5b                   	pop    %ebx
8010375e:	5e                   	pop    %esi
8010375f:	5f                   	pop    %edi
80103760:	5d                   	pop    %ebp
80103761:	c3                   	ret    
80103762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103768:	83 ec 0c             	sub    $0xc,%esp
  return 0;
8010376b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
8010376d:	68 40 2d 11 80       	push   $0x80112d40
80103772:	e8 f9 10 00 00       	call   80104870 <release>
  return 0;
80103777:	83 c4 10             	add    $0x10,%esp
}
8010377a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010377d:	89 d8                	mov    %ebx,%eax
8010377f:	5b                   	pop    %ebx
80103780:	5e                   	pop    %esi
80103781:	5f                   	pop    %edi
80103782:	5d                   	pop    %ebp
80103783:	c3                   	ret    
    p->state = UNUSED;
80103784:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010378b:	31 db                	xor    %ebx,%ebx
8010378d:	eb c9                	jmp    80103758 <allocproc+0xd8>
    return 0;
8010378f:	31 db                	xor    %ebx,%ebx
80103791:	eb c5                	jmp    80103758 <allocproc+0xd8>
80103793:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037a0 <forkret>:
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
801037a6:	68 40 2d 11 80       	push   $0x80112d40
801037ab:	e8 c0 10 00 00       	call   80104870 <release>
  if (first) {
801037b0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801037b5:	83 c4 10             	add    $0x10,%esp
801037b8:	85 c0                	test   %eax,%eax
801037ba:	75 04                	jne    801037c0 <forkret+0x20>
}
801037bc:	c9                   	leave  
801037bd:	c3                   	ret    
801037be:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801037c0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801037c3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801037ca:	00 00 00 
    iinit(ROOTDEV);
801037cd:	6a 01                	push   $0x1
801037cf:	e8 cc dc ff ff       	call   801014a0 <iinit>
    initlog(ROOTDEV);
801037d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037db:	e8 40 f3 ff ff       	call   80102b20 <initlog>
801037e0:	83 c4 10             	add    $0x10,%esp
}
801037e3:	c9                   	leave  
801037e4:	c3                   	ret    
801037e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037f0 <pinit>:
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037f6:	68 35 79 10 80       	push   $0x80107935
801037fb:	68 40 2d 11 80       	push   $0x80112d40
80103800:	e8 6b 0e 00 00       	call   80104670 <initlock>
}
80103805:	83 c4 10             	add    $0x10,%esp
80103808:	c9                   	leave  
80103809:	c3                   	ret    
8010380a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103810 <mycpu>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	56                   	push   %esi
80103814:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103815:	9c                   	pushf  
80103816:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103817:	f6 c4 02             	test   $0x2,%ah
8010381a:	75 5e                	jne    8010387a <mycpu+0x6a>
  apicid = lapicid();
8010381c:	e8 2f ef ff ff       	call   80102750 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103821:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
80103827:	85 f6                	test   %esi,%esi
80103829:	7e 42                	jle    8010386d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010382b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103832:	39 d0                	cmp    %edx,%eax
80103834:	74 30                	je     80103866 <mycpu+0x56>
80103836:	b9 34 28 11 80       	mov    $0x80112834,%ecx
  for (i = 0; i < ncpu; ++i) {
8010383b:	31 d2                	xor    %edx,%edx
8010383d:	8d 76 00             	lea    0x0(%esi),%esi
80103840:	83 c2 01             	add    $0x1,%edx
80103843:	39 f2                	cmp    %esi,%edx
80103845:	74 26                	je     8010386d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103847:	0f b6 19             	movzbl (%ecx),%ebx
8010384a:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
80103850:	39 c3                	cmp    %eax,%ebx
80103852:	75 ec                	jne    80103840 <mycpu+0x30>
80103854:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
8010385a:	05 80 27 11 80       	add    $0x80112780,%eax
}
8010385f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103862:	5b                   	pop    %ebx
80103863:	5e                   	pop    %esi
80103864:	5d                   	pop    %ebp
80103865:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103866:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010386b:	eb f2                	jmp    8010385f <mycpu+0x4f>
  panic("unknown apicid\n");
8010386d:	83 ec 0c             	sub    $0xc,%esp
80103870:	68 3c 79 10 80       	push   $0x8010793c
80103875:	e8 16 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010387a:	83 ec 0c             	sub    $0xc,%esp
8010387d:	68 2c 7a 10 80       	push   $0x80107a2c
80103882:	e8 09 cb ff ff       	call   80100390 <panic>
80103887:	89 f6                	mov    %esi,%esi
80103889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103890 <cpuid>:
cpuid() {
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103896:	e8 75 ff ff ff       	call   80103810 <mycpu>
8010389b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
801038a0:	c9                   	leave  
  return mycpu()-cpus;
801038a1:	c1 f8 02             	sar    $0x2,%eax
801038a4:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
801038aa:	c3                   	ret    
801038ab:	90                   	nop
801038ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038b0 <myproc>:
myproc(void) {
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	53                   	push   %ebx
801038b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038b7:	e8 24 0e 00 00       	call   801046e0 <pushcli>
  c = mycpu();
801038bc:	e8 4f ff ff ff       	call   80103810 <mycpu>
  p = c->proc;
801038c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038c7:	e8 54 0e 00 00       	call   80104720 <popcli>
}
801038cc:	83 c4 04             	add    $0x4,%esp
801038cf:	89 d8                	mov    %ebx,%eax
801038d1:	5b                   	pop    %ebx
801038d2:	5d                   	pop    %ebp
801038d3:	c3                   	ret    
801038d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038e0 <mythread>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	53                   	push   %ebx
801038e4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038e7:	e8 f4 0d 00 00       	call   801046e0 <pushcli>
  c = mycpu();
801038ec:	e8 1f ff ff ff       	call   80103810 <mycpu>
  t = c->thread;
801038f1:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
801038f7:	e8 24 0e 00 00       	call   80104720 <popcli>
}
801038fc:	83 c4 04             	add    $0x4,%esp
801038ff:	89 d8                	mov    %ebx,%eax
80103901:	5b                   	pop    %ebx
80103902:	5d                   	pop    %ebp
80103903:	c3                   	ret    
80103904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010390a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103910 <userinit>:
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	56                   	push   %esi
80103914:	53                   	push   %ebx
  p = allocproc();
80103915:	e8 66 fd ff ff       	call   80103680 <allocproc>
8010391a:	89 c6                	mov    %eax,%esi
  initproc = p;
8010391c:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103921:	e8 1a 38 00 00       	call   80107140 <setupkvm>
80103926:	85 c0                	test   %eax,%eax
80103928:	89 46 04             	mov    %eax,0x4(%esi)
8010392b:	0f 84 c9 00 00 00    	je     801039fa <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103931:	83 ec 04             	sub    $0x4,%esp
80103934:	68 2c 00 00 00       	push   $0x2c
80103939:	68 60 a4 10 80       	push   $0x8010a460
8010393e:	50                   	push   %eax
8010393f:	e8 dc 34 00 00       	call   80106e20 <inituvm>
  t = p->threads;
80103944:	8b 5e 6c             	mov    0x6c(%esi),%ebx
  memset(t->tf, 0, sizeof(*t->tf));
80103947:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010394a:	c7 06 00 10 00 00    	movl   $0x1000,(%esi)
  memset(t->tf, 0, sizeof(*t->tf));
80103950:	6a 4c                	push   $0x4c
80103952:	6a 00                	push   $0x0
80103954:	ff 73 14             	pushl  0x14(%ebx)
80103957:	e8 64 0f 00 00       	call   801048c0 <memset>
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010395c:	8b 43 14             	mov    0x14(%ebx),%eax
8010395f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103964:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103969:	83 c4 0c             	add    $0xc,%esp
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010396c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103970:	8b 43 14             	mov    0x14(%ebx),%eax
80103973:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  t->tf->es = t->tf->ds;
80103977:	8b 43 14             	mov    0x14(%ebx),%eax
8010397a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010397e:	66 89 50 28          	mov    %dx,0x28(%eax)
  t->tf->ss = t->tf->ds;
80103982:	8b 43 14             	mov    0x14(%ebx),%eax
80103985:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103989:	66 89 50 48          	mov    %dx,0x48(%eax)
  t->tf->eflags = FL_IF;
8010398d:	8b 43 14             	mov    0x14(%ebx),%eax
80103990:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  t->tf->esp = PGSIZE;
80103997:	8b 43 14             	mov    0x14(%ebx),%eax
8010399a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  t->tf->eip = 0;  // beginning of initcode.S
801039a1:	8b 43 14             	mov    0x14(%ebx),%eax
801039a4:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039ab:	8d 46 5c             	lea    0x5c(%esi),%eax
801039ae:	6a 10                	push   $0x10
801039b0:	68 65 79 10 80       	push   $0x80107965
801039b5:	50                   	push   %eax
801039b6:	e8 e5 10 00 00       	call   80104aa0 <safestrcpy>
  t->cwd = namei("/");
801039bb:	c7 04 24 6e 79 10 80 	movl   $0x8010796e,(%esp)
801039c2:	e8 39 e5 ff ff       	call   80101f00 <namei>
801039c7:	89 43 24             	mov    %eax,0x24(%ebx)
  acquire(&ptable.lock);
801039ca:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801039d1:	e8 da 0d 00 00       	call   801047b0 <acquire>
  p->state = USED;
801039d6:	c7 46 0c 02 00 00 00 	movl   $0x2,0xc(%esi)
  t->state = RUNNABLE;
801039dd:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  release(&ptable.lock);
801039e4:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801039eb:	e8 80 0e 00 00       	call   80104870 <release>
}
801039f0:	83 c4 10             	add    $0x10,%esp
801039f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039f6:	5b                   	pop    %ebx
801039f7:	5e                   	pop    %esi
801039f8:	5d                   	pop    %ebp
801039f9:	c3                   	ret    
    panic("userinit: out of memory?");
801039fa:	83 ec 0c             	sub    $0xc,%esp
801039fd:	68 4c 79 10 80       	push   $0x8010794c
80103a02:	e8 89 c9 ff ff       	call   80100390 <panic>
80103a07:	89 f6                	mov    %esi,%esi
80103a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a10 <growproc>:
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	53                   	push   %ebx
80103a15:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a18:	e8 c3 0c 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103a1d:	e8 ee fd ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103a22:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a28:	e8 f3 0c 00 00       	call   80104720 <popcli>
  acquire(&ptable.lock);
80103a2d:	83 ec 0c             	sub    $0xc,%esp
80103a30:	68 40 2d 11 80       	push   $0x80112d40
80103a35:	e8 76 0d 00 00       	call   801047b0 <acquire>
  if(n > 0){
80103a3a:	83 c4 10             	add    $0x10,%esp
80103a3d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a40:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a42:	7f 2c                	jg     80103a70 <growproc+0x60>
  } else if(n < 0){
80103a44:	75 5a                	jne    80103aa0 <growproc+0x90>
  switchuvm(curproc);
80103a46:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a49:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a4b:	53                   	push   %ebx
80103a4c:	e8 bf 32 00 00       	call   80106d10 <switchuvm>
  release(&ptable.lock);
80103a51:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a58:	e8 13 0e 00 00       	call   80104870 <release>
  return 0;
80103a5d:	83 c4 10             	add    $0x10,%esp
80103a60:	31 c0                	xor    %eax,%eax
}
80103a62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a65:	5b                   	pop    %ebx
80103a66:	5e                   	pop    %esi
80103a67:	5d                   	pop    %ebp
80103a68:	c3                   	ret    
80103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0){
80103a70:	83 ec 04             	sub    $0x4,%esp
80103a73:	01 c6                	add    %eax,%esi
80103a75:	56                   	push   %esi
80103a76:	50                   	push   %eax
80103a77:	ff 73 04             	pushl  0x4(%ebx)
80103a7a:	e8 e1 34 00 00       	call   80106f60 <allocuvm>
80103a7f:	83 c4 10             	add    $0x10,%esp
80103a82:	85 c0                	test   %eax,%eax
80103a84:	75 c0                	jne    80103a46 <growproc+0x36>
      release(&ptable.lock);
80103a86:	83 ec 0c             	sub    $0xc,%esp
80103a89:	68 40 2d 11 80       	push   $0x80112d40
80103a8e:	e8 dd 0d 00 00       	call   80104870 <release>
      return -1;
80103a93:	83 c4 10             	add    $0x10,%esp
80103a96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a9b:	eb c5                	jmp    80103a62 <growproc+0x52>
80103a9d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0){
80103aa0:	83 ec 04             	sub    $0x4,%esp
80103aa3:	01 c6                	add    %eax,%esi
80103aa5:	56                   	push   %esi
80103aa6:	50                   	push   %eax
80103aa7:	ff 73 04             	pushl  0x4(%ebx)
80103aaa:	e8 e1 35 00 00       	call   80107090 <deallocuvm>
80103aaf:	83 c4 10             	add    $0x10,%esp
80103ab2:	85 c0                	test   %eax,%eax
80103ab4:	75 90                	jne    80103a46 <growproc+0x36>
80103ab6:	eb ce                	jmp    80103a86 <growproc+0x76>
80103ab8:	90                   	nop
80103ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ac0 <fork>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	57                   	push   %edi
80103ac4:	56                   	push   %esi
80103ac5:	53                   	push   %ebx
80103ac6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ac9:	e8 12 0c 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103ace:	e8 3d fd ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103ad3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ad9:	e8 42 0c 00 00       	call   80104720 <popcli>
  pushcli();
80103ade:	e8 fd 0b 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103ae3:	e8 28 fd ff ff       	call   80103810 <mycpu>
  t = c->thread;
80103ae8:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80103aee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  popcli();
80103af1:	e8 2a 0c 00 00       	call   80104720 <popcli>
  if((np = allocproc()) == 0){
80103af6:	e8 85 fb ff ff       	call   80103680 <allocproc>
80103afb:	85 c0                	test   %eax,%eax
80103afd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b00:	89 c7                	mov    %eax,%edi
80103b02:	0f 84 d7 00 00 00    	je     80103bdf <fork+0x11f>
  nt = np->threads;
80103b08:	8b 48 6c             	mov    0x6c(%eax),%ecx
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b0b:	83 ec 08             	sub    $0x8,%esp
  nt->tproc = np;
80103b0e:	89 41 10             	mov    %eax,0x10(%ecx)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b11:	ff 33                	pushl  (%ebx)
80103b13:	ff 73 04             	pushl  0x4(%ebx)
  nt = np->threads;
80103b16:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b19:	e8 f2 36 00 00       	call   80107210 <copyuvm>
80103b1e:	83 c4 10             	add    $0x10,%esp
80103b21:	85 c0                	test   %eax,%eax
80103b23:	89 47 04             	mov    %eax,0x4(%edi)
80103b26:	0f 84 ba 00 00 00    	je     80103be6 <fork+0x126>
  np->sz = curproc->sz;
80103b2c:	8b 03                	mov    (%ebx),%eax
80103b2e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *nt->tf = *curthread->tf;
80103b31:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103b36:	89 02                	mov    %eax,(%edx)
  *nt->tf = *curthread->tf;
80103b38:	8b 45 dc             	mov    -0x24(%ebp),%eax
  np->parent = curproc;
80103b3b:	89 5a 14             	mov    %ebx,0x14(%edx)
  *nt->tf = *curthread->tf;
80103b3e:	8b 70 14             	mov    0x14(%eax),%esi
80103b41:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103b44:	8b 78 14             	mov    0x14(%eax),%edi
80103b47:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b49:	31 f6                	xor    %esi,%esi
80103b4b:	89 d7                	mov    %edx,%edi
  nt->tf->eax = 0;
80103b4d:	8b 40 14             	mov    0x14(%eax),%eax
80103b50:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b57:	89 f6                	mov    %esi,%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103b60:	8b 44 b3 1c          	mov    0x1c(%ebx,%esi,4),%eax
80103b64:	85 c0                	test   %eax,%eax
80103b66:	74 10                	je     80103b78 <fork+0xb8>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b68:	83 ec 0c             	sub    $0xc,%esp
80103b6b:	50                   	push   %eax
80103b6c:	e8 8f d2 ff ff       	call   80100e00 <filedup>
80103b71:	83 c4 10             	add    $0x10,%esp
80103b74:	89 44 b7 1c          	mov    %eax,0x1c(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b78:	83 c6 01             	add    $0x1,%esi
80103b7b:	83 fe 10             	cmp    $0x10,%esi
80103b7e:	75 e0                	jne    80103b60 <fork+0xa0>
  nt->cwd = idup(curthread->cwd);
80103b80:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103b83:	83 ec 0c             	sub    $0xc,%esp
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b86:	83 c3 5c             	add    $0x5c,%ebx
  nt->cwd = idup(curthread->cwd);
80103b89:	ff 70 24             	pushl  0x24(%eax)
80103b8c:	e8 df da ff ff       	call   80101670 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b91:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  nt->cwd = idup(curthread->cwd);
80103b94:	8b 75 e0             	mov    -0x20(%ebp),%esi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b97:	83 c4 0c             	add    $0xc,%esp
  nt->cwd = idup(curthread->cwd);
80103b9a:	89 46 24             	mov    %eax,0x24(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b9d:	8d 47 5c             	lea    0x5c(%edi),%eax
80103ba0:	6a 10                	push   $0x10
80103ba2:	53                   	push   %ebx
80103ba3:	50                   	push   %eax
80103ba4:	e8 f7 0e 00 00       	call   80104aa0 <safestrcpy>
  pid = np->pid;
80103ba9:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103bac:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103bb3:	e8 f8 0b 00 00       	call   801047b0 <acquire>
  np->state = USED;
80103bb8:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)
  nt->state = RUNNABLE;
80103bbf:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
  release(&ptable.lock);
80103bc6:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103bcd:	e8 9e 0c 00 00       	call   80104870 <release>
  return pid;
80103bd2:	83 c4 10             	add    $0x10,%esp
}
80103bd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bd8:	89 d8                	mov    %ebx,%eax
80103bda:	5b                   	pop    %ebx
80103bdb:	5e                   	pop    %esi
80103bdc:	5f                   	pop    %edi
80103bdd:	5d                   	pop    %ebp
80103bde:	c3                   	ret    
    return -1;
80103bdf:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103be4:	eb ef                	jmp    80103bd5 <fork+0x115>
    kfree(nt->kstack);
80103be6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103be9:	83 ec 0c             	sub    $0xc,%esp
80103bec:	ff 33                	pushl  (%ebx)
80103bee:	e8 3d e7 ff ff       	call   80102330 <kfree>
    np->state = UNUSED;
80103bf3:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    nt->kstack = 0;
80103bf6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    return -1;
80103bfc:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103bff:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
    nt->state = UNINIT;
80103c06:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103c0d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c12:	eb c1                	jmp    80103bd5 <fork+0x115>
80103c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c20 <scheduler>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	57                   	push   %edi
80103c24:	56                   	push   %esi
80103c25:	53                   	push   %ebx
80103c26:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103c29:	e8 e2 fb ff ff       	call   80103810 <mycpu>
  c->proc = 0;
80103c2e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c35:	00 00 00 
  c->thread = 0;
80103c38:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103c3f:	00 00 00 
  struct cpu *c = mycpu();
80103c42:	89 c7                	mov    %eax,%edi
80103c44:	8d 40 04             	lea    0x4(%eax),%eax
80103c47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80103c4a:	fb                   	sti    
    acquire(&ptable.lock);
80103c4b:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c4e:	be 74 2d 11 80       	mov    $0x80112d74,%esi
    acquire(&ptable.lock);
80103c53:	68 40 2d 11 80       	push   $0x80112d40
80103c58:	e8 53 0b 00 00       	call   801047b0 <acquire>
80103c5d:	83 c4 10             	add    $0x10,%esp
80103c60:	eb 11                	jmp    80103c73 <scheduler+0x53>
80103c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c68:	83 c6 70             	add    $0x70,%esi
80103c6b:	81 fe 74 49 11 80    	cmp    $0x80114974,%esi
80103c71:	73 73                	jae    80103ce6 <scheduler+0xc6>
      if(p->state != USED){
80103c73:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
80103c77:	75 ef                	jne    80103c68 <scheduler+0x48>
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103c79:	8b 4e 6c             	mov    0x6c(%esi),%ecx
80103c7c:	89 cb                	mov    %ecx,%ebx
80103c7e:	66 90                	xchg   %ax,%ax
        if(t->state != RUNNABLE){
80103c80:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
80103c84:	75 48                	jne    80103cce <scheduler+0xae>
        switchuvm(p);
80103c86:	83 ec 0c             	sub    $0xc,%esp
        c->proc = p;
80103c89:	89 b7 ac 00 00 00    	mov    %esi,0xac(%edi)
        c->thread = t;
80103c8f:	89 9f b0 00 00 00    	mov    %ebx,0xb0(%edi)
        switchuvm(p);
80103c95:	56                   	push   %esi
80103c96:	e8 75 30 00 00       	call   80106d10 <switchuvm>
        t->state = RUNNING;
80103c9b:	c7 43 08 03 00 00 00 	movl   $0x3,0x8(%ebx)
        swtch(&(c->scheduler), t->context);
80103ca2:	58                   	pop    %eax
80103ca3:	5a                   	pop    %edx
80103ca4:	ff 73 18             	pushl  0x18(%ebx)
80103ca7:	ff 75 e4             	pushl  -0x1c(%ebp)
80103caa:	e8 4c 0e 00 00       	call   80104afb <swtch>
        switchkvm();
80103caf:	e8 3c 30 00 00       	call   80106cf0 <switchkvm>
        c->proc = 0;
80103cb4:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103cbb:	00 00 00 
        c->thread = 0;
80103cbe:	c7 87 b0 00 00 00 00 	movl   $0x0,0xb0(%edi)
80103cc5:	00 00 00 
80103cc8:	83 c4 10             	add    $0x10,%esp
80103ccb:	8b 4e 6c             	mov    0x6c(%esi),%ecx
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103cce:	8d 91 80 02 00 00    	lea    0x280(%ecx),%edx
80103cd4:	83 c3 28             	add    $0x28,%ebx
80103cd7:	39 d3                	cmp    %edx,%ebx
80103cd9:	72 a5                	jb     80103c80 <scheduler+0x60>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cdb:	83 c6 70             	add    $0x70,%esi
80103cde:	81 fe 74 49 11 80    	cmp    $0x80114974,%esi
80103ce4:	72 8d                	jb     80103c73 <scheduler+0x53>
    release(&ptable.lock);
80103ce6:	83 ec 0c             	sub    $0xc,%esp
80103ce9:	68 40 2d 11 80       	push   $0x80112d40
80103cee:	e8 7d 0b 00 00       	call   80104870 <release>
    sti();
80103cf3:	83 c4 10             	add    $0x10,%esp
80103cf6:	e9 4f ff ff ff       	jmp    80103c4a <scheduler+0x2a>
80103cfb:	90                   	nop
80103cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103d00 <sched>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	56                   	push   %esi
80103d04:	53                   	push   %ebx
  pushcli();
80103d05:	e8 d6 09 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103d0a:	e8 01 fb ff ff       	call   80103810 <mycpu>
  t = c->thread;
80103d0f:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103d15:	e8 06 0a 00 00       	call   80104720 <popcli>
  if(!holding(&ptable.lock))
80103d1a:	83 ec 0c             	sub    $0xc,%esp
80103d1d:	68 40 2d 11 80       	push   $0x80112d40
80103d22:	e8 59 0a 00 00       	call   80104780 <holding>
80103d27:	83 c4 10             	add    $0x10,%esp
80103d2a:	85 c0                	test   %eax,%eax
80103d2c:	74 4f                	je     80103d7d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103d2e:	e8 dd fa ff ff       	call   80103810 <mycpu>
80103d33:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d3a:	75 68                	jne    80103da4 <sched+0xa4>
  if(t->state == RUNNING)
80103d3c:	83 7b 08 03          	cmpl   $0x3,0x8(%ebx)
80103d40:	74 55                	je     80103d97 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d42:	9c                   	pushf  
80103d43:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d44:	f6 c4 02             	test   $0x2,%ah
80103d47:	75 41                	jne    80103d8a <sched+0x8a>
  intena = mycpu()->intena;
80103d49:	e8 c2 fa ff ff       	call   80103810 <mycpu>
  swtch(&t->context, mycpu()->scheduler);
80103d4e:	83 c3 18             	add    $0x18,%ebx
  intena = mycpu()->intena;
80103d51:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&t->context, mycpu()->scheduler);
80103d57:	e8 b4 fa ff ff       	call   80103810 <mycpu>
80103d5c:	83 ec 08             	sub    $0x8,%esp
80103d5f:	ff 70 04             	pushl  0x4(%eax)
80103d62:	53                   	push   %ebx
80103d63:	e8 93 0d 00 00       	call   80104afb <swtch>
  mycpu()->intena = intena;
80103d68:	e8 a3 fa ff ff       	call   80103810 <mycpu>
}
80103d6d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d70:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d79:	5b                   	pop    %ebx
80103d7a:	5e                   	pop    %esi
80103d7b:	5d                   	pop    %ebp
80103d7c:	c3                   	ret    
    panic("sched ptable.lock");
80103d7d:	83 ec 0c             	sub    $0xc,%esp
80103d80:	68 70 79 10 80       	push   $0x80107970
80103d85:	e8 06 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d8a:	83 ec 0c             	sub    $0xc,%esp
80103d8d:	68 9c 79 10 80       	push   $0x8010799c
80103d92:	e8 f9 c5 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d97:	83 ec 0c             	sub    $0xc,%esp
80103d9a:	68 8e 79 10 80       	push   $0x8010798e
80103d9f:	e8 ec c5 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103da4:	83 ec 0c             	sub    $0xc,%esp
80103da7:	68 82 79 10 80       	push   $0x80107982
80103dac:	e8 df c5 ff ff       	call   80100390 <panic>
80103db1:	eb 0d                	jmp    80103dc0 <exit>
80103db3:	90                   	nop
80103db4:	90                   	nop
80103db5:	90                   	nop
80103db6:	90                   	nop
80103db7:	90                   	nop
80103db8:	90                   	nop
80103db9:	90                   	nop
80103dba:	90                   	nop
80103dbb:	90                   	nop
80103dbc:	90                   	nop
80103dbd:	90                   	nop
80103dbe:	90                   	nop
80103dbf:	90                   	nop

80103dc0 <exit>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103dc9:	e8 12 09 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103dce:	e8 3d fa ff ff       	call   80103810 <mycpu>
  p = c->proc;
80103dd3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103dd9:	e8 42 09 00 00       	call   80104720 <popcli>
  pushcli();
80103dde:	e8 fd 08 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103de3:	e8 28 fa ff ff       	call   80103810 <mycpu>
  t = c->thread;
80103de8:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80103dee:	8d 7e 1c             	lea    0x1c(%esi),%edi
80103df1:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80103df4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80103df7:	e8 24 09 00 00       	call   80104720 <popcli>
  if(curproc == initproc)
80103dfc:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103e02:	0f 84 da 00 00 00    	je     80103ee2 <exit+0x122>
80103e08:	90                   	nop
80103e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80103e10:	8b 17                	mov    (%edi),%edx
80103e12:	85 d2                	test   %edx,%edx
80103e14:	74 12                	je     80103e28 <exit+0x68>
      fileclose(curproc->ofile[fd]);
80103e16:	83 ec 0c             	sub    $0xc,%esp
80103e19:	52                   	push   %edx
80103e1a:	e8 31 d0 ff ff       	call   80100e50 <fileclose>
      curproc->ofile[fd] = 0;
80103e1f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103e25:	83 c4 10             	add    $0x10,%esp
80103e28:	83 c7 04             	add    $0x4,%edi
  for(fd = 0; fd < NOFILE; fd++){
80103e2b:	39 df                	cmp    %ebx,%edi
80103e2d:	75 e1                	jne    80103e10 <exit+0x50>
  begin_op();
80103e2f:	e8 8c ed ff ff       	call   80102bc0 <begin_op>
  iput(curthread->cwd);
80103e34:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103e37:	83 ec 0c             	sub    $0xc,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e3a:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
  iput(curthread->cwd);
80103e3f:	ff 77 24             	pushl  0x24(%edi)
80103e42:	e8 89 d9 ff ff       	call   801017d0 <iput>
  end_op();
80103e47:	e8 e4 ed ff ff       	call   80102c30 <end_op>
  curthread->cwd = 0;
80103e4c:	c7 47 24 00 00 00 00 	movl   $0x0,0x24(%edi)
  acquire(&ptable.lock);
80103e53:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103e5a:	e8 51 09 00 00       	call   801047b0 <acquire>
  wakeup1(curproc->parent);
80103e5f:	8b 46 14             	mov    0x14(%esi),%eax
80103e62:	e8 b9 f7 ff ff       	call   80103620 <wakeup1>
80103e67:	83 c4 10             	add    $0x10,%esp
80103e6a:	eb 0f                	jmp    80103e7b <exit+0xbb>
80103e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e70:	83 c3 70             	add    $0x70,%ebx
80103e73:	81 fb 74 49 11 80    	cmp    $0x80114974,%ebx
80103e79:	73 25                	jae    80103ea0 <exit+0xe0>
    if(p->parent == curproc){
80103e7b:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e7e:	75 f0                	jne    80103e70 <exit+0xb0>
      if(p->state == ZOMBIE)
80103e80:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
      p->parent = initproc;
80103e84:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103e89:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
80103e8c:	75 e2                	jne    80103e70 <exit+0xb0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e8e:	83 c3 70             	add    $0x70,%ebx
        wakeup1(initproc);
80103e91:	e8 8a f7 ff ff       	call   80103620 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e96:	81 fb 74 49 11 80    	cmp    $0x80114974,%ebx
80103e9c:	72 dd                	jb     80103e7b <exit+0xbb>
80103e9e:	66 90                	xchg   %ax,%ax
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103ea0:	8b 46 6c             	mov    0x6c(%esi),%eax
80103ea3:	90                   	nop
80103ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    t->exitRequest = 1;
80103ea8:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103eaf:	8b 4e 6c             	mov    0x6c(%esi),%ecx
80103eb2:	83 c0 28             	add    $0x28,%eax
80103eb5:	8d 91 80 02 00 00    	lea    0x280(%ecx),%edx
80103ebb:	39 d0                	cmp    %edx,%eax
80103ebd:	72 e9                	jb     80103ea8 <exit+0xe8>
  curthread->state = TERMINATED;
80103ebf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  curproc->state = ZOMBIE;
80103ec2:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  curthread->state = TERMINATED;
80103ec9:	c7 40 08 05 00 00 00 	movl   $0x5,0x8(%eax)
  sched();
80103ed0:	e8 2b fe ff ff       	call   80103d00 <sched>
  panic("zombie exit");
80103ed5:	83 ec 0c             	sub    $0xc,%esp
80103ed8:	68 bd 79 10 80       	push   $0x801079bd
80103edd:	e8 ae c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103ee2:	83 ec 0c             	sub    $0xc,%esp
80103ee5:	68 b0 79 10 80       	push   $0x801079b0
80103eea:	e8 a1 c4 ff ff       	call   80100390 <panic>
80103eef:	90                   	nop

80103ef0 <yield>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	53                   	push   %ebx
80103ef4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ef7:	68 40 2d 11 80       	push   $0x80112d40
80103efc:	e8 af 08 00 00       	call   801047b0 <acquire>
  pushcli();
80103f01:	e8 da 07 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103f06:	e8 05 f9 ff ff       	call   80103810 <mycpu>
  t = c->thread;
80103f0b:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103f11:	e8 0a 08 00 00       	call   80104720 <popcli>
  mythread()->state = RUNNABLE;
80103f16:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  sched();
80103f1d:	e8 de fd ff ff       	call   80103d00 <sched>
  release(&ptable.lock);
80103f22:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f29:	e8 42 09 00 00       	call   80104870 <release>
}
80103f2e:	83 c4 10             	add    $0x10,%esp
80103f31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f34:	c9                   	leave  
80103f35:	c3                   	ret    
80103f36:	8d 76 00             	lea    0x0(%esi),%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <sleep>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	57                   	push   %edi
80103f44:	56                   	push   %esi
80103f45:	53                   	push   %ebx
80103f46:	83 ec 0c             	sub    $0xc,%esp
80103f49:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103f4f:	e8 8c 07 00 00       	call   801046e0 <pushcli>
  c = mycpu();
80103f54:	e8 b7 f8 ff ff       	call   80103810 <mycpu>
  t = c->thread;
80103f59:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103f5f:	e8 bc 07 00 00       	call   80104720 <popcli>
  if(t == 0)
80103f64:	85 db                	test   %ebx,%ebx
80103f66:	0f 84 87 00 00 00    	je     80103ff3 <sleep+0xb3>
  if(lk == 0)
80103f6c:	85 f6                	test   %esi,%esi
80103f6e:	74 76                	je     80103fe6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f70:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103f76:	74 50                	je     80103fc8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f78:	83 ec 0c             	sub    $0xc,%esp
80103f7b:	68 40 2d 11 80       	push   $0x80112d40
80103f80:	e8 2b 08 00 00       	call   801047b0 <acquire>
    release(lk);
80103f85:	89 34 24             	mov    %esi,(%esp)
80103f88:	e8 e3 08 00 00       	call   80104870 <release>
  t->chan = chan;
80103f8d:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
80103f90:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
80103f97:	e8 64 fd ff ff       	call   80103d00 <sched>
  t->chan = 0;
80103f9c:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
    release(&ptable.lock);
80103fa3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103faa:	e8 c1 08 00 00       	call   80104870 <release>
    acquire(lk);
80103faf:	89 75 08             	mov    %esi,0x8(%ebp)
80103fb2:	83 c4 10             	add    $0x10,%esp
}
80103fb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fb8:	5b                   	pop    %ebx
80103fb9:	5e                   	pop    %esi
80103fba:	5f                   	pop    %edi
80103fbb:	5d                   	pop    %ebp
    acquire(lk);
80103fbc:	e9 ef 07 00 00       	jmp    801047b0 <acquire>
80103fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  t->chan = chan;
80103fc8:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
80103fcb:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
80103fd2:	e8 29 fd ff ff       	call   80103d00 <sched>
  t->chan = 0;
80103fd7:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
}
80103fde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fe1:	5b                   	pop    %ebx
80103fe2:	5e                   	pop    %esi
80103fe3:	5f                   	pop    %edi
80103fe4:	5d                   	pop    %ebp
80103fe5:	c3                   	ret    
    panic("sleep without lk");
80103fe6:	83 ec 0c             	sub    $0xc,%esp
80103fe9:	68 cf 79 10 80       	push   $0x801079cf
80103fee:	e8 9d c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80103ff3:	83 ec 0c             	sub    $0xc,%esp
80103ff6:	68 c9 79 10 80       	push   $0x801079c9
80103ffb:	e8 90 c3 ff ff       	call   80100390 <panic>

80104000 <wait>:
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	57                   	push   %edi
80104004:	56                   	push   %esi
80104005:	53                   	push   %ebx
80104006:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104009:	e8 d2 06 00 00       	call   801046e0 <pushcli>
  c = mycpu();
8010400e:	e8 fd f7 ff ff       	call   80103810 <mycpu>
  p = c->proc;
80104013:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104019:	e8 02 07 00 00       	call   80104720 <popcli>
  acquire(&ptable.lock);
8010401e:	83 ec 0c             	sub    $0xc,%esp
80104021:	68 40 2d 11 80       	push   $0x80112d40
80104026:	e8 85 07 00 00       	call   801047b0 <acquire>
8010402b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010402e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104030:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104035:	eb 14                	jmp    8010404b <wait+0x4b>
80104037:	89 f6                	mov    %esi,%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104040:	83 c3 70             	add    $0x70,%ebx
80104043:	81 fb 74 49 11 80    	cmp    $0x80114974,%ebx
80104049:	73 1b                	jae    80104066 <wait+0x66>
      if(p->parent != curproc)
8010404b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010404e:	75 f0                	jne    80104040 <wait+0x40>
      if(p->state == ZOMBIE){
80104050:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104054:	74 3a                	je     80104090 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104056:	83 c3 70             	add    $0x70,%ebx
      havekids = 1;
80104059:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010405e:	81 fb 74 49 11 80    	cmp    $0x80114974,%ebx
80104064:	72 e5                	jb     8010404b <wait+0x4b>
    if(!havekids || curproc->killed){
80104066:	85 c0                	test   %eax,%eax
80104068:	0f 84 ec 00 00 00    	je     8010415a <wait+0x15a>
8010406e:	8b 46 18             	mov    0x18(%esi),%eax
80104071:	85 c0                	test   %eax,%eax
80104073:	0f 85 e1 00 00 00    	jne    8010415a <wait+0x15a>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104079:	83 ec 08             	sub    $0x8,%esp
8010407c:	68 40 2d 11 80       	push   $0x80112d40
80104081:	56                   	push   %esi
80104082:	e8 b9 fe ff ff       	call   80103f40 <sleep>
    havekids = 0;
80104087:	83 c4 10             	add    $0x10,%esp
8010408a:	eb a2                	jmp    8010402e <wait+0x2e>
8010408c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104090:	8b 53 6c             	mov    0x6c(%ebx),%edx
        int hasNonTerminated = 0;
80104093:	31 ff                	xor    %edi,%edi
              hasNonTerminated = 1;
80104095:	b9 01 00 00 00       	mov    $0x1,%ecx
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
8010409a:	89 d6                	mov    %edx,%esi
8010409c:	eb 14                	jmp    801040b2 <wait+0xb2>
8010409e:	66 90                	xchg   %ax,%ax
              hasNonTerminated = 1;
801040a0:	85 c0                	test   %eax,%eax
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801040a2:	8d 82 80 02 00 00    	lea    0x280(%edx),%eax
              hasNonTerminated = 1;
801040a8:	0f 45 f9             	cmovne %ecx,%edi
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801040ab:	83 c6 28             	add    $0x28,%esi
801040ae:	39 c6                	cmp    %eax,%esi
801040b0:	73 40                	jae    801040f2 <wait+0xf2>
          if(t->state == TERMINATED){
801040b2:	8b 46 08             	mov    0x8(%esi),%eax
801040b5:	83 f8 05             	cmp    $0x5,%eax
801040b8:	75 e6                	jne    801040a0 <wait+0xa0>
            kfree(t->kstack);
801040ba:	83 ec 0c             	sub    $0xc,%esp
801040bd:	ff 36                	pushl  (%esi)
801040bf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801040c2:	83 c6 28             	add    $0x28,%esi
            kfree(t->kstack);
801040c5:	e8 66 e2 ff ff       	call   80102330 <kfree>
            t->kstack = 0;
801040ca:	c7 46 d8 00 00 00 00 	movl   $0x0,-0x28(%esi)
            t->tid = 0;
801040d1:	c7 46 e4 00 00 00 00 	movl   $0x0,-0x1c(%esi)
801040d8:	83 c4 10             	add    $0x10,%esp
            t->tproc = 0;
801040db:	c7 46 e8 00 00 00 00 	movl   $0x0,-0x18(%esi)
801040e2:	8b 53 6c             	mov    0x6c(%ebx),%edx
801040e5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801040e8:	8d 82 80 02 00 00    	lea    0x280(%edx),%eax
801040ee:	39 c6                	cmp    %eax,%esi
801040f0:	72 c0                	jb     801040b2 <wait+0xb2>
  int havekids, pid = 0;
801040f2:	31 f6                	xor    %esi,%esi
        if(!hasNonTerminated){
801040f4:	85 ff                	test   %edi,%edi
801040f6:	75 48                	jne    80104140 <wait+0x140>
          kfree(p->kstack);
801040f8:	83 ec 0c             	sub    $0xc,%esp
801040fb:	ff 73 08             	pushl  0x8(%ebx)
          pid = p->pid;
801040fe:	8b 73 10             	mov    0x10(%ebx),%esi
          kfree(p->kstack);
80104101:	e8 2a e2 ff ff       	call   80102330 <kfree>
          freevm(p->pgdir);
80104106:	5a                   	pop    %edx
80104107:	ff 73 04             	pushl  0x4(%ebx)
          p->kstack = 0;
8010410a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
          freevm(p->pgdir);
80104111:	e8 aa 2f 00 00       	call   801070c0 <freevm>
          p->pid = 0;
80104116:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
          p->parent = 0;
8010411d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
          p->threads = 0;
80104124:	83 c4 10             	add    $0x10,%esp
          p->name[0] = 0;
80104127:	c6 43 5c 00          	movb   $0x0,0x5c(%ebx)
          p->killed = 0;
8010412b:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
          p->state = UNUSED;
80104132:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
          p->threads = 0;
80104139:	c7 43 6c 00 00 00 00 	movl   $0x0,0x6c(%ebx)
        release(&ptable.lock);
80104140:	83 ec 0c             	sub    $0xc,%esp
80104143:	68 40 2d 11 80       	push   $0x80112d40
80104148:	e8 23 07 00 00       	call   80104870 <release>
        return pid;
8010414d:	83 c4 10             	add    $0x10,%esp
}
80104150:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104153:	89 f0                	mov    %esi,%eax
80104155:	5b                   	pop    %ebx
80104156:	5e                   	pop    %esi
80104157:	5f                   	pop    %edi
80104158:	5d                   	pop    %ebp
80104159:	c3                   	ret    
      release(&ptable.lock);
8010415a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010415d:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104162:	68 40 2d 11 80       	push   $0x80112d40
80104167:	e8 04 07 00 00       	call   80104870 <release>
      return -1;
8010416c:	83 c4 10             	add    $0x10,%esp
8010416f:	eb df                	jmp    80104150 <wait+0x150>
80104171:	eb 0d                	jmp    80104180 <wakeup>
80104173:	90                   	nop
80104174:	90                   	nop
80104175:	90                   	nop
80104176:	90                   	nop
80104177:	90                   	nop
80104178:	90                   	nop
80104179:	90                   	nop
8010417a:	90                   	nop
8010417b:	90                   	nop
8010417c:	90                   	nop
8010417d:	90                   	nop
8010417e:	90                   	nop
8010417f:	90                   	nop

80104180 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	53                   	push   %ebx
80104184:	83 ec 10             	sub    $0x10,%esp
80104187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010418a:	68 40 2d 11 80       	push   $0x80112d40
8010418f:	e8 1c 06 00 00       	call   801047b0 <acquire>
  wakeup1(chan);
80104194:	89 d8                	mov    %ebx,%eax
80104196:	e8 85 f4 ff ff       	call   80103620 <wakeup1>
  release(&ptable.lock);
8010419b:	83 c4 10             	add    $0x10,%esp
8010419e:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801041a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041a8:	c9                   	leave  
  release(&ptable.lock);
801041a9:	e9 c2 06 00 00       	jmp    80104870 <release>
801041ae:	66 90                	xchg   %ax,%ax

801041b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 10             	sub    $0x10,%esp
801041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //cprintf("entered kill: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;

  acquire(&ptable.lock);
801041ba:	68 40 2d 11 80       	push   $0x80112d40
801041bf:	e8 ec 05 00 00       	call   801047b0 <acquire>
801041c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801041cc:	eb 0c                	jmp    801041da <kill+0x2a>
801041ce:	66 90                	xchg   %ax,%ax
801041d0:	83 c0 70             	add    $0x70,%eax
801041d3:	3d 74 49 11 80       	cmp    $0x80114974,%eax
801041d8:	73 26                	jae    80104200 <kill+0x50>
    if(p->pid == pid){
801041da:	39 58 10             	cmp    %ebx,0x10(%eax)
801041dd:	75 f1                	jne    801041d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      /*if(p->state == SLEEPING)
        p->state = RUNNABLE;*/
      release(&ptable.lock);
801041df:	83 ec 0c             	sub    $0xc,%esp
      p->killed = 1;
801041e2:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%eax)
      release(&ptable.lock);
801041e9:	68 40 2d 11 80       	push   $0x80112d40
801041ee:	e8 7d 06 00 00       	call   80104870 <release>
      return 0;
801041f3:	83 c4 10             	add    $0x10,%esp
801041f6:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801041f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041fb:	c9                   	leave  
801041fc:	c3                   	ret    
801041fd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104200:	83 ec 0c             	sub    $0xc,%esp
80104203:	68 40 2d 11 80       	push   $0x80112d40
80104208:	e8 63 06 00 00       	call   80104870 <release>
  return -1;
8010420d:	83 c4 10             	add    $0x10,%esp
80104210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104215:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104218:	c9                   	leave  
80104219:	c3                   	ret    
8010421a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104220 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	57                   	push   %edi
80104224:	56                   	push   %esi
80104225:	53                   	push   %ebx
  struct proc *p;
  struct kthread *t;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104226:	bf 74 2d 11 80       	mov    $0x80112d74,%edi
{
8010422b:	83 ec 3c             	sub    $0x3c,%esp
8010422e:	66 90                	xchg   %ax,%ax
    if(p->state == UNUSED)
80104230:	8b 57 0c             	mov    0xc(%edi),%edx
80104233:	85 d2                	test   %edx,%edx
80104235:	0f 84 84 00 00 00    	je     801042bf <procdump+0x9f>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010423b:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
8010423e:	b9 e0 79 10 80       	mov    $0x801079e0,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104243:	77 11                	ja     80104256 <procdump+0x36>
80104245:	8b 0c 95 54 7a 10 80 	mov    -0x7fef85ac(,%edx,4),%ecx
      state = "???";
8010424c:	ba e0 79 10 80       	mov    $0x801079e0,%edx
80104251:	85 c9                	test   %ecx,%ecx
80104253:	0f 44 ca             	cmove  %edx,%ecx
    cprintf("%d %s %s || ", p->pid, state, p->name);
80104256:	8d 57 5c             	lea    0x5c(%edi),%edx
80104259:	52                   	push   %edx
8010425a:	51                   	push   %ecx
8010425b:	ff 77 10             	pushl  0x10(%edi)
8010425e:	68 e4 79 10 80       	push   $0x801079e4
80104263:	e8 f8 c3 ff ff       	call   80100660 <cprintf>
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104268:	8b 57 6c             	mov    0x6c(%edi),%edx
8010426b:	83 c4 10             	add    $0x10,%esp
8010426e:	89 d3                	mov    %edx,%ebx
      if(t->state == UNINIT)
80104270:	8b 43 08             	mov    0x8(%ebx),%eax
80104273:	85 c0                	test   %eax,%eax
80104275:	74 3b                	je     801042b2 <procdump+0x92>
        continue;
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104277:	8b 4f 0c             	mov    0xc(%edi),%ecx
        state = states[p->state];
      else
        state = "???";
8010427a:	ba e0 79 10 80       	mov    $0x801079e0,%edx
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010427f:	83 f9 05             	cmp    $0x5,%ecx
80104282:	77 11                	ja     80104295 <procdump+0x75>
80104284:	8b 14 8d 54 7a 10 80 	mov    -0x7fef85ac(,%ecx,4),%edx
        state = "???";
8010428b:	b9 e0 79 10 80       	mov    $0x801079e0,%ecx
80104290:	85 d2                	test   %edx,%edx
80104292:	0f 44 d1             	cmove  %ecx,%edx
      cprintf("%d %s || ", t->tid, state);
80104295:	83 ec 04             	sub    $0x4,%esp
80104298:	52                   	push   %edx
80104299:	ff 73 0c             	pushl  0xc(%ebx)
8010429c:	68 f1 79 10 80       	push   $0x801079f1
801042a1:	e8 ba c3 ff ff       	call   80100660 <cprintf>
      if(t->state == SLEEPING){
801042a6:	83 c4 10             	add    $0x10,%esp
801042a9:	83 7b 08 01          	cmpl   $0x1,0x8(%ebx)
801042ad:	74 41                	je     801042f0 <procdump+0xd0>
801042af:	8b 57 6c             	mov    0x6c(%edi),%edx
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801042b2:	8d 8a 80 02 00 00    	lea    0x280(%edx),%ecx
801042b8:	83 c3 28             	add    $0x28,%ebx
801042bb:	39 cb                	cmp    %ecx,%ebx
801042bd:	72 b1                	jb     80104270 <procdump+0x50>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042bf:	83 c7 70             	add    $0x70,%edi
801042c2:	81 ff 74 49 11 80    	cmp    $0x80114974,%edi
801042c8:	0f 82 62 ff ff ff    	jb     80104230 <procdump+0x10>
          cprintf(" %p * ", pc[i]);
        }
      }
    }
  }
  cprintf("\n");
801042ce:	83 ec 0c             	sub    $0xc,%esp
801042d1:	68 a7 7d 10 80       	push   $0x80107da7
801042d6:	e8 85 c3 ff ff       	call   80100660 <cprintf>
}
801042db:	83 c4 10             	add    $0x10,%esp
801042de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042e1:	5b                   	pop    %ebx
801042e2:	5e                   	pop    %esi
801042e3:	5f                   	pop    %edi
801042e4:	5d                   	pop    %ebp
801042e5:	c3                   	ret    
801042e6:	8d 76 00             	lea    0x0(%esi),%esi
801042e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        getcallerpcs((uint*)t->context->ebp+2, pc);
801042f0:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042f3:	83 ec 08             	sub    $0x8,%esp
801042f6:	8d 75 c0             	lea    -0x40(%ebp),%esi
801042f9:	50                   	push   %eax
801042fa:	8b 53 18             	mov    0x18(%ebx),%edx
801042fd:	8b 52 0c             	mov    0xc(%edx),%edx
80104300:	83 c2 08             	add    $0x8,%edx
80104303:	52                   	push   %edx
80104304:	e8 87 03 00 00       	call   80104690 <getcallerpcs>
80104309:	83 c4 10             	add    $0x10,%esp
8010430c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(i=0; i<10 && pc[i] != 0; i++){
80104310:	8b 0e                	mov    (%esi),%ecx
80104312:	85 c9                	test   %ecx,%ecx
80104314:	74 99                	je     801042af <procdump+0x8f>
          cprintf(" %p * ", pc[i]);
80104316:	83 ec 08             	sub    $0x8,%esp
80104319:	83 c6 04             	add    $0x4,%esi
8010431c:	51                   	push   %ecx
8010431d:	68 fb 79 10 80       	push   $0x801079fb
80104322:	e8 39 c3 ff ff       	call   80100660 <cprintf>
        for(i=0; i<10 && pc[i] != 0; i++){
80104327:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010432a:	83 c4 10             	add    $0x10,%esp
8010432d:	39 f0                	cmp    %esi,%eax
8010432f:	75 df                	jne    80104310 <procdump+0xf0>
80104331:	e9 79 ff ff ff       	jmp    801042af <procdump+0x8f>
80104336:	66 90                	xchg   %ax,%ax
80104338:	66 90                	xchg   %ax,%ax
8010433a:	66 90                	xchg   %ax,%ax
8010433c:	66 90                	xchg   %ax,%ax
8010433e:	66 90                	xchg   %ax,%ax

80104340 <kthread_create>:
};

extern struct ptable ptable;
extern void trapret(void);

int kthread_create(void (*start_func)(), void* stack){
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	57                   	push   %edi
80104344:	56                   	push   %esi
80104345:	53                   	push   %ebx
80104346:	83 ec 0c             	sub    $0xc,%esp
    struct proc *p;
    struct kthread *t = 0;
    char *sp;

    p = myproc();
80104349:	e8 62 f5 ff ff       	call   801038b0 <myproc>

    cprintf("kthread_create\n");
8010434e:	83 ec 0c             	sub    $0xc,%esp
    p = myproc();
80104351:	89 c6                	mov    %eax,%esi
    cprintf("kthread_create\n");
80104353:	68 6c 7a 10 80       	push   $0x80107a6c
80104358:	e8 03 c3 ff ff       	call   80100660 <cprintf>

    acquire(&ptable.lock);
8010435d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104364:	e8 47 04 00 00       	call   801047b0 <acquire>
    int tid = 1;
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104369:	8b 5e 6c             	mov    0x6c(%esi),%ebx
        if(tempT->state == UNINIT){
8010436c:	83 c4 10             	add    $0x10,%esp
    int tid = 1;
8010436f:	b8 01 00 00 00       	mov    $0x1,%eax
        if(tempT->state == UNINIT){
80104374:	8b 7b 08             	mov    0x8(%ebx),%edi
80104377:	85 ff                	test   %edi,%edi
80104379:	74 1b                	je     80104396 <kthread_create+0x56>
8010437b:	90                   	nop
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            t = tempT;
            break;
        }
        else{
            tid++;
80104380:	83 c0 01             	add    $0x1,%eax
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104383:	83 c3 28             	add    $0x28,%ebx
80104386:	83 f8 11             	cmp    $0x11,%eax
80104389:	0f 84 b9 00 00 00    	je     80104448 <kthread_create+0x108>
        if(tempT->state == UNINIT){
8010438f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80104392:	85 c9                	test   %ecx,%ecx
80104394:	75 ea                	jne    80104380 <kthread_create+0x40>
        }
    }
    t->tid = tid;
    release(&ptable.lock);
80104396:	83 ec 0c             	sub    $0xc,%esp
    t->tid = tid;
80104399:	89 43 0c             	mov    %eax,0xc(%ebx)
    release(&ptable.lock);
8010439c:	68 40 2d 11 80       	push   $0x80112d40
801043a1:	e8 ca 04 00 00       	call   80104870 <release>

    if (t == 0)
        return -1;

    t->tproc = p;    
801043a6:	89 73 10             	mov    %esi,0x10(%ebx)

    // Allocate kernel stack for the thread.
    if((t->kstack = kalloc()) == 0){
801043a9:	e8 32 e1 ff ff       	call   801024e0 <kalloc>
801043ae:	89 c2                	mov    %eax,%edx
801043b0:	89 03                	mov    %eax,(%ebx)
801043b2:	83 c4 10             	add    $0x10,%esp
        return 0;
801043b5:	31 c0                	xor    %eax,%eax
    if((t->kstack = kalloc()) == 0){
801043b7:	85 d2                	test   %edx,%edx
801043b9:	74 7e                	je     80104439 <kthread_create+0xf9>
    }
    sp = t->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *t->tf;
801043bb:	8d 82 b4 0f 00 00    	lea    0xfb4(%edx),%eax
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *t->context;
    t->context = (struct context*)sp;
    memset(t->context, 0, sizeof *t->context); //todo: 0 or tid?
801043c1:	83 ec 04             	sub    $0x4,%esp
    sp -= sizeof *t->context;
801043c4:	81 c2 9c 0f 00 00    	add    $0xf9c,%edx
    sp -= sizeof *t->tf;
801043ca:	89 43 14             	mov    %eax,0x14(%ebx)
    *(uint*)sp = (uint)trapret;
801043cd:	c7 42 14 6f 5b 10 80 	movl   $0x80105b6f,0x14(%edx)
    t->context = (struct context*)sp;
801043d4:	89 53 18             	mov    %edx,0x18(%ebx)
    memset(t->context, 0, sizeof *t->context); //todo: 0 or tid?
801043d7:	6a 14                	push   $0x14
801043d9:	6a 00                	push   $0x0
801043db:	52                   	push   %edx
801043dc:	e8 df 04 00 00       	call   801048c0 <memset>

    //cprintf("func address: %d\n",(uint) t->tf->eip);
    t->context->eip = (uint)forkret;
801043e1:	8b 43 18             	mov    0x18(%ebx),%eax
801043e4:	c7 40 10 a0 37 10 80 	movl   $0x801037a0,0x10(%eax)
    
    struct kthread* thread = mythread();
801043eb:	e8 f0 f4 ff ff       	call   801038e0 <mythread>
    *t->tf=*thread->tf;
801043f0:	8b 7b 14             	mov    0x14(%ebx),%edi
801043f3:	8b 70 14             	mov    0x14(%eax),%esi
801043f6:	b9 13 00 00 00       	mov    $0x13,%ecx
801043fb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->eip=(uint)start_func;
801043fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    t->tf->esp=(uint) (stack+KSTACKSIZE);
80104400:	8b 7d 0c             	mov    0xc(%ebp),%edi
    t->tf->eip=(uint)start_func;
80104403:	8b 43 14             	mov    0x14(%ebx),%eax
    t->tf->esp=(uint) (stack+KSTACKSIZE);
80104406:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
    t->tf->eip=(uint)start_func;
8010440c:	89 48 38             	mov    %ecx,0x38(%eax)
    t->tf->esp=(uint) (stack+KSTACKSIZE);
8010440f:	8b 43 14             	mov    0x14(%ebx),%eax
80104412:	89 50 44             	mov    %edx,0x44(%eax)

 
    t->exitRequest = 0;
80104415:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    t->state=RUNNABLE;
8010441c:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
    t->ustack = stack;
80104423:	89 7b 04             	mov    %edi,0x4(%ebx)


    cprintf("finished func %d\n",(uint)start_func);
80104426:	58                   	pop    %eax
80104427:	5a                   	pop    %edx
80104428:	51                   	push   %ecx
80104429:	68 7c 7a 10 80       	push   $0x80107a7c
8010442e:	e8 2d c2 ff ff       	call   80100660 <cprintf>


    return t->tid;
80104433:	8b 43 0c             	mov    0xc(%ebx),%eax
80104436:	83 c4 10             	add    $0x10,%esp
}
80104439:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010443c:	5b                   	pop    %ebx
8010443d:	5e                   	pop    %esi
8010443e:	5f                   	pop    %edi
8010443f:	5d                   	pop    %ebp
80104440:	c3                   	ret    
80104441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    t->tid = tid;
80104448:	c7 05 0c 00 00 00 00 	movl   $0x0,0xc
8010444f:	00 00 00 
80104452:	0f 0b                	ud2    
80104454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010445a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104460 <kthread_id>:
    if (t == 0)
        return -1;
}*/


int kthread_id(){
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	83 ec 08             	sub    $0x8,%esp
    procdump();
80104466:	e8 b5 fd ff ff       	call   80104220 <procdump>
    return mythread()->tid;
8010446b:	e8 70 f4 ff ff       	call   801038e0 <mythread>
80104470:	8b 40 0c             	mov    0xc(%eax),%eax
}
80104473:	c9                   	leave  
80104474:	c3                   	ret    
80104475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104480 <kthread_exit>:

void kthread_exit(){
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	56                   	push   %esi
80104485:	53                   	push   %ebx
80104486:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
80104489:	e8 52 f4 ff ff       	call   801038e0 <mythread>
    struct proc *threadProc;
    struct kthread *t;

    acquire(&ptable.lock);
8010448e:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
80104491:	89 c7                	mov    %eax,%edi
    acquire(&ptable.lock);
80104493:	68 40 2d 11 80       	push   $0x80112d40
80104498:	e8 13 03 00 00       	call   801047b0 <acquire>
    threadProc = curthread->tproc;
8010449d:	8b 47 10             	mov    0x10(%edi),%eax
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
801044a0:	83 c4 10             	add    $0x10,%esp
801044a3:	8b 70 6c             	mov    0x6c(%eax),%esi
801044a6:	89 f1                	mov    %esi,%ecx
801044a8:	eb 15                	jmp    801044bf <kthread_exit+0x3f>
801044aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044b0:	8d 9e 80 02 00 00    	lea    0x280(%esi),%ebx
801044b6:	83 c1 28             	add    $0x28,%ecx
801044b9:	89 f2                	mov    %esi,%edx
801044bb:	39 cb                	cmp    %ecx,%ebx
801044bd:	76 1e                	jbe    801044dd <kthread_exit+0x5d>
        if(t->tproc == threadProc){ // threads of the same process 
801044bf:	39 41 10             	cmp    %eax,0x10(%ecx)
801044c2:	75 ec                	jne    801044b0 <kthread_exit+0x30>
            t->exitRequest = 1;
801044c4:	c7 41 20 01 00 00 00 	movl   $0x1,0x20(%ecx)
801044cb:	8b 70 6c             	mov    0x6c(%eax),%esi
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
801044ce:	83 c1 28             	add    $0x28,%ecx
801044d1:	8d 9e 80 02 00 00    	lea    0x280(%esi),%ebx
801044d7:	89 f2                	mov    %esi,%edx
801044d9:	39 cb                	cmp    %ecx,%ebx
801044db:	77 e2                	ja     801044bf <kthread_exit+0x3f>
        }
    }
    // check if it is the last running thread. if it is, the process execute exit();
    int lastRunning = 1;
801044dd:	b9 01 00 00 00       	mov    $0x1,%ecx
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t != curthread && t->state != TERMINATED){
            lastRunning = 0;
801044e2:	31 c0                	xor    %eax,%eax
801044e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(t != curthread && t->state != TERMINATED){
801044e8:	39 d7                	cmp    %edx,%edi
801044ea:	74 07                	je     801044f3 <kthread_exit+0x73>
            lastRunning = 0;
801044ec:	83 7a 08 05          	cmpl   $0x5,0x8(%edx)
801044f0:	0f 45 c8             	cmovne %eax,%ecx
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
801044f3:	83 c2 28             	add    $0x28,%edx
801044f6:	39 d3                	cmp    %edx,%ebx
801044f8:	77 ee                	ja     801044e8 <kthread_exit+0x68>
        }
    }
    if(lastRunning){
801044fa:	85 c9                	test   %ecx,%ecx
801044fc:	75 1e                	jne    8010451c <kthread_exit+0x9c>
        exit();
    }
    // Jump into the scheduler, never to return.
    curthread->state = TERMINATED;
801044fe:	c7 47 08 05 00 00 00 	movl   $0x5,0x8(%edi)
    procdump();
80104505:	e8 16 fd ff ff       	call   80104220 <procdump>
    sched();
8010450a:	e8 f1 f7 ff ff       	call   80103d00 <sched>
    panic("terminated exit");
8010450f:	83 ec 0c             	sub    $0xc,%esp
80104512:	68 8e 7a 10 80       	push   $0x80107a8e
80104517:	e8 74 be ff ff       	call   80100390 <panic>
        exit();
8010451c:	e8 9f f8 ff ff       	call   80103dc0 <exit>
80104521:	eb db                	jmp    801044fe <kthread_exit+0x7e>
80104523:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104530 <kthread_join>:
}

int kthread_join(int thread_id){
80104530:	55                   	push   %ebp
          if (t->state == TERMINATED){
                threadTerminated = 1;
            }
    }
    return 0;*/
80104531:	31 c0                	xor    %eax,%eax
int kthread_join(int thread_id){
80104533:	89 e5                	mov    %esp,%ebp
80104535:	5d                   	pop    %ebp
80104536:	c3                   	ret    
80104537:	66 90                	xchg   %ax,%ax
80104539:	66 90                	xchg   %ax,%ax
8010453b:	66 90                	xchg   %ax,%ax
8010453d:	66 90                	xchg   %ax,%ax
8010453f:	90                   	nop

80104540 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 0c             	sub    $0xc,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010454a:	68 9e 7a 10 80       	push   $0x80107a9e
8010454f:	8d 43 04             	lea    0x4(%ebx),%eax
80104552:	50                   	push   %eax
80104553:	e8 18 01 00 00       	call   80104670 <initlock>
  lk->name = name;
80104558:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010455b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104561:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104564:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010456b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010456e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104571:	c9                   	leave  
80104572:	c3                   	ret    
80104573:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104580 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	56                   	push   %esi
80104584:	53                   	push   %ebx
80104585:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104588:	83 ec 0c             	sub    $0xc,%esp
8010458b:	8d 73 04             	lea    0x4(%ebx),%esi
8010458e:	56                   	push   %esi
8010458f:	e8 1c 02 00 00       	call   801047b0 <acquire>
  while (lk->locked) {
80104594:	8b 13                	mov    (%ebx),%edx
80104596:	83 c4 10             	add    $0x10,%esp
80104599:	85 d2                	test   %edx,%edx
8010459b:	74 16                	je     801045b3 <acquiresleep+0x33>
8010459d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801045a0:	83 ec 08             	sub    $0x8,%esp
801045a3:	56                   	push   %esi
801045a4:	53                   	push   %ebx
801045a5:	e8 96 f9 ff ff       	call   80103f40 <sleep>
  while (lk->locked) {
801045aa:	8b 03                	mov    (%ebx),%eax
801045ac:	83 c4 10             	add    $0x10,%esp
801045af:	85 c0                	test   %eax,%eax
801045b1:	75 ed                	jne    801045a0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801045b3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801045b9:	e8 f2 f2 ff ff       	call   801038b0 <myproc>
801045be:	8b 40 10             	mov    0x10(%eax),%eax
801045c1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801045c4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801045c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045ca:	5b                   	pop    %ebx
801045cb:	5e                   	pop    %esi
801045cc:	5d                   	pop    %ebp
  release(&lk->lk);
801045cd:	e9 9e 02 00 00       	jmp    80104870 <release>
801045d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	56                   	push   %esi
801045e4:	53                   	push   %ebx
801045e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045e8:	83 ec 0c             	sub    $0xc,%esp
801045eb:	8d 73 04             	lea    0x4(%ebx),%esi
801045ee:	56                   	push   %esi
801045ef:	e8 bc 01 00 00       	call   801047b0 <acquire>
  lk->locked = 0;
801045f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801045fa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104601:	89 1c 24             	mov    %ebx,(%esp)
80104604:	e8 77 fb ff ff       	call   80104180 <wakeup>
  release(&lk->lk);
80104609:	89 75 08             	mov    %esi,0x8(%ebp)
8010460c:	83 c4 10             	add    $0x10,%esp
}
8010460f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104612:	5b                   	pop    %ebx
80104613:	5e                   	pop    %esi
80104614:	5d                   	pop    %ebp
  release(&lk->lk);
80104615:	e9 56 02 00 00       	jmp    80104870 <release>
8010461a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104620 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	57                   	push   %edi
80104624:	56                   	push   %esi
80104625:	53                   	push   %ebx
80104626:	31 ff                	xor    %edi,%edi
80104628:	83 ec 18             	sub    $0x18,%esp
8010462b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010462e:	8d 73 04             	lea    0x4(%ebx),%esi
80104631:	56                   	push   %esi
80104632:	e8 79 01 00 00       	call   801047b0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104637:	8b 03                	mov    (%ebx),%eax
80104639:	83 c4 10             	add    $0x10,%esp
8010463c:	85 c0                	test   %eax,%eax
8010463e:	74 13                	je     80104653 <holdingsleep+0x33>
80104640:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104643:	e8 68 f2 ff ff       	call   801038b0 <myproc>
80104648:	39 58 10             	cmp    %ebx,0x10(%eax)
8010464b:	0f 94 c0             	sete   %al
8010464e:	0f b6 c0             	movzbl %al,%eax
80104651:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104653:	83 ec 0c             	sub    $0xc,%esp
80104656:	56                   	push   %esi
80104657:	e8 14 02 00 00       	call   80104870 <release>
  return r;
}
8010465c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010465f:	89 f8                	mov    %edi,%eax
80104661:	5b                   	pop    %ebx
80104662:	5e                   	pop    %esi
80104663:	5f                   	pop    %edi
80104664:	5d                   	pop    %ebp
80104665:	c3                   	ret    
80104666:	66 90                	xchg   %ax,%ax
80104668:	66 90                	xchg   %ax,%ax
8010466a:	66 90                	xchg   %ax,%ax
8010466c:	66 90                	xchg   %ax,%ax
8010466e:	66 90                	xchg   %ax,%ax

80104670 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104676:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104679:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010467f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104682:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104689:	5d                   	pop    %ebp
8010468a:	c3                   	ret    
8010468b:	90                   	nop
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104690:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104691:	31 d2                	xor    %edx,%edx
{
80104693:	89 e5                	mov    %esp,%ebp
80104695:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104696:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104699:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010469c:	83 e8 08             	sub    $0x8,%eax
8010469f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046a0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801046a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801046ac:	77 1a                	ja     801046c8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801046ae:	8b 58 04             	mov    0x4(%eax),%ebx
801046b1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801046b4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801046b7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801046b9:	83 fa 0a             	cmp    $0xa,%edx
801046bc:	75 e2                	jne    801046a0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801046be:	5b                   	pop    %ebx
801046bf:	5d                   	pop    %ebp
801046c0:	c3                   	ret    
801046c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801046cb:	83 c1 28             	add    $0x28,%ecx
801046ce:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801046d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801046d6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801046d9:	39 c1                	cmp    %eax,%ecx
801046db:	75 f3                	jne    801046d0 <getcallerpcs+0x40>
}
801046dd:	5b                   	pop    %ebx
801046de:	5d                   	pop    %ebp
801046df:	c3                   	ret    

801046e0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	53                   	push   %ebx
801046e4:	83 ec 04             	sub    $0x4,%esp
801046e7:	9c                   	pushf  
801046e8:	5b                   	pop    %ebx
  asm volatile("cli");
801046e9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801046ea:	e8 21 f1 ff ff       	call   80103810 <mycpu>
801046ef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801046f5:	85 c0                	test   %eax,%eax
801046f7:	75 11                	jne    8010470a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801046f9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801046ff:	e8 0c f1 ff ff       	call   80103810 <mycpu>
80104704:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010470a:	e8 01 f1 ff ff       	call   80103810 <mycpu>
8010470f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104716:	83 c4 04             	add    $0x4,%esp
80104719:	5b                   	pop    %ebx
8010471a:	5d                   	pop    %ebp
8010471b:	c3                   	ret    
8010471c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104720 <popcli>:

void
popcli(void)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104726:	9c                   	pushf  
80104727:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104728:	f6 c4 02             	test   $0x2,%ah
8010472b:	75 35                	jne    80104762 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010472d:	e8 de f0 ff ff       	call   80103810 <mycpu>
80104732:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104739:	78 34                	js     8010476f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010473b:	e8 d0 f0 ff ff       	call   80103810 <mycpu>
80104740:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104746:	85 d2                	test   %edx,%edx
80104748:	74 06                	je     80104750 <popcli+0x30>
    sti();
}
8010474a:	c9                   	leave  
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104750:	e8 bb f0 ff ff       	call   80103810 <mycpu>
80104755:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010475b:	85 c0                	test   %eax,%eax
8010475d:	74 eb                	je     8010474a <popcli+0x2a>
  asm volatile("sti");
8010475f:	fb                   	sti    
}
80104760:	c9                   	leave  
80104761:	c3                   	ret    
    panic("popcli - interruptible");
80104762:	83 ec 0c             	sub    $0xc,%esp
80104765:	68 a9 7a 10 80       	push   $0x80107aa9
8010476a:	e8 21 bc ff ff       	call   80100390 <panic>
    panic("popcli");
8010476f:	83 ec 0c             	sub    $0xc,%esp
80104772:	68 c0 7a 10 80       	push   $0x80107ac0
80104777:	e8 14 bc ff ff       	call   80100390 <panic>
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <holding>:
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 75 08             	mov    0x8(%ebp),%esi
80104788:	31 db                	xor    %ebx,%ebx
  pushcli();
8010478a:	e8 51 ff ff ff       	call   801046e0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010478f:	8b 06                	mov    (%esi),%eax
80104791:	85 c0                	test   %eax,%eax
80104793:	74 10                	je     801047a5 <holding+0x25>
80104795:	8b 5e 08             	mov    0x8(%esi),%ebx
80104798:	e8 73 f0 ff ff       	call   80103810 <mycpu>
8010479d:	39 c3                	cmp    %eax,%ebx
8010479f:	0f 94 c3             	sete   %bl
801047a2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801047a5:	e8 76 ff ff ff       	call   80104720 <popcli>
}
801047aa:	89 d8                	mov    %ebx,%eax
801047ac:	5b                   	pop    %ebx
801047ad:	5e                   	pop    %esi
801047ae:	5d                   	pop    %ebp
801047af:	c3                   	ret    

801047b0 <acquire>:
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801047b5:	e8 26 ff ff ff       	call   801046e0 <pushcli>
  if(holding(lk))
801047ba:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047bd:	83 ec 0c             	sub    $0xc,%esp
801047c0:	53                   	push   %ebx
801047c1:	e8 ba ff ff ff       	call   80104780 <holding>
801047c6:	83 c4 10             	add    $0x10,%esp
801047c9:	85 c0                	test   %eax,%eax
801047cb:	0f 85 83 00 00 00    	jne    80104854 <acquire+0xa4>
801047d1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801047d3:	ba 01 00 00 00       	mov    $0x1,%edx
801047d8:	eb 09                	jmp    801047e3 <acquire+0x33>
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047e0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047e3:	89 d0                	mov    %edx,%eax
801047e5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801047e8:	85 c0                	test   %eax,%eax
801047ea:	75 f4                	jne    801047e0 <acquire+0x30>
  __sync_synchronize();
801047ec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801047f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047f4:	e8 17 f0 ff ff       	call   80103810 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801047f9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801047fc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801047ff:	89 e8                	mov    %ebp,%eax
80104801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104808:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010480e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104814:	77 1a                	ja     80104830 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104816:	8b 48 04             	mov    0x4(%eax),%ecx
80104819:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010481c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010481f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104821:	83 fe 0a             	cmp    $0xa,%esi
80104824:	75 e2                	jne    80104808 <acquire+0x58>
}
80104826:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104829:	5b                   	pop    %ebx
8010482a:	5e                   	pop    %esi
8010482b:	5d                   	pop    %ebp
8010482c:	c3                   	ret    
8010482d:	8d 76 00             	lea    0x0(%esi),%esi
80104830:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104833:	83 c2 28             	add    $0x28,%edx
80104836:	8d 76 00             	lea    0x0(%esi),%esi
80104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104840:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104846:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104849:	39 d0                	cmp    %edx,%eax
8010484b:	75 f3                	jne    80104840 <acquire+0x90>
}
8010484d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104850:	5b                   	pop    %ebx
80104851:	5e                   	pop    %esi
80104852:	5d                   	pop    %ebp
80104853:	c3                   	ret    
    panic("acquire");
80104854:	83 ec 0c             	sub    $0xc,%esp
80104857:	68 c7 7a 10 80       	push   $0x80107ac7
8010485c:	e8 2f bb ff ff       	call   80100390 <panic>
80104861:	eb 0d                	jmp    80104870 <release>
80104863:	90                   	nop
80104864:	90                   	nop
80104865:	90                   	nop
80104866:	90                   	nop
80104867:	90                   	nop
80104868:	90                   	nop
80104869:	90                   	nop
8010486a:	90                   	nop
8010486b:	90                   	nop
8010486c:	90                   	nop
8010486d:	90                   	nop
8010486e:	90                   	nop
8010486f:	90                   	nop

80104870 <release>:
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	83 ec 10             	sub    $0x10,%esp
80104877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010487a:	53                   	push   %ebx
8010487b:	e8 00 ff ff ff       	call   80104780 <holding>
80104880:	83 c4 10             	add    $0x10,%esp
80104883:	85 c0                	test   %eax,%eax
80104885:	74 22                	je     801048a9 <release+0x39>
  lk->pcs[0] = 0;
80104887:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010488e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104895:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010489a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801048a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048a3:	c9                   	leave  
  popcli();
801048a4:	e9 77 fe ff ff       	jmp    80104720 <popcli>
    panic("release");
801048a9:	83 ec 0c             	sub    $0xc,%esp
801048ac:	68 cf 7a 10 80       	push   $0x80107acf
801048b1:	e8 da ba ff ff       	call   80100390 <panic>
801048b6:	66 90                	xchg   %ax,%ax
801048b8:	66 90                	xchg   %ax,%ax
801048ba:	66 90                	xchg   %ax,%ax
801048bc:	66 90                	xchg   %ax,%ax
801048be:	66 90                	xchg   %ax,%ax

801048c0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	57                   	push   %edi
801048c4:	53                   	push   %ebx
801048c5:	8b 55 08             	mov    0x8(%ebp),%edx
801048c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801048cb:	f6 c2 03             	test   $0x3,%dl
801048ce:	75 05                	jne    801048d5 <memset+0x15>
801048d0:	f6 c1 03             	test   $0x3,%cl
801048d3:	74 13                	je     801048e8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801048d5:	89 d7                	mov    %edx,%edi
801048d7:	8b 45 0c             	mov    0xc(%ebp),%eax
801048da:	fc                   	cld    
801048db:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801048dd:	5b                   	pop    %ebx
801048de:	89 d0                	mov    %edx,%eax
801048e0:	5f                   	pop    %edi
801048e1:	5d                   	pop    %ebp
801048e2:	c3                   	ret    
801048e3:	90                   	nop
801048e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801048e8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801048ec:	c1 e9 02             	shr    $0x2,%ecx
801048ef:	89 f8                	mov    %edi,%eax
801048f1:	89 fb                	mov    %edi,%ebx
801048f3:	c1 e0 18             	shl    $0x18,%eax
801048f6:	c1 e3 10             	shl    $0x10,%ebx
801048f9:	09 d8                	or     %ebx,%eax
801048fb:	09 f8                	or     %edi,%eax
801048fd:	c1 e7 08             	shl    $0x8,%edi
80104900:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104902:	89 d7                	mov    %edx,%edi
80104904:	fc                   	cld    
80104905:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104907:	5b                   	pop    %ebx
80104908:	89 d0                	mov    %edx,%eax
8010490a:	5f                   	pop    %edi
8010490b:	5d                   	pop    %ebp
8010490c:	c3                   	ret    
8010490d:	8d 76 00             	lea    0x0(%esi),%esi

80104910 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	53                   	push   %ebx
80104916:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104919:	8b 75 08             	mov    0x8(%ebp),%esi
8010491c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010491f:	85 db                	test   %ebx,%ebx
80104921:	74 29                	je     8010494c <memcmp+0x3c>
    if(*s1 != *s2)
80104923:	0f b6 16             	movzbl (%esi),%edx
80104926:	0f b6 0f             	movzbl (%edi),%ecx
80104929:	38 d1                	cmp    %dl,%cl
8010492b:	75 2b                	jne    80104958 <memcmp+0x48>
8010492d:	b8 01 00 00 00       	mov    $0x1,%eax
80104932:	eb 14                	jmp    80104948 <memcmp+0x38>
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104938:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010493c:	83 c0 01             	add    $0x1,%eax
8010493f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104944:	38 ca                	cmp    %cl,%dl
80104946:	75 10                	jne    80104958 <memcmp+0x48>
  while(n-- > 0){
80104948:	39 d8                	cmp    %ebx,%eax
8010494a:	75 ec                	jne    80104938 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010494c:	5b                   	pop    %ebx
  return 0;
8010494d:	31 c0                	xor    %eax,%eax
}
8010494f:	5e                   	pop    %esi
80104950:	5f                   	pop    %edi
80104951:	5d                   	pop    %ebp
80104952:	c3                   	ret    
80104953:	90                   	nop
80104954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104958:	0f b6 c2             	movzbl %dl,%eax
}
8010495b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010495c:	29 c8                	sub    %ecx,%eax
}
8010495e:	5e                   	pop    %esi
8010495f:	5f                   	pop    %edi
80104960:	5d                   	pop    %ebp
80104961:	c3                   	ret    
80104962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	8b 45 08             	mov    0x8(%ebp),%eax
80104978:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010497b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010497e:	39 c3                	cmp    %eax,%ebx
80104980:	73 26                	jae    801049a8 <memmove+0x38>
80104982:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104985:	39 c8                	cmp    %ecx,%eax
80104987:	73 1f                	jae    801049a8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104989:	85 f6                	test   %esi,%esi
8010498b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010498e:	74 0f                	je     8010499f <memmove+0x2f>
      *--d = *--s;
80104990:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104994:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104997:	83 ea 01             	sub    $0x1,%edx
8010499a:	83 fa ff             	cmp    $0xffffffff,%edx
8010499d:	75 f1                	jne    80104990 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010499f:	5b                   	pop    %ebx
801049a0:	5e                   	pop    %esi
801049a1:	5d                   	pop    %ebp
801049a2:	c3                   	ret    
801049a3:	90                   	nop
801049a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
801049a8:	31 d2                	xor    %edx,%edx
801049aa:	85 f6                	test   %esi,%esi
801049ac:	74 f1                	je     8010499f <memmove+0x2f>
801049ae:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801049b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801049b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801049b7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801049ba:	39 d6                	cmp    %edx,%esi
801049bc:	75 f2                	jne    801049b0 <memmove+0x40>
}
801049be:	5b                   	pop    %ebx
801049bf:	5e                   	pop    %esi
801049c0:	5d                   	pop    %ebp
801049c1:	c3                   	ret    
801049c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049d0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801049d3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801049d4:	eb 9a                	jmp    80104970 <memmove>
801049d6:	8d 76 00             	lea    0x0(%esi),%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	57                   	push   %edi
801049e4:	56                   	push   %esi
801049e5:	8b 7d 10             	mov    0x10(%ebp),%edi
801049e8:	53                   	push   %ebx
801049e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801049ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801049ef:	85 ff                	test   %edi,%edi
801049f1:	74 2f                	je     80104a22 <strncmp+0x42>
801049f3:	0f b6 01             	movzbl (%ecx),%eax
801049f6:	0f b6 1e             	movzbl (%esi),%ebx
801049f9:	84 c0                	test   %al,%al
801049fb:	74 37                	je     80104a34 <strncmp+0x54>
801049fd:	38 c3                	cmp    %al,%bl
801049ff:	75 33                	jne    80104a34 <strncmp+0x54>
80104a01:	01 f7                	add    %esi,%edi
80104a03:	eb 13                	jmp    80104a18 <strncmp+0x38>
80104a05:	8d 76 00             	lea    0x0(%esi),%esi
80104a08:	0f b6 01             	movzbl (%ecx),%eax
80104a0b:	84 c0                	test   %al,%al
80104a0d:	74 21                	je     80104a30 <strncmp+0x50>
80104a0f:	0f b6 1a             	movzbl (%edx),%ebx
80104a12:	89 d6                	mov    %edx,%esi
80104a14:	38 d8                	cmp    %bl,%al
80104a16:	75 1c                	jne    80104a34 <strncmp+0x54>
    n--, p++, q++;
80104a18:	8d 56 01             	lea    0x1(%esi),%edx
80104a1b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104a1e:	39 fa                	cmp    %edi,%edx
80104a20:	75 e6                	jne    80104a08 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104a22:	5b                   	pop    %ebx
    return 0;
80104a23:	31 c0                	xor    %eax,%eax
}
80104a25:	5e                   	pop    %esi
80104a26:	5f                   	pop    %edi
80104a27:	5d                   	pop    %ebp
80104a28:	c3                   	ret    
80104a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a30:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104a34:	29 d8                	sub    %ebx,%eax
}
80104a36:	5b                   	pop    %ebx
80104a37:	5e                   	pop    %esi
80104a38:	5f                   	pop    %edi
80104a39:	5d                   	pop    %ebp
80104a3a:	c3                   	ret    
80104a3b:	90                   	nop
80104a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	53                   	push   %ebx
80104a45:	8b 45 08             	mov    0x8(%ebp),%eax
80104a48:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104a4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104a4e:	89 c2                	mov    %eax,%edx
80104a50:	eb 19                	jmp    80104a6b <strncpy+0x2b>
80104a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a58:	83 c3 01             	add    $0x1,%ebx
80104a5b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104a5f:	83 c2 01             	add    $0x1,%edx
80104a62:	84 c9                	test   %cl,%cl
80104a64:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a67:	74 09                	je     80104a72 <strncpy+0x32>
80104a69:	89 f1                	mov    %esi,%ecx
80104a6b:	85 c9                	test   %ecx,%ecx
80104a6d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104a70:	7f e6                	jg     80104a58 <strncpy+0x18>
    ;
  while(n-- > 0)
80104a72:	31 c9                	xor    %ecx,%ecx
80104a74:	85 f6                	test   %esi,%esi
80104a76:	7e 17                	jle    80104a8f <strncpy+0x4f>
80104a78:	90                   	nop
80104a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104a80:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104a84:	89 f3                	mov    %esi,%ebx
80104a86:	83 c1 01             	add    $0x1,%ecx
80104a89:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104a8b:	85 db                	test   %ebx,%ebx
80104a8d:	7f f1                	jg     80104a80 <strncpy+0x40>
  return os;
}
80104a8f:	5b                   	pop    %ebx
80104a90:	5e                   	pop    %esi
80104a91:	5d                   	pop    %ebp
80104a92:	c3                   	ret    
80104a93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
80104aa5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104aa8:	8b 45 08             	mov    0x8(%ebp),%eax
80104aab:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104aae:	85 c9                	test   %ecx,%ecx
80104ab0:	7e 26                	jle    80104ad8 <safestrcpy+0x38>
80104ab2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104ab6:	89 c1                	mov    %eax,%ecx
80104ab8:	eb 17                	jmp    80104ad1 <safestrcpy+0x31>
80104aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ac0:	83 c2 01             	add    $0x1,%edx
80104ac3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104ac7:	83 c1 01             	add    $0x1,%ecx
80104aca:	84 db                	test   %bl,%bl
80104acc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104acf:	74 04                	je     80104ad5 <safestrcpy+0x35>
80104ad1:	39 f2                	cmp    %esi,%edx
80104ad3:	75 eb                	jne    80104ac0 <safestrcpy+0x20>
    ;
  *s = 0;
80104ad5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104ad8:	5b                   	pop    %ebx
80104ad9:	5e                   	pop    %esi
80104ada:	5d                   	pop    %ebp
80104adb:	c3                   	ret    
80104adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ae0 <strlen>:

int
strlen(const char *s)
{
80104ae0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ae1:	31 c0                	xor    %eax,%eax
{
80104ae3:	89 e5                	mov    %esp,%ebp
80104ae5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104ae8:	80 3a 00             	cmpb   $0x0,(%edx)
80104aeb:	74 0c                	je     80104af9 <strlen+0x19>
80104aed:	8d 76 00             	lea    0x0(%esi),%esi
80104af0:	83 c0 01             	add    $0x1,%eax
80104af3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104af7:	75 f7                	jne    80104af0 <strlen+0x10>
    ;
  return n;
}
80104af9:	5d                   	pop    %ebp
80104afa:	c3                   	ret    

80104afb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104afb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104aff:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104b03:	55                   	push   %ebp
  pushl %ebx
80104b04:	53                   	push   %ebx
  pushl %esi
80104b05:	56                   	push   %esi
  pushl %edi
80104b06:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104b07:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104b09:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104b0b:	5f                   	pop    %edi
  popl %esi
80104b0c:	5e                   	pop    %esi
  popl %ebx
80104b0d:	5b                   	pop    %ebx
  popl %ebp
80104b0e:	5d                   	pop    %ebp
  ret
80104b0f:	c3                   	ret    

80104b10 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	53                   	push   %ebx
80104b14:	83 ec 04             	sub    $0x4,%esp
80104b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104b1a:	e8 91 ed ff ff       	call   801038b0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b1f:	8b 00                	mov    (%eax),%eax
80104b21:	39 d8                	cmp    %ebx,%eax
80104b23:	76 1b                	jbe    80104b40 <fetchint+0x30>
80104b25:	8d 53 04             	lea    0x4(%ebx),%edx
80104b28:	39 d0                	cmp    %edx,%eax
80104b2a:	72 14                	jb     80104b40 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b2f:	8b 13                	mov    (%ebx),%edx
80104b31:	89 10                	mov    %edx,(%eax)
  return 0;
80104b33:	31 c0                	xor    %eax,%eax
}
80104b35:	83 c4 04             	add    $0x4,%esp
80104b38:	5b                   	pop    %ebx
80104b39:	5d                   	pop    %ebp
80104b3a:	c3                   	ret    
80104b3b:	90                   	nop
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b45:	eb ee                	jmp    80104b35 <fetchint+0x25>
80104b47:	89 f6                	mov    %esi,%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b50 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	53                   	push   %ebx
80104b54:	83 ec 04             	sub    $0x4,%esp
80104b57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104b5a:	e8 51 ed ff ff       	call   801038b0 <myproc>

  if(addr >= curproc->sz)
80104b5f:	39 18                	cmp    %ebx,(%eax)
80104b61:	76 29                	jbe    80104b8c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104b63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104b66:	89 da                	mov    %ebx,%edx
80104b68:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104b6a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104b6c:	39 c3                	cmp    %eax,%ebx
80104b6e:	73 1c                	jae    80104b8c <fetchstr+0x3c>
    if(*s == 0)
80104b70:	80 3b 00             	cmpb   $0x0,(%ebx)
80104b73:	75 10                	jne    80104b85 <fetchstr+0x35>
80104b75:	eb 39                	jmp    80104bb0 <fetchstr+0x60>
80104b77:	89 f6                	mov    %esi,%esi
80104b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b80:	80 3a 00             	cmpb   $0x0,(%edx)
80104b83:	74 1b                	je     80104ba0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104b85:	83 c2 01             	add    $0x1,%edx
80104b88:	39 d0                	cmp    %edx,%eax
80104b8a:	77 f4                	ja     80104b80 <fetchstr+0x30>
    return -1;
80104b8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104b91:	83 c4 04             	add    $0x4,%esp
80104b94:	5b                   	pop    %ebx
80104b95:	5d                   	pop    %ebp
80104b96:	c3                   	ret    
80104b97:	89 f6                	mov    %esi,%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ba0:	83 c4 04             	add    $0x4,%esp
80104ba3:	89 d0                	mov    %edx,%eax
80104ba5:	29 d8                	sub    %ebx,%eax
80104ba7:	5b                   	pop    %ebx
80104ba8:	5d                   	pop    %ebp
80104ba9:	c3                   	ret    
80104baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104bb0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104bb2:	eb dd                	jmp    80104b91 <fetchstr+0x41>
80104bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104bc0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	56                   	push   %esi
80104bc4:	53                   	push   %ebx
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104bc5:	e8 16 ed ff ff       	call   801038e0 <mythread>
80104bca:	8b 40 14             	mov    0x14(%eax),%eax
80104bcd:	8b 55 08             	mov    0x8(%ebp),%edx
80104bd0:	8b 40 44             	mov    0x44(%eax),%eax
80104bd3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104bd6:	e8 d5 ec ff ff       	call   801038b0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104bdb:	8b 00                	mov    (%eax),%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104bdd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104be0:	39 c6                	cmp    %eax,%esi
80104be2:	73 1c                	jae    80104c00 <argint+0x40>
80104be4:	8d 53 08             	lea    0x8(%ebx),%edx
80104be7:	39 d0                	cmp    %edx,%eax
80104be9:	72 15                	jb     80104c00 <argint+0x40>
  *ip = *(int*)(addr);
80104beb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bee:	8b 53 04             	mov    0x4(%ebx),%edx
80104bf1:	89 10                	mov    %edx,(%eax)
  return 0;
80104bf3:	31 c0                	xor    %eax,%eax
}
80104bf5:	5b                   	pop    %ebx
80104bf6:	5e                   	pop    %esi
80104bf7:	5d                   	pop    %ebp
80104bf8:	c3                   	ret    
80104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104c05:	eb ee                	jmp    80104bf5 <argint+0x35>
80104c07:	89 f6                	mov    %esi,%esi
80104c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	56                   	push   %esi
80104c14:	53                   	push   %ebx
80104c15:	83 ec 10             	sub    $0x10,%esp
80104c18:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104c1b:	e8 90 ec ff ff       	call   801038b0 <myproc>
80104c20:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104c22:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c25:	83 ec 08             	sub    $0x8,%esp
80104c28:	50                   	push   %eax
80104c29:	ff 75 08             	pushl  0x8(%ebp)
80104c2c:	e8 8f ff ff ff       	call   80104bc0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c31:	83 c4 10             	add    $0x10,%esp
80104c34:	85 c0                	test   %eax,%eax
80104c36:	78 28                	js     80104c60 <argptr+0x50>
80104c38:	85 db                	test   %ebx,%ebx
80104c3a:	78 24                	js     80104c60 <argptr+0x50>
80104c3c:	8b 16                	mov    (%esi),%edx
80104c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c41:	39 c2                	cmp    %eax,%edx
80104c43:	76 1b                	jbe    80104c60 <argptr+0x50>
80104c45:	01 c3                	add    %eax,%ebx
80104c47:	39 da                	cmp    %ebx,%edx
80104c49:	72 15                	jb     80104c60 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104c4b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c4e:	89 02                	mov    %eax,(%edx)
  return 0;
80104c50:	31 c0                	xor    %eax,%eax
}
80104c52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c55:	5b                   	pop    %ebx
80104c56:	5e                   	pop    %esi
80104c57:	5d                   	pop    %ebp
80104c58:	c3                   	ret    
80104c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c65:	eb eb                	jmp    80104c52 <argptr+0x42>
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104c76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c79:	50                   	push   %eax
80104c7a:	ff 75 08             	pushl  0x8(%ebp)
80104c7d:	e8 3e ff ff ff       	call   80104bc0 <argint>
80104c82:	83 c4 10             	add    $0x10,%esp
80104c85:	85 c0                	test   %eax,%eax
80104c87:	78 17                	js     80104ca0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104c89:	83 ec 08             	sub    $0x8,%esp
80104c8c:	ff 75 0c             	pushl  0xc(%ebp)
80104c8f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c92:	e8 b9 fe ff ff       	call   80104b50 <fetchstr>
80104c97:	83 c4 10             	add    $0x10,%esp
}
80104c9a:	c9                   	leave  
80104c9b:	c3                   	ret    
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ca5:	c9                   	leave  
80104ca6:	c3                   	ret    
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cb0 <syscall>:
[SYS_kthread_id]   sys_kthread_id,
};

void
syscall(void)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	56                   	push   %esi
80104cb4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104cb5:	e8 f6 eb ff ff       	call   801038b0 <myproc>
80104cba:	89 c6                	mov    %eax,%esi
  struct kthread *curthread = mythread();
80104cbc:	e8 1f ec ff ff       	call   801038e0 <mythread>
80104cc1:	89 c3                	mov    %eax,%ebx

  num = curthread->tf->eax;
80104cc3:	8b 40 14             	mov    0x14(%eax),%eax
80104cc6:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104cc9:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ccc:	83 fa 18             	cmp    $0x18,%edx
80104ccf:	77 1f                	ja     80104cf0 <syscall+0x40>
80104cd1:	8b 14 85 00 7b 10 80 	mov    -0x7fef8500(,%eax,4),%edx
80104cd8:	85 d2                	test   %edx,%edx
80104cda:	74 14                	je     80104cf0 <syscall+0x40>
    curthread->tf->eax = syscalls[num]();
80104cdc:	ff d2                	call   *%edx
80104cde:	8b 53 14             	mov    0x14(%ebx),%edx
80104ce1:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curthread->tf->eax = -1;
  }
}
80104ce4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ce7:	5b                   	pop    %ebx
80104ce8:	5e                   	pop    %esi
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    
80104ceb:	90                   	nop
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104cf0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104cf1:	8d 46 5c             	lea    0x5c(%esi),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104cf4:	50                   	push   %eax
80104cf5:	ff 76 10             	pushl  0x10(%esi)
80104cf8:	68 d7 7a 10 80       	push   $0x80107ad7
80104cfd:	e8 5e b9 ff ff       	call   80100660 <cprintf>
    curthread->tf->eax = -1;
80104d02:	8b 43 14             	mov    0x14(%ebx),%eax
80104d05:	83 c4 10             	add    $0x10,%esp
80104d08:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104d0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d12:	5b                   	pop    %ebx
80104d13:	5e                   	pop    %esi
80104d14:	5d                   	pop    %ebp
80104d15:	c3                   	ret    
80104d16:	66 90                	xchg   %ax,%ax
80104d18:	66 90                	xchg   %ax,%ax
80104d1a:	66 90                	xchg   %ax,%ax
80104d1c:	66 90                	xchg   %ax,%ax
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	57                   	push   %edi
80104d24:	56                   	push   %esi
80104d25:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d26:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104d29:	83 ec 44             	sub    $0x44,%esp
80104d2c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104d2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104d32:	56                   	push   %esi
80104d33:	50                   	push   %eax
{
80104d34:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104d37:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d3a:	e8 e1 d1 ff ff       	call   80101f20 <nameiparent>
80104d3f:	83 c4 10             	add    $0x10,%esp
80104d42:	85 c0                	test   %eax,%eax
80104d44:	0f 84 46 01 00 00    	je     80104e90 <create+0x170>
    return 0;
  ilock(dp);
80104d4a:	83 ec 0c             	sub    $0xc,%esp
80104d4d:	89 c3                	mov    %eax,%ebx
80104d4f:	50                   	push   %eax
80104d50:	e8 4b c9 ff ff       	call   801016a0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104d55:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104d58:	83 c4 0c             	add    $0xc,%esp
80104d5b:	50                   	push   %eax
80104d5c:	56                   	push   %esi
80104d5d:	53                   	push   %ebx
80104d5e:	e8 6d ce ff ff       	call   80101bd0 <dirlookup>
80104d63:	83 c4 10             	add    $0x10,%esp
80104d66:	85 c0                	test   %eax,%eax
80104d68:	89 c7                	mov    %eax,%edi
80104d6a:	74 34                	je     80104da0 <create+0x80>
    iunlockput(dp);
80104d6c:	83 ec 0c             	sub    $0xc,%esp
80104d6f:	53                   	push   %ebx
80104d70:	e8 bb cb ff ff       	call   80101930 <iunlockput>
    ilock(ip);
80104d75:	89 3c 24             	mov    %edi,(%esp)
80104d78:	e8 23 c9 ff ff       	call   801016a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104d7d:	83 c4 10             	add    $0x10,%esp
80104d80:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104d85:	0f 85 95 00 00 00    	jne    80104e20 <create+0x100>
80104d8b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104d90:	0f 85 8a 00 00 00    	jne    80104e20 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d99:	89 f8                	mov    %edi,%eax
80104d9b:	5b                   	pop    %ebx
80104d9c:	5e                   	pop    %esi
80104d9d:	5f                   	pop    %edi
80104d9e:	5d                   	pop    %ebp
80104d9f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104da0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104da4:	83 ec 08             	sub    $0x8,%esp
80104da7:	50                   	push   %eax
80104da8:	ff 33                	pushl  (%ebx)
80104daa:	e8 81 c7 ff ff       	call   80101530 <ialloc>
80104daf:	83 c4 10             	add    $0x10,%esp
80104db2:	85 c0                	test   %eax,%eax
80104db4:	89 c7                	mov    %eax,%edi
80104db6:	0f 84 e8 00 00 00    	je     80104ea4 <create+0x184>
  ilock(ip);
80104dbc:	83 ec 0c             	sub    $0xc,%esp
80104dbf:	50                   	push   %eax
80104dc0:	e8 db c8 ff ff       	call   801016a0 <ilock>
  ip->major = major;
80104dc5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104dc9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104dcd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104dd1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104dd5:	b8 01 00 00 00       	mov    $0x1,%eax
80104dda:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104dde:	89 3c 24             	mov    %edi,(%esp)
80104de1:	e8 0a c8 ff ff       	call   801015f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104de6:	83 c4 10             	add    $0x10,%esp
80104de9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104dee:	74 50                	je     80104e40 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104df0:	83 ec 04             	sub    $0x4,%esp
80104df3:	ff 77 04             	pushl  0x4(%edi)
80104df6:	56                   	push   %esi
80104df7:	53                   	push   %ebx
80104df8:	e8 43 d0 ff ff       	call   80101e40 <dirlink>
80104dfd:	83 c4 10             	add    $0x10,%esp
80104e00:	85 c0                	test   %eax,%eax
80104e02:	0f 88 8f 00 00 00    	js     80104e97 <create+0x177>
  iunlockput(dp);
80104e08:	83 ec 0c             	sub    $0xc,%esp
80104e0b:	53                   	push   %ebx
80104e0c:	e8 1f cb ff ff       	call   80101930 <iunlockput>
  return ip;
80104e11:	83 c4 10             	add    $0x10,%esp
}
80104e14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e17:	89 f8                	mov    %edi,%eax
80104e19:	5b                   	pop    %ebx
80104e1a:	5e                   	pop    %esi
80104e1b:	5f                   	pop    %edi
80104e1c:	5d                   	pop    %ebp
80104e1d:	c3                   	ret    
80104e1e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104e20:	83 ec 0c             	sub    $0xc,%esp
80104e23:	57                   	push   %edi
    return 0;
80104e24:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104e26:	e8 05 cb ff ff       	call   80101930 <iunlockput>
    return 0;
80104e2b:	83 c4 10             	add    $0x10,%esp
}
80104e2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e31:	89 f8                	mov    %edi,%eax
80104e33:	5b                   	pop    %ebx
80104e34:	5e                   	pop    %esi
80104e35:	5f                   	pop    %edi
80104e36:	5d                   	pop    %ebp
80104e37:	c3                   	ret    
80104e38:	90                   	nop
80104e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104e40:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104e45:	83 ec 0c             	sub    $0xc,%esp
80104e48:	53                   	push   %ebx
80104e49:	e8 a2 c7 ff ff       	call   801015f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e4e:	83 c4 0c             	add    $0xc,%esp
80104e51:	ff 77 04             	pushl  0x4(%edi)
80104e54:	68 84 7b 10 80       	push   $0x80107b84
80104e59:	57                   	push   %edi
80104e5a:	e8 e1 cf ff ff       	call   80101e40 <dirlink>
80104e5f:	83 c4 10             	add    $0x10,%esp
80104e62:	85 c0                	test   %eax,%eax
80104e64:	78 1c                	js     80104e82 <create+0x162>
80104e66:	83 ec 04             	sub    $0x4,%esp
80104e69:	ff 73 04             	pushl  0x4(%ebx)
80104e6c:	68 83 7b 10 80       	push   $0x80107b83
80104e71:	57                   	push   %edi
80104e72:	e8 c9 cf ff ff       	call   80101e40 <dirlink>
80104e77:	83 c4 10             	add    $0x10,%esp
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	0f 89 6e ff ff ff    	jns    80104df0 <create+0xd0>
      panic("create dots");
80104e82:	83 ec 0c             	sub    $0xc,%esp
80104e85:	68 77 7b 10 80       	push   $0x80107b77
80104e8a:	e8 01 b5 ff ff       	call   80100390 <panic>
80104e8f:	90                   	nop
    return 0;
80104e90:	31 ff                	xor    %edi,%edi
80104e92:	e9 ff fe ff ff       	jmp    80104d96 <create+0x76>
    panic("create: dirlink");
80104e97:	83 ec 0c             	sub    $0xc,%esp
80104e9a:	68 86 7b 10 80       	push   $0x80107b86
80104e9f:	e8 ec b4 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104ea4:	83 ec 0c             	sub    $0xc,%esp
80104ea7:	68 68 7b 10 80       	push   $0x80107b68
80104eac:	e8 df b4 ff ff       	call   80100390 <panic>
80104eb1:	eb 0d                	jmp    80104ec0 <argfd.constprop.0>
80104eb3:	90                   	nop
80104eb4:	90                   	nop
80104eb5:	90                   	nop
80104eb6:	90                   	nop
80104eb7:	90                   	nop
80104eb8:	90                   	nop
80104eb9:	90                   	nop
80104eba:	90                   	nop
80104ebb:	90                   	nop
80104ebc:	90                   	nop
80104ebd:	90                   	nop
80104ebe:	90                   	nop
80104ebf:	90                   	nop

80104ec0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	56                   	push   %esi
80104ec4:	53                   	push   %ebx
80104ec5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104ec7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104eca:	89 d6                	mov    %edx,%esi
80104ecc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104ecf:	50                   	push   %eax
80104ed0:	6a 00                	push   $0x0
80104ed2:	e8 e9 fc ff ff       	call   80104bc0 <argint>
80104ed7:	83 c4 10             	add    $0x10,%esp
80104eda:	85 c0                	test   %eax,%eax
80104edc:	78 2a                	js     80104f08 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104ede:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ee2:	77 24                	ja     80104f08 <argfd.constprop.0+0x48>
80104ee4:	e8 c7 e9 ff ff       	call   801038b0 <myproc>
80104ee9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104eec:	8b 44 90 1c          	mov    0x1c(%eax,%edx,4),%eax
80104ef0:	85 c0                	test   %eax,%eax
80104ef2:	74 14                	je     80104f08 <argfd.constprop.0+0x48>
  if(pfd)
80104ef4:	85 db                	test   %ebx,%ebx
80104ef6:	74 02                	je     80104efa <argfd.constprop.0+0x3a>
    *pfd = fd;
80104ef8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104efa:	89 06                	mov    %eax,(%esi)
  return 0;
80104efc:	31 c0                	xor    %eax,%eax
}
80104efe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f01:	5b                   	pop    %ebx
80104f02:	5e                   	pop    %esi
80104f03:	5d                   	pop    %ebp
80104f04:	c3                   	ret    
80104f05:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f0d:	eb ef                	jmp    80104efe <argfd.constprop.0+0x3e>
80104f0f:	90                   	nop

80104f10 <sys_dup>:
{
80104f10:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104f11:	31 c0                	xor    %eax,%eax
{
80104f13:	89 e5                	mov    %esp,%ebp
80104f15:	56                   	push   %esi
80104f16:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104f17:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104f1a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104f1d:	e8 9e ff ff ff       	call   80104ec0 <argfd.constprop.0>
80104f22:	85 c0                	test   %eax,%eax
80104f24:	78 42                	js     80104f68 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104f26:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104f29:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104f2b:	e8 80 e9 ff ff       	call   801038b0 <myproc>
80104f30:	eb 0e                	jmp    80104f40 <sys_dup+0x30>
80104f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104f38:	83 c3 01             	add    $0x1,%ebx
80104f3b:	83 fb 10             	cmp    $0x10,%ebx
80104f3e:	74 28                	je     80104f68 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104f40:	8b 54 98 1c          	mov    0x1c(%eax,%ebx,4),%edx
80104f44:	85 d2                	test   %edx,%edx
80104f46:	75 f0                	jne    80104f38 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104f48:	89 74 98 1c          	mov    %esi,0x1c(%eax,%ebx,4)
  filedup(f);
80104f4c:	83 ec 0c             	sub    $0xc,%esp
80104f4f:	ff 75 f4             	pushl  -0xc(%ebp)
80104f52:	e8 a9 be ff ff       	call   80100e00 <filedup>
  return fd;
80104f57:	83 c4 10             	add    $0x10,%esp
}
80104f5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f5d:	89 d8                	mov    %ebx,%eax
80104f5f:	5b                   	pop    %ebx
80104f60:	5e                   	pop    %esi
80104f61:	5d                   	pop    %ebp
80104f62:	c3                   	ret    
80104f63:	90                   	nop
80104f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f68:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f6b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f70:	89 d8                	mov    %ebx,%eax
80104f72:	5b                   	pop    %ebx
80104f73:	5e                   	pop    %esi
80104f74:	5d                   	pop    %ebp
80104f75:	c3                   	ret    
80104f76:	8d 76 00             	lea    0x0(%esi),%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <sys_read>:
{
80104f80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f81:	31 c0                	xor    %eax,%eax
{
80104f83:	89 e5                	mov    %esp,%ebp
80104f85:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f88:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f8b:	e8 30 ff ff ff       	call   80104ec0 <argfd.constprop.0>
80104f90:	85 c0                	test   %eax,%eax
80104f92:	78 4c                	js     80104fe0 <sys_read+0x60>
80104f94:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f97:	83 ec 08             	sub    $0x8,%esp
80104f9a:	50                   	push   %eax
80104f9b:	6a 02                	push   $0x2
80104f9d:	e8 1e fc ff ff       	call   80104bc0 <argint>
80104fa2:	83 c4 10             	add    $0x10,%esp
80104fa5:	85 c0                	test   %eax,%eax
80104fa7:	78 37                	js     80104fe0 <sys_read+0x60>
80104fa9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fac:	83 ec 04             	sub    $0x4,%esp
80104faf:	ff 75 f0             	pushl  -0x10(%ebp)
80104fb2:	50                   	push   %eax
80104fb3:	6a 01                	push   $0x1
80104fb5:	e8 56 fc ff ff       	call   80104c10 <argptr>
80104fba:	83 c4 10             	add    $0x10,%esp
80104fbd:	85 c0                	test   %eax,%eax
80104fbf:	78 1f                	js     80104fe0 <sys_read+0x60>
  return fileread(f, p, n);
80104fc1:	83 ec 04             	sub    $0x4,%esp
80104fc4:	ff 75 f0             	pushl  -0x10(%ebp)
80104fc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104fca:	ff 75 ec             	pushl  -0x14(%ebp)
80104fcd:	e8 9e bf ff ff       	call   80100f70 <fileread>
80104fd2:	83 c4 10             	add    $0x10,%esp
}
80104fd5:	c9                   	leave  
80104fd6:	c3                   	ret    
80104fd7:	89 f6                	mov    %esi,%esi
80104fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fe5:	c9                   	leave  
80104fe6:	c3                   	ret    
80104fe7:	89 f6                	mov    %esi,%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ff0 <sys_write>:
{
80104ff0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ff1:	31 c0                	xor    %eax,%eax
{
80104ff3:	89 e5                	mov    %esp,%ebp
80104ff5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ff8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ffb:	e8 c0 fe ff ff       	call   80104ec0 <argfd.constprop.0>
80105000:	85 c0                	test   %eax,%eax
80105002:	78 4c                	js     80105050 <sys_write+0x60>
80105004:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105007:	83 ec 08             	sub    $0x8,%esp
8010500a:	50                   	push   %eax
8010500b:	6a 02                	push   $0x2
8010500d:	e8 ae fb ff ff       	call   80104bc0 <argint>
80105012:	83 c4 10             	add    $0x10,%esp
80105015:	85 c0                	test   %eax,%eax
80105017:	78 37                	js     80105050 <sys_write+0x60>
80105019:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010501c:	83 ec 04             	sub    $0x4,%esp
8010501f:	ff 75 f0             	pushl  -0x10(%ebp)
80105022:	50                   	push   %eax
80105023:	6a 01                	push   $0x1
80105025:	e8 e6 fb ff ff       	call   80104c10 <argptr>
8010502a:	83 c4 10             	add    $0x10,%esp
8010502d:	85 c0                	test   %eax,%eax
8010502f:	78 1f                	js     80105050 <sys_write+0x60>
  return filewrite(f, p, n);
80105031:	83 ec 04             	sub    $0x4,%esp
80105034:	ff 75 f0             	pushl  -0x10(%ebp)
80105037:	ff 75 f4             	pushl  -0xc(%ebp)
8010503a:	ff 75 ec             	pushl  -0x14(%ebp)
8010503d:	e8 be bf ff ff       	call   80101000 <filewrite>
80105042:	83 c4 10             	add    $0x10,%esp
}
80105045:	c9                   	leave  
80105046:	c3                   	ret    
80105047:	89 f6                	mov    %esi,%esi
80105049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105055:	c9                   	leave  
80105056:	c3                   	ret    
80105057:	89 f6                	mov    %esi,%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105060 <sys_close>:
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105066:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105069:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010506c:	e8 4f fe ff ff       	call   80104ec0 <argfd.constprop.0>
80105071:	85 c0                	test   %eax,%eax
80105073:	78 2b                	js     801050a0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105075:	e8 36 e8 ff ff       	call   801038b0 <myproc>
8010507a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010507d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105080:	c7 44 90 1c 00 00 00 	movl   $0x0,0x1c(%eax,%edx,4)
80105087:	00 
  fileclose(f);
80105088:	ff 75 f4             	pushl  -0xc(%ebp)
8010508b:	e8 c0 bd ff ff       	call   80100e50 <fileclose>
  return 0;
80105090:	83 c4 10             	add    $0x10,%esp
80105093:	31 c0                	xor    %eax,%eax
}
80105095:	c9                   	leave  
80105096:	c3                   	ret    
80105097:	89 f6                	mov    %esi,%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801050a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050a5:	c9                   	leave  
801050a6:	c3                   	ret    
801050a7:	89 f6                	mov    %esi,%esi
801050a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050b0 <sys_fstat>:
{
801050b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801050b1:	31 c0                	xor    %eax,%eax
{
801050b3:	89 e5                	mov    %esp,%ebp
801050b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801050b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801050bb:	e8 00 fe ff ff       	call   80104ec0 <argfd.constprop.0>
801050c0:	85 c0                	test   %eax,%eax
801050c2:	78 2c                	js     801050f0 <sys_fstat+0x40>
801050c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050c7:	83 ec 04             	sub    $0x4,%esp
801050ca:	6a 14                	push   $0x14
801050cc:	50                   	push   %eax
801050cd:	6a 01                	push   $0x1
801050cf:	e8 3c fb ff ff       	call   80104c10 <argptr>
801050d4:	83 c4 10             	add    $0x10,%esp
801050d7:	85 c0                	test   %eax,%eax
801050d9:	78 15                	js     801050f0 <sys_fstat+0x40>
  return filestat(f, st);
801050db:	83 ec 08             	sub    $0x8,%esp
801050de:	ff 75 f4             	pushl  -0xc(%ebp)
801050e1:	ff 75 f0             	pushl  -0x10(%ebp)
801050e4:	e8 37 be ff ff       	call   80100f20 <filestat>
801050e9:	83 c4 10             	add    $0x10,%esp
}
801050ec:	c9                   	leave  
801050ed:	c3                   	ret    
801050ee:	66 90                	xchg   %ax,%ax
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050f5:	c9                   	leave  
801050f6:	c3                   	ret    
801050f7:	89 f6                	mov    %esi,%esi
801050f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105100 <sys_link>:
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	57                   	push   %edi
80105104:	56                   	push   %esi
80105105:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105106:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105109:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010510c:	50                   	push   %eax
8010510d:	6a 00                	push   $0x0
8010510f:	e8 5c fb ff ff       	call   80104c70 <argstr>
80105114:	83 c4 10             	add    $0x10,%esp
80105117:	85 c0                	test   %eax,%eax
80105119:	0f 88 fb 00 00 00    	js     8010521a <sys_link+0x11a>
8010511f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105122:	83 ec 08             	sub    $0x8,%esp
80105125:	50                   	push   %eax
80105126:	6a 01                	push   $0x1
80105128:	e8 43 fb ff ff       	call   80104c70 <argstr>
8010512d:	83 c4 10             	add    $0x10,%esp
80105130:	85 c0                	test   %eax,%eax
80105132:	0f 88 e2 00 00 00    	js     8010521a <sys_link+0x11a>
  begin_op();
80105138:	e8 83 da ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
8010513d:	83 ec 0c             	sub    $0xc,%esp
80105140:	ff 75 d4             	pushl  -0x2c(%ebp)
80105143:	e8 b8 cd ff ff       	call   80101f00 <namei>
80105148:	83 c4 10             	add    $0x10,%esp
8010514b:	85 c0                	test   %eax,%eax
8010514d:	89 c3                	mov    %eax,%ebx
8010514f:	0f 84 ea 00 00 00    	je     8010523f <sys_link+0x13f>
  ilock(ip);
80105155:	83 ec 0c             	sub    $0xc,%esp
80105158:	50                   	push   %eax
80105159:	e8 42 c5 ff ff       	call   801016a0 <ilock>
  if(ip->type == T_DIR){
8010515e:	83 c4 10             	add    $0x10,%esp
80105161:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105166:	0f 84 bb 00 00 00    	je     80105227 <sys_link+0x127>
  ip->nlink++;
8010516c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105171:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105174:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105177:	53                   	push   %ebx
80105178:	e8 73 c4 ff ff       	call   801015f0 <iupdate>
  iunlock(ip);
8010517d:	89 1c 24             	mov    %ebx,(%esp)
80105180:	e8 fb c5 ff ff       	call   80101780 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105185:	58                   	pop    %eax
80105186:	5a                   	pop    %edx
80105187:	57                   	push   %edi
80105188:	ff 75 d0             	pushl  -0x30(%ebp)
8010518b:	e8 90 cd ff ff       	call   80101f20 <nameiparent>
80105190:	83 c4 10             	add    $0x10,%esp
80105193:	85 c0                	test   %eax,%eax
80105195:	89 c6                	mov    %eax,%esi
80105197:	74 5b                	je     801051f4 <sys_link+0xf4>
  ilock(dp);
80105199:	83 ec 0c             	sub    $0xc,%esp
8010519c:	50                   	push   %eax
8010519d:	e8 fe c4 ff ff       	call   801016a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801051a2:	83 c4 10             	add    $0x10,%esp
801051a5:	8b 03                	mov    (%ebx),%eax
801051a7:	39 06                	cmp    %eax,(%esi)
801051a9:	75 3d                	jne    801051e8 <sys_link+0xe8>
801051ab:	83 ec 04             	sub    $0x4,%esp
801051ae:	ff 73 04             	pushl  0x4(%ebx)
801051b1:	57                   	push   %edi
801051b2:	56                   	push   %esi
801051b3:	e8 88 cc ff ff       	call   80101e40 <dirlink>
801051b8:	83 c4 10             	add    $0x10,%esp
801051bb:	85 c0                	test   %eax,%eax
801051bd:	78 29                	js     801051e8 <sys_link+0xe8>
  iunlockput(dp);
801051bf:	83 ec 0c             	sub    $0xc,%esp
801051c2:	56                   	push   %esi
801051c3:	e8 68 c7 ff ff       	call   80101930 <iunlockput>
  iput(ip);
801051c8:	89 1c 24             	mov    %ebx,(%esp)
801051cb:	e8 00 c6 ff ff       	call   801017d0 <iput>
  end_op();
801051d0:	e8 5b da ff ff       	call   80102c30 <end_op>
  return 0;
801051d5:	83 c4 10             	add    $0x10,%esp
801051d8:	31 c0                	xor    %eax,%eax
}
801051da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051dd:	5b                   	pop    %ebx
801051de:	5e                   	pop    %esi
801051df:	5f                   	pop    %edi
801051e0:	5d                   	pop    %ebp
801051e1:	c3                   	ret    
801051e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801051e8:	83 ec 0c             	sub    $0xc,%esp
801051eb:	56                   	push   %esi
801051ec:	e8 3f c7 ff ff       	call   80101930 <iunlockput>
    goto bad;
801051f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801051f4:	83 ec 0c             	sub    $0xc,%esp
801051f7:	53                   	push   %ebx
801051f8:	e8 a3 c4 ff ff       	call   801016a0 <ilock>
  ip->nlink--;
801051fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105202:	89 1c 24             	mov    %ebx,(%esp)
80105205:	e8 e6 c3 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
8010520a:	89 1c 24             	mov    %ebx,(%esp)
8010520d:	e8 1e c7 ff ff       	call   80101930 <iunlockput>
  end_op();
80105212:	e8 19 da ff ff       	call   80102c30 <end_op>
  return -1;
80105217:	83 c4 10             	add    $0x10,%esp
}
8010521a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010521d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105222:	5b                   	pop    %ebx
80105223:	5e                   	pop    %esi
80105224:	5f                   	pop    %edi
80105225:	5d                   	pop    %ebp
80105226:	c3                   	ret    
    iunlockput(ip);
80105227:	83 ec 0c             	sub    $0xc,%esp
8010522a:	53                   	push   %ebx
8010522b:	e8 00 c7 ff ff       	call   80101930 <iunlockput>
    end_op();
80105230:	e8 fb d9 ff ff       	call   80102c30 <end_op>
    return -1;
80105235:	83 c4 10             	add    $0x10,%esp
80105238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010523d:	eb 9b                	jmp    801051da <sys_link+0xda>
    end_op();
8010523f:	e8 ec d9 ff ff       	call   80102c30 <end_op>
    return -1;
80105244:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105249:	eb 8f                	jmp    801051da <sys_link+0xda>
8010524b:	90                   	nop
8010524c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105250 <sys_unlink>:
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	57                   	push   %edi
80105254:	56                   	push   %esi
80105255:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105256:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105259:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010525c:	50                   	push   %eax
8010525d:	6a 00                	push   $0x0
8010525f:	e8 0c fa ff ff       	call   80104c70 <argstr>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	0f 88 77 01 00 00    	js     801053e6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010526f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105272:	e8 49 d9 ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105277:	83 ec 08             	sub    $0x8,%esp
8010527a:	53                   	push   %ebx
8010527b:	ff 75 c0             	pushl  -0x40(%ebp)
8010527e:	e8 9d cc ff ff       	call   80101f20 <nameiparent>
80105283:	83 c4 10             	add    $0x10,%esp
80105286:	85 c0                	test   %eax,%eax
80105288:	89 c6                	mov    %eax,%esi
8010528a:	0f 84 60 01 00 00    	je     801053f0 <sys_unlink+0x1a0>
  ilock(dp);
80105290:	83 ec 0c             	sub    $0xc,%esp
80105293:	50                   	push   %eax
80105294:	e8 07 c4 ff ff       	call   801016a0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105299:	58                   	pop    %eax
8010529a:	5a                   	pop    %edx
8010529b:	68 84 7b 10 80       	push   $0x80107b84
801052a0:	53                   	push   %ebx
801052a1:	e8 0a c9 ff ff       	call   80101bb0 <namecmp>
801052a6:	83 c4 10             	add    $0x10,%esp
801052a9:	85 c0                	test   %eax,%eax
801052ab:	0f 84 03 01 00 00    	je     801053b4 <sys_unlink+0x164>
801052b1:	83 ec 08             	sub    $0x8,%esp
801052b4:	68 83 7b 10 80       	push   $0x80107b83
801052b9:	53                   	push   %ebx
801052ba:	e8 f1 c8 ff ff       	call   80101bb0 <namecmp>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	0f 84 ea 00 00 00    	je     801053b4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801052ca:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801052cd:	83 ec 04             	sub    $0x4,%esp
801052d0:	50                   	push   %eax
801052d1:	53                   	push   %ebx
801052d2:	56                   	push   %esi
801052d3:	e8 f8 c8 ff ff       	call   80101bd0 <dirlookup>
801052d8:	83 c4 10             	add    $0x10,%esp
801052db:	85 c0                	test   %eax,%eax
801052dd:	89 c3                	mov    %eax,%ebx
801052df:	0f 84 cf 00 00 00    	je     801053b4 <sys_unlink+0x164>
  ilock(ip);
801052e5:	83 ec 0c             	sub    $0xc,%esp
801052e8:	50                   	push   %eax
801052e9:	e8 b2 c3 ff ff       	call   801016a0 <ilock>
  if(ip->nlink < 1)
801052ee:	83 c4 10             	add    $0x10,%esp
801052f1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801052f6:	0f 8e 10 01 00 00    	jle    8010540c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801052fc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105301:	74 6d                	je     80105370 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105303:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105306:	83 ec 04             	sub    $0x4,%esp
80105309:	6a 10                	push   $0x10
8010530b:	6a 00                	push   $0x0
8010530d:	50                   	push   %eax
8010530e:	e8 ad f5 ff ff       	call   801048c0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105313:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105316:	6a 10                	push   $0x10
80105318:	ff 75 c4             	pushl  -0x3c(%ebp)
8010531b:	50                   	push   %eax
8010531c:	56                   	push   %esi
8010531d:	e8 5e c7 ff ff       	call   80101a80 <writei>
80105322:	83 c4 20             	add    $0x20,%esp
80105325:	83 f8 10             	cmp    $0x10,%eax
80105328:	0f 85 eb 00 00 00    	jne    80105419 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010532e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105333:	0f 84 97 00 00 00    	je     801053d0 <sys_unlink+0x180>
  iunlockput(dp);
80105339:	83 ec 0c             	sub    $0xc,%esp
8010533c:	56                   	push   %esi
8010533d:	e8 ee c5 ff ff       	call   80101930 <iunlockput>
  ip->nlink--;
80105342:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105347:	89 1c 24             	mov    %ebx,(%esp)
8010534a:	e8 a1 c2 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
8010534f:	89 1c 24             	mov    %ebx,(%esp)
80105352:	e8 d9 c5 ff ff       	call   80101930 <iunlockput>
  end_op();
80105357:	e8 d4 d8 ff ff       	call   80102c30 <end_op>
  return 0;
8010535c:	83 c4 10             	add    $0x10,%esp
8010535f:	31 c0                	xor    %eax,%eax
}
80105361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105364:	5b                   	pop    %ebx
80105365:	5e                   	pop    %esi
80105366:	5f                   	pop    %edi
80105367:	5d                   	pop    %ebp
80105368:	c3                   	ret    
80105369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105370:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105374:	76 8d                	jbe    80105303 <sys_unlink+0xb3>
80105376:	bf 20 00 00 00       	mov    $0x20,%edi
8010537b:	eb 0f                	jmp    8010538c <sys_unlink+0x13c>
8010537d:	8d 76 00             	lea    0x0(%esi),%esi
80105380:	83 c7 10             	add    $0x10,%edi
80105383:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105386:	0f 83 77 ff ff ff    	jae    80105303 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010538c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010538f:	6a 10                	push   $0x10
80105391:	57                   	push   %edi
80105392:	50                   	push   %eax
80105393:	53                   	push   %ebx
80105394:	e8 e7 c5 ff ff       	call   80101980 <readi>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	83 f8 10             	cmp    $0x10,%eax
8010539f:	75 5e                	jne    801053ff <sys_unlink+0x1af>
    if(de.inum != 0)
801053a1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801053a6:	74 d8                	je     80105380 <sys_unlink+0x130>
    iunlockput(ip);
801053a8:	83 ec 0c             	sub    $0xc,%esp
801053ab:	53                   	push   %ebx
801053ac:	e8 7f c5 ff ff       	call   80101930 <iunlockput>
    goto bad;
801053b1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801053b4:	83 ec 0c             	sub    $0xc,%esp
801053b7:	56                   	push   %esi
801053b8:	e8 73 c5 ff ff       	call   80101930 <iunlockput>
  end_op();
801053bd:	e8 6e d8 ff ff       	call   80102c30 <end_op>
  return -1;
801053c2:	83 c4 10             	add    $0x10,%esp
801053c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ca:	eb 95                	jmp    80105361 <sys_unlink+0x111>
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801053d0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801053d5:	83 ec 0c             	sub    $0xc,%esp
801053d8:	56                   	push   %esi
801053d9:	e8 12 c2 ff ff       	call   801015f0 <iupdate>
801053de:	83 c4 10             	add    $0x10,%esp
801053e1:	e9 53 ff ff ff       	jmp    80105339 <sys_unlink+0xe9>
    return -1;
801053e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053eb:	e9 71 ff ff ff       	jmp    80105361 <sys_unlink+0x111>
    end_op();
801053f0:	e8 3b d8 ff ff       	call   80102c30 <end_op>
    return -1;
801053f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053fa:	e9 62 ff ff ff       	jmp    80105361 <sys_unlink+0x111>
      panic("isdirempty: readi");
801053ff:	83 ec 0c             	sub    $0xc,%esp
80105402:	68 a8 7b 10 80       	push   $0x80107ba8
80105407:	e8 84 af ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010540c:	83 ec 0c             	sub    $0xc,%esp
8010540f:	68 96 7b 10 80       	push   $0x80107b96
80105414:	e8 77 af ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105419:	83 ec 0c             	sub    $0xc,%esp
8010541c:	68 ba 7b 10 80       	push   $0x80107bba
80105421:	e8 6a af ff ff       	call   80100390 <panic>
80105426:	8d 76 00             	lea    0x0(%esi),%esi
80105429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105430 <sys_open>:

int
sys_open(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105436:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105439:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010543c:	50                   	push   %eax
8010543d:	6a 00                	push   $0x0
8010543f:	e8 2c f8 ff ff       	call   80104c70 <argstr>
80105444:	83 c4 10             	add    $0x10,%esp
80105447:	85 c0                	test   %eax,%eax
80105449:	0f 88 1d 01 00 00    	js     8010556c <sys_open+0x13c>
8010544f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105452:	83 ec 08             	sub    $0x8,%esp
80105455:	50                   	push   %eax
80105456:	6a 01                	push   $0x1
80105458:	e8 63 f7 ff ff       	call   80104bc0 <argint>
8010545d:	83 c4 10             	add    $0x10,%esp
80105460:	85 c0                	test   %eax,%eax
80105462:	0f 88 04 01 00 00    	js     8010556c <sys_open+0x13c>
    return -1;

  begin_op();
80105468:	e8 53 d7 ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
8010546d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105471:	0f 85 a9 00 00 00    	jne    80105520 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105477:	83 ec 0c             	sub    $0xc,%esp
8010547a:	ff 75 e0             	pushl  -0x20(%ebp)
8010547d:	e8 7e ca ff ff       	call   80101f00 <namei>
80105482:	83 c4 10             	add    $0x10,%esp
80105485:	85 c0                	test   %eax,%eax
80105487:	89 c6                	mov    %eax,%esi
80105489:	0f 84 b2 00 00 00    	je     80105541 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010548f:	83 ec 0c             	sub    $0xc,%esp
80105492:	50                   	push   %eax
80105493:	e8 08 c2 ff ff       	call   801016a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105498:	83 c4 10             	add    $0x10,%esp
8010549b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801054a0:	0f 84 aa 00 00 00    	je     80105550 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801054a6:	e8 e5 b8 ff ff       	call   80100d90 <filealloc>
801054ab:	85 c0                	test   %eax,%eax
801054ad:	89 c7                	mov    %eax,%edi
801054af:	0f 84 a6 00 00 00    	je     8010555b <sys_open+0x12b>
  struct proc *curproc = myproc();
801054b5:	e8 f6 e3 ff ff       	call   801038b0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801054ba:	31 db                	xor    %ebx,%ebx
801054bc:	eb 0e                	jmp    801054cc <sys_open+0x9c>
801054be:	66 90                	xchg   %ax,%ax
801054c0:	83 c3 01             	add    $0x1,%ebx
801054c3:	83 fb 10             	cmp    $0x10,%ebx
801054c6:	0f 84 ac 00 00 00    	je     80105578 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801054cc:	8b 54 98 1c          	mov    0x1c(%eax,%ebx,4),%edx
801054d0:	85 d2                	test   %edx,%edx
801054d2:	75 ec                	jne    801054c0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054d4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801054d7:	89 7c 98 1c          	mov    %edi,0x1c(%eax,%ebx,4)
  iunlock(ip);
801054db:	56                   	push   %esi
801054dc:	e8 9f c2 ff ff       	call   80101780 <iunlock>
  end_op();
801054e1:	e8 4a d7 ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
801054e6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054ef:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801054f2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801054f5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801054fc:	89 d0                	mov    %edx,%eax
801054fe:	f7 d0                	not    %eax
80105500:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105503:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105506:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105509:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010550d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105510:	89 d8                	mov    %ebx,%eax
80105512:	5b                   	pop    %ebx
80105513:	5e                   	pop    %esi
80105514:	5f                   	pop    %edi
80105515:	5d                   	pop    %ebp
80105516:	c3                   	ret    
80105517:	89 f6                	mov    %esi,%esi
80105519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105526:	31 c9                	xor    %ecx,%ecx
80105528:	6a 00                	push   $0x0
8010552a:	ba 02 00 00 00       	mov    $0x2,%edx
8010552f:	e8 ec f7 ff ff       	call   80104d20 <create>
    if(ip == 0){
80105534:	83 c4 10             	add    $0x10,%esp
80105537:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105539:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010553b:	0f 85 65 ff ff ff    	jne    801054a6 <sys_open+0x76>
      end_op();
80105541:	e8 ea d6 ff ff       	call   80102c30 <end_op>
      return -1;
80105546:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010554b:	eb c0                	jmp    8010550d <sys_open+0xdd>
8010554d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105550:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105553:	85 c9                	test   %ecx,%ecx
80105555:	0f 84 4b ff ff ff    	je     801054a6 <sys_open+0x76>
    iunlockput(ip);
8010555b:	83 ec 0c             	sub    $0xc,%esp
8010555e:	56                   	push   %esi
8010555f:	e8 cc c3 ff ff       	call   80101930 <iunlockput>
    end_op();
80105564:	e8 c7 d6 ff ff       	call   80102c30 <end_op>
    return -1;
80105569:	83 c4 10             	add    $0x10,%esp
8010556c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105571:	eb 9a                	jmp    8010550d <sys_open+0xdd>
80105573:	90                   	nop
80105574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105578:	83 ec 0c             	sub    $0xc,%esp
8010557b:	57                   	push   %edi
8010557c:	e8 cf b8 ff ff       	call   80100e50 <fileclose>
80105581:	83 c4 10             	add    $0x10,%esp
80105584:	eb d5                	jmp    8010555b <sys_open+0x12b>
80105586:	8d 76 00             	lea    0x0(%esi),%esi
80105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105590 <sys_mkdir>:

int
sys_mkdir(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105596:	e8 25 d6 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010559b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010559e:	83 ec 08             	sub    $0x8,%esp
801055a1:	50                   	push   %eax
801055a2:	6a 00                	push   $0x0
801055a4:	e8 c7 f6 ff ff       	call   80104c70 <argstr>
801055a9:	83 c4 10             	add    $0x10,%esp
801055ac:	85 c0                	test   %eax,%eax
801055ae:	78 30                	js     801055e0 <sys_mkdir+0x50>
801055b0:	83 ec 0c             	sub    $0xc,%esp
801055b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055b6:	31 c9                	xor    %ecx,%ecx
801055b8:	6a 00                	push   $0x0
801055ba:	ba 01 00 00 00       	mov    $0x1,%edx
801055bf:	e8 5c f7 ff ff       	call   80104d20 <create>
801055c4:	83 c4 10             	add    $0x10,%esp
801055c7:	85 c0                	test   %eax,%eax
801055c9:	74 15                	je     801055e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801055cb:	83 ec 0c             	sub    $0xc,%esp
801055ce:	50                   	push   %eax
801055cf:	e8 5c c3 ff ff       	call   80101930 <iunlockput>
  end_op();
801055d4:	e8 57 d6 ff ff       	call   80102c30 <end_op>
  return 0;
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	31 c0                	xor    %eax,%eax
}
801055de:	c9                   	leave  
801055df:	c3                   	ret    
    end_op();
801055e0:	e8 4b d6 ff ff       	call   80102c30 <end_op>
    return -1;
801055e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055ea:	c9                   	leave  
801055eb:	c3                   	ret    
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055f0 <sys_mknod>:

int
sys_mknod(void)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801055f6:	e8 c5 d5 ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801055fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801055fe:	83 ec 08             	sub    $0x8,%esp
80105601:	50                   	push   %eax
80105602:	6a 00                	push   $0x0
80105604:	e8 67 f6 ff ff       	call   80104c70 <argstr>
80105609:	83 c4 10             	add    $0x10,%esp
8010560c:	85 c0                	test   %eax,%eax
8010560e:	78 60                	js     80105670 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105610:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105613:	83 ec 08             	sub    $0x8,%esp
80105616:	50                   	push   %eax
80105617:	6a 01                	push   $0x1
80105619:	e8 a2 f5 ff ff       	call   80104bc0 <argint>
  if((argstr(0, &path)) < 0 ||
8010561e:	83 c4 10             	add    $0x10,%esp
80105621:	85 c0                	test   %eax,%eax
80105623:	78 4b                	js     80105670 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105625:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105628:	83 ec 08             	sub    $0x8,%esp
8010562b:	50                   	push   %eax
8010562c:	6a 02                	push   $0x2
8010562e:	e8 8d f5 ff ff       	call   80104bc0 <argint>
     argint(1, &major) < 0 ||
80105633:	83 c4 10             	add    $0x10,%esp
80105636:	85 c0                	test   %eax,%eax
80105638:	78 36                	js     80105670 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010563a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010563e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105641:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105645:	ba 03 00 00 00       	mov    $0x3,%edx
8010564a:	50                   	push   %eax
8010564b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010564e:	e8 cd f6 ff ff       	call   80104d20 <create>
80105653:	83 c4 10             	add    $0x10,%esp
80105656:	85 c0                	test   %eax,%eax
80105658:	74 16                	je     80105670 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010565a:	83 ec 0c             	sub    $0xc,%esp
8010565d:	50                   	push   %eax
8010565e:	e8 cd c2 ff ff       	call   80101930 <iunlockput>
  end_op();
80105663:	e8 c8 d5 ff ff       	call   80102c30 <end_op>
  return 0;
80105668:	83 c4 10             	add    $0x10,%esp
8010566b:	31 c0                	xor    %eax,%eax
}
8010566d:	c9                   	leave  
8010566e:	c3                   	ret    
8010566f:	90                   	nop
    end_op();
80105670:	e8 bb d5 ff ff       	call   80102c30 <end_op>
    return -1;
80105675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010567a:	c9                   	leave  
8010567b:	c3                   	ret    
8010567c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105680 <sys_chdir>:

int
sys_chdir(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	56                   	push   %esi
80105684:	53                   	push   %ebx
80105685:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  //struct proc *curproc = myproc();
  struct kthread *curthread = mythread();
80105688:	e8 53 e2 ff ff       	call   801038e0 <mythread>
8010568d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010568f:	e8 2c d5 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105694:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105697:	83 ec 08             	sub    $0x8,%esp
8010569a:	50                   	push   %eax
8010569b:	6a 00                	push   $0x0
8010569d:	e8 ce f5 ff ff       	call   80104c70 <argstr>
801056a2:	83 c4 10             	add    $0x10,%esp
801056a5:	85 c0                	test   %eax,%eax
801056a7:	78 77                	js     80105720 <sys_chdir+0xa0>
801056a9:	83 ec 0c             	sub    $0xc,%esp
801056ac:	ff 75 f4             	pushl  -0xc(%ebp)
801056af:	e8 4c c8 ff ff       	call   80101f00 <namei>
801056b4:	83 c4 10             	add    $0x10,%esp
801056b7:	85 c0                	test   %eax,%eax
801056b9:	89 c3                	mov    %eax,%ebx
801056bb:	74 63                	je     80105720 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801056bd:	83 ec 0c             	sub    $0xc,%esp
801056c0:	50                   	push   %eax
801056c1:	e8 da bf ff ff       	call   801016a0 <ilock>
  if(ip->type != T_DIR){
801056c6:	83 c4 10             	add    $0x10,%esp
801056c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056ce:	75 30                	jne    80105700 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801056d0:	83 ec 0c             	sub    $0xc,%esp
801056d3:	53                   	push   %ebx
801056d4:	e8 a7 c0 ff ff       	call   80101780 <iunlock>
  iput(curthread->cwd);
801056d9:	58                   	pop    %eax
801056da:	ff 76 24             	pushl  0x24(%esi)
801056dd:	e8 ee c0 ff ff       	call   801017d0 <iput>
  end_op();
801056e2:	e8 49 d5 ff ff       	call   80102c30 <end_op>
  curthread->cwd = ip;
801056e7:	89 5e 24             	mov    %ebx,0x24(%esi)
  return 0;
801056ea:	83 c4 10             	add    $0x10,%esp
801056ed:	31 c0                	xor    %eax,%eax
}
801056ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056f2:	5b                   	pop    %ebx
801056f3:	5e                   	pop    %esi
801056f4:	5d                   	pop    %ebp
801056f5:	c3                   	ret    
801056f6:	8d 76 00             	lea    0x0(%esi),%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	53                   	push   %ebx
80105704:	e8 27 c2 ff ff       	call   80101930 <iunlockput>
    end_op();
80105709:	e8 22 d5 ff ff       	call   80102c30 <end_op>
    return -1;
8010570e:	83 c4 10             	add    $0x10,%esp
80105711:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105716:	eb d7                	jmp    801056ef <sys_chdir+0x6f>
80105718:	90                   	nop
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105720:	e8 0b d5 ff ff       	call   80102c30 <end_op>
    return -1;
80105725:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010572a:	eb c3                	jmp    801056ef <sys_chdir+0x6f>
8010572c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105730 <sys_exec>:

int
sys_exec(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	57                   	push   %edi
80105734:	56                   	push   %esi
80105735:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105736:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010573c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105742:	50                   	push   %eax
80105743:	6a 00                	push   $0x0
80105745:	e8 26 f5 ff ff       	call   80104c70 <argstr>
8010574a:	83 c4 10             	add    $0x10,%esp
8010574d:	85 c0                	test   %eax,%eax
8010574f:	0f 88 87 00 00 00    	js     801057dc <sys_exec+0xac>
80105755:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010575b:	83 ec 08             	sub    $0x8,%esp
8010575e:	50                   	push   %eax
8010575f:	6a 01                	push   $0x1
80105761:	e8 5a f4 ff ff       	call   80104bc0 <argint>
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	85 c0                	test   %eax,%eax
8010576b:	78 6f                	js     801057dc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010576d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105773:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105776:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105778:	68 80 00 00 00       	push   $0x80
8010577d:	6a 00                	push   $0x0
8010577f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105785:	50                   	push   %eax
80105786:	e8 35 f1 ff ff       	call   801048c0 <memset>
8010578b:	83 c4 10             	add    $0x10,%esp
8010578e:	eb 2c                	jmp    801057bc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105790:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105796:	85 c0                	test   %eax,%eax
80105798:	74 56                	je     801057f0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010579a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801057a0:	83 ec 08             	sub    $0x8,%esp
801057a3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801057a6:	52                   	push   %edx
801057a7:	50                   	push   %eax
801057a8:	e8 a3 f3 ff ff       	call   80104b50 <fetchstr>
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	85 c0                	test   %eax,%eax
801057b2:	78 28                	js     801057dc <sys_exec+0xac>
  for(i=0;; i++){
801057b4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801057b7:	83 fb 20             	cmp    $0x20,%ebx
801057ba:	74 20                	je     801057dc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801057bc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801057c2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801057c9:	83 ec 08             	sub    $0x8,%esp
801057cc:	57                   	push   %edi
801057cd:	01 f0                	add    %esi,%eax
801057cf:	50                   	push   %eax
801057d0:	e8 3b f3 ff ff       	call   80104b10 <fetchint>
801057d5:	83 c4 10             	add    $0x10,%esp
801057d8:	85 c0                	test   %eax,%eax
801057da:	79 b4                	jns    80105790 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801057dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801057df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057e4:	5b                   	pop    %ebx
801057e5:	5e                   	pop    %esi
801057e6:	5f                   	pop    %edi
801057e7:	5d                   	pop    %ebp
801057e8:	c3                   	ret    
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801057f0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801057f6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801057f9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105800:	00 00 00 00 
  return exec(path, argv);
80105804:	50                   	push   %eax
80105805:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010580b:	e8 00 b2 ff ff       	call   80100a10 <exec>
80105810:	83 c4 10             	add    $0x10,%esp
}
80105813:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105816:	5b                   	pop    %ebx
80105817:	5e                   	pop    %esi
80105818:	5f                   	pop    %edi
80105819:	5d                   	pop    %ebp
8010581a:	c3                   	ret    
8010581b:	90                   	nop
8010581c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105820 <sys_pipe>:

int
sys_pipe(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	57                   	push   %edi
80105824:	56                   	push   %esi
80105825:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105826:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105829:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010582c:	6a 08                	push   $0x8
8010582e:	50                   	push   %eax
8010582f:	6a 00                	push   $0x0
80105831:	e8 da f3 ff ff       	call   80104c10 <argptr>
80105836:	83 c4 10             	add    $0x10,%esp
80105839:	85 c0                	test   %eax,%eax
8010583b:	0f 88 ae 00 00 00    	js     801058ef <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105841:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105844:	83 ec 08             	sub    $0x8,%esp
80105847:	50                   	push   %eax
80105848:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010584b:	50                   	push   %eax
8010584c:	e8 0f da ff ff       	call   80103260 <pipealloc>
80105851:	83 c4 10             	add    $0x10,%esp
80105854:	85 c0                	test   %eax,%eax
80105856:	0f 88 93 00 00 00    	js     801058ef <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010585c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010585f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105861:	e8 4a e0 ff ff       	call   801038b0 <myproc>
80105866:	eb 10                	jmp    80105878 <sys_pipe+0x58>
80105868:	90                   	nop
80105869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105870:	83 c3 01             	add    $0x1,%ebx
80105873:	83 fb 10             	cmp    $0x10,%ebx
80105876:	74 60                	je     801058d8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105878:	8b 74 98 1c          	mov    0x1c(%eax,%ebx,4),%esi
8010587c:	85 f6                	test   %esi,%esi
8010587e:	75 f0                	jne    80105870 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105880:	8d 73 04             	lea    0x4(%ebx),%esi
80105883:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105887:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010588a:	e8 21 e0 ff ff       	call   801038b0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010588f:	31 d2                	xor    %edx,%edx
80105891:	eb 0d                	jmp    801058a0 <sys_pipe+0x80>
80105893:	90                   	nop
80105894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105898:	83 c2 01             	add    $0x1,%edx
8010589b:	83 fa 10             	cmp    $0x10,%edx
8010589e:	74 28                	je     801058c8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801058a0:	8b 4c 90 1c          	mov    0x1c(%eax,%edx,4),%ecx
801058a4:	85 c9                	test   %ecx,%ecx
801058a6:	75 f0                	jne    80105898 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801058a8:	89 7c 90 1c          	mov    %edi,0x1c(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801058ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
801058af:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801058b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801058b4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801058b7:	31 c0                	xor    %eax,%eax
}
801058b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058bc:	5b                   	pop    %ebx
801058bd:	5e                   	pop    %esi
801058be:	5f                   	pop    %edi
801058bf:	5d                   	pop    %ebp
801058c0:	c3                   	ret    
801058c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801058c8:	e8 e3 df ff ff       	call   801038b0 <myproc>
801058cd:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
801058d4:	00 
801058d5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801058d8:	83 ec 0c             	sub    $0xc,%esp
801058db:	ff 75 e0             	pushl  -0x20(%ebp)
801058de:	e8 6d b5 ff ff       	call   80100e50 <fileclose>
    fileclose(wf);
801058e3:	58                   	pop    %eax
801058e4:	ff 75 e4             	pushl  -0x1c(%ebp)
801058e7:	e8 64 b5 ff ff       	call   80100e50 <fileclose>
    return -1;
801058ec:	83 c4 10             	add    $0x10,%esp
801058ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f4:	eb c3                	jmp    801058b9 <sys_pipe+0x99>
801058f6:	66 90                	xchg   %ax,%ax
801058f8:	66 90                	xchg   %ax,%ax
801058fa:	66 90                	xchg   %ax,%ax
801058fc:	66 90                	xchg   %ax,%ax
801058fe:	66 90                	xchg   %ax,%ax

80105900 <sys_fork>:
#include "proc.h"
#include "kthread.h"

int
sys_fork(void)
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105903:	5d                   	pop    %ebp
  return fork();
80105904:	e9 b7 e1 ff ff       	jmp    80103ac0 <fork>
80105909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105910 <sys_exit>:

int
sys_exit(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	83 ec 08             	sub    $0x8,%esp
  exit();
80105916:	e8 a5 e4 ff ff       	call   80103dc0 <exit>
  return 0;  // not reached
}
8010591b:	31 c0                	xor    %eax,%eax
8010591d:	c9                   	leave  
8010591e:	c3                   	ret    
8010591f:	90                   	nop

80105920 <sys_wait>:

int
sys_wait(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105923:	5d                   	pop    %ebp
  return wait();
80105924:	e9 d7 e6 ff ff       	jmp    80104000 <wait>
80105929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105930 <sys_kill>:

int
sys_kill(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105936:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105939:	50                   	push   %eax
8010593a:	6a 00                	push   $0x0
8010593c:	e8 7f f2 ff ff       	call   80104bc0 <argint>
80105941:	83 c4 10             	add    $0x10,%esp
80105944:	85 c0                	test   %eax,%eax
80105946:	78 18                	js     80105960 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105948:	83 ec 0c             	sub    $0xc,%esp
8010594b:	ff 75 f4             	pushl  -0xc(%ebp)
8010594e:	e8 5d e8 ff ff       	call   801041b0 <kill>
80105953:	83 c4 10             	add    $0x10,%esp
}
80105956:	c9                   	leave  
80105957:	c3                   	ret    
80105958:	90                   	nop
80105959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105965:	c9                   	leave  
80105966:	c3                   	ret    
80105967:	89 f6                	mov    %esi,%esi
80105969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105970 <sys_getpid>:

int
sys_getpid(void)
{
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105976:	e8 35 df ff ff       	call   801038b0 <myproc>
8010597b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010597e:	c9                   	leave  
8010597f:	c3                   	ret    

80105980 <sys_sbrk>:

int
sys_sbrk(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105984:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105987:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010598a:	50                   	push   %eax
8010598b:	6a 00                	push   $0x0
8010598d:	e8 2e f2 ff ff       	call   80104bc0 <argint>
80105992:	83 c4 10             	add    $0x10,%esp
80105995:	85 c0                	test   %eax,%eax
80105997:	78 27                	js     801059c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105999:	e8 12 df ff ff       	call   801038b0 <myproc>
  if(growproc(n) < 0)
8010599e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801059a1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801059a3:	ff 75 f4             	pushl  -0xc(%ebp)
801059a6:	e8 65 e0 ff ff       	call   80103a10 <growproc>
801059ab:	83 c4 10             	add    $0x10,%esp
801059ae:	85 c0                	test   %eax,%eax
801059b0:	78 0e                	js     801059c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801059b2:	89 d8                	mov    %ebx,%eax
801059b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059b7:	c9                   	leave  
801059b8:	c3                   	ret    
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801059c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059c5:	eb eb                	jmp    801059b2 <sys_sbrk+0x32>
801059c7:	89 f6                	mov    %esi,%esi
801059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059d0 <sys_sleep>:

int
sys_sleep(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801059d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801059da:	50                   	push   %eax
801059db:	6a 00                	push   $0x0
801059dd:	e8 de f1 ff ff       	call   80104bc0 <argint>
801059e2:	83 c4 10             	add    $0x10,%esp
801059e5:	85 c0                	test   %eax,%eax
801059e7:	0f 88 8a 00 00 00    	js     80105a77 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801059ed:	83 ec 0c             	sub    $0xc,%esp
801059f0:	68 80 e9 11 80       	push   $0x8011e980
801059f5:	e8 b6 ed ff ff       	call   801047b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801059fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059fd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105a00:	8b 1d c0 f1 11 80    	mov    0x8011f1c0,%ebx
  while(ticks - ticks0 < n){
80105a06:	85 d2                	test   %edx,%edx
80105a08:	75 27                	jne    80105a31 <sys_sleep+0x61>
80105a0a:	eb 54                	jmp    80105a60 <sys_sleep+0x90>
80105a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105a10:	83 ec 08             	sub    $0x8,%esp
80105a13:	68 80 e9 11 80       	push   $0x8011e980
80105a18:	68 c0 f1 11 80       	push   $0x8011f1c0
80105a1d:	e8 1e e5 ff ff       	call   80103f40 <sleep>
  while(ticks - ticks0 < n){
80105a22:	a1 c0 f1 11 80       	mov    0x8011f1c0,%eax
80105a27:	83 c4 10             	add    $0x10,%esp
80105a2a:	29 d8                	sub    %ebx,%eax
80105a2c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105a2f:	73 2f                	jae    80105a60 <sys_sleep+0x90>
    if(myproc()->killed){
80105a31:	e8 7a de ff ff       	call   801038b0 <myproc>
80105a36:	8b 40 18             	mov    0x18(%eax),%eax
80105a39:	85 c0                	test   %eax,%eax
80105a3b:	74 d3                	je     80105a10 <sys_sleep+0x40>
      release(&tickslock);
80105a3d:	83 ec 0c             	sub    $0xc,%esp
80105a40:	68 80 e9 11 80       	push   $0x8011e980
80105a45:	e8 26 ee ff ff       	call   80104870 <release>
      return -1;
80105a4a:	83 c4 10             	add    $0x10,%esp
80105a4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105a52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a55:	c9                   	leave  
80105a56:	c3                   	ret    
80105a57:	89 f6                	mov    %esi,%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105a60:	83 ec 0c             	sub    $0xc,%esp
80105a63:	68 80 e9 11 80       	push   $0x8011e980
80105a68:	e8 03 ee ff ff       	call   80104870 <release>
  return 0;
80105a6d:	83 c4 10             	add    $0x10,%esp
80105a70:	31 c0                	xor    %eax,%eax
}
80105a72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a75:	c9                   	leave  
80105a76:	c3                   	ret    
    return -1;
80105a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a7c:	eb f4                	jmp    80105a72 <sys_sleep+0xa2>
80105a7e:	66 90                	xchg   %ax,%ax

80105a80 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	53                   	push   %ebx
80105a84:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105a87:	68 80 e9 11 80       	push   $0x8011e980
80105a8c:	e8 1f ed ff ff       	call   801047b0 <acquire>
  xticks = ticks;
80105a91:	8b 1d c0 f1 11 80    	mov    0x8011f1c0,%ebx
  release(&tickslock);
80105a97:	c7 04 24 80 e9 11 80 	movl   $0x8011e980,(%esp)
80105a9e:	e8 cd ed ff ff       	call   80104870 <release>
  return xticks;
}
80105aa3:	89 d8                	mov    %ebx,%eax
80105aa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105aa8:	c9                   	leave  
80105aa9:	c3                   	ret    
80105aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ab0 <sys_kthread_exit>:

int
sys_kthread_exit(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 08             	sub    $0x8,%esp
  kthread_exit();
80105ab6:	e8 c5 e9 ff ff       	call   80104480 <kthread_exit>
  return 0;  // not reached
}
80105abb:	31 c0                	xor    %eax,%eax
80105abd:	c9                   	leave  
80105abe:	c3                   	ret    
80105abf:	90                   	nop

80105ac0 <sys_kthread_create>:

int
sys_kthread_create(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	83 ec 1c             	sub    $0x1c,%esp
  void* start_func;
  void* stack;

  if ((argptr(0, (char**)(&start_func), sizeof(int)) < 0) || (argptr(1, (char**)(&stack), sizeof(int)) < 0))
80105ac6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ac9:	6a 04                	push   $0x4
80105acb:	50                   	push   %eax
80105acc:	6a 00                	push   $0x0
80105ace:	e8 3d f1 ff ff       	call   80104c10 <argptr>
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	85 c0                	test   %eax,%eax
80105ad8:	78 2e                	js     80105b08 <sys_kthread_create+0x48>
80105ada:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105add:	83 ec 04             	sub    $0x4,%esp
80105ae0:	6a 04                	push   $0x4
80105ae2:	50                   	push   %eax
80105ae3:	6a 01                	push   $0x1
80105ae5:	e8 26 f1 ff ff       	call   80104c10 <argptr>
80105aea:	83 c4 10             	add    $0x10,%esp
80105aed:	85 c0                	test   %eax,%eax
80105aef:	78 17                	js     80105b08 <sys_kthread_create+0x48>
    return -1;
return kthread_create(start_func,stack);
80105af1:	83 ec 08             	sub    $0x8,%esp
80105af4:	ff 75 f4             	pushl  -0xc(%ebp)
80105af7:	ff 75 f0             	pushl  -0x10(%ebp)
80105afa:	e8 41 e8 ff ff       	call   80104340 <kthread_create>
80105aff:	83 c4 10             	add    $0x10,%esp
}
80105b02:	c9                   	leave  
80105b03:	c3                   	ret    
80105b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b0d:	c9                   	leave  
80105b0e:	c3                   	ret    
80105b0f:	90                   	nop

80105b10 <sys_kthread_id>:

int
sys_kthread_id(void)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
  return kthread_id();
}
80105b13:	5d                   	pop    %ebp
  return kthread_id();
80105b14:	e9 47 e9 ff ff       	jmp    80104460 <kthread_id>
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b20 <sys_kthread_join>:

int
sys_kthread_join(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	83 ec 20             	sub    $0x20,%esp
  int n;

  if(argint(0, &n) < 0)
80105b26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b29:	50                   	push   %eax
80105b2a:	6a 00                	push   $0x0
80105b2c:	e8 8f f0 ff ff       	call   80104bc0 <argint>
80105b31:	83 c4 10             	add    $0x10,%esp
80105b34:	85 c0                	test   %eax,%eax
80105b36:	78 18                	js     80105b50 <sys_kthread_join+0x30>
    return -1;
  return kthread_join(n);
80105b38:	83 ec 0c             	sub    $0xc,%esp
80105b3b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b3e:	e8 ed e9 ff ff       	call   80104530 <kthread_join>
80105b43:	83 c4 10             	add    $0x10,%esp
}
80105b46:	c9                   	leave  
80105b47:	c3                   	ret    
80105b48:	90                   	nop
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b55:	c9                   	leave  
80105b56:	c3                   	ret    

80105b57 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105b57:	1e                   	push   %ds
  pushl %es
80105b58:	06                   	push   %es
  pushl %fs
80105b59:	0f a0                	push   %fs
  pushl %gs
80105b5b:	0f a8                	push   %gs
  pushal
80105b5d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105b5e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105b62:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105b64:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105b66:	54                   	push   %esp
  call trap
80105b67:	e8 c4 00 00 00       	call   80105c30 <trap>
  addl $4, %esp
80105b6c:	83 c4 04             	add    $0x4,%esp

80105b6f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105b6f:	61                   	popa   
  popl %gs
80105b70:	0f a9                	pop    %gs
  popl %fs
80105b72:	0f a1                	pop    %fs
  popl %es
80105b74:	07                   	pop    %es
  popl %ds
80105b75:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105b76:	83 c4 08             	add    $0x8,%esp
  iret
80105b79:	cf                   	iret   
80105b7a:	66 90                	xchg   %ax,%ax
80105b7c:	66 90                	xchg   %ax,%ax
80105b7e:	66 90                	xchg   %ax,%ax

80105b80 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105b80:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105b81:	31 c0                	xor    %eax,%eax
{
80105b83:	89 e5                	mov    %esp,%ebp
80105b85:	83 ec 08             	sub    $0x8,%esp
80105b88:	90                   	nop
80105b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b90:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105b97:	c7 04 c5 c2 e9 11 80 	movl   $0x8e000008,-0x7fee163e(,%eax,8)
80105b9e:	08 00 00 8e 
80105ba2:	66 89 14 c5 c0 e9 11 	mov    %dx,-0x7fee1640(,%eax,8)
80105ba9:	80 
80105baa:	c1 ea 10             	shr    $0x10,%edx
80105bad:	66 89 14 c5 c6 e9 11 	mov    %dx,-0x7fee163a(,%eax,8)
80105bb4:	80 
  for(i = 0; i < 256; i++)
80105bb5:	83 c0 01             	add    $0x1,%eax
80105bb8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105bbd:	75 d1                	jne    80105b90 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bbf:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105bc4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bc7:	c7 05 c2 eb 11 80 08 	movl   $0xef000008,0x8011ebc2
80105bce:	00 00 ef 
  initlock(&tickslock, "time");
80105bd1:	68 c9 7b 10 80       	push   $0x80107bc9
80105bd6:	68 80 e9 11 80       	push   $0x8011e980
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bdb:	66 a3 c0 eb 11 80    	mov    %ax,0x8011ebc0
80105be1:	c1 e8 10             	shr    $0x10,%eax
80105be4:	66 a3 c6 eb 11 80    	mov    %ax,0x8011ebc6
  initlock(&tickslock, "time");
80105bea:	e8 81 ea ff ff       	call   80104670 <initlock>
}
80105bef:	83 c4 10             	add    $0x10,%esp
80105bf2:	c9                   	leave  
80105bf3:	c3                   	ret    
80105bf4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105bfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105c00 <idtinit>:

void
idtinit(void)
{
80105c00:	55                   	push   %ebp
  pd[0] = size-1;
80105c01:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105c06:	89 e5                	mov    %esp,%ebp
80105c08:	83 ec 10             	sub    $0x10,%esp
80105c0b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c0f:	b8 c0 e9 11 80       	mov    $0x8011e9c0,%eax
80105c14:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c18:	c1 e8 10             	shr    $0x10,%eax
80105c1b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c1f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c22:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c25:	c9                   	leave  
80105c26:	c3                   	ret    
80105c27:	89 f6                	mov    %esi,%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c30 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	57                   	push   %edi
80105c34:	56                   	push   %esi
80105c35:	53                   	push   %ebx
80105c36:	83 ec 1c             	sub    $0x1c,%esp
80105c39:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105c3c:	8b 47 30             	mov    0x30(%edi),%eax
80105c3f:	83 f8 40             	cmp    $0x40,%eax
80105c42:	0f 84 f0 00 00 00    	je     80105d38 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105c48:	83 e8 20             	sub    $0x20,%eax
80105c4b:	83 f8 1f             	cmp    $0x1f,%eax
80105c4e:	77 10                	ja     80105c60 <trap+0x30>
80105c50:	ff 24 85 70 7c 10 80 	jmp    *-0x7fef8390(,%eax,4)
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105c60:	e8 4b dc ff ff       	call   801038b0 <myproc>
80105c65:	85 c0                	test   %eax,%eax
80105c67:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c6a:	0f 84 14 02 00 00    	je     80105e84 <trap+0x254>
80105c70:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105c74:	0f 84 0a 02 00 00    	je     80105e84 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c7a:	0f 20 d1             	mov    %cr2,%ecx
80105c7d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c80:	e8 0b dc ff ff       	call   80103890 <cpuid>
80105c85:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105c88:	8b 47 34             	mov    0x34(%edi),%eax
80105c8b:	8b 77 30             	mov    0x30(%edi),%esi
80105c8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105c91:	e8 1a dc ff ff       	call   801038b0 <myproc>
80105c96:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105c99:	e8 12 dc ff ff       	call   801038b0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c9e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ca1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ca4:	51                   	push   %ecx
80105ca5:	53                   	push   %ebx
80105ca6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105ca7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105caa:	ff 75 e4             	pushl  -0x1c(%ebp)
80105cad:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105cae:	83 c2 5c             	add    $0x5c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cb1:	52                   	push   %edx
80105cb2:	ff 70 10             	pushl  0x10(%eax)
80105cb5:	68 2c 7c 10 80       	push   $0x80107c2c
80105cba:	e8 a1 a9 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105cbf:	83 c4 20             	add    $0x20,%esp
80105cc2:	e8 e9 db ff ff       	call   801038b0 <myproc>
80105cc7:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105cce:	e8 dd db ff ff       	call   801038b0 <myproc>
80105cd3:	85 c0                	test   %eax,%eax
80105cd5:	74 1d                	je     80105cf4 <trap+0xc4>
80105cd7:	e8 d4 db ff ff       	call   801038b0 <myproc>
80105cdc:	8b 50 18             	mov    0x18(%eax),%edx
80105cdf:	85 d2                	test   %edx,%edx
80105ce1:	74 11                	je     80105cf4 <trap+0xc4>
80105ce3:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ce7:	83 e0 03             	and    $0x3,%eax
80105cea:	66 83 f8 03          	cmp    $0x3,%ax
80105cee:	0f 84 4c 01 00 00    	je     80105e40 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(mythread() && mythread()->state == RUNNING &&
80105cf4:	e8 e7 db ff ff       	call   801038e0 <mythread>
80105cf9:	85 c0                	test   %eax,%eax
80105cfb:	74 0b                	je     80105d08 <trap+0xd8>
80105cfd:	e8 de db ff ff       	call   801038e0 <mythread>
80105d02:	83 78 08 03          	cmpl   $0x3,0x8(%eax)
80105d06:	74 68                	je     80105d70 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d08:	e8 a3 db ff ff       	call   801038b0 <myproc>
80105d0d:	85 c0                	test   %eax,%eax
80105d0f:	74 19                	je     80105d2a <trap+0xfa>
80105d11:	e8 9a db ff ff       	call   801038b0 <myproc>
80105d16:	8b 40 18             	mov    0x18(%eax),%eax
80105d19:	85 c0                	test   %eax,%eax
80105d1b:	74 0d                	je     80105d2a <trap+0xfa>
80105d1d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105d21:	83 e0 03             	and    $0x3,%eax
80105d24:	66 83 f8 03          	cmp    $0x3,%ax
80105d28:	74 37                	je     80105d61 <trap+0x131>
    exit();
}
80105d2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d2d:	5b                   	pop    %ebx
80105d2e:	5e                   	pop    %esi
80105d2f:	5f                   	pop    %edi
80105d30:	5d                   	pop    %ebp
80105d31:	c3                   	ret    
80105d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105d38:	e8 73 db ff ff       	call   801038b0 <myproc>
80105d3d:	8b 58 18             	mov    0x18(%eax),%ebx
80105d40:	85 db                	test   %ebx,%ebx
80105d42:	0f 85 e8 00 00 00    	jne    80105e30 <trap+0x200>
    mythread()->tf = tf;
80105d48:	e8 93 db ff ff       	call   801038e0 <mythread>
80105d4d:	89 78 14             	mov    %edi,0x14(%eax)
    syscall();
80105d50:	e8 5b ef ff ff       	call   80104cb0 <syscall>
    if(myproc()->killed)
80105d55:	e8 56 db ff ff       	call   801038b0 <myproc>
80105d5a:	8b 48 18             	mov    0x18(%eax),%ecx
80105d5d:	85 c9                	test   %ecx,%ecx
80105d5f:	74 c9                	je     80105d2a <trap+0xfa>
}
80105d61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d64:	5b                   	pop    %ebx
80105d65:	5e                   	pop    %esi
80105d66:	5f                   	pop    %edi
80105d67:	5d                   	pop    %ebp
      exit();
80105d68:	e9 53 e0 ff ff       	jmp    80103dc0 <exit>
80105d6d:	8d 76 00             	lea    0x0(%esi),%esi
  if(mythread() && mythread()->state == RUNNING &&
80105d70:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105d74:	75 92                	jne    80105d08 <trap+0xd8>
    yield();
80105d76:	e8 75 e1 ff ff       	call   80103ef0 <yield>
80105d7b:	eb 8b                	jmp    80105d08 <trap+0xd8>
80105d7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105d80:	e8 0b db ff ff       	call   80103890 <cpuid>
80105d85:	85 c0                	test   %eax,%eax
80105d87:	0f 84 c3 00 00 00    	je     80105e50 <trap+0x220>
    lapiceoi();
80105d8d:	e8 de c9 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d92:	e8 19 db ff ff       	call   801038b0 <myproc>
80105d97:	85 c0                	test   %eax,%eax
80105d99:	0f 85 38 ff ff ff    	jne    80105cd7 <trap+0xa7>
80105d9f:	e9 50 ff ff ff       	jmp    80105cf4 <trap+0xc4>
80105da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105da8:	e8 83 c8 ff ff       	call   80102630 <kbdintr>
    lapiceoi();
80105dad:	e8 be c9 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105db2:	e8 f9 da ff ff       	call   801038b0 <myproc>
80105db7:	85 c0                	test   %eax,%eax
80105db9:	0f 85 18 ff ff ff    	jne    80105cd7 <trap+0xa7>
80105dbf:	e9 30 ff ff ff       	jmp    80105cf4 <trap+0xc4>
80105dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105dc8:	e8 53 02 00 00       	call   80106020 <uartintr>
    lapiceoi();
80105dcd:	e8 9e c9 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dd2:	e8 d9 da ff ff       	call   801038b0 <myproc>
80105dd7:	85 c0                	test   %eax,%eax
80105dd9:	0f 85 f8 fe ff ff    	jne    80105cd7 <trap+0xa7>
80105ddf:	e9 10 ff ff ff       	jmp    80105cf4 <trap+0xc4>
80105de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105de8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105dec:	8b 77 38             	mov    0x38(%edi),%esi
80105def:	e8 9c da ff ff       	call   80103890 <cpuid>
80105df4:	56                   	push   %esi
80105df5:	53                   	push   %ebx
80105df6:	50                   	push   %eax
80105df7:	68 d4 7b 10 80       	push   $0x80107bd4
80105dfc:	e8 5f a8 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105e01:	e8 6a c9 ff ff       	call   80102770 <lapiceoi>
    break;
80105e06:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e09:	e8 a2 da ff ff       	call   801038b0 <myproc>
80105e0e:	85 c0                	test   %eax,%eax
80105e10:	0f 85 c1 fe ff ff    	jne    80105cd7 <trap+0xa7>
80105e16:	e9 d9 fe ff ff       	jmp    80105cf4 <trap+0xc4>
80105e1b:	90                   	nop
80105e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105e20:	e8 7b c2 ff ff       	call   801020a0 <ideintr>
80105e25:	e9 63 ff ff ff       	jmp    80105d8d <trap+0x15d>
80105e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105e30:	e8 8b df ff ff       	call   80103dc0 <exit>
80105e35:	e9 0e ff ff ff       	jmp    80105d48 <trap+0x118>
80105e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105e40:	e8 7b df ff ff       	call   80103dc0 <exit>
80105e45:	e9 aa fe ff ff       	jmp    80105cf4 <trap+0xc4>
80105e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105e50:	83 ec 0c             	sub    $0xc,%esp
80105e53:	68 80 e9 11 80       	push   $0x8011e980
80105e58:	e8 53 e9 ff ff       	call   801047b0 <acquire>
      wakeup(&ticks);
80105e5d:	c7 04 24 c0 f1 11 80 	movl   $0x8011f1c0,(%esp)
      ticks++;
80105e64:	83 05 c0 f1 11 80 01 	addl   $0x1,0x8011f1c0
      wakeup(&ticks);
80105e6b:	e8 10 e3 ff ff       	call   80104180 <wakeup>
      release(&tickslock);
80105e70:	c7 04 24 80 e9 11 80 	movl   $0x8011e980,(%esp)
80105e77:	e8 f4 e9 ff ff       	call   80104870 <release>
80105e7c:	83 c4 10             	add    $0x10,%esp
80105e7f:	e9 09 ff ff ff       	jmp    80105d8d <trap+0x15d>
80105e84:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105e87:	e8 04 da ff ff       	call   80103890 <cpuid>
80105e8c:	83 ec 0c             	sub    $0xc,%esp
80105e8f:	56                   	push   %esi
80105e90:	53                   	push   %ebx
80105e91:	50                   	push   %eax
80105e92:	ff 77 30             	pushl  0x30(%edi)
80105e95:	68 f8 7b 10 80       	push   $0x80107bf8
80105e9a:	e8 c1 a7 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105e9f:	83 c4 14             	add    $0x14,%esp
80105ea2:	68 ce 7b 10 80       	push   $0x80107bce
80105ea7:	e8 e4 a4 ff ff       	call   80100390 <panic>
80105eac:	66 90                	xchg   %ax,%ax
80105eae:	66 90                	xchg   %ax,%ax

80105eb0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105eb0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105eb5:	55                   	push   %ebp
80105eb6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105eb8:	85 c0                	test   %eax,%eax
80105eba:	74 1c                	je     80105ed8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ebc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ec1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105ec2:	a8 01                	test   $0x1,%al
80105ec4:	74 12                	je     80105ed8 <uartgetc+0x28>
80105ec6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ecb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105ecc:	0f b6 c0             	movzbl %al,%eax
}
80105ecf:	5d                   	pop    %ebp
80105ed0:	c3                   	ret    
80105ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ed8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105edd:	5d                   	pop    %ebp
80105ede:	c3                   	ret    
80105edf:	90                   	nop

80105ee0 <uartputc.part.0>:
uartputc(int c)
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	57                   	push   %edi
80105ee4:	56                   	push   %esi
80105ee5:	53                   	push   %ebx
80105ee6:	89 c7                	mov    %eax,%edi
80105ee8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105eed:	be fd 03 00 00       	mov    $0x3fd,%esi
80105ef2:	83 ec 0c             	sub    $0xc,%esp
80105ef5:	eb 1b                	jmp    80105f12 <uartputc.part.0+0x32>
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105f00:	83 ec 0c             	sub    $0xc,%esp
80105f03:	6a 0a                	push   $0xa
80105f05:	e8 86 c8 ff ff       	call   80102790 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f0a:	83 c4 10             	add    $0x10,%esp
80105f0d:	83 eb 01             	sub    $0x1,%ebx
80105f10:	74 07                	je     80105f19 <uartputc.part.0+0x39>
80105f12:	89 f2                	mov    %esi,%edx
80105f14:	ec                   	in     (%dx),%al
80105f15:	a8 20                	test   $0x20,%al
80105f17:	74 e7                	je     80105f00 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f19:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f1e:	89 f8                	mov    %edi,%eax
80105f20:	ee                   	out    %al,(%dx)
}
80105f21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f24:	5b                   	pop    %ebx
80105f25:	5e                   	pop    %esi
80105f26:	5f                   	pop    %edi
80105f27:	5d                   	pop    %ebp
80105f28:	c3                   	ret    
80105f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f30 <uartinit>:
{
80105f30:	55                   	push   %ebp
80105f31:	31 c9                	xor    %ecx,%ecx
80105f33:	89 c8                	mov    %ecx,%eax
80105f35:	89 e5                	mov    %esp,%ebp
80105f37:	57                   	push   %edi
80105f38:	56                   	push   %esi
80105f39:	53                   	push   %ebx
80105f3a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105f3f:	89 da                	mov    %ebx,%edx
80105f41:	83 ec 0c             	sub    $0xc,%esp
80105f44:	ee                   	out    %al,(%dx)
80105f45:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105f4a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105f4f:	89 fa                	mov    %edi,%edx
80105f51:	ee                   	out    %al,(%dx)
80105f52:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f57:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f5c:	ee                   	out    %al,(%dx)
80105f5d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105f62:	89 c8                	mov    %ecx,%eax
80105f64:	89 f2                	mov    %esi,%edx
80105f66:	ee                   	out    %al,(%dx)
80105f67:	b8 03 00 00 00       	mov    $0x3,%eax
80105f6c:	89 fa                	mov    %edi,%edx
80105f6e:	ee                   	out    %al,(%dx)
80105f6f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105f74:	89 c8                	mov    %ecx,%eax
80105f76:	ee                   	out    %al,(%dx)
80105f77:	b8 01 00 00 00       	mov    $0x1,%eax
80105f7c:	89 f2                	mov    %esi,%edx
80105f7e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f7f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f84:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105f85:	3c ff                	cmp    $0xff,%al
80105f87:	74 5a                	je     80105fe3 <uartinit+0xb3>
  uart = 1;
80105f89:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105f90:	00 00 00 
80105f93:	89 da                	mov    %ebx,%edx
80105f95:	ec                   	in     (%dx),%al
80105f96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f9b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105f9c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105f9f:	bb f0 7c 10 80       	mov    $0x80107cf0,%ebx
  ioapicenable(IRQ_COM1, 0);
80105fa4:	6a 00                	push   $0x0
80105fa6:	6a 04                	push   $0x4
80105fa8:	e8 43 c3 ff ff       	call   801022f0 <ioapicenable>
80105fad:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105fb0:	b8 78 00 00 00       	mov    $0x78,%eax
80105fb5:	eb 13                	jmp    80105fca <uartinit+0x9a>
80105fb7:	89 f6                	mov    %esi,%esi
80105fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105fc0:	83 c3 01             	add    $0x1,%ebx
80105fc3:	0f be 03             	movsbl (%ebx),%eax
80105fc6:	84 c0                	test   %al,%al
80105fc8:	74 19                	je     80105fe3 <uartinit+0xb3>
  if(!uart)
80105fca:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105fd0:	85 d2                	test   %edx,%edx
80105fd2:	74 ec                	je     80105fc0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105fd4:	83 c3 01             	add    $0x1,%ebx
80105fd7:	e8 04 ff ff ff       	call   80105ee0 <uartputc.part.0>
80105fdc:	0f be 03             	movsbl (%ebx),%eax
80105fdf:	84 c0                	test   %al,%al
80105fe1:	75 e7                	jne    80105fca <uartinit+0x9a>
}
80105fe3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fe6:	5b                   	pop    %ebx
80105fe7:	5e                   	pop    %esi
80105fe8:	5f                   	pop    %edi
80105fe9:	5d                   	pop    %ebp
80105fea:	c3                   	ret    
80105feb:	90                   	nop
80105fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <uartputc>:
  if(!uart)
80105ff0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105ff6:	55                   	push   %ebp
80105ff7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ff9:	85 d2                	test   %edx,%edx
{
80105ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105ffe:	74 10                	je     80106010 <uartputc+0x20>
}
80106000:	5d                   	pop    %ebp
80106001:	e9 da fe ff ff       	jmp    80105ee0 <uartputc.part.0>
80106006:	8d 76 00             	lea    0x0(%esi),%esi
80106009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106010:	5d                   	pop    %ebp
80106011:	c3                   	ret    
80106012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106020 <uartintr>:

void
uartintr(void)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106026:	68 b0 5e 10 80       	push   $0x80105eb0
8010602b:	e8 e0 a7 ff ff       	call   80100810 <consoleintr>
}
80106030:	83 c4 10             	add    $0x10,%esp
80106033:	c9                   	leave  
80106034:	c3                   	ret    

80106035 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106035:	6a 00                	push   $0x0
  pushl $0
80106037:	6a 00                	push   $0x0
  jmp alltraps
80106039:	e9 19 fb ff ff       	jmp    80105b57 <alltraps>

8010603e <vector1>:
.globl vector1
vector1:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $1
80106040:	6a 01                	push   $0x1
  jmp alltraps
80106042:	e9 10 fb ff ff       	jmp    80105b57 <alltraps>

80106047 <vector2>:
.globl vector2
vector2:
  pushl $0
80106047:	6a 00                	push   $0x0
  pushl $2
80106049:	6a 02                	push   $0x2
  jmp alltraps
8010604b:	e9 07 fb ff ff       	jmp    80105b57 <alltraps>

80106050 <vector3>:
.globl vector3
vector3:
  pushl $0
80106050:	6a 00                	push   $0x0
  pushl $3
80106052:	6a 03                	push   $0x3
  jmp alltraps
80106054:	e9 fe fa ff ff       	jmp    80105b57 <alltraps>

80106059 <vector4>:
.globl vector4
vector4:
  pushl $0
80106059:	6a 00                	push   $0x0
  pushl $4
8010605b:	6a 04                	push   $0x4
  jmp alltraps
8010605d:	e9 f5 fa ff ff       	jmp    80105b57 <alltraps>

80106062 <vector5>:
.globl vector5
vector5:
  pushl $0
80106062:	6a 00                	push   $0x0
  pushl $5
80106064:	6a 05                	push   $0x5
  jmp alltraps
80106066:	e9 ec fa ff ff       	jmp    80105b57 <alltraps>

8010606b <vector6>:
.globl vector6
vector6:
  pushl $0
8010606b:	6a 00                	push   $0x0
  pushl $6
8010606d:	6a 06                	push   $0x6
  jmp alltraps
8010606f:	e9 e3 fa ff ff       	jmp    80105b57 <alltraps>

80106074 <vector7>:
.globl vector7
vector7:
  pushl $0
80106074:	6a 00                	push   $0x0
  pushl $7
80106076:	6a 07                	push   $0x7
  jmp alltraps
80106078:	e9 da fa ff ff       	jmp    80105b57 <alltraps>

8010607d <vector8>:
.globl vector8
vector8:
  pushl $8
8010607d:	6a 08                	push   $0x8
  jmp alltraps
8010607f:	e9 d3 fa ff ff       	jmp    80105b57 <alltraps>

80106084 <vector9>:
.globl vector9
vector9:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $9
80106086:	6a 09                	push   $0x9
  jmp alltraps
80106088:	e9 ca fa ff ff       	jmp    80105b57 <alltraps>

8010608d <vector10>:
.globl vector10
vector10:
  pushl $10
8010608d:	6a 0a                	push   $0xa
  jmp alltraps
8010608f:	e9 c3 fa ff ff       	jmp    80105b57 <alltraps>

80106094 <vector11>:
.globl vector11
vector11:
  pushl $11
80106094:	6a 0b                	push   $0xb
  jmp alltraps
80106096:	e9 bc fa ff ff       	jmp    80105b57 <alltraps>

8010609b <vector12>:
.globl vector12
vector12:
  pushl $12
8010609b:	6a 0c                	push   $0xc
  jmp alltraps
8010609d:	e9 b5 fa ff ff       	jmp    80105b57 <alltraps>

801060a2 <vector13>:
.globl vector13
vector13:
  pushl $13
801060a2:	6a 0d                	push   $0xd
  jmp alltraps
801060a4:	e9 ae fa ff ff       	jmp    80105b57 <alltraps>

801060a9 <vector14>:
.globl vector14
vector14:
  pushl $14
801060a9:	6a 0e                	push   $0xe
  jmp alltraps
801060ab:	e9 a7 fa ff ff       	jmp    80105b57 <alltraps>

801060b0 <vector15>:
.globl vector15
vector15:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $15
801060b2:	6a 0f                	push   $0xf
  jmp alltraps
801060b4:	e9 9e fa ff ff       	jmp    80105b57 <alltraps>

801060b9 <vector16>:
.globl vector16
vector16:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $16
801060bb:	6a 10                	push   $0x10
  jmp alltraps
801060bd:	e9 95 fa ff ff       	jmp    80105b57 <alltraps>

801060c2 <vector17>:
.globl vector17
vector17:
  pushl $17
801060c2:	6a 11                	push   $0x11
  jmp alltraps
801060c4:	e9 8e fa ff ff       	jmp    80105b57 <alltraps>

801060c9 <vector18>:
.globl vector18
vector18:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $18
801060cb:	6a 12                	push   $0x12
  jmp alltraps
801060cd:	e9 85 fa ff ff       	jmp    80105b57 <alltraps>

801060d2 <vector19>:
.globl vector19
vector19:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $19
801060d4:	6a 13                	push   $0x13
  jmp alltraps
801060d6:	e9 7c fa ff ff       	jmp    80105b57 <alltraps>

801060db <vector20>:
.globl vector20
vector20:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $20
801060dd:	6a 14                	push   $0x14
  jmp alltraps
801060df:	e9 73 fa ff ff       	jmp    80105b57 <alltraps>

801060e4 <vector21>:
.globl vector21
vector21:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $21
801060e6:	6a 15                	push   $0x15
  jmp alltraps
801060e8:	e9 6a fa ff ff       	jmp    80105b57 <alltraps>

801060ed <vector22>:
.globl vector22
vector22:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $22
801060ef:	6a 16                	push   $0x16
  jmp alltraps
801060f1:	e9 61 fa ff ff       	jmp    80105b57 <alltraps>

801060f6 <vector23>:
.globl vector23
vector23:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $23
801060f8:	6a 17                	push   $0x17
  jmp alltraps
801060fa:	e9 58 fa ff ff       	jmp    80105b57 <alltraps>

801060ff <vector24>:
.globl vector24
vector24:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $24
80106101:	6a 18                	push   $0x18
  jmp alltraps
80106103:	e9 4f fa ff ff       	jmp    80105b57 <alltraps>

80106108 <vector25>:
.globl vector25
vector25:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $25
8010610a:	6a 19                	push   $0x19
  jmp alltraps
8010610c:	e9 46 fa ff ff       	jmp    80105b57 <alltraps>

80106111 <vector26>:
.globl vector26
vector26:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $26
80106113:	6a 1a                	push   $0x1a
  jmp alltraps
80106115:	e9 3d fa ff ff       	jmp    80105b57 <alltraps>

8010611a <vector27>:
.globl vector27
vector27:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $27
8010611c:	6a 1b                	push   $0x1b
  jmp alltraps
8010611e:	e9 34 fa ff ff       	jmp    80105b57 <alltraps>

80106123 <vector28>:
.globl vector28
vector28:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $28
80106125:	6a 1c                	push   $0x1c
  jmp alltraps
80106127:	e9 2b fa ff ff       	jmp    80105b57 <alltraps>

8010612c <vector29>:
.globl vector29
vector29:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $29
8010612e:	6a 1d                	push   $0x1d
  jmp alltraps
80106130:	e9 22 fa ff ff       	jmp    80105b57 <alltraps>

80106135 <vector30>:
.globl vector30
vector30:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $30
80106137:	6a 1e                	push   $0x1e
  jmp alltraps
80106139:	e9 19 fa ff ff       	jmp    80105b57 <alltraps>

8010613e <vector31>:
.globl vector31
vector31:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $31
80106140:	6a 1f                	push   $0x1f
  jmp alltraps
80106142:	e9 10 fa ff ff       	jmp    80105b57 <alltraps>

80106147 <vector32>:
.globl vector32
vector32:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $32
80106149:	6a 20                	push   $0x20
  jmp alltraps
8010614b:	e9 07 fa ff ff       	jmp    80105b57 <alltraps>

80106150 <vector33>:
.globl vector33
vector33:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $33
80106152:	6a 21                	push   $0x21
  jmp alltraps
80106154:	e9 fe f9 ff ff       	jmp    80105b57 <alltraps>

80106159 <vector34>:
.globl vector34
vector34:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $34
8010615b:	6a 22                	push   $0x22
  jmp alltraps
8010615d:	e9 f5 f9 ff ff       	jmp    80105b57 <alltraps>

80106162 <vector35>:
.globl vector35
vector35:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $35
80106164:	6a 23                	push   $0x23
  jmp alltraps
80106166:	e9 ec f9 ff ff       	jmp    80105b57 <alltraps>

8010616b <vector36>:
.globl vector36
vector36:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $36
8010616d:	6a 24                	push   $0x24
  jmp alltraps
8010616f:	e9 e3 f9 ff ff       	jmp    80105b57 <alltraps>

80106174 <vector37>:
.globl vector37
vector37:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $37
80106176:	6a 25                	push   $0x25
  jmp alltraps
80106178:	e9 da f9 ff ff       	jmp    80105b57 <alltraps>

8010617d <vector38>:
.globl vector38
vector38:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $38
8010617f:	6a 26                	push   $0x26
  jmp alltraps
80106181:	e9 d1 f9 ff ff       	jmp    80105b57 <alltraps>

80106186 <vector39>:
.globl vector39
vector39:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $39
80106188:	6a 27                	push   $0x27
  jmp alltraps
8010618a:	e9 c8 f9 ff ff       	jmp    80105b57 <alltraps>

8010618f <vector40>:
.globl vector40
vector40:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $40
80106191:	6a 28                	push   $0x28
  jmp alltraps
80106193:	e9 bf f9 ff ff       	jmp    80105b57 <alltraps>

80106198 <vector41>:
.globl vector41
vector41:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $41
8010619a:	6a 29                	push   $0x29
  jmp alltraps
8010619c:	e9 b6 f9 ff ff       	jmp    80105b57 <alltraps>

801061a1 <vector42>:
.globl vector42
vector42:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $42
801061a3:	6a 2a                	push   $0x2a
  jmp alltraps
801061a5:	e9 ad f9 ff ff       	jmp    80105b57 <alltraps>

801061aa <vector43>:
.globl vector43
vector43:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $43
801061ac:	6a 2b                	push   $0x2b
  jmp alltraps
801061ae:	e9 a4 f9 ff ff       	jmp    80105b57 <alltraps>

801061b3 <vector44>:
.globl vector44
vector44:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $44
801061b5:	6a 2c                	push   $0x2c
  jmp alltraps
801061b7:	e9 9b f9 ff ff       	jmp    80105b57 <alltraps>

801061bc <vector45>:
.globl vector45
vector45:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $45
801061be:	6a 2d                	push   $0x2d
  jmp alltraps
801061c0:	e9 92 f9 ff ff       	jmp    80105b57 <alltraps>

801061c5 <vector46>:
.globl vector46
vector46:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $46
801061c7:	6a 2e                	push   $0x2e
  jmp alltraps
801061c9:	e9 89 f9 ff ff       	jmp    80105b57 <alltraps>

801061ce <vector47>:
.globl vector47
vector47:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $47
801061d0:	6a 2f                	push   $0x2f
  jmp alltraps
801061d2:	e9 80 f9 ff ff       	jmp    80105b57 <alltraps>

801061d7 <vector48>:
.globl vector48
vector48:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $48
801061d9:	6a 30                	push   $0x30
  jmp alltraps
801061db:	e9 77 f9 ff ff       	jmp    80105b57 <alltraps>

801061e0 <vector49>:
.globl vector49
vector49:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $49
801061e2:	6a 31                	push   $0x31
  jmp alltraps
801061e4:	e9 6e f9 ff ff       	jmp    80105b57 <alltraps>

801061e9 <vector50>:
.globl vector50
vector50:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $50
801061eb:	6a 32                	push   $0x32
  jmp alltraps
801061ed:	e9 65 f9 ff ff       	jmp    80105b57 <alltraps>

801061f2 <vector51>:
.globl vector51
vector51:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $51
801061f4:	6a 33                	push   $0x33
  jmp alltraps
801061f6:	e9 5c f9 ff ff       	jmp    80105b57 <alltraps>

801061fb <vector52>:
.globl vector52
vector52:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $52
801061fd:	6a 34                	push   $0x34
  jmp alltraps
801061ff:	e9 53 f9 ff ff       	jmp    80105b57 <alltraps>

80106204 <vector53>:
.globl vector53
vector53:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $53
80106206:	6a 35                	push   $0x35
  jmp alltraps
80106208:	e9 4a f9 ff ff       	jmp    80105b57 <alltraps>

8010620d <vector54>:
.globl vector54
vector54:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $54
8010620f:	6a 36                	push   $0x36
  jmp alltraps
80106211:	e9 41 f9 ff ff       	jmp    80105b57 <alltraps>

80106216 <vector55>:
.globl vector55
vector55:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $55
80106218:	6a 37                	push   $0x37
  jmp alltraps
8010621a:	e9 38 f9 ff ff       	jmp    80105b57 <alltraps>

8010621f <vector56>:
.globl vector56
vector56:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $56
80106221:	6a 38                	push   $0x38
  jmp alltraps
80106223:	e9 2f f9 ff ff       	jmp    80105b57 <alltraps>

80106228 <vector57>:
.globl vector57
vector57:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $57
8010622a:	6a 39                	push   $0x39
  jmp alltraps
8010622c:	e9 26 f9 ff ff       	jmp    80105b57 <alltraps>

80106231 <vector58>:
.globl vector58
vector58:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $58
80106233:	6a 3a                	push   $0x3a
  jmp alltraps
80106235:	e9 1d f9 ff ff       	jmp    80105b57 <alltraps>

8010623a <vector59>:
.globl vector59
vector59:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $59
8010623c:	6a 3b                	push   $0x3b
  jmp alltraps
8010623e:	e9 14 f9 ff ff       	jmp    80105b57 <alltraps>

80106243 <vector60>:
.globl vector60
vector60:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $60
80106245:	6a 3c                	push   $0x3c
  jmp alltraps
80106247:	e9 0b f9 ff ff       	jmp    80105b57 <alltraps>

8010624c <vector61>:
.globl vector61
vector61:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $61
8010624e:	6a 3d                	push   $0x3d
  jmp alltraps
80106250:	e9 02 f9 ff ff       	jmp    80105b57 <alltraps>

80106255 <vector62>:
.globl vector62
vector62:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $62
80106257:	6a 3e                	push   $0x3e
  jmp alltraps
80106259:	e9 f9 f8 ff ff       	jmp    80105b57 <alltraps>

8010625e <vector63>:
.globl vector63
vector63:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $63
80106260:	6a 3f                	push   $0x3f
  jmp alltraps
80106262:	e9 f0 f8 ff ff       	jmp    80105b57 <alltraps>

80106267 <vector64>:
.globl vector64
vector64:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $64
80106269:	6a 40                	push   $0x40
  jmp alltraps
8010626b:	e9 e7 f8 ff ff       	jmp    80105b57 <alltraps>

80106270 <vector65>:
.globl vector65
vector65:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $65
80106272:	6a 41                	push   $0x41
  jmp alltraps
80106274:	e9 de f8 ff ff       	jmp    80105b57 <alltraps>

80106279 <vector66>:
.globl vector66
vector66:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $66
8010627b:	6a 42                	push   $0x42
  jmp alltraps
8010627d:	e9 d5 f8 ff ff       	jmp    80105b57 <alltraps>

80106282 <vector67>:
.globl vector67
vector67:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $67
80106284:	6a 43                	push   $0x43
  jmp alltraps
80106286:	e9 cc f8 ff ff       	jmp    80105b57 <alltraps>

8010628b <vector68>:
.globl vector68
vector68:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $68
8010628d:	6a 44                	push   $0x44
  jmp alltraps
8010628f:	e9 c3 f8 ff ff       	jmp    80105b57 <alltraps>

80106294 <vector69>:
.globl vector69
vector69:
  pushl $0
80106294:	6a 00                	push   $0x0
  pushl $69
80106296:	6a 45                	push   $0x45
  jmp alltraps
80106298:	e9 ba f8 ff ff       	jmp    80105b57 <alltraps>

8010629d <vector70>:
.globl vector70
vector70:
  pushl $0
8010629d:	6a 00                	push   $0x0
  pushl $70
8010629f:	6a 46                	push   $0x46
  jmp alltraps
801062a1:	e9 b1 f8 ff ff       	jmp    80105b57 <alltraps>

801062a6 <vector71>:
.globl vector71
vector71:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $71
801062a8:	6a 47                	push   $0x47
  jmp alltraps
801062aa:	e9 a8 f8 ff ff       	jmp    80105b57 <alltraps>

801062af <vector72>:
.globl vector72
vector72:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $72
801062b1:	6a 48                	push   $0x48
  jmp alltraps
801062b3:	e9 9f f8 ff ff       	jmp    80105b57 <alltraps>

801062b8 <vector73>:
.globl vector73
vector73:
  pushl $0
801062b8:	6a 00                	push   $0x0
  pushl $73
801062ba:	6a 49                	push   $0x49
  jmp alltraps
801062bc:	e9 96 f8 ff ff       	jmp    80105b57 <alltraps>

801062c1 <vector74>:
.globl vector74
vector74:
  pushl $0
801062c1:	6a 00                	push   $0x0
  pushl $74
801062c3:	6a 4a                	push   $0x4a
  jmp alltraps
801062c5:	e9 8d f8 ff ff       	jmp    80105b57 <alltraps>

801062ca <vector75>:
.globl vector75
vector75:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $75
801062cc:	6a 4b                	push   $0x4b
  jmp alltraps
801062ce:	e9 84 f8 ff ff       	jmp    80105b57 <alltraps>

801062d3 <vector76>:
.globl vector76
vector76:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $76
801062d5:	6a 4c                	push   $0x4c
  jmp alltraps
801062d7:	e9 7b f8 ff ff       	jmp    80105b57 <alltraps>

801062dc <vector77>:
.globl vector77
vector77:
  pushl $0
801062dc:	6a 00                	push   $0x0
  pushl $77
801062de:	6a 4d                	push   $0x4d
  jmp alltraps
801062e0:	e9 72 f8 ff ff       	jmp    80105b57 <alltraps>

801062e5 <vector78>:
.globl vector78
vector78:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $78
801062e7:	6a 4e                	push   $0x4e
  jmp alltraps
801062e9:	e9 69 f8 ff ff       	jmp    80105b57 <alltraps>

801062ee <vector79>:
.globl vector79
vector79:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $79
801062f0:	6a 4f                	push   $0x4f
  jmp alltraps
801062f2:	e9 60 f8 ff ff       	jmp    80105b57 <alltraps>

801062f7 <vector80>:
.globl vector80
vector80:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $80
801062f9:	6a 50                	push   $0x50
  jmp alltraps
801062fb:	e9 57 f8 ff ff       	jmp    80105b57 <alltraps>

80106300 <vector81>:
.globl vector81
vector81:
  pushl $0
80106300:	6a 00                	push   $0x0
  pushl $81
80106302:	6a 51                	push   $0x51
  jmp alltraps
80106304:	e9 4e f8 ff ff       	jmp    80105b57 <alltraps>

80106309 <vector82>:
.globl vector82
vector82:
  pushl $0
80106309:	6a 00                	push   $0x0
  pushl $82
8010630b:	6a 52                	push   $0x52
  jmp alltraps
8010630d:	e9 45 f8 ff ff       	jmp    80105b57 <alltraps>

80106312 <vector83>:
.globl vector83
vector83:
  pushl $0
80106312:	6a 00                	push   $0x0
  pushl $83
80106314:	6a 53                	push   $0x53
  jmp alltraps
80106316:	e9 3c f8 ff ff       	jmp    80105b57 <alltraps>

8010631b <vector84>:
.globl vector84
vector84:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $84
8010631d:	6a 54                	push   $0x54
  jmp alltraps
8010631f:	e9 33 f8 ff ff       	jmp    80105b57 <alltraps>

80106324 <vector85>:
.globl vector85
vector85:
  pushl $0
80106324:	6a 00                	push   $0x0
  pushl $85
80106326:	6a 55                	push   $0x55
  jmp alltraps
80106328:	e9 2a f8 ff ff       	jmp    80105b57 <alltraps>

8010632d <vector86>:
.globl vector86
vector86:
  pushl $0
8010632d:	6a 00                	push   $0x0
  pushl $86
8010632f:	6a 56                	push   $0x56
  jmp alltraps
80106331:	e9 21 f8 ff ff       	jmp    80105b57 <alltraps>

80106336 <vector87>:
.globl vector87
vector87:
  pushl $0
80106336:	6a 00                	push   $0x0
  pushl $87
80106338:	6a 57                	push   $0x57
  jmp alltraps
8010633a:	e9 18 f8 ff ff       	jmp    80105b57 <alltraps>

8010633f <vector88>:
.globl vector88
vector88:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $88
80106341:	6a 58                	push   $0x58
  jmp alltraps
80106343:	e9 0f f8 ff ff       	jmp    80105b57 <alltraps>

80106348 <vector89>:
.globl vector89
vector89:
  pushl $0
80106348:	6a 00                	push   $0x0
  pushl $89
8010634a:	6a 59                	push   $0x59
  jmp alltraps
8010634c:	e9 06 f8 ff ff       	jmp    80105b57 <alltraps>

80106351 <vector90>:
.globl vector90
vector90:
  pushl $0
80106351:	6a 00                	push   $0x0
  pushl $90
80106353:	6a 5a                	push   $0x5a
  jmp alltraps
80106355:	e9 fd f7 ff ff       	jmp    80105b57 <alltraps>

8010635a <vector91>:
.globl vector91
vector91:
  pushl $0
8010635a:	6a 00                	push   $0x0
  pushl $91
8010635c:	6a 5b                	push   $0x5b
  jmp alltraps
8010635e:	e9 f4 f7 ff ff       	jmp    80105b57 <alltraps>

80106363 <vector92>:
.globl vector92
vector92:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $92
80106365:	6a 5c                	push   $0x5c
  jmp alltraps
80106367:	e9 eb f7 ff ff       	jmp    80105b57 <alltraps>

8010636c <vector93>:
.globl vector93
vector93:
  pushl $0
8010636c:	6a 00                	push   $0x0
  pushl $93
8010636e:	6a 5d                	push   $0x5d
  jmp alltraps
80106370:	e9 e2 f7 ff ff       	jmp    80105b57 <alltraps>

80106375 <vector94>:
.globl vector94
vector94:
  pushl $0
80106375:	6a 00                	push   $0x0
  pushl $94
80106377:	6a 5e                	push   $0x5e
  jmp alltraps
80106379:	e9 d9 f7 ff ff       	jmp    80105b57 <alltraps>

8010637e <vector95>:
.globl vector95
vector95:
  pushl $0
8010637e:	6a 00                	push   $0x0
  pushl $95
80106380:	6a 5f                	push   $0x5f
  jmp alltraps
80106382:	e9 d0 f7 ff ff       	jmp    80105b57 <alltraps>

80106387 <vector96>:
.globl vector96
vector96:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $96
80106389:	6a 60                	push   $0x60
  jmp alltraps
8010638b:	e9 c7 f7 ff ff       	jmp    80105b57 <alltraps>

80106390 <vector97>:
.globl vector97
vector97:
  pushl $0
80106390:	6a 00                	push   $0x0
  pushl $97
80106392:	6a 61                	push   $0x61
  jmp alltraps
80106394:	e9 be f7 ff ff       	jmp    80105b57 <alltraps>

80106399 <vector98>:
.globl vector98
vector98:
  pushl $0
80106399:	6a 00                	push   $0x0
  pushl $98
8010639b:	6a 62                	push   $0x62
  jmp alltraps
8010639d:	e9 b5 f7 ff ff       	jmp    80105b57 <alltraps>

801063a2 <vector99>:
.globl vector99
vector99:
  pushl $0
801063a2:	6a 00                	push   $0x0
  pushl $99
801063a4:	6a 63                	push   $0x63
  jmp alltraps
801063a6:	e9 ac f7 ff ff       	jmp    80105b57 <alltraps>

801063ab <vector100>:
.globl vector100
vector100:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $100
801063ad:	6a 64                	push   $0x64
  jmp alltraps
801063af:	e9 a3 f7 ff ff       	jmp    80105b57 <alltraps>

801063b4 <vector101>:
.globl vector101
vector101:
  pushl $0
801063b4:	6a 00                	push   $0x0
  pushl $101
801063b6:	6a 65                	push   $0x65
  jmp alltraps
801063b8:	e9 9a f7 ff ff       	jmp    80105b57 <alltraps>

801063bd <vector102>:
.globl vector102
vector102:
  pushl $0
801063bd:	6a 00                	push   $0x0
  pushl $102
801063bf:	6a 66                	push   $0x66
  jmp alltraps
801063c1:	e9 91 f7 ff ff       	jmp    80105b57 <alltraps>

801063c6 <vector103>:
.globl vector103
vector103:
  pushl $0
801063c6:	6a 00                	push   $0x0
  pushl $103
801063c8:	6a 67                	push   $0x67
  jmp alltraps
801063ca:	e9 88 f7 ff ff       	jmp    80105b57 <alltraps>

801063cf <vector104>:
.globl vector104
vector104:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $104
801063d1:	6a 68                	push   $0x68
  jmp alltraps
801063d3:	e9 7f f7 ff ff       	jmp    80105b57 <alltraps>

801063d8 <vector105>:
.globl vector105
vector105:
  pushl $0
801063d8:	6a 00                	push   $0x0
  pushl $105
801063da:	6a 69                	push   $0x69
  jmp alltraps
801063dc:	e9 76 f7 ff ff       	jmp    80105b57 <alltraps>

801063e1 <vector106>:
.globl vector106
vector106:
  pushl $0
801063e1:	6a 00                	push   $0x0
  pushl $106
801063e3:	6a 6a                	push   $0x6a
  jmp alltraps
801063e5:	e9 6d f7 ff ff       	jmp    80105b57 <alltraps>

801063ea <vector107>:
.globl vector107
vector107:
  pushl $0
801063ea:	6a 00                	push   $0x0
  pushl $107
801063ec:	6a 6b                	push   $0x6b
  jmp alltraps
801063ee:	e9 64 f7 ff ff       	jmp    80105b57 <alltraps>

801063f3 <vector108>:
.globl vector108
vector108:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $108
801063f5:	6a 6c                	push   $0x6c
  jmp alltraps
801063f7:	e9 5b f7 ff ff       	jmp    80105b57 <alltraps>

801063fc <vector109>:
.globl vector109
vector109:
  pushl $0
801063fc:	6a 00                	push   $0x0
  pushl $109
801063fe:	6a 6d                	push   $0x6d
  jmp alltraps
80106400:	e9 52 f7 ff ff       	jmp    80105b57 <alltraps>

80106405 <vector110>:
.globl vector110
vector110:
  pushl $0
80106405:	6a 00                	push   $0x0
  pushl $110
80106407:	6a 6e                	push   $0x6e
  jmp alltraps
80106409:	e9 49 f7 ff ff       	jmp    80105b57 <alltraps>

8010640e <vector111>:
.globl vector111
vector111:
  pushl $0
8010640e:	6a 00                	push   $0x0
  pushl $111
80106410:	6a 6f                	push   $0x6f
  jmp alltraps
80106412:	e9 40 f7 ff ff       	jmp    80105b57 <alltraps>

80106417 <vector112>:
.globl vector112
vector112:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $112
80106419:	6a 70                	push   $0x70
  jmp alltraps
8010641b:	e9 37 f7 ff ff       	jmp    80105b57 <alltraps>

80106420 <vector113>:
.globl vector113
vector113:
  pushl $0
80106420:	6a 00                	push   $0x0
  pushl $113
80106422:	6a 71                	push   $0x71
  jmp alltraps
80106424:	e9 2e f7 ff ff       	jmp    80105b57 <alltraps>

80106429 <vector114>:
.globl vector114
vector114:
  pushl $0
80106429:	6a 00                	push   $0x0
  pushl $114
8010642b:	6a 72                	push   $0x72
  jmp alltraps
8010642d:	e9 25 f7 ff ff       	jmp    80105b57 <alltraps>

80106432 <vector115>:
.globl vector115
vector115:
  pushl $0
80106432:	6a 00                	push   $0x0
  pushl $115
80106434:	6a 73                	push   $0x73
  jmp alltraps
80106436:	e9 1c f7 ff ff       	jmp    80105b57 <alltraps>

8010643b <vector116>:
.globl vector116
vector116:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $116
8010643d:	6a 74                	push   $0x74
  jmp alltraps
8010643f:	e9 13 f7 ff ff       	jmp    80105b57 <alltraps>

80106444 <vector117>:
.globl vector117
vector117:
  pushl $0
80106444:	6a 00                	push   $0x0
  pushl $117
80106446:	6a 75                	push   $0x75
  jmp alltraps
80106448:	e9 0a f7 ff ff       	jmp    80105b57 <alltraps>

8010644d <vector118>:
.globl vector118
vector118:
  pushl $0
8010644d:	6a 00                	push   $0x0
  pushl $118
8010644f:	6a 76                	push   $0x76
  jmp alltraps
80106451:	e9 01 f7 ff ff       	jmp    80105b57 <alltraps>

80106456 <vector119>:
.globl vector119
vector119:
  pushl $0
80106456:	6a 00                	push   $0x0
  pushl $119
80106458:	6a 77                	push   $0x77
  jmp alltraps
8010645a:	e9 f8 f6 ff ff       	jmp    80105b57 <alltraps>

8010645f <vector120>:
.globl vector120
vector120:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $120
80106461:	6a 78                	push   $0x78
  jmp alltraps
80106463:	e9 ef f6 ff ff       	jmp    80105b57 <alltraps>

80106468 <vector121>:
.globl vector121
vector121:
  pushl $0
80106468:	6a 00                	push   $0x0
  pushl $121
8010646a:	6a 79                	push   $0x79
  jmp alltraps
8010646c:	e9 e6 f6 ff ff       	jmp    80105b57 <alltraps>

80106471 <vector122>:
.globl vector122
vector122:
  pushl $0
80106471:	6a 00                	push   $0x0
  pushl $122
80106473:	6a 7a                	push   $0x7a
  jmp alltraps
80106475:	e9 dd f6 ff ff       	jmp    80105b57 <alltraps>

8010647a <vector123>:
.globl vector123
vector123:
  pushl $0
8010647a:	6a 00                	push   $0x0
  pushl $123
8010647c:	6a 7b                	push   $0x7b
  jmp alltraps
8010647e:	e9 d4 f6 ff ff       	jmp    80105b57 <alltraps>

80106483 <vector124>:
.globl vector124
vector124:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $124
80106485:	6a 7c                	push   $0x7c
  jmp alltraps
80106487:	e9 cb f6 ff ff       	jmp    80105b57 <alltraps>

8010648c <vector125>:
.globl vector125
vector125:
  pushl $0
8010648c:	6a 00                	push   $0x0
  pushl $125
8010648e:	6a 7d                	push   $0x7d
  jmp alltraps
80106490:	e9 c2 f6 ff ff       	jmp    80105b57 <alltraps>

80106495 <vector126>:
.globl vector126
vector126:
  pushl $0
80106495:	6a 00                	push   $0x0
  pushl $126
80106497:	6a 7e                	push   $0x7e
  jmp alltraps
80106499:	e9 b9 f6 ff ff       	jmp    80105b57 <alltraps>

8010649e <vector127>:
.globl vector127
vector127:
  pushl $0
8010649e:	6a 00                	push   $0x0
  pushl $127
801064a0:	6a 7f                	push   $0x7f
  jmp alltraps
801064a2:	e9 b0 f6 ff ff       	jmp    80105b57 <alltraps>

801064a7 <vector128>:
.globl vector128
vector128:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $128
801064a9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801064ae:	e9 a4 f6 ff ff       	jmp    80105b57 <alltraps>

801064b3 <vector129>:
.globl vector129
vector129:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $129
801064b5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801064ba:	e9 98 f6 ff ff       	jmp    80105b57 <alltraps>

801064bf <vector130>:
.globl vector130
vector130:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $130
801064c1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801064c6:	e9 8c f6 ff ff       	jmp    80105b57 <alltraps>

801064cb <vector131>:
.globl vector131
vector131:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $131
801064cd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801064d2:	e9 80 f6 ff ff       	jmp    80105b57 <alltraps>

801064d7 <vector132>:
.globl vector132
vector132:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $132
801064d9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801064de:	e9 74 f6 ff ff       	jmp    80105b57 <alltraps>

801064e3 <vector133>:
.globl vector133
vector133:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $133
801064e5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801064ea:	e9 68 f6 ff ff       	jmp    80105b57 <alltraps>

801064ef <vector134>:
.globl vector134
vector134:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $134
801064f1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801064f6:	e9 5c f6 ff ff       	jmp    80105b57 <alltraps>

801064fb <vector135>:
.globl vector135
vector135:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $135
801064fd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106502:	e9 50 f6 ff ff       	jmp    80105b57 <alltraps>

80106507 <vector136>:
.globl vector136
vector136:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $136
80106509:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010650e:	e9 44 f6 ff ff       	jmp    80105b57 <alltraps>

80106513 <vector137>:
.globl vector137
vector137:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $137
80106515:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010651a:	e9 38 f6 ff ff       	jmp    80105b57 <alltraps>

8010651f <vector138>:
.globl vector138
vector138:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $138
80106521:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106526:	e9 2c f6 ff ff       	jmp    80105b57 <alltraps>

8010652b <vector139>:
.globl vector139
vector139:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $139
8010652d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106532:	e9 20 f6 ff ff       	jmp    80105b57 <alltraps>

80106537 <vector140>:
.globl vector140
vector140:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $140
80106539:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010653e:	e9 14 f6 ff ff       	jmp    80105b57 <alltraps>

80106543 <vector141>:
.globl vector141
vector141:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $141
80106545:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010654a:	e9 08 f6 ff ff       	jmp    80105b57 <alltraps>

8010654f <vector142>:
.globl vector142
vector142:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $142
80106551:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106556:	e9 fc f5 ff ff       	jmp    80105b57 <alltraps>

8010655b <vector143>:
.globl vector143
vector143:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $143
8010655d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106562:	e9 f0 f5 ff ff       	jmp    80105b57 <alltraps>

80106567 <vector144>:
.globl vector144
vector144:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $144
80106569:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010656e:	e9 e4 f5 ff ff       	jmp    80105b57 <alltraps>

80106573 <vector145>:
.globl vector145
vector145:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $145
80106575:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010657a:	e9 d8 f5 ff ff       	jmp    80105b57 <alltraps>

8010657f <vector146>:
.globl vector146
vector146:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $146
80106581:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106586:	e9 cc f5 ff ff       	jmp    80105b57 <alltraps>

8010658b <vector147>:
.globl vector147
vector147:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $147
8010658d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106592:	e9 c0 f5 ff ff       	jmp    80105b57 <alltraps>

80106597 <vector148>:
.globl vector148
vector148:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $148
80106599:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010659e:	e9 b4 f5 ff ff       	jmp    80105b57 <alltraps>

801065a3 <vector149>:
.globl vector149
vector149:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $149
801065a5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801065aa:	e9 a8 f5 ff ff       	jmp    80105b57 <alltraps>

801065af <vector150>:
.globl vector150
vector150:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $150
801065b1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801065b6:	e9 9c f5 ff ff       	jmp    80105b57 <alltraps>

801065bb <vector151>:
.globl vector151
vector151:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $151
801065bd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801065c2:	e9 90 f5 ff ff       	jmp    80105b57 <alltraps>

801065c7 <vector152>:
.globl vector152
vector152:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $152
801065c9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801065ce:	e9 84 f5 ff ff       	jmp    80105b57 <alltraps>

801065d3 <vector153>:
.globl vector153
vector153:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $153
801065d5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801065da:	e9 78 f5 ff ff       	jmp    80105b57 <alltraps>

801065df <vector154>:
.globl vector154
vector154:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $154
801065e1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801065e6:	e9 6c f5 ff ff       	jmp    80105b57 <alltraps>

801065eb <vector155>:
.globl vector155
vector155:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $155
801065ed:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801065f2:	e9 60 f5 ff ff       	jmp    80105b57 <alltraps>

801065f7 <vector156>:
.globl vector156
vector156:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $156
801065f9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801065fe:	e9 54 f5 ff ff       	jmp    80105b57 <alltraps>

80106603 <vector157>:
.globl vector157
vector157:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $157
80106605:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010660a:	e9 48 f5 ff ff       	jmp    80105b57 <alltraps>

8010660f <vector158>:
.globl vector158
vector158:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $158
80106611:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106616:	e9 3c f5 ff ff       	jmp    80105b57 <alltraps>

8010661b <vector159>:
.globl vector159
vector159:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $159
8010661d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106622:	e9 30 f5 ff ff       	jmp    80105b57 <alltraps>

80106627 <vector160>:
.globl vector160
vector160:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $160
80106629:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010662e:	e9 24 f5 ff ff       	jmp    80105b57 <alltraps>

80106633 <vector161>:
.globl vector161
vector161:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $161
80106635:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010663a:	e9 18 f5 ff ff       	jmp    80105b57 <alltraps>

8010663f <vector162>:
.globl vector162
vector162:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $162
80106641:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106646:	e9 0c f5 ff ff       	jmp    80105b57 <alltraps>

8010664b <vector163>:
.globl vector163
vector163:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $163
8010664d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106652:	e9 00 f5 ff ff       	jmp    80105b57 <alltraps>

80106657 <vector164>:
.globl vector164
vector164:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $164
80106659:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010665e:	e9 f4 f4 ff ff       	jmp    80105b57 <alltraps>

80106663 <vector165>:
.globl vector165
vector165:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $165
80106665:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010666a:	e9 e8 f4 ff ff       	jmp    80105b57 <alltraps>

8010666f <vector166>:
.globl vector166
vector166:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $166
80106671:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106676:	e9 dc f4 ff ff       	jmp    80105b57 <alltraps>

8010667b <vector167>:
.globl vector167
vector167:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $167
8010667d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106682:	e9 d0 f4 ff ff       	jmp    80105b57 <alltraps>

80106687 <vector168>:
.globl vector168
vector168:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $168
80106689:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010668e:	e9 c4 f4 ff ff       	jmp    80105b57 <alltraps>

80106693 <vector169>:
.globl vector169
vector169:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $169
80106695:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010669a:	e9 b8 f4 ff ff       	jmp    80105b57 <alltraps>

8010669f <vector170>:
.globl vector170
vector170:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $170
801066a1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801066a6:	e9 ac f4 ff ff       	jmp    80105b57 <alltraps>

801066ab <vector171>:
.globl vector171
vector171:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $171
801066ad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801066b2:	e9 a0 f4 ff ff       	jmp    80105b57 <alltraps>

801066b7 <vector172>:
.globl vector172
vector172:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $172
801066b9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801066be:	e9 94 f4 ff ff       	jmp    80105b57 <alltraps>

801066c3 <vector173>:
.globl vector173
vector173:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $173
801066c5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801066ca:	e9 88 f4 ff ff       	jmp    80105b57 <alltraps>

801066cf <vector174>:
.globl vector174
vector174:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $174
801066d1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801066d6:	e9 7c f4 ff ff       	jmp    80105b57 <alltraps>

801066db <vector175>:
.globl vector175
vector175:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $175
801066dd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801066e2:	e9 70 f4 ff ff       	jmp    80105b57 <alltraps>

801066e7 <vector176>:
.globl vector176
vector176:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $176
801066e9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801066ee:	e9 64 f4 ff ff       	jmp    80105b57 <alltraps>

801066f3 <vector177>:
.globl vector177
vector177:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $177
801066f5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801066fa:	e9 58 f4 ff ff       	jmp    80105b57 <alltraps>

801066ff <vector178>:
.globl vector178
vector178:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $178
80106701:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106706:	e9 4c f4 ff ff       	jmp    80105b57 <alltraps>

8010670b <vector179>:
.globl vector179
vector179:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $179
8010670d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106712:	e9 40 f4 ff ff       	jmp    80105b57 <alltraps>

80106717 <vector180>:
.globl vector180
vector180:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $180
80106719:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010671e:	e9 34 f4 ff ff       	jmp    80105b57 <alltraps>

80106723 <vector181>:
.globl vector181
vector181:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $181
80106725:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010672a:	e9 28 f4 ff ff       	jmp    80105b57 <alltraps>

8010672f <vector182>:
.globl vector182
vector182:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $182
80106731:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106736:	e9 1c f4 ff ff       	jmp    80105b57 <alltraps>

8010673b <vector183>:
.globl vector183
vector183:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $183
8010673d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106742:	e9 10 f4 ff ff       	jmp    80105b57 <alltraps>

80106747 <vector184>:
.globl vector184
vector184:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $184
80106749:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010674e:	e9 04 f4 ff ff       	jmp    80105b57 <alltraps>

80106753 <vector185>:
.globl vector185
vector185:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $185
80106755:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010675a:	e9 f8 f3 ff ff       	jmp    80105b57 <alltraps>

8010675f <vector186>:
.globl vector186
vector186:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $186
80106761:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106766:	e9 ec f3 ff ff       	jmp    80105b57 <alltraps>

8010676b <vector187>:
.globl vector187
vector187:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $187
8010676d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106772:	e9 e0 f3 ff ff       	jmp    80105b57 <alltraps>

80106777 <vector188>:
.globl vector188
vector188:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $188
80106779:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010677e:	e9 d4 f3 ff ff       	jmp    80105b57 <alltraps>

80106783 <vector189>:
.globl vector189
vector189:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $189
80106785:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010678a:	e9 c8 f3 ff ff       	jmp    80105b57 <alltraps>

8010678f <vector190>:
.globl vector190
vector190:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $190
80106791:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106796:	e9 bc f3 ff ff       	jmp    80105b57 <alltraps>

8010679b <vector191>:
.globl vector191
vector191:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $191
8010679d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801067a2:	e9 b0 f3 ff ff       	jmp    80105b57 <alltraps>

801067a7 <vector192>:
.globl vector192
vector192:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $192
801067a9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801067ae:	e9 a4 f3 ff ff       	jmp    80105b57 <alltraps>

801067b3 <vector193>:
.globl vector193
vector193:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $193
801067b5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801067ba:	e9 98 f3 ff ff       	jmp    80105b57 <alltraps>

801067bf <vector194>:
.globl vector194
vector194:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $194
801067c1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801067c6:	e9 8c f3 ff ff       	jmp    80105b57 <alltraps>

801067cb <vector195>:
.globl vector195
vector195:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $195
801067cd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801067d2:	e9 80 f3 ff ff       	jmp    80105b57 <alltraps>

801067d7 <vector196>:
.globl vector196
vector196:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $196
801067d9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801067de:	e9 74 f3 ff ff       	jmp    80105b57 <alltraps>

801067e3 <vector197>:
.globl vector197
vector197:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $197
801067e5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801067ea:	e9 68 f3 ff ff       	jmp    80105b57 <alltraps>

801067ef <vector198>:
.globl vector198
vector198:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $198
801067f1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801067f6:	e9 5c f3 ff ff       	jmp    80105b57 <alltraps>

801067fb <vector199>:
.globl vector199
vector199:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $199
801067fd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106802:	e9 50 f3 ff ff       	jmp    80105b57 <alltraps>

80106807 <vector200>:
.globl vector200
vector200:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $200
80106809:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010680e:	e9 44 f3 ff ff       	jmp    80105b57 <alltraps>

80106813 <vector201>:
.globl vector201
vector201:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $201
80106815:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010681a:	e9 38 f3 ff ff       	jmp    80105b57 <alltraps>

8010681f <vector202>:
.globl vector202
vector202:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $202
80106821:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106826:	e9 2c f3 ff ff       	jmp    80105b57 <alltraps>

8010682b <vector203>:
.globl vector203
vector203:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $203
8010682d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106832:	e9 20 f3 ff ff       	jmp    80105b57 <alltraps>

80106837 <vector204>:
.globl vector204
vector204:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $204
80106839:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010683e:	e9 14 f3 ff ff       	jmp    80105b57 <alltraps>

80106843 <vector205>:
.globl vector205
vector205:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $205
80106845:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010684a:	e9 08 f3 ff ff       	jmp    80105b57 <alltraps>

8010684f <vector206>:
.globl vector206
vector206:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $206
80106851:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106856:	e9 fc f2 ff ff       	jmp    80105b57 <alltraps>

8010685b <vector207>:
.globl vector207
vector207:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $207
8010685d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106862:	e9 f0 f2 ff ff       	jmp    80105b57 <alltraps>

80106867 <vector208>:
.globl vector208
vector208:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $208
80106869:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010686e:	e9 e4 f2 ff ff       	jmp    80105b57 <alltraps>

80106873 <vector209>:
.globl vector209
vector209:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $209
80106875:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010687a:	e9 d8 f2 ff ff       	jmp    80105b57 <alltraps>

8010687f <vector210>:
.globl vector210
vector210:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $210
80106881:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106886:	e9 cc f2 ff ff       	jmp    80105b57 <alltraps>

8010688b <vector211>:
.globl vector211
vector211:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $211
8010688d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106892:	e9 c0 f2 ff ff       	jmp    80105b57 <alltraps>

80106897 <vector212>:
.globl vector212
vector212:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $212
80106899:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010689e:	e9 b4 f2 ff ff       	jmp    80105b57 <alltraps>

801068a3 <vector213>:
.globl vector213
vector213:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $213
801068a5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801068aa:	e9 a8 f2 ff ff       	jmp    80105b57 <alltraps>

801068af <vector214>:
.globl vector214
vector214:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $214
801068b1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801068b6:	e9 9c f2 ff ff       	jmp    80105b57 <alltraps>

801068bb <vector215>:
.globl vector215
vector215:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $215
801068bd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801068c2:	e9 90 f2 ff ff       	jmp    80105b57 <alltraps>

801068c7 <vector216>:
.globl vector216
vector216:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $216
801068c9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801068ce:	e9 84 f2 ff ff       	jmp    80105b57 <alltraps>

801068d3 <vector217>:
.globl vector217
vector217:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $217
801068d5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801068da:	e9 78 f2 ff ff       	jmp    80105b57 <alltraps>

801068df <vector218>:
.globl vector218
vector218:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $218
801068e1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801068e6:	e9 6c f2 ff ff       	jmp    80105b57 <alltraps>

801068eb <vector219>:
.globl vector219
vector219:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $219
801068ed:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801068f2:	e9 60 f2 ff ff       	jmp    80105b57 <alltraps>

801068f7 <vector220>:
.globl vector220
vector220:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $220
801068f9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801068fe:	e9 54 f2 ff ff       	jmp    80105b57 <alltraps>

80106903 <vector221>:
.globl vector221
vector221:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $221
80106905:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010690a:	e9 48 f2 ff ff       	jmp    80105b57 <alltraps>

8010690f <vector222>:
.globl vector222
vector222:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $222
80106911:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106916:	e9 3c f2 ff ff       	jmp    80105b57 <alltraps>

8010691b <vector223>:
.globl vector223
vector223:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $223
8010691d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106922:	e9 30 f2 ff ff       	jmp    80105b57 <alltraps>

80106927 <vector224>:
.globl vector224
vector224:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $224
80106929:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010692e:	e9 24 f2 ff ff       	jmp    80105b57 <alltraps>

80106933 <vector225>:
.globl vector225
vector225:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $225
80106935:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010693a:	e9 18 f2 ff ff       	jmp    80105b57 <alltraps>

8010693f <vector226>:
.globl vector226
vector226:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $226
80106941:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106946:	e9 0c f2 ff ff       	jmp    80105b57 <alltraps>

8010694b <vector227>:
.globl vector227
vector227:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $227
8010694d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106952:	e9 00 f2 ff ff       	jmp    80105b57 <alltraps>

80106957 <vector228>:
.globl vector228
vector228:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $228
80106959:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010695e:	e9 f4 f1 ff ff       	jmp    80105b57 <alltraps>

80106963 <vector229>:
.globl vector229
vector229:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $229
80106965:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010696a:	e9 e8 f1 ff ff       	jmp    80105b57 <alltraps>

8010696f <vector230>:
.globl vector230
vector230:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $230
80106971:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106976:	e9 dc f1 ff ff       	jmp    80105b57 <alltraps>

8010697b <vector231>:
.globl vector231
vector231:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $231
8010697d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106982:	e9 d0 f1 ff ff       	jmp    80105b57 <alltraps>

80106987 <vector232>:
.globl vector232
vector232:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $232
80106989:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010698e:	e9 c4 f1 ff ff       	jmp    80105b57 <alltraps>

80106993 <vector233>:
.globl vector233
vector233:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $233
80106995:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010699a:	e9 b8 f1 ff ff       	jmp    80105b57 <alltraps>

8010699f <vector234>:
.globl vector234
vector234:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $234
801069a1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801069a6:	e9 ac f1 ff ff       	jmp    80105b57 <alltraps>

801069ab <vector235>:
.globl vector235
vector235:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $235
801069ad:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801069b2:	e9 a0 f1 ff ff       	jmp    80105b57 <alltraps>

801069b7 <vector236>:
.globl vector236
vector236:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $236
801069b9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801069be:	e9 94 f1 ff ff       	jmp    80105b57 <alltraps>

801069c3 <vector237>:
.globl vector237
vector237:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $237
801069c5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801069ca:	e9 88 f1 ff ff       	jmp    80105b57 <alltraps>

801069cf <vector238>:
.globl vector238
vector238:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $238
801069d1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801069d6:	e9 7c f1 ff ff       	jmp    80105b57 <alltraps>

801069db <vector239>:
.globl vector239
vector239:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $239
801069dd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801069e2:	e9 70 f1 ff ff       	jmp    80105b57 <alltraps>

801069e7 <vector240>:
.globl vector240
vector240:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $240
801069e9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801069ee:	e9 64 f1 ff ff       	jmp    80105b57 <alltraps>

801069f3 <vector241>:
.globl vector241
vector241:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $241
801069f5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801069fa:	e9 58 f1 ff ff       	jmp    80105b57 <alltraps>

801069ff <vector242>:
.globl vector242
vector242:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $242
80106a01:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106a06:	e9 4c f1 ff ff       	jmp    80105b57 <alltraps>

80106a0b <vector243>:
.globl vector243
vector243:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $243
80106a0d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106a12:	e9 40 f1 ff ff       	jmp    80105b57 <alltraps>

80106a17 <vector244>:
.globl vector244
vector244:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $244
80106a19:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106a1e:	e9 34 f1 ff ff       	jmp    80105b57 <alltraps>

80106a23 <vector245>:
.globl vector245
vector245:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $245
80106a25:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106a2a:	e9 28 f1 ff ff       	jmp    80105b57 <alltraps>

80106a2f <vector246>:
.globl vector246
vector246:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $246
80106a31:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106a36:	e9 1c f1 ff ff       	jmp    80105b57 <alltraps>

80106a3b <vector247>:
.globl vector247
vector247:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $247
80106a3d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a42:	e9 10 f1 ff ff       	jmp    80105b57 <alltraps>

80106a47 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $248
80106a49:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a4e:	e9 04 f1 ff ff       	jmp    80105b57 <alltraps>

80106a53 <vector249>:
.globl vector249
vector249:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $249
80106a55:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106a5a:	e9 f8 f0 ff ff       	jmp    80105b57 <alltraps>

80106a5f <vector250>:
.globl vector250
vector250:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $250
80106a61:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106a66:	e9 ec f0 ff ff       	jmp    80105b57 <alltraps>

80106a6b <vector251>:
.globl vector251
vector251:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $251
80106a6d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106a72:	e9 e0 f0 ff ff       	jmp    80105b57 <alltraps>

80106a77 <vector252>:
.globl vector252
vector252:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $252
80106a79:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106a7e:	e9 d4 f0 ff ff       	jmp    80105b57 <alltraps>

80106a83 <vector253>:
.globl vector253
vector253:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $253
80106a85:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106a8a:	e9 c8 f0 ff ff       	jmp    80105b57 <alltraps>

80106a8f <vector254>:
.globl vector254
vector254:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $254
80106a91:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106a96:	e9 bc f0 ff ff       	jmp    80105b57 <alltraps>

80106a9b <vector255>:
.globl vector255
vector255:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $255
80106a9d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106aa2:	e9 b0 f0 ff ff       	jmp    80105b57 <alltraps>
80106aa7:	66 90                	xchg   %ax,%ax
80106aa9:	66 90                	xchg   %ax,%ax
80106aab:	66 90                	xchg   %ax,%ax
80106aad:	66 90                	xchg   %ax,%ax
80106aaf:	90                   	nop

80106ab0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	57                   	push   %edi
80106ab4:	56                   	push   %esi
80106ab5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106ab6:	89 d3                	mov    %edx,%ebx
{
80106ab8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106aba:	c1 eb 16             	shr    $0x16,%ebx
80106abd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106ac0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106ac3:	8b 06                	mov    (%esi),%eax
80106ac5:	a8 01                	test   $0x1,%al
80106ac7:	74 27                	je     80106af0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ac9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ace:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106ad4:	c1 ef 0a             	shr    $0xa,%edi
}
80106ad7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106ada:	89 fa                	mov    %edi,%edx
80106adc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106ae2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106ae5:	5b                   	pop    %ebx
80106ae6:	5e                   	pop    %esi
80106ae7:	5f                   	pop    %edi
80106ae8:	5d                   	pop    %ebp
80106ae9:	c3                   	ret    
80106aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106af0:	85 c9                	test   %ecx,%ecx
80106af2:	74 2c                	je     80106b20 <walkpgdir+0x70>
80106af4:	e8 e7 b9 ff ff       	call   801024e0 <kalloc>
80106af9:	85 c0                	test   %eax,%eax
80106afb:	89 c3                	mov    %eax,%ebx
80106afd:	74 21                	je     80106b20 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106aff:	83 ec 04             	sub    $0x4,%esp
80106b02:	68 00 10 00 00       	push   $0x1000
80106b07:	6a 00                	push   $0x0
80106b09:	50                   	push   %eax
80106b0a:	e8 b1 dd ff ff       	call   801048c0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b0f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b15:	83 c4 10             	add    $0x10,%esp
80106b18:	83 c8 07             	or     $0x7,%eax
80106b1b:	89 06                	mov    %eax,(%esi)
80106b1d:	eb b5                	jmp    80106ad4 <walkpgdir+0x24>
80106b1f:	90                   	nop
}
80106b20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106b23:	31 c0                	xor    %eax,%eax
}
80106b25:	5b                   	pop    %ebx
80106b26:	5e                   	pop    %esi
80106b27:	5f                   	pop    %edi
80106b28:	5d                   	pop    %ebp
80106b29:	c3                   	ret    
80106b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b30 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	57                   	push   %edi
80106b34:	56                   	push   %esi
80106b35:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106b36:	89 d3                	mov    %edx,%ebx
80106b38:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106b3e:	83 ec 1c             	sub    $0x1c,%esp
80106b41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106b44:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106b48:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b4b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b50:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106b53:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b56:	29 df                	sub    %ebx,%edi
80106b58:	83 c8 01             	or     $0x1,%eax
80106b5b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106b5e:	eb 15                	jmp    80106b75 <mappages+0x45>
    if(*pte & PTE_P)
80106b60:	f6 00 01             	testb  $0x1,(%eax)
80106b63:	75 45                	jne    80106baa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106b65:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106b68:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106b6b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106b6d:	74 31                	je     80106ba0 <mappages+0x70>
      break;
    a += PGSIZE;
80106b6f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106b75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b78:	b9 01 00 00 00       	mov    $0x1,%ecx
80106b7d:	89 da                	mov    %ebx,%edx
80106b7f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106b82:	e8 29 ff ff ff       	call   80106ab0 <walkpgdir>
80106b87:	85 c0                	test   %eax,%eax
80106b89:	75 d5                	jne    80106b60 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106b8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106b8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b93:	5b                   	pop    %ebx
80106b94:	5e                   	pop    %esi
80106b95:	5f                   	pop    %edi
80106b96:	5d                   	pop    %ebp
80106b97:	c3                   	ret    
80106b98:	90                   	nop
80106b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ba3:	31 c0                	xor    %eax,%eax
}
80106ba5:	5b                   	pop    %ebx
80106ba6:	5e                   	pop    %esi
80106ba7:	5f                   	pop    %edi
80106ba8:	5d                   	pop    %ebp
80106ba9:	c3                   	ret    
      panic("remap");
80106baa:	83 ec 0c             	sub    $0xc,%esp
80106bad:	68 f8 7c 10 80       	push   $0x80107cf8
80106bb2:	e8 d9 97 ff ff       	call   80100390 <panic>
80106bb7:	89 f6                	mov    %esi,%esi
80106bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bc0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	57                   	push   %edi
80106bc4:	56                   	push   %esi
80106bc5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106bc6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106bcc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106bce:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106bd4:	83 ec 1c             	sub    $0x1c,%esp
80106bd7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106bda:	39 d3                	cmp    %edx,%ebx
80106bdc:	73 66                	jae    80106c44 <deallocuvm.part.0+0x84>
80106bde:	89 d6                	mov    %edx,%esi
80106be0:	eb 3d                	jmp    80106c1f <deallocuvm.part.0+0x5f>
80106be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106be8:	8b 10                	mov    (%eax),%edx
80106bea:	f6 c2 01             	test   $0x1,%dl
80106bed:	74 26                	je     80106c15 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106bef:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106bf5:	74 58                	je     80106c4f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106bf7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106bfa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106c00:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106c03:	52                   	push   %edx
80106c04:	e8 27 b7 ff ff       	call   80102330 <kfree>
      *pte = 0;
80106c09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c0c:	83 c4 10             	add    $0x10,%esp
80106c0f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106c15:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c1b:	39 f3                	cmp    %esi,%ebx
80106c1d:	73 25                	jae    80106c44 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106c1f:	31 c9                	xor    %ecx,%ecx
80106c21:	89 da                	mov    %ebx,%edx
80106c23:	89 f8                	mov    %edi,%eax
80106c25:	e8 86 fe ff ff       	call   80106ab0 <walkpgdir>
    if(!pte)
80106c2a:	85 c0                	test   %eax,%eax
80106c2c:	75 ba                	jne    80106be8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106c2e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106c34:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106c3a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c40:	39 f3                	cmp    %esi,%ebx
80106c42:	72 db                	jb     80106c1f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106c44:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c4a:	5b                   	pop    %ebx
80106c4b:	5e                   	pop    %esi
80106c4c:	5f                   	pop    %edi
80106c4d:	5d                   	pop    %ebp
80106c4e:	c3                   	ret    
        panic("kfree");
80106c4f:	83 ec 0c             	sub    $0xc,%esp
80106c52:	68 46 76 10 80       	push   $0x80107646
80106c57:	e8 34 97 ff ff       	call   80100390 <panic>
80106c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c60 <seginit>:
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106c66:	e8 25 cc ff ff       	call   80103890 <cpuid>
80106c6b:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
80106c71:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106c76:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c7a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106c81:	ff 00 00 
80106c84:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106c8b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c8e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106c95:	ff 00 00 
80106c98:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106c9f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ca2:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106ca9:	ff 00 00 
80106cac:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106cb3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106cb6:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106cbd:	ff 00 00 
80106cc0:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106cc7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106cca:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106ccf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106cd3:	c1 e8 10             	shr    $0x10,%eax
80106cd6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106cda:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106cdd:	0f 01 10             	lgdtl  (%eax)
}
80106ce0:	c9                   	leave  
80106ce1:	c3                   	ret    
80106ce2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cf0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106cf0:	a1 c4 f1 11 80       	mov    0x8011f1c4,%eax
{
80106cf5:	55                   	push   %ebp
80106cf6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106cf8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106cfd:	0f 22 d8             	mov    %eax,%cr3
}
80106d00:	5d                   	pop    %ebp
80106d01:	c3                   	ret    
80106d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d10 <switchuvm>:
{
80106d10:	55                   	push   %ebp
80106d11:	89 e5                	mov    %esp,%ebp
80106d13:	57                   	push   %edi
80106d14:	56                   	push   %esi
80106d15:	53                   	push   %ebx
80106d16:	83 ec 1c             	sub    $0x1c,%esp
80106d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106d1c:	85 db                	test   %ebx,%ebx
80106d1e:	0f 84 cb 00 00 00    	je     80106def <switchuvm+0xdf>
  if(p->kstack == 0)
80106d24:	8b 43 08             	mov    0x8(%ebx),%eax
80106d27:	85 c0                	test   %eax,%eax
80106d29:	0f 84 da 00 00 00    	je     80106e09 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106d2f:	8b 43 04             	mov    0x4(%ebx),%eax
80106d32:	85 c0                	test   %eax,%eax
80106d34:	0f 84 c2 00 00 00    	je     80106dfc <switchuvm+0xec>
  pushcli();
80106d3a:	e8 a1 d9 ff ff       	call   801046e0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d3f:	e8 cc ca ff ff       	call   80103810 <mycpu>
80106d44:	89 c6                	mov    %eax,%esi
80106d46:	e8 c5 ca ff ff       	call   80103810 <mycpu>
80106d4b:	89 c7                	mov    %eax,%edi
80106d4d:	e8 be ca ff ff       	call   80103810 <mycpu>
80106d52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d55:	83 c7 08             	add    $0x8,%edi
80106d58:	e8 b3 ca ff ff       	call   80103810 <mycpu>
80106d5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d60:	83 c0 08             	add    $0x8,%eax
80106d63:	ba 67 00 00 00       	mov    $0x67,%edx
80106d68:	c1 e8 18             	shr    $0x18,%eax
80106d6b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106d72:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106d79:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d7f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d84:	83 c1 08             	add    $0x8,%ecx
80106d87:	c1 e9 10             	shr    $0x10,%ecx
80106d8a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106d90:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106d95:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d9c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106da1:	e8 6a ca ff ff       	call   80103810 <mycpu>
80106da6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106dad:	e8 5e ca ff ff       	call   80103810 <mycpu>
80106db2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106db6:	8b 73 08             	mov    0x8(%ebx),%esi
80106db9:	e8 52 ca ff ff       	call   80103810 <mycpu>
80106dbe:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106dc4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106dc7:	e8 44 ca ff ff       	call   80103810 <mycpu>
80106dcc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106dd0:	b8 28 00 00 00       	mov    $0x28,%eax
80106dd5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106dd8:	8b 43 04             	mov    0x4(%ebx),%eax
80106ddb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106de0:	0f 22 d8             	mov    %eax,%cr3
}
80106de3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de6:	5b                   	pop    %ebx
80106de7:	5e                   	pop    %esi
80106de8:	5f                   	pop    %edi
80106de9:	5d                   	pop    %ebp
  popcli();
80106dea:	e9 31 d9 ff ff       	jmp    80104720 <popcli>
    panic("switchuvm: no process");
80106def:	83 ec 0c             	sub    $0xc,%esp
80106df2:	68 fe 7c 10 80       	push   $0x80107cfe
80106df7:	e8 94 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106dfc:	83 ec 0c             	sub    $0xc,%esp
80106dff:	68 29 7d 10 80       	push   $0x80107d29
80106e04:	e8 87 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106e09:	83 ec 0c             	sub    $0xc,%esp
80106e0c:	68 14 7d 10 80       	push   $0x80107d14
80106e11:	e8 7a 95 ff ff       	call   80100390 <panic>
80106e16:	8d 76 00             	lea    0x0(%esi),%esi
80106e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e20 <inituvm>:
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	57                   	push   %edi
80106e24:	56                   	push   %esi
80106e25:	53                   	push   %ebx
80106e26:	83 ec 1c             	sub    $0x1c,%esp
80106e29:	8b 75 10             	mov    0x10(%ebp),%esi
80106e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106e32:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106e38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106e3b:	77 49                	ja     80106e86 <inituvm+0x66>
  mem = kalloc();
80106e3d:	e8 9e b6 ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
80106e42:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106e45:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e47:	68 00 10 00 00       	push   $0x1000
80106e4c:	6a 00                	push   $0x0
80106e4e:	50                   	push   %eax
80106e4f:	e8 6c da ff ff       	call   801048c0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e54:	58                   	pop    %eax
80106e55:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e5b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e60:	5a                   	pop    %edx
80106e61:	6a 06                	push   $0x6
80106e63:	50                   	push   %eax
80106e64:	31 d2                	xor    %edx,%edx
80106e66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e69:	e8 c2 fc ff ff       	call   80106b30 <mappages>
  memmove(mem, init, sz);
80106e6e:	89 75 10             	mov    %esi,0x10(%ebp)
80106e71:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106e74:	83 c4 10             	add    $0x10,%esp
80106e77:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106e7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e7d:	5b                   	pop    %ebx
80106e7e:	5e                   	pop    %esi
80106e7f:	5f                   	pop    %edi
80106e80:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106e81:	e9 ea da ff ff       	jmp    80104970 <memmove>
    panic("inituvm: more than a page");
80106e86:	83 ec 0c             	sub    $0xc,%esp
80106e89:	68 3d 7d 10 80       	push   $0x80107d3d
80106e8e:	e8 fd 94 ff ff       	call   80100390 <panic>
80106e93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ea0 <loaduvm>:
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	57                   	push   %edi
80106ea4:	56                   	push   %esi
80106ea5:	53                   	push   %ebx
80106ea6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106ea9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106eb0:	0f 85 91 00 00 00    	jne    80106f47 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106eb6:	8b 75 18             	mov    0x18(%ebp),%esi
80106eb9:	31 db                	xor    %ebx,%ebx
80106ebb:	85 f6                	test   %esi,%esi
80106ebd:	75 1a                	jne    80106ed9 <loaduvm+0x39>
80106ebf:	eb 6f                	jmp    80106f30 <loaduvm+0x90>
80106ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ec8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ece:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ed4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ed7:	76 57                	jbe    80106f30 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ed9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106edc:	8b 45 08             	mov    0x8(%ebp),%eax
80106edf:	31 c9                	xor    %ecx,%ecx
80106ee1:	01 da                	add    %ebx,%edx
80106ee3:	e8 c8 fb ff ff       	call   80106ab0 <walkpgdir>
80106ee8:	85 c0                	test   %eax,%eax
80106eea:	74 4e                	je     80106f3a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106eec:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106eee:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106ef1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106ef6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106efb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106f01:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f04:	01 d9                	add    %ebx,%ecx
80106f06:	05 00 00 00 80       	add    $0x80000000,%eax
80106f0b:	57                   	push   %edi
80106f0c:	51                   	push   %ecx
80106f0d:	50                   	push   %eax
80106f0e:	ff 75 10             	pushl  0x10(%ebp)
80106f11:	e8 6a aa ff ff       	call   80101980 <readi>
80106f16:	83 c4 10             	add    $0x10,%esp
80106f19:	39 f8                	cmp    %edi,%eax
80106f1b:	74 ab                	je     80106ec8 <loaduvm+0x28>
}
80106f1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f25:	5b                   	pop    %ebx
80106f26:	5e                   	pop    %esi
80106f27:	5f                   	pop    %edi
80106f28:	5d                   	pop    %ebp
80106f29:	c3                   	ret    
80106f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f33:	31 c0                	xor    %eax,%eax
}
80106f35:	5b                   	pop    %ebx
80106f36:	5e                   	pop    %esi
80106f37:	5f                   	pop    %edi
80106f38:	5d                   	pop    %ebp
80106f39:	c3                   	ret    
      panic("loaduvm: address should exist");
80106f3a:	83 ec 0c             	sub    $0xc,%esp
80106f3d:	68 57 7d 10 80       	push   $0x80107d57
80106f42:	e8 49 94 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106f47:	83 ec 0c             	sub    $0xc,%esp
80106f4a:	68 f8 7d 10 80       	push   $0x80107df8
80106f4f:	e8 3c 94 ff ff       	call   80100390 <panic>
80106f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f60 <allocuvm>:
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	57                   	push   %edi
80106f64:	56                   	push   %esi
80106f65:	53                   	push   %ebx
80106f66:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106f69:	8b 7d 10             	mov    0x10(%ebp),%edi
80106f6c:	85 ff                	test   %edi,%edi
80106f6e:	0f 88 8e 00 00 00    	js     80107002 <allocuvm+0xa2>
  if(newsz < oldsz)
80106f74:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106f77:	0f 82 93 00 00 00    	jb     80107010 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f80:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106f86:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106f8c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106f8f:	0f 86 7e 00 00 00    	jbe    80107013 <allocuvm+0xb3>
80106f95:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106f98:	8b 7d 08             	mov    0x8(%ebp),%edi
80106f9b:	eb 42                	jmp    80106fdf <allocuvm+0x7f>
80106f9d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106fa0:	83 ec 04             	sub    $0x4,%esp
80106fa3:	68 00 10 00 00       	push   $0x1000
80106fa8:	6a 00                	push   $0x0
80106faa:	50                   	push   %eax
80106fab:	e8 10 d9 ff ff       	call   801048c0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106fb0:	58                   	pop    %eax
80106fb1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106fb7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fbc:	5a                   	pop    %edx
80106fbd:	6a 06                	push   $0x6
80106fbf:	50                   	push   %eax
80106fc0:	89 da                	mov    %ebx,%edx
80106fc2:	89 f8                	mov    %edi,%eax
80106fc4:	e8 67 fb ff ff       	call   80106b30 <mappages>
80106fc9:	83 c4 10             	add    $0x10,%esp
80106fcc:	85 c0                	test   %eax,%eax
80106fce:	78 50                	js     80107020 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106fd0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fd6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106fd9:	0f 86 81 00 00 00    	jbe    80107060 <allocuvm+0x100>
    mem = kalloc();
80106fdf:	e8 fc b4 ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
80106fe4:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106fe6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106fe8:	75 b6                	jne    80106fa0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106fea:	83 ec 0c             	sub    $0xc,%esp
80106fed:	68 75 7d 10 80       	push   $0x80107d75
80106ff2:	e8 69 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106ff7:	83 c4 10             	add    $0x10,%esp
80106ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ffd:	39 45 10             	cmp    %eax,0x10(%ebp)
80107000:	77 6e                	ja     80107070 <allocuvm+0x110>
}
80107002:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107005:	31 ff                	xor    %edi,%edi
}
80107007:	89 f8                	mov    %edi,%eax
80107009:	5b                   	pop    %ebx
8010700a:	5e                   	pop    %esi
8010700b:	5f                   	pop    %edi
8010700c:	5d                   	pop    %ebp
8010700d:	c3                   	ret    
8010700e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107010:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107013:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107016:	89 f8                	mov    %edi,%eax
80107018:	5b                   	pop    %ebx
80107019:	5e                   	pop    %esi
8010701a:	5f                   	pop    %edi
8010701b:	5d                   	pop    %ebp
8010701c:	c3                   	ret    
8010701d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107020:	83 ec 0c             	sub    $0xc,%esp
80107023:	68 8d 7d 10 80       	push   $0x80107d8d
80107028:	e8 33 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010702d:	83 c4 10             	add    $0x10,%esp
80107030:	8b 45 0c             	mov    0xc(%ebp),%eax
80107033:	39 45 10             	cmp    %eax,0x10(%ebp)
80107036:	76 0d                	jbe    80107045 <allocuvm+0xe5>
80107038:	89 c1                	mov    %eax,%ecx
8010703a:	8b 55 10             	mov    0x10(%ebp),%edx
8010703d:	8b 45 08             	mov    0x8(%ebp),%eax
80107040:	e8 7b fb ff ff       	call   80106bc0 <deallocuvm.part.0>
      kfree(mem);
80107045:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107048:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010704a:	56                   	push   %esi
8010704b:	e8 e0 b2 ff ff       	call   80102330 <kfree>
      return 0;
80107050:	83 c4 10             	add    $0x10,%esp
}
80107053:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107056:	89 f8                	mov    %edi,%eax
80107058:	5b                   	pop    %ebx
80107059:	5e                   	pop    %esi
8010705a:	5f                   	pop    %edi
8010705b:	5d                   	pop    %ebp
8010705c:	c3                   	ret    
8010705d:	8d 76 00             	lea    0x0(%esi),%esi
80107060:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107063:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107066:	5b                   	pop    %ebx
80107067:	89 f8                	mov    %edi,%eax
80107069:	5e                   	pop    %esi
8010706a:	5f                   	pop    %edi
8010706b:	5d                   	pop    %ebp
8010706c:	c3                   	ret    
8010706d:	8d 76 00             	lea    0x0(%esi),%esi
80107070:	89 c1                	mov    %eax,%ecx
80107072:	8b 55 10             	mov    0x10(%ebp),%edx
80107075:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107078:	31 ff                	xor    %edi,%edi
8010707a:	e8 41 fb ff ff       	call   80106bc0 <deallocuvm.part.0>
8010707f:	eb 92                	jmp    80107013 <allocuvm+0xb3>
80107081:	eb 0d                	jmp    80107090 <deallocuvm>
80107083:	90                   	nop
80107084:	90                   	nop
80107085:	90                   	nop
80107086:	90                   	nop
80107087:	90                   	nop
80107088:	90                   	nop
80107089:	90                   	nop
8010708a:	90                   	nop
8010708b:	90                   	nop
8010708c:	90                   	nop
8010708d:	90                   	nop
8010708e:	90                   	nop
8010708f:	90                   	nop

80107090 <deallocuvm>:
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	8b 55 0c             	mov    0xc(%ebp),%edx
80107096:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107099:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010709c:	39 d1                	cmp    %edx,%ecx
8010709e:	73 10                	jae    801070b0 <deallocuvm+0x20>
}
801070a0:	5d                   	pop    %ebp
801070a1:	e9 1a fb ff ff       	jmp    80106bc0 <deallocuvm.part.0>
801070a6:	8d 76 00             	lea    0x0(%esi),%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801070b0:	89 d0                	mov    %edx,%eax
801070b2:	5d                   	pop    %ebp
801070b3:	c3                   	ret    
801070b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801070c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801070c0:	55                   	push   %ebp
801070c1:	89 e5                	mov    %esp,%ebp
801070c3:	57                   	push   %edi
801070c4:	56                   	push   %esi
801070c5:	53                   	push   %ebx
801070c6:	83 ec 0c             	sub    $0xc,%esp
801070c9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801070cc:	85 f6                	test   %esi,%esi
801070ce:	74 59                	je     80107129 <freevm+0x69>
801070d0:	31 c9                	xor    %ecx,%ecx
801070d2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801070d7:	89 f0                	mov    %esi,%eax
801070d9:	e8 e2 fa ff ff       	call   80106bc0 <deallocuvm.part.0>
801070de:	89 f3                	mov    %esi,%ebx
801070e0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801070e6:	eb 0f                	jmp    801070f7 <freevm+0x37>
801070e8:	90                   	nop
801070e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070f0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070f3:	39 fb                	cmp    %edi,%ebx
801070f5:	74 23                	je     8010711a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801070f7:	8b 03                	mov    (%ebx),%eax
801070f9:	a8 01                	test   $0x1,%al
801070fb:	74 f3                	je     801070f0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801070fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107102:	83 ec 0c             	sub    $0xc,%esp
80107105:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107108:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010710d:	50                   	push   %eax
8010710e:	e8 1d b2 ff ff       	call   80102330 <kfree>
80107113:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107116:	39 fb                	cmp    %edi,%ebx
80107118:	75 dd                	jne    801070f7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010711a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010711d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107120:	5b                   	pop    %ebx
80107121:	5e                   	pop    %esi
80107122:	5f                   	pop    %edi
80107123:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107124:	e9 07 b2 ff ff       	jmp    80102330 <kfree>
    panic("freevm: no pgdir");
80107129:	83 ec 0c             	sub    $0xc,%esp
8010712c:	68 a9 7d 10 80       	push   $0x80107da9
80107131:	e8 5a 92 ff ff       	call   80100390 <panic>
80107136:	8d 76 00             	lea    0x0(%esi),%esi
80107139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107140 <setupkvm>:
{
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	56                   	push   %esi
80107144:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107145:	e8 96 b3 ff ff       	call   801024e0 <kalloc>
8010714a:	85 c0                	test   %eax,%eax
8010714c:	89 c6                	mov    %eax,%esi
8010714e:	74 42                	je     80107192 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107150:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107153:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107158:	68 00 10 00 00       	push   $0x1000
8010715d:	6a 00                	push   $0x0
8010715f:	50                   	push   %eax
80107160:	e8 5b d7 ff ff       	call   801048c0 <memset>
80107165:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107168:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010716b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010716e:	83 ec 08             	sub    $0x8,%esp
80107171:	8b 13                	mov    (%ebx),%edx
80107173:	ff 73 0c             	pushl  0xc(%ebx)
80107176:	50                   	push   %eax
80107177:	29 c1                	sub    %eax,%ecx
80107179:	89 f0                	mov    %esi,%eax
8010717b:	e8 b0 f9 ff ff       	call   80106b30 <mappages>
80107180:	83 c4 10             	add    $0x10,%esp
80107183:	85 c0                	test   %eax,%eax
80107185:	78 19                	js     801071a0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107187:	83 c3 10             	add    $0x10,%ebx
8010718a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107190:	75 d6                	jne    80107168 <setupkvm+0x28>
}
80107192:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107195:	89 f0                	mov    %esi,%eax
80107197:	5b                   	pop    %ebx
80107198:	5e                   	pop    %esi
80107199:	5d                   	pop    %ebp
8010719a:	c3                   	ret    
8010719b:	90                   	nop
8010719c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801071a0:	83 ec 0c             	sub    $0xc,%esp
801071a3:	56                   	push   %esi
      return 0;
801071a4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801071a6:	e8 15 ff ff ff       	call   801070c0 <freevm>
      return 0;
801071ab:	83 c4 10             	add    $0x10,%esp
}
801071ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801071b1:	89 f0                	mov    %esi,%eax
801071b3:	5b                   	pop    %ebx
801071b4:	5e                   	pop    %esi
801071b5:	5d                   	pop    %ebp
801071b6:	c3                   	ret    
801071b7:	89 f6                	mov    %esi,%esi
801071b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071c0 <kvmalloc>:
{
801071c0:	55                   	push   %ebp
801071c1:	89 e5                	mov    %esp,%ebp
801071c3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801071c6:	e8 75 ff ff ff       	call   80107140 <setupkvm>
801071cb:	a3 c4 f1 11 80       	mov    %eax,0x8011f1c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071d0:	05 00 00 00 80       	add    $0x80000000,%eax
801071d5:	0f 22 d8             	mov    %eax,%cr3
}
801071d8:	c9                   	leave  
801071d9:	c3                   	ret    
801071da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801071e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071e1:	31 c9                	xor    %ecx,%ecx
{
801071e3:	89 e5                	mov    %esp,%ebp
801071e5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801071e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801071eb:	8b 45 08             	mov    0x8(%ebp),%eax
801071ee:	e8 bd f8 ff ff       	call   80106ab0 <walkpgdir>
  if(pte == 0)
801071f3:	85 c0                	test   %eax,%eax
801071f5:	74 05                	je     801071fc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801071f7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801071fa:	c9                   	leave  
801071fb:	c3                   	ret    
    panic("clearpteu");
801071fc:	83 ec 0c             	sub    $0xc,%esp
801071ff:	68 ba 7d 10 80       	push   $0x80107dba
80107204:	e8 87 91 ff ff       	call   80100390 <panic>
80107209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107210 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	57                   	push   %edi
80107214:	56                   	push   %esi
80107215:	53                   	push   %ebx
80107216:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107219:	e8 22 ff ff ff       	call   80107140 <setupkvm>
8010721e:	85 c0                	test   %eax,%eax
80107220:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107223:	0f 84 9f 00 00 00    	je     801072c8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107229:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010722c:	85 c9                	test   %ecx,%ecx
8010722e:	0f 84 94 00 00 00    	je     801072c8 <copyuvm+0xb8>
80107234:	31 ff                	xor    %edi,%edi
80107236:	eb 4a                	jmp    80107282 <copyuvm+0x72>
80107238:	90                   	nop
80107239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107240:	83 ec 04             	sub    $0x4,%esp
80107243:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107249:	68 00 10 00 00       	push   $0x1000
8010724e:	53                   	push   %ebx
8010724f:	50                   	push   %eax
80107250:	e8 1b d7 ff ff       	call   80104970 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107255:	58                   	pop    %eax
80107256:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010725c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107261:	5a                   	pop    %edx
80107262:	ff 75 e4             	pushl  -0x1c(%ebp)
80107265:	50                   	push   %eax
80107266:	89 fa                	mov    %edi,%edx
80107268:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010726b:	e8 c0 f8 ff ff       	call   80106b30 <mappages>
80107270:	83 c4 10             	add    $0x10,%esp
80107273:	85 c0                	test   %eax,%eax
80107275:	78 61                	js     801072d8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107277:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010727d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107280:	76 46                	jbe    801072c8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107282:	8b 45 08             	mov    0x8(%ebp),%eax
80107285:	31 c9                	xor    %ecx,%ecx
80107287:	89 fa                	mov    %edi,%edx
80107289:	e8 22 f8 ff ff       	call   80106ab0 <walkpgdir>
8010728e:	85 c0                	test   %eax,%eax
80107290:	74 61                	je     801072f3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107292:	8b 00                	mov    (%eax),%eax
80107294:	a8 01                	test   $0x1,%al
80107296:	74 4e                	je     801072e6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107298:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010729a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010729f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801072a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801072a8:	e8 33 b2 ff ff       	call   801024e0 <kalloc>
801072ad:	85 c0                	test   %eax,%eax
801072af:	89 c6                	mov    %eax,%esi
801072b1:	75 8d                	jne    80107240 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801072b3:	83 ec 0c             	sub    $0xc,%esp
801072b6:	ff 75 e0             	pushl  -0x20(%ebp)
801072b9:	e8 02 fe ff ff       	call   801070c0 <freevm>
  return 0;
801072be:	83 c4 10             	add    $0x10,%esp
801072c1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801072c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072ce:	5b                   	pop    %ebx
801072cf:	5e                   	pop    %esi
801072d0:	5f                   	pop    %edi
801072d1:	5d                   	pop    %ebp
801072d2:	c3                   	ret    
801072d3:	90                   	nop
801072d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801072d8:	83 ec 0c             	sub    $0xc,%esp
801072db:	56                   	push   %esi
801072dc:	e8 4f b0 ff ff       	call   80102330 <kfree>
      goto bad;
801072e1:	83 c4 10             	add    $0x10,%esp
801072e4:	eb cd                	jmp    801072b3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801072e6:	83 ec 0c             	sub    $0xc,%esp
801072e9:	68 de 7d 10 80       	push   $0x80107dde
801072ee:	e8 9d 90 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801072f3:	83 ec 0c             	sub    $0xc,%esp
801072f6:	68 c4 7d 10 80       	push   $0x80107dc4
801072fb:	e8 90 90 ff ff       	call   80100390 <panic>

80107300 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107300:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107301:	31 c9                	xor    %ecx,%ecx
{
80107303:	89 e5                	mov    %esp,%ebp
80107305:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107308:	8b 55 0c             	mov    0xc(%ebp),%edx
8010730b:	8b 45 08             	mov    0x8(%ebp),%eax
8010730e:	e8 9d f7 ff ff       	call   80106ab0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107313:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107315:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107316:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107318:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010731d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107320:	05 00 00 00 80       	add    $0x80000000,%eax
80107325:	83 fa 05             	cmp    $0x5,%edx
80107328:	ba 00 00 00 00       	mov    $0x0,%edx
8010732d:	0f 45 c2             	cmovne %edx,%eax
}
80107330:	c3                   	ret    
80107331:	eb 0d                	jmp    80107340 <copyout>
80107333:	90                   	nop
80107334:	90                   	nop
80107335:	90                   	nop
80107336:	90                   	nop
80107337:	90                   	nop
80107338:	90                   	nop
80107339:	90                   	nop
8010733a:	90                   	nop
8010733b:	90                   	nop
8010733c:	90                   	nop
8010733d:	90                   	nop
8010733e:	90                   	nop
8010733f:	90                   	nop

80107340 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	56                   	push   %esi
80107345:	53                   	push   %ebx
80107346:	83 ec 1c             	sub    $0x1c,%esp
80107349:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010734c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010734f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107352:	85 db                	test   %ebx,%ebx
80107354:	75 40                	jne    80107396 <copyout+0x56>
80107356:	eb 70                	jmp    801073c8 <copyout+0x88>
80107358:	90                   	nop
80107359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107360:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107363:	89 f1                	mov    %esi,%ecx
80107365:	29 d1                	sub    %edx,%ecx
80107367:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010736d:	39 d9                	cmp    %ebx,%ecx
8010736f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107372:	29 f2                	sub    %esi,%edx
80107374:	83 ec 04             	sub    $0x4,%esp
80107377:	01 d0                	add    %edx,%eax
80107379:	51                   	push   %ecx
8010737a:	57                   	push   %edi
8010737b:	50                   	push   %eax
8010737c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010737f:	e8 ec d5 ff ff       	call   80104970 <memmove>
    len -= n;
    buf += n;
80107384:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107387:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010738a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107390:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107392:	29 cb                	sub    %ecx,%ebx
80107394:	74 32                	je     801073c8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107396:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107398:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010739b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010739e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801073a4:	56                   	push   %esi
801073a5:	ff 75 08             	pushl  0x8(%ebp)
801073a8:	e8 53 ff ff ff       	call   80107300 <uva2ka>
    if(pa0 == 0)
801073ad:	83 c4 10             	add    $0x10,%esp
801073b0:	85 c0                	test   %eax,%eax
801073b2:	75 ac                	jne    80107360 <copyout+0x20>
  }
  return 0;
}
801073b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073bc:	5b                   	pop    %ebx
801073bd:	5e                   	pop    %esi
801073be:	5f                   	pop    %edi
801073bf:	5d                   	pop    %ebp
801073c0:	c3                   	ret    
801073c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073cb:	31 c0                	xor    %eax,%eax
}
801073cd:	5b                   	pop    %ebx
801073ce:	5e                   	pop    %esi
801073cf:	5f                   	pop    %edi
801073d0:	5d                   	pop    %ebp
801073d1:	c3                   	ret    