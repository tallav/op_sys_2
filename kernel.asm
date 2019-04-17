
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2f 10 80       	mov    $0x80102f80,%eax
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
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 76 10 80       	push   $0x801076a0
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 f5 47 00 00       	call   80104850 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 0c 11 80       	mov    $0x80110cbc,%edx
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
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 76 10 80       	push   $0x801076a7
80100097:	50                   	push   %eax
80100098:	e8 83 46 00 00       	call   80104720 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 0c 11 80       	cmp    $0x80110cbc,%eax
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
801000df:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e4:	e8 a7 48 00 00       	call   80104990 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 e9 48 00 00       	call   80104a50 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 45 00 00       	call   80104760 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 7d 20 00 00       	call   80102200 <iderw>
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
80100193:	68 ae 76 10 80       	push   $0x801076ae
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
801001ae:	e8 4d 46 00 00       	call   80104800 <holdingsleep>
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
801001c4:	e9 37 20 00 00       	jmp    80102200 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 76 10 80       	push   $0x801076bf
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
801001ef:	e8 0c 46 00 00       	call   80104800 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 45 00 00       	call   801047c0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 80 47 00 00       	call   80104990 <acquire>
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
80100232:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 0d 11 80       	mov    0x80110d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 ef 47 00 00       	jmp    80104a50 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 76 10 80       	push   $0x801076c6
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
80100280:	e8 bb 15 00 00       	call   80101840 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 ff 46 00 00       	call   80104990 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002a7:	39 15 a4 0f 11 80    	cmp    %edx,0x80110fa4
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
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 a0 0f 11 80       	push   $0x80110fa0
801002c5:	e8 26 3d 00 00       	call   80103ff0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 0f 11 80    	cmp    0x80110fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 80 36 00 00       	call   80103960 <myproc>
801002e0:	8b 40 14             	mov    0x14(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 5c 47 00 00       	call   80104a50 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 64 14 00 00       	call   80101760 <ilock>
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
80100313:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 0f 11 80 	movsbl -0x7feef0e0(%eax),%eax
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
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 fe 46 00 00       	call   80104a50 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 06 14 00 00       	call   80101760 <ilock>
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
80100372:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
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
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 62 24 00 00       	call   80102810 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 cd 76 10 80       	push   $0x801076cd
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 07 81 10 80 	movl   $0x80108107,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 93 44 00 00       	call   80104870 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 e1 76 10 80       	push   $0x801076e1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
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
8010043a:	e8 61 5e 00 00       	call   801062a0 <uartputc>
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
801004ec:	e8 af 5d 00 00       	call   801062a0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 a3 5d 00 00       	call   801062a0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 97 5d 00 00       	call   801062a0 <uartputc>
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
80100524:	e8 27 46 00 00       	call   80104b50 <memmove>
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
80100541:	e8 5a 45 00 00       	call   80104aa0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 e5 76 10 80       	push   $0x801076e5
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
801005b1:	0f b6 92 10 77 10 80 	movzbl -0x7fef88f0(%edx),%edx
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
8010060f:	e8 2c 12 00 00       	call   80101840 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 70 43 00 00       	call   80104990 <acquire>
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
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 04 44 00 00       	call   80104a50 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 0b 11 00 00       	call   80101760 <ilock>

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
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
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
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 2c 43 00 00       	call   80104a50 <release>
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
801007d0:	ba f8 76 10 80       	mov    $0x801076f8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 9b 41 00 00       	call   80104990 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 ff 76 10 80       	push   $0x801076ff
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
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 68 41 00 00       	call   80104990 <acquire>
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
80100851:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100856:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
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
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 c3 41 00 00       	call   80104a50 <release>
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
801008a9:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
          wakeup(&input.r);
80100911:	68 a0 0f 11 80       	push   $0x80110fa0
80100916:	e8 95 37 00 00       	call   801040b0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010093d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100964:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
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
80100997:	e9 b4 37 00 00       	jmp    80104150 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
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
801009c6:	68 08 77 10 80       	push   $0x80107708
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 7b 3e 00 00       	call   80104850 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 19 11 80 00 	movl   $0x80100600,0x8011196c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 19 11 80 70 	movl   $0x80100270,0x80111968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 b2 19 00 00       	call   801023b0 <ioapicenable>
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
};
extern struct ptable ptable;

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
80100a1c:	e8 3f 2f 00 00       	call   80103960 <myproc>
80100a21:	89 c6                	mov    %eax,%esi
  struct kthread *curthread = mythread();
80100a23:	e8 68 2f 00 00       	call   80103990 <mythread>

  // check if you got exit request before executing
  if(curthread->exitRequest == 1){
80100a28:	83 78 20 01          	cmpl   $0x1,0x20(%eax)
80100a2c:	0f 84 b5 01 00 00    	je     80100be7 <exec+0x1d7>
    cprintf("exec: thread got exit request\n");
    kthread_exit();
    return -1;
  }

  acquire(&ptable.lock);
80100a32:	83 ec 0c             	sub    $0xc,%esp
80100a35:	89 c7                	mov    %eax,%edi
80100a37:	68 40 3d 11 80       	push   $0x80113d40
80100a3c:	e8 4f 3f 00 00       	call   80104990 <acquire>
  struct kthread *t;
  int allTerminated = 0;
  // wait until the other threads in the process are terminated before executing
  while(!allTerminated){
80100a41:	83 c4 10             	add    $0x10,%esp
    int hasNonTerminated = 0;
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80100a44:	8b 46 6c             	mov    0x6c(%esi),%eax
80100a47:	8d 88 40 02 00 00    	lea    0x240(%eax),%ecx
80100a4d:	8d 76 00             	lea    0x0(%esi),%esi
      //cprintf("exec: thread %d state %d\n", t->tid, t->state);
      if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80100a50:	39 c7                	cmp    %eax,%edi
80100a52:	74 0c                	je     80100a60 <exec+0x50>
80100a54:	8b 50 08             	mov    0x8(%eax),%edx
80100a57:	83 fa 05             	cmp    $0x5,%edx
80100a5a:	74 04                	je     80100a60 <exec+0x50>
80100a5c:	85 d2                	test   %edx,%edx
80100a5e:	75 70                	jne    80100ad0 <exec+0xc0>
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80100a60:	83 c0 24             	add    $0x24,%eax
80100a63:	39 c8                	cmp    %ecx,%eax
80100a65:	75 e9                	jne    80100a50 <exec+0x40>
    }
    if(!hasNonTerminated){
      allTerminated = 1;
    }
  }
  release(&ptable.lock);
80100a67:	83 ec 0c             	sub    $0xc,%esp
80100a6a:	68 40 3d 11 80       	push   $0x80113d40
80100a6f:	e8 dc 3f 00 00       	call   80104a50 <release>

  begin_op();
80100a74:	e8 07 22 00 00       	call   80102c80 <begin_op>

  if((ip = namei(path)) == 0){
80100a79:	5a                   	pop    %edx
80100a7a:	ff 75 08             	pushl  0x8(%ebp)
80100a7d:	e8 3e 15 00 00       	call   80101fc0 <namei>
80100a82:	83 c4 10             	add    $0x10,%esp
80100a85:	85 c0                	test   %eax,%eax
80100a87:	89 c3                	mov    %eax,%ebx
80100a89:	0f 84 f5 01 00 00    	je     80100c84 <exec+0x274>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a8f:	83 ec 0c             	sub    $0xc,%esp
80100a92:	50                   	push   %eax
80100a93:	e8 c8 0c 00 00       	call   80101760 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a98:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a9e:	6a 34                	push   $0x34
80100aa0:	6a 00                	push   $0x0
80100aa2:	50                   	push   %eax
80100aa3:	53                   	push   %ebx
80100aa4:	e8 97 0f 00 00       	call   80101a40 <readi>
80100aa9:	83 c4 20             	add    $0x20,%esp
80100aac:	83 f8 34             	cmp    $0x34,%eax
80100aaf:	74 2f                	je     80100ae0 <exec+0xd0>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ab1:	83 ec 0c             	sub    $0xc,%esp
80100ab4:	53                   	push   %ebx
80100ab5:	e8 36 0f 00 00       	call   801019f0 <iunlockput>
    end_op();
80100aba:	e8 31 22 00 00       	call   80102cf0 <end_op>
80100abf:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ac2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ac7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100aca:	5b                   	pop    %ebx
80100acb:	5e                   	pop    %esi
80100acc:	5f                   	pop    %edi
80100acd:	5d                   	pop    %ebp
80100ace:	c3                   	ret    
80100acf:	90                   	nop
        t->exitRequest = 1;
80100ad0:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
80100ad7:	e9 68 ff ff ff       	jmp    80100a44 <exec+0x34>
80100adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100ae0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ae7:	45 4c 46 
80100aea:	75 c5                	jne    80100ab1 <exec+0xa1>
  if((pgdir = setupkvm()) == 0)
80100aec:	e8 ff 68 00 00       	call   801073f0 <setupkvm>
80100af1:	85 c0                	test   %eax,%eax
80100af3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100af9:	74 b6                	je     80100ab1 <exec+0xa1>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100afb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b02:	00 
80100b03:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100b09:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b0f:	0f 84 f7 02 00 00    	je     80100e0c <exec+0x3fc>
  sz = 0;
80100b15:	31 c9                	xor    %ecx,%ecx
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b17:	31 c0                	xor    %eax,%eax
80100b19:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100b1f:	89 bd e8 fe ff ff    	mov    %edi,-0x118(%ebp)
80100b25:	89 c6                	mov    %eax,%esi
80100b27:	89 cf                	mov    %ecx,%edi
80100b29:	eb 7f                	jmp    80100baa <exec+0x19a>
80100b2b:	90                   	nop
80100b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b30:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b37:	75 63                	jne    80100b9c <exec+0x18c>
    if(ph.memsz < ph.filesz)
80100b39:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b3f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b45:	0f 82 86 00 00 00    	jb     80100bd1 <exec+0x1c1>
80100b4b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b51:	72 7e                	jb     80100bd1 <exec+0x1c1>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b53:	83 ec 04             	sub    $0x4,%esp
80100b56:	50                   	push   %eax
80100b57:	57                   	push   %edi
80100b58:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b5e:	e8 ad 66 00 00       	call   80107210 <allocuvm>
80100b63:	83 c4 10             	add    $0x10,%esp
80100b66:	85 c0                	test   %eax,%eax
80100b68:	89 c7                	mov    %eax,%edi
80100b6a:	74 65                	je     80100bd1 <exec+0x1c1>
    if(ph.vaddr % PGSIZE != 0)
80100b6c:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b72:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b77:	75 58                	jne    80100bd1 <exec+0x1c1>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b79:	83 ec 0c             	sub    $0xc,%esp
80100b7c:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b82:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b88:	53                   	push   %ebx
80100b89:	50                   	push   %eax
80100b8a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b90:	e8 bb 65 00 00       	call   80107150 <loaduvm>
80100b95:	83 c4 20             	add    $0x20,%esp
80100b98:	85 c0                	test   %eax,%eax
80100b9a:	78 35                	js     80100bd1 <exec+0x1c1>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b9c:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100ba3:	83 c6 01             	add    $0x1,%esi
80100ba6:	39 f0                	cmp    %esi,%eax
80100ba8:	7e 5c                	jle    80100c06 <exec+0x1f6>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100baa:	89 f0                	mov    %esi,%eax
80100bac:	6a 20                	push   $0x20
80100bae:	c1 e0 05             	shl    $0x5,%eax
80100bb1:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100bb7:	50                   	push   %eax
80100bb8:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bbe:	50                   	push   %eax
80100bbf:	53                   	push   %ebx
80100bc0:	e8 7b 0e 00 00       	call   80101a40 <readi>
80100bc5:	83 c4 10             	add    $0x10,%esp
80100bc8:	83 f8 20             	cmp    $0x20,%eax
80100bcb:	0f 84 5f ff ff ff    	je     80100b30 <exec+0x120>
    freevm(pgdir);
80100bd1:	83 ec 0c             	sub    $0xc,%esp
80100bd4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bda:	e8 91 67 00 00       	call   80107370 <freevm>
80100bdf:	83 c4 10             	add    $0x10,%esp
80100be2:	e9 ca fe ff ff       	jmp    80100ab1 <exec+0xa1>
    cprintf("exec: thread got exit request\n");
80100be7:	83 ec 0c             	sub    $0xc,%esp
80100bea:	68 24 77 10 80       	push   $0x80107724
80100bef:	e8 6c fa ff ff       	call   80100660 <cprintf>
    kthread_exit();
80100bf4:	e8 57 39 00 00       	call   80104550 <kthread_exit>
    return -1;
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c01:	e9 c1 fe ff ff       	jmp    80100ac7 <exec+0xb7>
80100c06:	89 f8                	mov    %edi,%eax
80100c08:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100c0e:	8b bd e8 fe ff ff    	mov    -0x118(%ebp),%edi
80100c14:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100c1e:	89 c2                	mov    %eax,%edx
80100c20:	8d 80 00 20 00 00    	lea    0x2000(%eax),%eax
  iunlockput(ip);
80100c26:	83 ec 0c             	sub    $0xc,%esp
80100c29:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100c2f:	89 95 f0 fe ff ff    	mov    %edx,-0x110(%ebp)
80100c35:	53                   	push   %ebx
80100c36:	e8 b5 0d 00 00       	call   801019f0 <iunlockput>
  end_op();
80100c3b:	e8 b0 20 00 00       	call   80102cf0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c40:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c46:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c4c:	83 c4 0c             	add    $0xc,%esp
80100c4f:	50                   	push   %eax
80100c50:	52                   	push   %edx
80100c51:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c57:	e8 b4 65 00 00       	call   80107210 <allocuvm>
80100c5c:	83 c4 10             	add    $0x10,%esp
80100c5f:	85 c0                	test   %eax,%eax
80100c61:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c67:	75 3a                	jne    80100ca3 <exec+0x293>
    freevm(pgdir);
80100c69:	83 ec 0c             	sub    $0xc,%esp
80100c6c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c72:	e8 f9 66 00 00       	call   80107370 <freevm>
80100c77:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c7f:	e9 43 fe ff ff       	jmp    80100ac7 <exec+0xb7>
    end_op();
80100c84:	e8 67 20 00 00       	call   80102cf0 <end_op>
    cprintf("exec: fail\n");
80100c89:	83 ec 0c             	sub    $0xc,%esp
80100c8c:	68 43 77 10 80       	push   $0x80107743
80100c91:	e8 ca f9 ff ff       	call   80100660 <cprintf>
    return -1;
80100c96:	83 c4 10             	add    $0x10,%esp
80100c99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c9e:	e9 24 fe ff ff       	jmp    80100ac7 <exec+0xb7>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ca3:	89 c3                	mov    %eax,%ebx
80100ca5:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100cab:	83 ec 08             	sub    $0x8,%esp
80100cae:	50                   	push   %eax
80100caf:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cb5:	e8 d6 67 00 00       	call   80107490 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cba:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cbd:	83 c4 10             	add    $0x10,%esp
80100cc0:	31 c9                	xor    %ecx,%ecx
80100cc2:	8b 00                	mov    (%eax),%eax
80100cc4:	85 c0                	test   %eax,%eax
80100cc6:	0f 84 4c 01 00 00    	je     80100e18 <exec+0x408>
80100ccc:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100cd2:	89 f7                	mov    %esi,%edi
80100cd4:	89 de                	mov    %ebx,%esi
80100cd6:	89 cb                	mov    %ecx,%ebx
80100cd8:	eb 05                	jmp    80100cdf <exec+0x2cf>
    if(argc >= MAXARG)
80100cda:	83 fb 20             	cmp    $0x20,%ebx
80100cdd:	74 8a                	je     80100c69 <exec+0x259>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cdf:	83 ec 0c             	sub    $0xc,%esp
80100ce2:	50                   	push   %eax
80100ce3:	e8 d8 3f 00 00       	call   80104cc0 <strlen>
80100ce8:	f7 d0                	not    %eax
80100cea:	01 f0                	add    %esi,%eax
80100cec:	83 e0 fc             	and    $0xfffffffc,%eax
80100cef:	89 c6                	mov    %eax,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf1:	58                   	pop    %eax
80100cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf5:	ff 34 98             	pushl  (%eax,%ebx,4)
80100cf8:	e8 c3 3f 00 00       	call   80104cc0 <strlen>
80100cfd:	83 c0 01             	add    $0x1,%eax
80100d00:	50                   	push   %eax
80100d01:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d04:	ff 34 98             	pushl  (%eax,%ebx,4)
80100d07:	56                   	push   %esi
80100d08:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d0e:	e8 dd 68 00 00       	call   801075f0 <copyout>
80100d13:	83 c4 20             	add    $0x20,%esp
80100d16:	85 c0                	test   %eax,%eax
80100d18:	0f 88 4b ff ff ff    	js     80100c69 <exec+0x259>
  for(argc = 0; argv[argc]; argc++) {
80100d1e:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d21:	89 b4 9d 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%ebx,4)
  for(argc = 0; argv[argc]; argc++) {
80100d28:	83 c3 01             	add    $0x1,%ebx
    ustack[3+argc] = sp;
80100d2b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d31:	8b 04 98             	mov    (%eax,%ebx,4),%eax
80100d34:	85 c0                	test   %eax,%eax
80100d36:	75 a2                	jne    80100cda <exec+0x2ca>
80100d38:	89 d9                	mov    %ebx,%ecx
80100d3a:	89 f3                	mov    %esi,%ebx
80100d3c:	89 fe                	mov    %edi,%esi
80100d3e:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d44:	8d 04 8d 04 00 00 00 	lea    0x4(,%ecx,4),%eax
  ustack[3+argc] = 0;
80100d4b:	c7 84 8d 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%ecx,4)
80100d52:	00 00 00 00 
  ustack[1] = argc;
80100d56:	89 8d 5c ff ff ff    	mov    %ecx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5c:	89 d9                	mov    %ebx,%ecx
  ustack[0] = 0xffffffff;  // fake return PC
80100d5e:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d65:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d68:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d6a:	83 c0 0c             	add    $0xc,%eax
80100d6d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d6f:	50                   	push   %eax
80100d70:	52                   	push   %edx
80100d71:	53                   	push   %ebx
80100d72:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d78:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d7e:	e8 6d 68 00 00       	call   801075f0 <copyout>
80100d83:	83 c4 10             	add    $0x10,%esp
80100d86:	85 c0                	test   %eax,%eax
80100d88:	0f 88 db fe ff ff    	js     80100c69 <exec+0x259>
  for(last=s=path; *s; s++)
80100d8e:	8b 45 08             	mov    0x8(%ebp),%eax
80100d91:	0f b6 00             	movzbl (%eax),%eax
80100d94:	84 c0                	test   %al,%al
80100d96:	74 17                	je     80100daf <exec+0x39f>
80100d98:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100d9b:	89 ca                	mov    %ecx,%edx
80100d9d:	83 c2 01             	add    $0x1,%edx
80100da0:	3c 2f                	cmp    $0x2f,%al
80100da2:	0f b6 02             	movzbl (%edx),%eax
80100da5:	0f 44 ca             	cmove  %edx,%ecx
80100da8:	84 c0                	test   %al,%al
80100daa:	75 f1                	jne    80100d9d <exec+0x38d>
80100dac:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100daf:	8d 46 5c             	lea    0x5c(%esi),%eax
80100db2:	83 ec 04             	sub    $0x4,%esp
80100db5:	6a 10                	push   $0x10
80100db7:	ff 75 08             	pushl  0x8(%ebp)
80100dba:	50                   	push   %eax
80100dbb:	e8 c0 3e 00 00       	call   80104c80 <safestrcpy>
  curproc->pgdir = pgdir;
80100dc0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  oldpgdir = curproc->pgdir;
80100dc6:	8b 56 04             	mov    0x4(%esi),%edx
  curproc->pgdir = pgdir;
80100dc9:	89 46 04             	mov    %eax,0x4(%esi)
  curproc->sz = sz;
80100dcc:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  oldpgdir = curproc->pgdir;
80100dd2:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
  curproc->sz = sz;
80100dd8:	89 06                	mov    %eax,(%esi)
  curthread->tf->eip = elf.entry;  // main
80100dda:	8b 47 14             	mov    0x14(%edi),%eax
80100ddd:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100de3:	89 48 38             	mov    %ecx,0x38(%eax)
  curthread->tf->esp = sp;
80100de6:	8b 47 14             	mov    0x14(%edi),%eax
80100de9:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dec:	89 34 24             	mov    %esi,(%esp)
80100def:	e8 cc 61 00 00       	call   80106fc0 <switchuvm>
  freevm(oldpgdir);
80100df4:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
80100dfa:	89 14 24             	mov    %edx,(%esp)
80100dfd:	e8 6e 65 00 00       	call   80107370 <freevm>
  return 0;
80100e02:	83 c4 10             	add    $0x10,%esp
80100e05:	31 c0                	xor    %eax,%eax
80100e07:	e9 bb fc ff ff       	jmp    80100ac7 <exec+0xb7>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e0c:	31 d2                	xor    %edx,%edx
80100e0e:	b8 00 20 00 00       	mov    $0x2000,%eax
80100e13:	e9 0e fe ff ff       	jmp    80100c26 <exec+0x216>
  for(argc = 0; argv[argc]; argc++) {
80100e18:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100e1e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100e24:	e9 1b ff ff ff       	jmp    80100d44 <exec+0x334>
80100e29:	66 90                	xchg   %ax,%ax
80100e2b:	66 90                	xchg   %ax,%ax
80100e2d:	66 90                	xchg   %ax,%ax
80100e2f:	90                   	nop

80100e30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e36:	68 4f 77 10 80       	push   $0x8010774f
80100e3b:	68 c0 0f 11 80       	push   $0x80110fc0
80100e40:	e8 0b 3a 00 00       	call   80104850 <initlock>
}
80100e45:	83 c4 10             	add    $0x10,%esp
80100e48:	c9                   	leave  
80100e49:	c3                   	ret    
80100e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e54:	bb f4 0f 11 80       	mov    $0x80110ff4,%ebx
{
80100e59:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e5c:	68 c0 0f 11 80       	push   $0x80110fc0
80100e61:	e8 2a 3b 00 00       	call   80104990 <acquire>
80100e66:	83 c4 10             	add    $0x10,%esp
80100e69:	eb 10                	jmp    80100e7b <filealloc+0x2b>
80100e6b:	90                   	nop
80100e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e70:	83 c3 18             	add    $0x18,%ebx
80100e73:	81 fb 54 19 11 80    	cmp    $0x80111954,%ebx
80100e79:	73 25                	jae    80100ea0 <filealloc+0x50>
    if(f->ref == 0){
80100e7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	75 ee                	jne    80100e70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e82:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e8c:	68 c0 0f 11 80       	push   $0x80110fc0
80100e91:	e8 ba 3b 00 00       	call   80104a50 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e96:	89 d8                	mov    %ebx,%eax
      return f;
80100e98:	83 c4 10             	add    $0x10,%esp
}
80100e9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e9e:	c9                   	leave  
80100e9f:	c3                   	ret    
  release(&ftable.lock);
80100ea0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ea3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ea5:	68 c0 0f 11 80       	push   $0x80110fc0
80100eaa:	e8 a1 3b 00 00       	call   80104a50 <release>
}
80100eaf:	89 d8                	mov    %ebx,%eax
  return 0;
80100eb1:	83 c4 10             	add    $0x10,%esp
}
80100eb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eb7:	c9                   	leave  
80100eb8:	c3                   	ret    
80100eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ec0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
80100ec4:	83 ec 10             	sub    $0x10,%esp
80100ec7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eca:	68 c0 0f 11 80       	push   $0x80110fc0
80100ecf:	e8 bc 3a 00 00       	call   80104990 <acquire>
  if(f->ref < 1)
80100ed4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed7:	83 c4 10             	add    $0x10,%esp
80100eda:	85 c0                	test   %eax,%eax
80100edc:	7e 1a                	jle    80100ef8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ede:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ee1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ee4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ee7:	68 c0 0f 11 80       	push   $0x80110fc0
80100eec:	e8 5f 3b 00 00       	call   80104a50 <release>
  return f;
}
80100ef1:	89 d8                	mov    %ebx,%eax
80100ef3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ef6:	c9                   	leave  
80100ef7:	c3                   	ret    
    panic("filedup");
80100ef8:	83 ec 0c             	sub    $0xc,%esp
80100efb:	68 56 77 10 80       	push   $0x80107756
80100f00:	e8 8b f4 ff ff       	call   80100390 <panic>
80100f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f10 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	57                   	push   %edi
80100f14:	56                   	push   %esi
80100f15:	53                   	push   %ebx
80100f16:	83 ec 28             	sub    $0x28,%esp
80100f19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f1c:	68 c0 0f 11 80       	push   $0x80110fc0
80100f21:	e8 6a 3a 00 00       	call   80104990 <acquire>
  if(f->ref < 1)
80100f26:	8b 43 04             	mov    0x4(%ebx),%eax
80100f29:	83 c4 10             	add    $0x10,%esp
80100f2c:	85 c0                	test   %eax,%eax
80100f2e:	0f 8e 9b 00 00 00    	jle    80100fcf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f34:	83 e8 01             	sub    $0x1,%eax
80100f37:	85 c0                	test   %eax,%eax
80100f39:	89 43 04             	mov    %eax,0x4(%ebx)
80100f3c:	74 1a                	je     80100f58 <fileclose+0x48>
    release(&ftable.lock);
80100f3e:	c7 45 08 c0 0f 11 80 	movl   $0x80110fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f48:	5b                   	pop    %ebx
80100f49:	5e                   	pop    %esi
80100f4a:	5f                   	pop    %edi
80100f4b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f4c:	e9 ff 3a 00 00       	jmp    80104a50 <release>
80100f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f58:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f5c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f5e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f61:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f64:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f6d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f70:	68 c0 0f 11 80       	push   $0x80110fc0
  ff = *f;
80100f75:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f78:	e8 d3 3a 00 00       	call   80104a50 <release>
  if(ff.type == FD_PIPE)
80100f7d:	83 c4 10             	add    $0x10,%esp
80100f80:	83 ff 01             	cmp    $0x1,%edi
80100f83:	74 13                	je     80100f98 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f85:	83 ff 02             	cmp    $0x2,%edi
80100f88:	74 26                	je     80100fb0 <fileclose+0xa0>
}
80100f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8d:	5b                   	pop    %ebx
80100f8e:	5e                   	pop    %esi
80100f8f:	5f                   	pop    %edi
80100f90:	5d                   	pop    %ebp
80100f91:	c3                   	ret    
80100f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f98:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f9c:	83 ec 08             	sub    $0x8,%esp
80100f9f:	53                   	push   %ebx
80100fa0:	56                   	push   %esi
80100fa1:	e8 8a 24 00 00       	call   80103430 <pipeclose>
80100fa6:	83 c4 10             	add    $0x10,%esp
80100fa9:	eb df                	jmp    80100f8a <fileclose+0x7a>
80100fab:	90                   	nop
80100fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100fb0:	e8 cb 1c 00 00       	call   80102c80 <begin_op>
    iput(ff.ip);
80100fb5:	83 ec 0c             	sub    $0xc,%esp
80100fb8:	ff 75 e0             	pushl  -0x20(%ebp)
80100fbb:	e8 d0 08 00 00       	call   80101890 <iput>
    end_op();
80100fc0:	83 c4 10             	add    $0x10,%esp
}
80100fc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc6:	5b                   	pop    %ebx
80100fc7:	5e                   	pop    %esi
80100fc8:	5f                   	pop    %edi
80100fc9:	5d                   	pop    %ebp
    end_op();
80100fca:	e9 21 1d 00 00       	jmp    80102cf0 <end_op>
    panic("fileclose");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 5e 77 10 80       	push   $0x8010775e
80100fd7:	e8 b4 f3 ff ff       	call   80100390 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	53                   	push   %ebx
80100fe4:	83 ec 04             	sub    $0x4,%esp
80100fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fea:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fed:	75 31                	jne    80101020 <filestat+0x40>
    ilock(f->ip);
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	ff 73 10             	pushl  0x10(%ebx)
80100ff5:	e8 66 07 00 00       	call   80101760 <ilock>
    stati(f->ip, st);
80100ffa:	58                   	pop    %eax
80100ffb:	5a                   	pop    %edx
80100ffc:	ff 75 0c             	pushl  0xc(%ebp)
80100fff:	ff 73 10             	pushl  0x10(%ebx)
80101002:	e8 09 0a 00 00       	call   80101a10 <stati>
    iunlock(f->ip);
80101007:	59                   	pop    %ecx
80101008:	ff 73 10             	pushl  0x10(%ebx)
8010100b:	e8 30 08 00 00       	call   80101840 <iunlock>
    return 0;
80101010:	83 c4 10             	add    $0x10,%esp
80101013:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101015:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101025:	eb ee                	jmp    80101015 <filestat+0x35>
80101027:	89 f6                	mov    %esi,%esi
80101029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101030 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 0c             	sub    $0xc,%esp
80101039:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010103c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010103f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101042:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101046:	74 60                	je     801010a8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101048:	8b 03                	mov    (%ebx),%eax
8010104a:	83 f8 01             	cmp    $0x1,%eax
8010104d:	74 41                	je     80101090 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010104f:	83 f8 02             	cmp    $0x2,%eax
80101052:	75 5b                	jne    801010af <fileread+0x7f>
    ilock(f->ip);
80101054:	83 ec 0c             	sub    $0xc,%esp
80101057:	ff 73 10             	pushl  0x10(%ebx)
8010105a:	e8 01 07 00 00       	call   80101760 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010105f:	57                   	push   %edi
80101060:	ff 73 14             	pushl  0x14(%ebx)
80101063:	56                   	push   %esi
80101064:	ff 73 10             	pushl  0x10(%ebx)
80101067:	e8 d4 09 00 00       	call   80101a40 <readi>
8010106c:	83 c4 20             	add    $0x20,%esp
8010106f:	85 c0                	test   %eax,%eax
80101071:	89 c6                	mov    %eax,%esi
80101073:	7e 03                	jle    80101078 <fileread+0x48>
      f->off += r;
80101075:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101078:	83 ec 0c             	sub    $0xc,%esp
8010107b:	ff 73 10             	pushl  0x10(%ebx)
8010107e:	e8 bd 07 00 00       	call   80101840 <iunlock>
    return r;
80101083:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	89 f0                	mov    %esi,%eax
8010108b:	5b                   	pop    %ebx
8010108c:	5e                   	pop    %esi
8010108d:	5f                   	pop    %edi
8010108e:	5d                   	pop    %ebp
8010108f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101090:	8b 43 0c             	mov    0xc(%ebx),%eax
80101093:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101099:	5b                   	pop    %ebx
8010109a:	5e                   	pop    %esi
8010109b:	5f                   	pop    %edi
8010109c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010109d:	e9 3e 25 00 00       	jmp    801035e0 <piperead>
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010ad:	eb d7                	jmp    80101086 <fileread+0x56>
  panic("fileread");
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	68 68 77 10 80       	push   $0x80107768
801010b7:	e8 d4 f2 ff ff       	call   80100390 <panic>
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010c0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	57                   	push   %edi
801010c4:	56                   	push   %esi
801010c5:	53                   	push   %ebx
801010c6:	83 ec 1c             	sub    $0x1c,%esp
801010c9:	8b 75 08             	mov    0x8(%ebp),%esi
801010cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801010cf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801010d3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010d6:	8b 45 10             	mov    0x10(%ebp),%eax
801010d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010dc:	0f 84 aa 00 00 00    	je     8010118c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
801010e2:	8b 06                	mov    (%esi),%eax
801010e4:	83 f8 01             	cmp    $0x1,%eax
801010e7:	0f 84 c3 00 00 00    	je     801011b0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ed:	83 f8 02             	cmp    $0x2,%eax
801010f0:	0f 85 d9 00 00 00    	jne    801011cf <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010f9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010fb:	85 c0                	test   %eax,%eax
801010fd:	7f 34                	jg     80101133 <filewrite+0x73>
801010ff:	e9 9c 00 00 00       	jmp    801011a0 <filewrite+0xe0>
80101104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101108:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010110b:	83 ec 0c             	sub    $0xc,%esp
8010110e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101111:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101114:	e8 27 07 00 00       	call   80101840 <iunlock>
      end_op();
80101119:	e8 d2 1b 00 00       	call   80102cf0 <end_op>
8010111e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101121:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101124:	39 c3                	cmp    %eax,%ebx
80101126:	0f 85 96 00 00 00    	jne    801011c2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010112c:	01 df                	add    %ebx,%edi
    while(i < n){
8010112e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101131:	7e 6d                	jle    801011a0 <filewrite+0xe0>
      int n1 = n - i;
80101133:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101136:	b8 00 06 00 00       	mov    $0x600,%eax
8010113b:	29 fb                	sub    %edi,%ebx
8010113d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101143:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101146:	e8 35 1b 00 00       	call   80102c80 <begin_op>
      ilock(f->ip);
8010114b:	83 ec 0c             	sub    $0xc,%esp
8010114e:	ff 76 10             	pushl  0x10(%esi)
80101151:	e8 0a 06 00 00       	call   80101760 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101156:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101159:	53                   	push   %ebx
8010115a:	ff 76 14             	pushl  0x14(%esi)
8010115d:	01 f8                	add    %edi,%eax
8010115f:	50                   	push   %eax
80101160:	ff 76 10             	pushl  0x10(%esi)
80101163:	e8 d8 09 00 00       	call   80101b40 <writei>
80101168:	83 c4 20             	add    $0x20,%esp
8010116b:	85 c0                	test   %eax,%eax
8010116d:	7f 99                	jg     80101108 <filewrite+0x48>
      iunlock(f->ip);
8010116f:	83 ec 0c             	sub    $0xc,%esp
80101172:	ff 76 10             	pushl  0x10(%esi)
80101175:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101178:	e8 c3 06 00 00       	call   80101840 <iunlock>
      end_op();
8010117d:	e8 6e 1b 00 00       	call   80102cf0 <end_op>
      if(r < 0)
80101182:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101185:	83 c4 10             	add    $0x10,%esp
80101188:	85 c0                	test   %eax,%eax
8010118a:	74 98                	je     80101124 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010118c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010118f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101194:	89 f8                	mov    %edi,%eax
80101196:	5b                   	pop    %ebx
80101197:	5e                   	pop    %esi
80101198:	5f                   	pop    %edi
80101199:	5d                   	pop    %ebp
8010119a:	c3                   	ret    
8010119b:	90                   	nop
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801011a0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011a3:	75 e7                	jne    8010118c <filewrite+0xcc>
}
801011a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a8:	89 f8                	mov    %edi,%eax
801011aa:	5b                   	pop    %ebx
801011ab:	5e                   	pop    %esi
801011ac:	5f                   	pop    %edi
801011ad:	5d                   	pop    %ebp
801011ae:	c3                   	ret    
801011af:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801011b0:	8b 46 0c             	mov    0xc(%esi),%eax
801011b3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b9:	5b                   	pop    %ebx
801011ba:	5e                   	pop    %esi
801011bb:	5f                   	pop    %edi
801011bc:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011bd:	e9 0e 23 00 00       	jmp    801034d0 <pipewrite>
        panic("short filewrite");
801011c2:	83 ec 0c             	sub    $0xc,%esp
801011c5:	68 71 77 10 80       	push   $0x80107771
801011ca:	e8 c1 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	68 77 77 10 80       	push   $0x80107777
801011d7:	e8 b4 f1 ff ff       	call   80100390 <panic>
801011dc:	66 90                	xchg   %ax,%ax
801011de:	66 90                	xchg   %ax,%ax

801011e0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011e9:	8b 0d c0 19 11 80    	mov    0x801119c0,%ecx
{
801011ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011f2:	85 c9                	test   %ecx,%ecx
801011f4:	0f 84 87 00 00 00    	je     80101281 <balloc+0xa1>
801011fa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101201:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101204:	83 ec 08             	sub    $0x8,%esp
80101207:	89 f0                	mov    %esi,%eax
80101209:	c1 f8 0c             	sar    $0xc,%eax
8010120c:	03 05 d8 19 11 80    	add    0x801119d8,%eax
80101212:	50                   	push   %eax
80101213:	ff 75 d8             	pushl  -0x28(%ebp)
80101216:	e8 b5 ee ff ff       	call   801000d0 <bread>
8010121b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010121e:	a1 c0 19 11 80       	mov    0x801119c0,%eax
80101223:	83 c4 10             	add    $0x10,%esp
80101226:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101229:	31 c0                	xor    %eax,%eax
8010122b:	eb 2f                	jmp    8010125c <balloc+0x7c>
8010122d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101230:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101235:	bb 01 00 00 00       	mov    $0x1,%ebx
8010123a:	83 e1 07             	and    $0x7,%ecx
8010123d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010123f:	89 c1                	mov    %eax,%ecx
80101241:	c1 f9 03             	sar    $0x3,%ecx
80101244:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101249:	85 df                	test   %ebx,%edi
8010124b:	89 fa                	mov    %edi,%edx
8010124d:	74 41                	je     80101290 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010124f:	83 c0 01             	add    $0x1,%eax
80101252:	83 c6 01             	add    $0x1,%esi
80101255:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010125a:	74 05                	je     80101261 <balloc+0x81>
8010125c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010125f:	77 cf                	ja     80101230 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101261:	83 ec 0c             	sub    $0xc,%esp
80101264:	ff 75 e4             	pushl  -0x1c(%ebp)
80101267:	e8 74 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010126c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101273:	83 c4 10             	add    $0x10,%esp
80101276:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101279:	39 05 c0 19 11 80    	cmp    %eax,0x801119c0
8010127f:	77 80                	ja     80101201 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101281:	83 ec 0c             	sub    $0xc,%esp
80101284:	68 81 77 10 80       	push   $0x80107781
80101289:	e8 02 f1 ff ff       	call   80100390 <panic>
8010128e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101290:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101293:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101296:	09 da                	or     %ebx,%edx
80101298:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010129c:	57                   	push   %edi
8010129d:	e8 ae 1b 00 00       	call   80102e50 <log_write>
        brelse(bp);
801012a2:	89 3c 24             	mov    %edi,(%esp)
801012a5:	e8 36 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801012aa:	58                   	pop    %eax
801012ab:	5a                   	pop    %edx
801012ac:	56                   	push   %esi
801012ad:	ff 75 d8             	pushl  -0x28(%ebp)
801012b0:	e8 1b ee ff ff       	call   801000d0 <bread>
801012b5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801012ba:	83 c4 0c             	add    $0xc,%esp
801012bd:	68 00 02 00 00       	push   $0x200
801012c2:	6a 00                	push   $0x0
801012c4:	50                   	push   %eax
801012c5:	e8 d6 37 00 00       	call   80104aa0 <memset>
  log_write(bp);
801012ca:	89 1c 24             	mov    %ebx,(%esp)
801012cd:	e8 7e 1b 00 00       	call   80102e50 <log_write>
  brelse(bp);
801012d2:	89 1c 24             	mov    %ebx,(%esp)
801012d5:	e8 06 ef ff ff       	call   801001e0 <brelse>
}
801012da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012dd:	89 f0                	mov    %esi,%eax
801012df:	5b                   	pop    %ebx
801012e0:	5e                   	pop    %esi
801012e1:	5f                   	pop    %edi
801012e2:	5d                   	pop    %ebp
801012e3:	c3                   	ret    
801012e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801012f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012f8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fa:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
{
801012ff:	83 ec 28             	sub    $0x28,%esp
80101302:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101305:	68 e0 19 11 80       	push   $0x801119e0
8010130a:	e8 81 36 00 00       	call   80104990 <acquire>
8010130f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101312:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101315:	eb 17                	jmp    8010132e <iget+0x3e>
80101317:	89 f6                	mov    %esi,%esi
80101319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101320:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101326:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
8010132c:	73 22                	jae    80101350 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010132e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101331:	85 c9                	test   %ecx,%ecx
80101333:	7e 04                	jle    80101339 <iget+0x49>
80101335:	39 3b                	cmp    %edi,(%ebx)
80101337:	74 4f                	je     80101388 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101339:	85 f6                	test   %esi,%esi
8010133b:	75 e3                	jne    80101320 <iget+0x30>
8010133d:	85 c9                	test   %ecx,%ecx
8010133f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101342:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101348:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
8010134e:	72 de                	jb     8010132e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101350:	85 f6                	test   %esi,%esi
80101352:	74 5b                	je     801013af <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101354:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101357:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101359:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010135c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101363:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010136a:	68 e0 19 11 80       	push   $0x801119e0
8010136f:	e8 dc 36 00 00       	call   80104a50 <release>

  return ip;
80101374:	83 c4 10             	add    $0x10,%esp
}
80101377:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137a:	89 f0                	mov    %esi,%eax
8010137c:	5b                   	pop    %ebx
8010137d:	5e                   	pop    %esi
8010137e:	5f                   	pop    %edi
8010137f:	5d                   	pop    %ebp
80101380:	c3                   	ret    
80101381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101388:	39 53 04             	cmp    %edx,0x4(%ebx)
8010138b:	75 ac                	jne    80101339 <iget+0x49>
      release(&icache.lock);
8010138d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101390:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101393:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101395:	68 e0 19 11 80       	push   $0x801119e0
      ip->ref++;
8010139a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010139d:	e8 ae 36 00 00       	call   80104a50 <release>
      return ip;
801013a2:	83 c4 10             	add    $0x10,%esp
}
801013a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013a8:	89 f0                	mov    %esi,%eax
801013aa:	5b                   	pop    %ebx
801013ab:	5e                   	pop    %esi
801013ac:	5f                   	pop    %edi
801013ad:	5d                   	pop    %ebp
801013ae:	c3                   	ret    
    panic("iget: no inodes");
801013af:	83 ec 0c             	sub    $0xc,%esp
801013b2:	68 97 77 10 80       	push   $0x80107797
801013b7:	e8 d4 ef ff ff       	call   80100390 <panic>
801013bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	57                   	push   %edi
801013c4:	56                   	push   %esi
801013c5:	53                   	push   %ebx
801013c6:	89 c6                	mov    %eax,%esi
801013c8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013cb:	83 fa 0b             	cmp    $0xb,%edx
801013ce:	77 18                	ja     801013e8 <bmap+0x28>
801013d0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013d3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013d6:	85 db                	test   %ebx,%ebx
801013d8:	74 76                	je     80101450 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013dd:	89 d8                	mov    %ebx,%eax
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5f                   	pop    %edi
801013e2:	5d                   	pop    %ebp
801013e3:	c3                   	ret    
801013e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801013e8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801013eb:	83 fb 7f             	cmp    $0x7f,%ebx
801013ee:	0f 87 90 00 00 00    	ja     80101484 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801013f4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013fa:	8b 00                	mov    (%eax),%eax
801013fc:	85 d2                	test   %edx,%edx
801013fe:	74 70                	je     80101470 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101400:	83 ec 08             	sub    $0x8,%esp
80101403:	52                   	push   %edx
80101404:	50                   	push   %eax
80101405:	e8 c6 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010140a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010140e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101411:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101413:	8b 1a                	mov    (%edx),%ebx
80101415:	85 db                	test   %ebx,%ebx
80101417:	75 1d                	jne    80101436 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101419:	8b 06                	mov    (%esi),%eax
8010141b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010141e:	e8 bd fd ff ff       	call   801011e0 <balloc>
80101423:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101426:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101429:	89 c3                	mov    %eax,%ebx
8010142b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010142d:	57                   	push   %edi
8010142e:	e8 1d 1a 00 00       	call   80102e50 <log_write>
80101433:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101436:	83 ec 0c             	sub    $0xc,%esp
80101439:	57                   	push   %edi
8010143a:	e8 a1 ed ff ff       	call   801001e0 <brelse>
8010143f:	83 c4 10             	add    $0x10,%esp
}
80101442:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101445:	89 d8                	mov    %ebx,%eax
80101447:	5b                   	pop    %ebx
80101448:	5e                   	pop    %esi
80101449:	5f                   	pop    %edi
8010144a:	5d                   	pop    %ebp
8010144b:	c3                   	ret    
8010144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101450:	8b 00                	mov    (%eax),%eax
80101452:	e8 89 fd ff ff       	call   801011e0 <balloc>
80101457:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010145a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010145d:	89 c3                	mov    %eax,%ebx
}
8010145f:	89 d8                	mov    %ebx,%eax
80101461:	5b                   	pop    %ebx
80101462:	5e                   	pop    %esi
80101463:	5f                   	pop    %edi
80101464:	5d                   	pop    %ebp
80101465:	c3                   	ret    
80101466:	8d 76 00             	lea    0x0(%esi),%esi
80101469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101470:	e8 6b fd ff ff       	call   801011e0 <balloc>
80101475:	89 c2                	mov    %eax,%edx
80101477:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010147d:	8b 06                	mov    (%esi),%eax
8010147f:	e9 7c ff ff ff       	jmp    80101400 <bmap+0x40>
  panic("bmap: out of range");
80101484:	83 ec 0c             	sub    $0xc,%esp
80101487:	68 a7 77 10 80       	push   $0x801077a7
8010148c:	e8 ff ee ff ff       	call   80100390 <panic>
80101491:	eb 0d                	jmp    801014a0 <readsb>
80101493:	90                   	nop
80101494:	90                   	nop
80101495:	90                   	nop
80101496:	90                   	nop
80101497:	90                   	nop
80101498:	90                   	nop
80101499:	90                   	nop
8010149a:	90                   	nop
8010149b:	90                   	nop
8010149c:	90                   	nop
8010149d:	90                   	nop
8010149e:	90                   	nop
8010149f:	90                   	nop

801014a0 <readsb>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	56                   	push   %esi
801014a4:	53                   	push   %ebx
801014a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801014a8:	83 ec 08             	sub    $0x8,%esp
801014ab:	6a 01                	push   $0x1
801014ad:	ff 75 08             	pushl  0x8(%ebp)
801014b0:	e8 1b ec ff ff       	call   801000d0 <bread>
801014b5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801014b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801014ba:	83 c4 0c             	add    $0xc,%esp
801014bd:	6a 1c                	push   $0x1c
801014bf:	50                   	push   %eax
801014c0:	56                   	push   %esi
801014c1:	e8 8a 36 00 00       	call   80104b50 <memmove>
  brelse(bp);
801014c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014c9:	83 c4 10             	add    $0x10,%esp
}
801014cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014cf:	5b                   	pop    %ebx
801014d0:	5e                   	pop    %esi
801014d1:	5d                   	pop    %ebp
  brelse(bp);
801014d2:	e9 09 ed ff ff       	jmp    801001e0 <brelse>
801014d7:	89 f6                	mov    %esi,%esi
801014d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014e0 <bfree>:
{
801014e0:	55                   	push   %ebp
801014e1:	89 e5                	mov    %esp,%ebp
801014e3:	56                   	push   %esi
801014e4:	53                   	push   %ebx
801014e5:	89 d3                	mov    %edx,%ebx
801014e7:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
801014e9:	83 ec 08             	sub    $0x8,%esp
801014ec:	68 c0 19 11 80       	push   $0x801119c0
801014f1:	50                   	push   %eax
801014f2:	e8 a9 ff ff ff       	call   801014a0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014f7:	58                   	pop    %eax
801014f8:	5a                   	pop    %edx
801014f9:	89 da                	mov    %ebx,%edx
801014fb:	c1 ea 0c             	shr    $0xc,%edx
801014fe:	03 15 d8 19 11 80    	add    0x801119d8,%edx
80101504:	52                   	push   %edx
80101505:	56                   	push   %esi
80101506:	e8 c5 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010150b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010150d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101510:	ba 01 00 00 00       	mov    $0x1,%edx
80101515:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101518:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010151e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101521:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101523:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101528:	85 d1                	test   %edx,%ecx
8010152a:	74 25                	je     80101551 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010152c:	f7 d2                	not    %edx
8010152e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101530:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101533:	21 ca                	and    %ecx,%edx
80101535:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101539:	56                   	push   %esi
8010153a:	e8 11 19 00 00       	call   80102e50 <log_write>
  brelse(bp);
8010153f:	89 34 24             	mov    %esi,(%esp)
80101542:	e8 99 ec ff ff       	call   801001e0 <brelse>
}
80101547:	83 c4 10             	add    $0x10,%esp
8010154a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010154d:	5b                   	pop    %ebx
8010154e:	5e                   	pop    %esi
8010154f:	5d                   	pop    %ebp
80101550:	c3                   	ret    
    panic("freeing free block");
80101551:	83 ec 0c             	sub    $0xc,%esp
80101554:	68 ba 77 10 80       	push   $0x801077ba
80101559:	e8 32 ee ff ff       	call   80100390 <panic>
8010155e:	66 90                	xchg   %ax,%ax

80101560 <iinit>:
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010156c:	68 cd 77 10 80       	push   $0x801077cd
80101571:	68 e0 19 11 80       	push   $0x801119e0
80101576:	e8 d5 32 00 00       	call   80104850 <initlock>
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 d4 77 10 80       	push   $0x801077d4
80101588:	53                   	push   %ebx
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010158f:	e8 8c 31 00 00       	call   80104720 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb 40 36 11 80    	cmp    $0x80113640,%ebx
8010159d:	75 e1                	jne    80101580 <iinit+0x20>
  readsb(dev, &sb);
8010159f:	83 ec 08             	sub    $0x8,%esp
801015a2:	68 c0 19 11 80       	push   $0x801119c0
801015a7:	ff 75 08             	pushl  0x8(%ebp)
801015aa:	e8 f1 fe ff ff       	call   801014a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015af:	ff 35 d8 19 11 80    	pushl  0x801119d8
801015b5:	ff 35 d4 19 11 80    	pushl  0x801119d4
801015bb:	ff 35 d0 19 11 80    	pushl  0x801119d0
801015c1:	ff 35 cc 19 11 80    	pushl  0x801119cc
801015c7:	ff 35 c8 19 11 80    	pushl  0x801119c8
801015cd:	ff 35 c4 19 11 80    	pushl  0x801119c4
801015d3:	ff 35 c0 19 11 80    	pushl  0x801119c0
801015d9:	68 38 78 10 80       	push   $0x80107838
801015de:	e8 7d f0 ff ff       	call   80100660 <cprintf>
}
801015e3:	83 c4 30             	add    $0x30,%esp
801015e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015e9:	c9                   	leave  
801015ea:	c3                   	ret    
801015eb:	90                   	nop
801015ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015f0 <ialloc>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	57                   	push   %edi
801015f4:	56                   	push   %esi
801015f5:	53                   	push   %ebx
801015f6:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015f9:	83 3d c8 19 11 80 01 	cmpl   $0x1,0x801119c8
{
80101600:	8b 45 0c             	mov    0xc(%ebp),%eax
80101603:	8b 75 08             	mov    0x8(%ebp),%esi
80101606:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101609:	0f 86 91 00 00 00    	jbe    801016a0 <ialloc+0xb0>
8010160f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101614:	eb 21                	jmp    80101637 <ialloc+0x47>
80101616:	8d 76 00             	lea    0x0(%esi),%esi
80101619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101620:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101623:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101626:	57                   	push   %edi
80101627:	e8 b4 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010162c:	83 c4 10             	add    $0x10,%esp
8010162f:	39 1d c8 19 11 80    	cmp    %ebx,0x801119c8
80101635:	76 69                	jbe    801016a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101637:	89 d8                	mov    %ebx,%eax
80101639:	83 ec 08             	sub    $0x8,%esp
8010163c:	c1 e8 03             	shr    $0x3,%eax
8010163f:	03 05 d4 19 11 80    	add    0x801119d4,%eax
80101645:	50                   	push   %eax
80101646:	56                   	push   %esi
80101647:	e8 84 ea ff ff       	call   801000d0 <bread>
8010164c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010164e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101650:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101653:	83 e0 07             	and    $0x7,%eax
80101656:	c1 e0 06             	shl    $0x6,%eax
80101659:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010165d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101661:	75 bd                	jne    80101620 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101663:	83 ec 04             	sub    $0x4,%esp
80101666:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101669:	6a 40                	push   $0x40
8010166b:	6a 00                	push   $0x0
8010166d:	51                   	push   %ecx
8010166e:	e8 2d 34 00 00       	call   80104aa0 <memset>
      dip->type = type;
80101673:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101677:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010167a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010167d:	89 3c 24             	mov    %edi,(%esp)
80101680:	e8 cb 17 00 00       	call   80102e50 <log_write>
      brelse(bp);
80101685:	89 3c 24             	mov    %edi,(%esp)
80101688:	e8 53 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010168d:	83 c4 10             	add    $0x10,%esp
}
80101690:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101693:	89 da                	mov    %ebx,%edx
80101695:	89 f0                	mov    %esi,%eax
}
80101697:	5b                   	pop    %ebx
80101698:	5e                   	pop    %esi
80101699:	5f                   	pop    %edi
8010169a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010169b:	e9 50 fc ff ff       	jmp    801012f0 <iget>
  panic("ialloc: no inodes");
801016a0:	83 ec 0c             	sub    $0xc,%esp
801016a3:	68 da 77 10 80       	push   $0x801077da
801016a8:	e8 e3 ec ff ff       	call   80100390 <panic>
801016ad:	8d 76 00             	lea    0x0(%esi),%esi

801016b0 <iupdate>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b8:	83 ec 08             	sub    $0x8,%esp
801016bb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016be:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c1:	c1 e8 03             	shr    $0x3,%eax
801016c4:	03 05 d4 19 11 80    	add    0x801119d4,%eax
801016ca:	50                   	push   %eax
801016cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801016ce:	e8 fd e9 ff ff       	call   801000d0 <bread>
801016d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801016d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016f0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101703:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101707:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010170a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010170d:	6a 34                	push   $0x34
8010170f:	53                   	push   %ebx
80101710:	50                   	push   %eax
80101711:	e8 3a 34 00 00       	call   80104b50 <memmove>
  log_write(bp);
80101716:	89 34 24             	mov    %esi,(%esp)
80101719:	e8 32 17 00 00       	call   80102e50 <log_write>
  brelse(bp);
8010171e:	89 75 08             	mov    %esi,0x8(%ebp)
80101721:	83 c4 10             	add    $0x10,%esp
}
80101724:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101727:	5b                   	pop    %ebx
80101728:	5e                   	pop    %esi
80101729:	5d                   	pop    %ebp
  brelse(bp);
8010172a:	e9 b1 ea ff ff       	jmp    801001e0 <brelse>
8010172f:	90                   	nop

80101730 <idup>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	53                   	push   %ebx
80101734:	83 ec 10             	sub    $0x10,%esp
80101737:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010173a:	68 e0 19 11 80       	push   $0x801119e0
8010173f:	e8 4c 32 00 00       	call   80104990 <acquire>
  ip->ref++;
80101744:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101748:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010174f:	e8 fc 32 00 00       	call   80104a50 <release>
}
80101754:	89 d8                	mov    %ebx,%eax
80101756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101759:	c9                   	leave  
8010175a:	c3                   	ret    
8010175b:	90                   	nop
8010175c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101760 <ilock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	0f 84 b7 00 00 00    	je     80101827 <ilock+0xc7>
80101770:	8b 53 08             	mov    0x8(%ebx),%edx
80101773:	85 d2                	test   %edx,%edx
80101775:	0f 8e ac 00 00 00    	jle    80101827 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010177b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010177e:	83 ec 0c             	sub    $0xc,%esp
80101781:	50                   	push   %eax
80101782:	e8 d9 2f 00 00       	call   80104760 <acquiresleep>
  if(ip->valid == 0){
80101787:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010178a:	83 c4 10             	add    $0x10,%esp
8010178d:	85 c0                	test   %eax,%eax
8010178f:	74 0f                	je     801017a0 <ilock+0x40>
}
80101791:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101794:	5b                   	pop    %ebx
80101795:	5e                   	pop    %esi
80101796:	5d                   	pop    %ebp
80101797:	c3                   	ret    
80101798:	90                   	nop
80101799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017a0:	8b 43 04             	mov    0x4(%ebx),%eax
801017a3:	83 ec 08             	sub    $0x8,%esp
801017a6:	c1 e8 03             	shr    $0x3,%eax
801017a9:	03 05 d4 19 11 80    	add    0x801119d4,%eax
801017af:	50                   	push   %eax
801017b0:	ff 33                	pushl  (%ebx)
801017b2:	e8 19 e9 ff ff       	call   801000d0 <bread>
801017b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017b9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017bc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017bf:	83 e0 07             	and    $0x7,%eax
801017c2:	c1 e0 06             	shl    $0x6,%eax
801017c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017c9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017cc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017f1:	6a 34                	push   $0x34
801017f3:	50                   	push   %eax
801017f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017f7:	50                   	push   %eax
801017f8:	e8 53 33 00 00       	call   80104b50 <memmove>
    brelse(bp);
801017fd:	89 34 24             	mov    %esi,(%esp)
80101800:	e8 db e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101805:	83 c4 10             	add    $0x10,%esp
80101808:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010180d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101814:	0f 85 77 ff ff ff    	jne    80101791 <ilock+0x31>
      panic("ilock: no type");
8010181a:	83 ec 0c             	sub    $0xc,%esp
8010181d:	68 f2 77 10 80       	push   $0x801077f2
80101822:	e8 69 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101827:	83 ec 0c             	sub    $0xc,%esp
8010182a:	68 ec 77 10 80       	push   $0x801077ec
8010182f:	e8 5c eb ff ff       	call   80100390 <panic>
80101834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010183a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101840 <iunlock>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	56                   	push   %esi
80101844:	53                   	push   %ebx
80101845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101848:	85 db                	test   %ebx,%ebx
8010184a:	74 28                	je     80101874 <iunlock+0x34>
8010184c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010184f:	83 ec 0c             	sub    $0xc,%esp
80101852:	56                   	push   %esi
80101853:	e8 a8 2f 00 00       	call   80104800 <holdingsleep>
80101858:	83 c4 10             	add    $0x10,%esp
8010185b:	85 c0                	test   %eax,%eax
8010185d:	74 15                	je     80101874 <iunlock+0x34>
8010185f:	8b 43 08             	mov    0x8(%ebx),%eax
80101862:	85 c0                	test   %eax,%eax
80101864:	7e 0e                	jle    80101874 <iunlock+0x34>
  releasesleep(&ip->lock);
80101866:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101869:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010186c:	5b                   	pop    %ebx
8010186d:	5e                   	pop    %esi
8010186e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010186f:	e9 4c 2f 00 00       	jmp    801047c0 <releasesleep>
    panic("iunlock");
80101874:	83 ec 0c             	sub    $0xc,%esp
80101877:	68 01 78 10 80       	push   $0x80107801
8010187c:	e8 0f eb ff ff       	call   80100390 <panic>
80101881:	eb 0d                	jmp    80101890 <iput>
80101883:	90                   	nop
80101884:	90                   	nop
80101885:	90                   	nop
80101886:	90                   	nop
80101887:	90                   	nop
80101888:	90                   	nop
80101889:	90                   	nop
8010188a:	90                   	nop
8010188b:	90                   	nop
8010188c:	90                   	nop
8010188d:	90                   	nop
8010188e:	90                   	nop
8010188f:	90                   	nop

80101890 <iput>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	57                   	push   %edi
80101894:	56                   	push   %esi
80101895:	53                   	push   %ebx
80101896:	83 ec 28             	sub    $0x28,%esp
80101899:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010189c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010189f:	57                   	push   %edi
801018a0:	e8 bb 2e 00 00       	call   80104760 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018a5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018a8:	83 c4 10             	add    $0x10,%esp
801018ab:	85 d2                	test   %edx,%edx
801018ad:	74 07                	je     801018b6 <iput+0x26>
801018af:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018b4:	74 32                	je     801018e8 <iput+0x58>
  releasesleep(&ip->lock);
801018b6:	83 ec 0c             	sub    $0xc,%esp
801018b9:	57                   	push   %edi
801018ba:	e8 01 2f 00 00       	call   801047c0 <releasesleep>
  acquire(&icache.lock);
801018bf:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801018c6:	e8 c5 30 00 00       	call   80104990 <acquire>
  ip->ref--;
801018cb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018cf:	83 c4 10             	add    $0x10,%esp
801018d2:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
}
801018d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018dc:	5b                   	pop    %ebx
801018dd:	5e                   	pop    %esi
801018de:	5f                   	pop    %edi
801018df:	5d                   	pop    %ebp
  release(&icache.lock);
801018e0:	e9 6b 31 00 00       	jmp    80104a50 <release>
801018e5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018e8:	83 ec 0c             	sub    $0xc,%esp
801018eb:	68 e0 19 11 80       	push   $0x801119e0
801018f0:	e8 9b 30 00 00       	call   80104990 <acquire>
    int r = ip->ref;
801018f5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018f8:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801018ff:	e8 4c 31 00 00       	call   80104a50 <release>
    if(r == 1){
80101904:	83 c4 10             	add    $0x10,%esp
80101907:	83 fe 01             	cmp    $0x1,%esi
8010190a:	75 aa                	jne    801018b6 <iput+0x26>
8010190c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101912:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101915:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101918:	89 cf                	mov    %ecx,%edi
8010191a:	eb 0b                	jmp    80101927 <iput+0x97>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101920:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101923:	39 fe                	cmp    %edi,%esi
80101925:	74 19                	je     80101940 <iput+0xb0>
    if(ip->addrs[i]){
80101927:	8b 16                	mov    (%esi),%edx
80101929:	85 d2                	test   %edx,%edx
8010192b:	74 f3                	je     80101920 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010192d:	8b 03                	mov    (%ebx),%eax
8010192f:	e8 ac fb ff ff       	call   801014e0 <bfree>
      ip->addrs[i] = 0;
80101934:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010193a:	eb e4                	jmp    80101920 <iput+0x90>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101940:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101946:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101949:	85 c0                	test   %eax,%eax
8010194b:	75 33                	jne    80101980 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010194d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101950:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101957:	53                   	push   %ebx
80101958:	e8 53 fd ff ff       	call   801016b0 <iupdate>
      ip->type = 0;
8010195d:	31 c0                	xor    %eax,%eax
8010195f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101963:	89 1c 24             	mov    %ebx,(%esp)
80101966:	e8 45 fd ff ff       	call   801016b0 <iupdate>
      ip->valid = 0;
8010196b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101972:	83 c4 10             	add    $0x10,%esp
80101975:	e9 3c ff ff ff       	jmp    801018b6 <iput+0x26>
8010197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101980:	83 ec 08             	sub    $0x8,%esp
80101983:	50                   	push   %eax
80101984:	ff 33                	pushl  (%ebx)
80101986:	e8 45 e7 ff ff       	call   801000d0 <bread>
8010198b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101991:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101994:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101997:	8d 70 5c             	lea    0x5c(%eax),%esi
8010199a:	83 c4 10             	add    $0x10,%esp
8010199d:	89 cf                	mov    %ecx,%edi
8010199f:	eb 0e                	jmp    801019af <iput+0x11f>
801019a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019a8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801019ab:	39 fe                	cmp    %edi,%esi
801019ad:	74 0f                	je     801019be <iput+0x12e>
      if(a[j])
801019af:	8b 16                	mov    (%esi),%edx
801019b1:	85 d2                	test   %edx,%edx
801019b3:	74 f3                	je     801019a8 <iput+0x118>
        bfree(ip->dev, a[j]);
801019b5:	8b 03                	mov    (%ebx),%eax
801019b7:	e8 24 fb ff ff       	call   801014e0 <bfree>
801019bc:	eb ea                	jmp    801019a8 <iput+0x118>
    brelse(bp);
801019be:	83 ec 0c             	sub    $0xc,%esp
801019c1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019c7:	e8 14 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019cc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019d2:	8b 03                	mov    (%ebx),%eax
801019d4:	e8 07 fb ff ff       	call   801014e0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019d9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019e0:	00 00 00 
801019e3:	83 c4 10             	add    $0x10,%esp
801019e6:	e9 62 ff ff ff       	jmp    8010194d <iput+0xbd>
801019eb:	90                   	nop
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019f0 <iunlockput>:
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	53                   	push   %ebx
801019f4:	83 ec 10             	sub    $0x10,%esp
801019f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019fa:	53                   	push   %ebx
801019fb:	e8 40 fe ff ff       	call   80101840 <iunlock>
  iput(ip);
80101a00:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a03:	83 c4 10             	add    $0x10,%esp
}
80101a06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a09:	c9                   	leave  
  iput(ip);
80101a0a:	e9 81 fe ff ff       	jmp    80101890 <iput>
80101a0f:	90                   	nop

80101a10 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	8b 55 08             	mov    0x8(%ebp),%edx
80101a16:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a19:	8b 0a                	mov    (%edx),%ecx
80101a1b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a1e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a21:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a24:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a28:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a2b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a2f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a33:	8b 52 58             	mov    0x58(%edx),%edx
80101a36:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a39:	5d                   	pop    %ebp
80101a3a:	c3                   	ret    
80101a3b:	90                   	nop
80101a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a40 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 1c             	sub    $0x1c,%esp
80101a49:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a4f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a57:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101a5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a60:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a63:	0f 84 a7 00 00 00    	je     80101b10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a6c:	8b 40 58             	mov    0x58(%eax),%eax
80101a6f:	39 c6                	cmp    %eax,%esi
80101a71:	0f 87 ba 00 00 00    	ja     80101b31 <readi+0xf1>
80101a77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a7a:	89 f9                	mov    %edi,%ecx
80101a7c:	01 f1                	add    %esi,%ecx
80101a7e:	0f 82 ad 00 00 00    	jb     80101b31 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a84:	89 c2                	mov    %eax,%edx
80101a86:	29 f2                	sub    %esi,%edx
80101a88:	39 c8                	cmp    %ecx,%eax
80101a8a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a8d:	31 ff                	xor    %edi,%edi
80101a8f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101a91:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a94:	74 6c                	je     80101b02 <readi+0xc2>
80101a96:	8d 76 00             	lea    0x0(%esi),%esi
80101a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101aa3:	89 f2                	mov    %esi,%edx
80101aa5:	c1 ea 09             	shr    $0x9,%edx
80101aa8:	89 d8                	mov    %ebx,%eax
80101aaa:	e8 11 f9 ff ff       	call   801013c0 <bmap>
80101aaf:	83 ec 08             	sub    $0x8,%esp
80101ab2:	50                   	push   %eax
80101ab3:	ff 33                	pushl  (%ebx)
80101ab5:	e8 16 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101abd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101abf:	89 f0                	mov    %esi,%eax
80101ac1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ac6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101acb:	83 c4 0c             	add    $0xc,%esp
80101ace:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ad0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101ad4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad7:	29 fb                	sub    %edi,%ebx
80101ad9:	39 d9                	cmp    %ebx,%ecx
80101adb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ade:	53                   	push   %ebx
80101adf:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ae2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ae7:	e8 64 30 00 00       	call   80104b50 <memmove>
    brelse(bp);
80101aec:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101aef:	89 14 24             	mov    %edx,(%esp)
80101af2:	e8 e9 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101af7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101afa:	83 c4 10             	add    $0x10,%esp
80101afd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b00:	77 9e                	ja     80101aa0 <readi+0x60>
  }
  return n;
80101b02:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b08:	5b                   	pop    %ebx
80101b09:	5e                   	pop    %esi
80101b0a:	5f                   	pop    %edi
80101b0b:	5d                   	pop    %ebp
80101b0c:	c3                   	ret    
80101b0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b14:	66 83 f8 09          	cmp    $0x9,%ax
80101b18:	77 17                	ja     80101b31 <readi+0xf1>
80101b1a:	8b 04 c5 60 19 11 80 	mov    -0x7feee6a0(,%eax,8),%eax
80101b21:	85 c0                	test   %eax,%eax
80101b23:	74 0c                	je     80101b31 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b25:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b2b:	5b                   	pop    %ebx
80101b2c:	5e                   	pop    %esi
80101b2d:	5f                   	pop    %edi
80101b2e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b2f:	ff e0                	jmp    *%eax
      return -1;
80101b31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b36:	eb cd                	jmp    80101b05 <readi+0xc5>
80101b38:	90                   	nop
80101b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b40 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	57                   	push   %edi
80101b44:	56                   	push   %esi
80101b45:	53                   	push   %ebx
80101b46:	83 ec 1c             	sub    $0x1c,%esp
80101b49:	8b 45 08             	mov    0x8(%ebp),%eax
80101b4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b4f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b57:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b60:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b63:	0f 84 b7 00 00 00    	je     80101c20 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b6f:	0f 82 eb 00 00 00    	jb     80101c60 <writei+0x120>
80101b75:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b78:	31 d2                	xor    %edx,%edx
80101b7a:	89 f8                	mov    %edi,%eax
80101b7c:	01 f0                	add    %esi,%eax
80101b7e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b81:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b86:	0f 87 d4 00 00 00    	ja     80101c60 <writei+0x120>
80101b8c:	85 d2                	test   %edx,%edx
80101b8e:	0f 85 cc 00 00 00    	jne    80101c60 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b94:	85 ff                	test   %edi,%edi
80101b96:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b9d:	74 72                	je     80101c11 <writei+0xd1>
80101b9f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ba0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ba3:	89 f2                	mov    %esi,%edx
80101ba5:	c1 ea 09             	shr    $0x9,%edx
80101ba8:	89 f8                	mov    %edi,%eax
80101baa:	e8 11 f8 ff ff       	call   801013c0 <bmap>
80101baf:	83 ec 08             	sub    $0x8,%esp
80101bb2:	50                   	push   %eax
80101bb3:	ff 37                	pushl  (%edi)
80101bb5:	e8 16 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bba:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bbd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bc0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc2:	89 f0                	mov    %esi,%eax
80101bc4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bc9:	83 c4 0c             	add    $0xc,%esp
80101bcc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bd1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bd3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd7:	39 d9                	cmp    %ebx,%ecx
80101bd9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bdc:	53                   	push   %ebx
80101bdd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101be2:	50                   	push   %eax
80101be3:	e8 68 2f 00 00       	call   80104b50 <memmove>
    log_write(bp);
80101be8:	89 3c 24             	mov    %edi,(%esp)
80101beb:	e8 60 12 00 00       	call   80102e50 <log_write>
    brelse(bp);
80101bf0:	89 3c 24             	mov    %edi,(%esp)
80101bf3:	e8 e8 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bf8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bfb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bfe:	83 c4 10             	add    $0x10,%esp
80101c01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c04:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c07:	77 97                	ja     80101ba0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c0c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c0f:	77 37                	ja     80101c48 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c11:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c17:	5b                   	pop    %ebx
80101c18:	5e                   	pop    %esi
80101c19:	5f                   	pop    %edi
80101c1a:	5d                   	pop    %ebp
80101c1b:	c3                   	ret    
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c24:	66 83 f8 09          	cmp    $0x9,%ax
80101c28:	77 36                	ja     80101c60 <writei+0x120>
80101c2a:	8b 04 c5 64 19 11 80 	mov    -0x7feee69c(,%eax,8),%eax
80101c31:	85 c0                	test   %eax,%eax
80101c33:	74 2b                	je     80101c60 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101c35:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3b:	5b                   	pop    %ebx
80101c3c:	5e                   	pop    %esi
80101c3d:	5f                   	pop    %edi
80101c3e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c3f:	ff e0                	jmp    *%eax
80101c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c48:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c4b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c4e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c51:	50                   	push   %eax
80101c52:	e8 59 fa ff ff       	call   801016b0 <iupdate>
80101c57:	83 c4 10             	add    $0x10,%esp
80101c5a:	eb b5                	jmp    80101c11 <writei+0xd1>
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c65:	eb ad                	jmp    80101c14 <writei+0xd4>
80101c67:	89 f6                	mov    %esi,%esi
80101c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c70 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c76:	6a 0e                	push   $0xe
80101c78:	ff 75 0c             	pushl  0xc(%ebp)
80101c7b:	ff 75 08             	pushl  0x8(%ebp)
80101c7e:	e8 3d 2f 00 00       	call   80104bc0 <strncmp>
}
80101c83:	c9                   	leave  
80101c84:	c3                   	ret    
80101c85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c90 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	57                   	push   %edi
80101c94:	56                   	push   %esi
80101c95:	53                   	push   %ebx
80101c96:	83 ec 1c             	sub    $0x1c,%esp
80101c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ca1:	0f 85 85 00 00 00    	jne    80101d2c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ca7:	8b 53 58             	mov    0x58(%ebx),%edx
80101caa:	31 ff                	xor    %edi,%edi
80101cac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101caf:	85 d2                	test   %edx,%edx
80101cb1:	74 3e                	je     80101cf1 <dirlookup+0x61>
80101cb3:	90                   	nop
80101cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101cb8:	6a 10                	push   $0x10
80101cba:	57                   	push   %edi
80101cbb:	56                   	push   %esi
80101cbc:	53                   	push   %ebx
80101cbd:	e8 7e fd ff ff       	call   80101a40 <readi>
80101cc2:	83 c4 10             	add    $0x10,%esp
80101cc5:	83 f8 10             	cmp    $0x10,%eax
80101cc8:	75 55                	jne    80101d1f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101cca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ccf:	74 18                	je     80101ce9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101cd1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cd4:	83 ec 04             	sub    $0x4,%esp
80101cd7:	6a 0e                	push   $0xe
80101cd9:	50                   	push   %eax
80101cda:	ff 75 0c             	pushl  0xc(%ebp)
80101cdd:	e8 de 2e 00 00       	call   80104bc0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101ce2:	83 c4 10             	add    $0x10,%esp
80101ce5:	85 c0                	test   %eax,%eax
80101ce7:	74 17                	je     80101d00 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ce9:	83 c7 10             	add    $0x10,%edi
80101cec:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cef:	72 c7                	jb     80101cb8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101cf4:	31 c0                	xor    %eax,%eax
}
80101cf6:	5b                   	pop    %ebx
80101cf7:	5e                   	pop    %esi
80101cf8:	5f                   	pop    %edi
80101cf9:	5d                   	pop    %ebp
80101cfa:	c3                   	ret    
80101cfb:	90                   	nop
80101cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101d00:	8b 45 10             	mov    0x10(%ebp),%eax
80101d03:	85 c0                	test   %eax,%eax
80101d05:	74 05                	je     80101d0c <dirlookup+0x7c>
        *poff = off;
80101d07:	8b 45 10             	mov    0x10(%ebp),%eax
80101d0a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d0c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d10:	8b 03                	mov    (%ebx),%eax
80101d12:	e8 d9 f5 ff ff       	call   801012f0 <iget>
}
80101d17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d1a:	5b                   	pop    %ebx
80101d1b:	5e                   	pop    %esi
80101d1c:	5f                   	pop    %edi
80101d1d:	5d                   	pop    %ebp
80101d1e:	c3                   	ret    
      panic("dirlookup read");
80101d1f:	83 ec 0c             	sub    $0xc,%esp
80101d22:	68 1b 78 10 80       	push   $0x8010781b
80101d27:	e8 64 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d2c:	83 ec 0c             	sub    $0xc,%esp
80101d2f:	68 09 78 10 80       	push   $0x80107809
80101d34:	e8 57 e6 ff ff       	call   80100390 <panic>
80101d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	56                   	push   %esi
80101d45:	53                   	push   %ebx
80101d46:	89 cf                	mov    %ecx,%edi
80101d48:	89 c3                	mov    %eax,%ebx
80101d4a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d4d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d53:	0f 84 67 01 00 00    	je     80101ec0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d59:	e8 02 1c 00 00       	call   80103960 <myproc>
  acquire(&icache.lock);
80101d5e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d61:	8b 70 58             	mov    0x58(%eax),%esi
  acquire(&icache.lock);
80101d64:	68 e0 19 11 80       	push   $0x801119e0
80101d69:	e8 22 2c 00 00       	call   80104990 <acquire>
  ip->ref++;
80101d6e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d72:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101d79:	e8 d2 2c 00 00       	call   80104a50 <release>
80101d7e:	83 c4 10             	add    $0x10,%esp
80101d81:	eb 08                	jmp    80101d8b <namex+0x4b>
80101d83:	90                   	nop
80101d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101d88:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d8b:	0f b6 03             	movzbl (%ebx),%eax
80101d8e:	3c 2f                	cmp    $0x2f,%al
80101d90:	74 f6                	je     80101d88 <namex+0x48>
  if(*path == 0)
80101d92:	84 c0                	test   %al,%al
80101d94:	0f 84 ee 00 00 00    	je     80101e88 <namex+0x148>
  while(*path != '/' && *path != 0)
80101d9a:	0f b6 03             	movzbl (%ebx),%eax
80101d9d:	3c 2f                	cmp    $0x2f,%al
80101d9f:	0f 84 b3 00 00 00    	je     80101e58 <namex+0x118>
80101da5:	84 c0                	test   %al,%al
80101da7:	89 da                	mov    %ebx,%edx
80101da9:	75 09                	jne    80101db4 <namex+0x74>
80101dab:	e9 a8 00 00 00       	jmp    80101e58 <namex+0x118>
80101db0:	84 c0                	test   %al,%al
80101db2:	74 0a                	je     80101dbe <namex+0x7e>
    path++;
80101db4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101db7:	0f b6 02             	movzbl (%edx),%eax
80101dba:	3c 2f                	cmp    $0x2f,%al
80101dbc:	75 f2                	jne    80101db0 <namex+0x70>
80101dbe:	89 d1                	mov    %edx,%ecx
80101dc0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101dc2:	83 f9 0d             	cmp    $0xd,%ecx
80101dc5:	0f 8e 91 00 00 00    	jle    80101e5c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101dcb:	83 ec 04             	sub    $0x4,%esp
80101dce:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101dd1:	6a 0e                	push   $0xe
80101dd3:	53                   	push   %ebx
80101dd4:	57                   	push   %edi
80101dd5:	e8 76 2d 00 00       	call   80104b50 <memmove>
    path++;
80101dda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101ddd:	83 c4 10             	add    $0x10,%esp
    path++;
80101de0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101de2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101de5:	75 11                	jne    80101df8 <namex+0xb8>
80101de7:	89 f6                	mov    %esi,%esi
80101de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101df0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101df3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101df6:	74 f8                	je     80101df0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101df8:	83 ec 0c             	sub    $0xc,%esp
80101dfb:	56                   	push   %esi
80101dfc:	e8 5f f9 ff ff       	call   80101760 <ilock>
    if(ip->type != T_DIR){
80101e01:	83 c4 10             	add    $0x10,%esp
80101e04:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e09:	0f 85 91 00 00 00    	jne    80101ea0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e12:	85 d2                	test   %edx,%edx
80101e14:	74 09                	je     80101e1f <namex+0xdf>
80101e16:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e19:	0f 84 b7 00 00 00    	je     80101ed6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e1f:	83 ec 04             	sub    $0x4,%esp
80101e22:	6a 00                	push   $0x0
80101e24:	57                   	push   %edi
80101e25:	56                   	push   %esi
80101e26:	e8 65 fe ff ff       	call   80101c90 <dirlookup>
80101e2b:	83 c4 10             	add    $0x10,%esp
80101e2e:	85 c0                	test   %eax,%eax
80101e30:	74 6e                	je     80101ea0 <namex+0x160>
  iunlock(ip);
80101e32:	83 ec 0c             	sub    $0xc,%esp
80101e35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e38:	56                   	push   %esi
80101e39:	e8 02 fa ff ff       	call   80101840 <iunlock>
  iput(ip);
80101e3e:	89 34 24             	mov    %esi,(%esp)
80101e41:	e8 4a fa ff ff       	call   80101890 <iput>
80101e46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	89 c6                	mov    %eax,%esi
80101e4e:	e9 38 ff ff ff       	jmp    80101d8b <namex+0x4b>
80101e53:	90                   	nop
80101e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e58:	89 da                	mov    %ebx,%edx
80101e5a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e5c:	83 ec 04             	sub    $0x4,%esp
80101e5f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e62:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e65:	51                   	push   %ecx
80101e66:	53                   	push   %ebx
80101e67:	57                   	push   %edi
80101e68:	e8 e3 2c 00 00       	call   80104b50 <memmove>
    name[len] = 0;
80101e6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e70:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e73:	83 c4 10             	add    $0x10,%esp
80101e76:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e7a:	89 d3                	mov    %edx,%ebx
80101e7c:	e9 61 ff ff ff       	jmp    80101de2 <namex+0xa2>
80101e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e88:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e8b:	85 c0                	test   %eax,%eax
80101e8d:	75 5d                	jne    80101eec <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e92:	89 f0                	mov    %esi,%eax
80101e94:	5b                   	pop    %ebx
80101e95:	5e                   	pop    %esi
80101e96:	5f                   	pop    %edi
80101e97:	5d                   	pop    %ebp
80101e98:	c3                   	ret    
80101e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101ea0:	83 ec 0c             	sub    $0xc,%esp
80101ea3:	56                   	push   %esi
80101ea4:	e8 97 f9 ff ff       	call   80101840 <iunlock>
  iput(ip);
80101ea9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101eac:	31 f6                	xor    %esi,%esi
  iput(ip);
80101eae:	e8 dd f9 ff ff       	call   80101890 <iput>
      return 0;
80101eb3:	83 c4 10             	add    $0x10,%esp
}
80101eb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb9:	89 f0                	mov    %esi,%eax
80101ebb:	5b                   	pop    %ebx
80101ebc:	5e                   	pop    %esi
80101ebd:	5f                   	pop    %edi
80101ebe:	5d                   	pop    %ebp
80101ebf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101ec0:	ba 01 00 00 00       	mov    $0x1,%edx
80101ec5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eca:	e8 21 f4 ff ff       	call   801012f0 <iget>
80101ecf:	89 c6                	mov    %eax,%esi
80101ed1:	e9 b5 fe ff ff       	jmp    80101d8b <namex+0x4b>
      iunlock(ip);
80101ed6:	83 ec 0c             	sub    $0xc,%esp
80101ed9:	56                   	push   %esi
80101eda:	e8 61 f9 ff ff       	call   80101840 <iunlock>
      return ip;
80101edf:	83 c4 10             	add    $0x10,%esp
}
80101ee2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee5:	89 f0                	mov    %esi,%eax
80101ee7:	5b                   	pop    %ebx
80101ee8:	5e                   	pop    %esi
80101ee9:	5f                   	pop    %edi
80101eea:	5d                   	pop    %ebp
80101eeb:	c3                   	ret    
    iput(ip);
80101eec:	83 ec 0c             	sub    $0xc,%esp
80101eef:	56                   	push   %esi
    return 0;
80101ef0:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ef2:	e8 99 f9 ff ff       	call   80101890 <iput>
    return 0;
80101ef7:	83 c4 10             	add    $0x10,%esp
80101efa:	eb 93                	jmp    80101e8f <namex+0x14f>
80101efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f00 <dirlink>:
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	83 ec 20             	sub    $0x20,%esp
80101f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f0c:	6a 00                	push   $0x0
80101f0e:	ff 75 0c             	pushl  0xc(%ebp)
80101f11:	53                   	push   %ebx
80101f12:	e8 79 fd ff ff       	call   80101c90 <dirlookup>
80101f17:	83 c4 10             	add    $0x10,%esp
80101f1a:	85 c0                	test   %eax,%eax
80101f1c:	75 67                	jne    80101f85 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f24:	85 ff                	test   %edi,%edi
80101f26:	74 29                	je     80101f51 <dirlink+0x51>
80101f28:	31 ff                	xor    %edi,%edi
80101f2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f2d:	eb 09                	jmp    80101f38 <dirlink+0x38>
80101f2f:	90                   	nop
80101f30:	83 c7 10             	add    $0x10,%edi
80101f33:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f36:	73 19                	jae    80101f51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f38:	6a 10                	push   $0x10
80101f3a:	57                   	push   %edi
80101f3b:	56                   	push   %esi
80101f3c:	53                   	push   %ebx
80101f3d:	e8 fe fa ff ff       	call   80101a40 <readi>
80101f42:	83 c4 10             	add    $0x10,%esp
80101f45:	83 f8 10             	cmp    $0x10,%eax
80101f48:	75 4e                	jne    80101f98 <dirlink+0x98>
    if(de.inum == 0)
80101f4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f4f:	75 df                	jne    80101f30 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f54:	83 ec 04             	sub    $0x4,%esp
80101f57:	6a 0e                	push   $0xe
80101f59:	ff 75 0c             	pushl  0xc(%ebp)
80101f5c:	50                   	push   %eax
80101f5d:	e8 be 2c 00 00       	call   80104c20 <strncpy>
  de.inum = inum;
80101f62:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f65:	6a 10                	push   $0x10
80101f67:	57                   	push   %edi
80101f68:	56                   	push   %esi
80101f69:	53                   	push   %ebx
  de.inum = inum;
80101f6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f6e:	e8 cd fb ff ff       	call   80101b40 <writei>
80101f73:	83 c4 20             	add    $0x20,%esp
80101f76:	83 f8 10             	cmp    $0x10,%eax
80101f79:	75 2a                	jne    80101fa5 <dirlink+0xa5>
  return 0;
80101f7b:	31 c0                	xor    %eax,%eax
}
80101f7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f80:	5b                   	pop    %ebx
80101f81:	5e                   	pop    %esi
80101f82:	5f                   	pop    %edi
80101f83:	5d                   	pop    %ebp
80101f84:	c3                   	ret    
    iput(ip);
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	50                   	push   %eax
80101f89:	e8 02 f9 ff ff       	call   80101890 <iput>
    return -1;
80101f8e:	83 c4 10             	add    $0x10,%esp
80101f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f96:	eb e5                	jmp    80101f7d <dirlink+0x7d>
      panic("dirlink read");
80101f98:	83 ec 0c             	sub    $0xc,%esp
80101f9b:	68 2a 78 10 80       	push   $0x8010782a
80101fa0:	e8 eb e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	68 ee 7e 10 80       	push   $0x80107eee
80101fad:	e8 de e3 ff ff       	call   80100390 <panic>
80101fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fc0 <namei>:

struct inode*
namei(char *path)
{
80101fc0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fc1:	31 d2                	xor    %edx,%edx
{
80101fc3:	89 e5                	mov    %esp,%ebp
80101fc5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fce:	e8 6d fd ff ff       	call   80101d40 <namex>
}
80101fd3:	c9                   	leave  
80101fd4:	c3                   	ret    
80101fd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fe0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fe0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fe1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fe6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fe8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101feb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fee:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fef:	e9 4c fd ff ff       	jmp    80101d40 <namex>
80101ff4:	66 90                	xchg   %ax,%ax
80101ff6:	66 90                	xchg   %ax,%ax
80101ff8:	66 90                	xchg   %ax,%ax
80101ffa:	66 90                	xchg   %ax,%ax
80101ffc:	66 90                	xchg   %ax,%ax
80101ffe:	66 90                	xchg   %ax,%ax

80102000 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102009:	85 c0                	test   %eax,%eax
8010200b:	0f 84 b4 00 00 00    	je     801020c5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102011:	8b 58 08             	mov    0x8(%eax),%ebx
80102014:	89 c6                	mov    %eax,%esi
80102016:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010201c:	0f 87 96 00 00 00    	ja     801020b8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102022:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102030:	89 ca                	mov    %ecx,%edx
80102032:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102033:	83 e0 c0             	and    $0xffffffc0,%eax
80102036:	3c 40                	cmp    $0x40,%al
80102038:	75 f6                	jne    80102030 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010203a:	31 ff                	xor    %edi,%edi
8010203c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102041:	89 f8                	mov    %edi,%eax
80102043:	ee                   	out    %al,(%dx)
80102044:	b8 01 00 00 00       	mov    $0x1,%eax
80102049:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010204e:	ee                   	out    %al,(%dx)
8010204f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102054:	89 d8                	mov    %ebx,%eax
80102056:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102057:	89 d8                	mov    %ebx,%eax
80102059:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010205e:	c1 f8 08             	sar    $0x8,%eax
80102061:	ee                   	out    %al,(%dx)
80102062:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102067:	89 f8                	mov    %edi,%eax
80102069:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010206a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010206e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102073:	c1 e0 04             	shl    $0x4,%eax
80102076:	83 e0 10             	and    $0x10,%eax
80102079:	83 c8 e0             	or     $0xffffffe0,%eax
8010207c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010207d:	f6 06 04             	testb  $0x4,(%esi)
80102080:	75 16                	jne    80102098 <idestart+0x98>
80102082:	b8 20 00 00 00       	mov    $0x20,%eax
80102087:	89 ca                	mov    %ecx,%edx
80102089:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010208a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010208d:	5b                   	pop    %ebx
8010208e:	5e                   	pop    %esi
8010208f:	5f                   	pop    %edi
80102090:	5d                   	pop    %ebp
80102091:	c3                   	ret    
80102092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102098:	b8 30 00 00 00       	mov    $0x30,%eax
8010209d:	89 ca                	mov    %ecx,%edx
8010209f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020a0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020a5:	83 c6 5c             	add    $0x5c,%esi
801020a8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ad:	fc                   	cld    
801020ae:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b3:	5b                   	pop    %ebx
801020b4:	5e                   	pop    %esi
801020b5:	5f                   	pop    %edi
801020b6:	5d                   	pop    %ebp
801020b7:	c3                   	ret    
    panic("incorrect blockno");
801020b8:	83 ec 0c             	sub    $0xc,%esp
801020bb:	68 94 78 10 80       	push   $0x80107894
801020c0:	e8 cb e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	68 8b 78 10 80       	push   $0x8010788b
801020cd:	e8 be e2 ff ff       	call   80100390 <panic>
801020d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020e6:	68 a6 78 10 80       	push   $0x801078a6
801020eb:	68 80 b5 10 80       	push   $0x8010b580
801020f0:	e8 5b 27 00 00       	call   80104850 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020f5:	58                   	pop    %eax
801020f6:	a1 20 3d 11 80       	mov    0x80113d20,%eax
801020fb:	5a                   	pop    %edx
801020fc:	83 e8 01             	sub    $0x1,%eax
801020ff:	50                   	push   %eax
80102100:	6a 0e                	push   $0xe
80102102:	e8 a9 02 00 00       	call   801023b0 <ioapicenable>
80102107:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010210a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010210f:	90                   	nop
80102110:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102111:	83 e0 c0             	and    $0xffffffc0,%eax
80102114:	3c 40                	cmp    $0x40,%al
80102116:	75 f8                	jne    80102110 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102118:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010211d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102122:	ee                   	out    %al,(%dx)
80102123:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102128:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010212d:	eb 06                	jmp    80102135 <ideinit+0x55>
8010212f:	90                   	nop
  for(i=0; i<1000; i++){
80102130:	83 e9 01             	sub    $0x1,%ecx
80102133:	74 0f                	je     80102144 <ideinit+0x64>
80102135:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102136:	84 c0                	test   %al,%al
80102138:	74 f6                	je     80102130 <ideinit+0x50>
      havedisk1 = 1;
8010213a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102141:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102144:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102149:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010214e:	ee                   	out    %al,(%dx)
}
8010214f:	c9                   	leave  
80102150:	c3                   	ret    
80102151:	eb 0d                	jmp    80102160 <ideintr>
80102153:	90                   	nop
80102154:	90                   	nop
80102155:	90                   	nop
80102156:	90                   	nop
80102157:	90                   	nop
80102158:	90                   	nop
80102159:	90                   	nop
8010215a:	90                   	nop
8010215b:	90                   	nop
8010215c:	90                   	nop
8010215d:	90                   	nop
8010215e:	90                   	nop
8010215f:	90                   	nop

80102160 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102169:	68 80 b5 10 80       	push   $0x8010b580
8010216e:	e8 1d 28 00 00       	call   80104990 <acquire>

  if((b = idequeue) == 0){
80102173:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102179:	83 c4 10             	add    $0x10,%esp
8010217c:	85 db                	test   %ebx,%ebx
8010217e:	74 67                	je     801021e7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102180:	8b 43 58             	mov    0x58(%ebx),%eax
80102183:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102188:	8b 3b                	mov    (%ebx),%edi
8010218a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102190:	75 31                	jne    801021c3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102192:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102197:	89 f6                	mov    %esi,%esi
80102199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801021a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a1:	89 c6                	mov    %eax,%esi
801021a3:	83 e6 c0             	and    $0xffffffc0,%esi
801021a6:	89 f1                	mov    %esi,%ecx
801021a8:	80 f9 40             	cmp    $0x40,%cl
801021ab:	75 f3                	jne    801021a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021ad:	a8 21                	test   $0x21,%al
801021af:	75 12                	jne    801021c3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801021b1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021b4:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021be:	fc                   	cld    
801021bf:	f3 6d                	rep insl (%dx),%es:(%edi)
801021c1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021c3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801021c6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021c9:	89 f9                	mov    %edi,%ecx
801021cb:	83 c9 02             	or     $0x2,%ecx
801021ce:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021d0:	53                   	push   %ebx
801021d1:	e8 da 1e 00 00       	call   801040b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d6:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801021db:	83 c4 10             	add    $0x10,%esp
801021de:	85 c0                	test   %eax,%eax
801021e0:	74 05                	je     801021e7 <ideintr+0x87>
    idestart(idequeue);
801021e2:	e8 19 fe ff ff       	call   80102000 <idestart>
    release(&idelock);
801021e7:	83 ec 0c             	sub    $0xc,%esp
801021ea:	68 80 b5 10 80       	push   $0x8010b580
801021ef:	e8 5c 28 00 00       	call   80104a50 <release>

  release(&idelock);
}
801021f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021f7:	5b                   	pop    %ebx
801021f8:	5e                   	pop    %esi
801021f9:	5f                   	pop    %edi
801021fa:	5d                   	pop    %ebp
801021fb:	c3                   	ret    
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102200 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	53                   	push   %ebx
80102204:	83 ec 10             	sub    $0x10,%esp
80102207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010220a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010220d:	50                   	push   %eax
8010220e:	e8 ed 25 00 00       	call   80104800 <holdingsleep>
80102213:	83 c4 10             	add    $0x10,%esp
80102216:	85 c0                	test   %eax,%eax
80102218:	0f 84 c6 00 00 00    	je     801022e4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010221e:	8b 03                	mov    (%ebx),%eax
80102220:	83 e0 06             	and    $0x6,%eax
80102223:	83 f8 02             	cmp    $0x2,%eax
80102226:	0f 84 ab 00 00 00    	je     801022d7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010222c:	8b 53 04             	mov    0x4(%ebx),%edx
8010222f:	85 d2                	test   %edx,%edx
80102231:	74 0d                	je     80102240 <iderw+0x40>
80102233:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102238:	85 c0                	test   %eax,%eax
8010223a:	0f 84 b1 00 00 00    	je     801022f1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	83 ec 0c             	sub    $0xc,%esp
80102243:	68 80 b5 10 80       	push   $0x8010b580
80102248:	e8 43 27 00 00       	call   80104990 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
80102253:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102256:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010225d:	85 d2                	test   %edx,%edx
8010225f:	75 09                	jne    8010226a <iderw+0x6a>
80102261:	eb 6d                	jmp    801022d0 <iderw+0xd0>
80102263:	90                   	nop
80102264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102268:	89 c2                	mov    %eax,%edx
8010226a:	8b 42 58             	mov    0x58(%edx),%eax
8010226d:	85 c0                	test   %eax,%eax
8010226f:	75 f7                	jne    80102268 <iderw+0x68>
80102271:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102274:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102276:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
8010227c:	74 42                	je     801022c0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010227e:	8b 03                	mov    (%ebx),%eax
80102280:	83 e0 06             	and    $0x6,%eax
80102283:	83 f8 02             	cmp    $0x2,%eax
80102286:	74 23                	je     801022ab <iderw+0xab>
80102288:	90                   	nop
80102289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102290:	83 ec 08             	sub    $0x8,%esp
80102293:	68 80 b5 10 80       	push   $0x8010b580
80102298:	53                   	push   %ebx
80102299:	e8 52 1d 00 00       	call   80103ff0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010229e:	8b 03                	mov    (%ebx),%eax
801022a0:	83 c4 10             	add    $0x10,%esp
801022a3:	83 e0 06             	and    $0x6,%eax
801022a6:	83 f8 02             	cmp    $0x2,%eax
801022a9:	75 e5                	jne    80102290 <iderw+0x90>
  }


  release(&idelock);
801022ab:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801022b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022b5:	c9                   	leave  
  release(&idelock);
801022b6:	e9 95 27 00 00       	jmp    80104a50 <release>
801022bb:	90                   	nop
801022bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022c0:	89 d8                	mov    %ebx,%eax
801022c2:	e8 39 fd ff ff       	call   80102000 <idestart>
801022c7:	eb b5                	jmp    8010227e <iderw+0x7e>
801022c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022d0:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801022d5:	eb 9d                	jmp    80102274 <iderw+0x74>
    panic("iderw: nothing to do");
801022d7:	83 ec 0c             	sub    $0xc,%esp
801022da:	68 c0 78 10 80       	push   $0x801078c0
801022df:	e8 ac e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022e4:	83 ec 0c             	sub    $0xc,%esp
801022e7:	68 aa 78 10 80       	push   $0x801078aa
801022ec:	e8 9f e0 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801022f1:	83 ec 0c             	sub    $0xc,%esp
801022f4:	68 d5 78 10 80       	push   $0x801078d5
801022f9:	e8 92 e0 ff ff       	call   80100390 <panic>
801022fe:	66 90                	xchg   %ax,%ax

80102300 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102300:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102301:	c7 05 34 36 11 80 00 	movl   $0xfec00000,0x80113634
80102308:	00 c0 fe 
{
8010230b:	89 e5                	mov    %esp,%ebp
8010230d:	56                   	push   %esi
8010230e:	53                   	push   %ebx
  ioapic->reg = reg;
8010230f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102316:	00 00 00 
  return ioapic->data;
80102319:	a1 34 36 11 80       	mov    0x80113634,%eax
8010231e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102321:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102327:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010232d:	0f b6 15 60 37 11 80 	movzbl 0x80113760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102334:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102337:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010233a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010233d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102340:	39 c2                	cmp    %eax,%edx
80102342:	74 16                	je     8010235a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102344:	83 ec 0c             	sub    $0xc,%esp
80102347:	68 f4 78 10 80       	push   $0x801078f4
8010234c:	e8 0f e3 ff ff       	call   80100660 <cprintf>
80102351:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
80102357:	83 c4 10             	add    $0x10,%esp
8010235a:	83 c3 21             	add    $0x21,%ebx
{
8010235d:	ba 10 00 00 00       	mov    $0x10,%edx
80102362:	b8 20 00 00 00       	mov    $0x20,%eax
80102367:	89 f6                	mov    %esi,%esi
80102369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102370:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102372:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102378:	89 c6                	mov    %eax,%esi
8010237a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102380:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102383:	89 71 10             	mov    %esi,0x10(%ecx)
80102386:	8d 72 01             	lea    0x1(%edx),%esi
80102389:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010238c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010238e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102390:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
80102396:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010239d:	75 d1                	jne    80102370 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010239f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a2:	5b                   	pop    %ebx
801023a3:	5e                   	pop    %esi
801023a4:	5d                   	pop    %ebp
801023a5:	c3                   	ret    
801023a6:	8d 76 00             	lea    0x0(%esi),%esi
801023a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023b0:	55                   	push   %ebp
  ioapic->reg = reg;
801023b1:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
{
801023b7:	89 e5                	mov    %esp,%ebp
801023b9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023bc:	8d 50 20             	lea    0x20(%eax),%edx
801023bf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023c3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c5:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023cb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023ce:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023d4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023d6:	a1 34 36 11 80       	mov    0x80113634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023db:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023de:	89 50 10             	mov    %edx,0x10(%eax)
}
801023e1:	5d                   	pop    %ebp
801023e2:	c3                   	ret    
801023e3:	66 90                	xchg   %ax,%ax
801023e5:	66 90                	xchg   %ax,%ax
801023e7:	66 90                	xchg   %ax,%ax
801023e9:	66 90                	xchg   %ax,%ax
801023eb:	66 90                	xchg   %ax,%ax
801023ed:	66 90                	xchg   %ax,%ax
801023ef:	90                   	nop

801023f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	53                   	push   %ebx
801023f4:	83 ec 04             	sub    $0x4,%esp
801023f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102400:	75 70                	jne    80102472 <kfree+0x82>
80102402:	81 fb c8 f1 11 80    	cmp    $0x8011f1c8,%ebx
80102408:	72 68                	jb     80102472 <kfree+0x82>
8010240a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102410:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102415:	77 5b                	ja     80102472 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102417:	83 ec 04             	sub    $0x4,%esp
8010241a:	68 00 10 00 00       	push   $0x1000
8010241f:	6a 01                	push   $0x1
80102421:	53                   	push   %ebx
80102422:	e8 79 26 00 00       	call   80104aa0 <memset>

  if(kmem.use_lock)
80102427:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010242d:	83 c4 10             	add    $0x10,%esp
80102430:	85 d2                	test   %edx,%edx
80102432:	75 2c                	jne    80102460 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102434:	a1 78 36 11 80       	mov    0x80113678,%eax
80102439:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010243b:	a1 74 36 11 80       	mov    0x80113674,%eax
  kmem.freelist = r;
80102440:	89 1d 78 36 11 80    	mov    %ebx,0x80113678
  if(kmem.use_lock)
80102446:	85 c0                	test   %eax,%eax
80102448:	75 06                	jne    80102450 <kfree+0x60>
    release(&kmem.lock);
}
8010244a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010244d:	c9                   	leave  
8010244e:	c3                   	ret    
8010244f:	90                   	nop
    release(&kmem.lock);
80102450:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
80102457:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010245a:	c9                   	leave  
    release(&kmem.lock);
8010245b:	e9 f0 25 00 00       	jmp    80104a50 <release>
    acquire(&kmem.lock);
80102460:	83 ec 0c             	sub    $0xc,%esp
80102463:	68 40 36 11 80       	push   $0x80113640
80102468:	e8 23 25 00 00       	call   80104990 <acquire>
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	eb c2                	jmp    80102434 <kfree+0x44>
    panic("kfree");
80102472:	83 ec 0c             	sub    $0xc,%esp
80102475:	68 26 79 10 80       	push   $0x80107926
8010247a:	e8 11 df ff ff       	call   80100390 <panic>
8010247f:	90                   	nop

80102480 <freerange>:
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
8010249f:	72 23                	jb     801024c4 <freerange+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ae:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 33 ff ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 f3                	cmp    %esi,%ebx
801024c2:	76 e4                	jbe    801024a8 <freerange+0x28>
}
801024c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024c7:	5b                   	pop    %ebx
801024c8:	5e                   	pop    %esi
801024c9:	5d                   	pop    %ebp
801024ca:	c3                   	ret    
801024cb:	90                   	nop
801024cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024d0 <kinit1>:
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	56                   	push   %esi
801024d4:	53                   	push   %ebx
801024d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024d8:	83 ec 08             	sub    $0x8,%esp
801024db:	68 2c 79 10 80       	push   $0x8010792c
801024e0:	68 40 36 11 80       	push   $0x80113640
801024e5:	e8 66 23 00 00       	call   80104850 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024ea:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ed:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801024f0:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
801024f7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801024fa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102500:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102506:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010250c:	39 de                	cmp    %ebx,%esi
8010250e:	72 1c                	jb     8010252c <kinit1+0x5c>
    kfree(p);
80102510:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102516:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102519:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010251f:	50                   	push   %eax
80102520:	e8 cb fe ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102525:	83 c4 10             	add    $0x10,%esp
80102528:	39 de                	cmp    %ebx,%esi
8010252a:	73 e4                	jae    80102510 <kinit1+0x40>
}
8010252c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010252f:	5b                   	pop    %ebx
80102530:	5e                   	pop    %esi
80102531:	5d                   	pop    %ebp
80102532:	c3                   	ret    
80102533:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102540 <kinit2>:
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	56                   	push   %esi
80102544:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102545:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102548:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010254b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102551:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102557:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010255d:	39 de                	cmp    %ebx,%esi
8010255f:	72 23                	jb     80102584 <kinit2+0x44>
80102561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102568:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010256e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102571:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102577:	50                   	push   %eax
80102578:	e8 73 fe ff ff       	call   801023f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	39 de                	cmp    %ebx,%esi
80102582:	73 e4                	jae    80102568 <kinit2+0x28>
  kmem.use_lock = 1;
80102584:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
8010258b:	00 00 00 
}
8010258e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102591:	5b                   	pop    %ebx
80102592:	5e                   	pop    %esi
80102593:	5d                   	pop    %ebp
80102594:	c3                   	ret    
80102595:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025a0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801025a0:	a1 74 36 11 80       	mov    0x80113674,%eax
801025a5:	85 c0                	test   %eax,%eax
801025a7:	75 1f                	jne    801025c8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025a9:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
801025ae:	85 c0                	test   %eax,%eax
801025b0:	74 0e                	je     801025c0 <kalloc+0x20>
    kmem.freelist = r->next;
801025b2:	8b 10                	mov    (%eax),%edx
801025b4:	89 15 78 36 11 80    	mov    %edx,0x80113678
801025ba:	c3                   	ret    
801025bb:	90                   	nop
801025bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025c0:	f3 c3                	repz ret 
801025c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801025c8:	55                   	push   %ebp
801025c9:	89 e5                	mov    %esp,%ebp
801025cb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801025ce:	68 40 36 11 80       	push   $0x80113640
801025d3:	e8 b8 23 00 00       	call   80104990 <acquire>
  r = kmem.freelist;
801025d8:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	8b 15 74 36 11 80    	mov    0x80113674,%edx
801025e6:	85 c0                	test   %eax,%eax
801025e8:	74 08                	je     801025f2 <kalloc+0x52>
    kmem.freelist = r->next;
801025ea:	8b 08                	mov    (%eax),%ecx
801025ec:	89 0d 78 36 11 80    	mov    %ecx,0x80113678
  if(kmem.use_lock)
801025f2:	85 d2                	test   %edx,%edx
801025f4:	74 16                	je     8010260c <kalloc+0x6c>
    release(&kmem.lock);
801025f6:	83 ec 0c             	sub    $0xc,%esp
801025f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025fc:	68 40 36 11 80       	push   $0x80113640
80102601:	e8 4a 24 00 00       	call   80104a50 <release>
  return (char*)r;
80102606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102609:	83 c4 10             	add    $0x10,%esp
}
8010260c:	c9                   	leave  
8010260d:	c3                   	ret    
8010260e:	66 90                	xchg   %ax,%ax

80102610 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102610:	ba 64 00 00 00       	mov    $0x64,%edx
80102615:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102616:	a8 01                	test   $0x1,%al
80102618:	0f 84 c2 00 00 00    	je     801026e0 <kbdgetc+0xd0>
8010261e:	ba 60 00 00 00       	mov    $0x60,%edx
80102623:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102624:	0f b6 d0             	movzbl %al,%edx
80102627:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
8010262d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102633:	0f 84 7f 00 00 00    	je     801026b8 <kbdgetc+0xa8>
{
80102639:	55                   	push   %ebp
8010263a:	89 e5                	mov    %esp,%ebp
8010263c:	53                   	push   %ebx
8010263d:	89 cb                	mov    %ecx,%ebx
8010263f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102642:	84 c0                	test   %al,%al
80102644:	78 4a                	js     80102690 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102646:	85 db                	test   %ebx,%ebx
80102648:	74 09                	je     80102653 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010264a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010264d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102650:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102653:	0f b6 82 60 7a 10 80 	movzbl -0x7fef85a0(%edx),%eax
8010265a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010265c:	0f b6 82 60 79 10 80 	movzbl -0x7fef86a0(%edx),%eax
80102663:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102665:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102667:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010266d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102670:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102673:	8b 04 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%eax
8010267a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010267e:	74 31                	je     801026b1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102680:	8d 50 9f             	lea    -0x61(%eax),%edx
80102683:	83 fa 19             	cmp    $0x19,%edx
80102686:	77 40                	ja     801026c8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102688:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010268b:	5b                   	pop    %ebx
8010268c:	5d                   	pop    %ebp
8010268d:	c3                   	ret    
8010268e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102690:	83 e0 7f             	and    $0x7f,%eax
80102693:	85 db                	test   %ebx,%ebx
80102695:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102698:	0f b6 82 60 7a 10 80 	movzbl -0x7fef85a0(%edx),%eax
8010269f:	83 c8 40             	or     $0x40,%eax
801026a2:	0f b6 c0             	movzbl %al,%eax
801026a5:	f7 d0                	not    %eax
801026a7:	21 c1                	and    %eax,%ecx
    return 0;
801026a9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026ab:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
801026b1:	5b                   	pop    %ebx
801026b2:	5d                   	pop    %ebp
801026b3:	c3                   	ret    
801026b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026b8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801026bb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026bd:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
801026c3:	c3                   	ret    
801026c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026c8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026cb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026ce:	5b                   	pop    %ebx
      c += 'a' - 'A';
801026cf:	83 f9 1a             	cmp    $0x1a,%ecx
801026d2:	0f 42 c2             	cmovb  %edx,%eax
}
801026d5:	5d                   	pop    %ebp
801026d6:	c3                   	ret    
801026d7:	89 f6                	mov    %esi,%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801026e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026e5:	c3                   	ret    
801026e6:	8d 76 00             	lea    0x0(%esi),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <kbdintr>:

void
kbdintr(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026f6:	68 10 26 10 80       	push   $0x80102610
801026fb:	e8 10 e1 ff ff       	call   80100810 <consoleintr>
}
80102700:	83 c4 10             	add    $0x10,%esp
80102703:	c9                   	leave  
80102704:	c3                   	ret    
80102705:	66 90                	xchg   %ax,%ax
80102707:	66 90                	xchg   %ax,%ax
80102709:	66 90                	xchg   %ax,%ax
8010270b:	66 90                	xchg   %ax,%ax
8010270d:	66 90                	xchg   %ax,%ax
8010270f:	90                   	nop

80102710 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102710:	a1 7c 36 11 80       	mov    0x8011367c,%eax
{
80102715:	55                   	push   %ebp
80102716:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102718:	85 c0                	test   %eax,%eax
8010271a:	0f 84 c8 00 00 00    	je     801027e8 <lapicinit+0xd8>
  lapic[index] = value;
80102720:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102727:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010272d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102734:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102737:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010273a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102741:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102744:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102747:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010274e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102751:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102754:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010275b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102761:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102768:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010276b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010276e:	8b 50 30             	mov    0x30(%eax),%edx
80102771:	c1 ea 10             	shr    $0x10,%edx
80102774:	80 fa 03             	cmp    $0x3,%dl
80102777:	77 77                	ja     801027f0 <lapicinit+0xe0>
  lapic[index] = value;
80102779:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102780:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102783:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102786:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010278d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102790:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102793:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010279a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027a7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027aa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027c1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027c4:	8b 50 20             	mov    0x20(%eax),%edx
801027c7:	89 f6                	mov    %esi,%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027d6:	80 e6 10             	and    $0x10,%dh
801027d9:	75 f5                	jne    801027d0 <lapicinit+0xc0>
  lapic[index] = value;
801027db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027e2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027e8:	5d                   	pop    %ebp
801027e9:	c3                   	ret    
801027ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801027f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027f7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fa:	8b 50 20             	mov    0x20(%eax),%edx
801027fd:	e9 77 ff ff ff       	jmp    80102779 <lapicinit+0x69>
80102802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102810 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102810:	8b 15 7c 36 11 80    	mov    0x8011367c,%edx
{
80102816:	55                   	push   %ebp
80102817:	31 c0                	xor    %eax,%eax
80102819:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010281b:	85 d2                	test   %edx,%edx
8010281d:	74 06                	je     80102825 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010281f:	8b 42 20             	mov    0x20(%edx),%eax
80102822:	c1 e8 18             	shr    $0x18,%eax
}
80102825:	5d                   	pop    %ebp
80102826:	c3                   	ret    
80102827:	89 f6                	mov    %esi,%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102830:	a1 7c 36 11 80       	mov    0x8011367c,%eax
{
80102835:	55                   	push   %ebp
80102836:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102838:	85 c0                	test   %eax,%eax
8010283a:	74 0d                	je     80102849 <lapiceoi+0x19>
  lapic[index] = value;
8010283c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102843:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102846:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102849:	5d                   	pop    %ebp
8010284a:	c3                   	ret    
8010284b:	90                   	nop
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
}
80102853:	5d                   	pop    %ebp
80102854:	c3                   	ret    
80102855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102860 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102860:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102861:	b8 0f 00 00 00       	mov    $0xf,%eax
80102866:	ba 70 00 00 00       	mov    $0x70,%edx
8010286b:	89 e5                	mov    %esp,%ebp
8010286d:	53                   	push   %ebx
8010286e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102871:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102874:	ee                   	out    %al,(%dx)
80102875:	b8 0a 00 00 00       	mov    $0xa,%eax
8010287a:	ba 71 00 00 00       	mov    $0x71,%edx
8010287f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102880:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102882:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102885:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010288b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010288d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102890:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102893:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102895:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102898:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010289e:	a1 7c 36 11 80       	mov    0x8011367c,%eax
801028a3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028b3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028c0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028c6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028cc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028cf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028d8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028ea:	5b                   	pop    %ebx
801028eb:	5d                   	pop    %ebp
801028ec:	c3                   	ret    
801028ed:	8d 76 00             	lea    0x0(%esi),%esi

801028f0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028f0:	55                   	push   %ebp
801028f1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028f6:	ba 70 00 00 00       	mov    $0x70,%edx
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	57                   	push   %edi
801028fe:	56                   	push   %esi
801028ff:	53                   	push   %ebx
80102900:	83 ec 4c             	sub    $0x4c,%esp
80102903:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102904:	ba 71 00 00 00       	mov    $0x71,%edx
80102909:	ec                   	in     (%dx),%al
8010290a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010290d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102912:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102915:	8d 76 00             	lea    0x0(%esi),%esi
80102918:	31 c0                	xor    %eax,%eax
8010291a:	89 da                	mov    %ebx,%edx
8010291c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102922:	89 ca                	mov    %ecx,%edx
80102924:	ec                   	in     (%dx),%al
80102925:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102928:	89 da                	mov    %ebx,%edx
8010292a:	b8 02 00 00 00       	mov    $0x2,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	b8 04 00 00 00       	mov    $0x4,%eax
8010293d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293e:	89 ca                	mov    %ecx,%edx
80102940:	ec                   	in     (%dx),%al
80102941:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102944:	89 da                	mov    %ebx,%edx
80102946:	b8 07 00 00 00       	mov    $0x7,%eax
8010294b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294c:	89 ca                	mov    %ecx,%edx
8010294e:	ec                   	in     (%dx),%al
8010294f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102952:	89 da                	mov    %ebx,%edx
80102954:	b8 08 00 00 00       	mov    $0x8,%eax
80102959:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295a:	89 ca                	mov    %ecx,%edx
8010295c:	ec                   	in     (%dx),%al
8010295d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295f:	89 da                	mov    %ebx,%edx
80102961:	b8 09 00 00 00       	mov    $0x9,%eax
80102966:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102967:	89 ca                	mov    %ecx,%edx
80102969:	ec                   	in     (%dx),%al
8010296a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010296c:	89 da                	mov    %ebx,%edx
8010296e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102973:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102974:	89 ca                	mov    %ecx,%edx
80102976:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102977:	84 c0                	test   %al,%al
80102979:	78 9d                	js     80102918 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010297b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010297f:	89 fa                	mov    %edi,%edx
80102981:	0f b6 fa             	movzbl %dl,%edi
80102984:	89 f2                	mov    %esi,%edx
80102986:	0f b6 f2             	movzbl %dl,%esi
80102989:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010298c:	89 da                	mov    %ebx,%edx
8010298e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102991:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102994:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102998:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010299b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010299f:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029a2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029a6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029a9:	31 c0                	xor    %eax,%eax
801029ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ac:	89 ca                	mov    %ecx,%edx
801029ae:	ec                   	in     (%dx),%al
801029af:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b2:	89 da                	mov    %ebx,%edx
801029b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029b7:	b8 02 00 00 00       	mov    $0x2,%eax
801029bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bd:	89 ca                	mov    %ecx,%edx
801029bf:	ec                   	in     (%dx),%al
801029c0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c3:	89 da                	mov    %ebx,%edx
801029c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029c8:	b8 04 00 00 00       	mov    $0x4,%eax
801029cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ce:	89 ca                	mov    %ecx,%edx
801029d0:	ec                   	in     (%dx),%al
801029d1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d4:	89 da                	mov    %ebx,%edx
801029d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029d9:	b8 07 00 00 00       	mov    $0x7,%eax
801029de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029df:	89 ca                	mov    %ecx,%edx
801029e1:	ec                   	in     (%dx),%al
801029e2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e5:	89 da                	mov    %ebx,%edx
801029e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ea:	b8 08 00 00 00       	mov    $0x8,%eax
801029ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f0:	89 ca                	mov    %ecx,%edx
801029f2:	ec                   	in     (%dx),%al
801029f3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f6:	89 da                	mov    %ebx,%edx
801029f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029fb:	b8 09 00 00 00       	mov    $0x9,%eax
80102a00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a01:	89 ca                	mov    %ecx,%edx
80102a03:	ec                   	in     (%dx),%al
80102a04:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a07:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a0d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a10:	6a 18                	push   $0x18
80102a12:	50                   	push   %eax
80102a13:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a16:	50                   	push   %eax
80102a17:	e8 d4 20 00 00       	call   80104af0 <memcmp>
80102a1c:	83 c4 10             	add    $0x10,%esp
80102a1f:	85 c0                	test   %eax,%eax
80102a21:	0f 85 f1 fe ff ff    	jne    80102918 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a27:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a2b:	75 78                	jne    80102aa5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a2d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a30:	89 c2                	mov    %eax,%edx
80102a32:	83 e0 0f             	and    $0xf,%eax
80102a35:	c1 ea 04             	shr    $0x4,%edx
80102a38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a41:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a44:	89 c2                	mov    %eax,%edx
80102a46:	83 e0 0f             	and    $0xf,%eax
80102a49:	c1 ea 04             	shr    $0x4,%edx
80102a4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a52:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a55:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a58:	89 c2                	mov    %eax,%edx
80102a5a:	83 e0 0f             	and    $0xf,%eax
80102a5d:	c1 ea 04             	shr    $0x4,%edx
80102a60:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a63:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a66:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a6c:	89 c2                	mov    %eax,%edx
80102a6e:	83 e0 0f             	and    $0xf,%eax
80102a71:	c1 ea 04             	shr    $0x4,%edx
80102a74:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a77:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a7a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a80:	89 c2                	mov    %eax,%edx
80102a82:	83 e0 0f             	and    $0xf,%eax
80102a85:	c1 ea 04             	shr    $0x4,%edx
80102a88:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a8b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a8e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a91:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a94:	89 c2                	mov    %eax,%edx
80102a96:	83 e0 0f             	and    $0xf,%eax
80102a99:	c1 ea 04             	shr    $0x4,%edx
80102a9c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a9f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aa2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102aa5:	8b 75 08             	mov    0x8(%ebp),%esi
80102aa8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aab:	89 06                	mov    %eax,(%esi)
80102aad:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ab0:	89 46 04             	mov    %eax,0x4(%esi)
80102ab3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ab6:	89 46 08             	mov    %eax,0x8(%esi)
80102ab9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102abc:	89 46 0c             	mov    %eax,0xc(%esi)
80102abf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ac2:	89 46 10             	mov    %eax,0x10(%esi)
80102ac5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ac8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102acb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ad2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ad5:	5b                   	pop    %ebx
80102ad6:	5e                   	pop    %esi
80102ad7:	5f                   	pop    %edi
80102ad8:	5d                   	pop    %ebp
80102ad9:	c3                   	ret    
80102ada:	66 90                	xchg   %ax,%ax
80102adc:	66 90                	xchg   %ax,%ax
80102ade:	66 90                	xchg   %ax,%ax

80102ae0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ae0:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102ae6:	85 c9                	test   %ecx,%ecx
80102ae8:	0f 8e 8a 00 00 00    	jle    80102b78 <install_trans+0x98>
{
80102aee:	55                   	push   %ebp
80102aef:	89 e5                	mov    %esp,%ebp
80102af1:	57                   	push   %edi
80102af2:	56                   	push   %esi
80102af3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102af4:	31 db                	xor    %ebx,%ebx
{
80102af6:	83 ec 0c             	sub    $0xc,%esp
80102af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b00:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b05:	83 ec 08             	sub    $0x8,%esp
80102b08:	01 d8                	add    %ebx,%eax
80102b0a:	83 c0 01             	add    $0x1,%eax
80102b0d:	50                   	push   %eax
80102b0e:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102b14:	e8 b7 d5 ff ff       	call   801000d0 <bread>
80102b19:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1b:	58                   	pop    %eax
80102b1c:	5a                   	pop    %edx
80102b1d:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102b24:	ff 35 c4 36 11 80    	pushl  0x801136c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b2a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b2d:	e8 9e d5 ff ff       	call   801000d0 <bread>
80102b32:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b34:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b37:	83 c4 0c             	add    $0xc,%esp
80102b3a:	68 00 02 00 00       	push   $0x200
80102b3f:	50                   	push   %eax
80102b40:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b43:	50                   	push   %eax
80102b44:	e8 07 20 00 00       	call   80104b50 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b49:	89 34 24             	mov    %esi,(%esp)
80102b4c:	e8 4f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b51:	89 3c 24             	mov    %edi,(%esp)
80102b54:	e8 87 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b59:	89 34 24             	mov    %esi,(%esp)
80102b5c:	e8 7f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b61:	83 c4 10             	add    $0x10,%esp
80102b64:	39 1d c8 36 11 80    	cmp    %ebx,0x801136c8
80102b6a:	7f 94                	jg     80102b00 <install_trans+0x20>
  }
}
80102b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b6f:	5b                   	pop    %ebx
80102b70:	5e                   	pop    %esi
80102b71:	5f                   	pop    %edi
80102b72:	5d                   	pop    %ebp
80102b73:	c3                   	ret    
80102b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b78:	f3 c3                	repz ret 
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	56                   	push   %esi
80102b84:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102b85:	83 ec 08             	sub    $0x8,%esp
80102b88:	ff 35 b4 36 11 80    	pushl  0x801136b4
80102b8e:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102b94:	e8 37 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b99:	8b 1d c8 36 11 80    	mov    0x801136c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b9f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ba2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ba4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ba6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ba9:	7e 16                	jle    80102bc1 <write_head+0x41>
80102bab:	c1 e3 02             	shl    $0x2,%ebx
80102bae:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102bb0:	8b 8a cc 36 11 80    	mov    -0x7feec934(%edx),%ecx
80102bb6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102bba:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bbd:	39 da                	cmp    %ebx,%edx
80102bbf:	75 ef                	jne    80102bb0 <write_head+0x30>
  }
  bwrite(buf);
80102bc1:	83 ec 0c             	sub    $0xc,%esp
80102bc4:	56                   	push   %esi
80102bc5:	e8 d6 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bca:	89 34 24             	mov    %esi,(%esp)
80102bcd:	e8 0e d6 ff ff       	call   801001e0 <brelse>
}
80102bd2:	83 c4 10             	add    $0x10,%esp
80102bd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102bd8:	5b                   	pop    %ebx
80102bd9:	5e                   	pop    %esi
80102bda:	5d                   	pop    %ebp
80102bdb:	c3                   	ret    
80102bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102be0 <initlog>:
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	53                   	push   %ebx
80102be4:	83 ec 2c             	sub    $0x2c,%esp
80102be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bea:	68 60 7b 10 80       	push   $0x80107b60
80102bef:	68 80 36 11 80       	push   $0x80113680
80102bf4:	e8 57 1c 00 00       	call   80104850 <initlock>
  readsb(dev, &sb);
80102bf9:	58                   	pop    %eax
80102bfa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bfd:	5a                   	pop    %edx
80102bfe:	50                   	push   %eax
80102bff:	53                   	push   %ebx
80102c00:	e8 9b e8 ff ff       	call   801014a0 <readsb>
  log.size = sb.nlog;
80102c05:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c0b:	59                   	pop    %ecx
  log.dev = dev;
80102c0c:	89 1d c4 36 11 80    	mov    %ebx,0x801136c4
  log.size = sb.nlog;
80102c12:	89 15 b8 36 11 80    	mov    %edx,0x801136b8
  log.start = sb.logstart;
80102c18:	a3 b4 36 11 80       	mov    %eax,0x801136b4
  struct buf *buf = bread(log.dev, log.start);
80102c1d:	5a                   	pop    %edx
80102c1e:	50                   	push   %eax
80102c1f:	53                   	push   %ebx
80102c20:	e8 ab d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c25:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c28:	83 c4 10             	add    $0x10,%esp
80102c2b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c2d:	89 1d c8 36 11 80    	mov    %ebx,0x801136c8
  for (i = 0; i < log.lh.n; i++) {
80102c33:	7e 1c                	jle    80102c51 <initlog+0x71>
80102c35:	c1 e3 02             	shl    $0x2,%ebx
80102c38:	31 d2                	xor    %edx,%edx
80102c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c44:	83 c2 04             	add    $0x4,%edx
80102c47:	89 8a c8 36 11 80    	mov    %ecx,-0x7feec938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c4d:	39 d3                	cmp    %edx,%ebx
80102c4f:	75 ef                	jne    80102c40 <initlog+0x60>
  brelse(buf);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	50                   	push   %eax
80102c55:	e8 86 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c5a:	e8 81 fe ff ff       	call   80102ae0 <install_trans>
  log.lh.n = 0;
80102c5f:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
80102c66:	00 00 00 
  write_head(); // clear the log
80102c69:	e8 12 ff ff ff       	call   80102b80 <write_head>
}
80102c6e:	83 c4 10             	add    $0x10,%esp
80102c71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c74:	c9                   	leave  
80102c75:	c3                   	ret    
80102c76:	8d 76 00             	lea    0x0(%esi),%esi
80102c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c86:	68 80 36 11 80       	push   $0x80113680
80102c8b:	e8 00 1d 00 00       	call   80104990 <acquire>
80102c90:	83 c4 10             	add    $0x10,%esp
80102c93:	eb 18                	jmp    80102cad <begin_op+0x2d>
80102c95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c98:	83 ec 08             	sub    $0x8,%esp
80102c9b:	68 80 36 11 80       	push   $0x80113680
80102ca0:	68 80 36 11 80       	push   $0x80113680
80102ca5:	e8 46 13 00 00       	call   80103ff0 <sleep>
80102caa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102cad:	a1 c0 36 11 80       	mov    0x801136c0,%eax
80102cb2:	85 c0                	test   %eax,%eax
80102cb4:	75 e2                	jne    80102c98 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cb6:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102cbb:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
80102cc1:	83 c0 01             	add    $0x1,%eax
80102cc4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cc7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cca:	83 fa 1e             	cmp    $0x1e,%edx
80102ccd:	7f c9                	jg     80102c98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102ccf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cd2:	a3 bc 36 11 80       	mov    %eax,0x801136bc
      release(&log.lock);
80102cd7:	68 80 36 11 80       	push   $0x80113680
80102cdc:	e8 6f 1d 00 00       	call   80104a50 <release>
      break;
    }
  }
}
80102ce1:	83 c4 10             	add    $0x10,%esp
80102ce4:	c9                   	leave  
80102ce5:	c3                   	ret    
80102ce6:	8d 76 00             	lea    0x0(%esi),%esi
80102ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cf0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cf0:	55                   	push   %ebp
80102cf1:	89 e5                	mov    %esp,%ebp
80102cf3:	57                   	push   %edi
80102cf4:	56                   	push   %esi
80102cf5:	53                   	push   %ebx
80102cf6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cf9:	68 80 36 11 80       	push   $0x80113680
80102cfe:	e8 8d 1c 00 00       	call   80104990 <acquire>
  log.outstanding -= 1;
80102d03:	a1 bc 36 11 80       	mov    0x801136bc,%eax
  if(log.committing)
80102d08:	8b 35 c0 36 11 80    	mov    0x801136c0,%esi
80102d0e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d11:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d14:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102d16:	89 1d bc 36 11 80    	mov    %ebx,0x801136bc
  if(log.committing)
80102d1c:	0f 85 1a 01 00 00    	jne    80102e3c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d22:	85 db                	test   %ebx,%ebx
80102d24:	0f 85 ee 00 00 00    	jne    80102e18 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d2a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d2d:	c7 05 c0 36 11 80 01 	movl   $0x1,0x801136c0
80102d34:	00 00 00 
  release(&log.lock);
80102d37:	68 80 36 11 80       	push   $0x80113680
80102d3c:	e8 0f 1d 00 00       	call   80104a50 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d41:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102d47:	83 c4 10             	add    $0x10,%esp
80102d4a:	85 c9                	test   %ecx,%ecx
80102d4c:	0f 8e 85 00 00 00    	jle    80102dd7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d52:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102d57:	83 ec 08             	sub    $0x8,%esp
80102d5a:	01 d8                	add    %ebx,%eax
80102d5c:	83 c0 01             	add    $0x1,%eax
80102d5f:	50                   	push   %eax
80102d60:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102d66:	e8 65 d3 ff ff       	call   801000d0 <bread>
80102d6b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d6d:	58                   	pop    %eax
80102d6e:	5a                   	pop    %edx
80102d6f:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102d76:	ff 35 c4 36 11 80    	pushl  0x801136c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d7f:	e8 4c d3 ff ff       	call   801000d0 <bread>
80102d84:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d86:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d89:	83 c4 0c             	add    $0xc,%esp
80102d8c:	68 00 02 00 00       	push   $0x200
80102d91:	50                   	push   %eax
80102d92:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d95:	50                   	push   %eax
80102d96:	e8 b5 1d 00 00       	call   80104b50 <memmove>
    bwrite(to);  // write the log
80102d9b:	89 34 24             	mov    %esi,(%esp)
80102d9e:	e8 fd d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102da3:	89 3c 24             	mov    %edi,(%esp)
80102da6:	e8 35 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102dab:	89 34 24             	mov    %esi,(%esp)
80102dae:	e8 2d d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102db3:	83 c4 10             	add    $0x10,%esp
80102db6:	3b 1d c8 36 11 80    	cmp    0x801136c8,%ebx
80102dbc:	7c 94                	jl     80102d52 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dbe:	e8 bd fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dc3:	e8 18 fd ff ff       	call   80102ae0 <install_trans>
    log.lh.n = 0;
80102dc8:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
80102dcf:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dd2:	e8 a9 fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102dd7:	83 ec 0c             	sub    $0xc,%esp
80102dda:	68 80 36 11 80       	push   $0x80113680
80102ddf:	e8 ac 1b 00 00       	call   80104990 <acquire>
    wakeup(&log);
80102de4:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
    log.committing = 0;
80102deb:	c7 05 c0 36 11 80 00 	movl   $0x0,0x801136c0
80102df2:	00 00 00 
    wakeup(&log);
80102df5:	e8 b6 12 00 00       	call   801040b0 <wakeup>
    release(&log.lock);
80102dfa:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102e01:	e8 4a 1c 00 00       	call   80104a50 <release>
80102e06:	83 c4 10             	add    $0x10,%esp
}
80102e09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e0c:	5b                   	pop    %ebx
80102e0d:	5e                   	pop    %esi
80102e0e:	5f                   	pop    %edi
80102e0f:	5d                   	pop    %ebp
80102e10:	c3                   	ret    
80102e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102e18:	83 ec 0c             	sub    $0xc,%esp
80102e1b:	68 80 36 11 80       	push   $0x80113680
80102e20:	e8 8b 12 00 00       	call   801040b0 <wakeup>
  release(&log.lock);
80102e25:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102e2c:	e8 1f 1c 00 00       	call   80104a50 <release>
80102e31:	83 c4 10             	add    $0x10,%esp
}
80102e34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e37:	5b                   	pop    %ebx
80102e38:	5e                   	pop    %esi
80102e39:	5f                   	pop    %edi
80102e3a:	5d                   	pop    %ebp
80102e3b:	c3                   	ret    
    panic("log.committing");
80102e3c:	83 ec 0c             	sub    $0xc,%esp
80102e3f:	68 64 7b 10 80       	push   $0x80107b64
80102e44:	e8 47 d5 ff ff       	call   80100390 <panic>
80102e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e57:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
{
80102e5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e60:	83 fa 1d             	cmp    $0x1d,%edx
80102e63:	0f 8f 9d 00 00 00    	jg     80102f06 <log_write+0xb6>
80102e69:	a1 b8 36 11 80       	mov    0x801136b8,%eax
80102e6e:	83 e8 01             	sub    $0x1,%eax
80102e71:	39 c2                	cmp    %eax,%edx
80102e73:	0f 8d 8d 00 00 00    	jge    80102f06 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e79:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102e7e:	85 c0                	test   %eax,%eax
80102e80:	0f 8e 8d 00 00 00    	jle    80102f13 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e86:	83 ec 0c             	sub    $0xc,%esp
80102e89:	68 80 36 11 80       	push   $0x80113680
80102e8e:	e8 fd 1a 00 00       	call   80104990 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e93:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102e99:	83 c4 10             	add    $0x10,%esp
80102e9c:	83 f9 00             	cmp    $0x0,%ecx
80102e9f:	7e 57                	jle    80102ef8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102ea4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea6:	3b 15 cc 36 11 80    	cmp    0x801136cc,%edx
80102eac:	75 0b                	jne    80102eb9 <log_write+0x69>
80102eae:	eb 38                	jmp    80102ee8 <log_write+0x98>
80102eb0:	39 14 85 cc 36 11 80 	cmp    %edx,-0x7feec934(,%eax,4)
80102eb7:	74 2f                	je     80102ee8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102eb9:	83 c0 01             	add    $0x1,%eax
80102ebc:	39 c1                	cmp    %eax,%ecx
80102ebe:	75 f0                	jne    80102eb0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ec7:	83 c0 01             	add    $0x1,%eax
80102eca:	a3 c8 36 11 80       	mov    %eax,0x801136c8
  b->flags |= B_DIRTY; // prevent eviction
80102ecf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ed2:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
80102ed9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102edc:	c9                   	leave  
  release(&log.lock);
80102edd:	e9 6e 1b 00 00       	jmp    80104a50 <release>
80102ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ee8:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
80102eef:	eb de                	jmp    80102ecf <log_write+0x7f>
80102ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef8:	8b 43 08             	mov    0x8(%ebx),%eax
80102efb:	a3 cc 36 11 80       	mov    %eax,0x801136cc
  if (i == log.lh.n)
80102f00:	75 cd                	jne    80102ecf <log_write+0x7f>
80102f02:	31 c0                	xor    %eax,%eax
80102f04:	eb c1                	jmp    80102ec7 <log_write+0x77>
    panic("too big a transaction");
80102f06:	83 ec 0c             	sub    $0xc,%esp
80102f09:	68 73 7b 10 80       	push   $0x80107b73
80102f0e:	e8 7d d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f13:	83 ec 0c             	sub    $0xc,%esp
80102f16:	68 89 7b 10 80       	push   $0x80107b89
80102f1b:	e8 70 d4 ff ff       	call   80100390 <panic>

80102f20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f27:	e8 14 0a 00 00       	call   80103940 <cpuid>
80102f2c:	89 c3                	mov    %eax,%ebx
80102f2e:	e8 0d 0a 00 00       	call   80103940 <cpuid>
80102f33:	83 ec 04             	sub    $0x4,%esp
80102f36:	53                   	push   %ebx
80102f37:	50                   	push   %eax
80102f38:	68 a4 7b 10 80       	push   $0x80107ba4
80102f3d:	e8 1e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f42:	e8 99 2e 00 00       	call   80105de0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f47:	e8 74 09 00 00       	call   801038c0 <mycpu>
80102f4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f5a:	e8 61 0d 00 00       	call   80103cc0 <scheduler>
80102f5f:	90                   	nop

80102f60 <mpenter>:
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f66:	e8 35 40 00 00       	call   80106fa0 <switchkvm>
  seginit();
80102f6b:	e8 a0 3f 00 00       	call   80106f10 <seginit>
  lapicinit();
80102f70:	e8 9b f7 ff ff       	call   80102710 <lapicinit>
  mpmain();
80102f75:	e8 a6 ff ff ff       	call   80102f20 <mpmain>
80102f7a:	66 90                	xchg   %ax,%ax
80102f7c:	66 90                	xchg   %ax,%ax
80102f7e:	66 90                	xchg   %ax,%ax

80102f80 <main>:
{
80102f80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f84:	83 e4 f0             	and    $0xfffffff0,%esp
80102f87:	ff 71 fc             	pushl  -0x4(%ecx)
80102f8a:	55                   	push   %ebp
80102f8b:	89 e5                	mov    %esp,%ebp
80102f8d:	53                   	push   %ebx
80102f8e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 00 40 80       	push   $0x80400000
80102f97:	68 c8 f1 11 80       	push   $0x8011f1c8
80102f9c:	e8 2f f5 ff ff       	call   801024d0 <kinit1>
  kvmalloc();      // kernel page table
80102fa1:	e8 ca 44 00 00       	call   80107470 <kvmalloc>
  mpinit();        // detect other processors
80102fa6:	e8 75 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102fab:	e8 60 f7 ff ff       	call   80102710 <lapicinit>
  seginit();       // segment descriptors
80102fb0:	e8 5b 3f 00 00       	call   80106f10 <seginit>
  picinit();       // disable pic
80102fb5:	e8 46 03 00 00       	call   80103300 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 41 f3 ff ff       	call   80102300 <ioapicinit>
  consoleinit();   // console hardware
80102fbf:	e8 fc d9 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102fc4:	e8 17 32 00 00       	call   801061e0 <uartinit>
  pinit();         // process table
80102fc9:	e8 d2 08 00 00       	call   801038a0 <pinit>
  tvinit();        // trap vectors
80102fce:	e8 8d 2d 00 00       	call   80105d60 <tvinit>
  binit();         // buffer cache
80102fd3:	e8 68 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fd8:	e8 53 de ff ff       	call   80100e30 <fileinit>
  ideinit();       // disk 
80102fdd:	e8 fe f0 ff ff       	call   801020e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe2:	83 c4 0c             	add    $0xc,%esp
80102fe5:	68 8a 00 00 00       	push   $0x8a
80102fea:	68 8c b4 10 80       	push   $0x8010b48c
80102fef:	68 00 70 00 80       	push   $0x80007000
80102ff4:	e8 57 1b 00 00       	call   80104b50 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ff9:	69 05 20 3d 11 80 b4 	imul   $0xb4,0x80113d20,%eax
80103000:	00 00 00 
80103003:	83 c4 10             	add    $0x10,%esp
80103006:	05 80 37 11 80       	add    $0x80113780,%eax
8010300b:	3d 80 37 11 80       	cmp    $0x80113780,%eax
80103010:	76 71                	jbe    80103083 <main+0x103>
80103012:	bb 80 37 11 80       	mov    $0x80113780,%ebx
80103017:	89 f6                	mov    %esi,%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103020:	e8 9b 08 00 00       	call   801038c0 <mycpu>
80103025:	39 d8                	cmp    %ebx,%eax
80103027:	74 41                	je     8010306a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103029:	e8 72 f5 ff ff       	call   801025a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010302e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103033:	c7 05 f8 6f 00 80 60 	movl   $0x80102f60,0x80006ff8
8010303a:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010303d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103044:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103047:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010304c:	0f b6 03             	movzbl (%ebx),%eax
8010304f:	83 ec 08             	sub    $0x8,%esp
80103052:	68 00 70 00 00       	push   $0x7000
80103057:	50                   	push   %eax
80103058:	e8 03 f8 ff ff       	call   80102860 <lapicstartap>
8010305d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103060:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103066:	85 c0                	test   %eax,%eax
80103068:	74 f6                	je     80103060 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010306a:	69 05 20 3d 11 80 b4 	imul   $0xb4,0x80113d20,%eax
80103071:	00 00 00 
80103074:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
8010307a:	05 80 37 11 80       	add    $0x80113780,%eax
8010307f:	39 c3                	cmp    %eax,%ebx
80103081:	72 9d                	jb     80103020 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103083:	83 ec 08             	sub    $0x8,%esp
80103086:	68 00 00 00 8e       	push   $0x8e000000
8010308b:	68 00 00 40 80       	push   $0x80400000
80103090:	e8 ab f4 ff ff       	call   80102540 <kinit2>
  userinit();      // first user process
80103095:	e8 26 09 00 00       	call   801039c0 <userinit>
  mpmain();        // finish this processor's setup
8010309a:	e8 81 fe ff ff       	call   80102f20 <mpmain>
8010309f:	90                   	nop

801030a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030ab:	53                   	push   %ebx
  e = addr+len;
801030ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030b2:	39 de                	cmp    %ebx,%esi
801030b4:	72 10                	jb     801030c6 <mpsearch1+0x26>
801030b6:	eb 50                	jmp    80103108 <mpsearch1+0x68>
801030b8:	90                   	nop
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030c0:	39 fb                	cmp    %edi,%ebx
801030c2:	89 fe                	mov    %edi,%esi
801030c4:	76 42                	jbe    80103108 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c6:	83 ec 04             	sub    $0x4,%esp
801030c9:	8d 7e 10             	lea    0x10(%esi),%edi
801030cc:	6a 04                	push   $0x4
801030ce:	68 b8 7b 10 80       	push   $0x80107bb8
801030d3:	56                   	push   %esi
801030d4:	e8 17 1a 00 00       	call   80104af0 <memcmp>
801030d9:	83 c4 10             	add    $0x10,%esp
801030dc:	85 c0                	test   %eax,%eax
801030de:	75 e0                	jne    801030c0 <mpsearch1+0x20>
801030e0:	89 f1                	mov    %esi,%ecx
801030e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030e8:	0f b6 11             	movzbl (%ecx),%edx
801030eb:	83 c1 01             	add    $0x1,%ecx
801030ee:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801030f0:	39 f9                	cmp    %edi,%ecx
801030f2:	75 f4                	jne    801030e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030f4:	84 c0                	test   %al,%al
801030f6:	75 c8                	jne    801030c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030fb:	89 f0                	mov    %esi,%eax
801030fd:	5b                   	pop    %ebx
801030fe:	5e                   	pop    %esi
801030ff:	5f                   	pop    %edi
80103100:	5d                   	pop    %ebp
80103101:	c3                   	ret    
80103102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010310b:	31 f6                	xor    %esi,%esi
}
8010310d:	89 f0                	mov    %esi,%eax
8010310f:	5b                   	pop    %ebx
80103110:	5e                   	pop    %esi
80103111:	5f                   	pop    %edi
80103112:	5d                   	pop    %ebp
80103113:	c3                   	ret    
80103114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010311a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103120 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
80103125:	53                   	push   %ebx
80103126:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103129:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103130:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103137:	c1 e0 08             	shl    $0x8,%eax
8010313a:	09 d0                	or     %edx,%eax
8010313c:	c1 e0 04             	shl    $0x4,%eax
8010313f:	85 c0                	test   %eax,%eax
80103141:	75 1b                	jne    8010315e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103143:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010314a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103151:	c1 e0 08             	shl    $0x8,%eax
80103154:	09 d0                	or     %edx,%eax
80103156:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103159:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010315e:	ba 00 04 00 00       	mov    $0x400,%edx
80103163:	e8 38 ff ff ff       	call   801030a0 <mpsearch1>
80103168:	85 c0                	test   %eax,%eax
8010316a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010316d:	0f 84 3d 01 00 00    	je     801032b0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103173:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103176:	8b 58 04             	mov    0x4(%eax),%ebx
80103179:	85 db                	test   %ebx,%ebx
8010317b:	0f 84 4f 01 00 00    	je     801032d0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103181:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103187:	83 ec 04             	sub    $0x4,%esp
8010318a:	6a 04                	push   $0x4
8010318c:	68 d5 7b 10 80       	push   $0x80107bd5
80103191:	56                   	push   %esi
80103192:	e8 59 19 00 00       	call   80104af0 <memcmp>
80103197:	83 c4 10             	add    $0x10,%esp
8010319a:	85 c0                	test   %eax,%eax
8010319c:	0f 85 2e 01 00 00    	jne    801032d0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801031a2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031a9:	3c 01                	cmp    $0x1,%al
801031ab:	0f 95 c2             	setne  %dl
801031ae:	3c 04                	cmp    $0x4,%al
801031b0:	0f 95 c0             	setne  %al
801031b3:	20 c2                	and    %al,%dl
801031b5:	0f 85 15 01 00 00    	jne    801032d0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801031bb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801031c2:	66 85 ff             	test   %di,%di
801031c5:	74 1a                	je     801031e1 <mpinit+0xc1>
801031c7:	89 f0                	mov    %esi,%eax
801031c9:	01 f7                	add    %esi,%edi
  sum = 0;
801031cb:	31 d2                	xor    %edx,%edx
801031cd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801031d0:	0f b6 08             	movzbl (%eax),%ecx
801031d3:	83 c0 01             	add    $0x1,%eax
801031d6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031d8:	39 c7                	cmp    %eax,%edi
801031da:	75 f4                	jne    801031d0 <mpinit+0xb0>
801031dc:	84 d2                	test   %dl,%dl
801031de:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031e1:	85 f6                	test   %esi,%esi
801031e3:	0f 84 e7 00 00 00    	je     801032d0 <mpinit+0x1b0>
801031e9:	84 d2                	test   %dl,%dl
801031eb:	0f 85 df 00 00 00    	jne    801032d0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031f1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031f7:	a3 7c 36 11 80       	mov    %eax,0x8011367c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031fc:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103203:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103209:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010320e:	01 d6                	add    %edx,%esi
80103210:	39 c6                	cmp    %eax,%esi
80103212:	76 23                	jbe    80103237 <mpinit+0x117>
    switch(*p){
80103214:	0f b6 10             	movzbl (%eax),%edx
80103217:	80 fa 04             	cmp    $0x4,%dl
8010321a:	0f 87 ca 00 00 00    	ja     801032ea <mpinit+0x1ca>
80103220:	ff 24 95 fc 7b 10 80 	jmp    *-0x7fef8404(,%edx,4)
80103227:	89 f6                	mov    %esi,%esi
80103229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103230:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103233:	39 c6                	cmp    %eax,%esi
80103235:	77 dd                	ja     80103214 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103237:	85 db                	test   %ebx,%ebx
80103239:	0f 84 9e 00 00 00    	je     801032dd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010323f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103242:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103246:	74 15                	je     8010325d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103248:	b8 70 00 00 00       	mov    $0x70,%eax
8010324d:	ba 22 00 00 00       	mov    $0x22,%edx
80103252:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103253:	ba 23 00 00 00       	mov    $0x23,%edx
80103258:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103259:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010325c:	ee                   	out    %al,(%dx)
  }
}
8010325d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103260:	5b                   	pop    %ebx
80103261:	5e                   	pop    %esi
80103262:	5f                   	pop    %edi
80103263:	5d                   	pop    %ebp
80103264:	c3                   	ret    
80103265:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103268:	8b 0d 20 3d 11 80    	mov    0x80113d20,%ecx
8010326e:	83 f9 07             	cmp    $0x7,%ecx
80103271:	7f 19                	jg     8010328c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103273:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103277:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
        ncpu++;
8010327d:	83 c1 01             	add    $0x1,%ecx
80103280:	89 0d 20 3d 11 80    	mov    %ecx,0x80113d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103286:	88 97 80 37 11 80    	mov    %dl,-0x7feec880(%edi)
      p += sizeof(struct mpproc);
8010328c:	83 c0 14             	add    $0x14,%eax
      continue;
8010328f:	e9 7c ff ff ff       	jmp    80103210 <mpinit+0xf0>
80103294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103298:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010329c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010329f:	88 15 60 37 11 80    	mov    %dl,0x80113760
      continue;
801032a5:	e9 66 ff ff ff       	jmp    80103210 <mpinit+0xf0>
801032aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801032b0:	ba 00 00 01 00       	mov    $0x10000,%edx
801032b5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032ba:	e8 e1 fd ff ff       	call   801030a0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032bf:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801032c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032c4:	0f 85 a9 fe ff ff    	jne    80103173 <mpinit+0x53>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801032d0:	83 ec 0c             	sub    $0xc,%esp
801032d3:	68 bd 7b 10 80       	push   $0x80107bbd
801032d8:	e8 b3 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801032dd:	83 ec 0c             	sub    $0xc,%esp
801032e0:	68 dc 7b 10 80       	push   $0x80107bdc
801032e5:	e8 a6 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
801032ea:	31 db                	xor    %ebx,%ebx
801032ec:	e9 26 ff ff ff       	jmp    80103217 <mpinit+0xf7>
801032f1:	66 90                	xchg   %ax,%ax
801032f3:	66 90                	xchg   %ax,%ax
801032f5:	66 90                	xchg   %ax,%ax
801032f7:	66 90                	xchg   %ax,%ax
801032f9:	66 90                	xchg   %ax,%ax
801032fb:	66 90                	xchg   %ax,%ax
801032fd:	66 90                	xchg   %ax,%ax
801032ff:	90                   	nop

80103300 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103300:	55                   	push   %ebp
80103301:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103306:	ba 21 00 00 00       	mov    $0x21,%edx
8010330b:	89 e5                	mov    %esp,%ebp
8010330d:	ee                   	out    %al,(%dx)
8010330e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103313:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103314:	5d                   	pop    %ebp
80103315:	c3                   	ret    
80103316:	66 90                	xchg   %ax,%ax
80103318:	66 90                	xchg   %ax,%ax
8010331a:	66 90                	xchg   %ax,%ax
8010331c:	66 90                	xchg   %ax,%ax
8010331e:	66 90                	xchg   %ax,%ax

80103320 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 0c             	sub    $0xc,%esp
80103329:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010332c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010332f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103335:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010333b:	e8 10 db ff ff       	call   80100e50 <filealloc>
80103340:	85 c0                	test   %eax,%eax
80103342:	89 03                	mov    %eax,(%ebx)
80103344:	74 22                	je     80103368 <pipealloc+0x48>
80103346:	e8 05 db ff ff       	call   80100e50 <filealloc>
8010334b:	85 c0                	test   %eax,%eax
8010334d:	89 06                	mov    %eax,(%esi)
8010334f:	74 3f                	je     80103390 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103351:	e8 4a f2 ff ff       	call   801025a0 <kalloc>
80103356:	85 c0                	test   %eax,%eax
80103358:	89 c7                	mov    %eax,%edi
8010335a:	75 54                	jne    801033b0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010335c:	8b 03                	mov    (%ebx),%eax
8010335e:	85 c0                	test   %eax,%eax
80103360:	75 34                	jne    80103396 <pipealloc+0x76>
80103362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103368:	8b 06                	mov    (%esi),%eax
8010336a:	85 c0                	test   %eax,%eax
8010336c:	74 0c                	je     8010337a <pipealloc+0x5a>
    fileclose(*f1);
8010336e:	83 ec 0c             	sub    $0xc,%esp
80103371:	50                   	push   %eax
80103372:	e8 99 db ff ff       	call   80100f10 <fileclose>
80103377:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010337a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010337d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103382:	5b                   	pop    %ebx
80103383:	5e                   	pop    %esi
80103384:	5f                   	pop    %edi
80103385:	5d                   	pop    %ebp
80103386:	c3                   	ret    
80103387:	89 f6                	mov    %esi,%esi
80103389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103390:	8b 03                	mov    (%ebx),%eax
80103392:	85 c0                	test   %eax,%eax
80103394:	74 e4                	je     8010337a <pipealloc+0x5a>
    fileclose(*f0);
80103396:	83 ec 0c             	sub    $0xc,%esp
80103399:	50                   	push   %eax
8010339a:	e8 71 db ff ff       	call   80100f10 <fileclose>
  if(*f1)
8010339f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801033a1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033a4:	85 c0                	test   %eax,%eax
801033a6:	75 c6                	jne    8010336e <pipealloc+0x4e>
801033a8:	eb d0                	jmp    8010337a <pipealloc+0x5a>
801033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801033b0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801033b3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033ba:	00 00 00 
  p->writeopen = 1;
801033bd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033c4:	00 00 00 
  p->nwrite = 0;
801033c7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033ce:	00 00 00 
  p->nread = 0;
801033d1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033d8:	00 00 00 
  initlock(&p->lock, "pipe");
801033db:	68 10 7c 10 80       	push   $0x80107c10
801033e0:	50                   	push   %eax
801033e1:	e8 6a 14 00 00       	call   80104850 <initlock>
  (*f0)->type = FD_PIPE;
801033e6:	8b 03                	mov    (%ebx),%eax
  return 0;
801033e8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033eb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033f1:	8b 03                	mov    (%ebx),%eax
801033f3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033f7:	8b 03                	mov    (%ebx),%eax
801033f9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033fd:	8b 03                	mov    (%ebx),%eax
801033ff:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103402:	8b 06                	mov    (%esi),%eax
80103404:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010340a:	8b 06                	mov    (%esi),%eax
8010340c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103410:	8b 06                	mov    (%esi),%eax
80103412:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103416:	8b 06                	mov    (%esi),%eax
80103418:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010341b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010341e:	31 c0                	xor    %eax,%eax
}
80103420:	5b                   	pop    %ebx
80103421:	5e                   	pop    %esi
80103422:	5f                   	pop    %edi
80103423:	5d                   	pop    %ebp
80103424:	c3                   	ret    
80103425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103430 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	56                   	push   %esi
80103434:	53                   	push   %ebx
80103435:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103438:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010343b:	83 ec 0c             	sub    $0xc,%esp
8010343e:	53                   	push   %ebx
8010343f:	e8 4c 15 00 00       	call   80104990 <acquire>
  if(writable){
80103444:	83 c4 10             	add    $0x10,%esp
80103447:	85 f6                	test   %esi,%esi
80103449:	74 45                	je     80103490 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010344b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103451:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103454:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010345b:	00 00 00 
    wakeup(&p->nread);
8010345e:	50                   	push   %eax
8010345f:	e8 4c 0c 00 00       	call   801040b0 <wakeup>
80103464:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103467:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010346d:	85 d2                	test   %edx,%edx
8010346f:	75 0a                	jne    8010347b <pipeclose+0x4b>
80103471:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103477:	85 c0                	test   %eax,%eax
80103479:	74 35                	je     801034b0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010347b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010347e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103481:	5b                   	pop    %ebx
80103482:	5e                   	pop    %esi
80103483:	5d                   	pop    %ebp
    release(&p->lock);
80103484:	e9 c7 15 00 00       	jmp    80104a50 <release>
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103490:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103496:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103499:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034a0:	00 00 00 
    wakeup(&p->nwrite);
801034a3:	50                   	push   %eax
801034a4:	e8 07 0c 00 00       	call   801040b0 <wakeup>
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	eb b9                	jmp    80103467 <pipeclose+0x37>
801034ae:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 97 15 00 00       	call   80104a50 <release>
    kfree((char*)p);
801034b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034bc:	83 c4 10             	add    $0x10,%esp
}
801034bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034c2:	5b                   	pop    %ebx
801034c3:	5e                   	pop    %esi
801034c4:	5d                   	pop    %ebp
    kfree((char*)p);
801034c5:	e9 26 ef ff ff       	jmp    801023f0 <kfree>
801034ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	57                   	push   %edi
801034d4:	56                   	push   %esi
801034d5:	53                   	push   %ebx
801034d6:	83 ec 28             	sub    $0x28,%esp
801034d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034dc:	53                   	push   %ebx
801034dd:	e8 ae 14 00 00       	call   80104990 <acquire>
  for(i = 0; i < n; i++){
801034e2:	8b 45 10             	mov    0x10(%ebp),%eax
801034e5:	83 c4 10             	add    $0x10,%esp
801034e8:	85 c0                	test   %eax,%eax
801034ea:	0f 8e c9 00 00 00    	jle    801035b9 <pipewrite+0xe9>
801034f0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034f3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034ff:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103502:	03 4d 10             	add    0x10(%ebp),%ecx
80103505:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103508:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010350e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103514:	39 d0                	cmp    %edx,%eax
80103516:	75 71                	jne    80103589 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103518:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010351e:	85 c0                	test   %eax,%eax
80103520:	74 4e                	je     80103570 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103522:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103528:	eb 3a                	jmp    80103564 <pipewrite+0x94>
8010352a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103530:	83 ec 0c             	sub    $0xc,%esp
80103533:	57                   	push   %edi
80103534:	e8 77 0b 00 00       	call   801040b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103539:	5a                   	pop    %edx
8010353a:	59                   	pop    %ecx
8010353b:	53                   	push   %ebx
8010353c:	56                   	push   %esi
8010353d:	e8 ae 0a 00 00       	call   80103ff0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103542:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103548:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010354e:	83 c4 10             	add    $0x10,%esp
80103551:	05 00 02 00 00       	add    $0x200,%eax
80103556:	39 c2                	cmp    %eax,%edx
80103558:	75 36                	jne    80103590 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010355a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103560:	85 c0                	test   %eax,%eax
80103562:	74 0c                	je     80103570 <pipewrite+0xa0>
80103564:	e8 f7 03 00 00       	call   80103960 <myproc>
80103569:	8b 40 14             	mov    0x14(%eax),%eax
8010356c:	85 c0                	test   %eax,%eax
8010356e:	74 c0                	je     80103530 <pipewrite+0x60>
        release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 d7 14 00 00       	call   80104a50 <release>
        return -1;
80103579:	83 c4 10             	add    $0x10,%esp
8010357c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103581:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103584:	5b                   	pop    %ebx
80103585:	5e                   	pop    %esi
80103586:	5f                   	pop    %edi
80103587:	5d                   	pop    %ebp
80103588:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103589:	89 c2                	mov    %eax,%edx
8010358b:	90                   	nop
8010358c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103590:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103593:	8d 42 01             	lea    0x1(%edx),%eax
80103596:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010359c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801035a2:	83 c6 01             	add    $0x1,%esi
801035a5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801035a9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801035ac:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801035af:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801035b3:	0f 85 4f ff ff ff    	jne    80103508 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035b9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035bf:	83 ec 0c             	sub    $0xc,%esp
801035c2:	50                   	push   %eax
801035c3:	e8 e8 0a 00 00       	call   801040b0 <wakeup>
  release(&p->lock);
801035c8:	89 1c 24             	mov    %ebx,(%esp)
801035cb:	e8 80 14 00 00       	call   80104a50 <release>
  return n;
801035d0:	83 c4 10             	add    $0x10,%esp
801035d3:	8b 45 10             	mov    0x10(%ebp),%eax
801035d6:	eb a9                	jmp    80103581 <pipewrite+0xb1>
801035d8:	90                   	nop
801035d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	57                   	push   %edi
801035e4:	56                   	push   %esi
801035e5:	53                   	push   %ebx
801035e6:	83 ec 18             	sub    $0x18,%esp
801035e9:	8b 75 08             	mov    0x8(%ebp),%esi
801035ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035ef:	56                   	push   %esi
801035f0:	e8 9b 13 00 00       	call   80104990 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035f5:	83 c4 10             	add    $0x10,%esp
801035f8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035fe:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103604:	75 6a                	jne    80103670 <piperead+0x90>
80103606:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010360c:	85 db                	test   %ebx,%ebx
8010360e:	0f 84 c4 00 00 00    	je     801036d8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103614:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010361a:	eb 2d                	jmp    80103649 <piperead+0x69>
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103620:	83 ec 08             	sub    $0x8,%esp
80103623:	56                   	push   %esi
80103624:	53                   	push   %ebx
80103625:	e8 c6 09 00 00       	call   80103ff0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010362a:	83 c4 10             	add    $0x10,%esp
8010362d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103633:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103639:	75 35                	jne    80103670 <piperead+0x90>
8010363b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103641:	85 d2                	test   %edx,%edx
80103643:	0f 84 8f 00 00 00    	je     801036d8 <piperead+0xf8>
    if(myproc()->killed){
80103649:	e8 12 03 00 00       	call   80103960 <myproc>
8010364e:	8b 48 14             	mov    0x14(%eax),%ecx
80103651:	85 c9                	test   %ecx,%ecx
80103653:	74 cb                	je     80103620 <piperead+0x40>
      release(&p->lock);
80103655:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103658:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010365d:	56                   	push   %esi
8010365e:	e8 ed 13 00 00       	call   80104a50 <release>
      return -1;
80103663:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103666:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103669:	89 d8                	mov    %ebx,%eax
8010366b:	5b                   	pop    %ebx
8010366c:	5e                   	pop    %esi
8010366d:	5f                   	pop    %edi
8010366e:	5d                   	pop    %ebp
8010366f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103670:	8b 45 10             	mov    0x10(%ebp),%eax
80103673:	85 c0                	test   %eax,%eax
80103675:	7e 61                	jle    801036d8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103677:	31 db                	xor    %ebx,%ebx
80103679:	eb 13                	jmp    8010368e <piperead+0xae>
8010367b:	90                   	nop
8010367c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103680:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103686:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010368c:	74 1f                	je     801036ad <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010368e:	8d 41 01             	lea    0x1(%ecx),%eax
80103691:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103697:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010369d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801036a2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036a5:	83 c3 01             	add    $0x1,%ebx
801036a8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801036ab:	75 d3                	jne    80103680 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801036ad:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801036b3:	83 ec 0c             	sub    $0xc,%esp
801036b6:	50                   	push   %eax
801036b7:	e8 f4 09 00 00       	call   801040b0 <wakeup>
  release(&p->lock);
801036bc:	89 34 24             	mov    %esi,(%esp)
801036bf:	e8 8c 13 00 00       	call   80104a50 <release>
  return i;
801036c4:	83 c4 10             	add    $0x10,%esp
}
801036c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ca:	89 d8                	mov    %ebx,%eax
801036cc:	5b                   	pop    %ebx
801036cd:	5e                   	pop    %esi
801036ce:	5f                   	pop    %edi
801036cf:	5d                   	pop    %ebp
801036d0:	c3                   	ret    
801036d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d8:	31 db                	xor    %ebx,%ebx
801036da:	eb d1                	jmp    801036ad <piperead+0xcd>
801036dc:	66 90                	xchg   %ax,%ax
801036de:	66 90                	xchg   %ax,%ax

801036e0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	56                   	push   %esi
801036e4:	53                   	push   %ebx
  //cprintf("entered wakeup1: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801036e5:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
801036ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == UNUSED){
801036f0:	8b 53 08             	mov    0x8(%ebx),%edx
801036f3:	85 d2                	test   %edx,%edx
801036f5:	74 39                	je     80103730 <wakeup1+0x50>
      continue;
    }
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801036f7:	8b 73 6c             	mov    0x6c(%ebx),%esi
801036fa:	89 f2                	mov    %esi,%edx
801036fc:	eb 0f                	jmp    8010370d <wakeup1+0x2d>
801036fe:	66 90                	xchg   %ax,%ax
80103700:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
80103706:	83 c2 24             	add    $0x24,%edx
80103709:	39 ca                	cmp    %ecx,%edx
8010370b:	73 23                	jae    80103730 <wakeup1+0x50>
      if(t->state == SLEEPING && t->chan == chan){
8010370d:	83 7a 08 01          	cmpl   $0x1,0x8(%edx)
80103711:	75 ed                	jne    80103700 <wakeup1+0x20>
80103713:	39 42 1c             	cmp    %eax,0x1c(%edx)
80103716:	75 e8                	jne    80103700 <wakeup1+0x20>
        //p->state = RUNNABLE;  
        t->state = RUNNABLE;
80103718:	c7 42 08 02 00 00 00 	movl   $0x2,0x8(%edx)
8010371f:	8b 73 6c             	mov    0x6c(%ebx),%esi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103722:	83 c2 24             	add    $0x24,%edx
80103725:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
8010372b:	39 ca                	cmp    %ecx,%edx
8010372d:	72 de                	jb     8010370d <wakeup1+0x2d>
8010372f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103730:	83 c3 70             	add    $0x70,%ebx
80103733:	81 fb 74 59 11 80    	cmp    $0x80115974,%ebx
80103739:	72 b5                	jb     801036f0 <wakeup1+0x10>
      }
    }
  }
}
8010373b:	5b                   	pop    %ebx
8010373c:	5e                   	pop    %esi
8010373d:	5d                   	pop    %ebp
8010373e:	c3                   	ret    
8010373f:	90                   	nop

80103740 <allocproc>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	56                   	push   %esi
80103744:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103745:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
  acquire(&ptable.lock);
8010374a:	83 ec 0c             	sub    $0xc,%esp
8010374d:	68 40 3d 11 80       	push   $0x80113d40
80103752:	e8 39 12 00 00       	call   80104990 <acquire>
80103757:	83 c4 10             	add    $0x10,%esp
  int i = 0;
8010375a:	31 c0                	xor    %eax,%eax
8010375c:	eb 14                	jmp    80103772 <allocproc+0x32>
8010375e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103760:	83 c3 70             	add    $0x70,%ebx
      i++;
80103763:	83 c0 01             	add    $0x1,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103766:	81 fb 74 59 11 80    	cmp    $0x80115974,%ebx
8010376c:	0f 83 be 00 00 00    	jae    80103830 <allocproc+0xf0>
    if(p->state == UNUSED)
80103772:	8b 53 08             	mov    0x8(%ebx),%edx
80103775:	85 d2                	test   %edx,%edx
80103777:	75 e7                	jne    80103760 <allocproc+0x20>
  p->pid = nextpid++;
80103779:	8b 15 08 b0 10 80    	mov    0x8010b008,%edx
  p->threads = ptable.ttable[i].threads;
8010377f:	8d 04 c0             	lea    (%eax,%eax,8),%eax
  p->state = EMBRYO;
80103782:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  p->threads = ptable.ttable[i].threads;
80103789:	c1 e0 06             	shl    $0x6,%eax
  p->pid = nextpid++;
8010378c:	8d 4a 01             	lea    0x1(%edx),%ecx
  p->threads = ptable.ttable[i].threads;
8010378f:	05 74 59 11 80       	add    $0x80115974,%eax
  p->pid = nextpid++;
80103794:	89 53 0c             	mov    %edx,0xc(%ebx)
  p->threads = ptable.ttable[i].threads;
80103797:	89 43 6c             	mov    %eax,0x6c(%ebx)
  p->pid = nextpid++;
8010379a:	89 0d 08 b0 10 80    	mov    %ecx,0x8010b008
    tTemp->state = UNINIT;
801037a0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  for(tTemp = p->threads; tTemp < &p->threads[NTHREAD]; tTemp++){
801037a7:	8b 73 6c             	mov    0x6c(%ebx),%esi
801037aa:	83 c0 24             	add    $0x24,%eax
801037ad:	8d 96 40 02 00 00    	lea    0x240(%esi),%edx
801037b3:	39 d0                	cmp    %edx,%eax
801037b5:	72 e9                	jb     801037a0 <allocproc+0x60>
  t->tid = nexttid++;
801037b7:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  release(&ptable.lock);
801037bc:	83 ec 0c             	sub    $0xc,%esp
  t->tproc = p;
801037bf:	89 5e 10             	mov    %ebx,0x10(%esi)
  t->exitRequest = 0;
801037c2:	c7 46 20 00 00 00 00 	movl   $0x0,0x20(%esi)
  t->tid = nexttid++;
801037c9:	8d 50 01             	lea    0x1(%eax),%edx
801037cc:	89 46 0c             	mov    %eax,0xc(%esi)
  release(&ptable.lock);
801037cf:	68 40 3d 11 80       	push   $0x80113d40
  t->tid = nexttid++;
801037d4:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801037da:	e8 71 12 00 00       	call   80104a50 <release>
  if((t->kstack = kalloc()) == 0){
801037df:	e8 bc ed ff ff       	call   801025a0 <kalloc>
801037e4:	83 c4 10             	add    $0x10,%esp
801037e7:	85 c0                	test   %eax,%eax
801037e9:	89 06                	mov    %eax,(%esi)
801037eb:	74 5e                	je     8010384b <allocproc+0x10b>
  sp -= sizeof *t->tf;
801037ed:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(t->context, 0, sizeof *t->context);
801037f3:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *t->context;
801037f6:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *t->tf;
801037fb:	89 56 14             	mov    %edx,0x14(%esi)
  *(uint*)sp = (uint)trapret;
801037fe:	c7 40 14 4f 5d 10 80 	movl   $0x80105d4f,0x14(%eax)
  t->context = (struct context*)sp;
80103805:	89 46 18             	mov    %eax,0x18(%esi)
  memset(t->context, 0, sizeof *t->context);
80103808:	6a 14                	push   $0x14
8010380a:	6a 00                	push   $0x0
8010380c:	50                   	push   %eax
8010380d:	e8 8e 12 00 00       	call   80104aa0 <memset>
  t->context->eip = (uint)forkret;
80103812:	8b 46 18             	mov    0x18(%esi),%eax
  return p;
80103815:	83 c4 10             	add    $0x10,%esp
  t->context->eip = (uint)forkret;
80103818:	c7 40 10 50 38 10 80 	movl   $0x80103850,0x10(%eax)
}
8010381f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103822:	89 d8                	mov    %ebx,%eax
80103824:	5b                   	pop    %ebx
80103825:	5e                   	pop    %esi
80103826:	5d                   	pop    %ebp
80103827:	c3                   	ret    
80103828:	90                   	nop
80103829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103830:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103833:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103835:	68 40 3d 11 80       	push   $0x80113d40
8010383a:	e8 11 12 00 00       	call   80104a50 <release>
  return 0;
8010383f:	83 c4 10             	add    $0x10,%esp
}
80103842:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103845:	89 d8                	mov    %ebx,%eax
80103847:	5b                   	pop    %ebx
80103848:	5e                   	pop    %esi
80103849:	5d                   	pop    %ebp
8010384a:	c3                   	ret    
    return 0;
8010384b:	31 db                	xor    %ebx,%ebx
8010384d:	eb d0                	jmp    8010381f <allocproc+0xdf>
8010384f:	90                   	nop

80103850 <forkret>:
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103856:	68 40 3d 11 80       	push   $0x80113d40
8010385b:	e8 f0 11 00 00       	call   80104a50 <release>
  if (first) {
80103860:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103865:	83 c4 10             	add    $0x10,%esp
80103868:	85 c0                	test   %eax,%eax
8010386a:	75 04                	jne    80103870 <forkret+0x20>
}
8010386c:	c9                   	leave  
8010386d:	c3                   	ret    
8010386e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103870:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103873:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010387a:	00 00 00 
    iinit(ROOTDEV);
8010387d:	6a 01                	push   $0x1
8010387f:	e8 dc dc ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
80103884:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010388b:	e8 50 f3 ff ff       	call   80102be0 <initlog>
80103890:	83 c4 10             	add    $0x10,%esp
}
80103893:	c9                   	leave  
80103894:	c3                   	ret    
80103895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038a0 <pinit>:
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038a6:	68 15 7c 10 80       	push   $0x80107c15
801038ab:	68 40 3d 11 80       	push   $0x80113d40
801038b0:	e8 9b 0f 00 00       	call   80104850 <initlock>
}
801038b5:	83 c4 10             	add    $0x10,%esp
801038b8:	c9                   	leave  
801038b9:	c3                   	ret    
801038ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038c0 <mycpu>:
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	56                   	push   %esi
801038c4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038c5:	9c                   	pushf  
801038c6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038c7:	f6 c4 02             	test   $0x2,%ah
801038ca:	75 5e                	jne    8010392a <mycpu+0x6a>
  apicid = lapicid();
801038cc:	e8 3f ef ff ff       	call   80102810 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038d1:	8b 35 20 3d 11 80    	mov    0x80113d20,%esi
801038d7:	85 f6                	test   %esi,%esi
801038d9:	7e 42                	jle    8010391d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038db:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
801038e2:	39 d0                	cmp    %edx,%eax
801038e4:	74 30                	je     80103916 <mycpu+0x56>
801038e6:	b9 34 38 11 80       	mov    $0x80113834,%ecx
  for (i = 0; i < ncpu; ++i) {
801038eb:	31 d2                	xor    %edx,%edx
801038ed:	8d 76 00             	lea    0x0(%esi),%esi
801038f0:	83 c2 01             	add    $0x1,%edx
801038f3:	39 f2                	cmp    %esi,%edx
801038f5:	74 26                	je     8010391d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038f7:	0f b6 19             	movzbl (%ecx),%ebx
801038fa:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
80103900:	39 c3                	cmp    %eax,%ebx
80103902:	75 ec                	jne    801038f0 <mycpu+0x30>
80103904:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
8010390a:	05 80 37 11 80       	add    $0x80113780,%eax
}
8010390f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103912:	5b                   	pop    %ebx
80103913:	5e                   	pop    %esi
80103914:	5d                   	pop    %ebp
80103915:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103916:	b8 80 37 11 80       	mov    $0x80113780,%eax
      return &cpus[i];
8010391b:	eb f2                	jmp    8010390f <mycpu+0x4f>
  panic("unknown apicid\n");
8010391d:	83 ec 0c             	sub    $0xc,%esp
80103920:	68 1c 7c 10 80       	push   $0x80107c1c
80103925:	e8 66 ca ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010392a:	83 ec 0c             	sub    $0xc,%esp
8010392d:	68 30 7d 10 80       	push   $0x80107d30
80103932:	e8 59 ca ff ff       	call   80100390 <panic>
80103937:	89 f6                	mov    %esi,%esi
80103939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103940 <cpuid>:
cpuid() {
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103946:	e8 75 ff ff ff       	call   801038c0 <mycpu>
8010394b:	2d 80 37 11 80       	sub    $0x80113780,%eax
}
80103950:	c9                   	leave  
  return mycpu()-cpus;
80103951:	c1 f8 02             	sar    $0x2,%eax
80103954:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
8010395a:	c3                   	ret    
8010395b:	90                   	nop
8010395c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103960 <myproc>:
myproc(void) {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103967:	e8 54 0f 00 00       	call   801048c0 <pushcli>
  c = mycpu();
8010396c:	e8 4f ff ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103971:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103977:	e8 84 0f 00 00       	call   80104900 <popcli>
}
8010397c:	83 c4 04             	add    $0x4,%esp
8010397f:	89 d8                	mov    %ebx,%eax
80103981:	5b                   	pop    %ebx
80103982:	5d                   	pop    %ebp
80103983:	c3                   	ret    
80103984:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010398a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103990 <mythread>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
80103994:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103997:	e8 24 0f 00 00       	call   801048c0 <pushcli>
  c = mycpu();
8010399c:	e8 1f ff ff ff       	call   801038c0 <mycpu>
  t = c->thread;
801039a1:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
801039a7:	e8 54 0f 00 00       	call   80104900 <popcli>
}
801039ac:	83 c4 04             	add    $0x4,%esp
801039af:	89 d8                	mov    %ebx,%eax
801039b1:	5b                   	pop    %ebx
801039b2:	5d                   	pop    %ebp
801039b3:	c3                   	ret    
801039b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039c0 <userinit>:
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	56                   	push   %esi
801039c4:	53                   	push   %ebx
  p = allocproc();
801039c5:	e8 76 fd ff ff       	call   80103740 <allocproc>
801039ca:	89 c6                	mov    %eax,%esi
  initproc = p;
801039cc:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
801039d1:	e8 1a 3a 00 00       	call   801073f0 <setupkvm>
801039d6:	85 c0                	test   %eax,%eax
801039d8:	89 46 04             	mov    %eax,0x4(%esi)
801039db:	0f 84 c9 00 00 00    	je     80103aaa <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039e1:	83 ec 04             	sub    $0x4,%esp
801039e4:	68 2c 00 00 00       	push   $0x2c
801039e9:	68 60 b4 10 80       	push   $0x8010b460
801039ee:	50                   	push   %eax
801039ef:	e8 dc 36 00 00       	call   801070d0 <inituvm>
  t = p->threads;
801039f4:	8b 5e 6c             	mov    0x6c(%esi),%ebx
  memset(t->tf, 0, sizeof(*t->tf));
801039f7:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039fa:	c7 06 00 10 00 00    	movl   $0x1000,(%esi)
  memset(t->tf, 0, sizeof(*t->tf));
80103a00:	6a 4c                	push   $0x4c
80103a02:	6a 00                	push   $0x0
80103a04:	ff 73 14             	pushl  0x14(%ebx)
80103a07:	e8 94 10 00 00       	call   80104aa0 <memset>
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a0c:	8b 43 14             	mov    0x14(%ebx),%eax
80103a0f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a14:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a19:	83 c4 0c             	add    $0xc,%esp
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a1c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a20:	8b 43 14             	mov    0x14(%ebx),%eax
80103a23:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  t->tf->es = t->tf->ds;
80103a27:	8b 43 14             	mov    0x14(%ebx),%eax
80103a2a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a2e:	66 89 50 28          	mov    %dx,0x28(%eax)
  t->tf->ss = t->tf->ds;
80103a32:	8b 43 14             	mov    0x14(%ebx),%eax
80103a35:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a39:	66 89 50 48          	mov    %dx,0x48(%eax)
  t->tf->eflags = FL_IF;
80103a3d:	8b 43 14             	mov    0x14(%ebx),%eax
80103a40:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  t->tf->esp = PGSIZE;
80103a47:	8b 43 14             	mov    0x14(%ebx),%eax
80103a4a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  t->tf->eip = 0;  // beginning of initcode.S
80103a51:	8b 43 14             	mov    0x14(%ebx),%eax
80103a54:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a5b:	8d 46 5c             	lea    0x5c(%esi),%eax
80103a5e:	6a 10                	push   $0x10
80103a60:	68 45 7c 10 80       	push   $0x80107c45
80103a65:	50                   	push   %eax
80103a66:	e8 15 12 00 00       	call   80104c80 <safestrcpy>
  p->cwd = namei("/");
80103a6b:	c7 04 24 4e 7c 10 80 	movl   $0x80107c4e,(%esp)
80103a72:	e8 49 e5 ff ff       	call   80101fc0 <namei>
80103a77:	89 46 58             	mov    %eax,0x58(%esi)
  acquire(&ptable.lock);
80103a7a:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103a81:	e8 0a 0f 00 00       	call   80104990 <acquire>
  p->state = USED;
80103a86:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
  t->state = RUNNABLE;
80103a8d:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  release(&ptable.lock);
80103a94:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103a9b:	e8 b0 0f 00 00       	call   80104a50 <release>
}
80103aa0:	83 c4 10             	add    $0x10,%esp
80103aa3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa6:	5b                   	pop    %ebx
80103aa7:	5e                   	pop    %esi
80103aa8:	5d                   	pop    %ebp
80103aa9:	c3                   	ret    
    panic("userinit: out of memory?");
80103aaa:	83 ec 0c             	sub    $0xc,%esp
80103aad:	68 2c 7c 10 80       	push   $0x80107c2c
80103ab2:	e8 d9 c8 ff ff       	call   80100390 <panic>
80103ab7:	89 f6                	mov    %esi,%esi
80103ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ac0 <growproc>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	56                   	push   %esi
80103ac4:	53                   	push   %ebx
80103ac5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ac8:	e8 f3 0d 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103acd:	e8 ee fd ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103ad2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ad8:	e8 23 0e 00 00       	call   80104900 <popcli>
  acquire(&ptable.lock);
80103add:	83 ec 0c             	sub    $0xc,%esp
80103ae0:	68 40 3d 11 80       	push   $0x80113d40
80103ae5:	e8 a6 0e 00 00       	call   80104990 <acquire>
  if(n > 0){
80103aea:	83 c4 10             	add    $0x10,%esp
80103aed:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103af0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103af2:	7f 2c                	jg     80103b20 <growproc+0x60>
  } else if(n < 0){
80103af4:	75 5a                	jne    80103b50 <growproc+0x90>
  switchuvm(curproc);
80103af6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103af9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103afb:	53                   	push   %ebx
80103afc:	e8 bf 34 00 00       	call   80106fc0 <switchuvm>
  release(&ptable.lock);
80103b01:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103b08:	e8 43 0f 00 00       	call   80104a50 <release>
  return 0;
80103b0d:	83 c4 10             	add    $0x10,%esp
80103b10:	31 c0                	xor    %eax,%eax
}
80103b12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b15:	5b                   	pop    %ebx
80103b16:	5e                   	pop    %esi
80103b17:	5d                   	pop    %ebp
80103b18:	c3                   	ret    
80103b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0){
80103b20:	83 ec 04             	sub    $0x4,%esp
80103b23:	01 c6                	add    %eax,%esi
80103b25:	56                   	push   %esi
80103b26:	50                   	push   %eax
80103b27:	ff 73 04             	pushl  0x4(%ebx)
80103b2a:	e8 e1 36 00 00       	call   80107210 <allocuvm>
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	85 c0                	test   %eax,%eax
80103b34:	75 c0                	jne    80103af6 <growproc+0x36>
      release(&ptable.lock);
80103b36:	83 ec 0c             	sub    $0xc,%esp
80103b39:	68 40 3d 11 80       	push   $0x80113d40
80103b3e:	e8 0d 0f 00 00       	call   80104a50 <release>
      return -1;
80103b43:	83 c4 10             	add    $0x10,%esp
80103b46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b4b:	eb c5                	jmp    80103b12 <growproc+0x52>
80103b4d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0){
80103b50:	83 ec 04             	sub    $0x4,%esp
80103b53:	01 c6                	add    %eax,%esi
80103b55:	56                   	push   %esi
80103b56:	50                   	push   %eax
80103b57:	ff 73 04             	pushl  0x4(%ebx)
80103b5a:	e8 e1 37 00 00       	call   80107340 <deallocuvm>
80103b5f:	83 c4 10             	add    $0x10,%esp
80103b62:	85 c0                	test   %eax,%eax
80103b64:	75 90                	jne    80103af6 <growproc+0x36>
80103b66:	eb ce                	jmp    80103b36 <growproc+0x76>
80103b68:	90                   	nop
80103b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b70 <fork>:
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	57                   	push   %edi
80103b74:	56                   	push   %esi
80103b75:	53                   	push   %ebx
80103b76:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b79:	e8 42 0d 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103b7e:	e8 3d fd ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103b83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b89:	e8 72 0d 00 00       	call   80104900 <popcli>
  pushcli();
80103b8e:	e8 2d 0d 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103b93:	e8 28 fd ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103b98:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
  popcli();
80103b9e:	e8 5d 0d 00 00       	call   80104900 <popcli>
  if((np = allocproc()) == 0){
80103ba3:	e8 98 fb ff ff       	call   80103740 <allocproc>
80103ba8:	85 c0                	test   %eax,%eax
80103baa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103bad:	89 c7                	mov    %eax,%edi
80103baf:	0f 84 cf 00 00 00    	je     80103c84 <fork+0x114>
  nt = np->threads;
80103bb5:	8b 48 6c             	mov    0x6c(%eax),%ecx
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bb8:	83 ec 08             	sub    $0x8,%esp
  nt->tproc = np;
80103bbb:	89 41 10             	mov    %eax,0x10(%ecx)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bbe:	ff 33                	pushl  (%ebx)
80103bc0:	ff 73 04             	pushl  0x4(%ebx)
  nt = np->threads;
80103bc3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bc6:	e8 f5 38 00 00       	call   801074c0 <copyuvm>
80103bcb:	83 c4 10             	add    $0x10,%esp
80103bce:	85 c0                	test   %eax,%eax
80103bd0:	89 47 04             	mov    %eax,0x4(%edi)
80103bd3:	0f 84 b2 00 00 00    	je     80103c8b <fork+0x11b>
  np->sz = curproc->sz;
80103bd9:	8b 03                	mov    (%ebx),%eax
80103bdb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *nt->tf = *curthread->tf;
80103bde:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103be3:	89 02                	mov    %eax,(%edx)
  *nt->tf = *curthread->tf;
80103be5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  np->parent = curproc;
80103be8:	89 5a 10             	mov    %ebx,0x10(%edx)
  *nt->tf = *curthread->tf;
80103beb:	8b 76 14             	mov    0x14(%esi),%esi
80103bee:	8b 78 14             	mov    0x14(%eax),%edi
80103bf1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103bf3:	31 f6                	xor    %esi,%esi
80103bf5:	89 d7                	mov    %edx,%edi
  nt->tf->eax = 0;
80103bf7:	8b 40 14             	mov    0x14(%eax),%eax
80103bfa:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103c08:	8b 44 b3 18          	mov    0x18(%ebx,%esi,4),%eax
80103c0c:	85 c0                	test   %eax,%eax
80103c0e:	74 10                	je     80103c20 <fork+0xb0>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c10:	83 ec 0c             	sub    $0xc,%esp
80103c13:	50                   	push   %eax
80103c14:	e8 a7 d2 ff ff       	call   80100ec0 <filedup>
80103c19:	83 c4 10             	add    $0x10,%esp
80103c1c:	89 44 b7 18          	mov    %eax,0x18(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c20:	83 c6 01             	add    $0x1,%esi
80103c23:	83 fe 10             	cmp    $0x10,%esi
80103c26:	75 e0                	jne    80103c08 <fork+0x98>
  np->cwd = idup(curproc->cwd);
80103c28:	83 ec 0c             	sub    $0xc,%esp
80103c2b:	ff 73 58             	pushl  0x58(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c2e:	83 c3 5c             	add    $0x5c,%ebx
  np->cwd = idup(curproc->cwd);
80103c31:	e8 fa da ff ff       	call   80101730 <idup>
80103c36:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c39:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c3c:	89 47 58             	mov    %eax,0x58(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c3f:	8d 47 5c             	lea    0x5c(%edi),%eax
80103c42:	6a 10                	push   $0x10
80103c44:	53                   	push   %ebx
80103c45:	50                   	push   %eax
80103c46:	e8 35 10 00 00       	call   80104c80 <safestrcpy>
  pid = np->pid;
80103c4b:	8b 5f 0c             	mov    0xc(%edi),%ebx
  acquire(&ptable.lock);
80103c4e:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103c55:	e8 36 0d 00 00       	call   80104990 <acquire>
  nt->state = RUNNABLE;
80103c5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  np->state = USED;
80103c5d:	c7 47 08 02 00 00 00 	movl   $0x2,0x8(%edi)
  nt->state = RUNNABLE;
80103c64:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)
  release(&ptable.lock);
80103c6b:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103c72:	e8 d9 0d 00 00       	call   80104a50 <release>
  return pid;
80103c77:	83 c4 10             	add    $0x10,%esp
}
80103c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c7d:	89 d8                	mov    %ebx,%eax
80103c7f:	5b                   	pop    %ebx
80103c80:	5e                   	pop    %esi
80103c81:	5f                   	pop    %edi
80103c82:	5d                   	pop    %ebp
80103c83:	c3                   	ret    
    return -1;
80103c84:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c89:	eb ef                	jmp    80103c7a <fork+0x10a>
    kfree(nt->kstack);
80103c8b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103c8e:	83 ec 0c             	sub    $0xc,%esp
80103c91:	ff 33                	pushl  (%ebx)
80103c93:	e8 58 e7 ff ff       	call   801023f0 <kfree>
    np->state = UNUSED;
80103c98:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    nt->kstack = 0;
80103c9b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    return -1;
80103ca1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103ca4:	c7 41 08 00 00 00 00 	movl   $0x0,0x8(%ecx)
    nt->state = UNINIT;
80103cab:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103cb2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103cb7:	eb c1                	jmp    80103c7a <fork+0x10a>
80103cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103cc0 <scheduler>:
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	57                   	push   %edi
80103cc4:	56                   	push   %esi
80103cc5:	53                   	push   %ebx
80103cc6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103cc9:	e8 f2 fb ff ff       	call   801038c0 <mycpu>
  c->proc = 0;
80103cce:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cd5:	00 00 00 
  c->thread = 0;
80103cd8:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103cdf:	00 00 00 
  struct cpu *c = mycpu();
80103ce2:	89 c7                	mov    %eax,%edi
80103ce4:	8d 40 04             	lea    0x4(%eax),%eax
80103ce7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80103cea:	fb                   	sti    
    acquire(&ptable.lock);
80103ceb:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cee:	be 74 3d 11 80       	mov    $0x80113d74,%esi
    acquire(&ptable.lock);
80103cf3:	68 40 3d 11 80       	push   $0x80113d40
80103cf8:	e8 93 0c 00 00       	call   80104990 <acquire>
80103cfd:	83 c4 10             	add    $0x10,%esp
80103d00:	eb 11                	jmp    80103d13 <scheduler+0x53>
80103d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d08:	83 c6 70             	add    $0x70,%esi
80103d0b:	81 fe 74 59 11 80    	cmp    $0x80115974,%esi
80103d11:	73 73                	jae    80103d86 <scheduler+0xc6>
      if(p->state != USED){
80103d13:	83 7e 08 02          	cmpl   $0x2,0x8(%esi)
80103d17:	75 ef                	jne    80103d08 <scheduler+0x48>
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103d19:	8b 4e 6c             	mov    0x6c(%esi),%ecx
80103d1c:	89 cb                	mov    %ecx,%ebx
80103d1e:	66 90                	xchg   %ax,%ax
        if(t->state != RUNNABLE){
80103d20:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
80103d24:	75 48                	jne    80103d6e <scheduler+0xae>
        switchuvm(p);
80103d26:	83 ec 0c             	sub    $0xc,%esp
        c->proc = p;
80103d29:	89 b7 ac 00 00 00    	mov    %esi,0xac(%edi)
        c->thread = t;
80103d2f:	89 9f b0 00 00 00    	mov    %ebx,0xb0(%edi)
        switchuvm(p);
80103d35:	56                   	push   %esi
80103d36:	e8 85 32 00 00       	call   80106fc0 <switchuvm>
        t->state = RUNNING;
80103d3b:	c7 43 08 03 00 00 00 	movl   $0x3,0x8(%ebx)
        swtch(&(c->scheduler), t->context);
80103d42:	58                   	pop    %eax
80103d43:	5a                   	pop    %edx
80103d44:	ff 73 18             	pushl  0x18(%ebx)
80103d47:	ff 75 e4             	pushl  -0x1c(%ebp)
80103d4a:	e8 8c 0f 00 00       	call   80104cdb <swtch>
        switchkvm();
80103d4f:	e8 4c 32 00 00       	call   80106fa0 <switchkvm>
        c->proc = 0;
80103d54:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103d5b:	00 00 00 
        c->thread = 0;
80103d5e:	c7 87 b0 00 00 00 00 	movl   $0x0,0xb0(%edi)
80103d65:	00 00 00 
80103d68:	83 c4 10             	add    $0x10,%esp
80103d6b:	8b 4e 6c             	mov    0x6c(%esi),%ecx
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103d6e:	8d 91 40 02 00 00    	lea    0x240(%ecx),%edx
80103d74:	83 c3 24             	add    $0x24,%ebx
80103d77:	39 d3                	cmp    %edx,%ebx
80103d79:	72 a5                	jb     80103d20 <scheduler+0x60>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d7b:	83 c6 70             	add    $0x70,%esi
80103d7e:	81 fe 74 59 11 80    	cmp    $0x80115974,%esi
80103d84:	72 8d                	jb     80103d13 <scheduler+0x53>
    release(&ptable.lock);
80103d86:	83 ec 0c             	sub    $0xc,%esp
80103d89:	68 40 3d 11 80       	push   $0x80113d40
80103d8e:	e8 bd 0c 00 00       	call   80104a50 <release>
    sti();
80103d93:	83 c4 10             	add    $0x10,%esp
80103d96:	e9 4f ff ff ff       	jmp    80103cea <scheduler+0x2a>
80103d9b:	90                   	nop
80103d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103da0 <sched>:
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	56                   	push   %esi
80103da4:	53                   	push   %ebx
  pushcli();
80103da5:	e8 16 0b 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103daa:	e8 11 fb ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103daf:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103db5:	e8 46 0b 00 00       	call   80104900 <popcli>
  if(!holding(&ptable.lock))
80103dba:	83 ec 0c             	sub    $0xc,%esp
80103dbd:	68 40 3d 11 80       	push   $0x80113d40
80103dc2:	e8 99 0b 00 00       	call   80104960 <holding>
80103dc7:	83 c4 10             	add    $0x10,%esp
80103dca:	85 c0                	test   %eax,%eax
80103dcc:	74 4f                	je     80103e1d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dce:	e8 ed fa ff ff       	call   801038c0 <mycpu>
80103dd3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dda:	75 68                	jne    80103e44 <sched+0xa4>
  if(t->state == RUNNING)
80103ddc:	83 7b 08 03          	cmpl   $0x3,0x8(%ebx)
80103de0:	74 55                	je     80103e37 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103de2:	9c                   	pushf  
80103de3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103de4:	f6 c4 02             	test   $0x2,%ah
80103de7:	75 41                	jne    80103e2a <sched+0x8a>
  intena = mycpu()->intena;
80103de9:	e8 d2 fa ff ff       	call   801038c0 <mycpu>
  swtch(&t->context, mycpu()->scheduler);
80103dee:	83 c3 18             	add    $0x18,%ebx
  intena = mycpu()->intena;
80103df1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&t->context, mycpu()->scheduler);
80103df7:	e8 c4 fa ff ff       	call   801038c0 <mycpu>
80103dfc:	83 ec 08             	sub    $0x8,%esp
80103dff:	ff 70 04             	pushl  0x4(%eax)
80103e02:	53                   	push   %ebx
80103e03:	e8 d3 0e 00 00       	call   80104cdb <swtch>
  mycpu()->intena = intena;
80103e08:	e8 b3 fa ff ff       	call   801038c0 <mycpu>
}
80103e0d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e10:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e19:	5b                   	pop    %ebx
80103e1a:	5e                   	pop    %esi
80103e1b:	5d                   	pop    %ebp
80103e1c:	c3                   	ret    
    panic("sched ptable.lock");
80103e1d:	83 ec 0c             	sub    $0xc,%esp
80103e20:	68 50 7c 10 80       	push   $0x80107c50
80103e25:	e8 66 c5 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	68 7c 7c 10 80       	push   $0x80107c7c
80103e32:	e8 59 c5 ff ff       	call   80100390 <panic>
    panic("sched running");
80103e37:	83 ec 0c             	sub    $0xc,%esp
80103e3a:	68 6e 7c 10 80       	push   $0x80107c6e
80103e3f:	e8 4c c5 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103e44:	83 ec 0c             	sub    $0xc,%esp
80103e47:	68 62 7c 10 80       	push   $0x80107c62
80103e4c:	e8 3f c5 ff ff       	call   80100390 <panic>
80103e51:	eb 0d                	jmp    80103e60 <exit>
80103e53:	90                   	nop
80103e54:	90                   	nop
80103e55:	90                   	nop
80103e56:	90                   	nop
80103e57:	90                   	nop
80103e58:	90                   	nop
80103e59:	90                   	nop
80103e5a:	90                   	nop
80103e5b:	90                   	nop
80103e5c:	90                   	nop
80103e5d:	90                   	nop
80103e5e:	90                   	nop
80103e5f:	90                   	nop

80103e60 <exit>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e69:	e8 52 0a 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103e6e:	e8 4d fa ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103e73:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e79:	e8 82 0a 00 00       	call   80104900 <popcli>
  pushcli();
80103e7e:	e8 3d 0a 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103e83:	e8 38 fa ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103e88:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80103e8e:	8d 7e 18             	lea    0x18(%esi),%edi
80103e91:	8d 5e 58             	lea    0x58(%esi),%ebx
80103e94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80103e97:	e8 64 0a 00 00       	call   80104900 <popcli>
  if(curproc == initproc)
80103e9c:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103ea2:	0f 84 e1 00 00 00    	je     80103f89 <exit+0x129>
80103ea8:	90                   	nop
80103ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80103eb0:	8b 17                	mov    (%edi),%edx
80103eb2:	85 d2                	test   %edx,%edx
80103eb4:	74 12                	je     80103ec8 <exit+0x68>
      fileclose(curproc->ofile[fd]);
80103eb6:	83 ec 0c             	sub    $0xc,%esp
80103eb9:	52                   	push   %edx
80103eba:	e8 51 d0 ff ff       	call   80100f10 <fileclose>
      curproc->ofile[fd] = 0;
80103ebf:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103ec5:	83 c4 10             	add    $0x10,%esp
80103ec8:	83 c7 04             	add    $0x4,%edi
  for(fd = 0; fd < NOFILE; fd++){
80103ecb:	39 df                	cmp    %ebx,%edi
80103ecd:	75 e1                	jne    80103eb0 <exit+0x50>
  begin_op();
80103ecf:	e8 ac ed ff ff       	call   80102c80 <begin_op>
  iput(curproc->cwd);
80103ed4:	83 ec 0c             	sub    $0xc,%esp
80103ed7:	ff 76 58             	pushl  0x58(%esi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eda:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
  iput(curproc->cwd);
80103edf:	e8 ac d9 ff ff       	call   80101890 <iput>
  end_op();
80103ee4:	e8 07 ee ff ff       	call   80102cf0 <end_op>
  curproc->cwd = 0;
80103ee9:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  acquire(&ptable.lock);
80103ef0:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103ef7:	e8 94 0a 00 00       	call   80104990 <acquire>
  wakeup1(curproc->parent);
80103efc:	8b 46 10             	mov    0x10(%esi),%eax
80103eff:	e8 dc f7 ff ff       	call   801036e0 <wakeup1>
80103f04:	83 c4 10             	add    $0x10,%esp
80103f07:	eb 12                	jmp    80103f1b <exit+0xbb>
80103f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f10:	83 c3 70             	add    $0x70,%ebx
80103f13:	81 fb 74 59 11 80    	cmp    $0x80115974,%ebx
80103f19:	73 25                	jae    80103f40 <exit+0xe0>
    if(p->parent == curproc){
80103f1b:	39 73 10             	cmp    %esi,0x10(%ebx)
80103f1e:	75 f0                	jne    80103f10 <exit+0xb0>
      if(p->state == ZOMBIE)
80103f20:	83 7b 08 03          	cmpl   $0x3,0x8(%ebx)
      p->parent = initproc;
80103f24:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
80103f29:	89 43 10             	mov    %eax,0x10(%ebx)
      if(p->state == ZOMBIE)
80103f2c:	75 e2                	jne    80103f10 <exit+0xb0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f2e:	83 c3 70             	add    $0x70,%ebx
        wakeup1(initproc);
80103f31:	e8 aa f7 ff ff       	call   801036e0 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f36:	81 fb 74 59 11 80    	cmp    $0x80115974,%ebx
80103f3c:	72 dd                	jb     80103f1b <exit+0xbb>
80103f3e:	66 90                	xchg   %ax,%ax
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103f40:	8b 4e 6c             	mov    0x6c(%esi),%ecx
80103f43:	89 c8                	mov    %ecx,%eax
80103f45:	8d 76 00             	lea    0x0(%esi),%esi
    if(t->state != UNINIT)
80103f48:	8b 50 08             	mov    0x8(%eax),%edx
80103f4b:	85 d2                	test   %edx,%edx
80103f4d:	74 0a                	je     80103f59 <exit+0xf9>
      t->exitRequest = 1;
80103f4f:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
80103f56:	8b 4e 6c             	mov    0x6c(%esi),%ecx
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103f59:	8d 91 40 02 00 00    	lea    0x240(%ecx),%edx
80103f5f:	83 c0 24             	add    $0x24,%eax
80103f62:	39 d0                	cmp    %edx,%eax
80103f64:	72 e2                	jb     80103f48 <exit+0xe8>
  curthread->state = TERMINATED;
80103f66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  curproc->state = ZOMBIE;
80103f69:	c7 46 08 03 00 00 00 	movl   $0x3,0x8(%esi)
  curthread->state = TERMINATED;
80103f70:	c7 40 08 05 00 00 00 	movl   $0x5,0x8(%eax)
  sched();
80103f77:	e8 24 fe ff ff       	call   80103da0 <sched>
  panic("zombie exit");
80103f7c:	83 ec 0c             	sub    $0xc,%esp
80103f7f:	68 9d 7c 10 80       	push   $0x80107c9d
80103f84:	e8 07 c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103f89:	83 ec 0c             	sub    $0xc,%esp
80103f8c:	68 90 7c 10 80       	push   $0x80107c90
80103f91:	e8 fa c3 ff ff       	call   80100390 <panic>
80103f96:	8d 76 00             	lea    0x0(%esi),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fa0 <yield>:
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	53                   	push   %ebx
80103fa4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fa7:	68 40 3d 11 80       	push   $0x80113d40
80103fac:	e8 df 09 00 00       	call   80104990 <acquire>
  pushcli();
80103fb1:	e8 0a 09 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80103fb6:	e8 05 f9 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103fbb:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103fc1:	e8 3a 09 00 00       	call   80104900 <popcli>
  mythread()->state = RUNNABLE;
80103fc6:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  sched();
80103fcd:	e8 ce fd ff ff       	call   80103da0 <sched>
  release(&ptable.lock);
80103fd2:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103fd9:	e8 72 0a 00 00       	call   80104a50 <release>
}
80103fde:	83 c4 10             	add    $0x10,%esp
80103fe1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fe4:	c9                   	leave  
80103fe5:	c3                   	ret    
80103fe6:	8d 76 00             	lea    0x0(%esi),%esi
80103fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ff0 <sleep>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	57                   	push   %edi
80103ff4:	56                   	push   %esi
80103ff5:	53                   	push   %ebx
80103ff6:	83 ec 0c             	sub    $0xc,%esp
80103ff9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ffc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103fff:	e8 bc 08 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80104004:	e8 b7 f8 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80104009:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
8010400f:	e8 ec 08 00 00       	call   80104900 <popcli>
  if(t == 0)
80104014:	85 db                	test   %ebx,%ebx
80104016:	0f 84 87 00 00 00    	je     801040a3 <sleep+0xb3>
  if(lk == 0)
8010401c:	85 f6                	test   %esi,%esi
8010401e:	74 76                	je     80104096 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104020:	81 fe 40 3d 11 80    	cmp    $0x80113d40,%esi
80104026:	74 50                	je     80104078 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104028:	83 ec 0c             	sub    $0xc,%esp
8010402b:	68 40 3d 11 80       	push   $0x80113d40
80104030:	e8 5b 09 00 00       	call   80104990 <acquire>
    release(lk);
80104035:	89 34 24             	mov    %esi,(%esp)
80104038:	e8 13 0a 00 00       	call   80104a50 <release>
  t->chan = chan;
8010403d:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
80104040:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
80104047:	e8 54 fd ff ff       	call   80103da0 <sched>
  t->chan = 0;
8010404c:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
    release(&ptable.lock);
80104053:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
8010405a:	e8 f1 09 00 00       	call   80104a50 <release>
    acquire(lk);
8010405f:	89 75 08             	mov    %esi,0x8(%ebp)
80104062:	83 c4 10             	add    $0x10,%esp
}
80104065:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104068:	5b                   	pop    %ebx
80104069:	5e                   	pop    %esi
8010406a:	5f                   	pop    %edi
8010406b:	5d                   	pop    %ebp
    acquire(lk);
8010406c:	e9 1f 09 00 00       	jmp    80104990 <acquire>
80104071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  t->chan = chan;
80104078:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
8010407b:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
80104082:	e8 19 fd ff ff       	call   80103da0 <sched>
  t->chan = 0;
80104087:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
}
8010408e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104091:	5b                   	pop    %ebx
80104092:	5e                   	pop    %esi
80104093:	5f                   	pop    %edi
80104094:	5d                   	pop    %ebp
80104095:	c3                   	ret    
    panic("sleep without lk");
80104096:	83 ec 0c             	sub    $0xc,%esp
80104099:	68 af 7c 10 80       	push   $0x80107caf
8010409e:	e8 ed c2 ff ff       	call   80100390 <panic>
    panic("sleep");
801040a3:	83 ec 0c             	sub    $0xc,%esp
801040a6:	68 a9 7c 10 80       	push   $0x80107ca9
801040ab:	e8 e0 c2 ff ff       	call   80100390 <panic>

801040b0 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	53                   	push   %ebx
801040b4:	83 ec 10             	sub    $0x10,%esp
801040b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ba:	68 40 3d 11 80       	push   $0x80113d40
801040bf:	e8 cc 08 00 00       	call   80104990 <acquire>
  wakeup1(chan);
801040c4:	89 d8                	mov    %ebx,%eax
801040c6:	e8 15 f6 ff ff       	call   801036e0 <wakeup1>
  release(&ptable.lock);
801040cb:	83 c4 10             	add    $0x10,%esp
801040ce:	c7 45 08 40 3d 11 80 	movl   $0x80113d40,0x8(%ebp)
}
801040d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d8:	c9                   	leave  
  release(&ptable.lock);
801040d9:	e9 72 09 00 00       	jmp    80104a50 <release>
801040de:	66 90                	xchg   %ax,%ax

801040e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //cprintf("entered kill: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;

  acquire(&ptable.lock);
801040ea:	68 40 3d 11 80       	push   $0x80113d40
801040ef:	e8 9c 08 00 00       	call   80104990 <acquire>
801040f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f7:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
801040fc:	eb 0c                	jmp    8010410a <kill+0x2a>
801040fe:	66 90                	xchg   %ax,%ax
80104100:	83 c0 70             	add    $0x70,%eax
80104103:	3d 74 59 11 80       	cmp    $0x80115974,%eax
80104108:	73 26                	jae    80104130 <kill+0x50>
    if(p->pid == pid){
8010410a:	39 58 0c             	cmp    %ebx,0xc(%eax)
8010410d:	75 f1                	jne    80104100 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      /*if(p->state == SLEEPING)
        p->state = RUNNABLE;*/
      release(&ptable.lock);
8010410f:	83 ec 0c             	sub    $0xc,%esp
      p->killed = 1;
80104112:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
      release(&ptable.lock);
80104119:	68 40 3d 11 80       	push   $0x80113d40
8010411e:	e8 2d 09 00 00       	call   80104a50 <release>
      return 0;
80104123:	83 c4 10             	add    $0x10,%esp
80104126:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104128:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010412b:	c9                   	leave  
8010412c:	c3                   	ret    
8010412d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	68 40 3d 11 80       	push   $0x80113d40
80104138:	e8 13 09 00 00       	call   80104a50 <release>
  return -1;
8010413d:	83 c4 10             	add    $0x10,%esp
80104140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104145:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104148:	c9                   	leave  
80104149:	c3                   	ret    
8010414a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104150 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
  struct proc *p;
  struct kthread *t;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104156:	bf 74 3d 11 80       	mov    $0x80113d74,%edi
{
8010415b:	83 ec 3c             	sub    $0x3c,%esp
8010415e:	66 90                	xchg   %ax,%ax
    if(p->state == UNUSED)
80104160:	8b 57 08             	mov    0x8(%edi),%edx
80104163:	85 d2                	test   %edx,%edx
80104165:	0f 84 84 00 00 00    	je     801041ef <procdump+0x9f>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010416b:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
8010416e:	b9 c0 7c 10 80       	mov    $0x80107cc0,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104173:	77 11                	ja     80104186 <procdump+0x36>
80104175:	8b 0c 95 58 7d 10 80 	mov    -0x7fef82a8(,%edx,4),%ecx
      state = "???";
8010417c:	ba c0 7c 10 80       	mov    $0x80107cc0,%edx
80104181:	85 c9                	test   %ecx,%ecx
80104183:	0f 44 ca             	cmove  %edx,%ecx
    cprintf("process: %d %s %s , ", p->pid, state, p->name);
80104186:	8d 57 5c             	lea    0x5c(%edi),%edx
80104189:	52                   	push   %edx
8010418a:	51                   	push   %ecx
8010418b:	ff 77 0c             	pushl  0xc(%edi)
8010418e:	68 c4 7c 10 80       	push   $0x80107cc4
80104193:	e8 c8 c4 ff ff       	call   80100660 <cprintf>
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104198:	8b 57 6c             	mov    0x6c(%edi),%edx
8010419b:	83 c4 10             	add    $0x10,%esp
8010419e:	89 d3                	mov    %edx,%ebx
      if(t->state == UNINIT)
801041a0:	8b 43 08             	mov    0x8(%ebx),%eax
801041a3:	85 c0                	test   %eax,%eax
801041a5:	74 3b                	je     801041e2 <procdump+0x92>
        continue;
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a7:	8b 4f 08             	mov    0x8(%edi),%ecx
        state = states[p->state];
      else
        state = "???";
801041aa:	ba c0 7c 10 80       	mov    $0x80107cc0,%edx
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041af:	83 f9 05             	cmp    $0x5,%ecx
801041b2:	77 11                	ja     801041c5 <procdump+0x75>
801041b4:	8b 14 8d 58 7d 10 80 	mov    -0x7fef82a8(,%ecx,4),%edx
        state = "???";
801041bb:	b9 c0 7c 10 80       	mov    $0x80107cc0,%ecx
801041c0:	85 d2                	test   %edx,%edx
801041c2:	0f 44 d1             	cmove  %ecx,%edx
      cprintf("thread: %d %s , ", t->tid, state);
801041c5:	83 ec 04             	sub    $0x4,%esp
801041c8:	52                   	push   %edx
801041c9:	ff 73 0c             	pushl  0xc(%ebx)
801041cc:	68 d9 7c 10 80       	push   $0x80107cd9
801041d1:	e8 8a c4 ff ff       	call   80100660 <cprintf>
      if(t->state == SLEEPING){
801041d6:	83 c4 10             	add    $0x10,%esp
801041d9:	83 7b 08 01          	cmpl   $0x1,0x8(%ebx)
801041dd:	74 41                	je     80104220 <procdump+0xd0>
801041df:	8b 57 6c             	mov    0x6c(%edi),%edx
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801041e2:	8d 8a 40 02 00 00    	lea    0x240(%edx),%ecx
801041e8:	83 c3 24             	add    $0x24,%ebx
801041eb:	39 cb                	cmp    %ecx,%ebx
801041ed:	72 b1                	jb     801041a0 <procdump+0x50>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041ef:	83 c7 70             	add    $0x70,%edi
801041f2:	81 ff 74 59 11 80    	cmp    $0x80115974,%edi
801041f8:	0f 82 62 ff ff ff    	jb     80104160 <procdump+0x10>
          cprintf(" %p ", pc[i]);
        }
      }
    }
  }
  cprintf("\n");
801041fe:	83 ec 0c             	sub    $0xc,%esp
80104201:	68 07 81 10 80       	push   $0x80108107
80104206:	e8 55 c4 ff ff       	call   80100660 <cprintf>
}
8010420b:	83 c4 10             	add    $0x10,%esp
8010420e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104211:	5b                   	pop    %ebx
80104212:	5e                   	pop    %esi
80104213:	5f                   	pop    %edi
80104214:	5d                   	pop    %ebp
80104215:	c3                   	ret    
80104216:	8d 76 00             	lea    0x0(%esi),%esi
80104219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        getcallerpcs((uint*)t->context->ebp+2, pc);
80104220:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104223:	83 ec 08             	sub    $0x8,%esp
80104226:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104229:	50                   	push   %eax
8010422a:	8b 53 18             	mov    0x18(%ebx),%edx
8010422d:	8b 52 0c             	mov    0xc(%edx),%edx
80104230:	83 c2 08             	add    $0x8,%edx
80104233:	52                   	push   %edx
80104234:	e8 37 06 00 00       	call   80104870 <getcallerpcs>
80104239:	83 c4 10             	add    $0x10,%esp
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(i=0; i<10 && pc[i] != 0; i++){
80104240:	8b 0e                	mov    (%esi),%ecx
80104242:	85 c9                	test   %ecx,%ecx
80104244:	74 99                	je     801041df <procdump+0x8f>
          cprintf(" %p ", pc[i]);
80104246:	83 ec 08             	sub    $0x8,%esp
80104249:	83 c6 04             	add    $0x4,%esi
8010424c:	51                   	push   %ecx
8010424d:	68 ea 7c 10 80       	push   $0x80107cea
80104252:	e8 09 c4 ff ff       	call   80100660 <cprintf>
        for(i=0; i<10 && pc[i] != 0; i++){
80104257:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010425a:	83 c4 10             	add    $0x10,%esp
8010425d:	39 f0                	cmp    %esi,%eax
8010425f:	75 df                	jne    80104240 <procdump+0xf0>
80104261:	e9 79 ff ff ff       	jmp    801041df <procdump+0x8f>
80104266:	8d 76 00             	lea    0x0(%esi),%esi
80104269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104270 <wait>:
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	57                   	push   %edi
80104274:	56                   	push   %esi
80104275:	53                   	push   %ebx
80104276:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104279:	e8 42 06 00 00       	call   801048c0 <pushcli>
  c = mycpu();
8010427e:	e8 3d f6 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104283:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104289:	e8 72 06 00 00       	call   80104900 <popcli>
  acquire(&ptable.lock);
8010428e:	83 ec 0c             	sub    $0xc,%esp
80104291:	68 40 3d 11 80       	push   $0x80113d40
80104296:	e8 f5 06 00 00       	call   80104990 <acquire>
8010429b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010429e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042a0:	bf 74 3d 11 80       	mov    $0x80113d74,%edi
801042a5:	eb 14                	jmp    801042bb <wait+0x4b>
801042a7:	89 f6                	mov    %esi,%esi
801042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801042b0:	83 c7 70             	add    $0x70,%edi
801042b3:	81 ff 74 59 11 80    	cmp    $0x80115974,%edi
801042b9:	73 1b                	jae    801042d6 <wait+0x66>
      if(p->parent != curproc)
801042bb:	39 5f 10             	cmp    %ebx,0x10(%edi)
801042be:	75 f0                	jne    801042b0 <wait+0x40>
      if(p->state == ZOMBIE){
801042c0:	83 7f 08 03          	cmpl   $0x3,0x8(%edi)
801042c4:	74 3a                	je     80104300 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042c6:	83 c7 70             	add    $0x70,%edi
      havekids = 1;
801042c9:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042ce:	81 ff 74 59 11 80    	cmp    $0x80115974,%edi
801042d4:	72 e5                	jb     801042bb <wait+0x4b>
    if(!havekids || curproc->killed){
801042d6:	85 c0                	test   %eax,%eax
801042d8:	0f 84 17 01 00 00    	je     801043f5 <wait+0x185>
801042de:	8b 43 14             	mov    0x14(%ebx),%eax
801042e1:	85 c0                	test   %eax,%eax
801042e3:	0f 85 0c 01 00 00    	jne    801043f5 <wait+0x185>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801042e9:	83 ec 08             	sub    $0x8,%esp
801042ec:	68 40 3d 11 80       	push   $0x80113d40
801042f1:	53                   	push   %ebx
801042f2:	e8 f9 fc ff ff       	call   80103ff0 <sleep>
    havekids = 0;
801042f7:	83 c4 10             	add    $0x10,%esp
801042fa:	eb a2                	jmp    8010429e <wait+0x2e>
801042fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104300:	8b 77 6c             	mov    0x6c(%edi),%esi
        int hasNonTerminated = 0;
80104303:	31 db                	xor    %ebx,%ebx
80104305:	eb 42                	jmp    80104349 <wait+0xd9>
80104307:	89 f6                	mov    %esi,%esi
80104309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  pushcli();
80104310:	e8 ab 05 00 00       	call   801048c0 <pushcli>
  c = mycpu();
80104315:	e8 a6 f5 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
8010431a:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104320:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  popcli();
80104323:	e8 d8 05 00 00       	call   80104900 <popcli>
            if(t != mythread() && t->state != UNINIT)
80104328:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010432b:	74 0d                	je     8010433a <wait+0xca>
              hasNonTerminated = 1;
8010432d:	8b 56 08             	mov    0x8(%esi),%edx
80104330:	b8 01 00 00 00       	mov    $0x1,%eax
80104335:	85 d2                	test   %edx,%edx
80104337:	0f 45 d8             	cmovne %eax,%ebx
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
8010433a:	8b 47 6c             	mov    0x6c(%edi),%eax
8010433d:	83 c6 24             	add    $0x24,%esi
80104340:	05 40 02 00 00       	add    $0x240,%eax
80104345:	39 c6                	cmp    %eax,%esi
80104347:	73 45                	jae    8010438e <wait+0x11e>
          if(t->state == TERMINATED){
80104349:	83 7e 08 05          	cmpl   $0x5,0x8(%esi)
8010434d:	75 c1                	jne    80104310 <wait+0xa0>
            kfree(t->kstack);
8010434f:	83 ec 0c             	sub    $0xc,%esp
80104352:	ff 36                	pushl  (%esi)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104354:	83 c6 24             	add    $0x24,%esi
            kfree(t->kstack);
80104357:	e8 94 e0 ff ff       	call   801023f0 <kfree>
            t->kstack = 0;
8010435c:	c7 46 dc 00 00 00 00 	movl   $0x0,-0x24(%esi)
            t->tid = 0;
80104363:	c7 46 e8 00 00 00 00 	movl   $0x0,-0x18(%esi)
8010436a:	83 c4 10             	add    $0x10,%esp
            t->tproc = 0;
8010436d:	c7 46 ec 00 00 00 00 	movl   $0x0,-0x14(%esi)
            t->exitRequest = 0;
80104374:	c7 46 fc 00 00 00 00 	movl   $0x0,-0x4(%esi)
            t->state = UNINIT;
8010437b:	c7 46 e4 00 00 00 00 	movl   $0x0,-0x1c(%esi)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104382:	8b 47 6c             	mov    0x6c(%edi),%eax
80104385:	05 40 02 00 00       	add    $0x240,%eax
8010438a:	39 c6                	cmp    %eax,%esi
8010438c:	72 bb                	jb     80104349 <wait+0xd9>
        procdump();
8010438e:	e8 bd fd ff ff       	call   80104150 <procdump>
        cprintf("hasNonTerminated = %d\n", hasNonTerminated);
80104393:	83 ec 08             	sub    $0x8,%esp
  int havekids, pid = 0;
80104396:	31 f6                	xor    %esi,%esi
        cprintf("hasNonTerminated = %d\n", hasNonTerminated);
80104398:	53                   	push   %ebx
80104399:	68 ef 7c 10 80       	push   $0x80107cef
8010439e:	e8 bd c2 ff ff       	call   80100660 <cprintf>
        if(!hasNonTerminated){
801043a3:	83 c4 10             	add    $0x10,%esp
801043a6:	85 db                	test   %ebx,%ebx
801043a8:	75 31                	jne    801043db <wait+0x16b>
          freevm(p->pgdir);
801043aa:	83 ec 0c             	sub    $0xc,%esp
801043ad:	ff 77 04             	pushl  0x4(%edi)
          pid = p->pid;
801043b0:	8b 77 0c             	mov    0xc(%edi),%esi
          freevm(p->pgdir);
801043b3:	e8 b8 2f 00 00       	call   80107370 <freevm>
          p->pid = 0;
801043b8:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
          p->parent = 0;
801043bf:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
          p->state = UNUSED;
801043c6:	83 c4 10             	add    $0x10,%esp
          p->name[0] = 0;
801043c9:	c6 47 5c 00          	movb   $0x0,0x5c(%edi)
          p->killed = 0;
801043cd:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
          p->state = UNUSED;
801043d4:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
        release(&ptable.lock);
801043db:	83 ec 0c             	sub    $0xc,%esp
801043de:	68 40 3d 11 80       	push   $0x80113d40
801043e3:	e8 68 06 00 00       	call   80104a50 <release>
        return pid;
801043e8:	83 c4 10             	add    $0x10,%esp
}
801043eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043ee:	89 f0                	mov    %esi,%eax
801043f0:	5b                   	pop    %ebx
801043f1:	5e                   	pop    %esi
801043f2:	5f                   	pop    %edi
801043f3:	5d                   	pop    %ebp
801043f4:	c3                   	ret    
      release(&ptable.lock);
801043f5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801043f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801043fd:	68 40 3d 11 80       	push   $0x80113d40
80104402:	e8 49 06 00 00       	call   80104a50 <release>
      return -1;
80104407:	83 c4 10             	add    $0x10,%esp
8010440a:	eb df                	jmp    801043eb <wait+0x17b>
8010440c:	66 90                	xchg   %ax,%ax
8010440e:	66 90                	xchg   %ax,%ax

80104410 <kthread_create>:
extern struct ptable ptable;
extern int nexttid;
extern void trapret(void);
extern void forkret(void);

int kthread_create(void (*start_func)(), void* stack){
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	57                   	push   %edi
80104414:	56                   	push   %esi
80104415:	53                   	push   %ebx
80104416:	83 ec 18             	sub    $0x18,%esp
    cprintf("entered kthread_create\n");
80104419:	68 70 7d 10 80       	push   $0x80107d70
8010441e:	e8 3d c2 ff ff       	call   80100660 <cprintf>
    struct proc *p = myproc();
80104423:	e8 38 f5 ff ff       	call   80103960 <myproc>
80104428:	89 c6                	mov    %eax,%esi
    struct kthread *t = 0;
    char *sp;

    acquire(&ptable.lock);
8010442a:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80104431:	e8 5a 05 00 00       	call   80104990 <acquire>
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104436:	8b 5e 6c             	mov    0x6c(%esi),%ebx
        if(tempT->state == UNINIT){
80104439:	83 c4 10             	add    $0x10,%esp
8010443c:	8b 53 08             	mov    0x8(%ebx),%edx
8010443f:	85 d2                	test   %edx,%edx
80104441:	74 1f                	je     80104462 <kthread_create+0x52>
80104443:	8d 93 40 02 00 00    	lea    0x240(%ebx),%edx
80104449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104450:	83 c3 24             	add    $0x24,%ebx
80104453:	39 d3                	cmp    %edx,%ebx
80104455:	0f 84 c5 00 00 00    	je     80104520 <kthread_create+0x110>
        if(tempT->state == UNINIT){
8010445b:	8b 43 08             	mov    0x8(%ebx),%eax
8010445e:	85 c0                	test   %eax,%eax
80104460:	75 ee                	jne    80104450 <kthread_create+0x40>
        release(&ptable.lock);
        return -1;
    }

    t->tproc = p;
    t->tid = nexttid++;
80104462:	a1 04 b0 10 80       	mov    0x8010b004,%eax
    release(&ptable.lock);  
80104467:	83 ec 0c             	sub    $0xc,%esp
    t->tproc = p;
8010446a:	89 73 10             	mov    %esi,0x10(%ebx)
    t->tid = nexttid++;
8010446d:	8d 50 01             	lea    0x1(%eax),%edx
80104470:	89 43 0c             	mov    %eax,0xc(%ebx)
    release(&ptable.lock);  
80104473:	68 40 3d 11 80       	push   $0x80113d40
    t->tid = nexttid++;
80104478:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
    release(&ptable.lock);  
8010447e:	e8 cd 05 00 00       	call   80104a50 <release>

    // Allocate kernel stack for the thread.
    if((t->kstack = kalloc()) == 0){
80104483:	e8 18 e1 ff ff       	call   801025a0 <kalloc>
80104488:	89 c2                	mov    %eax,%edx
8010448a:	89 03                	mov    %eax,(%ebx)
8010448c:	83 c4 10             	add    $0x10,%esp
        return 0;
8010448f:	31 c0                	xor    %eax,%eax
    if((t->kstack = kalloc()) == 0){
80104491:	85 d2                	test   %edx,%edx
80104493:	74 7a                	je     8010450f <kthread_create+0xff>
    }
    sp = t->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *t->tf;
80104495:	8d 82 b4 0f 00 00    	lea    0xfb4(%edx),%eax
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *t->context;
    t->context = (struct context*)sp;
    memset(t->context, 0, sizeof *t->context);
8010449b:	83 ec 04             	sub    $0x4,%esp
    sp -= sizeof *t->context;
8010449e:	81 c2 9c 0f 00 00    	add    $0xf9c,%edx
    sp -= sizeof *t->tf;
801044a4:	89 43 14             	mov    %eax,0x14(%ebx)
    *(uint*)sp = (uint)trapret;
801044a7:	c7 42 14 4f 5d 10 80 	movl   $0x80105d4f,0x14(%edx)
    t->context = (struct context*)sp;
801044ae:	89 53 18             	mov    %edx,0x18(%ebx)
    memset(t->context, 0, sizeof *t->context);
801044b1:	6a 14                	push   $0x14
801044b3:	6a 00                	push   $0x0
801044b5:	52                   	push   %edx
801044b6:	e8 e5 05 00 00       	call   80104aa0 <memset>
    t->context->eip = (uint)forkret;
801044bb:	8b 43 18             	mov    0x18(%ebx),%eax
801044be:	c7 40 10 50 38 10 80 	movl   $0x80103850,0x10(%eax)

    t->exitRequest = 0;
    t->state = RUNNABLE;
    t->ustack = stack;
801044c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    t->exitRequest = 0;
801044c8:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    t->state = RUNNABLE;
801044cf:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
    t->ustack = stack;
801044d6:	89 43 04             	mov    %eax,0x4(%ebx)
    *t->tf = *mythread()->tf;
801044d9:	e8 b2 f4 ff ff       	call   80103990 <mythread>
801044de:	8b 7b 14             	mov    0x14(%ebx),%edi
801044e1:	8b 70 14             	mov    0x14(%eax),%esi
801044e4:	b9 13 00 00 00       	mov    $0x13,%ecx
801044e9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->eip = (uint)start_func;
801044eb:	8b 55 08             	mov    0x8(%ebp),%edx
    t->tf->esp = (uint)(stack);
801044ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    t->tf->eip = (uint)start_func;
801044f1:	8b 43 14             	mov    0x14(%ebx),%eax
801044f4:	89 50 38             	mov    %edx,0x38(%eax)
    t->tf->esp = (uint)(stack);
801044f7:	8b 43 14             	mov    0x14(%ebx),%eax
801044fa:	89 48 44             	mov    %ecx,0x44(%eax)
    cprintf("thread created\n");
801044fd:	c7 04 24 88 7d 10 80 	movl   $0x80107d88,(%esp)
80104504:	e8 57 c1 ff ff       	call   80100660 <cprintf>
    return t->tid;
80104509:	8b 43 0c             	mov    0xc(%ebx),%eax
8010450c:	83 c4 10             	add    $0x10,%esp
}
8010450f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104512:	5b                   	pop    %ebx
80104513:	5e                   	pop    %esi
80104514:	5f                   	pop    %edi
80104515:	5d                   	pop    %ebp
80104516:	c3                   	ret    
80104517:	89 f6                	mov    %esi,%esi
80104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        release(&ptable.lock);
80104520:	83 ec 0c             	sub    $0xc,%esp
80104523:	68 40 3d 11 80       	push   $0x80113d40
80104528:	e8 23 05 00 00       	call   80104a50 <release>
        return -1;
8010452d:	83 c4 10             	add    $0x10,%esp
}
80104530:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80104533:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104538:	5b                   	pop    %ebx
80104539:	5e                   	pop    %esi
8010453a:	5f                   	pop    %edi
8010453b:	5d                   	pop    %ebp
8010453c:	c3                   	ret    
8010453d:	8d 76 00             	lea    0x0(%esi),%esi

80104540 <kthread_id>:

    if (t == 0)
        return -1;
}*/

int kthread_id(){
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	83 ec 08             	sub    $0x8,%esp
    return mythread()->tid;
80104546:	e8 45 f4 ff ff       	call   80103990 <mythread>
8010454b:	8b 40 0c             	mov    0xc(%eax),%eax
}
8010454e:	c9                   	leave  
8010454f:	c3                   	ret    

80104550 <kthread_exit>:

void kthread_exit(){
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	57                   	push   %edi
80104554:	56                   	push   %esi
80104555:	53                   	push   %ebx
    struct kthread *t;

    acquire(&ptable.lock);
    // check if it is the last running thread. if it is, the process execute exit();
    threadProc = curthread->tproc;
    int lastRunning = 1;
80104556:	be 01 00 00 00       	mov    $0x1,%esi
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
            lastRunning = 0;
8010455b:	31 ff                	xor    %edi,%edi
void kthread_exit(){
8010455d:	83 ec 18             	sub    $0x18,%esp
    cprintf("entered kthread_exit\n");
80104560:	68 98 7d 10 80       	push   $0x80107d98
80104565:	e8 f6 c0 ff ff       	call   80100660 <cprintf>
    struct kthread *curthread = mythread();
8010456a:	e8 21 f4 ff ff       	call   80103990 <mythread>
8010456f:	89 c3                	mov    %eax,%ebx
    acquire(&ptable.lock);
80104571:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80104578:	e8 13 04 00 00       	call   80104990 <acquire>
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
8010457d:	8b 43 10             	mov    0x10(%ebx),%eax
80104580:	83 c4 10             	add    $0x10,%esp
80104583:	8b 50 6c             	mov    0x6c(%eax),%edx
80104586:	8d 82 40 02 00 00    	lea    0x240(%edx),%eax
8010458c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80104590:	39 d3                	cmp    %edx,%ebx
80104592:	74 0d                	je     801045a1 <kthread_exit+0x51>
80104594:	8b 4a 08             	mov    0x8(%edx),%ecx
80104597:	85 c9                	test   %ecx,%ecx
80104599:	74 06                	je     801045a1 <kthread_exit+0x51>
            lastRunning = 0;
8010459b:	83 f9 05             	cmp    $0x5,%ecx
8010459e:	0f 45 f7             	cmovne %edi,%esi
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
801045a1:	83 c2 24             	add    $0x24,%edx
801045a4:	39 c2                	cmp    %eax,%edx
801045a6:	75 e8                	jne    80104590 <kthread_exit+0x40>
        }
    }
    if(lastRunning){
801045a8:	85 f6                	test   %esi,%esi
801045aa:	75 40                	jne    801045ec <kthread_exit+0x9c>
    }
    */
    curthread->tf = 0;
    curthread->state = TERMINATED;
	
    release(&ptable.lock);
801045ac:	83 ec 0c             	sub    $0xc,%esp
    curthread->tf = 0;
801045af:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
    curthread->state = TERMINATED;
801045b6:	c7 43 08 05 00 00 00 	movl   $0x5,0x8(%ebx)
    release(&ptable.lock);
801045bd:	68 40 3d 11 80       	push   $0x80113d40
801045c2:	e8 89 04 00 00       	call   80104a50 <release>
    wakeup(curthread);
801045c7:	89 1c 24             	mov    %ebx,(%esp)
801045ca:	e8 e1 fa ff ff       	call   801040b0 <wakeup>
    acquire(&ptable.lock);
801045cf:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801045d6:	e8 b5 03 00 00       	call   80104990 <acquire>

    // Jump into the scheduler, never to return.
    sched();
801045db:	e8 c0 f7 ff ff       	call   80103da0 <sched>
    panic("terminated exit");
801045e0:	c7 04 24 ae 7d 10 80 	movl   $0x80107dae,(%esp)
801045e7:	e8 a4 bd ff ff       	call   80100390 <panic>
        release(&ptable.lock);
801045ec:	83 ec 0c             	sub    $0xc,%esp
801045ef:	68 40 3d 11 80       	push   $0x80113d40
801045f4:	e8 57 04 00 00       	call   80104a50 <release>
        exit();
801045f9:	e8 62 f8 ff ff       	call   80103e60 <exit>
801045fe:	83 c4 10             	add    $0x10,%esp
80104601:	eb a9                	jmp    801045ac <kthread_exit+0x5c>
80104603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104610 <kthread_join>:
}

int kthread_join(int thread_id){
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	56                   	push   %esi
80104614:	53                   	push   %ebx
80104615:	8b 75 08             	mov    0x8(%ebp),%esi
    cprintf("entered kthread_join with thread_id: %d\n", thread_id);
80104618:	83 ec 08             	sub    $0x8,%esp
8010461b:	56                   	push   %esi
8010461c:	68 d4 7d 10 80       	push   $0x80107dd4
80104621:	e8 3a c0 ff ff       	call   80100660 <cprintf>
    struct proc *p = myproc();
80104626:	e8 35 f3 ff ff       	call   80103960 <myproc>
8010462b:	89 c3                	mov    %eax,%ebx
    struct kthread *t = 0;
    if(mythread()->tid == thread_id){
8010462d:	e8 5e f3 ff ff       	call   80103990 <mythread>
80104632:	83 c4 10             	add    $0x10,%esp
80104635:	39 70 0c             	cmp    %esi,0xc(%eax)
80104638:	0f 84 cb 00 00 00    	je     80104709 <kthread_join+0xf9>
        cprintf("join on my thread id\n");
        return -1;
    }

    acquire(&ptable.lock);
8010463e:	83 ec 0c             	sub    $0xc,%esp
80104641:	68 40 3d 11 80       	push   $0x80113d40
80104646:	e8 45 03 00 00       	call   80104990 <acquire>
    // look for the thread with this id
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
8010464b:	8b 5b 6c             	mov    0x6c(%ebx),%ebx
        if (tempT->tid == thread_id){
8010464e:	83 c4 10             	add    $0x10,%esp
80104651:	3b 73 0c             	cmp    0xc(%ebx),%esi
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104654:	8d 83 40 02 00 00    	lea    0x240(%ebx),%eax
        if (tempT->tid == thread_id){
8010465a:	74 10                	je     8010466c <kthread_join+0x5c>
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104660:	83 c3 24             	add    $0x24,%ebx
80104663:	39 c3                	cmp    %eax,%ebx
80104665:	74 69                	je     801046d0 <kthread_join+0xc0>
        if (tempT->tid == thread_id){
80104667:	39 73 0c             	cmp    %esi,0xc(%ebx)
8010466a:	75 f4                	jne    80104660 <kthread_join+0x50>
    }
    if (t == 0){ // thread not found
        release(&ptable.lock);
        return -1;
    }
    if (t->state == UNINIT){ // thread was not initialized - no need to wait
8010466c:	8b 43 08             	mov    0x8(%ebx),%eax
8010466f:	85 c0                	test   %eax,%eax
80104671:	74 7d                	je     801046f0 <kthread_join+0xe0>
         release(&ptable.lock);
         return 0;
    }
    while (t->state != TERMINATED){ // thread is not finished yet
80104673:	83 f8 05             	cmp    $0x5,%eax
80104676:	74 1f                	je     80104697 <kthread_join+0x87>
80104678:	90                   	nop
80104679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        sleep(t, &ptable.lock);
80104680:	83 ec 08             	sub    $0x8,%esp
80104683:	68 40 3d 11 80       	push   $0x80113d40
80104688:	53                   	push   %ebx
80104689:	e8 62 f9 ff ff       	call   80103ff0 <sleep>
    while (t->state != TERMINATED){ // thread is not finished yet
8010468e:	83 c4 10             	add    $0x10,%esp
80104691:	83 7b 08 05          	cmpl   $0x5,0x8(%ebx)
80104695:	75 e9                	jne    80104680 <kthread_join+0x70>
    }
    kfree(t->kstack);
80104697:	83 ec 0c             	sub    $0xc,%esp
8010469a:	ff 33                	pushl  (%ebx)
8010469c:	e8 4f dd ff ff       	call   801023f0 <kfree>
    t->kstack = 0;
801046a1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    t->state = UNINIT;
801046a7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    release(&ptable.lock);
801046ae:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801046b5:	e8 96 03 00 00       	call   80104a50 <release>
    return 0;
801046ba:	83 c4 10             	add    $0x10,%esp
801046bd:	31 c0                	xor    %eax,%eax
}
801046bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046c2:	5b                   	pop    %ebx
801046c3:	5e                   	pop    %esi
801046c4:	5d                   	pop    %ebp
801046c5:	c3                   	ret    
801046c6:	8d 76 00             	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        release(&ptable.lock);
801046d0:	83 ec 0c             	sub    $0xc,%esp
801046d3:	68 40 3d 11 80       	push   $0x80113d40
801046d8:	e8 73 03 00 00       	call   80104a50 <release>
        return -1;
801046dd:	83 c4 10             	add    $0x10,%esp
}
801046e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return -1;
801046e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801046e8:	5b                   	pop    %ebx
801046e9:	5e                   	pop    %esi
801046ea:	5d                   	pop    %ebp
801046eb:	c3                   	ret    
801046ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
         release(&ptable.lock);
801046f0:	83 ec 0c             	sub    $0xc,%esp
801046f3:	68 40 3d 11 80       	push   $0x80113d40
801046f8:	e8 53 03 00 00       	call   80104a50 <release>
         return 0;
801046fd:	83 c4 10             	add    $0x10,%esp
}
80104700:	8d 65 f8             	lea    -0x8(%ebp),%esp
         return 0;
80104703:	31 c0                	xor    %eax,%eax
}
80104705:	5b                   	pop    %ebx
80104706:	5e                   	pop    %esi
80104707:	5d                   	pop    %ebp
80104708:	c3                   	ret    
        cprintf("join on my thread id\n");
80104709:	83 ec 0c             	sub    $0xc,%esp
8010470c:	68 be 7d 10 80       	push   $0x80107dbe
80104711:	e8 4a bf ff ff       	call   80100660 <cprintf>
        return -1;
80104716:	83 c4 10             	add    $0x10,%esp
80104719:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010471e:	eb 9f                	jmp    801046bf <kthread_join+0xaf>

80104720 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	53                   	push   %ebx
80104724:	83 ec 0c             	sub    $0xc,%esp
80104727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010472a:	68 fd 7d 10 80       	push   $0x80107dfd
8010472f:	8d 43 04             	lea    0x4(%ebx),%eax
80104732:	50                   	push   %eax
80104733:	e8 18 01 00 00       	call   80104850 <initlock>
  lk->name = name;
80104738:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010473b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104741:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104744:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010474b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010474e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104751:	c9                   	leave  
80104752:	c3                   	ret    
80104753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104760 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104768:	83 ec 0c             	sub    $0xc,%esp
8010476b:	8d 73 04             	lea    0x4(%ebx),%esi
8010476e:	56                   	push   %esi
8010476f:	e8 1c 02 00 00       	call   80104990 <acquire>
  while (lk->locked) {
80104774:	8b 13                	mov    (%ebx),%edx
80104776:	83 c4 10             	add    $0x10,%esp
80104779:	85 d2                	test   %edx,%edx
8010477b:	74 16                	je     80104793 <acquiresleep+0x33>
8010477d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104780:	83 ec 08             	sub    $0x8,%esp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	e8 66 f8 ff ff       	call   80103ff0 <sleep>
  while (lk->locked) {
8010478a:	8b 03                	mov    (%ebx),%eax
8010478c:	83 c4 10             	add    $0x10,%esp
8010478f:	85 c0                	test   %eax,%eax
80104791:	75 ed                	jne    80104780 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104793:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104799:	e8 c2 f1 ff ff       	call   80103960 <myproc>
8010479e:	8b 40 0c             	mov    0xc(%eax),%eax
801047a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801047a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801047a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047aa:	5b                   	pop    %ebx
801047ab:	5e                   	pop    %esi
801047ac:	5d                   	pop    %ebp
  release(&lk->lk);
801047ad:	e9 9e 02 00 00       	jmp    80104a50 <release>
801047b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047c8:	83 ec 0c             	sub    $0xc,%esp
801047cb:	8d 73 04             	lea    0x4(%ebx),%esi
801047ce:	56                   	push   %esi
801047cf:	e8 bc 01 00 00       	call   80104990 <acquire>
  lk->locked = 0;
801047d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801047da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801047e1:	89 1c 24             	mov    %ebx,(%esp)
801047e4:	e8 c7 f8 ff ff       	call   801040b0 <wakeup>
  release(&lk->lk);
801047e9:	89 75 08             	mov    %esi,0x8(%ebp)
801047ec:	83 c4 10             	add    $0x10,%esp
}
801047ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047f2:	5b                   	pop    %ebx
801047f3:	5e                   	pop    %esi
801047f4:	5d                   	pop    %ebp
  release(&lk->lk);
801047f5:	e9 56 02 00 00       	jmp    80104a50 <release>
801047fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104800 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	53                   	push   %ebx
80104806:	31 ff                	xor    %edi,%edi
80104808:	83 ec 18             	sub    $0x18,%esp
8010480b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010480e:	8d 73 04             	lea    0x4(%ebx),%esi
80104811:	56                   	push   %esi
80104812:	e8 79 01 00 00       	call   80104990 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104817:	8b 03                	mov    (%ebx),%eax
80104819:	83 c4 10             	add    $0x10,%esp
8010481c:	85 c0                	test   %eax,%eax
8010481e:	74 13                	je     80104833 <holdingsleep+0x33>
80104820:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104823:	e8 38 f1 ff ff       	call   80103960 <myproc>
80104828:	39 58 0c             	cmp    %ebx,0xc(%eax)
8010482b:	0f 94 c0             	sete   %al
8010482e:	0f b6 c0             	movzbl %al,%eax
80104831:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104833:	83 ec 0c             	sub    $0xc,%esp
80104836:	56                   	push   %esi
80104837:	e8 14 02 00 00       	call   80104a50 <release>
  return r;
}
8010483c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010483f:	89 f8                	mov    %edi,%eax
80104841:	5b                   	pop    %ebx
80104842:	5e                   	pop    %esi
80104843:	5f                   	pop    %edi
80104844:	5d                   	pop    %ebp
80104845:	c3                   	ret    
80104846:	66 90                	xchg   %ax,%ax
80104848:	66 90                	xchg   %ax,%ax
8010484a:	66 90                	xchg   %ax,%ax
8010484c:	66 90                	xchg   %ax,%ax
8010484e:	66 90                	xchg   %ax,%ax

80104850 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104856:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104859:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010485f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104862:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104869:	5d                   	pop    %ebp
8010486a:	c3                   	ret    
8010486b:	90                   	nop
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104870 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104870:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104871:	31 d2                	xor    %edx,%edx
{
80104873:	89 e5                	mov    %esp,%ebp
80104875:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104876:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104879:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010487c:	83 e8 08             	sub    $0x8,%eax
8010487f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104880:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104886:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010488c:	77 1a                	ja     801048a8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010488e:	8b 58 04             	mov    0x4(%eax),%ebx
80104891:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104894:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104897:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104899:	83 fa 0a             	cmp    $0xa,%edx
8010489c:	75 e2                	jne    80104880 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010489e:	5b                   	pop    %ebx
8010489f:	5d                   	pop    %ebp
801048a0:	c3                   	ret    
801048a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048a8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801048ab:	83 c1 28             	add    $0x28,%ecx
801048ae:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801048b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801048b6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801048b9:	39 c1                	cmp    %eax,%ecx
801048bb:	75 f3                	jne    801048b0 <getcallerpcs+0x40>
}
801048bd:	5b                   	pop    %ebx
801048be:	5d                   	pop    %ebp
801048bf:	c3                   	ret    

801048c0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	83 ec 04             	sub    $0x4,%esp
801048c7:	9c                   	pushf  
801048c8:	5b                   	pop    %ebx
  asm volatile("cli");
801048c9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801048ca:	e8 f1 ef ff ff       	call   801038c0 <mycpu>
801048cf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801048d5:	85 c0                	test   %eax,%eax
801048d7:	75 11                	jne    801048ea <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801048d9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801048df:	e8 dc ef ff ff       	call   801038c0 <mycpu>
801048e4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801048ea:	e8 d1 ef ff ff       	call   801038c0 <mycpu>
801048ef:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801048f6:	83 c4 04             	add    $0x4,%esp
801048f9:	5b                   	pop    %ebx
801048fa:	5d                   	pop    %ebp
801048fb:	c3                   	ret    
801048fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104900 <popcli>:

void
popcli(void)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104906:	9c                   	pushf  
80104907:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104908:	f6 c4 02             	test   $0x2,%ah
8010490b:	75 35                	jne    80104942 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010490d:	e8 ae ef ff ff       	call   801038c0 <mycpu>
80104912:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104919:	78 34                	js     8010494f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010491b:	e8 a0 ef ff ff       	call   801038c0 <mycpu>
80104920:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104926:	85 d2                	test   %edx,%edx
80104928:	74 06                	je     80104930 <popcli+0x30>
    sti();
}
8010492a:	c9                   	leave  
8010492b:	c3                   	ret    
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104930:	e8 8b ef ff ff       	call   801038c0 <mycpu>
80104935:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010493b:	85 c0                	test   %eax,%eax
8010493d:	74 eb                	je     8010492a <popcli+0x2a>
  asm volatile("sti");
8010493f:	fb                   	sti    
}
80104940:	c9                   	leave  
80104941:	c3                   	ret    
    panic("popcli - interruptible");
80104942:	83 ec 0c             	sub    $0xc,%esp
80104945:	68 08 7e 10 80       	push   $0x80107e08
8010494a:	e8 41 ba ff ff       	call   80100390 <panic>
    panic("popcli");
8010494f:	83 ec 0c             	sub    $0xc,%esp
80104952:	68 1f 7e 10 80       	push   $0x80107e1f
80104957:	e8 34 ba ff ff       	call   80100390 <panic>
8010495c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104960 <holding>:
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	56                   	push   %esi
80104964:	53                   	push   %ebx
80104965:	8b 75 08             	mov    0x8(%ebp),%esi
80104968:	31 db                	xor    %ebx,%ebx
  pushcli();
8010496a:	e8 51 ff ff ff       	call   801048c0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010496f:	8b 06                	mov    (%esi),%eax
80104971:	85 c0                	test   %eax,%eax
80104973:	74 10                	je     80104985 <holding+0x25>
80104975:	8b 5e 08             	mov    0x8(%esi),%ebx
80104978:	e8 43 ef ff ff       	call   801038c0 <mycpu>
8010497d:	39 c3                	cmp    %eax,%ebx
8010497f:	0f 94 c3             	sete   %bl
80104982:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104985:	e8 76 ff ff ff       	call   80104900 <popcli>
}
8010498a:	89 d8                	mov    %ebx,%eax
8010498c:	5b                   	pop    %ebx
8010498d:	5e                   	pop    %esi
8010498e:	5d                   	pop    %ebp
8010498f:	c3                   	ret    

80104990 <acquire>:
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	56                   	push   %esi
80104994:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104995:	e8 26 ff ff ff       	call   801048c0 <pushcli>
  if(holding(lk))
8010499a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010499d:	83 ec 0c             	sub    $0xc,%esp
801049a0:	53                   	push   %ebx
801049a1:	e8 ba ff ff ff       	call   80104960 <holding>
801049a6:	83 c4 10             	add    $0x10,%esp
801049a9:	85 c0                	test   %eax,%eax
801049ab:	0f 85 83 00 00 00    	jne    80104a34 <acquire+0xa4>
801049b1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801049b3:	ba 01 00 00 00       	mov    $0x1,%edx
801049b8:	eb 09                	jmp    801049c3 <acquire+0x33>
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049c0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049c3:	89 d0                	mov    %edx,%eax
801049c5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801049c8:	85 c0                	test   %eax,%eax
801049ca:	75 f4                	jne    801049c0 <acquire+0x30>
  __sync_synchronize();
801049cc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801049d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049d4:	e8 e7 ee ff ff       	call   801038c0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801049d9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801049dc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801049df:	89 e8                	mov    %ebp,%eax
801049e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801049e8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801049ee:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801049f4:	77 1a                	ja     80104a10 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801049f6:	8b 48 04             	mov    0x4(%eax),%ecx
801049f9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801049fc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801049ff:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104a01:	83 fe 0a             	cmp    $0xa,%esi
80104a04:	75 e2                	jne    801049e8 <acquire+0x58>
}
80104a06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a09:	5b                   	pop    %ebx
80104a0a:	5e                   	pop    %esi
80104a0b:	5d                   	pop    %ebp
80104a0c:	c3                   	ret    
80104a0d:	8d 76 00             	lea    0x0(%esi),%esi
80104a10:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104a13:	83 c2 28             	add    $0x28,%edx
80104a16:	8d 76 00             	lea    0x0(%esi),%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104a20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104a26:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104a29:	39 d0                	cmp    %edx,%eax
80104a2b:	75 f3                	jne    80104a20 <acquire+0x90>
}
80104a2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a30:	5b                   	pop    %ebx
80104a31:	5e                   	pop    %esi
80104a32:	5d                   	pop    %ebp
80104a33:	c3                   	ret    
    panic("acquire");
80104a34:	83 ec 0c             	sub    $0xc,%esp
80104a37:	68 26 7e 10 80       	push   $0x80107e26
80104a3c:	e8 4f b9 ff ff       	call   80100390 <panic>
80104a41:	eb 0d                	jmp    80104a50 <release>
80104a43:	90                   	nop
80104a44:	90                   	nop
80104a45:	90                   	nop
80104a46:	90                   	nop
80104a47:	90                   	nop
80104a48:	90                   	nop
80104a49:	90                   	nop
80104a4a:	90                   	nop
80104a4b:	90                   	nop
80104a4c:	90                   	nop
80104a4d:	90                   	nop
80104a4e:	90                   	nop
80104a4f:	90                   	nop

80104a50 <release>:
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	53                   	push   %ebx
80104a54:	83 ec 10             	sub    $0x10,%esp
80104a57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104a5a:	53                   	push   %ebx
80104a5b:	e8 00 ff ff ff       	call   80104960 <holding>
80104a60:	83 c4 10             	add    $0x10,%esp
80104a63:	85 c0                	test   %eax,%eax
80104a65:	74 22                	je     80104a89 <release+0x39>
  lk->pcs[0] = 0;
80104a67:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104a6e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104a75:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104a7a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104a80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a83:	c9                   	leave  
  popcli();
80104a84:	e9 77 fe ff ff       	jmp    80104900 <popcli>
    panic("release");
80104a89:	83 ec 0c             	sub    $0xc,%esp
80104a8c:	68 2e 7e 10 80       	push   $0x80107e2e
80104a91:	e8 fa b8 ff ff       	call   80100390 <panic>
80104a96:	66 90                	xchg   %ax,%ax
80104a98:	66 90                	xchg   %ax,%ax
80104a9a:	66 90                	xchg   %ax,%ax
80104a9c:	66 90                	xchg   %ax,%ax
80104a9e:	66 90                	xchg   %ax,%ax

80104aa0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	53                   	push   %ebx
80104aa5:	8b 55 08             	mov    0x8(%ebp),%edx
80104aa8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104aab:	f6 c2 03             	test   $0x3,%dl
80104aae:	75 05                	jne    80104ab5 <memset+0x15>
80104ab0:	f6 c1 03             	test   $0x3,%cl
80104ab3:	74 13                	je     80104ac8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104ab5:	89 d7                	mov    %edx,%edi
80104ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104aba:	fc                   	cld    
80104abb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104abd:	5b                   	pop    %ebx
80104abe:	89 d0                	mov    %edx,%eax
80104ac0:	5f                   	pop    %edi
80104ac1:	5d                   	pop    %ebp
80104ac2:	c3                   	ret    
80104ac3:	90                   	nop
80104ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104ac8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104acc:	c1 e9 02             	shr    $0x2,%ecx
80104acf:	89 f8                	mov    %edi,%eax
80104ad1:	89 fb                	mov    %edi,%ebx
80104ad3:	c1 e0 18             	shl    $0x18,%eax
80104ad6:	c1 e3 10             	shl    $0x10,%ebx
80104ad9:	09 d8                	or     %ebx,%eax
80104adb:	09 f8                	or     %edi,%eax
80104add:	c1 e7 08             	shl    $0x8,%edi
80104ae0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104ae2:	89 d7                	mov    %edx,%edi
80104ae4:	fc                   	cld    
80104ae5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104ae7:	5b                   	pop    %ebx
80104ae8:	89 d0                	mov    %edx,%eax
80104aea:	5f                   	pop    %edi
80104aeb:	5d                   	pop    %ebp
80104aec:	c3                   	ret    
80104aed:	8d 76 00             	lea    0x0(%esi),%esi

80104af0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	57                   	push   %edi
80104af4:	56                   	push   %esi
80104af5:	53                   	push   %ebx
80104af6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104af9:	8b 75 08             	mov    0x8(%ebp),%esi
80104afc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104aff:	85 db                	test   %ebx,%ebx
80104b01:	74 29                	je     80104b2c <memcmp+0x3c>
    if(*s1 != *s2)
80104b03:	0f b6 16             	movzbl (%esi),%edx
80104b06:	0f b6 0f             	movzbl (%edi),%ecx
80104b09:	38 d1                	cmp    %dl,%cl
80104b0b:	75 2b                	jne    80104b38 <memcmp+0x48>
80104b0d:	b8 01 00 00 00       	mov    $0x1,%eax
80104b12:	eb 14                	jmp    80104b28 <memcmp+0x38>
80104b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b18:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104b1c:	83 c0 01             	add    $0x1,%eax
80104b1f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104b24:	38 ca                	cmp    %cl,%dl
80104b26:	75 10                	jne    80104b38 <memcmp+0x48>
  while(n-- > 0){
80104b28:	39 d8                	cmp    %ebx,%eax
80104b2a:	75 ec                	jne    80104b18 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104b2c:	5b                   	pop    %ebx
  return 0;
80104b2d:	31 c0                	xor    %eax,%eax
}
80104b2f:	5e                   	pop    %esi
80104b30:	5f                   	pop    %edi
80104b31:	5d                   	pop    %ebp
80104b32:	c3                   	ret    
80104b33:	90                   	nop
80104b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104b38:	0f b6 c2             	movzbl %dl,%eax
}
80104b3b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104b3c:	29 c8                	sub    %ecx,%eax
}
80104b3e:	5e                   	pop    %esi
80104b3f:	5f                   	pop    %edi
80104b40:	5d                   	pop    %ebp
80104b41:	c3                   	ret    
80104b42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b50 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	56                   	push   %esi
80104b54:	53                   	push   %ebx
80104b55:	8b 45 08             	mov    0x8(%ebp),%eax
80104b58:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104b5b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104b5e:	39 c3                	cmp    %eax,%ebx
80104b60:	73 26                	jae    80104b88 <memmove+0x38>
80104b62:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104b65:	39 c8                	cmp    %ecx,%eax
80104b67:	73 1f                	jae    80104b88 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104b69:	85 f6                	test   %esi,%esi
80104b6b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104b6e:	74 0f                	je     80104b7f <memmove+0x2f>
      *--d = *--s;
80104b70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104b77:	83 ea 01             	sub    $0x1,%edx
80104b7a:	83 fa ff             	cmp    $0xffffffff,%edx
80104b7d:	75 f1                	jne    80104b70 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104b7f:	5b                   	pop    %ebx
80104b80:	5e                   	pop    %esi
80104b81:	5d                   	pop    %ebp
80104b82:	c3                   	ret    
80104b83:	90                   	nop
80104b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104b88:	31 d2                	xor    %edx,%edx
80104b8a:	85 f6                	test   %esi,%esi
80104b8c:	74 f1                	je     80104b7f <memmove+0x2f>
80104b8e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104b90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104b97:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104b9a:	39 d6                	cmp    %edx,%esi
80104b9c:	75 f2                	jne    80104b90 <memmove+0x40>
}
80104b9e:	5b                   	pop    %ebx
80104b9f:	5e                   	pop    %esi
80104ba0:	5d                   	pop    %ebp
80104ba1:	c3                   	ret    
80104ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bb0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104bb3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104bb4:	eb 9a                	jmp    80104b50 <memmove>
80104bb6:	8d 76 00             	lea    0x0(%esi),%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bc0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	57                   	push   %edi
80104bc4:	56                   	push   %esi
80104bc5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104bc8:	53                   	push   %ebx
80104bc9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104bcc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104bcf:	85 ff                	test   %edi,%edi
80104bd1:	74 2f                	je     80104c02 <strncmp+0x42>
80104bd3:	0f b6 01             	movzbl (%ecx),%eax
80104bd6:	0f b6 1e             	movzbl (%esi),%ebx
80104bd9:	84 c0                	test   %al,%al
80104bdb:	74 37                	je     80104c14 <strncmp+0x54>
80104bdd:	38 c3                	cmp    %al,%bl
80104bdf:	75 33                	jne    80104c14 <strncmp+0x54>
80104be1:	01 f7                	add    %esi,%edi
80104be3:	eb 13                	jmp    80104bf8 <strncmp+0x38>
80104be5:	8d 76 00             	lea    0x0(%esi),%esi
80104be8:	0f b6 01             	movzbl (%ecx),%eax
80104beb:	84 c0                	test   %al,%al
80104bed:	74 21                	je     80104c10 <strncmp+0x50>
80104bef:	0f b6 1a             	movzbl (%edx),%ebx
80104bf2:	89 d6                	mov    %edx,%esi
80104bf4:	38 d8                	cmp    %bl,%al
80104bf6:	75 1c                	jne    80104c14 <strncmp+0x54>
    n--, p++, q++;
80104bf8:	8d 56 01             	lea    0x1(%esi),%edx
80104bfb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104bfe:	39 fa                	cmp    %edi,%edx
80104c00:	75 e6                	jne    80104be8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104c02:	5b                   	pop    %ebx
    return 0;
80104c03:	31 c0                	xor    %eax,%eax
}
80104c05:	5e                   	pop    %esi
80104c06:	5f                   	pop    %edi
80104c07:	5d                   	pop    %ebp
80104c08:	c3                   	ret    
80104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c10:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104c14:	29 d8                	sub    %ebx,%eax
}
80104c16:	5b                   	pop    %ebx
80104c17:	5e                   	pop    %esi
80104c18:	5f                   	pop    %edi
80104c19:	5d                   	pop    %ebp
80104c1a:	c3                   	ret    
80104c1b:	90                   	nop
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c20 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	56                   	push   %esi
80104c24:	53                   	push   %ebx
80104c25:	8b 45 08             	mov    0x8(%ebp),%eax
80104c28:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104c2b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104c2e:	89 c2                	mov    %eax,%edx
80104c30:	eb 19                	jmp    80104c4b <strncpy+0x2b>
80104c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c38:	83 c3 01             	add    $0x1,%ebx
80104c3b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104c3f:	83 c2 01             	add    $0x1,%edx
80104c42:	84 c9                	test   %cl,%cl
80104c44:	88 4a ff             	mov    %cl,-0x1(%edx)
80104c47:	74 09                	je     80104c52 <strncpy+0x32>
80104c49:	89 f1                	mov    %esi,%ecx
80104c4b:	85 c9                	test   %ecx,%ecx
80104c4d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104c50:	7f e6                	jg     80104c38 <strncpy+0x18>
    ;
  while(n-- > 0)
80104c52:	31 c9                	xor    %ecx,%ecx
80104c54:	85 f6                	test   %esi,%esi
80104c56:	7e 17                	jle    80104c6f <strncpy+0x4f>
80104c58:	90                   	nop
80104c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104c60:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104c64:	89 f3                	mov    %esi,%ebx
80104c66:	83 c1 01             	add    $0x1,%ecx
80104c69:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104c6b:	85 db                	test   %ebx,%ebx
80104c6d:	7f f1                	jg     80104c60 <strncpy+0x40>
  return os;
}
80104c6f:	5b                   	pop    %ebx
80104c70:	5e                   	pop    %esi
80104c71:	5d                   	pop    %ebp
80104c72:	c3                   	ret    
80104c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c80 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	56                   	push   %esi
80104c84:	53                   	push   %ebx
80104c85:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c88:	8b 45 08             	mov    0x8(%ebp),%eax
80104c8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104c8e:	85 c9                	test   %ecx,%ecx
80104c90:	7e 26                	jle    80104cb8 <safestrcpy+0x38>
80104c92:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104c96:	89 c1                	mov    %eax,%ecx
80104c98:	eb 17                	jmp    80104cb1 <safestrcpy+0x31>
80104c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ca0:	83 c2 01             	add    $0x1,%edx
80104ca3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104ca7:	83 c1 01             	add    $0x1,%ecx
80104caa:	84 db                	test   %bl,%bl
80104cac:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104caf:	74 04                	je     80104cb5 <safestrcpy+0x35>
80104cb1:	39 f2                	cmp    %esi,%edx
80104cb3:	75 eb                	jne    80104ca0 <safestrcpy+0x20>
    ;
  *s = 0;
80104cb5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104cb8:	5b                   	pop    %ebx
80104cb9:	5e                   	pop    %esi
80104cba:	5d                   	pop    %ebp
80104cbb:	c3                   	ret    
80104cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cc0 <strlen>:

int
strlen(const char *s)
{
80104cc0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104cc1:	31 c0                	xor    %eax,%eax
{
80104cc3:	89 e5                	mov    %esp,%ebp
80104cc5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104cc8:	80 3a 00             	cmpb   $0x0,(%edx)
80104ccb:	74 0c                	je     80104cd9 <strlen+0x19>
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi
80104cd0:	83 c0 01             	add    $0x1,%eax
80104cd3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104cd7:	75 f7                	jne    80104cd0 <strlen+0x10>
    ;
  return n;
}
80104cd9:	5d                   	pop    %ebp
80104cda:	c3                   	ret    

80104cdb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104cdb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104cdf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104ce3:	55                   	push   %ebp
  pushl %ebx
80104ce4:	53                   	push   %ebx
  pushl %esi
80104ce5:	56                   	push   %esi
  pushl %edi
80104ce6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104ce7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104ce9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104ceb:	5f                   	pop    %edi
  popl %esi
80104cec:	5e                   	pop    %esi
  popl %ebx
80104ced:	5b                   	pop    %ebx
  popl %ebp
80104cee:	5d                   	pop    %ebp
  ret
80104cef:	c3                   	ret    

80104cf0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	53                   	push   %ebx
80104cf4:	83 ec 04             	sub    $0x4,%esp
80104cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104cfa:	e8 61 ec ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104cff:	8b 00                	mov    (%eax),%eax
80104d01:	39 d8                	cmp    %ebx,%eax
80104d03:	76 1b                	jbe    80104d20 <fetchint+0x30>
80104d05:	8d 53 04             	lea    0x4(%ebx),%edx
80104d08:	39 d0                	cmp    %edx,%eax
80104d0a:	72 14                	jb     80104d20 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d0f:	8b 13                	mov    (%ebx),%edx
80104d11:	89 10                	mov    %edx,(%eax)
  return 0;
80104d13:	31 c0                	xor    %eax,%eax
}
80104d15:	83 c4 04             	add    $0x4,%esp
80104d18:	5b                   	pop    %ebx
80104d19:	5d                   	pop    %ebp
80104d1a:	c3                   	ret    
80104d1b:	90                   	nop
80104d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d25:	eb ee                	jmp    80104d15 <fetchint+0x25>
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d30 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	53                   	push   %ebx
80104d34:	83 ec 04             	sub    $0x4,%esp
80104d37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104d3a:	e8 21 ec ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz)
80104d3f:	39 18                	cmp    %ebx,(%eax)
80104d41:	76 29                	jbe    80104d6c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104d43:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104d46:	89 da                	mov    %ebx,%edx
80104d48:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104d4a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104d4c:	39 c3                	cmp    %eax,%ebx
80104d4e:	73 1c                	jae    80104d6c <fetchstr+0x3c>
    if(*s == 0)
80104d50:	80 3b 00             	cmpb   $0x0,(%ebx)
80104d53:	75 10                	jne    80104d65 <fetchstr+0x35>
80104d55:	eb 39                	jmp    80104d90 <fetchstr+0x60>
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d60:	80 3a 00             	cmpb   $0x0,(%edx)
80104d63:	74 1b                	je     80104d80 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104d65:	83 c2 01             	add    $0x1,%edx
80104d68:	39 d0                	cmp    %edx,%eax
80104d6a:	77 f4                	ja     80104d60 <fetchstr+0x30>
    return -1;
80104d6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104d71:	83 c4 04             	add    $0x4,%esp
80104d74:	5b                   	pop    %ebx
80104d75:	5d                   	pop    %ebp
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d80:	83 c4 04             	add    $0x4,%esp
80104d83:	89 d0                	mov    %edx,%eax
80104d85:	29 d8                	sub    %ebx,%eax
80104d87:	5b                   	pop    %ebx
80104d88:	5d                   	pop    %ebp
80104d89:	c3                   	ret    
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104d90:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104d92:	eb dd                	jmp    80104d71 <fetchstr+0x41>
80104d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104da0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	56                   	push   %esi
80104da4:	53                   	push   %ebx
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104da5:	e8 e6 eb ff ff       	call   80103990 <mythread>
80104daa:	8b 40 14             	mov    0x14(%eax),%eax
80104dad:	8b 55 08             	mov    0x8(%ebp),%edx
80104db0:	8b 40 44             	mov    0x44(%eax),%eax
80104db3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104db6:	e8 a5 eb ff ff       	call   80103960 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104dbb:	8b 00                	mov    (%eax),%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104dbd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104dc0:	39 c6                	cmp    %eax,%esi
80104dc2:	73 1c                	jae    80104de0 <argint+0x40>
80104dc4:	8d 53 08             	lea    0x8(%ebx),%edx
80104dc7:	39 d0                	cmp    %edx,%eax
80104dc9:	72 15                	jb     80104de0 <argint+0x40>
  *ip = *(int*)(addr);
80104dcb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dce:	8b 53 04             	mov    0x4(%ebx),%edx
80104dd1:	89 10                	mov    %edx,(%eax)
  return 0;
80104dd3:	31 c0                	xor    %eax,%eax
}
80104dd5:	5b                   	pop    %ebx
80104dd6:	5e                   	pop    %esi
80104dd7:	5d                   	pop    %ebp
80104dd8:	c3                   	ret    
80104dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80104de5:	eb ee                	jmp    80104dd5 <argint+0x35>
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104df0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	53                   	push   %ebx
80104df5:	83 ec 10             	sub    $0x10,%esp
80104df8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104dfb:	e8 60 eb ff ff       	call   80103960 <myproc>
80104e00:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104e02:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e05:	83 ec 08             	sub    $0x8,%esp
80104e08:	50                   	push   %eax
80104e09:	ff 75 08             	pushl  0x8(%ebp)
80104e0c:	e8 8f ff ff ff       	call   80104da0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104e11:	83 c4 10             	add    $0x10,%esp
80104e14:	85 c0                	test   %eax,%eax
80104e16:	78 28                	js     80104e40 <argptr+0x50>
80104e18:	85 db                	test   %ebx,%ebx
80104e1a:	78 24                	js     80104e40 <argptr+0x50>
80104e1c:	8b 16                	mov    (%esi),%edx
80104e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e21:	39 c2                	cmp    %eax,%edx
80104e23:	76 1b                	jbe    80104e40 <argptr+0x50>
80104e25:	01 c3                	add    %eax,%ebx
80104e27:	39 da                	cmp    %ebx,%edx
80104e29:	72 15                	jb     80104e40 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104e2b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e2e:	89 02                	mov    %eax,(%edx)
  return 0;
80104e30:	31 c0                	xor    %eax,%eax
}
80104e32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e35:	5b                   	pop    %ebx
80104e36:	5e                   	pop    %esi
80104e37:	5d                   	pop    %ebp
80104e38:	c3                   	ret    
80104e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e45:	eb eb                	jmp    80104e32 <argptr+0x42>
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104e56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e59:	50                   	push   %eax
80104e5a:	ff 75 08             	pushl  0x8(%ebp)
80104e5d:	e8 3e ff ff ff       	call   80104da0 <argint>
80104e62:	83 c4 10             	add    $0x10,%esp
80104e65:	85 c0                	test   %eax,%eax
80104e67:	78 17                	js     80104e80 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104e69:	83 ec 08             	sub    $0x8,%esp
80104e6c:	ff 75 0c             	pushl  0xc(%ebp)
80104e6f:	ff 75 f4             	pushl  -0xc(%ebp)
80104e72:	e8 b9 fe ff ff       	call   80104d30 <fetchstr>
80104e77:	83 c4 10             	add    $0x10,%esp
}
80104e7a:	c9                   	leave  
80104e7b:	c3                   	ret    
80104e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <syscall>:
[SYS_kthread_id]   sys_kthread_id,
};

void
syscall(void)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104e95:	e8 c6 ea ff ff       	call   80103960 <myproc>
80104e9a:	89 c6                	mov    %eax,%esi
  struct kthread *curthread = mythread();
80104e9c:	e8 ef ea ff ff       	call   80103990 <mythread>
80104ea1:	89 c3                	mov    %eax,%ebx

  num = curthread->tf->eax;
80104ea3:	8b 40 14             	mov    0x14(%eax),%eax
80104ea6:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ea9:	8d 50 ff             	lea    -0x1(%eax),%edx
80104eac:	83 fa 18             	cmp    $0x18,%edx
80104eaf:	77 1f                	ja     80104ed0 <syscall+0x40>
80104eb1:	8b 14 85 60 7e 10 80 	mov    -0x7fef81a0(,%eax,4),%edx
80104eb8:	85 d2                	test   %edx,%edx
80104eba:	74 14                	je     80104ed0 <syscall+0x40>
    curthread->tf->eax = syscalls[num]();
80104ebc:	ff d2                	call   *%edx
80104ebe:	8b 53 14             	mov    0x14(%ebx),%edx
80104ec1:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curthread->tf->eax = -1;
  }
}
80104ec4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ec7:	5b                   	pop    %ebx
80104ec8:	5e                   	pop    %esi
80104ec9:	5d                   	pop    %ebp
80104eca:	c3                   	ret    
80104ecb:	90                   	nop
80104ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104ed0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ed1:	8d 46 5c             	lea    0x5c(%esi),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ed4:	50                   	push   %eax
80104ed5:	ff 76 0c             	pushl  0xc(%esi)
80104ed8:	68 36 7e 10 80       	push   $0x80107e36
80104edd:	e8 7e b7 ff ff       	call   80100660 <cprintf>
    curthread->tf->eax = -1;
80104ee2:	8b 43 14             	mov    0x14(%ebx),%eax
80104ee5:	83 c4 10             	add    $0x10,%esp
80104ee8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104eef:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ef2:	5b                   	pop    %ebx
80104ef3:	5e                   	pop    %esi
80104ef4:	5d                   	pop    %ebp
80104ef5:	c3                   	ret    
80104ef6:	66 90                	xchg   %ax,%ax
80104ef8:	66 90                	xchg   %ax,%ax
80104efa:	66 90                	xchg   %ax,%ax
80104efc:	66 90                	xchg   %ax,%ax
80104efe:	66 90                	xchg   %ax,%ax

80104f00 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	57                   	push   %edi
80104f04:	56                   	push   %esi
80104f05:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104f06:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104f09:	83 ec 44             	sub    $0x44,%esp
80104f0c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104f0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104f12:	56                   	push   %esi
80104f13:	50                   	push   %eax
{
80104f14:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104f17:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104f1a:	e8 c1 d0 ff ff       	call   80101fe0 <nameiparent>
80104f1f:	83 c4 10             	add    $0x10,%esp
80104f22:	85 c0                	test   %eax,%eax
80104f24:	0f 84 46 01 00 00    	je     80105070 <create+0x170>
    return 0;
  ilock(dp);
80104f2a:	83 ec 0c             	sub    $0xc,%esp
80104f2d:	89 c3                	mov    %eax,%ebx
80104f2f:	50                   	push   %eax
80104f30:	e8 2b c8 ff ff       	call   80101760 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104f35:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104f38:	83 c4 0c             	add    $0xc,%esp
80104f3b:	50                   	push   %eax
80104f3c:	56                   	push   %esi
80104f3d:	53                   	push   %ebx
80104f3e:	e8 4d cd ff ff       	call   80101c90 <dirlookup>
80104f43:	83 c4 10             	add    $0x10,%esp
80104f46:	85 c0                	test   %eax,%eax
80104f48:	89 c7                	mov    %eax,%edi
80104f4a:	74 34                	je     80104f80 <create+0x80>
    iunlockput(dp);
80104f4c:	83 ec 0c             	sub    $0xc,%esp
80104f4f:	53                   	push   %ebx
80104f50:	e8 9b ca ff ff       	call   801019f0 <iunlockput>
    ilock(ip);
80104f55:	89 3c 24             	mov    %edi,(%esp)
80104f58:	e8 03 c8 ff ff       	call   80101760 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104f5d:	83 c4 10             	add    $0x10,%esp
80104f60:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104f65:	0f 85 95 00 00 00    	jne    80105000 <create+0x100>
80104f6b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104f70:	0f 85 8a 00 00 00    	jne    80105000 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104f76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f79:	89 f8                	mov    %edi,%eax
80104f7b:	5b                   	pop    %ebx
80104f7c:	5e                   	pop    %esi
80104f7d:	5f                   	pop    %edi
80104f7e:	5d                   	pop    %ebp
80104f7f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104f80:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104f84:	83 ec 08             	sub    $0x8,%esp
80104f87:	50                   	push   %eax
80104f88:	ff 33                	pushl  (%ebx)
80104f8a:	e8 61 c6 ff ff       	call   801015f0 <ialloc>
80104f8f:	83 c4 10             	add    $0x10,%esp
80104f92:	85 c0                	test   %eax,%eax
80104f94:	89 c7                	mov    %eax,%edi
80104f96:	0f 84 e8 00 00 00    	je     80105084 <create+0x184>
  ilock(ip);
80104f9c:	83 ec 0c             	sub    $0xc,%esp
80104f9f:	50                   	push   %eax
80104fa0:	e8 bb c7 ff ff       	call   80101760 <ilock>
  ip->major = major;
80104fa5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104fa9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104fad:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104fb1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104fb5:	b8 01 00 00 00       	mov    $0x1,%eax
80104fba:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104fbe:	89 3c 24             	mov    %edi,(%esp)
80104fc1:	e8 ea c6 ff ff       	call   801016b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104fc6:	83 c4 10             	add    $0x10,%esp
80104fc9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104fce:	74 50                	je     80105020 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104fd0:	83 ec 04             	sub    $0x4,%esp
80104fd3:	ff 77 04             	pushl  0x4(%edi)
80104fd6:	56                   	push   %esi
80104fd7:	53                   	push   %ebx
80104fd8:	e8 23 cf ff ff       	call   80101f00 <dirlink>
80104fdd:	83 c4 10             	add    $0x10,%esp
80104fe0:	85 c0                	test   %eax,%eax
80104fe2:	0f 88 8f 00 00 00    	js     80105077 <create+0x177>
  iunlockput(dp);
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	53                   	push   %ebx
80104fec:	e8 ff c9 ff ff       	call   801019f0 <iunlockput>
  return ip;
80104ff1:	83 c4 10             	add    $0x10,%esp
}
80104ff4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ff7:	89 f8                	mov    %edi,%eax
80104ff9:	5b                   	pop    %ebx
80104ffa:	5e                   	pop    %esi
80104ffb:	5f                   	pop    %edi
80104ffc:	5d                   	pop    %ebp
80104ffd:	c3                   	ret    
80104ffe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105000:	83 ec 0c             	sub    $0xc,%esp
80105003:	57                   	push   %edi
    return 0;
80105004:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105006:	e8 e5 c9 ff ff       	call   801019f0 <iunlockput>
    return 0;
8010500b:	83 c4 10             	add    $0x10,%esp
}
8010500e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105011:	89 f8                	mov    %edi,%eax
80105013:	5b                   	pop    %ebx
80105014:	5e                   	pop    %esi
80105015:	5f                   	pop    %edi
80105016:	5d                   	pop    %ebp
80105017:	c3                   	ret    
80105018:	90                   	nop
80105019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105020:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105025:	83 ec 0c             	sub    $0xc,%esp
80105028:	53                   	push   %ebx
80105029:	e8 82 c6 ff ff       	call   801016b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010502e:	83 c4 0c             	add    $0xc,%esp
80105031:	ff 77 04             	pushl  0x4(%edi)
80105034:	68 e4 7e 10 80       	push   $0x80107ee4
80105039:	57                   	push   %edi
8010503a:	e8 c1 ce ff ff       	call   80101f00 <dirlink>
8010503f:	83 c4 10             	add    $0x10,%esp
80105042:	85 c0                	test   %eax,%eax
80105044:	78 1c                	js     80105062 <create+0x162>
80105046:	83 ec 04             	sub    $0x4,%esp
80105049:	ff 73 04             	pushl  0x4(%ebx)
8010504c:	68 e3 7e 10 80       	push   $0x80107ee3
80105051:	57                   	push   %edi
80105052:	e8 a9 ce ff ff       	call   80101f00 <dirlink>
80105057:	83 c4 10             	add    $0x10,%esp
8010505a:	85 c0                	test   %eax,%eax
8010505c:	0f 89 6e ff ff ff    	jns    80104fd0 <create+0xd0>
      panic("create dots");
80105062:	83 ec 0c             	sub    $0xc,%esp
80105065:	68 d7 7e 10 80       	push   $0x80107ed7
8010506a:	e8 21 b3 ff ff       	call   80100390 <panic>
8010506f:	90                   	nop
    return 0;
80105070:	31 ff                	xor    %edi,%edi
80105072:	e9 ff fe ff ff       	jmp    80104f76 <create+0x76>
    panic("create: dirlink");
80105077:	83 ec 0c             	sub    $0xc,%esp
8010507a:	68 e6 7e 10 80       	push   $0x80107ee6
8010507f:	e8 0c b3 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105084:	83 ec 0c             	sub    $0xc,%esp
80105087:	68 c8 7e 10 80       	push   $0x80107ec8
8010508c:	e8 ff b2 ff ff       	call   80100390 <panic>
80105091:	eb 0d                	jmp    801050a0 <argfd.constprop.0>
80105093:	90                   	nop
80105094:	90                   	nop
80105095:	90                   	nop
80105096:	90                   	nop
80105097:	90                   	nop
80105098:	90                   	nop
80105099:	90                   	nop
8010509a:	90                   	nop
8010509b:	90                   	nop
8010509c:	90                   	nop
8010509d:	90                   	nop
8010509e:	90                   	nop
8010509f:	90                   	nop

801050a0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	56                   	push   %esi
801050a4:	53                   	push   %ebx
801050a5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801050a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801050aa:	89 d6                	mov    %edx,%esi
801050ac:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050af:	50                   	push   %eax
801050b0:	6a 00                	push   $0x0
801050b2:	e8 e9 fc ff ff       	call   80104da0 <argint>
801050b7:	83 c4 10             	add    $0x10,%esp
801050ba:	85 c0                	test   %eax,%eax
801050bc:	78 2a                	js     801050e8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050be:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050c2:	77 24                	ja     801050e8 <argfd.constprop.0+0x48>
801050c4:	e8 97 e8 ff ff       	call   80103960 <myproc>
801050c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050cc:	8b 44 90 18          	mov    0x18(%eax,%edx,4),%eax
801050d0:	85 c0                	test   %eax,%eax
801050d2:	74 14                	je     801050e8 <argfd.constprop.0+0x48>
  if(pfd)
801050d4:	85 db                	test   %ebx,%ebx
801050d6:	74 02                	je     801050da <argfd.constprop.0+0x3a>
    *pfd = fd;
801050d8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801050da:	89 06                	mov    %eax,(%esi)
  return 0;
801050dc:	31 c0                	xor    %eax,%eax
}
801050de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050e1:	5b                   	pop    %ebx
801050e2:	5e                   	pop    %esi
801050e3:	5d                   	pop    %ebp
801050e4:	c3                   	ret    
801050e5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ed:	eb ef                	jmp    801050de <argfd.constprop.0+0x3e>
801050ef:	90                   	nop

801050f0 <sys_dup>:
{
801050f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801050f1:	31 c0                	xor    %eax,%eax
{
801050f3:	89 e5                	mov    %esp,%ebp
801050f5:	56                   	push   %esi
801050f6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801050f7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801050fa:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801050fd:	e8 9e ff ff ff       	call   801050a0 <argfd.constprop.0>
80105102:	85 c0                	test   %eax,%eax
80105104:	78 42                	js     80105148 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80105106:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105109:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010510b:	e8 50 e8 ff ff       	call   80103960 <myproc>
80105110:	eb 0e                	jmp    80105120 <sys_dup+0x30>
80105112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105118:	83 c3 01             	add    $0x1,%ebx
8010511b:	83 fb 10             	cmp    $0x10,%ebx
8010511e:	74 28                	je     80105148 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105120:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
80105124:	85 d2                	test   %edx,%edx
80105126:	75 f0                	jne    80105118 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105128:	89 74 98 18          	mov    %esi,0x18(%eax,%ebx,4)
  filedup(f);
8010512c:	83 ec 0c             	sub    $0xc,%esp
8010512f:	ff 75 f4             	pushl  -0xc(%ebp)
80105132:	e8 89 bd ff ff       	call   80100ec0 <filedup>
  return fd;
80105137:	83 c4 10             	add    $0x10,%esp
}
8010513a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010513d:	89 d8                	mov    %ebx,%eax
8010513f:	5b                   	pop    %ebx
80105140:	5e                   	pop    %esi
80105141:	5d                   	pop    %ebp
80105142:	c3                   	ret    
80105143:	90                   	nop
80105144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105148:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010514b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105150:	89 d8                	mov    %ebx,%eax
80105152:	5b                   	pop    %ebx
80105153:	5e                   	pop    %esi
80105154:	5d                   	pop    %ebp
80105155:	c3                   	ret    
80105156:	8d 76 00             	lea    0x0(%esi),%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105160 <sys_read>:
{
80105160:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105161:	31 c0                	xor    %eax,%eax
{
80105163:	89 e5                	mov    %esp,%ebp
80105165:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105168:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010516b:	e8 30 ff ff ff       	call   801050a0 <argfd.constprop.0>
80105170:	85 c0                	test   %eax,%eax
80105172:	78 4c                	js     801051c0 <sys_read+0x60>
80105174:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105177:	83 ec 08             	sub    $0x8,%esp
8010517a:	50                   	push   %eax
8010517b:	6a 02                	push   $0x2
8010517d:	e8 1e fc ff ff       	call   80104da0 <argint>
80105182:	83 c4 10             	add    $0x10,%esp
80105185:	85 c0                	test   %eax,%eax
80105187:	78 37                	js     801051c0 <sys_read+0x60>
80105189:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010518c:	83 ec 04             	sub    $0x4,%esp
8010518f:	ff 75 f0             	pushl  -0x10(%ebp)
80105192:	50                   	push   %eax
80105193:	6a 01                	push   $0x1
80105195:	e8 56 fc ff ff       	call   80104df0 <argptr>
8010519a:	83 c4 10             	add    $0x10,%esp
8010519d:	85 c0                	test   %eax,%eax
8010519f:	78 1f                	js     801051c0 <sys_read+0x60>
  return fileread(f, p, n);
801051a1:	83 ec 04             	sub    $0x4,%esp
801051a4:	ff 75 f0             	pushl  -0x10(%ebp)
801051a7:	ff 75 f4             	pushl  -0xc(%ebp)
801051aa:	ff 75 ec             	pushl  -0x14(%ebp)
801051ad:	e8 7e be ff ff       	call   80101030 <fileread>
801051b2:	83 c4 10             	add    $0x10,%esp
}
801051b5:	c9                   	leave  
801051b6:	c3                   	ret    
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801051c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051c5:	c9                   	leave  
801051c6:	c3                   	ret    
801051c7:	89 f6                	mov    %esi,%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <sys_write>:
{
801051d0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051d1:	31 c0                	xor    %eax,%eax
{
801051d3:	89 e5                	mov    %esp,%ebp
801051d5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051d8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801051db:	e8 c0 fe ff ff       	call   801050a0 <argfd.constprop.0>
801051e0:	85 c0                	test   %eax,%eax
801051e2:	78 4c                	js     80105230 <sys_write+0x60>
801051e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051e7:	83 ec 08             	sub    $0x8,%esp
801051ea:	50                   	push   %eax
801051eb:	6a 02                	push   $0x2
801051ed:	e8 ae fb ff ff       	call   80104da0 <argint>
801051f2:	83 c4 10             	add    $0x10,%esp
801051f5:	85 c0                	test   %eax,%eax
801051f7:	78 37                	js     80105230 <sys_write+0x60>
801051f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051fc:	83 ec 04             	sub    $0x4,%esp
801051ff:	ff 75 f0             	pushl  -0x10(%ebp)
80105202:	50                   	push   %eax
80105203:	6a 01                	push   $0x1
80105205:	e8 e6 fb ff ff       	call   80104df0 <argptr>
8010520a:	83 c4 10             	add    $0x10,%esp
8010520d:	85 c0                	test   %eax,%eax
8010520f:	78 1f                	js     80105230 <sys_write+0x60>
  return filewrite(f, p, n);
80105211:	83 ec 04             	sub    $0x4,%esp
80105214:	ff 75 f0             	pushl  -0x10(%ebp)
80105217:	ff 75 f4             	pushl  -0xc(%ebp)
8010521a:	ff 75 ec             	pushl  -0x14(%ebp)
8010521d:	e8 9e be ff ff       	call   801010c0 <filewrite>
80105222:	83 c4 10             	add    $0x10,%esp
}
80105225:	c9                   	leave  
80105226:	c3                   	ret    
80105227:	89 f6                	mov    %esi,%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105235:	c9                   	leave  
80105236:	c3                   	ret    
80105237:	89 f6                	mov    %esi,%esi
80105239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105240 <sys_close>:
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105246:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105249:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010524c:	e8 4f fe ff ff       	call   801050a0 <argfd.constprop.0>
80105251:	85 c0                	test   %eax,%eax
80105253:	78 2b                	js     80105280 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105255:	e8 06 e7 ff ff       	call   80103960 <myproc>
8010525a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010525d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105260:	c7 44 90 18 00 00 00 	movl   $0x0,0x18(%eax,%edx,4)
80105267:	00 
  fileclose(f);
80105268:	ff 75 f4             	pushl  -0xc(%ebp)
8010526b:	e8 a0 bc ff ff       	call   80100f10 <fileclose>
  return 0;
80105270:	83 c4 10             	add    $0x10,%esp
80105273:	31 c0                	xor    %eax,%eax
}
80105275:	c9                   	leave  
80105276:	c3                   	ret    
80105277:	89 f6                	mov    %esi,%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105285:	c9                   	leave  
80105286:	c3                   	ret    
80105287:	89 f6                	mov    %esi,%esi
80105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105290 <sys_fstat>:
{
80105290:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105291:	31 c0                	xor    %eax,%eax
{
80105293:	89 e5                	mov    %esp,%ebp
80105295:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105298:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010529b:	e8 00 fe ff ff       	call   801050a0 <argfd.constprop.0>
801052a0:	85 c0                	test   %eax,%eax
801052a2:	78 2c                	js     801052d0 <sys_fstat+0x40>
801052a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052a7:	83 ec 04             	sub    $0x4,%esp
801052aa:	6a 14                	push   $0x14
801052ac:	50                   	push   %eax
801052ad:	6a 01                	push   $0x1
801052af:	e8 3c fb ff ff       	call   80104df0 <argptr>
801052b4:	83 c4 10             	add    $0x10,%esp
801052b7:	85 c0                	test   %eax,%eax
801052b9:	78 15                	js     801052d0 <sys_fstat+0x40>
  return filestat(f, st);
801052bb:	83 ec 08             	sub    $0x8,%esp
801052be:	ff 75 f4             	pushl  -0xc(%ebp)
801052c1:	ff 75 f0             	pushl  -0x10(%ebp)
801052c4:	e8 17 bd ff ff       	call   80100fe0 <filestat>
801052c9:	83 c4 10             	add    $0x10,%esp
}
801052cc:	c9                   	leave  
801052cd:	c3                   	ret    
801052ce:	66 90                	xchg   %ax,%ax
    return -1;
801052d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052d5:	c9                   	leave  
801052d6:	c3                   	ret    
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052e0 <sys_link>:
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	57                   	push   %edi
801052e4:	56                   	push   %esi
801052e5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801052e6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801052e9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801052ec:	50                   	push   %eax
801052ed:	6a 00                	push   $0x0
801052ef:	e8 5c fb ff ff       	call   80104e50 <argstr>
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	85 c0                	test   %eax,%eax
801052f9:	0f 88 fb 00 00 00    	js     801053fa <sys_link+0x11a>
801052ff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105302:	83 ec 08             	sub    $0x8,%esp
80105305:	50                   	push   %eax
80105306:	6a 01                	push   $0x1
80105308:	e8 43 fb ff ff       	call   80104e50 <argstr>
8010530d:	83 c4 10             	add    $0x10,%esp
80105310:	85 c0                	test   %eax,%eax
80105312:	0f 88 e2 00 00 00    	js     801053fa <sys_link+0x11a>
  begin_op();
80105318:	e8 63 d9 ff ff       	call   80102c80 <begin_op>
  if((ip = namei(old)) == 0){
8010531d:	83 ec 0c             	sub    $0xc,%esp
80105320:	ff 75 d4             	pushl  -0x2c(%ebp)
80105323:	e8 98 cc ff ff       	call   80101fc0 <namei>
80105328:	83 c4 10             	add    $0x10,%esp
8010532b:	85 c0                	test   %eax,%eax
8010532d:	89 c3                	mov    %eax,%ebx
8010532f:	0f 84 ea 00 00 00    	je     8010541f <sys_link+0x13f>
  ilock(ip);
80105335:	83 ec 0c             	sub    $0xc,%esp
80105338:	50                   	push   %eax
80105339:	e8 22 c4 ff ff       	call   80101760 <ilock>
  if(ip->type == T_DIR){
8010533e:	83 c4 10             	add    $0x10,%esp
80105341:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105346:	0f 84 bb 00 00 00    	je     80105407 <sys_link+0x127>
  ip->nlink++;
8010534c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105351:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105354:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105357:	53                   	push   %ebx
80105358:	e8 53 c3 ff ff       	call   801016b0 <iupdate>
  iunlock(ip);
8010535d:	89 1c 24             	mov    %ebx,(%esp)
80105360:	e8 db c4 ff ff       	call   80101840 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105365:	58                   	pop    %eax
80105366:	5a                   	pop    %edx
80105367:	57                   	push   %edi
80105368:	ff 75 d0             	pushl  -0x30(%ebp)
8010536b:	e8 70 cc ff ff       	call   80101fe0 <nameiparent>
80105370:	83 c4 10             	add    $0x10,%esp
80105373:	85 c0                	test   %eax,%eax
80105375:	89 c6                	mov    %eax,%esi
80105377:	74 5b                	je     801053d4 <sys_link+0xf4>
  ilock(dp);
80105379:	83 ec 0c             	sub    $0xc,%esp
8010537c:	50                   	push   %eax
8010537d:	e8 de c3 ff ff       	call   80101760 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105382:	83 c4 10             	add    $0x10,%esp
80105385:	8b 03                	mov    (%ebx),%eax
80105387:	39 06                	cmp    %eax,(%esi)
80105389:	75 3d                	jne    801053c8 <sys_link+0xe8>
8010538b:	83 ec 04             	sub    $0x4,%esp
8010538e:	ff 73 04             	pushl  0x4(%ebx)
80105391:	57                   	push   %edi
80105392:	56                   	push   %esi
80105393:	e8 68 cb ff ff       	call   80101f00 <dirlink>
80105398:	83 c4 10             	add    $0x10,%esp
8010539b:	85 c0                	test   %eax,%eax
8010539d:	78 29                	js     801053c8 <sys_link+0xe8>
  iunlockput(dp);
8010539f:	83 ec 0c             	sub    $0xc,%esp
801053a2:	56                   	push   %esi
801053a3:	e8 48 c6 ff ff       	call   801019f0 <iunlockput>
  iput(ip);
801053a8:	89 1c 24             	mov    %ebx,(%esp)
801053ab:	e8 e0 c4 ff ff       	call   80101890 <iput>
  end_op();
801053b0:	e8 3b d9 ff ff       	call   80102cf0 <end_op>
  return 0;
801053b5:	83 c4 10             	add    $0x10,%esp
801053b8:	31 c0                	xor    %eax,%eax
}
801053ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053bd:	5b                   	pop    %ebx
801053be:	5e                   	pop    %esi
801053bf:	5f                   	pop    %edi
801053c0:	5d                   	pop    %ebp
801053c1:	c3                   	ret    
801053c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801053c8:	83 ec 0c             	sub    $0xc,%esp
801053cb:	56                   	push   %esi
801053cc:	e8 1f c6 ff ff       	call   801019f0 <iunlockput>
    goto bad;
801053d1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801053d4:	83 ec 0c             	sub    $0xc,%esp
801053d7:	53                   	push   %ebx
801053d8:	e8 83 c3 ff ff       	call   80101760 <ilock>
  ip->nlink--;
801053dd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801053e2:	89 1c 24             	mov    %ebx,(%esp)
801053e5:	e8 c6 c2 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
801053ea:	89 1c 24             	mov    %ebx,(%esp)
801053ed:	e8 fe c5 ff ff       	call   801019f0 <iunlockput>
  end_op();
801053f2:	e8 f9 d8 ff ff       	call   80102cf0 <end_op>
  return -1;
801053f7:	83 c4 10             	add    $0x10,%esp
}
801053fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801053fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105402:	5b                   	pop    %ebx
80105403:	5e                   	pop    %esi
80105404:	5f                   	pop    %edi
80105405:	5d                   	pop    %ebp
80105406:	c3                   	ret    
    iunlockput(ip);
80105407:	83 ec 0c             	sub    $0xc,%esp
8010540a:	53                   	push   %ebx
8010540b:	e8 e0 c5 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105410:	e8 db d8 ff ff       	call   80102cf0 <end_op>
    return -1;
80105415:	83 c4 10             	add    $0x10,%esp
80105418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010541d:	eb 9b                	jmp    801053ba <sys_link+0xda>
    end_op();
8010541f:	e8 cc d8 ff ff       	call   80102cf0 <end_op>
    return -1;
80105424:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105429:	eb 8f                	jmp    801053ba <sys_link+0xda>
8010542b:	90                   	nop
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105430 <sys_unlink>:
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105436:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105439:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010543c:	50                   	push   %eax
8010543d:	6a 00                	push   $0x0
8010543f:	e8 0c fa ff ff       	call   80104e50 <argstr>
80105444:	83 c4 10             	add    $0x10,%esp
80105447:	85 c0                	test   %eax,%eax
80105449:	0f 88 77 01 00 00    	js     801055c6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010544f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105452:	e8 29 d8 ff ff       	call   80102c80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105457:	83 ec 08             	sub    $0x8,%esp
8010545a:	53                   	push   %ebx
8010545b:	ff 75 c0             	pushl  -0x40(%ebp)
8010545e:	e8 7d cb ff ff       	call   80101fe0 <nameiparent>
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	85 c0                	test   %eax,%eax
80105468:	89 c6                	mov    %eax,%esi
8010546a:	0f 84 60 01 00 00    	je     801055d0 <sys_unlink+0x1a0>
  ilock(dp);
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	50                   	push   %eax
80105474:	e8 e7 c2 ff ff       	call   80101760 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105479:	58                   	pop    %eax
8010547a:	5a                   	pop    %edx
8010547b:	68 e4 7e 10 80       	push   $0x80107ee4
80105480:	53                   	push   %ebx
80105481:	e8 ea c7 ff ff       	call   80101c70 <namecmp>
80105486:	83 c4 10             	add    $0x10,%esp
80105489:	85 c0                	test   %eax,%eax
8010548b:	0f 84 03 01 00 00    	je     80105594 <sys_unlink+0x164>
80105491:	83 ec 08             	sub    $0x8,%esp
80105494:	68 e3 7e 10 80       	push   $0x80107ee3
80105499:	53                   	push   %ebx
8010549a:	e8 d1 c7 ff ff       	call   80101c70 <namecmp>
8010549f:	83 c4 10             	add    $0x10,%esp
801054a2:	85 c0                	test   %eax,%eax
801054a4:	0f 84 ea 00 00 00    	je     80105594 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801054aa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801054ad:	83 ec 04             	sub    $0x4,%esp
801054b0:	50                   	push   %eax
801054b1:	53                   	push   %ebx
801054b2:	56                   	push   %esi
801054b3:	e8 d8 c7 ff ff       	call   80101c90 <dirlookup>
801054b8:	83 c4 10             	add    $0x10,%esp
801054bb:	85 c0                	test   %eax,%eax
801054bd:	89 c3                	mov    %eax,%ebx
801054bf:	0f 84 cf 00 00 00    	je     80105594 <sys_unlink+0x164>
  ilock(ip);
801054c5:	83 ec 0c             	sub    $0xc,%esp
801054c8:	50                   	push   %eax
801054c9:	e8 92 c2 ff ff       	call   80101760 <ilock>
  if(ip->nlink < 1)
801054ce:	83 c4 10             	add    $0x10,%esp
801054d1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801054d6:	0f 8e 10 01 00 00    	jle    801055ec <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801054dc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054e1:	74 6d                	je     80105550 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801054e3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801054e6:	83 ec 04             	sub    $0x4,%esp
801054e9:	6a 10                	push   $0x10
801054eb:	6a 00                	push   $0x0
801054ed:	50                   	push   %eax
801054ee:	e8 ad f5 ff ff       	call   80104aa0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054f3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801054f6:	6a 10                	push   $0x10
801054f8:	ff 75 c4             	pushl  -0x3c(%ebp)
801054fb:	50                   	push   %eax
801054fc:	56                   	push   %esi
801054fd:	e8 3e c6 ff ff       	call   80101b40 <writei>
80105502:	83 c4 20             	add    $0x20,%esp
80105505:	83 f8 10             	cmp    $0x10,%eax
80105508:	0f 85 eb 00 00 00    	jne    801055f9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010550e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105513:	0f 84 97 00 00 00    	je     801055b0 <sys_unlink+0x180>
  iunlockput(dp);
80105519:	83 ec 0c             	sub    $0xc,%esp
8010551c:	56                   	push   %esi
8010551d:	e8 ce c4 ff ff       	call   801019f0 <iunlockput>
  ip->nlink--;
80105522:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105527:	89 1c 24             	mov    %ebx,(%esp)
8010552a:	e8 81 c1 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
8010552f:	89 1c 24             	mov    %ebx,(%esp)
80105532:	e8 b9 c4 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105537:	e8 b4 d7 ff ff       	call   80102cf0 <end_op>
  return 0;
8010553c:	83 c4 10             	add    $0x10,%esp
8010553f:	31 c0                	xor    %eax,%eax
}
80105541:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105544:	5b                   	pop    %ebx
80105545:	5e                   	pop    %esi
80105546:	5f                   	pop    %edi
80105547:	5d                   	pop    %ebp
80105548:	c3                   	ret    
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105550:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105554:	76 8d                	jbe    801054e3 <sys_unlink+0xb3>
80105556:	bf 20 00 00 00       	mov    $0x20,%edi
8010555b:	eb 0f                	jmp    8010556c <sys_unlink+0x13c>
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
80105560:	83 c7 10             	add    $0x10,%edi
80105563:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105566:	0f 83 77 ff ff ff    	jae    801054e3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010556c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010556f:	6a 10                	push   $0x10
80105571:	57                   	push   %edi
80105572:	50                   	push   %eax
80105573:	53                   	push   %ebx
80105574:	e8 c7 c4 ff ff       	call   80101a40 <readi>
80105579:	83 c4 10             	add    $0x10,%esp
8010557c:	83 f8 10             	cmp    $0x10,%eax
8010557f:	75 5e                	jne    801055df <sys_unlink+0x1af>
    if(de.inum != 0)
80105581:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105586:	74 d8                	je     80105560 <sys_unlink+0x130>
    iunlockput(ip);
80105588:	83 ec 0c             	sub    $0xc,%esp
8010558b:	53                   	push   %ebx
8010558c:	e8 5f c4 ff ff       	call   801019f0 <iunlockput>
    goto bad;
80105591:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105594:	83 ec 0c             	sub    $0xc,%esp
80105597:	56                   	push   %esi
80105598:	e8 53 c4 ff ff       	call   801019f0 <iunlockput>
  end_op();
8010559d:	e8 4e d7 ff ff       	call   80102cf0 <end_op>
  return -1;
801055a2:	83 c4 10             	add    $0x10,%esp
801055a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055aa:	eb 95                	jmp    80105541 <sys_unlink+0x111>
801055ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801055b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801055b5:	83 ec 0c             	sub    $0xc,%esp
801055b8:	56                   	push   %esi
801055b9:	e8 f2 c0 ff ff       	call   801016b0 <iupdate>
801055be:	83 c4 10             	add    $0x10,%esp
801055c1:	e9 53 ff ff ff       	jmp    80105519 <sys_unlink+0xe9>
    return -1;
801055c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055cb:	e9 71 ff ff ff       	jmp    80105541 <sys_unlink+0x111>
    end_op();
801055d0:	e8 1b d7 ff ff       	call   80102cf0 <end_op>
    return -1;
801055d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055da:	e9 62 ff ff ff       	jmp    80105541 <sys_unlink+0x111>
      panic("isdirempty: readi");
801055df:	83 ec 0c             	sub    $0xc,%esp
801055e2:	68 08 7f 10 80       	push   $0x80107f08
801055e7:	e8 a4 ad ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801055ec:	83 ec 0c             	sub    $0xc,%esp
801055ef:	68 f6 7e 10 80       	push   $0x80107ef6
801055f4:	e8 97 ad ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	68 1a 7f 10 80       	push   $0x80107f1a
80105601:	e8 8a ad ff ff       	call   80100390 <panic>
80105606:	8d 76 00             	lea    0x0(%esi),%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <sys_open>:

int
sys_open(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	57                   	push   %edi
80105614:	56                   	push   %esi
80105615:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105616:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105619:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010561c:	50                   	push   %eax
8010561d:	6a 00                	push   $0x0
8010561f:	e8 2c f8 ff ff       	call   80104e50 <argstr>
80105624:	83 c4 10             	add    $0x10,%esp
80105627:	85 c0                	test   %eax,%eax
80105629:	0f 88 1d 01 00 00    	js     8010574c <sys_open+0x13c>
8010562f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105632:	83 ec 08             	sub    $0x8,%esp
80105635:	50                   	push   %eax
80105636:	6a 01                	push   $0x1
80105638:	e8 63 f7 ff ff       	call   80104da0 <argint>
8010563d:	83 c4 10             	add    $0x10,%esp
80105640:	85 c0                	test   %eax,%eax
80105642:	0f 88 04 01 00 00    	js     8010574c <sys_open+0x13c>
    return -1;

  begin_op();
80105648:	e8 33 d6 ff ff       	call   80102c80 <begin_op>

  if(omode & O_CREATE){
8010564d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105651:	0f 85 a9 00 00 00    	jne    80105700 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105657:	83 ec 0c             	sub    $0xc,%esp
8010565a:	ff 75 e0             	pushl  -0x20(%ebp)
8010565d:	e8 5e c9 ff ff       	call   80101fc0 <namei>
80105662:	83 c4 10             	add    $0x10,%esp
80105665:	85 c0                	test   %eax,%eax
80105667:	89 c6                	mov    %eax,%esi
80105669:	0f 84 b2 00 00 00    	je     80105721 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010566f:	83 ec 0c             	sub    $0xc,%esp
80105672:	50                   	push   %eax
80105673:	e8 e8 c0 ff ff       	call   80101760 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105678:	83 c4 10             	add    $0x10,%esp
8010567b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105680:	0f 84 aa 00 00 00    	je     80105730 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105686:	e8 c5 b7 ff ff       	call   80100e50 <filealloc>
8010568b:	85 c0                	test   %eax,%eax
8010568d:	89 c7                	mov    %eax,%edi
8010568f:	0f 84 a6 00 00 00    	je     8010573b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105695:	e8 c6 e2 ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010569a:	31 db                	xor    %ebx,%ebx
8010569c:	eb 0e                	jmp    801056ac <sys_open+0x9c>
8010569e:	66 90                	xchg   %ax,%ax
801056a0:	83 c3 01             	add    $0x1,%ebx
801056a3:	83 fb 10             	cmp    $0x10,%ebx
801056a6:	0f 84 ac 00 00 00    	je     80105758 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801056ac:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
801056b0:	85 d2                	test   %edx,%edx
801056b2:	75 ec                	jne    801056a0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801056b4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801056b7:	89 7c 98 18          	mov    %edi,0x18(%eax,%ebx,4)
  iunlock(ip);
801056bb:	56                   	push   %esi
801056bc:	e8 7f c1 ff ff       	call   80101840 <iunlock>
  end_op();
801056c1:	e8 2a d6 ff ff       	call   80102cf0 <end_op>

  f->type = FD_INODE;
801056c6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801056cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056cf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801056d2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801056d5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801056dc:	89 d0                	mov    %edx,%eax
801056de:	f7 d0                	not    %eax
801056e0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056e3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801056e6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056e9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801056ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056f0:	89 d8                	mov    %ebx,%eax
801056f2:	5b                   	pop    %ebx
801056f3:	5e                   	pop    %esi
801056f4:	5f                   	pop    %edi
801056f5:	5d                   	pop    %ebp
801056f6:	c3                   	ret    
801056f7:	89 f6                	mov    %esi,%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105706:	31 c9                	xor    %ecx,%ecx
80105708:	6a 00                	push   $0x0
8010570a:	ba 02 00 00 00       	mov    $0x2,%edx
8010570f:	e8 ec f7 ff ff       	call   80104f00 <create>
    if(ip == 0){
80105714:	83 c4 10             	add    $0x10,%esp
80105717:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105719:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010571b:	0f 85 65 ff ff ff    	jne    80105686 <sys_open+0x76>
      end_op();
80105721:	e8 ca d5 ff ff       	call   80102cf0 <end_op>
      return -1;
80105726:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010572b:	eb c0                	jmp    801056ed <sys_open+0xdd>
8010572d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105730:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105733:	85 c9                	test   %ecx,%ecx
80105735:	0f 84 4b ff ff ff    	je     80105686 <sys_open+0x76>
    iunlockput(ip);
8010573b:	83 ec 0c             	sub    $0xc,%esp
8010573e:	56                   	push   %esi
8010573f:	e8 ac c2 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105744:	e8 a7 d5 ff ff       	call   80102cf0 <end_op>
    return -1;
80105749:	83 c4 10             	add    $0x10,%esp
8010574c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105751:	eb 9a                	jmp    801056ed <sys_open+0xdd>
80105753:	90                   	nop
80105754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105758:	83 ec 0c             	sub    $0xc,%esp
8010575b:	57                   	push   %edi
8010575c:	e8 af b7 ff ff       	call   80100f10 <fileclose>
80105761:	83 c4 10             	add    $0x10,%esp
80105764:	eb d5                	jmp    8010573b <sys_open+0x12b>
80105766:	8d 76 00             	lea    0x0(%esi),%esi
80105769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105770 <sys_mkdir>:

int
sys_mkdir(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105776:	e8 05 d5 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010577b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010577e:	83 ec 08             	sub    $0x8,%esp
80105781:	50                   	push   %eax
80105782:	6a 00                	push   $0x0
80105784:	e8 c7 f6 ff ff       	call   80104e50 <argstr>
80105789:	83 c4 10             	add    $0x10,%esp
8010578c:	85 c0                	test   %eax,%eax
8010578e:	78 30                	js     801057c0 <sys_mkdir+0x50>
80105790:	83 ec 0c             	sub    $0xc,%esp
80105793:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105796:	31 c9                	xor    %ecx,%ecx
80105798:	6a 00                	push   $0x0
8010579a:	ba 01 00 00 00       	mov    $0x1,%edx
8010579f:	e8 5c f7 ff ff       	call   80104f00 <create>
801057a4:	83 c4 10             	add    $0x10,%esp
801057a7:	85 c0                	test   %eax,%eax
801057a9:	74 15                	je     801057c0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057ab:	83 ec 0c             	sub    $0xc,%esp
801057ae:	50                   	push   %eax
801057af:	e8 3c c2 ff ff       	call   801019f0 <iunlockput>
  end_op();
801057b4:	e8 37 d5 ff ff       	call   80102cf0 <end_op>
  return 0;
801057b9:	83 c4 10             	add    $0x10,%esp
801057bc:	31 c0                	xor    %eax,%eax
}
801057be:	c9                   	leave  
801057bf:	c3                   	ret    
    end_op();
801057c0:	e8 2b d5 ff ff       	call   80102cf0 <end_op>
    return -1;
801057c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057ca:	c9                   	leave  
801057cb:	c3                   	ret    
801057cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057d0 <sys_mknod>:

int
sys_mknod(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801057d6:	e8 a5 d4 ff ff       	call   80102c80 <begin_op>
  if((argstr(0, &path)) < 0 ||
801057db:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057de:	83 ec 08             	sub    $0x8,%esp
801057e1:	50                   	push   %eax
801057e2:	6a 00                	push   $0x0
801057e4:	e8 67 f6 ff ff       	call   80104e50 <argstr>
801057e9:	83 c4 10             	add    $0x10,%esp
801057ec:	85 c0                	test   %eax,%eax
801057ee:	78 60                	js     80105850 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801057f0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057f3:	83 ec 08             	sub    $0x8,%esp
801057f6:	50                   	push   %eax
801057f7:	6a 01                	push   $0x1
801057f9:	e8 a2 f5 ff ff       	call   80104da0 <argint>
  if((argstr(0, &path)) < 0 ||
801057fe:	83 c4 10             	add    $0x10,%esp
80105801:	85 c0                	test   %eax,%eax
80105803:	78 4b                	js     80105850 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105805:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105808:	83 ec 08             	sub    $0x8,%esp
8010580b:	50                   	push   %eax
8010580c:	6a 02                	push   $0x2
8010580e:	e8 8d f5 ff ff       	call   80104da0 <argint>
     argint(1, &major) < 0 ||
80105813:	83 c4 10             	add    $0x10,%esp
80105816:	85 c0                	test   %eax,%eax
80105818:	78 36                	js     80105850 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010581a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010581e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105821:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105825:	ba 03 00 00 00       	mov    $0x3,%edx
8010582a:	50                   	push   %eax
8010582b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010582e:	e8 cd f6 ff ff       	call   80104f00 <create>
80105833:	83 c4 10             	add    $0x10,%esp
80105836:	85 c0                	test   %eax,%eax
80105838:	74 16                	je     80105850 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010583a:	83 ec 0c             	sub    $0xc,%esp
8010583d:	50                   	push   %eax
8010583e:	e8 ad c1 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105843:	e8 a8 d4 ff ff       	call   80102cf0 <end_op>
  return 0;
80105848:	83 c4 10             	add    $0x10,%esp
8010584b:	31 c0                	xor    %eax,%eax
}
8010584d:	c9                   	leave  
8010584e:	c3                   	ret    
8010584f:	90                   	nop
    end_op();
80105850:	e8 9b d4 ff ff       	call   80102cf0 <end_op>
    return -1;
80105855:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010585a:	c9                   	leave  
8010585b:	c3                   	ret    
8010585c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105860 <sys_chdir>:

int
sys_chdir(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	56                   	push   %esi
80105864:	53                   	push   %ebx
80105865:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105868:	e8 f3 e0 ff ff       	call   80103960 <myproc>
8010586d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010586f:	e8 0c d4 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105874:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105877:	83 ec 08             	sub    $0x8,%esp
8010587a:	50                   	push   %eax
8010587b:	6a 00                	push   $0x0
8010587d:	e8 ce f5 ff ff       	call   80104e50 <argstr>
80105882:	83 c4 10             	add    $0x10,%esp
80105885:	85 c0                	test   %eax,%eax
80105887:	78 77                	js     80105900 <sys_chdir+0xa0>
80105889:	83 ec 0c             	sub    $0xc,%esp
8010588c:	ff 75 f4             	pushl  -0xc(%ebp)
8010588f:	e8 2c c7 ff ff       	call   80101fc0 <namei>
80105894:	83 c4 10             	add    $0x10,%esp
80105897:	85 c0                	test   %eax,%eax
80105899:	89 c3                	mov    %eax,%ebx
8010589b:	74 63                	je     80105900 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010589d:	83 ec 0c             	sub    $0xc,%esp
801058a0:	50                   	push   %eax
801058a1:	e8 ba be ff ff       	call   80101760 <ilock>
  if(ip->type != T_DIR){
801058a6:	83 c4 10             	add    $0x10,%esp
801058a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058ae:	75 30                	jne    801058e0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801058b0:	83 ec 0c             	sub    $0xc,%esp
801058b3:	53                   	push   %ebx
801058b4:	e8 87 bf ff ff       	call   80101840 <iunlock>
  iput(curproc->cwd);
801058b9:	58                   	pop    %eax
801058ba:	ff 76 58             	pushl  0x58(%esi)
801058bd:	e8 ce bf ff ff       	call   80101890 <iput>
  end_op();
801058c2:	e8 29 d4 ff ff       	call   80102cf0 <end_op>
  curproc->cwd = ip;
801058c7:	89 5e 58             	mov    %ebx,0x58(%esi)
  return 0;
801058ca:	83 c4 10             	add    $0x10,%esp
801058cd:	31 c0                	xor    %eax,%eax
}
801058cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058d2:	5b                   	pop    %ebx
801058d3:	5e                   	pop    %esi
801058d4:	5d                   	pop    %ebp
801058d5:	c3                   	ret    
801058d6:	8d 76 00             	lea    0x0(%esi),%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801058e0:	83 ec 0c             	sub    $0xc,%esp
801058e3:	53                   	push   %ebx
801058e4:	e8 07 c1 ff ff       	call   801019f0 <iunlockput>
    end_op();
801058e9:	e8 02 d4 ff ff       	call   80102cf0 <end_op>
    return -1;
801058ee:	83 c4 10             	add    $0x10,%esp
801058f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f6:	eb d7                	jmp    801058cf <sys_chdir+0x6f>
801058f8:	90                   	nop
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105900:	e8 eb d3 ff ff       	call   80102cf0 <end_op>
    return -1;
80105905:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010590a:	eb c3                	jmp    801058cf <sys_chdir+0x6f>
8010590c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105910 <sys_exec>:

int
sys_exec(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	57                   	push   %edi
80105914:	56                   	push   %esi
80105915:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105916:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010591c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105922:	50                   	push   %eax
80105923:	6a 00                	push   $0x0
80105925:	e8 26 f5 ff ff       	call   80104e50 <argstr>
8010592a:	83 c4 10             	add    $0x10,%esp
8010592d:	85 c0                	test   %eax,%eax
8010592f:	0f 88 87 00 00 00    	js     801059bc <sys_exec+0xac>
80105935:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010593b:	83 ec 08             	sub    $0x8,%esp
8010593e:	50                   	push   %eax
8010593f:	6a 01                	push   $0x1
80105941:	e8 5a f4 ff ff       	call   80104da0 <argint>
80105946:	83 c4 10             	add    $0x10,%esp
80105949:	85 c0                	test   %eax,%eax
8010594b:	78 6f                	js     801059bc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010594d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105953:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105956:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105958:	68 80 00 00 00       	push   $0x80
8010595d:	6a 00                	push   $0x0
8010595f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105965:	50                   	push   %eax
80105966:	e8 35 f1 ff ff       	call   80104aa0 <memset>
8010596b:	83 c4 10             	add    $0x10,%esp
8010596e:	eb 2c                	jmp    8010599c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105970:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105976:	85 c0                	test   %eax,%eax
80105978:	74 56                	je     801059d0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010597a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105986:	52                   	push   %edx
80105987:	50                   	push   %eax
80105988:	e8 a3 f3 ff ff       	call   80104d30 <fetchstr>
8010598d:	83 c4 10             	add    $0x10,%esp
80105990:	85 c0                	test   %eax,%eax
80105992:	78 28                	js     801059bc <sys_exec+0xac>
  for(i=0;; i++){
80105994:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105997:	83 fb 20             	cmp    $0x20,%ebx
8010599a:	74 20                	je     801059bc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010599c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801059a2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801059a9:	83 ec 08             	sub    $0x8,%esp
801059ac:	57                   	push   %edi
801059ad:	01 f0                	add    %esi,%eax
801059af:	50                   	push   %eax
801059b0:	e8 3b f3 ff ff       	call   80104cf0 <fetchint>
801059b5:	83 c4 10             	add    $0x10,%esp
801059b8:	85 c0                	test   %eax,%eax
801059ba:	79 b4                	jns    80105970 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801059bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801059bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059c4:	5b                   	pop    %ebx
801059c5:	5e                   	pop    %esi
801059c6:	5f                   	pop    %edi
801059c7:	5d                   	pop    %ebp
801059c8:	c3                   	ret    
801059c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801059d0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801059d6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801059d9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801059e0:	00 00 00 00 
  return exec(path, argv);
801059e4:	50                   	push   %eax
801059e5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801059eb:	e8 20 b0 ff ff       	call   80100a10 <exec>
801059f0:	83 c4 10             	add    $0x10,%esp
}
801059f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059f6:	5b                   	pop    %ebx
801059f7:	5e                   	pop    %esi
801059f8:	5f                   	pop    %edi
801059f9:	5d                   	pop    %ebp
801059fa:	c3                   	ret    
801059fb:	90                   	nop
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a00 <sys_pipe>:

int
sys_pipe(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	57                   	push   %edi
80105a04:	56                   	push   %esi
80105a05:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a06:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105a09:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a0c:	6a 08                	push   $0x8
80105a0e:	50                   	push   %eax
80105a0f:	6a 00                	push   $0x0
80105a11:	e8 da f3 ff ff       	call   80104df0 <argptr>
80105a16:	83 c4 10             	add    $0x10,%esp
80105a19:	85 c0                	test   %eax,%eax
80105a1b:	0f 88 ae 00 00 00    	js     80105acf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105a21:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a24:	83 ec 08             	sub    $0x8,%esp
80105a27:	50                   	push   %eax
80105a28:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a2b:	50                   	push   %eax
80105a2c:	e8 ef d8 ff ff       	call   80103320 <pipealloc>
80105a31:	83 c4 10             	add    $0x10,%esp
80105a34:	85 c0                	test   %eax,%eax
80105a36:	0f 88 93 00 00 00    	js     80105acf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a3c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105a3f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105a41:	e8 1a df ff ff       	call   80103960 <myproc>
80105a46:	eb 10                	jmp    80105a58 <sys_pipe+0x58>
80105a48:	90                   	nop
80105a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105a50:	83 c3 01             	add    $0x1,%ebx
80105a53:	83 fb 10             	cmp    $0x10,%ebx
80105a56:	74 60                	je     80105ab8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105a58:	8b 74 98 18          	mov    0x18(%eax,%ebx,4),%esi
80105a5c:	85 f6                	test   %esi,%esi
80105a5e:	75 f0                	jne    80105a50 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105a60:	8d 73 04             	lea    0x4(%ebx),%esi
80105a63:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105a6a:	e8 f1 de ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105a6f:	31 d2                	xor    %edx,%edx
80105a71:	eb 0d                	jmp    80105a80 <sys_pipe+0x80>
80105a73:	90                   	nop
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a78:	83 c2 01             	add    $0x1,%edx
80105a7b:	83 fa 10             	cmp    $0x10,%edx
80105a7e:	74 28                	je     80105aa8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105a80:	8b 4c 90 18          	mov    0x18(%eax,%edx,4),%ecx
80105a84:	85 c9                	test   %ecx,%ecx
80105a86:	75 f0                	jne    80105a78 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105a88:	89 7c 90 18          	mov    %edi,0x18(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105a8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a8f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105a91:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a94:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105a97:	31 c0                	xor    %eax,%eax
}
80105a99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a9c:	5b                   	pop    %ebx
80105a9d:	5e                   	pop    %esi
80105a9e:	5f                   	pop    %edi
80105a9f:	5d                   	pop    %ebp
80105aa0:	c3                   	ret    
80105aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105aa8:	e8 b3 de ff ff       	call   80103960 <myproc>
80105aad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105ab4:	00 
80105ab5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105ab8:	83 ec 0c             	sub    $0xc,%esp
80105abb:	ff 75 e0             	pushl  -0x20(%ebp)
80105abe:	e8 4d b4 ff ff       	call   80100f10 <fileclose>
    fileclose(wf);
80105ac3:	58                   	pop    %eax
80105ac4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105ac7:	e8 44 b4 ff ff       	call   80100f10 <fileclose>
    return -1;
80105acc:	83 c4 10             	add    $0x10,%esp
80105acf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ad4:	eb c3                	jmp    80105a99 <sys_pipe+0x99>
80105ad6:	66 90                	xchg   %ax,%ax
80105ad8:	66 90                	xchg   %ax,%ax
80105ada:	66 90                	xchg   %ax,%ax
80105adc:	66 90                	xchg   %ax,%ax
80105ade:	66 90                	xchg   %ax,%ax

80105ae0 <sys_fork>:
#include "proc.h"
#include "kthread.h"

int
sys_fork(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105ae3:	5d                   	pop    %ebp
  return fork();
80105ae4:	e9 87 e0 ff ff       	jmp    80103b70 <fork>
80105ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105af0 <sys_exit>:

int
sys_exit(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105af6:	e8 65 e3 ff ff       	call   80103e60 <exit>
  return 0;  // not reached
}
80105afb:	31 c0                	xor    %eax,%eax
80105afd:	c9                   	leave  
80105afe:	c3                   	ret    
80105aff:	90                   	nop

80105b00 <sys_wait>:

int
sys_wait(void)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105b03:	5d                   	pop    %ebp
  return wait();
80105b04:	e9 67 e7 ff ff       	jmp    80104270 <wait>
80105b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b10 <sys_kill>:

int
sys_kill(void)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105b16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b19:	50                   	push   %eax
80105b1a:	6a 00                	push   $0x0
80105b1c:	e8 7f f2 ff ff       	call   80104da0 <argint>
80105b21:	83 c4 10             	add    $0x10,%esp
80105b24:	85 c0                	test   %eax,%eax
80105b26:	78 18                	js     80105b40 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105b28:	83 ec 0c             	sub    $0xc,%esp
80105b2b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b2e:	e8 ad e5 ff ff       	call   801040e0 <kill>
80105b33:	83 c4 10             	add    $0x10,%esp
}
80105b36:	c9                   	leave  
80105b37:	c3                   	ret    
80105b38:	90                   	nop
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b45:	c9                   	leave  
80105b46:	c3                   	ret    
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b50 <sys_getpid>:

int
sys_getpid(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b56:	e8 05 de ff ff       	call   80103960 <myproc>
80105b5b:	8b 40 0c             	mov    0xc(%eax),%eax
}
80105b5e:	c9                   	leave  
80105b5f:	c3                   	ret    

80105b60 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b64:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b67:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b6a:	50                   	push   %eax
80105b6b:	6a 00                	push   $0x0
80105b6d:	e8 2e f2 ff ff       	call   80104da0 <argint>
80105b72:	83 c4 10             	add    $0x10,%esp
80105b75:	85 c0                	test   %eax,%eax
80105b77:	78 27                	js     80105ba0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105b79:	e8 e2 dd ff ff       	call   80103960 <myproc>
  if(growproc(n) < 0)
80105b7e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105b81:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105b83:	ff 75 f4             	pushl  -0xc(%ebp)
80105b86:	e8 35 df ff ff       	call   80103ac0 <growproc>
80105b8b:	83 c4 10             	add    $0x10,%esp
80105b8e:	85 c0                	test   %eax,%eax
80105b90:	78 0e                	js     80105ba0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105b92:	89 d8                	mov    %ebx,%eax
80105b94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b97:	c9                   	leave  
80105b98:	c3                   	ret    
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ba0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ba5:	eb eb                	jmp    80105b92 <sys_sbrk+0x32>
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bb0 <sys_sleep>:

int
sys_sleep(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105bb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105bb7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105bba:	50                   	push   %eax
80105bbb:	6a 00                	push   $0x0
80105bbd:	e8 de f1 ff ff       	call   80104da0 <argint>
80105bc2:	83 c4 10             	add    $0x10,%esp
80105bc5:	85 c0                	test   %eax,%eax
80105bc7:	0f 88 8a 00 00 00    	js     80105c57 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105bcd:	83 ec 0c             	sub    $0xc,%esp
80105bd0:	68 80 e9 11 80       	push   $0x8011e980
80105bd5:	e8 b6 ed ff ff       	call   80104990 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105bda:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105bdd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105be0:	8b 1d c0 f1 11 80    	mov    0x8011f1c0,%ebx
  while(ticks - ticks0 < n){
80105be6:	85 d2                	test   %edx,%edx
80105be8:	75 27                	jne    80105c11 <sys_sleep+0x61>
80105bea:	eb 54                	jmp    80105c40 <sys_sleep+0x90>
80105bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105bf0:	83 ec 08             	sub    $0x8,%esp
80105bf3:	68 80 e9 11 80       	push   $0x8011e980
80105bf8:	68 c0 f1 11 80       	push   $0x8011f1c0
80105bfd:	e8 ee e3 ff ff       	call   80103ff0 <sleep>
  while(ticks - ticks0 < n){
80105c02:	a1 c0 f1 11 80       	mov    0x8011f1c0,%eax
80105c07:	83 c4 10             	add    $0x10,%esp
80105c0a:	29 d8                	sub    %ebx,%eax
80105c0c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c0f:	73 2f                	jae    80105c40 <sys_sleep+0x90>
    if(myproc()->killed){
80105c11:	e8 4a dd ff ff       	call   80103960 <myproc>
80105c16:	8b 40 14             	mov    0x14(%eax),%eax
80105c19:	85 c0                	test   %eax,%eax
80105c1b:	74 d3                	je     80105bf0 <sys_sleep+0x40>
      release(&tickslock);
80105c1d:	83 ec 0c             	sub    $0xc,%esp
80105c20:	68 80 e9 11 80       	push   $0x8011e980
80105c25:	e8 26 ee ff ff       	call   80104a50 <release>
      return -1;
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105c32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c35:	c9                   	leave  
80105c36:	c3                   	ret    
80105c37:	89 f6                	mov    %esi,%esi
80105c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105c40:	83 ec 0c             	sub    $0xc,%esp
80105c43:	68 80 e9 11 80       	push   $0x8011e980
80105c48:	e8 03 ee ff ff       	call   80104a50 <release>
  return 0;
80105c4d:	83 c4 10             	add    $0x10,%esp
80105c50:	31 c0                	xor    %eax,%eax
}
80105c52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c55:	c9                   	leave  
80105c56:	c3                   	ret    
    return -1;
80105c57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c5c:	eb f4                	jmp    80105c52 <sys_sleep+0xa2>
80105c5e:	66 90                	xchg   %ax,%ax

80105c60 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	53                   	push   %ebx
80105c64:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105c67:	68 80 e9 11 80       	push   $0x8011e980
80105c6c:	e8 1f ed ff ff       	call   80104990 <acquire>
  xticks = ticks;
80105c71:	8b 1d c0 f1 11 80    	mov    0x8011f1c0,%ebx
  release(&tickslock);
80105c77:	c7 04 24 80 e9 11 80 	movl   $0x8011e980,(%esp)
80105c7e:	e8 cd ed ff ff       	call   80104a50 <release>
  return xticks;
}
80105c83:	89 d8                	mov    %ebx,%eax
80105c85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c88:	c9                   	leave  
80105c89:	c3                   	ret    
80105c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c90 <sys_kthread_exit>:

int
sys_kthread_exit(void)
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	83 ec 08             	sub    $0x8,%esp
  kthread_exit();
80105c96:	e8 b5 e8 ff ff       	call   80104550 <kthread_exit>
  return 0;  // not reached
}
80105c9b:	31 c0                	xor    %eax,%eax
80105c9d:	c9                   	leave  
80105c9e:	c3                   	ret    
80105c9f:	90                   	nop

80105ca0 <sys_kthread_create>:

int
sys_kthread_create(void)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	83 ec 1c             	sub    $0x1c,%esp
  void* start_func;
  void* stack;

  if ((argptr(0, (char**)(&start_func), sizeof(int)) < 0) || (argptr(1, (char**)(&stack), sizeof(int)) < 0))
80105ca6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ca9:	6a 04                	push   $0x4
80105cab:	50                   	push   %eax
80105cac:	6a 00                	push   $0x0
80105cae:	e8 3d f1 ff ff       	call   80104df0 <argptr>
80105cb3:	83 c4 10             	add    $0x10,%esp
80105cb6:	85 c0                	test   %eax,%eax
80105cb8:	78 2e                	js     80105ce8 <sys_kthread_create+0x48>
80105cba:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cbd:	83 ec 04             	sub    $0x4,%esp
80105cc0:	6a 04                	push   $0x4
80105cc2:	50                   	push   %eax
80105cc3:	6a 01                	push   $0x1
80105cc5:	e8 26 f1 ff ff       	call   80104df0 <argptr>
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	85 c0                	test   %eax,%eax
80105ccf:	78 17                	js     80105ce8 <sys_kthread_create+0x48>
    return -1;
  return kthread_create(start_func,stack);
80105cd1:	83 ec 08             	sub    $0x8,%esp
80105cd4:	ff 75 f4             	pushl  -0xc(%ebp)
80105cd7:	ff 75 f0             	pushl  -0x10(%ebp)
80105cda:	e8 31 e7 ff ff       	call   80104410 <kthread_create>
80105cdf:	83 c4 10             	add    $0x10,%esp
}
80105ce2:	c9                   	leave  
80105ce3:	c3                   	ret    
80105ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ce8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ced:	c9                   	leave  
80105cee:	c3                   	ret    
80105cef:	90                   	nop

80105cf0 <sys_kthread_id>:

int
sys_kthread_id(void)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
  return kthread_id();
}
80105cf3:	5d                   	pop    %ebp
  return kthread_id();
80105cf4:	e9 47 e8 ff ff       	jmp    80104540 <kthread_id>
80105cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d00 <sys_kthread_join>:

int
sys_kthread_join(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	83 ec 20             	sub    $0x20,%esp
  int n;

  if(argint(0, &n) < 0)
80105d06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d09:	50                   	push   %eax
80105d0a:	6a 00                	push   $0x0
80105d0c:	e8 8f f0 ff ff       	call   80104da0 <argint>
80105d11:	83 c4 10             	add    $0x10,%esp
80105d14:	85 c0                	test   %eax,%eax
80105d16:	78 18                	js     80105d30 <sys_kthread_join+0x30>
    return -1;
  return kthread_join(n);
80105d18:	83 ec 0c             	sub    $0xc,%esp
80105d1b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d1e:	e8 ed e8 ff ff       	call   80104610 <kthread_join>
80105d23:	83 c4 10             	add    $0x10,%esp
}
80105d26:	c9                   	leave  
80105d27:	c3                   	ret    
80105d28:	90                   	nop
80105d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d35:	c9                   	leave  
80105d36:	c3                   	ret    

80105d37 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d37:	1e                   	push   %ds
  pushl %es
80105d38:	06                   	push   %es
  pushl %fs
80105d39:	0f a0                	push   %fs
  pushl %gs
80105d3b:	0f a8                	push   %gs
  pushal
80105d3d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105d3e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d42:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d44:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d46:	54                   	push   %esp
  call trap
80105d47:	e8 c4 00 00 00       	call   80105e10 <trap>
  addl $4, %esp
80105d4c:	83 c4 04             	add    $0x4,%esp

80105d4f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d4f:	61                   	popa   
  popl %gs
80105d50:	0f a9                	pop    %gs
  popl %fs
80105d52:	0f a1                	pop    %fs
  popl %es
80105d54:	07                   	pop    %es
  popl %ds
80105d55:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d56:	83 c4 08             	add    $0x8,%esp
  iret
80105d59:	cf                   	iret   
80105d5a:	66 90                	xchg   %ax,%ax
80105d5c:	66 90                	xchg   %ax,%ax
80105d5e:	66 90                	xchg   %ax,%ax

80105d60 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d60:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105d61:	31 c0                	xor    %eax,%eax
{
80105d63:	89 e5                	mov    %esp,%ebp
80105d65:	83 ec 08             	sub    $0x8,%esp
80105d68:	90                   	nop
80105d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d70:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80105d77:	c7 04 c5 c2 e9 11 80 	movl   $0x8e000008,-0x7fee163e(,%eax,8)
80105d7e:	08 00 00 8e 
80105d82:	66 89 14 c5 c0 e9 11 	mov    %dx,-0x7fee1640(,%eax,8)
80105d89:	80 
80105d8a:	c1 ea 10             	shr    $0x10,%edx
80105d8d:	66 89 14 c5 c6 e9 11 	mov    %dx,-0x7fee163a(,%eax,8)
80105d94:	80 
  for(i = 0; i < 256; i++)
80105d95:	83 c0 01             	add    $0x1,%eax
80105d98:	3d 00 01 00 00       	cmp    $0x100,%eax
80105d9d:	75 d1                	jne    80105d70 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d9f:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
80105da4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105da7:	c7 05 c2 eb 11 80 08 	movl   $0xef000008,0x8011ebc2
80105dae:	00 00 ef 
  initlock(&tickslock, "time");
80105db1:	68 29 7f 10 80       	push   $0x80107f29
80105db6:	68 80 e9 11 80       	push   $0x8011e980
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105dbb:	66 a3 c0 eb 11 80    	mov    %ax,0x8011ebc0
80105dc1:	c1 e8 10             	shr    $0x10,%eax
80105dc4:	66 a3 c6 eb 11 80    	mov    %ax,0x8011ebc6
  initlock(&tickslock, "time");
80105dca:	e8 81 ea ff ff       	call   80104850 <initlock>
}
80105dcf:	83 c4 10             	add    $0x10,%esp
80105dd2:	c9                   	leave  
80105dd3:	c3                   	ret    
80105dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105de0 <idtinit>:

void
idtinit(void)
{
80105de0:	55                   	push   %ebp
  pd[0] = size-1;
80105de1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105de6:	89 e5                	mov    %esp,%ebp
80105de8:	83 ec 10             	sub    $0x10,%esp
80105deb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105def:	b8 c0 e9 11 80       	mov    $0x8011e9c0,%eax
80105df4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105df8:	c1 e8 10             	shr    $0x10,%eax
80105dfb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105dff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105e02:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105e05:	c9                   	leave  
80105e06:	c3                   	ret    
80105e07:	89 f6                	mov    %esi,%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e10 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	57                   	push   %edi
80105e14:	56                   	push   %esi
80105e15:	53                   	push   %ebx
80105e16:	83 ec 1c             	sub    $0x1c,%esp
80105e19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105e1c:	8b 43 30             	mov    0x30(%ebx),%eax
80105e1f:	83 f8 40             	cmp    $0x40,%eax
80105e22:	0f 84 c0 00 00 00    	je     80105ee8 <trap+0xd8>
    if(mythread()->exitRequest)
      kthread_exit();
    return;
  }

  switch(tf->trapno){
80105e28:	83 e8 20             	sub    $0x20,%eax
80105e2b:	83 f8 1f             	cmp    $0x1f,%eax
80105e2e:	0f 87 dc 01 00 00    	ja     80106010 <trap+0x200>
80105e34:	ff 24 85 d0 7f 10 80 	jmp    *-0x7fef8030(,%eax,4)
80105e3b:	90                   	nop
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105e40:	e8 fb da ff ff       	call   80103940 <cpuid>
80105e45:	85 c0                	test   %eax,%eax
80105e47:	0f 84 ab 02 00 00    	je     801060f8 <trap+0x2e8>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105e4d:	e8 de c9 ff ff       	call   80102830 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e52:	e8 09 db ff ff       	call   80103960 <myproc>
80105e57:	85 c0                	test   %eax,%eax
80105e59:	74 1d                	je     80105e78 <trap+0x68>
80105e5b:	e8 00 db ff ff       	call   80103960 <myproc>
80105e60:	8b 48 14             	mov    0x14(%eax),%ecx
80105e63:	85 c9                	test   %ecx,%ecx
80105e65:	74 11                	je     80105e78 <trap+0x68>
80105e67:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e6b:	83 e0 03             	and    $0x3,%eax
80105e6e:	66 83 f8 03          	cmp    $0x3,%ax
80105e72:	0f 84 60 02 00 00    	je     801060d8 <trap+0x2c8>
    exit();
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e78:	e8 e3 da ff ff       	call   80103960 <myproc>
80105e7d:	85 c0                	test   %eax,%eax
80105e7f:	74 1d                	je     80105e9e <trap+0x8e>
80105e81:	e8 da da ff ff       	call   80103960 <myproc>
80105e86:	8b 50 14             	mov    0x14(%eax),%edx
80105e89:	85 d2                	test   %edx,%edx
80105e8b:	74 11                	je     80105e9e <trap+0x8e>
80105e8d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e91:	83 e0 03             	and    $0x3,%eax
80105e94:	66 83 f8 03          	cmp    $0x3,%ax
80105e98:	0f 84 4a 02 00 00    	je     801060e8 <trap+0x2d8>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(mythread() && mythread()->state == RUNNING &&
80105e9e:	e8 ed da ff ff       	call   80103990 <mythread>
80105ea3:	85 c0                	test   %eax,%eax
80105ea5:	74 0f                	je     80105eb6 <trap+0xa6>
80105ea7:	e8 e4 da ff ff       	call   80103990 <mythread>
80105eac:	83 78 08 03          	cmpl   $0x3,0x8(%eax)
80105eb0:	0f 84 8a 00 00 00    	je     80105f40 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eb6:	e8 a5 da ff ff       	call   80103960 <myproc>
80105ebb:	85 c0                	test   %eax,%eax
80105ebd:	74 1d                	je     80105edc <trap+0xcc>
80105ebf:	e8 9c da ff ff       	call   80103960 <myproc>
80105ec4:	8b 40 14             	mov    0x14(%eax),%eax
80105ec7:	85 c0                	test   %eax,%eax
80105ec9:	74 11                	je     80105edc <trap+0xcc>
80105ecb:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105ecf:	83 e0 03             	and    $0x3,%eax
80105ed2:	66 83 f8 03          	cmp    $0x3,%ax
80105ed6:	0f 84 ec 01 00 00    	je     801060c8 <trap+0x2b8>
    exit();
}
80105edc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105edf:	5b                   	pop    %ebx
80105ee0:	5e                   	pop    %esi
80105ee1:	5f                   	pop    %edi
80105ee2:	5d                   	pop    %ebp
80105ee3:	c3                   	ret    
80105ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105ee8:	e8 73 da ff ff       	call   80103960 <myproc>
80105eed:	8b 40 14             	mov    0x14(%eax),%eax
80105ef0:	85 c0                	test   %eax,%eax
80105ef2:	0f 85 08 01 00 00    	jne    80106000 <trap+0x1f0>
    if(mythread()->exitRequest)
80105ef8:	e8 93 da ff ff       	call   80103990 <mythread>
80105efd:	8b 78 20             	mov    0x20(%eax),%edi
80105f00:	85 ff                	test   %edi,%edi
80105f02:	0f 85 e8 00 00 00    	jne    80105ff0 <trap+0x1e0>
    mythread()->tf = tf;
80105f08:	e8 83 da ff ff       	call   80103990 <mythread>
80105f0d:	89 58 14             	mov    %ebx,0x14(%eax)
    syscall();
80105f10:	e8 7b ef ff ff       	call   80104e90 <syscall>
    if(myproc()->killed)
80105f15:	e8 46 da ff ff       	call   80103960 <myproc>
80105f1a:	8b 70 14             	mov    0x14(%eax),%esi
80105f1d:	85 f6                	test   %esi,%esi
80105f1f:	0f 85 bb 00 00 00    	jne    80105fe0 <trap+0x1d0>
    if(mythread()->exitRequest)
80105f25:	e8 66 da ff ff       	call   80103990 <mythread>
80105f2a:	8b 58 20             	mov    0x20(%eax),%ebx
80105f2d:	85 db                	test   %ebx,%ebx
80105f2f:	74 ab                	je     80105edc <trap+0xcc>
}
80105f31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f34:	5b                   	pop    %ebx
80105f35:	5e                   	pop    %esi
80105f36:	5f                   	pop    %edi
80105f37:	5d                   	pop    %ebp
      kthread_exit();
80105f38:	e9 13 e6 ff ff       	jmp    80104550 <kthread_exit>
80105f3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(mythread() && mythread()->state == RUNNING &&
80105f40:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105f44:	0f 85 6c ff ff ff    	jne    80105eb6 <trap+0xa6>
    yield();
80105f4a:	e8 51 e0 ff ff       	call   80103fa0 <yield>
80105f4f:	e9 62 ff ff ff       	jmp    80105eb6 <trap+0xa6>
80105f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105f58:	e8 93 c7 ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80105f5d:	e8 ce c8 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f62:	e8 f9 d9 ff ff       	call   80103960 <myproc>
80105f67:	85 c0                	test   %eax,%eax
80105f69:	0f 85 ec fe ff ff    	jne    80105e5b <trap+0x4b>
80105f6f:	e9 04 ff ff ff       	jmp    80105e78 <trap+0x68>
80105f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105f78:	e8 53 03 00 00       	call   801062d0 <uartintr>
    lapiceoi();
80105f7d:	e8 ae c8 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f82:	e8 d9 d9 ff ff       	call   80103960 <myproc>
80105f87:	85 c0                	test   %eax,%eax
80105f89:	0f 85 cc fe ff ff    	jne    80105e5b <trap+0x4b>
80105f8f:	e9 e4 fe ff ff       	jmp    80105e78 <trap+0x68>
80105f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f98:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105f9c:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f9f:	e8 9c d9 ff ff       	call   80103940 <cpuid>
80105fa4:	57                   	push   %edi
80105fa5:	56                   	push   %esi
80105fa6:	50                   	push   %eax
80105fa7:	68 34 7f 10 80       	push   $0x80107f34
80105fac:	e8 af a6 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105fb1:	e8 7a c8 ff ff       	call   80102830 <lapiceoi>
    break;
80105fb6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fb9:	e8 a2 d9 ff ff       	call   80103960 <myproc>
80105fbe:	85 c0                	test   %eax,%eax
80105fc0:	0f 85 95 fe ff ff    	jne    80105e5b <trap+0x4b>
80105fc6:	e9 ad fe ff ff       	jmp    80105e78 <trap+0x68>
80105fcb:	90                   	nop
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105fd0:	e8 8b c1 ff ff       	call   80102160 <ideintr>
80105fd5:	e9 73 fe ff ff       	jmp    80105e4d <trap+0x3d>
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105fe0:	e8 7b de ff ff       	call   80103e60 <exit>
80105fe5:	e9 3b ff ff ff       	jmp    80105f25 <trap+0x115>
80105fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kthread_exit();
80105ff0:	e8 5b e5 ff ff       	call   80104550 <kthread_exit>
80105ff5:	e9 0e ff ff ff       	jmp    80105f08 <trap+0xf8>
80105ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106000:	e8 5b de ff ff       	call   80103e60 <exit>
80106005:	e9 ee fe ff ff       	jmp    80105ef8 <trap+0xe8>
8010600a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106010:	e8 4b d9 ff ff       	call   80103960 <myproc>
80106015:	85 c0                	test   %eax,%eax
80106017:	8b 7b 38             	mov    0x38(%ebx),%edi
8010601a:	0f 84 0c 01 00 00    	je     8010612c <trap+0x31c>
80106020:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106024:	0f 84 02 01 00 00    	je     8010612c <trap+0x31c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010602a:	0f 20 d1             	mov    %cr2,%ecx
8010602d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106030:	e8 0b d9 ff ff       	call   80103940 <cpuid>
80106035:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106038:	8b 43 34             	mov    0x34(%ebx),%eax
8010603b:	8b 73 30             	mov    0x30(%ebx),%esi
8010603e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106041:	e8 1a d9 ff ff       	call   80103960 <myproc>
80106046:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106049:	e8 12 d9 ff ff       	call   80103960 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010604e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106051:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106054:	51                   	push   %ecx
80106055:	57                   	push   %edi
80106056:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106057:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010605a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010605d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010605e:	83 c2 5c             	add    $0x5c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106061:	52                   	push   %edx
80106062:	ff 70 0c             	pushl  0xc(%eax)
80106065:	68 8c 7f 10 80       	push   $0x80107f8c
8010606a:	e8 f1 a5 ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
8010606f:	83 c4 20             	add    $0x20,%esp
80106072:	e8 e9 d8 ff ff       	call   80103960 <myproc>
80106077:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    for(t = myproc()->threads ; t < &myproc()->threads[NTHREAD] ; t++){
8010607e:	e8 dd d8 ff ff       	call   80103960 <myproc>
80106083:	8b 70 6c             	mov    0x6c(%eax),%esi
80106086:	eb 18                	jmp    801060a0 <trap+0x290>
80106088:	90                   	nop
80106089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(t->state == SLEEPING)
80106090:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
80106094:	75 07                	jne    8010609d <trap+0x28d>
        t->state = RUNNABLE;
80106096:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
    for(t = myproc()->threads ; t < &myproc()->threads[NTHREAD] ; t++){
8010609d:	83 c6 24             	add    $0x24,%esi
801060a0:	e8 bb d8 ff ff       	call   80103960 <myproc>
801060a5:	8b 40 6c             	mov    0x6c(%eax),%eax
801060a8:	05 40 02 00 00       	add    $0x240,%eax
801060ad:	39 c6                	cmp    %eax,%esi
801060af:	72 df                	jb     80106090 <trap+0x280>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801060b1:	e8 aa d8 ff ff       	call   80103960 <myproc>
801060b6:	85 c0                	test   %eax,%eax
801060b8:	0f 85 9d fd ff ff    	jne    80105e5b <trap+0x4b>
801060be:	e9 b5 fd ff ff       	jmp    80105e78 <trap+0x68>
801060c3:	90                   	nop
801060c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
801060c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060cb:	5b                   	pop    %ebx
801060cc:	5e                   	pop    %esi
801060cd:	5f                   	pop    %edi
801060ce:	5d                   	pop    %ebp
    exit();
801060cf:	e9 8c dd ff ff       	jmp    80103e60 <exit>
801060d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
801060d8:	e8 83 dd ff ff       	call   80103e60 <exit>
801060dd:	e9 96 fd ff ff       	jmp    80105e78 <trap+0x68>
801060e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801060e8:	e8 73 dd ff ff       	call   80103e60 <exit>
801060ed:	e9 ac fd ff ff       	jmp    80105e9e <trap+0x8e>
801060f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801060f8:	83 ec 0c             	sub    $0xc,%esp
801060fb:	68 80 e9 11 80       	push   $0x8011e980
80106100:	e8 8b e8 ff ff       	call   80104990 <acquire>
      wakeup(&ticks);
80106105:	c7 04 24 c0 f1 11 80 	movl   $0x8011f1c0,(%esp)
      ticks++;
8010610c:	83 05 c0 f1 11 80 01 	addl   $0x1,0x8011f1c0
      wakeup(&ticks);
80106113:	e8 98 df ff ff       	call   801040b0 <wakeup>
      release(&tickslock);
80106118:	c7 04 24 80 e9 11 80 	movl   $0x8011e980,(%esp)
8010611f:	e8 2c e9 ff ff       	call   80104a50 <release>
80106124:	83 c4 10             	add    $0x10,%esp
80106127:	e9 21 fd ff ff       	jmp    80105e4d <trap+0x3d>
8010612c:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010612f:	e8 0c d8 ff ff       	call   80103940 <cpuid>
80106134:	83 ec 0c             	sub    $0xc,%esp
80106137:	56                   	push   %esi
80106138:	57                   	push   %edi
80106139:	50                   	push   %eax
8010613a:	ff 73 30             	pushl  0x30(%ebx)
8010613d:	68 58 7f 10 80       	push   $0x80107f58
80106142:	e8 19 a5 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106147:	83 c4 14             	add    $0x14,%esp
8010614a:	68 2e 7f 10 80       	push   $0x80107f2e
8010614f:	e8 3c a2 ff ff       	call   80100390 <panic>
80106154:	66 90                	xchg   %ax,%ax
80106156:	66 90                	xchg   %ax,%ax
80106158:	66 90                	xchg   %ax,%ax
8010615a:	66 90                	xchg   %ax,%ax
8010615c:	66 90                	xchg   %ax,%ax
8010615e:	66 90                	xchg   %ax,%ax

80106160 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106160:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
80106165:	55                   	push   %ebp
80106166:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106168:	85 c0                	test   %eax,%eax
8010616a:	74 1c                	je     80106188 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010616c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106171:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106172:	a8 01                	test   $0x1,%al
80106174:	74 12                	je     80106188 <uartgetc+0x28>
80106176:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010617b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010617c:	0f b6 c0             	movzbl %al,%eax
}
8010617f:	5d                   	pop    %ebp
80106180:	c3                   	ret    
80106181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010618d:	5d                   	pop    %ebp
8010618e:	c3                   	ret    
8010618f:	90                   	nop

80106190 <uartputc.part.0>:
uartputc(int c)
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
80106193:	57                   	push   %edi
80106194:	56                   	push   %esi
80106195:	53                   	push   %ebx
80106196:	89 c7                	mov    %eax,%edi
80106198:	bb 80 00 00 00       	mov    $0x80,%ebx
8010619d:	be fd 03 00 00       	mov    $0x3fd,%esi
801061a2:	83 ec 0c             	sub    $0xc,%esp
801061a5:	eb 1b                	jmp    801061c2 <uartputc.part.0+0x32>
801061a7:	89 f6                	mov    %esi,%esi
801061a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801061b0:	83 ec 0c             	sub    $0xc,%esp
801061b3:	6a 0a                	push   $0xa
801061b5:	e8 96 c6 ff ff       	call   80102850 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061ba:	83 c4 10             	add    $0x10,%esp
801061bd:	83 eb 01             	sub    $0x1,%ebx
801061c0:	74 07                	je     801061c9 <uartputc.part.0+0x39>
801061c2:	89 f2                	mov    %esi,%edx
801061c4:	ec                   	in     (%dx),%al
801061c5:	a8 20                	test   $0x20,%al
801061c7:	74 e7                	je     801061b0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801061c9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061ce:	89 f8                	mov    %edi,%eax
801061d0:	ee                   	out    %al,(%dx)
}
801061d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061d4:	5b                   	pop    %ebx
801061d5:	5e                   	pop    %esi
801061d6:	5f                   	pop    %edi
801061d7:	5d                   	pop    %ebp
801061d8:	c3                   	ret    
801061d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061e0 <uartinit>:
{
801061e0:	55                   	push   %ebp
801061e1:	31 c9                	xor    %ecx,%ecx
801061e3:	89 c8                	mov    %ecx,%eax
801061e5:	89 e5                	mov    %esp,%ebp
801061e7:	57                   	push   %edi
801061e8:	56                   	push   %esi
801061e9:	53                   	push   %ebx
801061ea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801061ef:	89 da                	mov    %ebx,%edx
801061f1:	83 ec 0c             	sub    $0xc,%esp
801061f4:	ee                   	out    %al,(%dx)
801061f5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801061fa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801061ff:	89 fa                	mov    %edi,%edx
80106201:	ee                   	out    %al,(%dx)
80106202:	b8 0c 00 00 00       	mov    $0xc,%eax
80106207:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010620c:	ee                   	out    %al,(%dx)
8010620d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106212:	89 c8                	mov    %ecx,%eax
80106214:	89 f2                	mov    %esi,%edx
80106216:	ee                   	out    %al,(%dx)
80106217:	b8 03 00 00 00       	mov    $0x3,%eax
8010621c:	89 fa                	mov    %edi,%edx
8010621e:	ee                   	out    %al,(%dx)
8010621f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106224:	89 c8                	mov    %ecx,%eax
80106226:	ee                   	out    %al,(%dx)
80106227:	b8 01 00 00 00       	mov    $0x1,%eax
8010622c:	89 f2                	mov    %esi,%edx
8010622e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010622f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106234:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106235:	3c ff                	cmp    $0xff,%al
80106237:	74 5a                	je     80106293 <uartinit+0xb3>
  uart = 1;
80106239:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106240:	00 00 00 
80106243:	89 da                	mov    %ebx,%edx
80106245:	ec                   	in     (%dx),%al
80106246:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010624b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010624c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010624f:	bb 50 80 10 80       	mov    $0x80108050,%ebx
  ioapicenable(IRQ_COM1, 0);
80106254:	6a 00                	push   $0x0
80106256:	6a 04                	push   $0x4
80106258:	e8 53 c1 ff ff       	call   801023b0 <ioapicenable>
8010625d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106260:	b8 78 00 00 00       	mov    $0x78,%eax
80106265:	eb 13                	jmp    8010627a <uartinit+0x9a>
80106267:	89 f6                	mov    %esi,%esi
80106269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106270:	83 c3 01             	add    $0x1,%ebx
80106273:	0f be 03             	movsbl (%ebx),%eax
80106276:	84 c0                	test   %al,%al
80106278:	74 19                	je     80106293 <uartinit+0xb3>
  if(!uart)
8010627a:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80106280:	85 d2                	test   %edx,%edx
80106282:	74 ec                	je     80106270 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106284:	83 c3 01             	add    $0x1,%ebx
80106287:	e8 04 ff ff ff       	call   80106190 <uartputc.part.0>
8010628c:	0f be 03             	movsbl (%ebx),%eax
8010628f:	84 c0                	test   %al,%al
80106291:	75 e7                	jne    8010627a <uartinit+0x9a>
}
80106293:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106296:	5b                   	pop    %ebx
80106297:	5e                   	pop    %esi
80106298:	5f                   	pop    %edi
80106299:	5d                   	pop    %ebp
8010629a:	c3                   	ret    
8010629b:	90                   	nop
8010629c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062a0 <uartputc>:
  if(!uart)
801062a0:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
801062a6:	55                   	push   %ebp
801062a7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801062a9:	85 d2                	test   %edx,%edx
{
801062ab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801062ae:	74 10                	je     801062c0 <uartputc+0x20>
}
801062b0:	5d                   	pop    %ebp
801062b1:	e9 da fe ff ff       	jmp    80106190 <uartputc.part.0>
801062b6:	8d 76 00             	lea    0x0(%esi),%esi
801062b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801062c0:	5d                   	pop    %ebp
801062c1:	c3                   	ret    
801062c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062d0 <uartintr>:

void
uartintr(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801062d6:	68 60 61 10 80       	push   $0x80106160
801062db:	e8 30 a5 ff ff       	call   80100810 <consoleintr>
}
801062e0:	83 c4 10             	add    $0x10,%esp
801062e3:	c9                   	leave  
801062e4:	c3                   	ret    

801062e5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $0
801062e7:	6a 00                	push   $0x0
  jmp alltraps
801062e9:	e9 49 fa ff ff       	jmp    80105d37 <alltraps>

801062ee <vector1>:
.globl vector1
vector1:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $1
801062f0:	6a 01                	push   $0x1
  jmp alltraps
801062f2:	e9 40 fa ff ff       	jmp    80105d37 <alltraps>

801062f7 <vector2>:
.globl vector2
vector2:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $2
801062f9:	6a 02                	push   $0x2
  jmp alltraps
801062fb:	e9 37 fa ff ff       	jmp    80105d37 <alltraps>

80106300 <vector3>:
.globl vector3
vector3:
  pushl $0
80106300:	6a 00                	push   $0x0
  pushl $3
80106302:	6a 03                	push   $0x3
  jmp alltraps
80106304:	e9 2e fa ff ff       	jmp    80105d37 <alltraps>

80106309 <vector4>:
.globl vector4
vector4:
  pushl $0
80106309:	6a 00                	push   $0x0
  pushl $4
8010630b:	6a 04                	push   $0x4
  jmp alltraps
8010630d:	e9 25 fa ff ff       	jmp    80105d37 <alltraps>

80106312 <vector5>:
.globl vector5
vector5:
  pushl $0
80106312:	6a 00                	push   $0x0
  pushl $5
80106314:	6a 05                	push   $0x5
  jmp alltraps
80106316:	e9 1c fa ff ff       	jmp    80105d37 <alltraps>

8010631b <vector6>:
.globl vector6
vector6:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $6
8010631d:	6a 06                	push   $0x6
  jmp alltraps
8010631f:	e9 13 fa ff ff       	jmp    80105d37 <alltraps>

80106324 <vector7>:
.globl vector7
vector7:
  pushl $0
80106324:	6a 00                	push   $0x0
  pushl $7
80106326:	6a 07                	push   $0x7
  jmp alltraps
80106328:	e9 0a fa ff ff       	jmp    80105d37 <alltraps>

8010632d <vector8>:
.globl vector8
vector8:
  pushl $8
8010632d:	6a 08                	push   $0x8
  jmp alltraps
8010632f:	e9 03 fa ff ff       	jmp    80105d37 <alltraps>

80106334 <vector9>:
.globl vector9
vector9:
  pushl $0
80106334:	6a 00                	push   $0x0
  pushl $9
80106336:	6a 09                	push   $0x9
  jmp alltraps
80106338:	e9 fa f9 ff ff       	jmp    80105d37 <alltraps>

8010633d <vector10>:
.globl vector10
vector10:
  pushl $10
8010633d:	6a 0a                	push   $0xa
  jmp alltraps
8010633f:	e9 f3 f9 ff ff       	jmp    80105d37 <alltraps>

80106344 <vector11>:
.globl vector11
vector11:
  pushl $11
80106344:	6a 0b                	push   $0xb
  jmp alltraps
80106346:	e9 ec f9 ff ff       	jmp    80105d37 <alltraps>

8010634b <vector12>:
.globl vector12
vector12:
  pushl $12
8010634b:	6a 0c                	push   $0xc
  jmp alltraps
8010634d:	e9 e5 f9 ff ff       	jmp    80105d37 <alltraps>

80106352 <vector13>:
.globl vector13
vector13:
  pushl $13
80106352:	6a 0d                	push   $0xd
  jmp alltraps
80106354:	e9 de f9 ff ff       	jmp    80105d37 <alltraps>

80106359 <vector14>:
.globl vector14
vector14:
  pushl $14
80106359:	6a 0e                	push   $0xe
  jmp alltraps
8010635b:	e9 d7 f9 ff ff       	jmp    80105d37 <alltraps>

80106360 <vector15>:
.globl vector15
vector15:
  pushl $0
80106360:	6a 00                	push   $0x0
  pushl $15
80106362:	6a 0f                	push   $0xf
  jmp alltraps
80106364:	e9 ce f9 ff ff       	jmp    80105d37 <alltraps>

80106369 <vector16>:
.globl vector16
vector16:
  pushl $0
80106369:	6a 00                	push   $0x0
  pushl $16
8010636b:	6a 10                	push   $0x10
  jmp alltraps
8010636d:	e9 c5 f9 ff ff       	jmp    80105d37 <alltraps>

80106372 <vector17>:
.globl vector17
vector17:
  pushl $17
80106372:	6a 11                	push   $0x11
  jmp alltraps
80106374:	e9 be f9 ff ff       	jmp    80105d37 <alltraps>

80106379 <vector18>:
.globl vector18
vector18:
  pushl $0
80106379:	6a 00                	push   $0x0
  pushl $18
8010637b:	6a 12                	push   $0x12
  jmp alltraps
8010637d:	e9 b5 f9 ff ff       	jmp    80105d37 <alltraps>

80106382 <vector19>:
.globl vector19
vector19:
  pushl $0
80106382:	6a 00                	push   $0x0
  pushl $19
80106384:	6a 13                	push   $0x13
  jmp alltraps
80106386:	e9 ac f9 ff ff       	jmp    80105d37 <alltraps>

8010638b <vector20>:
.globl vector20
vector20:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $20
8010638d:	6a 14                	push   $0x14
  jmp alltraps
8010638f:	e9 a3 f9 ff ff       	jmp    80105d37 <alltraps>

80106394 <vector21>:
.globl vector21
vector21:
  pushl $0
80106394:	6a 00                	push   $0x0
  pushl $21
80106396:	6a 15                	push   $0x15
  jmp alltraps
80106398:	e9 9a f9 ff ff       	jmp    80105d37 <alltraps>

8010639d <vector22>:
.globl vector22
vector22:
  pushl $0
8010639d:	6a 00                	push   $0x0
  pushl $22
8010639f:	6a 16                	push   $0x16
  jmp alltraps
801063a1:	e9 91 f9 ff ff       	jmp    80105d37 <alltraps>

801063a6 <vector23>:
.globl vector23
vector23:
  pushl $0
801063a6:	6a 00                	push   $0x0
  pushl $23
801063a8:	6a 17                	push   $0x17
  jmp alltraps
801063aa:	e9 88 f9 ff ff       	jmp    80105d37 <alltraps>

801063af <vector24>:
.globl vector24
vector24:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $24
801063b1:	6a 18                	push   $0x18
  jmp alltraps
801063b3:	e9 7f f9 ff ff       	jmp    80105d37 <alltraps>

801063b8 <vector25>:
.globl vector25
vector25:
  pushl $0
801063b8:	6a 00                	push   $0x0
  pushl $25
801063ba:	6a 19                	push   $0x19
  jmp alltraps
801063bc:	e9 76 f9 ff ff       	jmp    80105d37 <alltraps>

801063c1 <vector26>:
.globl vector26
vector26:
  pushl $0
801063c1:	6a 00                	push   $0x0
  pushl $26
801063c3:	6a 1a                	push   $0x1a
  jmp alltraps
801063c5:	e9 6d f9 ff ff       	jmp    80105d37 <alltraps>

801063ca <vector27>:
.globl vector27
vector27:
  pushl $0
801063ca:	6a 00                	push   $0x0
  pushl $27
801063cc:	6a 1b                	push   $0x1b
  jmp alltraps
801063ce:	e9 64 f9 ff ff       	jmp    80105d37 <alltraps>

801063d3 <vector28>:
.globl vector28
vector28:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $28
801063d5:	6a 1c                	push   $0x1c
  jmp alltraps
801063d7:	e9 5b f9 ff ff       	jmp    80105d37 <alltraps>

801063dc <vector29>:
.globl vector29
vector29:
  pushl $0
801063dc:	6a 00                	push   $0x0
  pushl $29
801063de:	6a 1d                	push   $0x1d
  jmp alltraps
801063e0:	e9 52 f9 ff ff       	jmp    80105d37 <alltraps>

801063e5 <vector30>:
.globl vector30
vector30:
  pushl $0
801063e5:	6a 00                	push   $0x0
  pushl $30
801063e7:	6a 1e                	push   $0x1e
  jmp alltraps
801063e9:	e9 49 f9 ff ff       	jmp    80105d37 <alltraps>

801063ee <vector31>:
.globl vector31
vector31:
  pushl $0
801063ee:	6a 00                	push   $0x0
  pushl $31
801063f0:	6a 1f                	push   $0x1f
  jmp alltraps
801063f2:	e9 40 f9 ff ff       	jmp    80105d37 <alltraps>

801063f7 <vector32>:
.globl vector32
vector32:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $32
801063f9:	6a 20                	push   $0x20
  jmp alltraps
801063fb:	e9 37 f9 ff ff       	jmp    80105d37 <alltraps>

80106400 <vector33>:
.globl vector33
vector33:
  pushl $0
80106400:	6a 00                	push   $0x0
  pushl $33
80106402:	6a 21                	push   $0x21
  jmp alltraps
80106404:	e9 2e f9 ff ff       	jmp    80105d37 <alltraps>

80106409 <vector34>:
.globl vector34
vector34:
  pushl $0
80106409:	6a 00                	push   $0x0
  pushl $34
8010640b:	6a 22                	push   $0x22
  jmp alltraps
8010640d:	e9 25 f9 ff ff       	jmp    80105d37 <alltraps>

80106412 <vector35>:
.globl vector35
vector35:
  pushl $0
80106412:	6a 00                	push   $0x0
  pushl $35
80106414:	6a 23                	push   $0x23
  jmp alltraps
80106416:	e9 1c f9 ff ff       	jmp    80105d37 <alltraps>

8010641b <vector36>:
.globl vector36
vector36:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $36
8010641d:	6a 24                	push   $0x24
  jmp alltraps
8010641f:	e9 13 f9 ff ff       	jmp    80105d37 <alltraps>

80106424 <vector37>:
.globl vector37
vector37:
  pushl $0
80106424:	6a 00                	push   $0x0
  pushl $37
80106426:	6a 25                	push   $0x25
  jmp alltraps
80106428:	e9 0a f9 ff ff       	jmp    80105d37 <alltraps>

8010642d <vector38>:
.globl vector38
vector38:
  pushl $0
8010642d:	6a 00                	push   $0x0
  pushl $38
8010642f:	6a 26                	push   $0x26
  jmp alltraps
80106431:	e9 01 f9 ff ff       	jmp    80105d37 <alltraps>

80106436 <vector39>:
.globl vector39
vector39:
  pushl $0
80106436:	6a 00                	push   $0x0
  pushl $39
80106438:	6a 27                	push   $0x27
  jmp alltraps
8010643a:	e9 f8 f8 ff ff       	jmp    80105d37 <alltraps>

8010643f <vector40>:
.globl vector40
vector40:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $40
80106441:	6a 28                	push   $0x28
  jmp alltraps
80106443:	e9 ef f8 ff ff       	jmp    80105d37 <alltraps>

80106448 <vector41>:
.globl vector41
vector41:
  pushl $0
80106448:	6a 00                	push   $0x0
  pushl $41
8010644a:	6a 29                	push   $0x29
  jmp alltraps
8010644c:	e9 e6 f8 ff ff       	jmp    80105d37 <alltraps>

80106451 <vector42>:
.globl vector42
vector42:
  pushl $0
80106451:	6a 00                	push   $0x0
  pushl $42
80106453:	6a 2a                	push   $0x2a
  jmp alltraps
80106455:	e9 dd f8 ff ff       	jmp    80105d37 <alltraps>

8010645a <vector43>:
.globl vector43
vector43:
  pushl $0
8010645a:	6a 00                	push   $0x0
  pushl $43
8010645c:	6a 2b                	push   $0x2b
  jmp alltraps
8010645e:	e9 d4 f8 ff ff       	jmp    80105d37 <alltraps>

80106463 <vector44>:
.globl vector44
vector44:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $44
80106465:	6a 2c                	push   $0x2c
  jmp alltraps
80106467:	e9 cb f8 ff ff       	jmp    80105d37 <alltraps>

8010646c <vector45>:
.globl vector45
vector45:
  pushl $0
8010646c:	6a 00                	push   $0x0
  pushl $45
8010646e:	6a 2d                	push   $0x2d
  jmp alltraps
80106470:	e9 c2 f8 ff ff       	jmp    80105d37 <alltraps>

80106475 <vector46>:
.globl vector46
vector46:
  pushl $0
80106475:	6a 00                	push   $0x0
  pushl $46
80106477:	6a 2e                	push   $0x2e
  jmp alltraps
80106479:	e9 b9 f8 ff ff       	jmp    80105d37 <alltraps>

8010647e <vector47>:
.globl vector47
vector47:
  pushl $0
8010647e:	6a 00                	push   $0x0
  pushl $47
80106480:	6a 2f                	push   $0x2f
  jmp alltraps
80106482:	e9 b0 f8 ff ff       	jmp    80105d37 <alltraps>

80106487 <vector48>:
.globl vector48
vector48:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $48
80106489:	6a 30                	push   $0x30
  jmp alltraps
8010648b:	e9 a7 f8 ff ff       	jmp    80105d37 <alltraps>

80106490 <vector49>:
.globl vector49
vector49:
  pushl $0
80106490:	6a 00                	push   $0x0
  pushl $49
80106492:	6a 31                	push   $0x31
  jmp alltraps
80106494:	e9 9e f8 ff ff       	jmp    80105d37 <alltraps>

80106499 <vector50>:
.globl vector50
vector50:
  pushl $0
80106499:	6a 00                	push   $0x0
  pushl $50
8010649b:	6a 32                	push   $0x32
  jmp alltraps
8010649d:	e9 95 f8 ff ff       	jmp    80105d37 <alltraps>

801064a2 <vector51>:
.globl vector51
vector51:
  pushl $0
801064a2:	6a 00                	push   $0x0
  pushl $51
801064a4:	6a 33                	push   $0x33
  jmp alltraps
801064a6:	e9 8c f8 ff ff       	jmp    80105d37 <alltraps>

801064ab <vector52>:
.globl vector52
vector52:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $52
801064ad:	6a 34                	push   $0x34
  jmp alltraps
801064af:	e9 83 f8 ff ff       	jmp    80105d37 <alltraps>

801064b4 <vector53>:
.globl vector53
vector53:
  pushl $0
801064b4:	6a 00                	push   $0x0
  pushl $53
801064b6:	6a 35                	push   $0x35
  jmp alltraps
801064b8:	e9 7a f8 ff ff       	jmp    80105d37 <alltraps>

801064bd <vector54>:
.globl vector54
vector54:
  pushl $0
801064bd:	6a 00                	push   $0x0
  pushl $54
801064bf:	6a 36                	push   $0x36
  jmp alltraps
801064c1:	e9 71 f8 ff ff       	jmp    80105d37 <alltraps>

801064c6 <vector55>:
.globl vector55
vector55:
  pushl $0
801064c6:	6a 00                	push   $0x0
  pushl $55
801064c8:	6a 37                	push   $0x37
  jmp alltraps
801064ca:	e9 68 f8 ff ff       	jmp    80105d37 <alltraps>

801064cf <vector56>:
.globl vector56
vector56:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $56
801064d1:	6a 38                	push   $0x38
  jmp alltraps
801064d3:	e9 5f f8 ff ff       	jmp    80105d37 <alltraps>

801064d8 <vector57>:
.globl vector57
vector57:
  pushl $0
801064d8:	6a 00                	push   $0x0
  pushl $57
801064da:	6a 39                	push   $0x39
  jmp alltraps
801064dc:	e9 56 f8 ff ff       	jmp    80105d37 <alltraps>

801064e1 <vector58>:
.globl vector58
vector58:
  pushl $0
801064e1:	6a 00                	push   $0x0
  pushl $58
801064e3:	6a 3a                	push   $0x3a
  jmp alltraps
801064e5:	e9 4d f8 ff ff       	jmp    80105d37 <alltraps>

801064ea <vector59>:
.globl vector59
vector59:
  pushl $0
801064ea:	6a 00                	push   $0x0
  pushl $59
801064ec:	6a 3b                	push   $0x3b
  jmp alltraps
801064ee:	e9 44 f8 ff ff       	jmp    80105d37 <alltraps>

801064f3 <vector60>:
.globl vector60
vector60:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $60
801064f5:	6a 3c                	push   $0x3c
  jmp alltraps
801064f7:	e9 3b f8 ff ff       	jmp    80105d37 <alltraps>

801064fc <vector61>:
.globl vector61
vector61:
  pushl $0
801064fc:	6a 00                	push   $0x0
  pushl $61
801064fe:	6a 3d                	push   $0x3d
  jmp alltraps
80106500:	e9 32 f8 ff ff       	jmp    80105d37 <alltraps>

80106505 <vector62>:
.globl vector62
vector62:
  pushl $0
80106505:	6a 00                	push   $0x0
  pushl $62
80106507:	6a 3e                	push   $0x3e
  jmp alltraps
80106509:	e9 29 f8 ff ff       	jmp    80105d37 <alltraps>

8010650e <vector63>:
.globl vector63
vector63:
  pushl $0
8010650e:	6a 00                	push   $0x0
  pushl $63
80106510:	6a 3f                	push   $0x3f
  jmp alltraps
80106512:	e9 20 f8 ff ff       	jmp    80105d37 <alltraps>

80106517 <vector64>:
.globl vector64
vector64:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $64
80106519:	6a 40                	push   $0x40
  jmp alltraps
8010651b:	e9 17 f8 ff ff       	jmp    80105d37 <alltraps>

80106520 <vector65>:
.globl vector65
vector65:
  pushl $0
80106520:	6a 00                	push   $0x0
  pushl $65
80106522:	6a 41                	push   $0x41
  jmp alltraps
80106524:	e9 0e f8 ff ff       	jmp    80105d37 <alltraps>

80106529 <vector66>:
.globl vector66
vector66:
  pushl $0
80106529:	6a 00                	push   $0x0
  pushl $66
8010652b:	6a 42                	push   $0x42
  jmp alltraps
8010652d:	e9 05 f8 ff ff       	jmp    80105d37 <alltraps>

80106532 <vector67>:
.globl vector67
vector67:
  pushl $0
80106532:	6a 00                	push   $0x0
  pushl $67
80106534:	6a 43                	push   $0x43
  jmp alltraps
80106536:	e9 fc f7 ff ff       	jmp    80105d37 <alltraps>

8010653b <vector68>:
.globl vector68
vector68:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $68
8010653d:	6a 44                	push   $0x44
  jmp alltraps
8010653f:	e9 f3 f7 ff ff       	jmp    80105d37 <alltraps>

80106544 <vector69>:
.globl vector69
vector69:
  pushl $0
80106544:	6a 00                	push   $0x0
  pushl $69
80106546:	6a 45                	push   $0x45
  jmp alltraps
80106548:	e9 ea f7 ff ff       	jmp    80105d37 <alltraps>

8010654d <vector70>:
.globl vector70
vector70:
  pushl $0
8010654d:	6a 00                	push   $0x0
  pushl $70
8010654f:	6a 46                	push   $0x46
  jmp alltraps
80106551:	e9 e1 f7 ff ff       	jmp    80105d37 <alltraps>

80106556 <vector71>:
.globl vector71
vector71:
  pushl $0
80106556:	6a 00                	push   $0x0
  pushl $71
80106558:	6a 47                	push   $0x47
  jmp alltraps
8010655a:	e9 d8 f7 ff ff       	jmp    80105d37 <alltraps>

8010655f <vector72>:
.globl vector72
vector72:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $72
80106561:	6a 48                	push   $0x48
  jmp alltraps
80106563:	e9 cf f7 ff ff       	jmp    80105d37 <alltraps>

80106568 <vector73>:
.globl vector73
vector73:
  pushl $0
80106568:	6a 00                	push   $0x0
  pushl $73
8010656a:	6a 49                	push   $0x49
  jmp alltraps
8010656c:	e9 c6 f7 ff ff       	jmp    80105d37 <alltraps>

80106571 <vector74>:
.globl vector74
vector74:
  pushl $0
80106571:	6a 00                	push   $0x0
  pushl $74
80106573:	6a 4a                	push   $0x4a
  jmp alltraps
80106575:	e9 bd f7 ff ff       	jmp    80105d37 <alltraps>

8010657a <vector75>:
.globl vector75
vector75:
  pushl $0
8010657a:	6a 00                	push   $0x0
  pushl $75
8010657c:	6a 4b                	push   $0x4b
  jmp alltraps
8010657e:	e9 b4 f7 ff ff       	jmp    80105d37 <alltraps>

80106583 <vector76>:
.globl vector76
vector76:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $76
80106585:	6a 4c                	push   $0x4c
  jmp alltraps
80106587:	e9 ab f7 ff ff       	jmp    80105d37 <alltraps>

8010658c <vector77>:
.globl vector77
vector77:
  pushl $0
8010658c:	6a 00                	push   $0x0
  pushl $77
8010658e:	6a 4d                	push   $0x4d
  jmp alltraps
80106590:	e9 a2 f7 ff ff       	jmp    80105d37 <alltraps>

80106595 <vector78>:
.globl vector78
vector78:
  pushl $0
80106595:	6a 00                	push   $0x0
  pushl $78
80106597:	6a 4e                	push   $0x4e
  jmp alltraps
80106599:	e9 99 f7 ff ff       	jmp    80105d37 <alltraps>

8010659e <vector79>:
.globl vector79
vector79:
  pushl $0
8010659e:	6a 00                	push   $0x0
  pushl $79
801065a0:	6a 4f                	push   $0x4f
  jmp alltraps
801065a2:	e9 90 f7 ff ff       	jmp    80105d37 <alltraps>

801065a7 <vector80>:
.globl vector80
vector80:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $80
801065a9:	6a 50                	push   $0x50
  jmp alltraps
801065ab:	e9 87 f7 ff ff       	jmp    80105d37 <alltraps>

801065b0 <vector81>:
.globl vector81
vector81:
  pushl $0
801065b0:	6a 00                	push   $0x0
  pushl $81
801065b2:	6a 51                	push   $0x51
  jmp alltraps
801065b4:	e9 7e f7 ff ff       	jmp    80105d37 <alltraps>

801065b9 <vector82>:
.globl vector82
vector82:
  pushl $0
801065b9:	6a 00                	push   $0x0
  pushl $82
801065bb:	6a 52                	push   $0x52
  jmp alltraps
801065bd:	e9 75 f7 ff ff       	jmp    80105d37 <alltraps>

801065c2 <vector83>:
.globl vector83
vector83:
  pushl $0
801065c2:	6a 00                	push   $0x0
  pushl $83
801065c4:	6a 53                	push   $0x53
  jmp alltraps
801065c6:	e9 6c f7 ff ff       	jmp    80105d37 <alltraps>

801065cb <vector84>:
.globl vector84
vector84:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $84
801065cd:	6a 54                	push   $0x54
  jmp alltraps
801065cf:	e9 63 f7 ff ff       	jmp    80105d37 <alltraps>

801065d4 <vector85>:
.globl vector85
vector85:
  pushl $0
801065d4:	6a 00                	push   $0x0
  pushl $85
801065d6:	6a 55                	push   $0x55
  jmp alltraps
801065d8:	e9 5a f7 ff ff       	jmp    80105d37 <alltraps>

801065dd <vector86>:
.globl vector86
vector86:
  pushl $0
801065dd:	6a 00                	push   $0x0
  pushl $86
801065df:	6a 56                	push   $0x56
  jmp alltraps
801065e1:	e9 51 f7 ff ff       	jmp    80105d37 <alltraps>

801065e6 <vector87>:
.globl vector87
vector87:
  pushl $0
801065e6:	6a 00                	push   $0x0
  pushl $87
801065e8:	6a 57                	push   $0x57
  jmp alltraps
801065ea:	e9 48 f7 ff ff       	jmp    80105d37 <alltraps>

801065ef <vector88>:
.globl vector88
vector88:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $88
801065f1:	6a 58                	push   $0x58
  jmp alltraps
801065f3:	e9 3f f7 ff ff       	jmp    80105d37 <alltraps>

801065f8 <vector89>:
.globl vector89
vector89:
  pushl $0
801065f8:	6a 00                	push   $0x0
  pushl $89
801065fa:	6a 59                	push   $0x59
  jmp alltraps
801065fc:	e9 36 f7 ff ff       	jmp    80105d37 <alltraps>

80106601 <vector90>:
.globl vector90
vector90:
  pushl $0
80106601:	6a 00                	push   $0x0
  pushl $90
80106603:	6a 5a                	push   $0x5a
  jmp alltraps
80106605:	e9 2d f7 ff ff       	jmp    80105d37 <alltraps>

8010660a <vector91>:
.globl vector91
vector91:
  pushl $0
8010660a:	6a 00                	push   $0x0
  pushl $91
8010660c:	6a 5b                	push   $0x5b
  jmp alltraps
8010660e:	e9 24 f7 ff ff       	jmp    80105d37 <alltraps>

80106613 <vector92>:
.globl vector92
vector92:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $92
80106615:	6a 5c                	push   $0x5c
  jmp alltraps
80106617:	e9 1b f7 ff ff       	jmp    80105d37 <alltraps>

8010661c <vector93>:
.globl vector93
vector93:
  pushl $0
8010661c:	6a 00                	push   $0x0
  pushl $93
8010661e:	6a 5d                	push   $0x5d
  jmp alltraps
80106620:	e9 12 f7 ff ff       	jmp    80105d37 <alltraps>

80106625 <vector94>:
.globl vector94
vector94:
  pushl $0
80106625:	6a 00                	push   $0x0
  pushl $94
80106627:	6a 5e                	push   $0x5e
  jmp alltraps
80106629:	e9 09 f7 ff ff       	jmp    80105d37 <alltraps>

8010662e <vector95>:
.globl vector95
vector95:
  pushl $0
8010662e:	6a 00                	push   $0x0
  pushl $95
80106630:	6a 5f                	push   $0x5f
  jmp alltraps
80106632:	e9 00 f7 ff ff       	jmp    80105d37 <alltraps>

80106637 <vector96>:
.globl vector96
vector96:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $96
80106639:	6a 60                	push   $0x60
  jmp alltraps
8010663b:	e9 f7 f6 ff ff       	jmp    80105d37 <alltraps>

80106640 <vector97>:
.globl vector97
vector97:
  pushl $0
80106640:	6a 00                	push   $0x0
  pushl $97
80106642:	6a 61                	push   $0x61
  jmp alltraps
80106644:	e9 ee f6 ff ff       	jmp    80105d37 <alltraps>

80106649 <vector98>:
.globl vector98
vector98:
  pushl $0
80106649:	6a 00                	push   $0x0
  pushl $98
8010664b:	6a 62                	push   $0x62
  jmp alltraps
8010664d:	e9 e5 f6 ff ff       	jmp    80105d37 <alltraps>

80106652 <vector99>:
.globl vector99
vector99:
  pushl $0
80106652:	6a 00                	push   $0x0
  pushl $99
80106654:	6a 63                	push   $0x63
  jmp alltraps
80106656:	e9 dc f6 ff ff       	jmp    80105d37 <alltraps>

8010665b <vector100>:
.globl vector100
vector100:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $100
8010665d:	6a 64                	push   $0x64
  jmp alltraps
8010665f:	e9 d3 f6 ff ff       	jmp    80105d37 <alltraps>

80106664 <vector101>:
.globl vector101
vector101:
  pushl $0
80106664:	6a 00                	push   $0x0
  pushl $101
80106666:	6a 65                	push   $0x65
  jmp alltraps
80106668:	e9 ca f6 ff ff       	jmp    80105d37 <alltraps>

8010666d <vector102>:
.globl vector102
vector102:
  pushl $0
8010666d:	6a 00                	push   $0x0
  pushl $102
8010666f:	6a 66                	push   $0x66
  jmp alltraps
80106671:	e9 c1 f6 ff ff       	jmp    80105d37 <alltraps>

80106676 <vector103>:
.globl vector103
vector103:
  pushl $0
80106676:	6a 00                	push   $0x0
  pushl $103
80106678:	6a 67                	push   $0x67
  jmp alltraps
8010667a:	e9 b8 f6 ff ff       	jmp    80105d37 <alltraps>

8010667f <vector104>:
.globl vector104
vector104:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $104
80106681:	6a 68                	push   $0x68
  jmp alltraps
80106683:	e9 af f6 ff ff       	jmp    80105d37 <alltraps>

80106688 <vector105>:
.globl vector105
vector105:
  pushl $0
80106688:	6a 00                	push   $0x0
  pushl $105
8010668a:	6a 69                	push   $0x69
  jmp alltraps
8010668c:	e9 a6 f6 ff ff       	jmp    80105d37 <alltraps>

80106691 <vector106>:
.globl vector106
vector106:
  pushl $0
80106691:	6a 00                	push   $0x0
  pushl $106
80106693:	6a 6a                	push   $0x6a
  jmp alltraps
80106695:	e9 9d f6 ff ff       	jmp    80105d37 <alltraps>

8010669a <vector107>:
.globl vector107
vector107:
  pushl $0
8010669a:	6a 00                	push   $0x0
  pushl $107
8010669c:	6a 6b                	push   $0x6b
  jmp alltraps
8010669e:	e9 94 f6 ff ff       	jmp    80105d37 <alltraps>

801066a3 <vector108>:
.globl vector108
vector108:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $108
801066a5:	6a 6c                	push   $0x6c
  jmp alltraps
801066a7:	e9 8b f6 ff ff       	jmp    80105d37 <alltraps>

801066ac <vector109>:
.globl vector109
vector109:
  pushl $0
801066ac:	6a 00                	push   $0x0
  pushl $109
801066ae:	6a 6d                	push   $0x6d
  jmp alltraps
801066b0:	e9 82 f6 ff ff       	jmp    80105d37 <alltraps>

801066b5 <vector110>:
.globl vector110
vector110:
  pushl $0
801066b5:	6a 00                	push   $0x0
  pushl $110
801066b7:	6a 6e                	push   $0x6e
  jmp alltraps
801066b9:	e9 79 f6 ff ff       	jmp    80105d37 <alltraps>

801066be <vector111>:
.globl vector111
vector111:
  pushl $0
801066be:	6a 00                	push   $0x0
  pushl $111
801066c0:	6a 6f                	push   $0x6f
  jmp alltraps
801066c2:	e9 70 f6 ff ff       	jmp    80105d37 <alltraps>

801066c7 <vector112>:
.globl vector112
vector112:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $112
801066c9:	6a 70                	push   $0x70
  jmp alltraps
801066cb:	e9 67 f6 ff ff       	jmp    80105d37 <alltraps>

801066d0 <vector113>:
.globl vector113
vector113:
  pushl $0
801066d0:	6a 00                	push   $0x0
  pushl $113
801066d2:	6a 71                	push   $0x71
  jmp alltraps
801066d4:	e9 5e f6 ff ff       	jmp    80105d37 <alltraps>

801066d9 <vector114>:
.globl vector114
vector114:
  pushl $0
801066d9:	6a 00                	push   $0x0
  pushl $114
801066db:	6a 72                	push   $0x72
  jmp alltraps
801066dd:	e9 55 f6 ff ff       	jmp    80105d37 <alltraps>

801066e2 <vector115>:
.globl vector115
vector115:
  pushl $0
801066e2:	6a 00                	push   $0x0
  pushl $115
801066e4:	6a 73                	push   $0x73
  jmp alltraps
801066e6:	e9 4c f6 ff ff       	jmp    80105d37 <alltraps>

801066eb <vector116>:
.globl vector116
vector116:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $116
801066ed:	6a 74                	push   $0x74
  jmp alltraps
801066ef:	e9 43 f6 ff ff       	jmp    80105d37 <alltraps>

801066f4 <vector117>:
.globl vector117
vector117:
  pushl $0
801066f4:	6a 00                	push   $0x0
  pushl $117
801066f6:	6a 75                	push   $0x75
  jmp alltraps
801066f8:	e9 3a f6 ff ff       	jmp    80105d37 <alltraps>

801066fd <vector118>:
.globl vector118
vector118:
  pushl $0
801066fd:	6a 00                	push   $0x0
  pushl $118
801066ff:	6a 76                	push   $0x76
  jmp alltraps
80106701:	e9 31 f6 ff ff       	jmp    80105d37 <alltraps>

80106706 <vector119>:
.globl vector119
vector119:
  pushl $0
80106706:	6a 00                	push   $0x0
  pushl $119
80106708:	6a 77                	push   $0x77
  jmp alltraps
8010670a:	e9 28 f6 ff ff       	jmp    80105d37 <alltraps>

8010670f <vector120>:
.globl vector120
vector120:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $120
80106711:	6a 78                	push   $0x78
  jmp alltraps
80106713:	e9 1f f6 ff ff       	jmp    80105d37 <alltraps>

80106718 <vector121>:
.globl vector121
vector121:
  pushl $0
80106718:	6a 00                	push   $0x0
  pushl $121
8010671a:	6a 79                	push   $0x79
  jmp alltraps
8010671c:	e9 16 f6 ff ff       	jmp    80105d37 <alltraps>

80106721 <vector122>:
.globl vector122
vector122:
  pushl $0
80106721:	6a 00                	push   $0x0
  pushl $122
80106723:	6a 7a                	push   $0x7a
  jmp alltraps
80106725:	e9 0d f6 ff ff       	jmp    80105d37 <alltraps>

8010672a <vector123>:
.globl vector123
vector123:
  pushl $0
8010672a:	6a 00                	push   $0x0
  pushl $123
8010672c:	6a 7b                	push   $0x7b
  jmp alltraps
8010672e:	e9 04 f6 ff ff       	jmp    80105d37 <alltraps>

80106733 <vector124>:
.globl vector124
vector124:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $124
80106735:	6a 7c                	push   $0x7c
  jmp alltraps
80106737:	e9 fb f5 ff ff       	jmp    80105d37 <alltraps>

8010673c <vector125>:
.globl vector125
vector125:
  pushl $0
8010673c:	6a 00                	push   $0x0
  pushl $125
8010673e:	6a 7d                	push   $0x7d
  jmp alltraps
80106740:	e9 f2 f5 ff ff       	jmp    80105d37 <alltraps>

80106745 <vector126>:
.globl vector126
vector126:
  pushl $0
80106745:	6a 00                	push   $0x0
  pushl $126
80106747:	6a 7e                	push   $0x7e
  jmp alltraps
80106749:	e9 e9 f5 ff ff       	jmp    80105d37 <alltraps>

8010674e <vector127>:
.globl vector127
vector127:
  pushl $0
8010674e:	6a 00                	push   $0x0
  pushl $127
80106750:	6a 7f                	push   $0x7f
  jmp alltraps
80106752:	e9 e0 f5 ff ff       	jmp    80105d37 <alltraps>

80106757 <vector128>:
.globl vector128
vector128:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $128
80106759:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010675e:	e9 d4 f5 ff ff       	jmp    80105d37 <alltraps>

80106763 <vector129>:
.globl vector129
vector129:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $129
80106765:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010676a:	e9 c8 f5 ff ff       	jmp    80105d37 <alltraps>

8010676f <vector130>:
.globl vector130
vector130:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $130
80106771:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106776:	e9 bc f5 ff ff       	jmp    80105d37 <alltraps>

8010677b <vector131>:
.globl vector131
vector131:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $131
8010677d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106782:	e9 b0 f5 ff ff       	jmp    80105d37 <alltraps>

80106787 <vector132>:
.globl vector132
vector132:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $132
80106789:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010678e:	e9 a4 f5 ff ff       	jmp    80105d37 <alltraps>

80106793 <vector133>:
.globl vector133
vector133:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $133
80106795:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010679a:	e9 98 f5 ff ff       	jmp    80105d37 <alltraps>

8010679f <vector134>:
.globl vector134
vector134:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $134
801067a1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801067a6:	e9 8c f5 ff ff       	jmp    80105d37 <alltraps>

801067ab <vector135>:
.globl vector135
vector135:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $135
801067ad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801067b2:	e9 80 f5 ff ff       	jmp    80105d37 <alltraps>

801067b7 <vector136>:
.globl vector136
vector136:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $136
801067b9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801067be:	e9 74 f5 ff ff       	jmp    80105d37 <alltraps>

801067c3 <vector137>:
.globl vector137
vector137:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $137
801067c5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801067ca:	e9 68 f5 ff ff       	jmp    80105d37 <alltraps>

801067cf <vector138>:
.globl vector138
vector138:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $138
801067d1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801067d6:	e9 5c f5 ff ff       	jmp    80105d37 <alltraps>

801067db <vector139>:
.globl vector139
vector139:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $139
801067dd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801067e2:	e9 50 f5 ff ff       	jmp    80105d37 <alltraps>

801067e7 <vector140>:
.globl vector140
vector140:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $140
801067e9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801067ee:	e9 44 f5 ff ff       	jmp    80105d37 <alltraps>

801067f3 <vector141>:
.globl vector141
vector141:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $141
801067f5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801067fa:	e9 38 f5 ff ff       	jmp    80105d37 <alltraps>

801067ff <vector142>:
.globl vector142
vector142:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $142
80106801:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106806:	e9 2c f5 ff ff       	jmp    80105d37 <alltraps>

8010680b <vector143>:
.globl vector143
vector143:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $143
8010680d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106812:	e9 20 f5 ff ff       	jmp    80105d37 <alltraps>

80106817 <vector144>:
.globl vector144
vector144:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $144
80106819:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010681e:	e9 14 f5 ff ff       	jmp    80105d37 <alltraps>

80106823 <vector145>:
.globl vector145
vector145:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $145
80106825:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010682a:	e9 08 f5 ff ff       	jmp    80105d37 <alltraps>

8010682f <vector146>:
.globl vector146
vector146:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $146
80106831:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106836:	e9 fc f4 ff ff       	jmp    80105d37 <alltraps>

8010683b <vector147>:
.globl vector147
vector147:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $147
8010683d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106842:	e9 f0 f4 ff ff       	jmp    80105d37 <alltraps>

80106847 <vector148>:
.globl vector148
vector148:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $148
80106849:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010684e:	e9 e4 f4 ff ff       	jmp    80105d37 <alltraps>

80106853 <vector149>:
.globl vector149
vector149:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $149
80106855:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010685a:	e9 d8 f4 ff ff       	jmp    80105d37 <alltraps>

8010685f <vector150>:
.globl vector150
vector150:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $150
80106861:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106866:	e9 cc f4 ff ff       	jmp    80105d37 <alltraps>

8010686b <vector151>:
.globl vector151
vector151:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $151
8010686d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106872:	e9 c0 f4 ff ff       	jmp    80105d37 <alltraps>

80106877 <vector152>:
.globl vector152
vector152:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $152
80106879:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010687e:	e9 b4 f4 ff ff       	jmp    80105d37 <alltraps>

80106883 <vector153>:
.globl vector153
vector153:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $153
80106885:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010688a:	e9 a8 f4 ff ff       	jmp    80105d37 <alltraps>

8010688f <vector154>:
.globl vector154
vector154:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $154
80106891:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106896:	e9 9c f4 ff ff       	jmp    80105d37 <alltraps>

8010689b <vector155>:
.globl vector155
vector155:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $155
8010689d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801068a2:	e9 90 f4 ff ff       	jmp    80105d37 <alltraps>

801068a7 <vector156>:
.globl vector156
vector156:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $156
801068a9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801068ae:	e9 84 f4 ff ff       	jmp    80105d37 <alltraps>

801068b3 <vector157>:
.globl vector157
vector157:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $157
801068b5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801068ba:	e9 78 f4 ff ff       	jmp    80105d37 <alltraps>

801068bf <vector158>:
.globl vector158
vector158:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $158
801068c1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801068c6:	e9 6c f4 ff ff       	jmp    80105d37 <alltraps>

801068cb <vector159>:
.globl vector159
vector159:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $159
801068cd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801068d2:	e9 60 f4 ff ff       	jmp    80105d37 <alltraps>

801068d7 <vector160>:
.globl vector160
vector160:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $160
801068d9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801068de:	e9 54 f4 ff ff       	jmp    80105d37 <alltraps>

801068e3 <vector161>:
.globl vector161
vector161:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $161
801068e5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801068ea:	e9 48 f4 ff ff       	jmp    80105d37 <alltraps>

801068ef <vector162>:
.globl vector162
vector162:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $162
801068f1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801068f6:	e9 3c f4 ff ff       	jmp    80105d37 <alltraps>

801068fb <vector163>:
.globl vector163
vector163:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $163
801068fd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106902:	e9 30 f4 ff ff       	jmp    80105d37 <alltraps>

80106907 <vector164>:
.globl vector164
vector164:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $164
80106909:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010690e:	e9 24 f4 ff ff       	jmp    80105d37 <alltraps>

80106913 <vector165>:
.globl vector165
vector165:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $165
80106915:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010691a:	e9 18 f4 ff ff       	jmp    80105d37 <alltraps>

8010691f <vector166>:
.globl vector166
vector166:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $166
80106921:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106926:	e9 0c f4 ff ff       	jmp    80105d37 <alltraps>

8010692b <vector167>:
.globl vector167
vector167:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $167
8010692d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106932:	e9 00 f4 ff ff       	jmp    80105d37 <alltraps>

80106937 <vector168>:
.globl vector168
vector168:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $168
80106939:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010693e:	e9 f4 f3 ff ff       	jmp    80105d37 <alltraps>

80106943 <vector169>:
.globl vector169
vector169:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $169
80106945:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010694a:	e9 e8 f3 ff ff       	jmp    80105d37 <alltraps>

8010694f <vector170>:
.globl vector170
vector170:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $170
80106951:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106956:	e9 dc f3 ff ff       	jmp    80105d37 <alltraps>

8010695b <vector171>:
.globl vector171
vector171:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $171
8010695d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106962:	e9 d0 f3 ff ff       	jmp    80105d37 <alltraps>

80106967 <vector172>:
.globl vector172
vector172:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $172
80106969:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010696e:	e9 c4 f3 ff ff       	jmp    80105d37 <alltraps>

80106973 <vector173>:
.globl vector173
vector173:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $173
80106975:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010697a:	e9 b8 f3 ff ff       	jmp    80105d37 <alltraps>

8010697f <vector174>:
.globl vector174
vector174:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $174
80106981:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106986:	e9 ac f3 ff ff       	jmp    80105d37 <alltraps>

8010698b <vector175>:
.globl vector175
vector175:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $175
8010698d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106992:	e9 a0 f3 ff ff       	jmp    80105d37 <alltraps>

80106997 <vector176>:
.globl vector176
vector176:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $176
80106999:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010699e:	e9 94 f3 ff ff       	jmp    80105d37 <alltraps>

801069a3 <vector177>:
.globl vector177
vector177:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $177
801069a5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801069aa:	e9 88 f3 ff ff       	jmp    80105d37 <alltraps>

801069af <vector178>:
.globl vector178
vector178:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $178
801069b1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801069b6:	e9 7c f3 ff ff       	jmp    80105d37 <alltraps>

801069bb <vector179>:
.globl vector179
vector179:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $179
801069bd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801069c2:	e9 70 f3 ff ff       	jmp    80105d37 <alltraps>

801069c7 <vector180>:
.globl vector180
vector180:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $180
801069c9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801069ce:	e9 64 f3 ff ff       	jmp    80105d37 <alltraps>

801069d3 <vector181>:
.globl vector181
vector181:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $181
801069d5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801069da:	e9 58 f3 ff ff       	jmp    80105d37 <alltraps>

801069df <vector182>:
.globl vector182
vector182:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $182
801069e1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801069e6:	e9 4c f3 ff ff       	jmp    80105d37 <alltraps>

801069eb <vector183>:
.globl vector183
vector183:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $183
801069ed:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801069f2:	e9 40 f3 ff ff       	jmp    80105d37 <alltraps>

801069f7 <vector184>:
.globl vector184
vector184:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $184
801069f9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801069fe:	e9 34 f3 ff ff       	jmp    80105d37 <alltraps>

80106a03 <vector185>:
.globl vector185
vector185:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $185
80106a05:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106a0a:	e9 28 f3 ff ff       	jmp    80105d37 <alltraps>

80106a0f <vector186>:
.globl vector186
vector186:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $186
80106a11:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106a16:	e9 1c f3 ff ff       	jmp    80105d37 <alltraps>

80106a1b <vector187>:
.globl vector187
vector187:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $187
80106a1d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106a22:	e9 10 f3 ff ff       	jmp    80105d37 <alltraps>

80106a27 <vector188>:
.globl vector188
vector188:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $188
80106a29:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106a2e:	e9 04 f3 ff ff       	jmp    80105d37 <alltraps>

80106a33 <vector189>:
.globl vector189
vector189:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $189
80106a35:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106a3a:	e9 f8 f2 ff ff       	jmp    80105d37 <alltraps>

80106a3f <vector190>:
.globl vector190
vector190:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $190
80106a41:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106a46:	e9 ec f2 ff ff       	jmp    80105d37 <alltraps>

80106a4b <vector191>:
.globl vector191
vector191:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $191
80106a4d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106a52:	e9 e0 f2 ff ff       	jmp    80105d37 <alltraps>

80106a57 <vector192>:
.globl vector192
vector192:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $192
80106a59:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106a5e:	e9 d4 f2 ff ff       	jmp    80105d37 <alltraps>

80106a63 <vector193>:
.globl vector193
vector193:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $193
80106a65:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106a6a:	e9 c8 f2 ff ff       	jmp    80105d37 <alltraps>

80106a6f <vector194>:
.globl vector194
vector194:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $194
80106a71:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106a76:	e9 bc f2 ff ff       	jmp    80105d37 <alltraps>

80106a7b <vector195>:
.globl vector195
vector195:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $195
80106a7d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106a82:	e9 b0 f2 ff ff       	jmp    80105d37 <alltraps>

80106a87 <vector196>:
.globl vector196
vector196:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $196
80106a89:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106a8e:	e9 a4 f2 ff ff       	jmp    80105d37 <alltraps>

80106a93 <vector197>:
.globl vector197
vector197:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $197
80106a95:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106a9a:	e9 98 f2 ff ff       	jmp    80105d37 <alltraps>

80106a9f <vector198>:
.globl vector198
vector198:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $198
80106aa1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106aa6:	e9 8c f2 ff ff       	jmp    80105d37 <alltraps>

80106aab <vector199>:
.globl vector199
vector199:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $199
80106aad:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106ab2:	e9 80 f2 ff ff       	jmp    80105d37 <alltraps>

80106ab7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $200
80106ab9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106abe:	e9 74 f2 ff ff       	jmp    80105d37 <alltraps>

80106ac3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $201
80106ac5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106aca:	e9 68 f2 ff ff       	jmp    80105d37 <alltraps>

80106acf <vector202>:
.globl vector202
vector202:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $202
80106ad1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ad6:	e9 5c f2 ff ff       	jmp    80105d37 <alltraps>

80106adb <vector203>:
.globl vector203
vector203:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $203
80106add:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106ae2:	e9 50 f2 ff ff       	jmp    80105d37 <alltraps>

80106ae7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $204
80106ae9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106aee:	e9 44 f2 ff ff       	jmp    80105d37 <alltraps>

80106af3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $205
80106af5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106afa:	e9 38 f2 ff ff       	jmp    80105d37 <alltraps>

80106aff <vector206>:
.globl vector206
vector206:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $206
80106b01:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106b06:	e9 2c f2 ff ff       	jmp    80105d37 <alltraps>

80106b0b <vector207>:
.globl vector207
vector207:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $207
80106b0d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106b12:	e9 20 f2 ff ff       	jmp    80105d37 <alltraps>

80106b17 <vector208>:
.globl vector208
vector208:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $208
80106b19:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106b1e:	e9 14 f2 ff ff       	jmp    80105d37 <alltraps>

80106b23 <vector209>:
.globl vector209
vector209:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $209
80106b25:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106b2a:	e9 08 f2 ff ff       	jmp    80105d37 <alltraps>

80106b2f <vector210>:
.globl vector210
vector210:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $210
80106b31:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106b36:	e9 fc f1 ff ff       	jmp    80105d37 <alltraps>

80106b3b <vector211>:
.globl vector211
vector211:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $211
80106b3d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106b42:	e9 f0 f1 ff ff       	jmp    80105d37 <alltraps>

80106b47 <vector212>:
.globl vector212
vector212:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $212
80106b49:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106b4e:	e9 e4 f1 ff ff       	jmp    80105d37 <alltraps>

80106b53 <vector213>:
.globl vector213
vector213:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $213
80106b55:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106b5a:	e9 d8 f1 ff ff       	jmp    80105d37 <alltraps>

80106b5f <vector214>:
.globl vector214
vector214:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $214
80106b61:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106b66:	e9 cc f1 ff ff       	jmp    80105d37 <alltraps>

80106b6b <vector215>:
.globl vector215
vector215:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $215
80106b6d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106b72:	e9 c0 f1 ff ff       	jmp    80105d37 <alltraps>

80106b77 <vector216>:
.globl vector216
vector216:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $216
80106b79:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106b7e:	e9 b4 f1 ff ff       	jmp    80105d37 <alltraps>

80106b83 <vector217>:
.globl vector217
vector217:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $217
80106b85:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106b8a:	e9 a8 f1 ff ff       	jmp    80105d37 <alltraps>

80106b8f <vector218>:
.globl vector218
vector218:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $218
80106b91:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106b96:	e9 9c f1 ff ff       	jmp    80105d37 <alltraps>

80106b9b <vector219>:
.globl vector219
vector219:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $219
80106b9d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106ba2:	e9 90 f1 ff ff       	jmp    80105d37 <alltraps>

80106ba7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $220
80106ba9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106bae:	e9 84 f1 ff ff       	jmp    80105d37 <alltraps>

80106bb3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $221
80106bb5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106bba:	e9 78 f1 ff ff       	jmp    80105d37 <alltraps>

80106bbf <vector222>:
.globl vector222
vector222:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $222
80106bc1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106bc6:	e9 6c f1 ff ff       	jmp    80105d37 <alltraps>

80106bcb <vector223>:
.globl vector223
vector223:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $223
80106bcd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106bd2:	e9 60 f1 ff ff       	jmp    80105d37 <alltraps>

80106bd7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $224
80106bd9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106bde:	e9 54 f1 ff ff       	jmp    80105d37 <alltraps>

80106be3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $225
80106be5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106bea:	e9 48 f1 ff ff       	jmp    80105d37 <alltraps>

80106bef <vector226>:
.globl vector226
vector226:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $226
80106bf1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106bf6:	e9 3c f1 ff ff       	jmp    80105d37 <alltraps>

80106bfb <vector227>:
.globl vector227
vector227:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $227
80106bfd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106c02:	e9 30 f1 ff ff       	jmp    80105d37 <alltraps>

80106c07 <vector228>:
.globl vector228
vector228:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $228
80106c09:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106c0e:	e9 24 f1 ff ff       	jmp    80105d37 <alltraps>

80106c13 <vector229>:
.globl vector229
vector229:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $229
80106c15:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106c1a:	e9 18 f1 ff ff       	jmp    80105d37 <alltraps>

80106c1f <vector230>:
.globl vector230
vector230:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $230
80106c21:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106c26:	e9 0c f1 ff ff       	jmp    80105d37 <alltraps>

80106c2b <vector231>:
.globl vector231
vector231:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $231
80106c2d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106c32:	e9 00 f1 ff ff       	jmp    80105d37 <alltraps>

80106c37 <vector232>:
.globl vector232
vector232:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $232
80106c39:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106c3e:	e9 f4 f0 ff ff       	jmp    80105d37 <alltraps>

80106c43 <vector233>:
.globl vector233
vector233:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $233
80106c45:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106c4a:	e9 e8 f0 ff ff       	jmp    80105d37 <alltraps>

80106c4f <vector234>:
.globl vector234
vector234:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $234
80106c51:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106c56:	e9 dc f0 ff ff       	jmp    80105d37 <alltraps>

80106c5b <vector235>:
.globl vector235
vector235:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $235
80106c5d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106c62:	e9 d0 f0 ff ff       	jmp    80105d37 <alltraps>

80106c67 <vector236>:
.globl vector236
vector236:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $236
80106c69:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106c6e:	e9 c4 f0 ff ff       	jmp    80105d37 <alltraps>

80106c73 <vector237>:
.globl vector237
vector237:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $237
80106c75:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106c7a:	e9 b8 f0 ff ff       	jmp    80105d37 <alltraps>

80106c7f <vector238>:
.globl vector238
vector238:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $238
80106c81:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106c86:	e9 ac f0 ff ff       	jmp    80105d37 <alltraps>

80106c8b <vector239>:
.globl vector239
vector239:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $239
80106c8d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106c92:	e9 a0 f0 ff ff       	jmp    80105d37 <alltraps>

80106c97 <vector240>:
.globl vector240
vector240:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $240
80106c99:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106c9e:	e9 94 f0 ff ff       	jmp    80105d37 <alltraps>

80106ca3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $241
80106ca5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106caa:	e9 88 f0 ff ff       	jmp    80105d37 <alltraps>

80106caf <vector242>:
.globl vector242
vector242:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $242
80106cb1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106cb6:	e9 7c f0 ff ff       	jmp    80105d37 <alltraps>

80106cbb <vector243>:
.globl vector243
vector243:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $243
80106cbd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106cc2:	e9 70 f0 ff ff       	jmp    80105d37 <alltraps>

80106cc7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $244
80106cc9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106cce:	e9 64 f0 ff ff       	jmp    80105d37 <alltraps>

80106cd3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $245
80106cd5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106cda:	e9 58 f0 ff ff       	jmp    80105d37 <alltraps>

80106cdf <vector246>:
.globl vector246
vector246:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $246
80106ce1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106ce6:	e9 4c f0 ff ff       	jmp    80105d37 <alltraps>

80106ceb <vector247>:
.globl vector247
vector247:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $247
80106ced:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106cf2:	e9 40 f0 ff ff       	jmp    80105d37 <alltraps>

80106cf7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $248
80106cf9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106cfe:	e9 34 f0 ff ff       	jmp    80105d37 <alltraps>

80106d03 <vector249>:
.globl vector249
vector249:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $249
80106d05:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106d0a:	e9 28 f0 ff ff       	jmp    80105d37 <alltraps>

80106d0f <vector250>:
.globl vector250
vector250:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $250
80106d11:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106d16:	e9 1c f0 ff ff       	jmp    80105d37 <alltraps>

80106d1b <vector251>:
.globl vector251
vector251:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $251
80106d1d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106d22:	e9 10 f0 ff ff       	jmp    80105d37 <alltraps>

80106d27 <vector252>:
.globl vector252
vector252:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $252
80106d29:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106d2e:	e9 04 f0 ff ff       	jmp    80105d37 <alltraps>

80106d33 <vector253>:
.globl vector253
vector253:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $253
80106d35:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106d3a:	e9 f8 ef ff ff       	jmp    80105d37 <alltraps>

80106d3f <vector254>:
.globl vector254
vector254:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $254
80106d41:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106d46:	e9 ec ef ff ff       	jmp    80105d37 <alltraps>

80106d4b <vector255>:
.globl vector255
vector255:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $255
80106d4d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106d52:	e9 e0 ef ff ff       	jmp    80105d37 <alltraps>
80106d57:	66 90                	xchg   %ax,%ax
80106d59:	66 90                	xchg   %ax,%ax
80106d5b:	66 90                	xchg   %ax,%ax
80106d5d:	66 90                	xchg   %ax,%ax
80106d5f:	90                   	nop

80106d60 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106d66:	89 d3                	mov    %edx,%ebx
{
80106d68:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106d6a:	c1 eb 16             	shr    $0x16,%ebx
80106d6d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106d70:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106d73:	8b 06                	mov    (%esi),%eax
80106d75:	a8 01                	test   $0x1,%al
80106d77:	74 27                	je     80106da0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d79:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d7e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106d84:	c1 ef 0a             	shr    $0xa,%edi
}
80106d87:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106d8a:	89 fa                	mov    %edi,%edx
80106d8c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106d92:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106d95:	5b                   	pop    %ebx
80106d96:	5e                   	pop    %esi
80106d97:	5f                   	pop    %edi
80106d98:	5d                   	pop    %ebp
80106d99:	c3                   	ret    
80106d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106da0:	85 c9                	test   %ecx,%ecx
80106da2:	74 2c                	je     80106dd0 <walkpgdir+0x70>
80106da4:	e8 f7 b7 ff ff       	call   801025a0 <kalloc>
80106da9:	85 c0                	test   %eax,%eax
80106dab:	89 c3                	mov    %eax,%ebx
80106dad:	74 21                	je     80106dd0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106daf:	83 ec 04             	sub    $0x4,%esp
80106db2:	68 00 10 00 00       	push   $0x1000
80106db7:	6a 00                	push   $0x0
80106db9:	50                   	push   %eax
80106dba:	e8 e1 dc ff ff       	call   80104aa0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106dbf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dc5:	83 c4 10             	add    $0x10,%esp
80106dc8:	83 c8 07             	or     $0x7,%eax
80106dcb:	89 06                	mov    %eax,(%esi)
80106dcd:	eb b5                	jmp    80106d84 <walkpgdir+0x24>
80106dcf:	90                   	nop
}
80106dd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106dd3:	31 c0                	xor    %eax,%eax
}
80106dd5:	5b                   	pop    %ebx
80106dd6:	5e                   	pop    %esi
80106dd7:	5f                   	pop    %edi
80106dd8:	5d                   	pop    %ebp
80106dd9:	c3                   	ret    
80106dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106de0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	57                   	push   %edi
80106de4:	56                   	push   %esi
80106de5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106de6:	89 d3                	mov    %edx,%ebx
80106de8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106dee:	83 ec 1c             	sub    $0x1c,%esp
80106df1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106df4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106df8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106dfb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e00:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106e03:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e06:	29 df                	sub    %ebx,%edi
80106e08:	83 c8 01             	or     $0x1,%eax
80106e0b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106e0e:	eb 15                	jmp    80106e25 <mappages+0x45>
    if(*pte & PTE_P)
80106e10:	f6 00 01             	testb  $0x1,(%eax)
80106e13:	75 45                	jne    80106e5a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106e15:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106e18:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106e1b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106e1d:	74 31                	je     80106e50 <mappages+0x70>
      break;
    a += PGSIZE;
80106e1f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106e25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e28:	b9 01 00 00 00       	mov    $0x1,%ecx
80106e2d:	89 da                	mov    %ebx,%edx
80106e2f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106e32:	e8 29 ff ff ff       	call   80106d60 <walkpgdir>
80106e37:	85 c0                	test   %eax,%eax
80106e39:	75 d5                	jne    80106e10 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106e3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e43:	5b                   	pop    %ebx
80106e44:	5e                   	pop    %esi
80106e45:	5f                   	pop    %edi
80106e46:	5d                   	pop    %ebp
80106e47:	c3                   	ret    
80106e48:	90                   	nop
80106e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e50:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e53:	31 c0                	xor    %eax,%eax
}
80106e55:	5b                   	pop    %ebx
80106e56:	5e                   	pop    %esi
80106e57:	5f                   	pop    %edi
80106e58:	5d                   	pop    %ebp
80106e59:	c3                   	ret    
      panic("remap");
80106e5a:	83 ec 0c             	sub    $0xc,%esp
80106e5d:	68 58 80 10 80       	push   $0x80108058
80106e62:	e8 29 95 ff ff       	call   80100390 <panic>
80106e67:	89 f6                	mov    %esi,%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e70 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	57                   	push   %edi
80106e74:	56                   	push   %esi
80106e75:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106e76:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e7c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106e7e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e84:	83 ec 1c             	sub    $0x1c,%esp
80106e87:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106e8a:	39 d3                	cmp    %edx,%ebx
80106e8c:	73 66                	jae    80106ef4 <deallocuvm.part.0+0x84>
80106e8e:	89 d6                	mov    %edx,%esi
80106e90:	eb 3d                	jmp    80106ecf <deallocuvm.part.0+0x5f>
80106e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106e98:	8b 10                	mov    (%eax),%edx
80106e9a:	f6 c2 01             	test   $0x1,%dl
80106e9d:	74 26                	je     80106ec5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106e9f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106ea5:	74 58                	je     80106eff <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106ea7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106eaa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106eb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106eb3:	52                   	push   %edx
80106eb4:	e8 37 b5 ff ff       	call   801023f0 <kfree>
      *pte = 0;
80106eb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ebc:	83 c4 10             	add    $0x10,%esp
80106ebf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106ec5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ecb:	39 f3                	cmp    %esi,%ebx
80106ecd:	73 25                	jae    80106ef4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106ecf:	31 c9                	xor    %ecx,%ecx
80106ed1:	89 da                	mov    %ebx,%edx
80106ed3:	89 f8                	mov    %edi,%eax
80106ed5:	e8 86 fe ff ff       	call   80106d60 <walkpgdir>
    if(!pte)
80106eda:	85 c0                	test   %eax,%eax
80106edc:	75 ba                	jne    80106e98 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106ede:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106ee4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106eea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ef0:	39 f3                	cmp    %esi,%ebx
80106ef2:	72 db                	jb     80106ecf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106ef4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ef7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106efa:	5b                   	pop    %ebx
80106efb:	5e                   	pop    %esi
80106efc:	5f                   	pop    %edi
80106efd:	5d                   	pop    %ebp
80106efe:	c3                   	ret    
        panic("kfree");
80106eff:	83 ec 0c             	sub    $0xc,%esp
80106f02:	68 26 79 10 80       	push   $0x80107926
80106f07:	e8 84 94 ff ff       	call   80100390 <panic>
80106f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106f10 <seginit>:
{
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106f16:	e8 25 ca ff ff       	call   80103940 <cpuid>
80106f1b:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
80106f21:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106f26:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f2a:	c7 80 f8 37 11 80 ff 	movl   $0xffff,-0x7feec808(%eax)
80106f31:	ff 00 00 
80106f34:	c7 80 fc 37 11 80 00 	movl   $0xcf9a00,-0x7feec804(%eax)
80106f3b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f3e:	c7 80 00 38 11 80 ff 	movl   $0xffff,-0x7feec800(%eax)
80106f45:	ff 00 00 
80106f48:	c7 80 04 38 11 80 00 	movl   $0xcf9200,-0x7feec7fc(%eax)
80106f4f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f52:	c7 80 08 38 11 80 ff 	movl   $0xffff,-0x7feec7f8(%eax)
80106f59:	ff 00 00 
80106f5c:	c7 80 0c 38 11 80 00 	movl   $0xcffa00,-0x7feec7f4(%eax)
80106f63:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f66:	c7 80 10 38 11 80 ff 	movl   $0xffff,-0x7feec7f0(%eax)
80106f6d:	ff 00 00 
80106f70:	c7 80 14 38 11 80 00 	movl   $0xcff200,-0x7feec7ec(%eax)
80106f77:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106f7a:	05 f0 37 11 80       	add    $0x801137f0,%eax
  pd[1] = (uint)p;
80106f7f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106f83:	c1 e8 10             	shr    $0x10,%eax
80106f86:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106f8a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106f8d:	0f 01 10             	lgdtl  (%eax)
}
80106f90:	c9                   	leave  
80106f91:	c3                   	ret    
80106f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fa0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106fa0:	a1 c4 f1 11 80       	mov    0x8011f1c4,%eax
{
80106fa5:	55                   	push   %ebp
80106fa6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106fa8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fad:	0f 22 d8             	mov    %eax,%cr3
}
80106fb0:	5d                   	pop    %ebp
80106fb1:	c3                   	ret    
80106fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fc0 <switchuvm>:
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	57                   	push   %edi
80106fc4:	56                   	push   %esi
80106fc5:	53                   	push   %ebx
80106fc6:	83 ec 1c             	sub    $0x1c,%esp
80106fc9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106fcc:	85 f6                	test   %esi,%esi
80106fce:	0f 84 d3 00 00 00    	je     801070a7 <switchuvm+0xe7>
  if(mythread()->kstack == 0)
80106fd4:	e8 b7 c9 ff ff       	call   80103990 <mythread>
80106fd9:	8b 00                	mov    (%eax),%eax
80106fdb:	85 c0                	test   %eax,%eax
80106fdd:	0f 84 de 00 00 00    	je     801070c1 <switchuvm+0x101>
  if(p->pgdir == 0)
80106fe3:	8b 46 04             	mov    0x4(%esi),%eax
80106fe6:	85 c0                	test   %eax,%eax
80106fe8:	0f 84 c6 00 00 00    	je     801070b4 <switchuvm+0xf4>
  pushcli();
80106fee:	e8 cd d8 ff ff       	call   801048c0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106ff3:	e8 c8 c8 ff ff       	call   801038c0 <mycpu>
80106ff8:	89 c3                	mov    %eax,%ebx
80106ffa:	e8 c1 c8 ff ff       	call   801038c0 <mycpu>
80106fff:	89 c7                	mov    %eax,%edi
80107001:	e8 ba c8 ff ff       	call   801038c0 <mycpu>
80107006:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107009:	83 c7 08             	add    $0x8,%edi
8010700c:	e8 af c8 ff ff       	call   801038c0 <mycpu>
80107011:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107014:	83 c0 08             	add    $0x8,%eax
80107017:	ba 67 00 00 00       	mov    $0x67,%edx
8010701c:	c1 e8 18             	shr    $0x18,%eax
8010701f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107026:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010702d:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107033:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107038:	83 c1 08             	add    $0x8,%ecx
8010703b:	c1 e9 10             	shr    $0x10,%ecx
8010703e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107044:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107049:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107050:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107055:	e8 66 c8 ff ff       	call   801038c0 <mycpu>
8010705a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107061:	e8 5a c8 ff ff       	call   801038c0 <mycpu>
80107066:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)mythread()->kstack + KSTACKSIZE;
8010706a:	e8 21 c9 ff ff       	call   80103990 <mythread>
8010706f:	8b 18                	mov    (%eax),%ebx
80107071:	e8 4a c8 ff ff       	call   801038c0 <mycpu>
80107076:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010707c:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010707f:	e8 3c c8 ff ff       	call   801038c0 <mycpu>
80107084:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107088:	b8 28 00 00 00       	mov    $0x28,%eax
8010708d:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107090:	8b 46 04             	mov    0x4(%esi),%eax
80107093:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107098:	0f 22 d8             	mov    %eax,%cr3
}
8010709b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010709e:	5b                   	pop    %ebx
8010709f:	5e                   	pop    %esi
801070a0:	5f                   	pop    %edi
801070a1:	5d                   	pop    %ebp
  popcli();
801070a2:	e9 59 d8 ff ff       	jmp    80104900 <popcli>
    panic("switchuvm: no process");
801070a7:	83 ec 0c             	sub    $0xc,%esp
801070aa:	68 5e 80 10 80       	push   $0x8010805e
801070af:	e8 dc 92 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801070b4:	83 ec 0c             	sub    $0xc,%esp
801070b7:	68 89 80 10 80       	push   $0x80108089
801070bc:	e8 cf 92 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801070c1:	83 ec 0c             	sub    $0xc,%esp
801070c4:	68 74 80 10 80       	push   $0x80108074
801070c9:	e8 c2 92 ff ff       	call   80100390 <panic>
801070ce:	66 90                	xchg   %ax,%ax

801070d0 <inituvm>:
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
801070d6:	83 ec 1c             	sub    $0x1c,%esp
801070d9:	8b 75 10             	mov    0x10(%ebp),%esi
801070dc:	8b 45 08             	mov    0x8(%ebp),%eax
801070df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801070e2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801070e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801070eb:	77 49                	ja     80107136 <inituvm+0x66>
  mem = kalloc();
801070ed:	e8 ae b4 ff ff       	call   801025a0 <kalloc>
  memset(mem, 0, PGSIZE);
801070f2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801070f5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801070f7:	68 00 10 00 00       	push   $0x1000
801070fc:	6a 00                	push   $0x0
801070fe:	50                   	push   %eax
801070ff:	e8 9c d9 ff ff       	call   80104aa0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107104:	58                   	pop    %eax
80107105:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010710b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107110:	5a                   	pop    %edx
80107111:	6a 06                	push   $0x6
80107113:	50                   	push   %eax
80107114:	31 d2                	xor    %edx,%edx
80107116:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107119:	e8 c2 fc ff ff       	call   80106de0 <mappages>
  memmove(mem, init, sz);
8010711e:	89 75 10             	mov    %esi,0x10(%ebp)
80107121:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107124:	83 c4 10             	add    $0x10,%esp
80107127:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010712a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010712d:	5b                   	pop    %ebx
8010712e:	5e                   	pop    %esi
8010712f:	5f                   	pop    %edi
80107130:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107131:	e9 1a da ff ff       	jmp    80104b50 <memmove>
    panic("inituvm: more than a page");
80107136:	83 ec 0c             	sub    $0xc,%esp
80107139:	68 9d 80 10 80       	push   $0x8010809d
8010713e:	e8 4d 92 ff ff       	call   80100390 <panic>
80107143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107150 <loaduvm>:
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	57                   	push   %edi
80107154:	56                   	push   %esi
80107155:	53                   	push   %ebx
80107156:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107159:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107160:	0f 85 91 00 00 00    	jne    801071f7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107166:	8b 75 18             	mov    0x18(%ebp),%esi
80107169:	31 db                	xor    %ebx,%ebx
8010716b:	85 f6                	test   %esi,%esi
8010716d:	75 1a                	jne    80107189 <loaduvm+0x39>
8010716f:	eb 6f                	jmp    801071e0 <loaduvm+0x90>
80107171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107178:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010717e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107184:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107187:	76 57                	jbe    801071e0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107189:	8b 55 0c             	mov    0xc(%ebp),%edx
8010718c:	8b 45 08             	mov    0x8(%ebp),%eax
8010718f:	31 c9                	xor    %ecx,%ecx
80107191:	01 da                	add    %ebx,%edx
80107193:	e8 c8 fb ff ff       	call   80106d60 <walkpgdir>
80107198:	85 c0                	test   %eax,%eax
8010719a:	74 4e                	je     801071ea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010719c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010719e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801071a1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801071a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801071ab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801071b1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071b4:	01 d9                	add    %ebx,%ecx
801071b6:	05 00 00 00 80       	add    $0x80000000,%eax
801071bb:	57                   	push   %edi
801071bc:	51                   	push   %ecx
801071bd:	50                   	push   %eax
801071be:	ff 75 10             	pushl  0x10(%ebp)
801071c1:	e8 7a a8 ff ff       	call   80101a40 <readi>
801071c6:	83 c4 10             	add    $0x10,%esp
801071c9:	39 f8                	cmp    %edi,%eax
801071cb:	74 ab                	je     80107178 <loaduvm+0x28>
}
801071cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801071d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071d5:	5b                   	pop    %ebx
801071d6:	5e                   	pop    %esi
801071d7:	5f                   	pop    %edi
801071d8:	5d                   	pop    %ebp
801071d9:	c3                   	ret    
801071da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801071e3:	31 c0                	xor    %eax,%eax
}
801071e5:	5b                   	pop    %ebx
801071e6:	5e                   	pop    %esi
801071e7:	5f                   	pop    %edi
801071e8:	5d                   	pop    %ebp
801071e9:	c3                   	ret    
      panic("loaduvm: address should exist");
801071ea:	83 ec 0c             	sub    $0xc,%esp
801071ed:	68 b7 80 10 80       	push   $0x801080b7
801071f2:	e8 99 91 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801071f7:	83 ec 0c             	sub    $0xc,%esp
801071fa:	68 58 81 10 80       	push   $0x80108158
801071ff:	e8 8c 91 ff ff       	call   80100390 <panic>
80107204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010720a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107210 <allocuvm>:
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	57                   	push   %edi
80107214:	56                   	push   %esi
80107215:	53                   	push   %ebx
80107216:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107219:	8b 7d 10             	mov    0x10(%ebp),%edi
8010721c:	85 ff                	test   %edi,%edi
8010721e:	0f 88 8e 00 00 00    	js     801072b2 <allocuvm+0xa2>
  if(newsz < oldsz)
80107224:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107227:	0f 82 93 00 00 00    	jb     801072c0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010722d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107230:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107236:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010723c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010723f:	0f 86 7e 00 00 00    	jbe    801072c3 <allocuvm+0xb3>
80107245:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107248:	8b 7d 08             	mov    0x8(%ebp),%edi
8010724b:	eb 42                	jmp    8010728f <allocuvm+0x7f>
8010724d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107250:	83 ec 04             	sub    $0x4,%esp
80107253:	68 00 10 00 00       	push   $0x1000
80107258:	6a 00                	push   $0x0
8010725a:	50                   	push   %eax
8010725b:	e8 40 d8 ff ff       	call   80104aa0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107260:	58                   	pop    %eax
80107261:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107267:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010726c:	5a                   	pop    %edx
8010726d:	6a 06                	push   $0x6
8010726f:	50                   	push   %eax
80107270:	89 da                	mov    %ebx,%edx
80107272:	89 f8                	mov    %edi,%eax
80107274:	e8 67 fb ff ff       	call   80106de0 <mappages>
80107279:	83 c4 10             	add    $0x10,%esp
8010727c:	85 c0                	test   %eax,%eax
8010727e:	78 50                	js     801072d0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107280:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107286:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107289:	0f 86 81 00 00 00    	jbe    80107310 <allocuvm+0x100>
    mem = kalloc();
8010728f:	e8 0c b3 ff ff       	call   801025a0 <kalloc>
    if(mem == 0){
80107294:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107296:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107298:	75 b6                	jne    80107250 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010729a:	83 ec 0c             	sub    $0xc,%esp
8010729d:	68 d5 80 10 80       	push   $0x801080d5
801072a2:	e8 b9 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801072a7:	83 c4 10             	add    $0x10,%esp
801072aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801072ad:	39 45 10             	cmp    %eax,0x10(%ebp)
801072b0:	77 6e                	ja     80107320 <allocuvm+0x110>
}
801072b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801072b5:	31 ff                	xor    %edi,%edi
}
801072b7:	89 f8                	mov    %edi,%eax
801072b9:	5b                   	pop    %ebx
801072ba:	5e                   	pop    %esi
801072bb:	5f                   	pop    %edi
801072bc:	5d                   	pop    %ebp
801072bd:	c3                   	ret    
801072be:	66 90                	xchg   %ax,%ax
    return oldsz;
801072c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801072c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072c6:	89 f8                	mov    %edi,%eax
801072c8:	5b                   	pop    %ebx
801072c9:	5e                   	pop    %esi
801072ca:	5f                   	pop    %edi
801072cb:	5d                   	pop    %ebp
801072cc:	c3                   	ret    
801072cd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801072d0:	83 ec 0c             	sub    $0xc,%esp
801072d3:	68 ed 80 10 80       	push   $0x801080ed
801072d8:	e8 83 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801072dd:	83 c4 10             	add    $0x10,%esp
801072e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801072e3:	39 45 10             	cmp    %eax,0x10(%ebp)
801072e6:	76 0d                	jbe    801072f5 <allocuvm+0xe5>
801072e8:	89 c1                	mov    %eax,%ecx
801072ea:	8b 55 10             	mov    0x10(%ebp),%edx
801072ed:	8b 45 08             	mov    0x8(%ebp),%eax
801072f0:	e8 7b fb ff ff       	call   80106e70 <deallocuvm.part.0>
      kfree(mem);
801072f5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801072f8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801072fa:	56                   	push   %esi
801072fb:	e8 f0 b0 ff ff       	call   801023f0 <kfree>
      return 0;
80107300:	83 c4 10             	add    $0x10,%esp
}
80107303:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107306:	89 f8                	mov    %edi,%eax
80107308:	5b                   	pop    %ebx
80107309:	5e                   	pop    %esi
8010730a:	5f                   	pop    %edi
8010730b:	5d                   	pop    %ebp
8010730c:	c3                   	ret    
8010730d:	8d 76 00             	lea    0x0(%esi),%esi
80107310:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107313:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107316:	5b                   	pop    %ebx
80107317:	89 f8                	mov    %edi,%eax
80107319:	5e                   	pop    %esi
8010731a:	5f                   	pop    %edi
8010731b:	5d                   	pop    %ebp
8010731c:	c3                   	ret    
8010731d:	8d 76 00             	lea    0x0(%esi),%esi
80107320:	89 c1                	mov    %eax,%ecx
80107322:	8b 55 10             	mov    0x10(%ebp),%edx
80107325:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107328:	31 ff                	xor    %edi,%edi
8010732a:	e8 41 fb ff ff       	call   80106e70 <deallocuvm.part.0>
8010732f:	eb 92                	jmp    801072c3 <allocuvm+0xb3>
80107331:	eb 0d                	jmp    80107340 <deallocuvm>
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

80107340 <deallocuvm>:
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	8b 55 0c             	mov    0xc(%ebp),%edx
80107346:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107349:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010734c:	39 d1                	cmp    %edx,%ecx
8010734e:	73 10                	jae    80107360 <deallocuvm+0x20>
}
80107350:	5d                   	pop    %ebp
80107351:	e9 1a fb ff ff       	jmp    80106e70 <deallocuvm.part.0>
80107356:	8d 76 00             	lea    0x0(%esi),%esi
80107359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107360:	89 d0                	mov    %edx,%eax
80107362:	5d                   	pop    %ebp
80107363:	c3                   	ret    
80107364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010736a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107370 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	57                   	push   %edi
80107374:	56                   	push   %esi
80107375:	53                   	push   %ebx
80107376:	83 ec 0c             	sub    $0xc,%esp
80107379:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010737c:	85 f6                	test   %esi,%esi
8010737e:	74 59                	je     801073d9 <freevm+0x69>
80107380:	31 c9                	xor    %ecx,%ecx
80107382:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107387:	89 f0                	mov    %esi,%eax
80107389:	e8 e2 fa ff ff       	call   80106e70 <deallocuvm.part.0>
8010738e:	89 f3                	mov    %esi,%ebx
80107390:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107396:	eb 0f                	jmp    801073a7 <freevm+0x37>
80107398:	90                   	nop
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073a0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801073a3:	39 fb                	cmp    %edi,%ebx
801073a5:	74 23                	je     801073ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801073a7:	8b 03                	mov    (%ebx),%eax
801073a9:	a8 01                	test   $0x1,%al
801073ab:	74 f3                	je     801073a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801073ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801073b2:	83 ec 0c             	sub    $0xc,%esp
801073b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801073b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801073bd:	50                   	push   %eax
801073be:	e8 2d b0 ff ff       	call   801023f0 <kfree>
801073c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801073c6:	39 fb                	cmp    %edi,%ebx
801073c8:	75 dd                	jne    801073a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801073ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801073cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073d0:	5b                   	pop    %ebx
801073d1:	5e                   	pop    %esi
801073d2:	5f                   	pop    %edi
801073d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801073d4:	e9 17 b0 ff ff       	jmp    801023f0 <kfree>
    panic("freevm: no pgdir");
801073d9:	83 ec 0c             	sub    $0xc,%esp
801073dc:	68 09 81 10 80       	push   $0x80108109
801073e1:	e8 aa 8f ff ff       	call   80100390 <panic>
801073e6:	8d 76 00             	lea    0x0(%esi),%esi
801073e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073f0 <setupkvm>:
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	56                   	push   %esi
801073f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801073f5:	e8 a6 b1 ff ff       	call   801025a0 <kalloc>
801073fa:	85 c0                	test   %eax,%eax
801073fc:	89 c6                	mov    %eax,%esi
801073fe:	74 42                	je     80107442 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107400:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107403:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107408:	68 00 10 00 00       	push   $0x1000
8010740d:	6a 00                	push   $0x0
8010740f:	50                   	push   %eax
80107410:	e8 8b d6 ff ff       	call   80104aa0 <memset>
80107415:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107418:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010741b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010741e:	83 ec 08             	sub    $0x8,%esp
80107421:	8b 13                	mov    (%ebx),%edx
80107423:	ff 73 0c             	pushl  0xc(%ebx)
80107426:	50                   	push   %eax
80107427:	29 c1                	sub    %eax,%ecx
80107429:	89 f0                	mov    %esi,%eax
8010742b:	e8 b0 f9 ff ff       	call   80106de0 <mappages>
80107430:	83 c4 10             	add    $0x10,%esp
80107433:	85 c0                	test   %eax,%eax
80107435:	78 19                	js     80107450 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107437:	83 c3 10             	add    $0x10,%ebx
8010743a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107440:	75 d6                	jne    80107418 <setupkvm+0x28>
}
80107442:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107445:	89 f0                	mov    %esi,%eax
80107447:	5b                   	pop    %ebx
80107448:	5e                   	pop    %esi
80107449:	5d                   	pop    %ebp
8010744a:	c3                   	ret    
8010744b:	90                   	nop
8010744c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107450:	83 ec 0c             	sub    $0xc,%esp
80107453:	56                   	push   %esi
      return 0;
80107454:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107456:	e8 15 ff ff ff       	call   80107370 <freevm>
      return 0;
8010745b:	83 c4 10             	add    $0x10,%esp
}
8010745e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107461:	89 f0                	mov    %esi,%eax
80107463:	5b                   	pop    %ebx
80107464:	5e                   	pop    %esi
80107465:	5d                   	pop    %ebp
80107466:	c3                   	ret    
80107467:	89 f6                	mov    %esi,%esi
80107469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107470 <kvmalloc>:
{
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107476:	e8 75 ff ff ff       	call   801073f0 <setupkvm>
8010747b:	a3 c4 f1 11 80       	mov    %eax,0x8011f1c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107480:	05 00 00 00 80       	add    $0x80000000,%eax
80107485:	0f 22 d8             	mov    %eax,%cr3
}
80107488:	c9                   	leave  
80107489:	c3                   	ret    
8010748a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107490 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107490:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107491:	31 c9                	xor    %ecx,%ecx
{
80107493:	89 e5                	mov    %esp,%ebp
80107495:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107498:	8b 55 0c             	mov    0xc(%ebp),%edx
8010749b:	8b 45 08             	mov    0x8(%ebp),%eax
8010749e:	e8 bd f8 ff ff       	call   80106d60 <walkpgdir>
  if(pte == 0)
801074a3:	85 c0                	test   %eax,%eax
801074a5:	74 05                	je     801074ac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801074a7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801074aa:	c9                   	leave  
801074ab:	c3                   	ret    
    panic("clearpteu");
801074ac:	83 ec 0c             	sub    $0xc,%esp
801074af:	68 1a 81 10 80       	push   $0x8010811a
801074b4:	e8 d7 8e ff ff       	call   80100390 <panic>
801074b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801074c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801074c0:	55                   	push   %ebp
801074c1:	89 e5                	mov    %esp,%ebp
801074c3:	57                   	push   %edi
801074c4:	56                   	push   %esi
801074c5:	53                   	push   %ebx
801074c6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801074c9:	e8 22 ff ff ff       	call   801073f0 <setupkvm>
801074ce:	85 c0                	test   %eax,%eax
801074d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801074d3:	0f 84 9f 00 00 00    	je     80107578 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801074d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074dc:	85 c9                	test   %ecx,%ecx
801074de:	0f 84 94 00 00 00    	je     80107578 <copyuvm+0xb8>
801074e4:	31 ff                	xor    %edi,%edi
801074e6:	eb 4a                	jmp    80107532 <copyuvm+0x72>
801074e8:	90                   	nop
801074e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801074f0:	83 ec 04             	sub    $0x4,%esp
801074f3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801074f9:	68 00 10 00 00       	push   $0x1000
801074fe:	53                   	push   %ebx
801074ff:	50                   	push   %eax
80107500:	e8 4b d6 ff ff       	call   80104b50 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107505:	58                   	pop    %eax
80107506:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010750c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107511:	5a                   	pop    %edx
80107512:	ff 75 e4             	pushl  -0x1c(%ebp)
80107515:	50                   	push   %eax
80107516:	89 fa                	mov    %edi,%edx
80107518:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010751b:	e8 c0 f8 ff ff       	call   80106de0 <mappages>
80107520:	83 c4 10             	add    $0x10,%esp
80107523:	85 c0                	test   %eax,%eax
80107525:	78 61                	js     80107588 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107527:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010752d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107530:	76 46                	jbe    80107578 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107532:	8b 45 08             	mov    0x8(%ebp),%eax
80107535:	31 c9                	xor    %ecx,%ecx
80107537:	89 fa                	mov    %edi,%edx
80107539:	e8 22 f8 ff ff       	call   80106d60 <walkpgdir>
8010753e:	85 c0                	test   %eax,%eax
80107540:	74 61                	je     801075a3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107542:	8b 00                	mov    (%eax),%eax
80107544:	a8 01                	test   $0x1,%al
80107546:	74 4e                	je     80107596 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107548:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010754a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010754f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107555:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107558:	e8 43 b0 ff ff       	call   801025a0 <kalloc>
8010755d:	85 c0                	test   %eax,%eax
8010755f:	89 c6                	mov    %eax,%esi
80107561:	75 8d                	jne    801074f0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107563:	83 ec 0c             	sub    $0xc,%esp
80107566:	ff 75 e0             	pushl  -0x20(%ebp)
80107569:	e8 02 fe ff ff       	call   80107370 <freevm>
  return 0;
8010756e:	83 c4 10             	add    $0x10,%esp
80107571:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107578:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010757b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010757e:	5b                   	pop    %ebx
8010757f:	5e                   	pop    %esi
80107580:	5f                   	pop    %edi
80107581:	5d                   	pop    %ebp
80107582:	c3                   	ret    
80107583:	90                   	nop
80107584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107588:	83 ec 0c             	sub    $0xc,%esp
8010758b:	56                   	push   %esi
8010758c:	e8 5f ae ff ff       	call   801023f0 <kfree>
      goto bad;
80107591:	83 c4 10             	add    $0x10,%esp
80107594:	eb cd                	jmp    80107563 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107596:	83 ec 0c             	sub    $0xc,%esp
80107599:	68 3e 81 10 80       	push   $0x8010813e
8010759e:	e8 ed 8d ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801075a3:	83 ec 0c             	sub    $0xc,%esp
801075a6:	68 24 81 10 80       	push   $0x80108124
801075ab:	e8 e0 8d ff ff       	call   80100390 <panic>

801075b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801075b1:	31 c9                	xor    %ecx,%ecx
{
801075b3:	89 e5                	mov    %esp,%ebp
801075b5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801075b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801075bb:	8b 45 08             	mov    0x8(%ebp),%eax
801075be:	e8 9d f7 ff ff       	call   80106d60 <walkpgdir>
  if((*pte & PTE_P) == 0)
801075c3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801075c5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801075c6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801075c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801075cd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801075d0:	05 00 00 00 80       	add    $0x80000000,%eax
801075d5:	83 fa 05             	cmp    $0x5,%edx
801075d8:	ba 00 00 00 00       	mov    $0x0,%edx
801075dd:	0f 45 c2             	cmovne %edx,%eax
}
801075e0:	c3                   	ret    
801075e1:	eb 0d                	jmp    801075f0 <copyout>
801075e3:	90                   	nop
801075e4:	90                   	nop
801075e5:	90                   	nop
801075e6:	90                   	nop
801075e7:	90                   	nop
801075e8:	90                   	nop
801075e9:	90                   	nop
801075ea:	90                   	nop
801075eb:	90                   	nop
801075ec:	90                   	nop
801075ed:	90                   	nop
801075ee:	90                   	nop
801075ef:	90                   	nop

801075f0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	57                   	push   %edi
801075f4:	56                   	push   %esi
801075f5:	53                   	push   %ebx
801075f6:	83 ec 1c             	sub    $0x1c,%esp
801075f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801075fc:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107602:	85 db                	test   %ebx,%ebx
80107604:	75 40                	jne    80107646 <copyout+0x56>
80107606:	eb 70                	jmp    80107678 <copyout+0x88>
80107608:	90                   	nop
80107609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107610:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107613:	89 f1                	mov    %esi,%ecx
80107615:	29 d1                	sub    %edx,%ecx
80107617:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010761d:	39 d9                	cmp    %ebx,%ecx
8010761f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107622:	29 f2                	sub    %esi,%edx
80107624:	83 ec 04             	sub    $0x4,%esp
80107627:	01 d0                	add    %edx,%eax
80107629:	51                   	push   %ecx
8010762a:	57                   	push   %edi
8010762b:	50                   	push   %eax
8010762c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010762f:	e8 1c d5 ff ff       	call   80104b50 <memmove>
    len -= n;
    buf += n;
80107634:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107637:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010763a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107640:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107642:	29 cb                	sub    %ecx,%ebx
80107644:	74 32                	je     80107678 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107646:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107648:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010764b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010764e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107654:	56                   	push   %esi
80107655:	ff 75 08             	pushl  0x8(%ebp)
80107658:	e8 53 ff ff ff       	call   801075b0 <uva2ka>
    if(pa0 == 0)
8010765d:	83 c4 10             	add    $0x10,%esp
80107660:	85 c0                	test   %eax,%eax
80107662:	75 ac                	jne    80107610 <copyout+0x20>
  }
  return 0;
}
80107664:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010766c:	5b                   	pop    %ebx
8010766d:	5e                   	pop    %esi
8010766e:	5f                   	pop    %edi
8010766f:	5d                   	pop    %ebp
80107670:	c3                   	ret    
80107671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107678:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010767b:	31 c0                	xor    %eax,%eax
}
8010767d:	5b                   	pop    %ebx
8010767e:	5e                   	pop    %esi
8010767f:	5f                   	pop    %edi
80107680:	5d                   	pop    %ebp
80107681:	c3                   	ret    
