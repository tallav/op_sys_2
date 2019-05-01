
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
8010004c:	68 40 7a 10 80       	push   $0x80107a40
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 b5 4a 00 00       	call   80104b10 <initlock>
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
80100092:	68 47 7a 10 80       	push   $0x80107a47
80100097:	50                   	push   %eax
80100098:	e8 43 49 00 00       	call   801049e0 <initsleeplock>
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
801000e4:	e8 67 4b 00 00       	call   80104c50 <acquire>
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
80100162:	e8 a9 4b 00 00       	call   80104d10 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 48 00 00       	call   80104a20 <acquiresleep>
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
80100193:	68 4e 7a 10 80       	push   $0x80107a4e
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
801001ae:	e8 0d 49 00 00       	call   80104ac0 <holdingsleep>
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
801001cc:	68 5f 7a 10 80       	push   $0x80107a5f
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
801001ef:	e8 cc 48 00 00       	call   80104ac0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 7c 48 00 00       	call   80104a80 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 40 4a 00 00       	call   80104c50 <acquire>
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
8010025c:	e9 af 4a 00 00       	jmp    80104d10 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 7a 10 80       	push   $0x80107a66
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
8010028c:	e8 bf 49 00 00       	call   80104c50 <acquire>
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
801002c5:	e8 66 3d 00 00       	call   80104030 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 0f 11 80    	cmp    0x80110fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 90 36 00 00       	call   80103970 <myproc>
801002e0:	8b 40 14             	mov    0x14(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 1c 4a 00 00       	call   80104d10 <release>
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
8010034d:	e8 be 49 00 00       	call   80104d10 <release>
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
801003b2:	68 6d 7a 10 80       	push   $0x80107a6d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 17 84 10 80 	movl   $0x80108417,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 53 47 00 00       	call   80104b30 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 7a 10 80       	push   $0x80107a81
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
8010043a:	e8 11 62 00 00       	call   80106650 <uartputc>
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
801004ec:	e8 5f 61 00 00       	call   80106650 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 53 61 00 00       	call   80106650 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 47 61 00 00       	call   80106650 <uartputc>
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
80100524:	e8 e7 48 00 00       	call   80104e10 <memmove>
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
80100541:	e8 1a 48 00 00       	call   80104d60 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 7a 10 80       	push   $0x80107a85
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
801005b1:	0f b6 92 b0 7a 10 80 	movzbl -0x7fef8550(%edx),%edx
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
8010061b:	e8 30 46 00 00       	call   80104c50 <acquire>
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
80100647:	e8 c4 46 00 00       	call   80104d10 <release>
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
8010071f:	e8 ec 45 00 00       	call   80104d10 <release>
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
801007d0:	ba 98 7a 10 80       	mov    $0x80107a98,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 5b 44 00 00       	call   80104c50 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 7a 10 80       	push   $0x80107a9f
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
80100823:	e8 28 44 00 00       	call   80104c50 <acquire>
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
80100888:	e8 83 44 00 00       	call   80104d10 <release>
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
80100916:	e8 65 39 00 00       	call   80104280 <wakeup>
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
80100997:	e9 84 39 00 00       	jmp    80104320 <procdump>
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
801009c6:	68 a8 7a 10 80       	push   $0x80107aa8
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 3b 41 00 00       	call   80104b10 <initlock>

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
80100a1c:	e8 4f 2f 00 00       	call   80103970 <myproc>
80100a21:	89 c7                	mov    %eax,%edi
  struct kthread *curthread = mythread();
80100a23:	e8 78 2f 00 00       	call   801039a0 <mythread>

  // check if you got exit request before executing
  if(curthread->exitRequest == 1){
80100a28:	83 78 20 01          	cmpl   $0x1,0x20(%eax)
80100a2c:	0f 84 cd 01 00 00    	je     80100bff <exec+0x1ef>
    kthread_exit();
    return -1;
  }else{
    acquire(&ptable.lock);
80100a32:	83 ec 0c             	sub    $0xc,%esp
80100a35:	89 c3                	mov    %eax,%ebx
80100a37:	68 80 4e 11 80       	push   $0x80114e80
80100a3c:	e8 0f 42 00 00       	call   80104c50 <acquire>
    struct kthread *t;
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80100a41:	8b 57 6c             	mov    0x6c(%edi),%edx
80100a44:	83 c4 10             	add    $0x10,%esp
80100a47:	89 d6                	mov    %edx,%esi
80100a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80100a50:	39 f3                	cmp    %esi,%ebx
80100a52:	74 2c                	je     80100a80 <exec+0x70>
80100a54:	8b 46 08             	mov    0x8(%esi),%eax
80100a57:	83 f8 05             	cmp    $0x5,%eax
80100a5a:	74 24                	je     80100a80 <exec+0x70>
80100a5c:	85 c0                	test   %eax,%eax
80100a5e:	74 20                	je     80100a80 <exec+0x70>
        t->exitRequest = 1;
        kthread_join(t->tid);
80100a60:	83 ec 0c             	sub    $0xc,%esp
        t->exitRequest = 1;
80100a63:	c7 46 20 01 00 00 00 	movl   $0x1,0x20(%esi)
        kthread_join(t->tid);
80100a6a:	ff 76 0c             	pushl  0xc(%esi)
80100a6d:	e8 ce 3b 00 00       	call   80104640 <kthread_join>
80100a72:	8b 57 6c             	mov    0x6c(%edi),%edx
80100a75:	83 c4 10             	add    $0x10,%esp
80100a78:	90                   	nop
80100a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80100a80:	8d 82 40 02 00 00    	lea    0x240(%edx),%eax
80100a86:	83 c6 24             	add    $0x24,%esi
80100a89:	39 c6                	cmp    %eax,%esi
80100a8b:	72 c3                	jb     80100a50 <exec+0x40>
      }
    }
    release(&ptable.lock);
80100a8d:	83 ec 0c             	sub    $0xc,%esp
80100a90:	68 80 4e 11 80       	push   $0x80114e80
80100a95:	e8 76 42 00 00       	call   80104d10 <release>
      allTerminated = 1;
    }
  }
  release(&ptable.lock);
  */
  begin_op();
80100a9a:	e8 e1 21 00 00       	call   80102c80 <begin_op>

  if((ip = namei(path)) == 0){
80100a9f:	59                   	pop    %ecx
80100aa0:	ff 75 08             	pushl  0x8(%ebp)
80100aa3:	e8 18 15 00 00       	call   80101fc0 <namei>
80100aa8:	83 c4 10             	add    $0x10,%esp
80100aab:	85 c0                	test   %eax,%eax
80100aad:	89 c6                	mov    %eax,%esi
80100aaf:	0f 84 d7 01 00 00    	je     80100c8c <exec+0x27c>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ab5:	83 ec 0c             	sub    $0xc,%esp
80100ab8:	50                   	push   %eax
80100ab9:	e8 a2 0c 00 00       	call   80101760 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100abe:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ac4:	6a 34                	push   $0x34
80100ac6:	6a 00                	push   $0x0
80100ac8:	50                   	push   %eax
80100ac9:	56                   	push   %esi
80100aca:	e8 71 0f 00 00       	call   80101a40 <readi>
80100acf:	83 c4 20             	add    $0x20,%esp
80100ad2:	83 f8 34             	cmp    $0x34,%eax
80100ad5:	74 21                	je     80100af8 <exec+0xe8>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ad7:	83 ec 0c             	sub    $0xc,%esp
80100ada:	56                   	push   %esi
80100adb:	e8 10 0f 00 00       	call   801019f0 <iunlockput>
    end_op();
80100ae0:	e8 0b 22 00 00       	call   80102cf0 <end_op>
80100ae5:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ae8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100aed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100af0:	5b                   	pop    %ebx
80100af1:	5e                   	pop    %esi
80100af2:	5f                   	pop    %edi
80100af3:	5d                   	pop    %ebp
80100af4:	c3                   	ret    
80100af5:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100af8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aff:	45 4c 46 
80100b02:	75 d3                	jne    80100ad7 <exec+0xc7>
  if((pgdir = setupkvm()) == 0)
80100b04:	e8 97 6c 00 00       	call   801077a0 <setupkvm>
80100b09:	85 c0                	test   %eax,%eax
80100b0b:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b11:	74 c4                	je     80100ad7 <exec+0xc7>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b13:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b1a:	00 
80100b1b:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100b21:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b27:	0f 84 db 02 00 00    	je     80100e08 <exec+0x3f8>
  sz = 0;
80100b2d:	31 c9                	xor    %ecx,%ecx
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b2f:	31 c0                	xor    %eax,%eax
80100b31:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100b37:	89 9d e8 fe ff ff    	mov    %ebx,-0x118(%ebp)
80100b3d:	89 cf                	mov    %ecx,%edi
80100b3f:	89 c3                	mov    %eax,%ebx
80100b41:	eb 7f                	jmp    80100bc2 <exec+0x1b2>
80100b43:	90                   	nop
80100b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b48:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b4f:	75 63                	jne    80100bb4 <exec+0x1a4>
    if(ph.memsz < ph.filesz)
80100b51:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b57:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b5d:	0f 82 86 00 00 00    	jb     80100be9 <exec+0x1d9>
80100b63:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b69:	72 7e                	jb     80100be9 <exec+0x1d9>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b6b:	83 ec 04             	sub    $0x4,%esp
80100b6e:	50                   	push   %eax
80100b6f:	57                   	push   %edi
80100b70:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b76:	e8 45 6a 00 00       	call   801075c0 <allocuvm>
80100b7b:	83 c4 10             	add    $0x10,%esp
80100b7e:	85 c0                	test   %eax,%eax
80100b80:	89 c7                	mov    %eax,%edi
80100b82:	74 65                	je     80100be9 <exec+0x1d9>
    if(ph.vaddr % PGSIZE != 0)
80100b84:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b8a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b8f:	75 58                	jne    80100be9 <exec+0x1d9>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b9a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100ba0:	56                   	push   %esi
80100ba1:	50                   	push   %eax
80100ba2:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba8:	e8 53 69 00 00       	call   80107500 <loaduvm>
80100bad:	83 c4 20             	add    $0x20,%esp
80100bb0:	85 c0                	test   %eax,%eax
80100bb2:	78 35                	js     80100be9 <exec+0x1d9>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb4:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bbb:	83 c3 01             	add    $0x1,%ebx
80100bbe:	39 d8                	cmp    %ebx,%eax
80100bc0:	7e 4c                	jle    80100c0e <exec+0x1fe>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bc2:	89 d8                	mov    %ebx,%eax
80100bc4:	6a 20                	push   $0x20
80100bc6:	c1 e0 05             	shl    $0x5,%eax
80100bc9:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100bcf:	50                   	push   %eax
80100bd0:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bd6:	50                   	push   %eax
80100bd7:	56                   	push   %esi
80100bd8:	e8 63 0e 00 00       	call   80101a40 <readi>
80100bdd:	83 c4 10             	add    $0x10,%esp
80100be0:	83 f8 20             	cmp    $0x20,%eax
80100be3:	0f 84 5f ff ff ff    	je     80100b48 <exec+0x138>
    freevm(pgdir);
80100be9:	83 ec 0c             	sub    $0xc,%esp
80100bec:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bf2:	e8 29 6b 00 00       	call   80107720 <freevm>
80100bf7:	83 c4 10             	add    $0x10,%esp
80100bfa:	e9 d8 fe ff ff       	jmp    80100ad7 <exec+0xc7>
    kthread_exit();
80100bff:	e8 5c 39 00 00       	call   80104560 <kthread_exit>
    return -1;
80100c04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c09:	e9 df fe ff ff       	jmp    80100aed <exec+0xdd>
80100c0e:	89 f8                	mov    %edi,%eax
80100c10:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100c16:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100c1c:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c21:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100c26:	89 c2                	mov    %eax,%edx
80100c28:	8d 80 00 20 00 00    	lea    0x2000(%eax),%eax
  iunlockput(ip);
80100c2e:	83 ec 0c             	sub    $0xc,%esp
80100c31:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100c37:	89 95 f0 fe ff ff    	mov    %edx,-0x110(%ebp)
80100c3d:	56                   	push   %esi
80100c3e:	e8 ad 0d 00 00       	call   801019f0 <iunlockput>
  end_op();
80100c43:	e8 a8 20 00 00       	call   80102cf0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c48:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c4e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c54:	83 c4 0c             	add    $0xc,%esp
80100c57:	50                   	push   %eax
80100c58:	52                   	push   %edx
80100c59:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c5f:	e8 5c 69 00 00       	call   801075c0 <allocuvm>
80100c64:	83 c4 10             	add    $0x10,%esp
80100c67:	85 c0                	test   %eax,%eax
80100c69:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c6f:	75 3a                	jne    80100cab <exec+0x29b>
    freevm(pgdir);
80100c71:	83 ec 0c             	sub    $0xc,%esp
80100c74:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c7a:	e8 a1 6a 00 00       	call   80107720 <freevm>
80100c7f:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c87:	e9 61 fe ff ff       	jmp    80100aed <exec+0xdd>
    end_op();
80100c8c:	e8 5f 20 00 00       	call   80102cf0 <end_op>
    cprintf("exec: fail\n");
80100c91:	83 ec 0c             	sub    $0xc,%esp
80100c94:	68 c1 7a 10 80       	push   $0x80107ac1
80100c99:	e8 c2 f9 ff ff       	call   80100660 <cprintf>
    return -1;
80100c9e:	83 c4 10             	add    $0x10,%esp
80100ca1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ca6:	e9 42 fe ff ff       	jmp    80100aed <exec+0xdd>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cab:	89 c6                	mov    %eax,%esi
80100cad:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100cb3:	83 ec 08             	sub    $0x8,%esp
80100cb6:	50                   	push   %eax
80100cb7:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cbd:	e8 7e 6b 00 00       	call   80107840 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cc2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc5:	83 c4 10             	add    $0x10,%esp
80100cc8:	31 d2                	xor    %edx,%edx
80100cca:	8b 00                	mov    (%eax),%eax
80100ccc:	85 c0                	test   %eax,%eax
80100cce:	0f 84 40 01 00 00    	je     80100e14 <exec+0x404>
80100cd4:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100cda:	89 d7                	mov    %edx,%edi
80100cdc:	eb 05                	jmp    80100ce3 <exec+0x2d3>
    if(argc >= MAXARG)
80100cde:	83 ff 20             	cmp    $0x20,%edi
80100ce1:	74 8e                	je     80100c71 <exec+0x261>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce3:	83 ec 0c             	sub    $0xc,%esp
80100ce6:	50                   	push   %eax
80100ce7:	e8 94 42 00 00       	call   80104f80 <strlen>
80100cec:	f7 d0                	not    %eax
80100cee:	01 c6                	add    %eax,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf4:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf7:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cfa:	e8 81 42 00 00       	call   80104f80 <strlen>
80100cff:	83 c0 01             	add    $0x1,%eax
80100d02:	50                   	push   %eax
80100d03:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d06:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d09:	56                   	push   %esi
80100d0a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d10:	e8 8b 6c 00 00       	call   801079a0 <copyout>
80100d15:	83 c4 20             	add    $0x20,%esp
80100d18:	85 c0                	test   %eax,%eax
80100d1a:	0f 88 51 ff ff ff    	js     80100c71 <exec+0x261>
  for(argc = 0; argv[argc]; argc++) {
80100d20:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d23:	89 b4 bd 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d2a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d2d:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100d33:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d36:	85 c0                	test   %eax,%eax
80100d38:	75 a4                	jne    80100cde <exec+0x2ce>
80100d3a:	89 fa                	mov    %edi,%edx
80100d3c:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d42:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[3+argc] = 0;
80100d49:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100d50:	00 00 00 00 
  ustack[1] = argc;
80100d54:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5a:	89 f2                	mov    %esi,%edx
  ustack[0] = 0xffffffff;  // fake return PC
80100d5c:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d63:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d66:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100d68:	83 c0 0c             	add    $0xc,%eax
80100d6b:	29 c6                	sub    %eax,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d6d:	50                   	push   %eax
80100d6e:	51                   	push   %ecx
80100d6f:	56                   	push   %esi
80100d70:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d76:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d7c:	e8 1f 6c 00 00       	call   801079a0 <copyout>
80100d81:	83 c4 10             	add    $0x10,%esp
80100d84:	85 c0                	test   %eax,%eax
80100d86:	0f 88 e5 fe ff ff    	js     80100c71 <exec+0x261>
  for(last=s=path; *s; s++)
80100d8c:	8b 45 08             	mov    0x8(%ebp),%eax
80100d8f:	0f b6 00             	movzbl (%eax),%eax
80100d92:	84 c0                	test   %al,%al
80100d94:	74 17                	je     80100dad <exec+0x39d>
80100d96:	8b 55 08             	mov    0x8(%ebp),%edx
80100d99:	89 d1                	mov    %edx,%ecx
80100d9b:	83 c1 01             	add    $0x1,%ecx
80100d9e:	3c 2f                	cmp    $0x2f,%al
80100da0:	0f b6 01             	movzbl (%ecx),%eax
80100da3:	0f 44 d1             	cmove  %ecx,%edx
80100da6:	84 c0                	test   %al,%al
80100da8:	75 f1                	jne    80100d9b <exec+0x38b>
80100daa:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100dad:	50                   	push   %eax
80100dae:	8d 47 5c             	lea    0x5c(%edi),%eax
80100db1:	6a 10                	push   $0x10
80100db3:	ff 75 08             	pushl  0x8(%ebp)
80100db6:	50                   	push   %eax
80100db7:	e8 84 41 00 00       	call   80104f40 <safestrcpy>
  oldpgdir = curproc->pgdir;
80100dbc:	8b 47 04             	mov    0x4(%edi),%eax
80100dbf:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  curproc->pgdir = pgdir;
80100dc5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100dcb:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100dce:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100dd4:	89 07                	mov    %eax,(%edi)
  curthread->tf->eip = elf.entry;  // main
80100dd6:	8b 53 14             	mov    0x14(%ebx),%edx
80100dd9:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100ddf:	89 4a 38             	mov    %ecx,0x38(%edx)
  curthread->tf->esp = sp;
80100de2:	8b 53 14             	mov    0x14(%ebx),%edx
80100de5:	89 72 44             	mov    %esi,0x44(%edx)
  switchuvm(curproc);
80100de8:	89 3c 24             	mov    %edi,(%esp)
80100deb:	e8 80 65 00 00       	call   80107370 <switchuvm>
  freevm(oldpgdir);
80100df0:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100df6:	89 04 24             	mov    %eax,(%esp)
80100df9:	e8 22 69 00 00       	call   80107720 <freevm>
  return 0;
80100dfe:	83 c4 10             	add    $0x10,%esp
80100e01:	31 c0                	xor    %eax,%eax
80100e03:	e9 e5 fc ff ff       	jmp    80100aed <exec+0xdd>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e08:	31 d2                	xor    %edx,%edx
80100e0a:	b8 00 20 00 00       	mov    $0x2000,%eax
80100e0f:	e9 1a fe ff ff       	jmp    80100c2e <exec+0x21e>
  for(argc = 0; argv[argc]; argc++) {
80100e14:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100e1a:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e20:	e9 1d ff ff ff       	jmp    80100d42 <exec+0x332>
80100e25:	66 90                	xchg   %ax,%ax
80100e27:	66 90                	xchg   %ax,%ax
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
80100e36:	68 cd 7a 10 80       	push   $0x80107acd
80100e3b:	68 c0 0f 11 80       	push   $0x80110fc0
80100e40:	e8 cb 3c 00 00       	call   80104b10 <initlock>
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
80100e61:	e8 ea 3d 00 00       	call   80104c50 <acquire>
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
80100e91:	e8 7a 3e 00 00       	call   80104d10 <release>
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
80100eaa:	e8 61 3e 00 00       	call   80104d10 <release>
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
80100ecf:	e8 7c 3d 00 00       	call   80104c50 <acquire>
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
80100eec:	e8 1f 3e 00 00       	call   80104d10 <release>
  return f;
}
80100ef1:	89 d8                	mov    %ebx,%eax
80100ef3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ef6:	c9                   	leave  
80100ef7:	c3                   	ret    
    panic("filedup");
80100ef8:	83 ec 0c             	sub    $0xc,%esp
80100efb:	68 d4 7a 10 80       	push   $0x80107ad4
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
80100f21:	e8 2a 3d 00 00       	call   80104c50 <acquire>
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
80100f4c:	e9 bf 3d 00 00       	jmp    80104d10 <release>
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
80100f78:	e8 93 3d 00 00       	call   80104d10 <release>
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
80100fd2:	68 dc 7a 10 80       	push   $0x80107adc
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
801010b2:	68 e6 7a 10 80       	push   $0x80107ae6
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
801011c5:	68 ef 7a 10 80       	push   $0x80107aef
801011ca:	e8 c1 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	68 f5 7a 10 80       	push   $0x80107af5
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
80101284:	68 ff 7a 10 80       	push   $0x80107aff
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
801012c5:	e8 96 3a 00 00       	call   80104d60 <memset>
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
8010130a:	e8 41 39 00 00       	call   80104c50 <acquire>
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
8010136f:	e8 9c 39 00 00       	call   80104d10 <release>

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
8010139d:	e8 6e 39 00 00       	call   80104d10 <release>
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
801013b2:	68 15 7b 10 80       	push   $0x80107b15
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
80101487:	68 25 7b 10 80       	push   $0x80107b25
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
801014c1:	e8 4a 39 00 00       	call   80104e10 <memmove>
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
80101554:	68 38 7b 10 80       	push   $0x80107b38
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
8010156c:	68 4b 7b 10 80       	push   $0x80107b4b
80101571:	68 e0 19 11 80       	push   $0x801119e0
80101576:	e8 95 35 00 00       	call   80104b10 <initlock>
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 52 7b 10 80       	push   $0x80107b52
80101588:	53                   	push   %ebx
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010158f:	e8 4c 34 00 00       	call   801049e0 <initsleeplock>
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
801015d9:	68 b8 7b 10 80       	push   $0x80107bb8
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
8010166e:	e8 ed 36 00 00       	call   80104d60 <memset>
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
801016a3:	68 58 7b 10 80       	push   $0x80107b58
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
80101711:	e8 fa 36 00 00       	call   80104e10 <memmove>
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
8010173f:	e8 0c 35 00 00       	call   80104c50 <acquire>
  ip->ref++;
80101744:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101748:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010174f:	e8 bc 35 00 00       	call   80104d10 <release>
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
80101782:	e8 99 32 00 00       	call   80104a20 <acquiresleep>
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
801017f8:	e8 13 36 00 00       	call   80104e10 <memmove>
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
8010181d:	68 70 7b 10 80       	push   $0x80107b70
80101822:	e8 69 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101827:	83 ec 0c             	sub    $0xc,%esp
8010182a:	68 6a 7b 10 80       	push   $0x80107b6a
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
80101853:	e8 68 32 00 00       	call   80104ac0 <holdingsleep>
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
8010186f:	e9 0c 32 00 00       	jmp    80104a80 <releasesleep>
    panic("iunlock");
80101874:	83 ec 0c             	sub    $0xc,%esp
80101877:	68 7f 7b 10 80       	push   $0x80107b7f
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
801018a0:	e8 7b 31 00 00       	call   80104a20 <acquiresleep>
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
801018ba:	e8 c1 31 00 00       	call   80104a80 <releasesleep>
  acquire(&icache.lock);
801018bf:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801018c6:	e8 85 33 00 00       	call   80104c50 <acquire>
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
801018e0:	e9 2b 34 00 00       	jmp    80104d10 <release>
801018e5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018e8:	83 ec 0c             	sub    $0xc,%esp
801018eb:	68 e0 19 11 80       	push   $0x801119e0
801018f0:	e8 5b 33 00 00       	call   80104c50 <acquire>
    int r = ip->ref;
801018f5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018f8:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801018ff:	e8 0c 34 00 00       	call   80104d10 <release>
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
80101ae7:	e8 24 33 00 00       	call   80104e10 <memmove>
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
80101be3:	e8 28 32 00 00       	call   80104e10 <memmove>
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
80101c7e:	e8 fd 31 00 00       	call   80104e80 <strncmp>
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
80101cdd:	e8 9e 31 00 00       	call   80104e80 <strncmp>
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
80101d22:	68 99 7b 10 80       	push   $0x80107b99
80101d27:	e8 64 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d2c:	83 ec 0c             	sub    $0xc,%esp
80101d2f:	68 87 7b 10 80       	push   $0x80107b87
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
80101d59:	e8 12 1c 00 00       	call   80103970 <myproc>
  acquire(&icache.lock);
80101d5e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d61:	8b 70 58             	mov    0x58(%eax),%esi
  acquire(&icache.lock);
80101d64:	68 e0 19 11 80       	push   $0x801119e0
80101d69:	e8 e2 2e 00 00       	call   80104c50 <acquire>
  ip->ref++;
80101d6e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d72:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101d79:	e8 92 2f 00 00       	call   80104d10 <release>
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
80101dd5:	e8 36 30 00 00       	call   80104e10 <memmove>
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
80101e68:	e8 a3 2f 00 00       	call   80104e10 <memmove>
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
80101f5d:	e8 7e 2f 00 00       	call   80104ee0 <strncpy>
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
80101f9b:	68 a8 7b 10 80       	push   $0x80107ba8
80101fa0:	e8 eb e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101fa5:	83 ec 0c             	sub    $0xc,%esp
80101fa8:	68 fe 81 10 80       	push   $0x801081fe
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
801020bb:	68 14 7c 10 80       	push   $0x80107c14
801020c0:	e8 cb e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020c5:	83 ec 0c             	sub    $0xc,%esp
801020c8:	68 0b 7c 10 80       	push   $0x80107c0b
801020cd:	e8 be e2 ff ff       	call   80100390 <panic>
801020d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020e6:	68 26 7c 10 80       	push   $0x80107c26
801020eb:	68 80 b5 10 80       	push   $0x8010b580
801020f0:	e8 1b 2a 00 00       	call   80104b10 <initlock>
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
8010216e:	e8 dd 2a 00 00       	call   80104c50 <acquire>

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
801021d1:	e8 aa 20 00 00       	call   80104280 <wakeup>

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
801021ef:	e8 1c 2b 00 00       	call   80104d10 <release>

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
8010220e:	e8 ad 28 00 00       	call   80104ac0 <holdingsleep>
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
80102248:	e8 03 2a 00 00       	call   80104c50 <acquire>

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
80102299:	e8 92 1d 00 00       	call   80104030 <sleep>
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
801022b6:	e9 55 2a 00 00       	jmp    80104d10 <release>
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
801022da:	68 40 7c 10 80       	push   $0x80107c40
801022df:	e8 ac e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022e4:	83 ec 0c             	sub    $0xc,%esp
801022e7:	68 2a 7c 10 80       	push   $0x80107c2a
801022ec:	e8 9f e0 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801022f1:	83 ec 0c             	sub    $0xc,%esp
801022f4:	68 55 7c 10 80       	push   $0x80107c55
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
80102347:	68 74 7c 10 80       	push   $0x80107c74
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
80102402:	81 fb 08 03 12 80    	cmp    $0x80120308,%ebx
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
80102422:	e8 39 29 00 00       	call   80104d60 <memset>

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
8010245b:	e9 b0 28 00 00       	jmp    80104d10 <release>
    acquire(&kmem.lock);
80102460:	83 ec 0c             	sub    $0xc,%esp
80102463:	68 40 36 11 80       	push   $0x80113640
80102468:	e8 e3 27 00 00       	call   80104c50 <acquire>
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	eb c2                	jmp    80102434 <kfree+0x44>
    panic("kfree");
80102472:	83 ec 0c             	sub    $0xc,%esp
80102475:	68 a6 7c 10 80       	push   $0x80107ca6
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
801024db:	68 ac 7c 10 80       	push   $0x80107cac
801024e0:	68 40 36 11 80       	push   $0x80113640
801024e5:	e8 26 26 00 00       	call   80104b10 <initlock>
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
801025d3:	e8 78 26 00 00       	call   80104c50 <acquire>
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
80102601:	e8 0a 27 00 00       	call   80104d10 <release>
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
80102653:	0f b6 82 e0 7d 10 80 	movzbl -0x7fef8220(%edx),%eax
8010265a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010265c:	0f b6 82 e0 7c 10 80 	movzbl -0x7fef8320(%edx),%eax
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
80102673:	8b 04 85 c0 7c 10 80 	mov    -0x7fef8340(,%eax,4),%eax
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
80102698:	0f b6 82 e0 7d 10 80 	movzbl -0x7fef8220(%edx),%eax
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
80102a17:	e8 94 23 00 00       	call   80104db0 <memcmp>
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
80102b44:	e8 c7 22 00 00       	call   80104e10 <memmove>
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
80102bea:	68 e0 7e 10 80       	push   $0x80107ee0
80102bef:	68 80 36 11 80       	push   $0x80113680
80102bf4:	e8 17 1f 00 00       	call   80104b10 <initlock>
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
80102c8b:	e8 c0 1f 00 00       	call   80104c50 <acquire>
80102c90:	83 c4 10             	add    $0x10,%esp
80102c93:	eb 18                	jmp    80102cad <begin_op+0x2d>
80102c95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c98:	83 ec 08             	sub    $0x8,%esp
80102c9b:	68 80 36 11 80       	push   $0x80113680
80102ca0:	68 80 36 11 80       	push   $0x80113680
80102ca5:	e8 86 13 00 00       	call   80104030 <sleep>
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
80102cdc:	e8 2f 20 00 00       	call   80104d10 <release>
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
80102cfe:	e8 4d 1f 00 00       	call   80104c50 <acquire>
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
80102d3c:	e8 cf 1f 00 00       	call   80104d10 <release>
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
80102d96:	e8 75 20 00 00       	call   80104e10 <memmove>
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
80102ddf:	e8 6c 1e 00 00       	call   80104c50 <acquire>
    wakeup(&log);
80102de4:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
    log.committing = 0;
80102deb:	c7 05 c0 36 11 80 00 	movl   $0x0,0x801136c0
80102df2:	00 00 00 
    wakeup(&log);
80102df5:	e8 86 14 00 00       	call   80104280 <wakeup>
    release(&log.lock);
80102dfa:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102e01:	e8 0a 1f 00 00       	call   80104d10 <release>
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
80102e20:	e8 5b 14 00 00       	call   80104280 <wakeup>
  release(&log.lock);
80102e25:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102e2c:	e8 df 1e 00 00       	call   80104d10 <release>
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
80102e3f:	68 e4 7e 10 80       	push   $0x80107ee4
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
80102e8e:	e8 bd 1d 00 00       	call   80104c50 <acquire>
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
80102edd:	e9 2e 1e 00 00       	jmp    80104d10 <release>
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
80102f09:	68 f3 7e 10 80       	push   $0x80107ef3
80102f0e:	e8 7d d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f13:	83 ec 0c             	sub    $0xc,%esp
80102f16:	68 09 7f 10 80       	push   $0x80107f09
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
80102f27:	e8 24 0a 00 00       	call   80103950 <cpuid>
80102f2c:	89 c3                	mov    %eax,%ebx
80102f2e:	e8 1d 0a 00 00       	call   80103950 <cpuid>
80102f33:	83 ec 04             	sub    $0x4,%esp
80102f36:	53                   	push   %ebx
80102f37:	50                   	push   %eax
80102f38:	68 24 7f 10 80       	push   $0x80107f24
80102f3d:	e8 1e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f42:	e8 29 32 00 00       	call   80106170 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f47:	e8 84 09 00 00       	call   801038d0 <mycpu>
80102f4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f5a:	e8 71 0d 00 00       	call   80103cd0 <scheduler>
80102f5f:	90                   	nop

80102f60 <mpenter>:
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f66:	e8 e5 43 00 00       	call   80107350 <switchkvm>
  seginit();
80102f6b:	e8 50 43 00 00       	call   801072c0 <seginit>
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
80102f97:	68 08 03 12 80       	push   $0x80120308
80102f9c:	e8 2f f5 ff ff       	call   801024d0 <kinit1>
  kvmalloc();      // kernel page table
80102fa1:	e8 7a 48 00 00       	call   80107820 <kvmalloc>
  mpinit();        // detect other processors
80102fa6:	e8 75 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102fab:	e8 60 f7 ff ff       	call   80102710 <lapicinit>
  seginit();       // segment descriptors
80102fb0:	e8 0b 43 00 00       	call   801072c0 <seginit>
  picinit();       // disable pic
80102fb5:	e8 46 03 00 00       	call   80103300 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 41 f3 ff ff       	call   80102300 <ioapicinit>
  consoleinit();   // console hardware
80102fbf:	e8 fc d9 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102fc4:	e8 c7 35 00 00       	call   80106590 <uartinit>
  pinit();         // process table
80102fc9:	e8 d2 08 00 00       	call   801038a0 <pinit>
  tvinit();        // trap vectors
80102fce:	e8 1d 31 00 00       	call   801060f0 <tvinit>
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
80102ff4:	e8 17 1e 00 00       	call   80104e10 <memmove>

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
80103020:	e8 ab 08 00 00       	call   801038d0 <mycpu>
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
80103095:	e8 36 09 00 00       	call   801039d0 <userinit>
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
801030ce:	68 38 7f 10 80       	push   $0x80107f38
801030d3:	56                   	push   %esi
801030d4:	e8 d7 1c 00 00       	call   80104db0 <memcmp>
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
8010318c:	68 55 7f 10 80       	push   $0x80107f55
80103191:	56                   	push   %esi
80103192:	e8 19 1c 00 00       	call   80104db0 <memcmp>
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
80103220:	ff 24 95 7c 7f 10 80 	jmp    *-0x7fef8084(,%edx,4)
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
801032d3:	68 3d 7f 10 80       	push   $0x80107f3d
801032d8:	e8 b3 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801032dd:	83 ec 0c             	sub    $0xc,%esp
801032e0:	68 5c 7f 10 80       	push   $0x80107f5c
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
801033db:	68 90 7f 10 80       	push   $0x80107f90
801033e0:	50                   	push   %eax
801033e1:	e8 2a 17 00 00       	call   80104b10 <initlock>
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
8010343f:	e8 0c 18 00 00       	call   80104c50 <acquire>
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
8010345f:	e8 1c 0e 00 00       	call   80104280 <wakeup>
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
80103484:	e9 87 18 00 00       	jmp    80104d10 <release>
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103490:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103496:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103499:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034a0:	00 00 00 
    wakeup(&p->nwrite);
801034a3:	50                   	push   %eax
801034a4:	e8 d7 0d 00 00       	call   80104280 <wakeup>
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	eb b9                	jmp    80103467 <pipeclose+0x37>
801034ae:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 57 18 00 00       	call   80104d10 <release>
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
801034dd:	e8 6e 17 00 00       	call   80104c50 <acquire>
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
80103534:	e8 47 0d 00 00       	call   80104280 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103539:	5a                   	pop    %edx
8010353a:	59                   	pop    %ecx
8010353b:	53                   	push   %ebx
8010353c:	56                   	push   %esi
8010353d:	e8 ee 0a 00 00       	call   80104030 <sleep>
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
80103564:	e8 07 04 00 00       	call   80103970 <myproc>
80103569:	8b 40 14             	mov    0x14(%eax),%eax
8010356c:	85 c0                	test   %eax,%eax
8010356e:	74 c0                	je     80103530 <pipewrite+0x60>
        release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 97 17 00 00       	call   80104d10 <release>
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
801035c3:	e8 b8 0c 00 00       	call   80104280 <wakeup>
  release(&p->lock);
801035c8:	89 1c 24             	mov    %ebx,(%esp)
801035cb:	e8 40 17 00 00       	call   80104d10 <release>
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
801035f0:	e8 5b 16 00 00       	call   80104c50 <acquire>
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
80103625:	e8 06 0a 00 00       	call   80104030 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010362a:	83 c4 10             	add    $0x10,%esp
8010362d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103633:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103639:	75 35                	jne    80103670 <piperead+0x90>
8010363b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103641:	85 d2                	test   %edx,%edx
80103643:	0f 84 8f 00 00 00    	je     801036d8 <piperead+0xf8>
    if(myproc()->killed){
80103649:	e8 22 03 00 00       	call   80103970 <myproc>
8010364e:	8b 48 14             	mov    0x14(%eax),%ecx
80103651:	85 c9                	test   %ecx,%ecx
80103653:	74 cb                	je     80103620 <piperead+0x40>
      release(&p->lock);
80103655:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103658:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010365d:	56                   	push   %esi
8010365e:	e8 ad 16 00 00       	call   80104d10 <release>
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
801036b7:	e8 c4 0b 00 00       	call   80104280 <wakeup>
  release(&p->lock);
801036bc:	89 34 24             	mov    %esi,(%esp)
801036bf:	e8 4c 16 00 00       	call   80104d10 <release>
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
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801036e5:	bb b4 4e 11 80       	mov    $0x80114eb4,%ebx
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
80103733:	81 fb b4 6a 11 80    	cmp    $0x80116ab4,%ebx
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
80103745:	bb b4 4e 11 80       	mov    $0x80114eb4,%ebx
  acquire(&ptable.lock);
8010374a:	83 ec 0c             	sub    $0xc,%esp
8010374d:	68 80 4e 11 80       	push   $0x80114e80
80103752:	e8 f9 14 00 00       	call   80104c50 <acquire>
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
80103766:	81 fb b4 6a 11 80    	cmp    $0x80116ab4,%ebx
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
8010378f:	05 b4 6a 11 80       	add    $0x80116ab4,%eax
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
801037cf:	68 80 4e 11 80       	push   $0x80114e80
  t->tid = nexttid++;
801037d4:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801037da:	e8 31 15 00 00       	call   80104d10 <release>
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
801037fe:	c7 40 14 df 60 10 80 	movl   $0x801060df,0x14(%eax)
  t->context = (struct context*)sp;
80103805:	89 46 18             	mov    %eax,0x18(%esi)
  memset(t->context, 0, sizeof *t->context);
80103808:	6a 14                	push   $0x14
8010380a:	6a 00                	push   $0x0
8010380c:	50                   	push   %eax
8010380d:	e8 4e 15 00 00       	call   80104d60 <memset>
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
80103835:	68 80 4e 11 80       	push   $0x80114e80
8010383a:	e8 d1 14 00 00       	call   80104d10 <release>
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
80103856:	68 80 4e 11 80       	push   $0x80114e80
8010385b:	e8 b0 14 00 00       	call   80104d10 <release>
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
801038a6:	68 95 7f 10 80       	push   $0x80107f95
801038ab:	68 80 4e 11 80       	push   $0x80114e80
801038b0:	e8 5b 12 00 00       	call   80104b10 <initlock>
  initlock(&mutexTable.lock, "mutexTable");
801038b5:	58                   	pop    %eax
801038b6:	5a                   	pop    %edx
801038b7:	68 9c 7f 10 80       	push   $0x80107f9c
801038bc:	68 40 3d 11 80       	push   $0x80113d40
801038c1:	e8 4a 12 00 00       	call   80104b10 <initlock>
}
801038c6:	83 c4 10             	add    $0x10,%esp
801038c9:	c9                   	leave  
801038ca:	c3                   	ret    
801038cb:	90                   	nop
801038cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038d0 <mycpu>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	56                   	push   %esi
801038d4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038d5:	9c                   	pushf  
801038d6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038d7:	f6 c4 02             	test   $0x2,%ah
801038da:	75 5e                	jne    8010393a <mycpu+0x6a>
  apicid = lapicid();
801038dc:	e8 2f ef ff ff       	call   80102810 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038e1:	8b 35 20 3d 11 80    	mov    0x80113d20,%esi
801038e7:	85 f6                	test   %esi,%esi
801038e9:	7e 42                	jle    8010392d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038eb:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
801038f2:	39 d0                	cmp    %edx,%eax
801038f4:	74 30                	je     80103926 <mycpu+0x56>
801038f6:	b9 34 38 11 80       	mov    $0x80113834,%ecx
  for (i = 0; i < ncpu; ++i) {
801038fb:	31 d2                	xor    %edx,%edx
801038fd:	8d 76 00             	lea    0x0(%esi),%esi
80103900:	83 c2 01             	add    $0x1,%edx
80103903:	39 f2                	cmp    %esi,%edx
80103905:	74 26                	je     8010392d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103907:	0f b6 19             	movzbl (%ecx),%ebx
8010390a:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
80103910:	39 c3                	cmp    %eax,%ebx
80103912:	75 ec                	jne    80103900 <mycpu+0x30>
80103914:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
8010391a:	05 80 37 11 80       	add    $0x80113780,%eax
}
8010391f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103922:	5b                   	pop    %ebx
80103923:	5e                   	pop    %esi
80103924:	5d                   	pop    %ebp
80103925:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103926:	b8 80 37 11 80       	mov    $0x80113780,%eax
      return &cpus[i];
8010392b:	eb f2                	jmp    8010391f <mycpu+0x4f>
  panic("unknown apicid\n");
8010392d:	83 ec 0c             	sub    $0xc,%esp
80103930:	68 a7 7f 10 80       	push   $0x80107fa7
80103935:	e8 56 ca ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010393a:	83 ec 0c             	sub    $0xc,%esp
8010393d:	68 a4 80 10 80       	push   $0x801080a4
80103942:	e8 49 ca ff ff       	call   80100390 <panic>
80103947:	89 f6                	mov    %esi,%esi
80103949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103950 <cpuid>:
cpuid() {
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103956:	e8 75 ff ff ff       	call   801038d0 <mycpu>
8010395b:	2d 80 37 11 80       	sub    $0x80113780,%eax
}
80103960:	c9                   	leave  
  return mycpu()-cpus;
80103961:	c1 f8 02             	sar    $0x2,%eax
80103964:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
8010396a:	c3                   	ret    
8010396b:	90                   	nop
8010396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103970 <myproc>:
myproc(void) {
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103977:	e8 04 12 00 00       	call   80104b80 <pushcli>
  c = mycpu();
8010397c:	e8 4f ff ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103981:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103987:	e8 34 12 00 00       	call   80104bc0 <popcli>
}
8010398c:	83 c4 04             	add    $0x4,%esp
8010398f:	89 d8                	mov    %ebx,%eax
80103991:	5b                   	pop    %ebx
80103992:	5d                   	pop    %ebp
80103993:	c3                   	ret    
80103994:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010399a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039a0 <mythread>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039a7:	e8 d4 11 00 00       	call   80104b80 <pushcli>
  c = mycpu();
801039ac:	e8 1f ff ff ff       	call   801038d0 <mycpu>
  t = c->thread;
801039b1:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
801039b7:	e8 04 12 00 00       	call   80104bc0 <popcli>
}
801039bc:	83 c4 04             	add    $0x4,%esp
801039bf:	89 d8                	mov    %ebx,%eax
801039c1:	5b                   	pop    %ebx
801039c2:	5d                   	pop    %ebp
801039c3:	c3                   	ret    
801039c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039d0 <userinit>:
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	56                   	push   %esi
801039d4:	53                   	push   %ebx
  p = allocproc();
801039d5:	e8 66 fd ff ff       	call   80103740 <allocproc>
801039da:	89 c6                	mov    %eax,%esi
  initproc = p;
801039dc:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
801039e1:	e8 ba 3d 00 00       	call   801077a0 <setupkvm>
801039e6:	85 c0                	test   %eax,%eax
801039e8:	89 46 04             	mov    %eax,0x4(%esi)
801039eb:	0f 84 c9 00 00 00    	je     80103aba <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039f1:	83 ec 04             	sub    $0x4,%esp
801039f4:	68 2c 00 00 00       	push   $0x2c
801039f9:	68 60 b4 10 80       	push   $0x8010b460
801039fe:	50                   	push   %eax
801039ff:	e8 7c 3a 00 00       	call   80107480 <inituvm>
  t = p->threads;
80103a04:	8b 5e 6c             	mov    0x6c(%esi),%ebx
  memset(t->tf, 0, sizeof(*t->tf));
80103a07:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a0a:	c7 06 00 10 00 00    	movl   $0x1000,(%esi)
  memset(t->tf, 0, sizeof(*t->tf));
80103a10:	6a 4c                	push   $0x4c
80103a12:	6a 00                	push   $0x0
80103a14:	ff 73 14             	pushl  0x14(%ebx)
80103a17:	e8 44 13 00 00       	call   80104d60 <memset>
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a1c:	8b 43 14             	mov    0x14(%ebx),%eax
80103a1f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a24:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a29:	83 c4 0c             	add    $0xc,%esp
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a2c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a30:	8b 43 14             	mov    0x14(%ebx),%eax
80103a33:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  t->tf->es = t->tf->ds;
80103a37:	8b 43 14             	mov    0x14(%ebx),%eax
80103a3a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a3e:	66 89 50 28          	mov    %dx,0x28(%eax)
  t->tf->ss = t->tf->ds;
80103a42:	8b 43 14             	mov    0x14(%ebx),%eax
80103a45:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a49:	66 89 50 48          	mov    %dx,0x48(%eax)
  t->tf->eflags = FL_IF;
80103a4d:	8b 43 14             	mov    0x14(%ebx),%eax
80103a50:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  t->tf->esp = PGSIZE;
80103a57:	8b 43 14             	mov    0x14(%ebx),%eax
80103a5a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  t->tf->eip = 0;  // beginning of initcode.S
80103a61:	8b 43 14             	mov    0x14(%ebx),%eax
80103a64:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a6b:	8d 46 5c             	lea    0x5c(%esi),%eax
80103a6e:	6a 10                	push   $0x10
80103a70:	68 d0 7f 10 80       	push   $0x80107fd0
80103a75:	50                   	push   %eax
80103a76:	e8 c5 14 00 00       	call   80104f40 <safestrcpy>
  p->cwd = namei("/");
80103a7b:	c7 04 24 d9 7f 10 80 	movl   $0x80107fd9,(%esp)
80103a82:	e8 39 e5 ff ff       	call   80101fc0 <namei>
80103a87:	89 46 58             	mov    %eax,0x58(%esi)
  acquire(&ptable.lock);
80103a8a:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80103a91:	e8 ba 11 00 00       	call   80104c50 <acquire>
  p->state = USED;
80103a96:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
  t->state = RUNNABLE;
80103a9d:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  release(&ptable.lock);
80103aa4:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80103aab:	e8 60 12 00 00       	call   80104d10 <release>
}
80103ab0:	83 c4 10             	add    $0x10,%esp
80103ab3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ab6:	5b                   	pop    %ebx
80103ab7:	5e                   	pop    %esi
80103ab8:	5d                   	pop    %ebp
80103ab9:	c3                   	ret    
    panic("userinit: out of memory?");
80103aba:	83 ec 0c             	sub    $0xc,%esp
80103abd:	68 b7 7f 10 80       	push   $0x80107fb7
80103ac2:	e8 c9 c8 ff ff       	call   80100390 <panic>
80103ac7:	89 f6                	mov    %esi,%esi
80103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ad0 <growproc>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	56                   	push   %esi
80103ad4:	53                   	push   %ebx
80103ad5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ad8:	e8 a3 10 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103add:	e8 ee fd ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103ae2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ae8:	e8 d3 10 00 00       	call   80104bc0 <popcli>
  acquire(&ptable.lock);
80103aed:	83 ec 0c             	sub    $0xc,%esp
80103af0:	68 80 4e 11 80       	push   $0x80114e80
80103af5:	e8 56 11 00 00       	call   80104c50 <acquire>
  if(n > 0){
80103afa:	83 c4 10             	add    $0x10,%esp
80103afd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103b00:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b02:	7f 2c                	jg     80103b30 <growproc+0x60>
  } else if(n < 0){
80103b04:	75 5a                	jne    80103b60 <growproc+0x90>
  switchuvm(curproc);
80103b06:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b09:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b0b:	53                   	push   %ebx
80103b0c:	e8 5f 38 00 00       	call   80107370 <switchuvm>
  release(&ptable.lock);
80103b11:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80103b18:	e8 f3 11 00 00       	call   80104d10 <release>
  return 0;
80103b1d:	83 c4 10             	add    $0x10,%esp
80103b20:	31 c0                	xor    %eax,%eax
}
80103b22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b25:	5b                   	pop    %ebx
80103b26:	5e                   	pop    %esi
80103b27:	5d                   	pop    %ebp
80103b28:	c3                   	ret    
80103b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0){
80103b30:	83 ec 04             	sub    $0x4,%esp
80103b33:	01 c6                	add    %eax,%esi
80103b35:	56                   	push   %esi
80103b36:	50                   	push   %eax
80103b37:	ff 73 04             	pushl  0x4(%ebx)
80103b3a:	e8 81 3a 00 00       	call   801075c0 <allocuvm>
80103b3f:	83 c4 10             	add    $0x10,%esp
80103b42:	85 c0                	test   %eax,%eax
80103b44:	75 c0                	jne    80103b06 <growproc+0x36>
      release(&ptable.lock);
80103b46:	83 ec 0c             	sub    $0xc,%esp
80103b49:	68 80 4e 11 80       	push   $0x80114e80
80103b4e:	e8 bd 11 00 00       	call   80104d10 <release>
      return -1;
80103b53:	83 c4 10             	add    $0x10,%esp
80103b56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b5b:	eb c5                	jmp    80103b22 <growproc+0x52>
80103b5d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0){
80103b60:	83 ec 04             	sub    $0x4,%esp
80103b63:	01 c6                	add    %eax,%esi
80103b65:	56                   	push   %esi
80103b66:	50                   	push   %eax
80103b67:	ff 73 04             	pushl  0x4(%ebx)
80103b6a:	e8 81 3b 00 00       	call   801076f0 <deallocuvm>
80103b6f:	83 c4 10             	add    $0x10,%esp
80103b72:	85 c0                	test   %eax,%eax
80103b74:	75 90                	jne    80103b06 <growproc+0x36>
80103b76:	eb ce                	jmp    80103b46 <growproc+0x76>
80103b78:	90                   	nop
80103b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b80 <fork>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	57                   	push   %edi
80103b84:	56                   	push   %esi
80103b85:	53                   	push   %ebx
80103b86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b89:	e8 f2 0f 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103b8e:	e8 3d fd ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103b93:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b99:	e8 22 10 00 00       	call   80104bc0 <popcli>
  pushcli();
80103b9e:	e8 dd 0f 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103ba3:	e8 28 fd ff ff       	call   801038d0 <mycpu>
  t = c->thread;
80103ba8:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
  popcli();
80103bae:	e8 0d 10 00 00       	call   80104bc0 <popcli>
  if((np = allocproc()) == 0){
80103bb3:	e8 88 fb ff ff       	call   80103740 <allocproc>
80103bb8:	85 c0                	test   %eax,%eax
80103bba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103bbd:	89 c7                	mov    %eax,%edi
80103bbf:	0f 84 cf 00 00 00    	je     80103c94 <fork+0x114>
  nt = np->threads;
80103bc5:	8b 48 6c             	mov    0x6c(%eax),%ecx
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bc8:	83 ec 08             	sub    $0x8,%esp
  nt->tproc = np;
80103bcb:	89 41 10             	mov    %eax,0x10(%ecx)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bce:	ff 33                	pushl  (%ebx)
80103bd0:	ff 73 04             	pushl  0x4(%ebx)
  nt = np->threads;
80103bd3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bd6:	e8 95 3c 00 00       	call   80107870 <copyuvm>
80103bdb:	83 c4 10             	add    $0x10,%esp
80103bde:	85 c0                	test   %eax,%eax
80103be0:	89 47 04             	mov    %eax,0x4(%edi)
80103be3:	0f 84 b2 00 00 00    	je     80103c9b <fork+0x11b>
  np->sz = curproc->sz;
80103be9:	8b 03                	mov    (%ebx),%eax
80103beb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *nt->tf = *curthread->tf;
80103bee:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103bf3:	89 02                	mov    %eax,(%edx)
  *nt->tf = *curthread->tf;
80103bf5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  np->parent = curproc;
80103bf8:	89 5a 10             	mov    %ebx,0x10(%edx)
  *nt->tf = *curthread->tf;
80103bfb:	8b 76 14             	mov    0x14(%esi),%esi
80103bfe:	8b 78 14             	mov    0x14(%eax),%edi
80103c01:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c03:	31 f6                	xor    %esi,%esi
80103c05:	89 d7                	mov    %edx,%edi
  nt->tf->eax = 0;
80103c07:	8b 40 14             	mov    0x14(%eax),%eax
80103c0a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103c18:	8b 44 b3 18          	mov    0x18(%ebx,%esi,4),%eax
80103c1c:	85 c0                	test   %eax,%eax
80103c1e:	74 10                	je     80103c30 <fork+0xb0>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c20:	83 ec 0c             	sub    $0xc,%esp
80103c23:	50                   	push   %eax
80103c24:	e8 97 d2 ff ff       	call   80100ec0 <filedup>
80103c29:	83 c4 10             	add    $0x10,%esp
80103c2c:	89 44 b7 18          	mov    %eax,0x18(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c30:	83 c6 01             	add    $0x1,%esi
80103c33:	83 fe 10             	cmp    $0x10,%esi
80103c36:	75 e0                	jne    80103c18 <fork+0x98>
  np->cwd = idup(curproc->cwd);
80103c38:	83 ec 0c             	sub    $0xc,%esp
80103c3b:	ff 73 58             	pushl  0x58(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c3e:	83 c3 5c             	add    $0x5c,%ebx
  np->cwd = idup(curproc->cwd);
80103c41:	e8 ea da ff ff       	call   80101730 <idup>
80103c46:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c49:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c4c:	89 47 58             	mov    %eax,0x58(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c4f:	8d 47 5c             	lea    0x5c(%edi),%eax
80103c52:	6a 10                	push   $0x10
80103c54:	53                   	push   %ebx
80103c55:	50                   	push   %eax
80103c56:	e8 e5 12 00 00       	call   80104f40 <safestrcpy>
  pid = np->pid;
80103c5b:	8b 5f 0c             	mov    0xc(%edi),%ebx
  acquire(&ptable.lock);
80103c5e:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80103c65:	e8 e6 0f 00 00       	call   80104c50 <acquire>
  nt->state = RUNNABLE;
80103c6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  np->state = USED;
80103c6d:	c7 47 08 02 00 00 00 	movl   $0x2,0x8(%edi)
  nt->state = RUNNABLE;
80103c74:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)
  release(&ptable.lock);
80103c7b:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80103c82:	e8 89 10 00 00       	call   80104d10 <release>
  return pid;
80103c87:	83 c4 10             	add    $0x10,%esp
}
80103c8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c8d:	89 d8                	mov    %ebx,%eax
80103c8f:	5b                   	pop    %ebx
80103c90:	5e                   	pop    %esi
80103c91:	5f                   	pop    %edi
80103c92:	5d                   	pop    %ebp
80103c93:	c3                   	ret    
    return -1;
80103c94:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c99:	eb ef                	jmp    80103c8a <fork+0x10a>
    kfree(nt->kstack);
80103c9b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103c9e:	83 ec 0c             	sub    $0xc,%esp
80103ca1:	ff 33                	pushl  (%ebx)
80103ca3:	e8 48 e7 ff ff       	call   801023f0 <kfree>
    np->state = UNUSED;
80103ca8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    nt->kstack = 0;
80103cab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    return -1;
80103cb1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103cb4:	c7 41 08 00 00 00 00 	movl   $0x0,0x8(%ecx)
    nt->state = UNINIT;
80103cbb:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103cc2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103cc7:	eb c1                	jmp    80103c8a <fork+0x10a>
80103cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103cd0 <scheduler>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103cd9:	e8 f2 fb ff ff       	call   801038d0 <mycpu>
  c->proc = 0;
80103cde:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ce5:	00 00 00 
  c->thread = 0;
80103ce8:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103cef:	00 00 00 
  struct cpu *c = mycpu();
80103cf2:	89 c7                	mov    %eax,%edi
80103cf4:	8d 40 04             	lea    0x4(%eax),%eax
80103cf7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80103cfa:	fb                   	sti    
    acquire(&ptable.lock);
80103cfb:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cfe:	be b4 4e 11 80       	mov    $0x80114eb4,%esi
    acquire(&ptable.lock);
80103d03:	68 80 4e 11 80       	push   $0x80114e80
80103d08:	e8 43 0f 00 00       	call   80104c50 <acquire>
80103d0d:	83 c4 10             	add    $0x10,%esp
80103d10:	eb 11                	jmp    80103d23 <scheduler+0x53>
80103d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d18:	83 c6 70             	add    $0x70,%esi
80103d1b:	81 fe b4 6a 11 80    	cmp    $0x80116ab4,%esi
80103d21:	73 73                	jae    80103d96 <scheduler+0xc6>
      if(p->state != USED){
80103d23:	83 7e 08 02          	cmpl   $0x2,0x8(%esi)
80103d27:	75 ef                	jne    80103d18 <scheduler+0x48>
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103d29:	8b 4e 6c             	mov    0x6c(%esi),%ecx
80103d2c:	89 cb                	mov    %ecx,%ebx
80103d2e:	66 90                	xchg   %ax,%ax
        if(t->state != RUNNABLE){
80103d30:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
80103d34:	75 48                	jne    80103d7e <scheduler+0xae>
        switchuvm(p);
80103d36:	83 ec 0c             	sub    $0xc,%esp
        c->proc = p;
80103d39:	89 b7 ac 00 00 00    	mov    %esi,0xac(%edi)
        c->thread = t;
80103d3f:	89 9f b0 00 00 00    	mov    %ebx,0xb0(%edi)
        switchuvm(p);
80103d45:	56                   	push   %esi
80103d46:	e8 25 36 00 00       	call   80107370 <switchuvm>
        t->state = RUNNING;
80103d4b:	c7 43 08 03 00 00 00 	movl   $0x3,0x8(%ebx)
        swtch(&(c->scheduler), t->context);
80103d52:	58                   	pop    %eax
80103d53:	5a                   	pop    %edx
80103d54:	ff 73 18             	pushl  0x18(%ebx)
80103d57:	ff 75 e4             	pushl  -0x1c(%ebp)
80103d5a:	e8 3c 12 00 00       	call   80104f9b <swtch>
        switchkvm();
80103d5f:	e8 ec 35 00 00       	call   80107350 <switchkvm>
        c->proc = 0;
80103d64:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103d6b:	00 00 00 
        c->thread = 0;
80103d6e:	c7 87 b0 00 00 00 00 	movl   $0x0,0xb0(%edi)
80103d75:	00 00 00 
80103d78:	83 c4 10             	add    $0x10,%esp
80103d7b:	8b 4e 6c             	mov    0x6c(%esi),%ecx
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103d7e:	8d 91 40 02 00 00    	lea    0x240(%ecx),%edx
80103d84:	83 c3 24             	add    $0x24,%ebx
80103d87:	39 d3                	cmp    %edx,%ebx
80103d89:	72 a5                	jb     80103d30 <scheduler+0x60>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d8b:	83 c6 70             	add    $0x70,%esi
80103d8e:	81 fe b4 6a 11 80    	cmp    $0x80116ab4,%esi
80103d94:	72 8d                	jb     80103d23 <scheduler+0x53>
    release(&ptable.lock);
80103d96:	83 ec 0c             	sub    $0xc,%esp
80103d99:	68 80 4e 11 80       	push   $0x80114e80
80103d9e:	e8 6d 0f 00 00       	call   80104d10 <release>
    sti();
80103da3:	83 c4 10             	add    $0x10,%esp
80103da6:	e9 4f ff ff ff       	jmp    80103cfa <scheduler+0x2a>
80103dab:	90                   	nop
80103dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103db0 <sched>:
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	56                   	push   %esi
80103db4:	53                   	push   %ebx
  pushcli();
80103db5:	e8 c6 0d 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103dba:	e8 11 fb ff ff       	call   801038d0 <mycpu>
  t = c->thread;
80103dbf:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103dc5:	e8 f6 0d 00 00       	call   80104bc0 <popcli>
  if(!holding(&ptable.lock))
80103dca:	83 ec 0c             	sub    $0xc,%esp
80103dcd:	68 80 4e 11 80       	push   $0x80114e80
80103dd2:	e8 49 0e 00 00       	call   80104c20 <holding>
80103dd7:	83 c4 10             	add    $0x10,%esp
80103dda:	85 c0                	test   %eax,%eax
80103ddc:	74 4f                	je     80103e2d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dde:	e8 ed fa ff ff       	call   801038d0 <mycpu>
80103de3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dea:	75 68                	jne    80103e54 <sched+0xa4>
  if(t->state == RUNNING)
80103dec:	83 7b 08 03          	cmpl   $0x3,0x8(%ebx)
80103df0:	74 55                	je     80103e47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103df2:	9c                   	pushf  
80103df3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103df4:	f6 c4 02             	test   $0x2,%ah
80103df7:	75 41                	jne    80103e3a <sched+0x8a>
  intena = mycpu()->intena;
80103df9:	e8 d2 fa ff ff       	call   801038d0 <mycpu>
  swtch(&t->context, mycpu()->scheduler);
80103dfe:	83 c3 18             	add    $0x18,%ebx
  intena = mycpu()->intena;
80103e01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&t->context, mycpu()->scheduler);
80103e07:	e8 c4 fa ff ff       	call   801038d0 <mycpu>
80103e0c:	83 ec 08             	sub    $0x8,%esp
80103e0f:	ff 70 04             	pushl  0x4(%eax)
80103e12:	53                   	push   %ebx
80103e13:	e8 83 11 00 00       	call   80104f9b <swtch>
  mycpu()->intena = intena;
80103e18:	e8 b3 fa ff ff       	call   801038d0 <mycpu>
}
80103e1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e29:	5b                   	pop    %ebx
80103e2a:	5e                   	pop    %esi
80103e2b:	5d                   	pop    %ebp
80103e2c:	c3                   	ret    
    panic("sched ptable.lock");
80103e2d:	83 ec 0c             	sub    $0xc,%esp
80103e30:	68 db 7f 10 80       	push   $0x80107fdb
80103e35:	e8 56 c5 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103e3a:	83 ec 0c             	sub    $0xc,%esp
80103e3d:	68 07 80 10 80       	push   $0x80108007
80103e42:	e8 49 c5 ff ff       	call   80100390 <panic>
    panic("sched running");
80103e47:	83 ec 0c             	sub    $0xc,%esp
80103e4a:	68 f9 7f 10 80       	push   $0x80107ff9
80103e4f:	e8 3c c5 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103e54:	83 ec 0c             	sub    $0xc,%esp
80103e57:	68 ed 7f 10 80       	push   $0x80107fed
80103e5c:	e8 2f c5 ff ff       	call   80100390 <panic>
80103e61:	eb 0d                	jmp    80103e70 <exit>
80103e63:	90                   	nop
80103e64:	90                   	nop
80103e65:	90                   	nop
80103e66:	90                   	nop
80103e67:	90                   	nop
80103e68:	90                   	nop
80103e69:	90                   	nop
80103e6a:	90                   	nop
80103e6b:	90                   	nop
80103e6c:	90                   	nop
80103e6d:	90                   	nop
80103e6e:	90                   	nop
80103e6f:	90                   	nop

80103e70 <exit>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e79:	e8 02 0d 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103e7e:	e8 4d fa ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103e83:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e89:	e8 32 0d 00 00       	call   80104bc0 <popcli>
  pushcli();
80103e8e:	e8 ed 0c 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103e93:	e8 38 fa ff ff       	call   801038d0 <mycpu>
  t = c->thread;
80103e98:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103e9e:	e8 1d 0d 00 00       	call   80104bc0 <popcli>
  if(curproc == initproc)
80103ea3:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103ea9:	74 62                	je     80103f0d <exit+0x9d>
  acquire(&ptable.lock);
80103eab:	83 ec 0c             	sub    $0xc,%esp
  int lastRunning = 1;
80103eae:	bf 01 00 00 00       	mov    $0x1,%edi
  acquire(&ptable.lock);
80103eb3:	68 80 4e 11 80       	push   $0x80114e80
80103eb8:	e8 93 0d 00 00       	call   80104c50 <acquire>
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103ebd:	8b 4e 6c             	mov    0x6c(%esi),%ecx
80103ec0:	83 c4 10             	add    $0x10,%esp
80103ec3:	89 c8                	mov    %ecx,%eax
80103ec5:	8d 76 00             	lea    0x0(%esi),%esi
      if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80103ec8:	39 d8                	cmp    %ebx,%eax
80103eca:	74 18                	je     80103ee4 <exit+0x74>
80103ecc:	8b 50 08             	mov    0x8(%eax),%edx
80103ecf:	85 d2                	test   %edx,%edx
80103ed1:	74 11                	je     80103ee4 <exit+0x74>
80103ed3:	83 fa 05             	cmp    $0x5,%edx
80103ed6:	74 0c                	je     80103ee4 <exit+0x74>
          t->exitRequest = 1;
80103ed8:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
80103edf:	8b 4e 6c             	mov    0x6c(%esi),%ecx
          lastRunning = 0;
80103ee2:	31 ff                	xor    %edi,%edi
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103ee4:	8d 91 40 02 00 00    	lea    0x240(%ecx),%edx
80103eea:	83 c0 24             	add    $0x24,%eax
80103eed:	39 d0                	cmp    %edx,%eax
80103eef:	72 d7                	jb     80103ec8 <exit+0x58>
  if(lastRunning){
80103ef1:	85 ff                	test   %edi,%edi
80103ef3:	75 25                	jne    80103f1a <exit+0xaa>
    release(&ptable.lock);
80103ef5:	83 ec 0c             	sub    $0xc,%esp
80103ef8:	68 80 4e 11 80       	push   $0x80114e80
80103efd:	e8 0e 0e 00 00       	call   80104d10 <release>
}
80103f02:	83 c4 10             	add    $0x10,%esp
80103f05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f08:	5b                   	pop    %ebx
80103f09:	5e                   	pop    %esi
80103f0a:	5f                   	pop    %edi
80103f0b:	5d                   	pop    %ebp
80103f0c:	c3                   	ret    
    panic("init exiting");
80103f0d:	83 ec 0c             	sub    $0xc,%esp
80103f10:	68 1b 80 10 80       	push   $0x8010801b
80103f15:	e8 76 c4 ff ff       	call   80100390 <panic>
    release(&ptable.lock);
80103f1a:	83 ec 0c             	sub    $0xc,%esp
80103f1d:	8d 7e 18             	lea    0x18(%esi),%edi
80103f20:	68 80 4e 11 80       	push   $0x80114e80
80103f25:	e8 e6 0d 00 00       	call   80104d10 <release>
80103f2a:	8d 46 58             	lea    0x58(%esi),%eax
80103f2d:	83 c4 10             	add    $0x10,%esp
80103f30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(curproc->ofile[fd]){
80103f33:	8b 17                	mov    (%edi),%edx
80103f35:	85 d2                	test   %edx,%edx
80103f37:	74 12                	je     80103f4b <exit+0xdb>
        fileclose(curproc->ofile[fd]);
80103f39:	83 ec 0c             	sub    $0xc,%esp
80103f3c:	52                   	push   %edx
80103f3d:	e8 ce cf ff ff       	call   80100f10 <fileclose>
        curproc->ofile[fd] = 0;
80103f42:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103f48:	83 c4 10             	add    $0x10,%esp
80103f4b:	83 c7 04             	add    $0x4,%edi
    for(fd = 0; fd < NOFILE; fd++){
80103f4e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80103f51:	75 e0                	jne    80103f33 <exit+0xc3>
    begin_op();
80103f53:	e8 28 ed ff ff       	call   80102c80 <begin_op>
    iput(curproc->cwd);
80103f58:	83 ec 0c             	sub    $0xc,%esp
80103f5b:	ff 76 58             	pushl  0x58(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f5e:	bf b4 4e 11 80       	mov    $0x80114eb4,%edi
    iput(curproc->cwd);
80103f63:	e8 28 d9 ff ff       	call   80101890 <iput>
    end_op();
80103f68:	e8 83 ed ff ff       	call   80102cf0 <end_op>
    curproc->cwd = 0;
80103f6d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
    acquire(&ptable.lock);
80103f74:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80103f7b:	e8 d0 0c 00 00       	call   80104c50 <acquire>
    wakeup1(curproc->parent);
80103f80:	8b 46 10             	mov    0x10(%esi),%eax
80103f83:	e8 58 f7 ff ff       	call   801036e0 <wakeup1>
80103f88:	83 c4 10             	add    $0x10,%esp
80103f8b:	eb 0e                	jmp    80103f9b <exit+0x12b>
80103f8d:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f90:	83 c7 70             	add    $0x70,%edi
80103f93:	81 ff b4 6a 11 80    	cmp    $0x80116ab4,%edi
80103f99:	73 1a                	jae    80103fb5 <exit+0x145>
      if(p->parent == curproc){
80103f9b:	39 77 10             	cmp    %esi,0x10(%edi)
80103f9e:	75 f0                	jne    80103f90 <exit+0x120>
        if(p->state == ZOMBIE)
80103fa0:	83 7f 08 03          	cmpl   $0x3,0x8(%edi)
        p->parent = initproc;
80103fa4:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
80103fa9:	89 47 10             	mov    %eax,0x10(%edi)
        if(p->state == ZOMBIE)
80103fac:	75 e2                	jne    80103f90 <exit+0x120>
          wakeup1(initproc);
80103fae:	e8 2d f7 ff ff       	call   801036e0 <wakeup1>
80103fb3:	eb db                	jmp    80103f90 <exit+0x120>
    wakeup1(curthread);
80103fb5:	89 d8                	mov    %ebx,%eax
80103fb7:	e8 24 f7 ff ff       	call   801036e0 <wakeup1>
    curproc->state = ZOMBIE;
80103fbc:	c7 46 08 03 00 00 00 	movl   $0x3,0x8(%esi)
    curthread->state = TERMINATED;
80103fc3:	c7 43 08 05 00 00 00 	movl   $0x5,0x8(%ebx)
    sched();
80103fca:	e8 e1 fd ff ff       	call   80103db0 <sched>
    panic("zombie exit");
80103fcf:	83 ec 0c             	sub    $0xc,%esp
80103fd2:	68 28 80 10 80       	push   $0x80108028
80103fd7:	e8 b4 c3 ff ff       	call   80100390 <panic>
80103fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103fe0 <yield>:
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	53                   	push   %ebx
80103fe4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fe7:	68 80 4e 11 80       	push   $0x80114e80
80103fec:	e8 5f 0c 00 00       	call   80104c50 <acquire>
  pushcli();
80103ff1:	e8 8a 0b 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80103ff6:	e8 d5 f8 ff ff       	call   801038d0 <mycpu>
  t = c->thread;
80103ffb:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80104001:	e8 ba 0b 00 00       	call   80104bc0 <popcli>
  mythread()->state = RUNNABLE;
80104006:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  sched();
8010400d:	e8 9e fd ff ff       	call   80103db0 <sched>
  release(&ptable.lock);
80104012:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
80104019:	e8 f2 0c 00 00       	call   80104d10 <release>
}
8010401e:	83 c4 10             	add    $0x10,%esp
80104021:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104024:	c9                   	leave  
80104025:	c3                   	ret    
80104026:	8d 76 00             	lea    0x0(%esi),%esi
80104029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104030 <sleep>:
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	57                   	push   %edi
80104034:	56                   	push   %esi
80104035:	53                   	push   %ebx
80104036:	83 ec 0c             	sub    $0xc,%esp
80104039:	8b 7d 08             	mov    0x8(%ebp),%edi
8010403c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010403f:	e8 3c 0b 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80104044:	e8 87 f8 ff ff       	call   801038d0 <mycpu>
  t = c->thread;
80104049:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
8010404f:	e8 6c 0b 00 00       	call   80104bc0 <popcli>
  if(t == 0)
80104054:	85 db                	test   %ebx,%ebx
80104056:	0f 84 87 00 00 00    	je     801040e3 <sleep+0xb3>
  if(lk == 0)
8010405c:	85 f6                	test   %esi,%esi
8010405e:	74 76                	je     801040d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104060:	81 fe 80 4e 11 80    	cmp    $0x80114e80,%esi
80104066:	74 50                	je     801040b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	68 80 4e 11 80       	push   $0x80114e80
80104070:	e8 db 0b 00 00       	call   80104c50 <acquire>
    release(lk);
80104075:	89 34 24             	mov    %esi,(%esp)
80104078:	e8 93 0c 00 00       	call   80104d10 <release>
  t->chan = chan;
8010407d:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
80104080:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
80104087:	e8 24 fd ff ff       	call   80103db0 <sched>
  t->chan = 0;
8010408c:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
    release(&ptable.lock);
80104093:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
8010409a:	e8 71 0c 00 00       	call   80104d10 <release>
    acquire(lk);
8010409f:	89 75 08             	mov    %esi,0x8(%ebp)
801040a2:	83 c4 10             	add    $0x10,%esp
}
801040a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040a8:	5b                   	pop    %ebx
801040a9:	5e                   	pop    %esi
801040aa:	5f                   	pop    %edi
801040ab:	5d                   	pop    %ebp
    acquire(lk);
801040ac:	e9 9f 0b 00 00       	jmp    80104c50 <acquire>
801040b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  t->chan = chan;
801040b8:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
801040bb:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
801040c2:	e8 e9 fc ff ff       	call   80103db0 <sched>
  t->chan = 0;
801040c7:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
}
801040ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040d1:	5b                   	pop    %ebx
801040d2:	5e                   	pop    %esi
801040d3:	5f                   	pop    %edi
801040d4:	5d                   	pop    %ebp
801040d5:	c3                   	ret    
    panic("sleep without lk");
801040d6:	83 ec 0c             	sub    $0xc,%esp
801040d9:	68 3a 80 10 80       	push   $0x8010803a
801040de:	e8 ad c2 ff ff       	call   80100390 <panic>
    panic("sleep");
801040e3:	83 ec 0c             	sub    $0xc,%esp
801040e6:	68 34 80 10 80       	push   $0x80108034
801040eb:	e8 a0 c2 ff ff       	call   80100390 <panic>

801040f0 <wait>:
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	57                   	push   %edi
801040f4:	56                   	push   %esi
801040f5:	53                   	push   %ebx
801040f6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801040f9:	e8 82 0a 00 00       	call   80104b80 <pushcli>
  c = mycpu();
801040fe:	e8 cd f7 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80104103:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104109:	e8 b2 0a 00 00       	call   80104bc0 <popcli>
  acquire(&ptable.lock);
8010410e:	83 ec 0c             	sub    $0xc,%esp
80104111:	68 80 4e 11 80       	push   $0x80114e80
80104116:	e8 35 0b 00 00       	call   80104c50 <acquire>
8010411b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010411e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104120:	bf b4 4e 11 80       	mov    $0x80114eb4,%edi
80104125:	eb 14                	jmp    8010413b <wait+0x4b>
80104127:	89 f6                	mov    %esi,%esi
80104129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104130:	83 c7 70             	add    $0x70,%edi
80104133:	81 ff b4 6a 11 80    	cmp    $0x80116ab4,%edi
80104139:	73 1b                	jae    80104156 <wait+0x66>
      if(p->parent != curproc)
8010413b:	39 5f 10             	cmp    %ebx,0x10(%edi)
8010413e:	75 f0                	jne    80104130 <wait+0x40>
      if(p->state == ZOMBIE){
80104140:	83 7f 08 03          	cmpl   $0x3,0x8(%edi)
80104144:	74 3a                	je     80104180 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104146:	83 c7 70             	add    $0x70,%edi
      havekids = 1;
80104149:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010414e:	81 ff b4 6a 11 80    	cmp    $0x80116ab4,%edi
80104154:	72 e5                	jb     8010413b <wait+0x4b>
    if(!havekids || curproc->killed){
80104156:	85 c0                	test   %eax,%eax
80104158:	0f 84 fe 00 00 00    	je     8010425c <wait+0x16c>
8010415e:	8b 43 14             	mov    0x14(%ebx),%eax
80104161:	85 c0                	test   %eax,%eax
80104163:	0f 85 f3 00 00 00    	jne    8010425c <wait+0x16c>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104169:	83 ec 08             	sub    $0x8,%esp
8010416c:	68 80 4e 11 80       	push   $0x80114e80
80104171:	53                   	push   %ebx
80104172:	e8 b9 fe ff ff       	call   80104030 <sleep>
    havekids = 0;
80104177:	83 c4 10             	add    $0x10,%esp
8010417a:	eb a2                	jmp    8010411e <wait+0x2e>
8010417c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104180:	8b 77 6c             	mov    0x6c(%edi),%esi
        int hasNonTerminated = 0;
80104183:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010418a:	eb 42                	jmp    801041ce <wait+0xde>
8010418c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pushcli();
80104190:	e8 eb 09 00 00       	call   80104b80 <pushcli>
  c = mycpu();
80104195:	e8 36 f7 ff ff       	call   801038d0 <mycpu>
  t = c->thread;
8010419a:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
801041a0:	e8 1b 0a 00 00       	call   80104bc0 <popcli>
          if(t != mythread() && t->state != UNINIT && t->state != TERMINATED){
801041a5:	39 f3                	cmp    %esi,%ebx
801041a7:	74 16                	je     801041bf <wait+0xcf>
801041a9:	8b 46 08             	mov    0x8(%esi),%eax
801041ac:	83 f8 05             	cmp    $0x5,%eax
801041af:	74 0e                	je     801041bf <wait+0xcf>
            hasNonTerminated = 1;
801041b1:	85 c0                	test   %eax,%eax
801041b3:	b8 01 00 00 00       	mov    $0x1,%eax
801041b8:	0f 44 45 e4          	cmove  -0x1c(%ebp),%eax
801041bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801041bf:	8b 47 6c             	mov    0x6c(%edi),%eax
801041c2:	83 c6 24             	add    $0x24,%esi
801041c5:	05 40 02 00 00       	add    $0x240,%eax
801041ca:	39 c6                	cmp    %eax,%esi
801041cc:	73 3a                	jae    80104208 <wait+0x118>
          if(t->state == TERMINATED){
801041ce:	83 7e 08 05          	cmpl   $0x5,0x8(%esi)
801041d2:	75 bc                	jne    80104190 <wait+0xa0>
            kfree(t->kstack);
801041d4:	83 ec 0c             	sub    $0xc,%esp
801041d7:	ff 36                	pushl  (%esi)
801041d9:	e8 12 e2 ff ff       	call   801023f0 <kfree>
            t->kstack = 0;
801041de:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
            t->tid = 0;
801041e4:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
            t->state = UNINIT;
801041eb:	83 c4 10             	add    $0x10,%esp
            t->tproc = 0;
801041ee:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
            t->exitRequest = 0;
801041f5:	c7 46 20 00 00 00 00 	movl   $0x0,0x20(%esi)
            t->state = UNINIT;
801041fc:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
80104203:	eb 8b                	jmp    80104190 <wait+0xa0>
80104205:	8d 76 00             	lea    0x0(%esi),%esi
        if(!hasNonTerminated){
80104208:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  int havekids, pid = 0;
8010420b:	31 db                	xor    %ebx,%ebx
        if(!hasNonTerminated){
8010420d:	85 d2                	test   %edx,%edx
8010420f:	75 31                	jne    80104242 <wait+0x152>
          freevm(p->pgdir);
80104211:	83 ec 0c             	sub    $0xc,%esp
80104214:	ff 77 04             	pushl  0x4(%edi)
          pid = p->pid;
80104217:	8b 5f 0c             	mov    0xc(%edi),%ebx
          freevm(p->pgdir);
8010421a:	e8 01 35 00 00       	call   80107720 <freevm>
          p->pid = 0;
8010421f:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
          p->parent = 0;
80104226:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
          p->state = UNUSED;
8010422d:	83 c4 10             	add    $0x10,%esp
          p->name[0] = 0;
80104230:	c6 47 5c 00          	movb   $0x0,0x5c(%edi)
          p->killed = 0;
80104234:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
          p->state = UNUSED;
8010423b:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
        release(&ptable.lock);
80104242:	83 ec 0c             	sub    $0xc,%esp
80104245:	68 80 4e 11 80       	push   $0x80114e80
8010424a:	e8 c1 0a 00 00       	call   80104d10 <release>
        return pid;
8010424f:	83 c4 10             	add    $0x10,%esp
}
80104252:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104255:	89 d8                	mov    %ebx,%eax
80104257:	5b                   	pop    %ebx
80104258:	5e                   	pop    %esi
80104259:	5f                   	pop    %edi
8010425a:	5d                   	pop    %ebp
8010425b:	c3                   	ret    
      release(&ptable.lock);
8010425c:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010425f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&ptable.lock);
80104264:	68 80 4e 11 80       	push   $0x80114e80
80104269:	e8 a2 0a 00 00       	call   80104d10 <release>
      return -1;
8010426e:	83 c4 10             	add    $0x10,%esp
80104271:	eb df                	jmp    80104252 <wait+0x162>
80104273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104280 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	53                   	push   %ebx
80104284:	83 ec 10             	sub    $0x10,%esp
80104287:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010428a:	68 80 4e 11 80       	push   $0x80114e80
8010428f:	e8 bc 09 00 00       	call   80104c50 <acquire>
  wakeup1(chan);
80104294:	89 d8                	mov    %ebx,%eax
80104296:	e8 45 f4 ff ff       	call   801036e0 <wakeup1>
  release(&ptable.lock);
8010429b:	83 c4 10             	add    $0x10,%esp
8010429e:	c7 45 08 80 4e 11 80 	movl   $0x80114e80,0x8(%ebp)
}
801042a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042a8:	c9                   	leave  
  release(&ptable.lock);
801042a9:	e9 62 0a 00 00       	jmp    80104d10 <release>
801042ae:	66 90                	xchg   %ax,%ax

801042b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	53                   	push   %ebx
801042b4:	83 ec 10             	sub    $0x10,%esp
801042b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //cprintf("entered kill: process=%p, thread=%p\n", myproc(), mythread());
  struct proc *p;

  acquire(&ptable.lock);
801042ba:	68 80 4e 11 80       	push   $0x80114e80
801042bf:	e8 8c 09 00 00       	call   80104c50 <acquire>
801042c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042c7:	b8 b4 4e 11 80       	mov    $0x80114eb4,%eax
801042cc:	eb 0c                	jmp    801042da <kill+0x2a>
801042ce:	66 90                	xchg   %ax,%ax
801042d0:	83 c0 70             	add    $0x70,%eax
801042d3:	3d b4 6a 11 80       	cmp    $0x80116ab4,%eax
801042d8:	73 26                	jae    80104300 <kill+0x50>
    if(p->pid == pid){
801042da:	39 58 0c             	cmp    %ebx,0xc(%eax)
801042dd:	75 f1                	jne    801042d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      /*if(p->state == SLEEPING)
        p->state = RUNNABLE;*/
      release(&ptable.lock);
801042df:	83 ec 0c             	sub    $0xc,%esp
      p->killed = 1;
801042e2:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
      release(&ptable.lock);
801042e9:	68 80 4e 11 80       	push   $0x80114e80
801042ee:	e8 1d 0a 00 00       	call   80104d10 <release>
      return 0;
801042f3:	83 c4 10             	add    $0x10,%esp
801042f6:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801042f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042fb:	c9                   	leave  
801042fc:	c3                   	ret    
801042fd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104300:	83 ec 0c             	sub    $0xc,%esp
80104303:	68 80 4e 11 80       	push   $0x80114e80
80104308:	e8 03 0a 00 00       	call   80104d10 <release>
  return -1;
8010430d:	83 c4 10             	add    $0x10,%esp
80104310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104318:	c9                   	leave  
80104319:	c3                   	ret    
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	53                   	push   %ebx
  struct proc *p;
  struct kthread *t;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104326:	bf b4 4e 11 80       	mov    $0x80114eb4,%edi
{
8010432b:	83 ec 3c             	sub    $0x3c,%esp
8010432e:	66 90                	xchg   %ax,%ax
    if(p->state == UNUSED)
80104330:	8b 57 08             	mov    0x8(%edi),%edx
80104333:	85 d2                	test   %edx,%edx
80104335:	0f 84 84 00 00 00    	je     801043bf <procdump+0x9f>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010433b:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
8010433e:	b9 4b 80 10 80       	mov    $0x8010804b,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104343:	77 11                	ja     80104356 <procdump+0x36>
80104345:	8b 0c 95 cc 80 10 80 	mov    -0x7fef7f34(,%edx,4),%ecx
      state = "???";
8010434c:	ba 4b 80 10 80       	mov    $0x8010804b,%edx
80104351:	85 c9                	test   %ecx,%ecx
80104353:	0f 44 ca             	cmove  %edx,%ecx
    cprintf("process: %d %s %s , ", p->pid, state, p->name);
80104356:	8d 57 5c             	lea    0x5c(%edi),%edx
80104359:	52                   	push   %edx
8010435a:	51                   	push   %ecx
8010435b:	ff 77 0c             	pushl  0xc(%edi)
8010435e:	68 4f 80 10 80       	push   $0x8010804f
80104363:	e8 f8 c2 ff ff       	call   80100660 <cprintf>
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104368:	8b 57 6c             	mov    0x6c(%edi),%edx
8010436b:	83 c4 10             	add    $0x10,%esp
8010436e:	89 d3                	mov    %edx,%ebx
      if(t->state == UNINIT)
80104370:	8b 43 08             	mov    0x8(%ebx),%eax
80104373:	85 c0                	test   %eax,%eax
80104375:	74 3b                	je     801043b2 <procdump+0x92>
        continue;
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104377:	8b 4f 08             	mov    0x8(%edi),%ecx
        state = states[p->state];
      else
        state = "???";
8010437a:	ba 4b 80 10 80       	mov    $0x8010804b,%edx
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010437f:	83 f9 05             	cmp    $0x5,%ecx
80104382:	77 11                	ja     80104395 <procdump+0x75>
80104384:	8b 14 8d cc 80 10 80 	mov    -0x7fef7f34(,%ecx,4),%edx
        state = "???";
8010438b:	b9 4b 80 10 80       	mov    $0x8010804b,%ecx
80104390:	85 d2                	test   %edx,%edx
80104392:	0f 44 d1             	cmove  %ecx,%edx
      cprintf("thread: %d %s , ", t->tid, state);
80104395:	83 ec 04             	sub    $0x4,%esp
80104398:	52                   	push   %edx
80104399:	ff 73 0c             	pushl  0xc(%ebx)
8010439c:	68 64 80 10 80       	push   $0x80108064
801043a1:	e8 ba c2 ff ff       	call   80100660 <cprintf>
      if(t->state == SLEEPING){
801043a6:	83 c4 10             	add    $0x10,%esp
801043a9:	83 7b 08 01          	cmpl   $0x1,0x8(%ebx)
801043ad:	74 41                	je     801043f0 <procdump+0xd0>
801043af:	8b 57 6c             	mov    0x6c(%edi),%edx
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801043b2:	8d 8a 40 02 00 00    	lea    0x240(%edx),%ecx
801043b8:	83 c3 24             	add    $0x24,%ebx
801043bb:	39 cb                	cmp    %ecx,%ebx
801043bd:	72 b1                	jb     80104370 <procdump+0x50>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043bf:	83 c7 70             	add    $0x70,%edi
801043c2:	81 ff b4 6a 11 80    	cmp    $0x80116ab4,%edi
801043c8:	0f 82 62 ff ff ff    	jb     80104330 <procdump+0x10>
          cprintf(" %p ", pc[i]);
        }
      }
    }
  }
  cprintf("\n");
801043ce:	83 ec 0c             	sub    $0xc,%esp
801043d1:	68 17 84 10 80       	push   $0x80108417
801043d6:	e8 85 c2 ff ff       	call   80100660 <cprintf>
}
801043db:	83 c4 10             	add    $0x10,%esp
801043de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043e1:	5b                   	pop    %ebx
801043e2:	5e                   	pop    %esi
801043e3:	5f                   	pop    %edi
801043e4:	5d                   	pop    %ebp
801043e5:	c3                   	ret    
801043e6:	8d 76 00             	lea    0x0(%esi),%esi
801043e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        getcallerpcs((uint*)t->context->ebp+2, pc);
801043f0:	8d 45 c0             	lea    -0x40(%ebp),%eax
801043f3:	83 ec 08             	sub    $0x8,%esp
801043f6:	8d 75 c0             	lea    -0x40(%ebp),%esi
801043f9:	50                   	push   %eax
801043fa:	8b 53 18             	mov    0x18(%ebx),%edx
801043fd:	8b 52 0c             	mov    0xc(%edx),%edx
80104400:	83 c2 08             	add    $0x8,%edx
80104403:	52                   	push   %edx
80104404:	e8 27 07 00 00       	call   80104b30 <getcallerpcs>
80104409:	83 c4 10             	add    $0x10,%esp
8010440c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(i=0; i<10 && pc[i] != 0; i++){
80104410:	8b 0e                	mov    (%esi),%ecx
80104412:	85 c9                	test   %ecx,%ecx
80104414:	74 99                	je     801043af <procdump+0x8f>
          cprintf(" %p ", pc[i]);
80104416:	83 ec 08             	sub    $0x8,%esp
80104419:	83 c6 04             	add    $0x4,%esi
8010441c:	51                   	push   %ecx
8010441d:	68 75 80 10 80       	push   $0x80108075
80104422:	e8 39 c2 ff ff       	call   80100660 <cprintf>
        for(i=0; i<10 && pc[i] != 0; i++){
80104427:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010442a:	83 c4 10             	add    $0x10,%esp
8010442d:	39 f0                	cmp    %esi,%eax
8010442f:	75 df                	jne    80104410 <procdump+0xf0>
80104431:	e9 79 ff ff ff       	jmp    801043af <procdump+0x8f>
80104436:	66 90                	xchg   %ax,%ax
80104438:	66 90                	xchg   %ax,%ax
8010443a:	66 90                	xchg   %ax,%ax
8010443c:	66 90                	xchg   %ax,%ax
8010443e:	66 90                	xchg   %ax,%ax

80104440 <kthread_create>:
extern int nexttid;
extern void trapret(void);
extern void forkret(void);
static void wakeupThreads(void *chan);

int kthread_create(void (*start_func)(), void* stack){
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	57                   	push   %edi
80104444:	56                   	push   %esi
80104445:	53                   	push   %ebx
80104446:	83 ec 0c             	sub    $0xc,%esp
    struct proc *p = myproc();
80104449:	e8 22 f5 ff ff       	call   80103970 <myproc>
    struct kthread *t = 0;
    char *sp;

    acquire(&ptable.lock);
8010444e:	83 ec 0c             	sub    $0xc,%esp
    struct proc *p = myproc();
80104451:	89 c6                	mov    %eax,%esi
    acquire(&ptable.lock);
80104453:	68 80 4e 11 80       	push   $0x80114e80
80104458:	e8 f3 07 00 00       	call   80104c50 <acquire>
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
8010445d:	8b 5e 6c             	mov    0x6c(%esi),%ebx
        if(tempT->state == UNINIT){
80104460:	83 c4 10             	add    $0x10,%esp
80104463:	8b 53 08             	mov    0x8(%ebx),%edx
80104466:	85 d2                	test   %edx,%edx
80104468:	74 18                	je     80104482 <kthread_create+0x42>
8010446a:	8d 93 40 02 00 00    	lea    0x240(%ebx),%edx
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
80104470:	83 c3 24             	add    $0x24,%ebx
80104473:	39 d3                	cmp    %edx,%ebx
80104475:	0f 84 b5 00 00 00    	je     80104530 <kthread_create+0xf0>
        if(tempT->state == UNINIT){
8010447b:	8b 43 08             	mov    0x8(%ebx),%eax
8010447e:	85 c0                	test   %eax,%eax
80104480:	75 ee                	jne    80104470 <kthread_create+0x30>
        release(&ptable.lock);
        return -1;
    }

    t->tproc = p;
    t->tid = nexttid++;
80104482:	a1 04 b0 10 80       	mov    0x8010b004,%eax

    release(&ptable.lock);  
80104487:	83 ec 0c             	sub    $0xc,%esp
    t->tproc = p;
8010448a:	89 73 10             	mov    %esi,0x10(%ebx)
    t->tid = nexttid++;
8010448d:	8d 50 01             	lea    0x1(%eax),%edx
80104490:	89 43 0c             	mov    %eax,0xc(%ebx)
    release(&ptable.lock);  
80104493:	68 80 4e 11 80       	push   $0x80114e80
    t->tid = nexttid++;
80104498:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
    release(&ptable.lock);  
8010449e:	e8 6d 08 00 00       	call   80104d10 <release>

    // Allocate kernel stack for the thread.
    if((t->kstack = kalloc()) == 0){
801044a3:	e8 f8 e0 ff ff       	call   801025a0 <kalloc>
801044a8:	89 c2                	mov    %eax,%edx
801044aa:	89 03                	mov    %eax,(%ebx)
801044ac:	83 c4 10             	add    $0x10,%esp
        return 0;
801044af:	31 c0                	xor    %eax,%eax
    if((t->kstack = kalloc()) == 0){
801044b1:	85 d2                	test   %edx,%edx
801044b3:	74 6e                	je     80104523 <kthread_create+0xe3>
    }
    sp = t->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *t->tf;
801044b5:	8d 82 b4 0f 00 00    	lea    0xfb4(%edx),%eax
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *t->context;
    t->context = (struct context*)sp;
    memset(t->context, 0, sizeof *t->context);
801044bb:	83 ec 04             	sub    $0x4,%esp
    sp -= sizeof *t->context;
801044be:	81 c2 9c 0f 00 00    	add    $0xf9c,%edx
    sp -= sizeof *t->tf;
801044c4:	89 43 14             	mov    %eax,0x14(%ebx)
    *(uint*)sp = (uint)trapret;
801044c7:	c7 42 14 df 60 10 80 	movl   $0x801060df,0x14(%edx)
    t->context = (struct context*)sp;
801044ce:	89 53 18             	mov    %edx,0x18(%ebx)
    memset(t->context, 0, sizeof *t->context);
801044d1:	6a 14                	push   $0x14
801044d3:	6a 00                	push   $0x0
801044d5:	52                   	push   %edx
801044d6:	e8 85 08 00 00       	call   80104d60 <memset>
    t->context->eip = (uint)forkret;
801044db:	8b 43 18             	mov    0x18(%ebx),%eax
801044de:	c7 40 10 50 38 10 80 	movl   $0x80103850,0x10(%eax)

    t->exitRequest = 0;
    t->state = RUNNABLE;
    t->ustack = stack;
801044e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    t->exitRequest = 0;
801044e8:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    t->state = RUNNABLE;
801044ef:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
    t->ustack = stack;
801044f6:	89 43 04             	mov    %eax,0x4(%ebx)
    *t->tf = *mythread()->tf;
801044f9:	e8 a2 f4 ff ff       	call   801039a0 <mythread>
801044fe:	8b 7b 14             	mov    0x14(%ebx),%edi
80104501:	8b 70 14             	mov    0x14(%eax),%esi
80104504:	b9 13 00 00 00       	mov    $0x13,%ecx
80104509:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->eip = (uint)start_func;
8010450b:	8b 55 08             	mov    0x8(%ebp),%edx
    t->tf->esp = (uint)(stack);
8010450e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    return t->tid;
80104511:	83 c4 10             	add    $0x10,%esp
    t->tf->eip = (uint)start_func;
80104514:	8b 43 14             	mov    0x14(%ebx),%eax
80104517:	89 50 38             	mov    %edx,0x38(%eax)
    t->tf->esp = (uint)(stack);
8010451a:	8b 43 14             	mov    0x14(%ebx),%eax
8010451d:	89 48 44             	mov    %ecx,0x44(%eax)
    return t->tid;
80104520:	8b 43 0c             	mov    0xc(%ebx),%eax
}
80104523:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104526:	5b                   	pop    %ebx
80104527:	5e                   	pop    %esi
80104528:	5f                   	pop    %edi
80104529:	5d                   	pop    %ebp
8010452a:	c3                   	ret    
8010452b:	90                   	nop
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&ptable.lock);
80104530:	83 ec 0c             	sub    $0xc,%esp
80104533:	68 80 4e 11 80       	push   $0x80114e80
80104538:	e8 d3 07 00 00       	call   80104d10 <release>
        return -1;
8010453d:	83 c4 10             	add    $0x10,%esp
}
80104540:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80104543:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104548:	5b                   	pop    %ebx
80104549:	5e                   	pop    %esi
8010454a:	5f                   	pop    %edi
8010454b:	5d                   	pop    %ebp
8010454c:	c3                   	ret    
8010454d:	8d 76 00             	lea    0x0(%esi),%esi

80104550 <kthread_id>:

int kthread_id(){
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	83 ec 08             	sub    $0x8,%esp
    //procdump();
    return mythread()->tid;
80104556:	e8 45 f4 ff ff       	call   801039a0 <mythread>
8010455b:	8b 40 0c             	mov    0xc(%eax),%eax
}
8010455e:	c9                   	leave  
8010455f:	c3                   	ret    

80104560 <kthread_exit>:

void kthread_exit(){
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	57                   	push   %edi
80104564:	56                   	push   %esi
80104565:	53                   	push   %ebx
    // check if it is the last running thread. if it is, the process execute exit();
    threadProc = curthread->tproc;
    int lastRunning = 1;
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
            lastRunning = 0;
80104566:	31 f6                	xor    %esi,%esi
    int lastRunning = 1;
80104568:	bb 01 00 00 00       	mov    $0x1,%ebx
void kthread_exit(){
8010456d:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
80104570:	e8 2b f4 ff ff       	call   801039a0 <mythread>
    acquire(&ptable.lock);
80104575:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
80104578:	89 c7                	mov    %eax,%edi
    acquire(&ptable.lock);
8010457a:	68 80 4e 11 80       	push   $0x80114e80
8010457f:	e8 cc 06 00 00       	call   80104c50 <acquire>
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
80104584:	8b 47 10             	mov    0x10(%edi),%eax
80104587:	83 c4 10             	add    $0x10,%esp
8010458a:	8b 40 6c             	mov    0x6c(%eax),%eax
8010458d:	8d 88 40 02 00 00    	lea    0x240(%eax),%ecx
80104593:	90                   	nop
80104594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80104598:	39 c7                	cmp    %eax,%edi
8010459a:	74 0d                	je     801045a9 <kthread_exit+0x49>
8010459c:	8b 50 08             	mov    0x8(%eax),%edx
8010459f:	85 d2                	test   %edx,%edx
801045a1:	74 06                	je     801045a9 <kthread_exit+0x49>
            lastRunning = 0;
801045a3:	83 fa 05             	cmp    $0x5,%edx
801045a6:	0f 45 de             	cmovne %esi,%ebx
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
801045a9:	83 c0 24             	add    $0x24,%eax
801045ac:	39 c8                	cmp    %ecx,%eax
801045ae:	75 e8                	jne    80104598 <kthread_exit+0x38>
        }
    }
    if(lastRunning){
801045b0:	85 db                	test   %ebx,%ebx
801045b2:	75 70                	jne    80104624 <kthread_exit+0xc4>
            lastRunning = 0;
801045b4:	bb b4 4e 11 80       	mov    $0x80114eb4,%ebx
801045b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED){
801045c0:	8b 43 08             	mov    0x8(%ebx),%eax
801045c3:	85 c0                	test   %eax,%eax
801045c5:	74 39                	je     80104600 <kthread_exit+0xa0>
      continue;
    }
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801045c7:	8b 73 6c             	mov    0x6c(%ebx),%esi
801045ca:	89 f2                	mov    %esi,%edx
801045cc:	eb 0f                	jmp    801045dd <kthread_exit+0x7d>
801045ce:	66 90                	xchg   %ax,%ax
801045d0:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
801045d6:	83 c2 24             	add    $0x24,%edx
801045d9:	39 ca                	cmp    %ecx,%edx
801045db:	73 23                	jae    80104600 <kthread_exit+0xa0>
      if(t->state == SLEEPING && t->chan == chan){
801045dd:	83 7a 08 01          	cmpl   $0x1,0x8(%edx)
801045e1:	75 ed                	jne    801045d0 <kthread_exit+0x70>
801045e3:	3b 7a 1c             	cmp    0x1c(%edx),%edi
801045e6:	75 e8                	jne    801045d0 <kthread_exit+0x70>
        t->state = RUNNABLE;
801045e8:	c7 42 08 02 00 00 00 	movl   $0x2,0x8(%edx)
801045ef:	8b 73 6c             	mov    0x6c(%ebx),%esi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801045f2:	83 c2 24             	add    $0x24,%edx
801045f5:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
801045fb:	39 ca                	cmp    %ecx,%edx
801045fd:	72 de                	jb     801045dd <kthread_exit+0x7d>
801045ff:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104600:	83 c3 70             	add    $0x70,%ebx
80104603:	81 fb b4 6a 11 80    	cmp    $0x80116ab4,%ebx
80104609:	72 b5                	jb     801045c0 <kthread_exit+0x60>
    curthread->state = TERMINATED;
8010460b:	c7 47 08 05 00 00 00 	movl   $0x5,0x8(%edi)
    sched();
80104612:	e8 99 f7 ff ff       	call   80103db0 <sched>
    panic("terminated exit");
80104617:	83 ec 0c             	sub    $0xc,%esp
8010461a:	68 e4 80 10 80       	push   $0x801080e4
8010461f:	e8 6c bd ff ff       	call   80100390 <panic>
        release(&ptable.lock);
80104624:	83 ec 0c             	sub    $0xc,%esp
80104627:	68 80 4e 11 80       	push   $0x80114e80
8010462c:	e8 df 06 00 00       	call   80104d10 <release>
        exit();
80104631:	e8 3a f8 ff ff       	call   80103e70 <exit>
80104636:	83 c4 10             	add    $0x10,%esp
80104639:	e9 76 ff ff ff       	jmp    801045b4 <kthread_exit+0x54>
8010463e:	66 90                	xchg   %ax,%ax

80104640 <kthread_join>:
int kthread_join(int thread_id){
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
80104645:	8b 75 08             	mov    0x8(%ebp),%esi
    struct proc *curproc = myproc();
80104648:	e8 23 f3 ff ff       	call   80103970 <myproc>
8010464d:	89 c3                	mov    %eax,%ebx
    struct kthread *curthread = mythread();
8010464f:	e8 4c f3 ff ff       	call   801039a0 <mythread>
    if(curthread->tid == thread_id){
80104654:	39 70 0c             	cmp    %esi,0xc(%eax)
80104657:	0f 84 b3 00 00 00    	je     80104710 <kthread_join+0xd0>
    acquire(&ptable.lock);
8010465d:	83 ec 0c             	sub    $0xc,%esp
80104660:	68 80 4e 11 80       	push   $0x80114e80
80104665:	e8 e6 05 00 00       	call   80104c50 <acquire>
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
8010466a:	8b 5b 6c             	mov    0x6c(%ebx),%ebx
        if (t->tid == thread_id){
8010466d:	83 c4 10             	add    $0x10,%esp
80104670:	3b 73 0c             	cmp    0xc(%ebx),%esi
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80104673:	8d 83 40 02 00 00    	lea    0x240(%ebx),%eax
        if (t->tid == thread_id){
80104679:	74 11                	je     8010468c <kthread_join+0x4c>
8010467b:	90                   	nop
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80104680:	83 c3 24             	add    $0x24,%ebx
80104683:	39 c3                	cmp    %eax,%ebx
80104685:	74 69                	je     801046f0 <kthread_join+0xb0>
        if (t->tid == thread_id){
80104687:	39 73 0c             	cmp    %esi,0xc(%ebx)
8010468a:	75 f4                	jne    80104680 <kthread_join+0x40>
    if (t->state == UNINIT){ // thread was not initialized - no need to wait
8010468c:	8b 43 08             	mov    0x8(%ebx),%eax
8010468f:	85 c0                	test   %eax,%eax
80104691:	74 66                	je     801046f9 <kthread_join+0xb9>
    while (t->state != TERMINATED){ // thread is not finished yet
80104693:	83 f8 05             	cmp    $0x5,%eax
80104696:	74 1f                	je     801046b7 <kthread_join+0x77>
80104698:	90                   	nop
80104699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        sleep(t, &ptable.lock);
801046a0:	83 ec 08             	sub    $0x8,%esp
801046a3:	68 80 4e 11 80       	push   $0x80114e80
801046a8:	53                   	push   %ebx
801046a9:	e8 82 f9 ff ff       	call   80104030 <sleep>
    while (t->state != TERMINATED){ // thread is not finished yet
801046ae:	83 c4 10             	add    $0x10,%esp
801046b1:	83 7b 08 05          	cmpl   $0x5,0x8(%ebx)
801046b5:	75 e9                	jne    801046a0 <kthread_join+0x60>
    kfree(t->kstack);
801046b7:	83 ec 0c             	sub    $0xc,%esp
801046ba:	ff 33                	pushl  (%ebx)
801046bc:	e8 2f dd ff ff       	call   801023f0 <kfree>
    t->kstack = 0;
801046c1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    t->state = UNINIT;
801046c7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    release(&ptable.lock);
801046ce:	c7 04 24 80 4e 11 80 	movl   $0x80114e80,(%esp)
801046d5:	e8 36 06 00 00       	call   80104d10 <release>
    return 0;
801046da:	83 c4 10             	add    $0x10,%esp
801046dd:	31 c0                	xor    %eax,%eax
}
801046df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046e2:	5b                   	pop    %ebx
801046e3:	5e                   	pop    %esi
801046e4:	5d                   	pop    %ebp
801046e5:	c3                   	ret    
801046e6:	8d 76 00             	lea    0x0(%esi),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (t == 0 || t->tid != thread_id){ // thread not found
801046f0:	85 db                	test   %ebx,%ebx
801046f2:	74 05                	je     801046f9 <kthread_join+0xb9>
801046f4:	39 73 0c             	cmp    %esi,0xc(%ebx)
801046f7:	74 93                	je     8010468c <kthread_join+0x4c>
        release(&ptable.lock);
801046f9:	83 ec 0c             	sub    $0xc,%esp
801046fc:	68 80 4e 11 80       	push   $0x80114e80
80104701:	e8 0a 06 00 00       	call   80104d10 <release>
        return -1;
80104706:	83 c4 10             	add    $0x10,%esp
80104709:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010470e:	eb cf                	jmp    801046df <kthread_join+0x9f>
        return -1;
80104710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104715:	eb c8                	jmp    801046df <kthread_join+0x9f>
80104717:	66 90                	xchg   %ax,%ax
80104719:	66 90                	xchg   %ax,%ax
8010471b:	66 90                	xchg   %ax,%ax
8010471d:	66 90                	xchg   %ax,%ax
8010471f:	90                   	nop

80104720 <kthread_mutex_alloc>:
  struct spinlock lock;
  struct kthread_mutex_t mutexes[MAX_MUTEXES];
};
extern struct mutexTable mutexTable;

int kthread_mutex_alloc(){
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	53                   	push   %ebx
    struct kthread_mutex_t *mutex;
    int i = 0;
80104724:	31 db                	xor    %ebx,%ebx
int kthread_mutex_alloc(){
80104726:	83 ec 10             	sub    $0x10,%esp
    acquire(&mutexTable.lock);
80104729:	68 40 3d 11 80       	push   $0x80113d40
8010472e:	e8 1d 05 00 00       	call   80104c50 <acquire>
80104733:	83 c4 10             	add    $0x10,%esp
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104736:	ba 74 3d 11 80       	mov    $0x80113d74,%edx
8010473b:	eb 11                	jmp    8010474e <kthread_mutex_alloc+0x2e>
8010473d:	8d 76 00             	lea    0x0(%esi),%esi
80104740:	83 c2 48             	add    $0x48,%edx
            mutex->used = 1;
            mutex->waitingThreads = 0;
            //cprintf("mutex allocated %d, max mutexts %d\n", mutex->id,MAX_MUTEXES);
            break;
        }
        i++;
80104743:	83 c3 01             	add    $0x1,%ebx
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104746:	81 fa 74 4f 11 80    	cmp    $0x80114f74,%edx
8010474c:	73 26                	jae    80104774 <kthread_mutex_alloc+0x54>
        if(!mutex->used){
8010474e:	8b 42 40             	mov    0x40(%edx),%eax
80104751:	85 c0                	test   %eax,%eax
80104753:	75 eb                	jne    80104740 <kthread_mutex_alloc+0x20>
            mutex->id = i;
80104755:	89 5a 34             	mov    %ebx,0x34(%edx)
            mutex->locked = 0;
80104758:	c7 42 38 00 00 00 00 	movl   $0x0,0x38(%edx)
            mutex->tid = 0;
8010475f:	c7 42 3c 00 00 00 00 	movl   $0x0,0x3c(%edx)
            mutex->used = 1;
80104766:	c7 42 40 01 00 00 00 	movl   $0x1,0x40(%edx)
            mutex->waitingThreads = 0;
8010476d:	c7 42 44 00 00 00 00 	movl   $0x0,0x44(%edx)
    }
    release(&mutexTable.lock);
80104774:	83 ec 0c             	sub    $0xc,%esp
80104777:	68 40 3d 11 80       	push   $0x80113d40
8010477c:	e8 8f 05 00 00       	call   80104d10 <release>
    if(i >= MAX_MUTEXES)
80104781:	83 c4 10             	add    $0x10,%esp
80104784:	83 fb 40             	cmp    $0x40,%ebx
80104787:	74 07                	je     80104790 <kthread_mutex_alloc+0x70>
        return -1;
    else
        return i;
}
80104789:	89 d8                	mov    %ebx,%eax
8010478b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010478e:	c9                   	leave  
8010478f:	c3                   	ret    
        return -1;
80104790:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104795:	eb f2                	jmp    80104789 <kthread_mutex_alloc+0x69>
80104797:	89 f6                	mov    %esi,%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <kthread_mutex_dealloc>:

int kthread_mutex_dealloc(int mutex_id){
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 10             	sub    $0x10,%esp
801047a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct kthread_mutex_t *mutex;
    acquire(&mutexTable.lock);
801047aa:	68 40 3d 11 80       	push   $0x80113d40
801047af:	e8 9c 04 00 00       	call   80104c50 <acquire>
801047b4:	83 c4 10             	add    $0x10,%esp
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
801047b7:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
801047bc:	eb 0c                	jmp    801047ca <kthread_mutex_dealloc+0x2a>
801047be:	66 90                	xchg   %ax,%ax
801047c0:	83 c0 48             	add    $0x48,%eax
801047c3:	3d 74 4f 11 80       	cmp    $0x80114f74,%eax
801047c8:	73 56                	jae    80104820 <kthread_mutex_dealloc+0x80>
        if(mutex->id == mutex_id){
801047ca:	39 58 34             	cmp    %ebx,0x34(%eax)
801047cd:	75 f1                	jne    801047c0 <kthread_mutex_dealloc+0x20>
            if(mutex->locked == 1){
801047cf:	83 78 38 01          	cmpl   $0x1,0x38(%eax)
801047d3:	74 4b                	je     80104820 <kthread_mutex_dealloc+0x80>
                release(&mutexTable.lock);
                return -1;
            }else{
                if(!mutex->used){ // already deallocated
801047d5:	8b 50 40             	mov    0x40(%eax),%edx
801047d8:	85 d2                	test   %edx,%edx
801047da:	74 44                	je     80104820 <kthread_mutex_dealloc+0x80>
                mutex->id = 0;
                mutex->locked = 0;
                mutex->tid = 0;
                mutex->used = 0;
                mutex->waitingThreads = 0;
                release(&mutexTable.lock);
801047dc:	83 ec 0c             	sub    $0xc,%esp
                mutex->id = 0;
801047df:	c7 40 34 00 00 00 00 	movl   $0x0,0x34(%eax)
                mutex->locked = 0;
801047e6:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
                mutex->tid = 0;
801047ed:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
                mutex->used = 0;
801047f4:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%eax)
                mutex->waitingThreads = 0;
801047fb:	c7 40 44 00 00 00 00 	movl   $0x0,0x44(%eax)
                release(&mutexTable.lock);
80104802:	68 40 3d 11 80       	push   $0x80113d40
80104807:	e8 04 05 00 00       	call   80104d10 <release>
                return 0;
8010480c:	83 c4 10             	add    $0x10,%esp
8010480f:	31 c0                	xor    %eax,%eax
        release(&mutexTable.lock);
        return -1;
    }
    release(&mutexTable.lock);
    return -1; // mutex_id does not exist
}
80104811:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104814:	c9                   	leave  
80104815:	c3                   	ret    
80104816:	8d 76 00             	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                release(&mutexTable.lock);
80104820:	83 ec 0c             	sub    $0xc,%esp
80104823:	68 40 3d 11 80       	push   $0x80113d40
80104828:	e8 e3 04 00 00       	call   80104d10 <release>
                return -1;
8010482d:	83 c4 10             	add    $0x10,%esp
80104830:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104835:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104838:	c9                   	leave  
80104839:	c3                   	ret    
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104840 <kthread_mutex_lock>:

int kthread_mutex_lock(int mutex_id){
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	57                   	push   %edi
80104844:	56                   	push   %esi
80104845:	53                   	push   %ebx
    //cprintf("thread %d trying to lock mutex %d\n", mythread()->tid, mutex_id);
    struct kthread_mutex_t *mutex;
    // find the mutex with this mutex_id
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104846:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
int kthread_mutex_lock(int mutex_id){
8010484b:	83 ec 18             	sub    $0x18,%esp
8010484e:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&mutexTable.lock);
80104851:	68 40 3d 11 80       	push   $0x80113d40
80104856:	e8 f5 03 00 00       	call   80104c50 <acquire>
8010485b:	83 c4 10             	add    $0x10,%esp
8010485e:	eb 0b                	jmp    8010486b <kthread_mutex_lock+0x2b>
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104860:	83 c3 48             	add    $0x48,%ebx
80104863:	81 fb 74 4f 11 80    	cmp    $0x80114f74,%ebx
80104869:	73 05                	jae    80104870 <kthread_mutex_lock+0x30>
        if(mutex->id == mutex_id)
8010486b:	39 73 34             	cmp    %esi,0x34(%ebx)
8010486e:	75 f0                	jne    80104860 <kthread_mutex_lock+0x20>
            break;
    }
    release(&mutexTable.lock);
80104870:	83 ec 0c             	sub    $0xc,%esp
80104873:	68 40 3d 11 80       	push   $0x80113d40
80104878:	e8 93 04 00 00       	call   80104d10 <release>
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id was not found
8010487d:	83 c4 10             	add    $0x10,%esp
80104880:	39 73 34             	cmp    %esi,0x34(%ebx)
80104883:	0f 85 9d 00 00 00    	jne    80104926 <kthread_mutex_lock+0xe6>
        return -1;
    }
    if(mutex->used == 0){ // mutex is not allocated
80104889:	8b 73 40             	mov    0x40(%ebx),%esi
8010488c:	85 f6                	test   %esi,%esi
8010488e:	0f 84 92 00 00 00    	je     80104926 <kthread_mutex_lock+0xe6>
        return -1;
    }
    struct kthread *curthread = mythread();
80104894:	e8 07 f1 ff ff       	call   801039a0 <mythread>
    acquire(&mutex->lock);
80104899:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
8010489c:	89 c7                	mov    %eax,%edi
    acquire(&mutex->lock);
8010489e:	53                   	push   %ebx
8010489f:	e8 ac 03 00 00       	call   80104c50 <acquire>
    if (mutex->tid != curthread->tid){
801048a4:	8b 43 3c             	mov    0x3c(%ebx),%eax
801048a7:	83 c4 10             	add    $0x10,%esp
801048aa:	3b 47 0c             	cmp    0xc(%edi),%eax
801048ad:	74 61                	je     80104910 <kthread_mutex_lock+0xd0>
            mutex->waitingThreads+=1;
    }
    while (mutex->locked) { // wait for the lock to be unlocked
801048af:	8b 4b 38             	mov    0x38(%ebx),%ecx
            mutex->waitingThreads+=1;
801048b2:	83 43 44 01          	addl   $0x1,0x44(%ebx)
    while (mutex->locked) { // wait for the lock to be unlocked
801048b6:	85 c9                	test   %ecx,%ecx
801048b8:	74 1d                	je     801048d7 <kthread_mutex_lock+0x97>
801048ba:	8d 73 3c             	lea    0x3c(%ebx),%esi
801048bd:	8d 76 00             	lea    0x0(%esi),%esi
        //cprintf("mutex_lock------thread %d going to sleep on mutex %d\n", mythread()->tid, mutex->id);
        sleep(&mutex->tid, &mutex->lock);
801048c0:	83 ec 08             	sub    $0x8,%esp
801048c3:	53                   	push   %ebx
801048c4:	56                   	push   %esi
801048c5:	e8 66 f7 ff ff       	call   80104030 <sleep>
    while (mutex->locked) { // wait for the lock to be unlocked
801048ca:	8b 53 38             	mov    0x38(%ebx),%edx
801048cd:	83 c4 10             	add    $0x10,%esp
801048d0:	85 d2                	test   %edx,%edx
801048d2:	75 ec                	jne    801048c0 <kthread_mutex_lock+0x80>
801048d4:	8b 43 3c             	mov    0x3c(%ebx),%eax
    }
    if(mutex->locked == 0){ // catch the free lock
         if (mutex->tid != curthread->tid )
801048d7:	39 47 0c             	cmp    %eax,0xc(%edi)
801048da:	8b 53 44             	mov    0x44(%ebx),%edx
801048dd:	74 41                	je     80104920 <kthread_mutex_lock+0xe0>
            mutex->waitingThreads-=1;
801048df:	83 ea 01             	sub    $0x1,%edx
801048e2:	89 53 44             	mov    %edx,0x44(%ebx)
        if (mutex->tid != curthread->tid || (mutex->tid == curthread->tid && mutex->waitingThreads == 0)){ // lock only if you are not the previouse thread who locked
801048e5:	39 47 0c             	cmp    %eax,0xc(%edi)
801048e8:	74 36                	je     80104920 <kthread_mutex_lock+0xe0>
            mutex->locked = 1;
801048ea:	c7 43 38 01 00 00 00 	movl   $0x1,0x38(%ebx)
            mutex->tid = curthread->tid;
801048f1:	8b 47 0c             	mov    0xc(%edi),%eax
801048f4:	89 43 3c             	mov    %eax,0x3c(%ebx)
        }
    }
    release(&mutex->lock);
801048f7:	83 ec 0c             	sub    $0xc,%esp
801048fa:	53                   	push   %ebx
801048fb:	e8 10 04 00 00       	call   80104d10 <release>
    return 0;
80104900:	83 c4 10             	add    $0x10,%esp
80104903:	31 c0                	xor    %eax,%eax
}
80104905:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104908:	5b                   	pop    %ebx
80104909:	5e                   	pop    %esi
8010490a:	5f                   	pop    %edi
8010490b:	5d                   	pop    %ebp
8010490c:	c3                   	ret    
8010490d:	8d 76 00             	lea    0x0(%esi),%esi
    while (mutex->locked) { // wait for the lock to be unlocked
80104910:	8b 43 38             	mov    0x38(%ebx),%eax
80104913:	85 c0                	test   %eax,%eax
80104915:	75 a3                	jne    801048ba <kthread_mutex_lock+0x7a>
80104917:	8b 53 44             	mov    0x44(%ebx),%edx
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (mutex->tid != curthread->tid || (mutex->tid == curthread->tid && mutex->waitingThreads == 0)){ // lock only if you are not the previouse thread who locked
80104920:	85 d2                	test   %edx,%edx
80104922:	74 c6                	je     801048ea <kthread_mutex_lock+0xaa>
80104924:	eb d1                	jmp    801048f7 <kthread_mutex_lock+0xb7>
        return -1;
80104926:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010492b:	eb d8                	jmp    80104905 <kthread_mutex_lock+0xc5>
8010492d:	8d 76 00             	lea    0x0(%esi),%esi

80104930 <kthread_mutex_unlock>:

int kthread_mutex_unlock(int mutex_id){
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	8b 75 08             	mov    0x8(%ebp),%esi
    //cprintf("thread %d trying to unlock mutex %d\n", mythread()->tid, mutex_id);
    struct kthread_mutex_t *mutex;
    // find the mutex with this mutex_id
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104938:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
    acquire(&mutexTable.lock);
8010493d:	83 ec 0c             	sub    $0xc,%esp
80104940:	68 40 3d 11 80       	push   $0x80113d40
80104945:	e8 06 03 00 00       	call   80104c50 <acquire>
8010494a:	83 c4 10             	add    $0x10,%esp
8010494d:	eb 0c                	jmp    8010495b <kthread_mutex_unlock+0x2b>
8010494f:	90                   	nop
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104950:	83 c3 48             	add    $0x48,%ebx
80104953:	81 fb 74 4f 11 80    	cmp    $0x80114f74,%ebx
80104959:	73 05                	jae    80104960 <kthread_mutex_unlock+0x30>
        if(mutex->id == mutex_id)
8010495b:	39 73 34             	cmp    %esi,0x34(%ebx)
8010495e:	75 f0                	jne    80104950 <kthread_mutex_unlock+0x20>
            break;
    }
    release(&mutexTable.lock);
80104960:	83 ec 0c             	sub    $0xc,%esp
80104963:	68 40 3d 11 80       	push   $0x80113d40
80104968:	e8 a3 03 00 00       	call   80104d10 <release>
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id was not found
8010496d:	83 c4 10             	add    $0x10,%esp
80104970:	39 73 34             	cmp    %esi,0x34(%ebx)
80104973:	75 53                	jne    801049c8 <kthread_mutex_unlock+0x98>
        return -1;
    }
    struct kthread *curthread = mythread();
80104975:	e8 26 f0 ff ff       	call   801039a0 <mythread>
    if(curthread->tid != mutex->tid){ 
8010497a:	8b 53 3c             	mov    0x3c(%ebx),%edx
8010497d:	39 50 0c             	cmp    %edx,0xc(%eax)
80104980:	75 46                	jne    801049c8 <kthread_mutex_unlock+0x98>
        return -1;
    }

    acquire(&mutex->lock);
80104982:	83 ec 0c             	sub    $0xc,%esp
80104985:	53                   	push   %ebx
80104986:	e8 c5 02 00 00       	call   80104c50 <acquire>
    if (mutex->locked == 0){ // mutex is not locked
8010498b:	8b 43 38             	mov    0x38(%ebx),%eax
8010498e:	83 c4 10             	add    $0x10,%esp
80104991:	85 c0                	test   %eax,%eax
80104993:	74 27                	je     801049bc <kthread_mutex_unlock+0x8c>
        return -1;
    }
    //cprintf("thread %d unlocking the mutex %d\n", mythread()->tid, mutex->id);
    mutex->locked = 0; // release the mutex
    //mutex->tid = 0;
    release(&mutex->lock);
80104995:	83 ec 0c             	sub    $0xc,%esp
    mutex->locked = 0; // release the mutex
80104998:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%ebx)
    release(&mutex->lock);
8010499f:	53                   	push   %ebx
    wakeup(&mutex->tid);
801049a0:	83 c3 3c             	add    $0x3c,%ebx
    release(&mutex->lock);
801049a3:	e8 68 03 00 00       	call   80104d10 <release>
    wakeup(&mutex->tid);
801049a8:	89 1c 24             	mov    %ebx,(%esp)
801049ab:	e8 d0 f8 ff ff       	call   80104280 <wakeup>
    //cprintf("wake up threads sleeping on mutex %d\n", mutex->id);
    return 0;
801049b0:	83 c4 10             	add    $0x10,%esp
}
801049b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
801049b6:	31 c0                	xor    %eax,%eax
}
801049b8:	5b                   	pop    %ebx
801049b9:	5e                   	pop    %esi
801049ba:	5d                   	pop    %ebp
801049bb:	c3                   	ret    
        release(&mutex->lock);
801049bc:	83 ec 0c             	sub    $0xc,%esp
801049bf:	53                   	push   %ebx
801049c0:	e8 4b 03 00 00       	call   80104d10 <release>
        return -1;
801049c5:	83 c4 10             	add    $0x10,%esp
}
801049c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return -1;
801049cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049d0:	5b                   	pop    %ebx
801049d1:	5e                   	pop    %esi
801049d2:	5d                   	pop    %ebp
801049d3:	c3                   	ret    
801049d4:	66 90                	xchg   %ax,%ax
801049d6:	66 90                	xchg   %ax,%ax
801049d8:	66 90                	xchg   %ax,%ax
801049da:	66 90                	xchg   %ax,%ax
801049dc:	66 90                	xchg   %ax,%ax
801049de:	66 90                	xchg   %ax,%ax

801049e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	53                   	push   %ebx
801049e4:	83 ec 0c             	sub    $0xc,%esp
801049e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801049ea:	68 f4 80 10 80       	push   $0x801080f4
801049ef:	8d 43 04             	lea    0x4(%ebx),%eax
801049f2:	50                   	push   %eax
801049f3:	e8 18 01 00 00       	call   80104b10 <initlock>
  lk->name = name;
801049f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801049fb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104a01:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104a04:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104a0b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104a0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a11:	c9                   	leave  
80104a12:	c3                   	ret    
80104a13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	53                   	push   %ebx
80104a25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a28:	83 ec 0c             	sub    $0xc,%esp
80104a2b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a2e:	56                   	push   %esi
80104a2f:	e8 1c 02 00 00       	call   80104c50 <acquire>
  while (lk->locked) {
80104a34:	8b 13                	mov    (%ebx),%edx
80104a36:	83 c4 10             	add    $0x10,%esp
80104a39:	85 d2                	test   %edx,%edx
80104a3b:	74 16                	je     80104a53 <acquiresleep+0x33>
80104a3d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104a40:	83 ec 08             	sub    $0x8,%esp
80104a43:	56                   	push   %esi
80104a44:	53                   	push   %ebx
80104a45:	e8 e6 f5 ff ff       	call   80104030 <sleep>
  while (lk->locked) {
80104a4a:	8b 03                	mov    (%ebx),%eax
80104a4c:	83 c4 10             	add    $0x10,%esp
80104a4f:	85 c0                	test   %eax,%eax
80104a51:	75 ed                	jne    80104a40 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104a53:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104a59:	e8 12 ef ff ff       	call   80103970 <myproc>
80104a5e:	8b 40 0c             	mov    0xc(%eax),%eax
80104a61:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104a64:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104a67:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a6a:	5b                   	pop    %ebx
80104a6b:	5e                   	pop    %esi
80104a6c:	5d                   	pop    %ebp
  release(&lk->lk);
80104a6d:	e9 9e 02 00 00       	jmp    80104d10 <release>
80104a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a80 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	56                   	push   %esi
80104a84:	53                   	push   %ebx
80104a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a88:	83 ec 0c             	sub    $0xc,%esp
80104a8b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a8e:	56                   	push   %esi
80104a8f:	e8 bc 01 00 00       	call   80104c50 <acquire>
  lk->locked = 0;
80104a94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104a9a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104aa1:	89 1c 24             	mov    %ebx,(%esp)
80104aa4:	e8 d7 f7 ff ff       	call   80104280 <wakeup>
  release(&lk->lk);
80104aa9:	89 75 08             	mov    %esi,0x8(%ebp)
80104aac:	83 c4 10             	add    $0x10,%esp
}
80104aaf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ab2:	5b                   	pop    %ebx
80104ab3:	5e                   	pop    %esi
80104ab4:	5d                   	pop    %ebp
  release(&lk->lk);
80104ab5:	e9 56 02 00 00       	jmp    80104d10 <release>
80104aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ac0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	57                   	push   %edi
80104ac4:	56                   	push   %esi
80104ac5:	53                   	push   %ebx
80104ac6:	31 ff                	xor    %edi,%edi
80104ac8:	83 ec 18             	sub    $0x18,%esp
80104acb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ace:	8d 73 04             	lea    0x4(%ebx),%esi
80104ad1:	56                   	push   %esi
80104ad2:	e8 79 01 00 00       	call   80104c50 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ad7:	8b 03                	mov    (%ebx),%eax
80104ad9:	83 c4 10             	add    $0x10,%esp
80104adc:	85 c0                	test   %eax,%eax
80104ade:	74 13                	je     80104af3 <holdingsleep+0x33>
80104ae0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104ae3:	e8 88 ee ff ff       	call   80103970 <myproc>
80104ae8:	39 58 0c             	cmp    %ebx,0xc(%eax)
80104aeb:	0f 94 c0             	sete   %al
80104aee:	0f b6 c0             	movzbl %al,%eax
80104af1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104af3:	83 ec 0c             	sub    $0xc,%esp
80104af6:	56                   	push   %esi
80104af7:	e8 14 02 00 00       	call   80104d10 <release>
  return r;
}
80104afc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aff:	89 f8                	mov    %edi,%eax
80104b01:	5b                   	pop    %ebx
80104b02:	5e                   	pop    %esi
80104b03:	5f                   	pop    %edi
80104b04:	5d                   	pop    %ebp
80104b05:	c3                   	ret    
80104b06:	66 90                	xchg   %ax,%ax
80104b08:	66 90                	xchg   %ax,%ax
80104b0a:	66 90                	xchg   %ax,%ax
80104b0c:	66 90                	xchg   %ax,%ax
80104b0e:	66 90                	xchg   %ax,%ax

80104b10 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104b16:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104b19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104b1f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104b22:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b29:	5d                   	pop    %ebp
80104b2a:	c3                   	ret    
80104b2b:	90                   	nop
80104b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b30 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104b30:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b31:	31 d2                	xor    %edx,%edx
{
80104b33:	89 e5                	mov    %esp,%ebp
80104b35:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104b36:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104b39:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b3c:	83 e8 08             	sub    $0x8,%eax
80104b3f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b40:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b46:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b4c:	77 1a                	ja     80104b68 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b4e:	8b 58 04             	mov    0x4(%eax),%ebx
80104b51:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b54:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b57:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b59:	83 fa 0a             	cmp    $0xa,%edx
80104b5c:	75 e2                	jne    80104b40 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104b5e:	5b                   	pop    %ebx
80104b5f:	5d                   	pop    %ebp
80104b60:	c3                   	ret    
80104b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b68:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104b6b:	83 c1 28             	add    $0x28,%ecx
80104b6e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104b70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104b76:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104b79:	39 c1                	cmp    %eax,%ecx
80104b7b:	75 f3                	jne    80104b70 <getcallerpcs+0x40>
}
80104b7d:	5b                   	pop    %ebx
80104b7e:	5d                   	pop    %ebp
80104b7f:	c3                   	ret    

80104b80 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	53                   	push   %ebx
80104b84:	83 ec 04             	sub    $0x4,%esp
80104b87:	9c                   	pushf  
80104b88:	5b                   	pop    %ebx
  asm volatile("cli");
80104b89:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b8a:	e8 41 ed ff ff       	call   801038d0 <mycpu>
80104b8f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104b95:	85 c0                	test   %eax,%eax
80104b97:	75 11                	jne    80104baa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104b99:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b9f:	e8 2c ed ff ff       	call   801038d0 <mycpu>
80104ba4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104baa:	e8 21 ed ff ff       	call   801038d0 <mycpu>
80104baf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104bb6:	83 c4 04             	add    $0x4,%esp
80104bb9:	5b                   	pop    %ebx
80104bba:	5d                   	pop    %ebp
80104bbb:	c3                   	ret    
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bc0 <popcli>:

void
popcli(void)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104bc6:	9c                   	pushf  
80104bc7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104bc8:	f6 c4 02             	test   $0x2,%ah
80104bcb:	75 35                	jne    80104c02 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104bcd:	e8 fe ec ff ff       	call   801038d0 <mycpu>
80104bd2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104bd9:	78 34                	js     80104c0f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104bdb:	e8 f0 ec ff ff       	call   801038d0 <mycpu>
80104be0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104be6:	85 d2                	test   %edx,%edx
80104be8:	74 06                	je     80104bf0 <popcli+0x30>
    sti();
}
80104bea:	c9                   	leave  
80104beb:	c3                   	ret    
80104bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104bf0:	e8 db ec ff ff       	call   801038d0 <mycpu>
80104bf5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104bfb:	85 c0                	test   %eax,%eax
80104bfd:	74 eb                	je     80104bea <popcli+0x2a>
  asm volatile("sti");
80104bff:	fb                   	sti    
}
80104c00:	c9                   	leave  
80104c01:	c3                   	ret    
    panic("popcli - interruptible");
80104c02:	83 ec 0c             	sub    $0xc,%esp
80104c05:	68 ff 80 10 80       	push   $0x801080ff
80104c0a:	e8 81 b7 ff ff       	call   80100390 <panic>
    panic("popcli");
80104c0f:	83 ec 0c             	sub    $0xc,%esp
80104c12:	68 16 81 10 80       	push   $0x80108116
80104c17:	e8 74 b7 ff ff       	call   80100390 <panic>
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c20 <holding>:
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	56                   	push   %esi
80104c24:	53                   	push   %ebx
80104c25:	8b 75 08             	mov    0x8(%ebp),%esi
80104c28:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c2a:	e8 51 ff ff ff       	call   80104b80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c2f:	8b 06                	mov    (%esi),%eax
80104c31:	85 c0                	test   %eax,%eax
80104c33:	74 10                	je     80104c45 <holding+0x25>
80104c35:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c38:	e8 93 ec ff ff       	call   801038d0 <mycpu>
80104c3d:	39 c3                	cmp    %eax,%ebx
80104c3f:	0f 94 c3             	sete   %bl
80104c42:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104c45:	e8 76 ff ff ff       	call   80104bc0 <popcli>
}
80104c4a:	89 d8                	mov    %ebx,%eax
80104c4c:	5b                   	pop    %ebx
80104c4d:	5e                   	pop    %esi
80104c4e:	5d                   	pop    %ebp
80104c4f:	c3                   	ret    

80104c50 <acquire>:
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	56                   	push   %esi
80104c54:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c55:	e8 26 ff ff ff       	call   80104b80 <pushcli>
  if(holding(lk))
80104c5a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c5d:	83 ec 0c             	sub    $0xc,%esp
80104c60:	53                   	push   %ebx
80104c61:	e8 ba ff ff ff       	call   80104c20 <holding>
80104c66:	83 c4 10             	add    $0x10,%esp
80104c69:	85 c0                	test   %eax,%eax
80104c6b:	0f 85 83 00 00 00    	jne    80104cf4 <acquire+0xa4>
80104c71:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104c73:	ba 01 00 00 00       	mov    $0x1,%edx
80104c78:	eb 09                	jmp    80104c83 <acquire+0x33>
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c80:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c83:	89 d0                	mov    %edx,%eax
80104c85:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104c88:	85 c0                	test   %eax,%eax
80104c8a:	75 f4                	jne    80104c80 <acquire+0x30>
  __sync_synchronize();
80104c8c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c94:	e8 37 ec ff ff       	call   801038d0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104c99:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104c9c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104c9f:	89 e8                	mov    %ebp,%eax
80104ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ca8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104cae:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104cb4:	77 1a                	ja     80104cd0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104cb6:	8b 48 04             	mov    0x4(%eax),%ecx
80104cb9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104cbc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104cbf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104cc1:	83 fe 0a             	cmp    $0xa,%esi
80104cc4:	75 e2                	jne    80104ca8 <acquire+0x58>
}
80104cc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cc9:	5b                   	pop    %ebx
80104cca:	5e                   	pop    %esi
80104ccb:	5d                   	pop    %ebp
80104ccc:	c3                   	ret    
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi
80104cd0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104cd3:	83 c2 28             	add    $0x28,%edx
80104cd6:	8d 76 00             	lea    0x0(%esi),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104ce0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ce6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104ce9:	39 d0                	cmp    %edx,%eax
80104ceb:	75 f3                	jne    80104ce0 <acquire+0x90>
}
80104ced:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cf0:	5b                   	pop    %ebx
80104cf1:	5e                   	pop    %esi
80104cf2:	5d                   	pop    %ebp
80104cf3:	c3                   	ret    
    panic("acquire");
80104cf4:	83 ec 0c             	sub    $0xc,%esp
80104cf7:	68 1d 81 10 80       	push   $0x8010811d
80104cfc:	e8 8f b6 ff ff       	call   80100390 <panic>
80104d01:	eb 0d                	jmp    80104d10 <release>
80104d03:	90                   	nop
80104d04:	90                   	nop
80104d05:	90                   	nop
80104d06:	90                   	nop
80104d07:	90                   	nop
80104d08:	90                   	nop
80104d09:	90                   	nop
80104d0a:	90                   	nop
80104d0b:	90                   	nop
80104d0c:	90                   	nop
80104d0d:	90                   	nop
80104d0e:	90                   	nop
80104d0f:	90                   	nop

80104d10 <release>:
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	53                   	push   %ebx
80104d14:	83 ec 10             	sub    $0x10,%esp
80104d17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d1a:	53                   	push   %ebx
80104d1b:	e8 00 ff ff ff       	call   80104c20 <holding>
80104d20:	83 c4 10             	add    $0x10,%esp
80104d23:	85 c0                	test   %eax,%eax
80104d25:	74 22                	je     80104d49 <release+0x39>
  lk->pcs[0] = 0;
80104d27:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d2e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d35:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d3a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d43:	c9                   	leave  
  popcli();
80104d44:	e9 77 fe ff ff       	jmp    80104bc0 <popcli>
    panic("release");
80104d49:	83 ec 0c             	sub    $0xc,%esp
80104d4c:	68 25 81 10 80       	push   $0x80108125
80104d51:	e8 3a b6 ff ff       	call   80100390 <panic>
80104d56:	66 90                	xchg   %ax,%ax
80104d58:	66 90                	xchg   %ax,%ax
80104d5a:	66 90                	xchg   %ax,%ax
80104d5c:	66 90                	xchg   %ax,%ax
80104d5e:	66 90                	xchg   %ax,%ax

80104d60 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	57                   	push   %edi
80104d64:	53                   	push   %ebx
80104d65:	8b 55 08             	mov    0x8(%ebp),%edx
80104d68:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104d6b:	f6 c2 03             	test   $0x3,%dl
80104d6e:	75 05                	jne    80104d75 <memset+0x15>
80104d70:	f6 c1 03             	test   $0x3,%cl
80104d73:	74 13                	je     80104d88 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104d75:	89 d7                	mov    %edx,%edi
80104d77:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d7a:	fc                   	cld    
80104d7b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104d7d:	5b                   	pop    %ebx
80104d7e:	89 d0                	mov    %edx,%eax
80104d80:	5f                   	pop    %edi
80104d81:	5d                   	pop    %ebp
80104d82:	c3                   	ret    
80104d83:	90                   	nop
80104d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104d88:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d8c:	c1 e9 02             	shr    $0x2,%ecx
80104d8f:	89 f8                	mov    %edi,%eax
80104d91:	89 fb                	mov    %edi,%ebx
80104d93:	c1 e0 18             	shl    $0x18,%eax
80104d96:	c1 e3 10             	shl    $0x10,%ebx
80104d99:	09 d8                	or     %ebx,%eax
80104d9b:	09 f8                	or     %edi,%eax
80104d9d:	c1 e7 08             	shl    $0x8,%edi
80104da0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104da2:	89 d7                	mov    %edx,%edi
80104da4:	fc                   	cld    
80104da5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104da7:	5b                   	pop    %ebx
80104da8:	89 d0                	mov    %edx,%eax
80104daa:	5f                   	pop    %edi
80104dab:	5d                   	pop    %ebp
80104dac:	c3                   	ret    
80104dad:	8d 76 00             	lea    0x0(%esi),%esi

80104db0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	57                   	push   %edi
80104db4:	56                   	push   %esi
80104db5:	53                   	push   %ebx
80104db6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104db9:	8b 75 08             	mov    0x8(%ebp),%esi
80104dbc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104dbf:	85 db                	test   %ebx,%ebx
80104dc1:	74 29                	je     80104dec <memcmp+0x3c>
    if(*s1 != *s2)
80104dc3:	0f b6 16             	movzbl (%esi),%edx
80104dc6:	0f b6 0f             	movzbl (%edi),%ecx
80104dc9:	38 d1                	cmp    %dl,%cl
80104dcb:	75 2b                	jne    80104df8 <memcmp+0x48>
80104dcd:	b8 01 00 00 00       	mov    $0x1,%eax
80104dd2:	eb 14                	jmp    80104de8 <memcmp+0x38>
80104dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104dd8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104ddc:	83 c0 01             	add    $0x1,%eax
80104ddf:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104de4:	38 ca                	cmp    %cl,%dl
80104de6:	75 10                	jne    80104df8 <memcmp+0x48>
  while(n-- > 0){
80104de8:	39 d8                	cmp    %ebx,%eax
80104dea:	75 ec                	jne    80104dd8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104dec:	5b                   	pop    %ebx
  return 0;
80104ded:	31 c0                	xor    %eax,%eax
}
80104def:	5e                   	pop    %esi
80104df0:	5f                   	pop    %edi
80104df1:	5d                   	pop    %ebp
80104df2:	c3                   	ret    
80104df3:	90                   	nop
80104df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104df8:	0f b6 c2             	movzbl %dl,%eax
}
80104dfb:	5b                   	pop    %ebx
      return *s1 - *s2;
80104dfc:	29 c8                	sub    %ecx,%eax
}
80104dfe:	5e                   	pop    %esi
80104dff:	5f                   	pop    %edi
80104e00:	5d                   	pop    %ebp
80104e01:	c3                   	ret    
80104e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	56                   	push   %esi
80104e14:	53                   	push   %ebx
80104e15:	8b 45 08             	mov    0x8(%ebp),%eax
80104e18:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104e1b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e1e:	39 c3                	cmp    %eax,%ebx
80104e20:	73 26                	jae    80104e48 <memmove+0x38>
80104e22:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104e25:	39 c8                	cmp    %ecx,%eax
80104e27:	73 1f                	jae    80104e48 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104e29:	85 f6                	test   %esi,%esi
80104e2b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104e2e:	74 0f                	je     80104e3f <memmove+0x2f>
      *--d = *--s;
80104e30:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e34:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104e37:	83 ea 01             	sub    $0x1,%edx
80104e3a:	83 fa ff             	cmp    $0xffffffff,%edx
80104e3d:	75 f1                	jne    80104e30 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e3f:	5b                   	pop    %ebx
80104e40:	5e                   	pop    %esi
80104e41:	5d                   	pop    %ebp
80104e42:	c3                   	ret    
80104e43:	90                   	nop
80104e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104e48:	31 d2                	xor    %edx,%edx
80104e4a:	85 f6                	test   %esi,%esi
80104e4c:	74 f1                	je     80104e3f <memmove+0x2f>
80104e4e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104e50:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e54:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104e57:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104e5a:	39 d6                	cmp    %edx,%esi
80104e5c:	75 f2                	jne    80104e50 <memmove+0x40>
}
80104e5e:	5b                   	pop    %ebx
80104e5f:	5e                   	pop    %esi
80104e60:	5d                   	pop    %ebp
80104e61:	c3                   	ret    
80104e62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104e73:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104e74:	eb 9a                	jmp    80104e10 <memmove>
80104e76:	8d 76 00             	lea    0x0(%esi),%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e80 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	57                   	push   %edi
80104e84:	56                   	push   %esi
80104e85:	8b 7d 10             	mov    0x10(%ebp),%edi
80104e88:	53                   	push   %ebx
80104e89:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e8c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104e8f:	85 ff                	test   %edi,%edi
80104e91:	74 2f                	je     80104ec2 <strncmp+0x42>
80104e93:	0f b6 01             	movzbl (%ecx),%eax
80104e96:	0f b6 1e             	movzbl (%esi),%ebx
80104e99:	84 c0                	test   %al,%al
80104e9b:	74 37                	je     80104ed4 <strncmp+0x54>
80104e9d:	38 c3                	cmp    %al,%bl
80104e9f:	75 33                	jne    80104ed4 <strncmp+0x54>
80104ea1:	01 f7                	add    %esi,%edi
80104ea3:	eb 13                	jmp    80104eb8 <strncmp+0x38>
80104ea5:	8d 76 00             	lea    0x0(%esi),%esi
80104ea8:	0f b6 01             	movzbl (%ecx),%eax
80104eab:	84 c0                	test   %al,%al
80104ead:	74 21                	je     80104ed0 <strncmp+0x50>
80104eaf:	0f b6 1a             	movzbl (%edx),%ebx
80104eb2:	89 d6                	mov    %edx,%esi
80104eb4:	38 d8                	cmp    %bl,%al
80104eb6:	75 1c                	jne    80104ed4 <strncmp+0x54>
    n--, p++, q++;
80104eb8:	8d 56 01             	lea    0x1(%esi),%edx
80104ebb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104ebe:	39 fa                	cmp    %edi,%edx
80104ec0:	75 e6                	jne    80104ea8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104ec2:	5b                   	pop    %ebx
    return 0;
80104ec3:	31 c0                	xor    %eax,%eax
}
80104ec5:	5e                   	pop    %esi
80104ec6:	5f                   	pop    %edi
80104ec7:	5d                   	pop    %ebp
80104ec8:	c3                   	ret    
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ed0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104ed4:	29 d8                	sub    %ebx,%eax
}
80104ed6:	5b                   	pop    %ebx
80104ed7:	5e                   	pop    %esi
80104ed8:	5f                   	pop    %edi
80104ed9:	5d                   	pop    %ebp
80104eda:	c3                   	ret    
80104edb:	90                   	nop
80104edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ee0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	56                   	push   %esi
80104ee4:	53                   	push   %ebx
80104ee5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ee8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104eeb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104eee:	89 c2                	mov    %eax,%edx
80104ef0:	eb 19                	jmp    80104f0b <strncpy+0x2b>
80104ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ef8:	83 c3 01             	add    $0x1,%ebx
80104efb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104eff:	83 c2 01             	add    $0x1,%edx
80104f02:	84 c9                	test   %cl,%cl
80104f04:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f07:	74 09                	je     80104f12 <strncpy+0x32>
80104f09:	89 f1                	mov    %esi,%ecx
80104f0b:	85 c9                	test   %ecx,%ecx
80104f0d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104f10:	7f e6                	jg     80104ef8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f12:	31 c9                	xor    %ecx,%ecx
80104f14:	85 f6                	test   %esi,%esi
80104f16:	7e 17                	jle    80104f2f <strncpy+0x4f>
80104f18:	90                   	nop
80104f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104f20:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104f24:	89 f3                	mov    %esi,%ebx
80104f26:	83 c1 01             	add    $0x1,%ecx
80104f29:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104f2b:	85 db                	test   %ebx,%ebx
80104f2d:	7f f1                	jg     80104f20 <strncpy+0x40>
  return os;
}
80104f2f:	5b                   	pop    %ebx
80104f30:	5e                   	pop    %esi
80104f31:	5d                   	pop    %ebp
80104f32:	c3                   	ret    
80104f33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f40 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	56                   	push   %esi
80104f44:	53                   	push   %ebx
80104f45:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f48:	8b 45 08             	mov    0x8(%ebp),%eax
80104f4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104f4e:	85 c9                	test   %ecx,%ecx
80104f50:	7e 26                	jle    80104f78 <safestrcpy+0x38>
80104f52:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104f56:	89 c1                	mov    %eax,%ecx
80104f58:	eb 17                	jmp    80104f71 <safestrcpy+0x31>
80104f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f60:	83 c2 01             	add    $0x1,%edx
80104f63:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104f67:	83 c1 01             	add    $0x1,%ecx
80104f6a:	84 db                	test   %bl,%bl
80104f6c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104f6f:	74 04                	je     80104f75 <safestrcpy+0x35>
80104f71:	39 f2                	cmp    %esi,%edx
80104f73:	75 eb                	jne    80104f60 <safestrcpy+0x20>
    ;
  *s = 0;
80104f75:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104f78:	5b                   	pop    %ebx
80104f79:	5e                   	pop    %esi
80104f7a:	5d                   	pop    %ebp
80104f7b:	c3                   	ret    
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f80 <strlen>:

int
strlen(const char *s)
{
80104f80:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f81:	31 c0                	xor    %eax,%eax
{
80104f83:	89 e5                	mov    %esp,%ebp
80104f85:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f88:	80 3a 00             	cmpb   $0x0,(%edx)
80104f8b:	74 0c                	je     80104f99 <strlen+0x19>
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
80104f90:	83 c0 01             	add    $0x1,%eax
80104f93:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f97:	75 f7                	jne    80104f90 <strlen+0x10>
    ;
  return n;
}
80104f99:	5d                   	pop    %ebp
80104f9a:	c3                   	ret    

80104f9b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f9b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f9f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104fa3:	55                   	push   %ebp
  pushl %ebx
80104fa4:	53                   	push   %ebx
  pushl %esi
80104fa5:	56                   	push   %esi
  pushl %edi
80104fa6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104fa7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104fa9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104fab:	5f                   	pop    %edi
  popl %esi
80104fac:	5e                   	pop    %esi
  popl %ebx
80104fad:	5b                   	pop    %ebx
  popl %ebp
80104fae:	5d                   	pop    %ebp
  ret
80104faf:	c3                   	ret    

80104fb0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	53                   	push   %ebx
80104fb4:	83 ec 04             	sub    $0x4,%esp
80104fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104fba:	e8 b1 e9 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fbf:	8b 00                	mov    (%eax),%eax
80104fc1:	39 d8                	cmp    %ebx,%eax
80104fc3:	76 1b                	jbe    80104fe0 <fetchint+0x30>
80104fc5:	8d 53 04             	lea    0x4(%ebx),%edx
80104fc8:	39 d0                	cmp    %edx,%eax
80104fca:	72 14                	jb     80104fe0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fcf:	8b 13                	mov    (%ebx),%edx
80104fd1:	89 10                	mov    %edx,(%eax)
  return 0;
80104fd3:	31 c0                	xor    %eax,%eax
}
80104fd5:	83 c4 04             	add    $0x4,%esp
80104fd8:	5b                   	pop    %ebx
80104fd9:	5d                   	pop    %ebp
80104fda:	c3                   	ret    
80104fdb:	90                   	nop
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe5:	eb ee                	jmp    80104fd5 <fetchint+0x25>
80104fe7:	89 f6                	mov    %esi,%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ff0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	53                   	push   %ebx
80104ff4:	83 ec 04             	sub    $0x4,%esp
80104ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104ffa:	e8 71 e9 ff ff       	call   80103970 <myproc>

  if(addr >= curproc->sz)
80104fff:	39 18                	cmp    %ebx,(%eax)
80105001:	76 29                	jbe    8010502c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105003:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105006:	89 da                	mov    %ebx,%edx
80105008:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010500a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010500c:	39 c3                	cmp    %eax,%ebx
8010500e:	73 1c                	jae    8010502c <fetchstr+0x3c>
    if(*s == 0)
80105010:	80 3b 00             	cmpb   $0x0,(%ebx)
80105013:	75 10                	jne    80105025 <fetchstr+0x35>
80105015:	eb 39                	jmp    80105050 <fetchstr+0x60>
80105017:	89 f6                	mov    %esi,%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105020:	80 3a 00             	cmpb   $0x0,(%edx)
80105023:	74 1b                	je     80105040 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105025:	83 c2 01             	add    $0x1,%edx
80105028:	39 d0                	cmp    %edx,%eax
8010502a:	77 f4                	ja     80105020 <fetchstr+0x30>
    return -1;
8010502c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105031:	83 c4 04             	add    $0x4,%esp
80105034:	5b                   	pop    %ebx
80105035:	5d                   	pop    %ebp
80105036:	c3                   	ret    
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105040:	83 c4 04             	add    $0x4,%esp
80105043:	89 d0                	mov    %edx,%eax
80105045:	29 d8                	sub    %ebx,%eax
80105047:	5b                   	pop    %ebx
80105048:	5d                   	pop    %ebp
80105049:	c3                   	ret    
8010504a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105050:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105052:	eb dd                	jmp    80105031 <fetchstr+0x41>
80105054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010505a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105060 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	56                   	push   %esi
80105064:	53                   	push   %ebx
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
80105065:	e8 36 e9 ff ff       	call   801039a0 <mythread>
8010506a:	8b 40 14             	mov    0x14(%eax),%eax
8010506d:	8b 55 08             	mov    0x8(%ebp),%edx
80105070:	8b 40 44             	mov    0x44(%eax),%eax
80105073:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105076:	e8 f5 e8 ff ff       	call   80103970 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010507b:	8b 00                	mov    (%eax),%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
8010507d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105080:	39 c6                	cmp    %eax,%esi
80105082:	73 1c                	jae    801050a0 <argint+0x40>
80105084:	8d 53 08             	lea    0x8(%ebx),%edx
80105087:	39 d0                	cmp    %edx,%eax
80105089:	72 15                	jb     801050a0 <argint+0x40>
  *ip = *(int*)(addr);
8010508b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010508e:	8b 53 04             	mov    0x4(%ebx),%edx
80105091:	89 10                	mov    %edx,(%eax)
  return 0;
80105093:	31 c0                	xor    %eax,%eax
}
80105095:	5b                   	pop    %ebx
80105096:	5e                   	pop    %esi
80105097:	5d                   	pop    %ebp
80105098:	c3                   	ret    
80105099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801050a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
801050a5:	eb ee                	jmp    80105095 <argint+0x35>
801050a7:	89 f6                	mov    %esi,%esi
801050a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050b0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
801050b5:	83 ec 10             	sub    $0x10,%esp
801050b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801050bb:	e8 b0 e8 ff ff       	call   80103970 <myproc>
801050c0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801050c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050c5:	83 ec 08             	sub    $0x8,%esp
801050c8:	50                   	push   %eax
801050c9:	ff 75 08             	pushl  0x8(%ebp)
801050cc:	e8 8f ff ff ff       	call   80105060 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801050d1:	83 c4 10             	add    $0x10,%esp
801050d4:	85 c0                	test   %eax,%eax
801050d6:	78 28                	js     80105100 <argptr+0x50>
801050d8:	85 db                	test   %ebx,%ebx
801050da:	78 24                	js     80105100 <argptr+0x50>
801050dc:	8b 16                	mov    (%esi),%edx
801050de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050e1:	39 c2                	cmp    %eax,%edx
801050e3:	76 1b                	jbe    80105100 <argptr+0x50>
801050e5:	01 c3                	add    %eax,%ebx
801050e7:	39 da                	cmp    %ebx,%edx
801050e9:	72 15                	jb     80105100 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801050eb:	8b 55 0c             	mov    0xc(%ebp),%edx
801050ee:	89 02                	mov    %eax,(%edx)
  return 0;
801050f0:	31 c0                	xor    %eax,%eax
}
801050f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050f5:	5b                   	pop    %ebx
801050f6:	5e                   	pop    %esi
801050f7:	5d                   	pop    %ebp
801050f8:	c3                   	ret    
801050f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105105:	eb eb                	jmp    801050f2 <argptr+0x42>
80105107:	89 f6                	mov    %esi,%esi
80105109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105110 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105116:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105119:	50                   	push   %eax
8010511a:	ff 75 08             	pushl  0x8(%ebp)
8010511d:	e8 3e ff ff ff       	call   80105060 <argint>
80105122:	83 c4 10             	add    $0x10,%esp
80105125:	85 c0                	test   %eax,%eax
80105127:	78 17                	js     80105140 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105129:	83 ec 08             	sub    $0x8,%esp
8010512c:	ff 75 0c             	pushl  0xc(%ebp)
8010512f:	ff 75 f4             	pushl  -0xc(%ebp)
80105132:	e8 b9 fe ff ff       	call   80104ff0 <fetchstr>
80105137:	83 c4 10             	add    $0x10,%esp
}
8010513a:	c9                   	leave  
8010513b:	c3                   	ret    
8010513c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105145:	c9                   	leave  
80105146:	c3                   	ret    
80105147:	89 f6                	mov    %esi,%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <syscall>:
[SYS_kthread_mutex_unlock] sys_kthread_mutex_unlock,
};

void
syscall(void)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	56                   	push   %esi
80105154:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80105155:	e8 16 e8 ff ff       	call   80103970 <myproc>
8010515a:	89 c6                	mov    %eax,%esi
  struct kthread *curthread = mythread();
8010515c:	e8 3f e8 ff ff       	call   801039a0 <mythread>
80105161:	89 c3                	mov    %eax,%ebx

  num = curthread->tf->eax;
80105163:	8b 40 14             	mov    0x14(%eax),%eax
80105166:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105169:	8d 50 ff             	lea    -0x1(%eax),%edx
8010516c:	83 fa 1c             	cmp    $0x1c,%edx
8010516f:	77 1f                	ja     80105190 <syscall+0x40>
80105171:	8b 14 85 60 81 10 80 	mov    -0x7fef7ea0(,%eax,4),%edx
80105178:	85 d2                	test   %edx,%edx
8010517a:	74 14                	je     80105190 <syscall+0x40>
    curthread->tf->eax = syscalls[num]();
8010517c:	ff d2                	call   *%edx
8010517e:	8b 53 14             	mov    0x14(%ebx),%edx
80105181:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curthread->tf->eax = -1;
  }
}
80105184:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105187:	5b                   	pop    %ebx
80105188:	5e                   	pop    %esi
80105189:	5d                   	pop    %ebp
8010518a:	c3                   	ret    
8010518b:	90                   	nop
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105190:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105191:	8d 46 5c             	lea    0x5c(%esi),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105194:	50                   	push   %eax
80105195:	ff 76 0c             	pushl  0xc(%esi)
80105198:	68 2d 81 10 80       	push   $0x8010812d
8010519d:	e8 be b4 ff ff       	call   80100660 <cprintf>
    curthread->tf->eax = -1;
801051a2:	8b 43 14             	mov    0x14(%ebx),%eax
801051a5:	83 c4 10             	add    $0x10,%esp
801051a8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801051af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051b2:	5b                   	pop    %ebx
801051b3:	5e                   	pop    %esi
801051b4:	5d                   	pop    %ebp
801051b5:	c3                   	ret    
801051b6:	66 90                	xchg   %ax,%ax
801051b8:	66 90                	xchg   %ax,%ax
801051ba:	66 90                	xchg   %ax,%ax
801051bc:	66 90                	xchg   %ax,%ax
801051be:	66 90                	xchg   %ax,%ax

801051c0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	57                   	push   %edi
801051c4:	56                   	push   %esi
801051c5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801051c6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801051c9:	83 ec 44             	sub    $0x44,%esp
801051cc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801051cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801051d2:	56                   	push   %esi
801051d3:	50                   	push   %eax
{
801051d4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801051d7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801051da:	e8 01 ce ff ff       	call   80101fe0 <nameiparent>
801051df:	83 c4 10             	add    $0x10,%esp
801051e2:	85 c0                	test   %eax,%eax
801051e4:	0f 84 46 01 00 00    	je     80105330 <create+0x170>
    return 0;
  ilock(dp);
801051ea:	83 ec 0c             	sub    $0xc,%esp
801051ed:	89 c3                	mov    %eax,%ebx
801051ef:	50                   	push   %eax
801051f0:	e8 6b c5 ff ff       	call   80101760 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801051f5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801051f8:	83 c4 0c             	add    $0xc,%esp
801051fb:	50                   	push   %eax
801051fc:	56                   	push   %esi
801051fd:	53                   	push   %ebx
801051fe:	e8 8d ca ff ff       	call   80101c90 <dirlookup>
80105203:	83 c4 10             	add    $0x10,%esp
80105206:	85 c0                	test   %eax,%eax
80105208:	89 c7                	mov    %eax,%edi
8010520a:	74 34                	je     80105240 <create+0x80>
    iunlockput(dp);
8010520c:	83 ec 0c             	sub    $0xc,%esp
8010520f:	53                   	push   %ebx
80105210:	e8 db c7 ff ff       	call   801019f0 <iunlockput>
    ilock(ip);
80105215:	89 3c 24             	mov    %edi,(%esp)
80105218:	e8 43 c5 ff ff       	call   80101760 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010521d:	83 c4 10             	add    $0x10,%esp
80105220:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105225:	0f 85 95 00 00 00    	jne    801052c0 <create+0x100>
8010522b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105230:	0f 85 8a 00 00 00    	jne    801052c0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105236:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105239:	89 f8                	mov    %edi,%eax
8010523b:	5b                   	pop    %ebx
8010523c:	5e                   	pop    %esi
8010523d:	5f                   	pop    %edi
8010523e:	5d                   	pop    %ebp
8010523f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105240:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105244:	83 ec 08             	sub    $0x8,%esp
80105247:	50                   	push   %eax
80105248:	ff 33                	pushl  (%ebx)
8010524a:	e8 a1 c3 ff ff       	call   801015f0 <ialloc>
8010524f:	83 c4 10             	add    $0x10,%esp
80105252:	85 c0                	test   %eax,%eax
80105254:	89 c7                	mov    %eax,%edi
80105256:	0f 84 e8 00 00 00    	je     80105344 <create+0x184>
  ilock(ip);
8010525c:	83 ec 0c             	sub    $0xc,%esp
8010525f:	50                   	push   %eax
80105260:	e8 fb c4 ff ff       	call   80101760 <ilock>
  ip->major = major;
80105265:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105269:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010526d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105271:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105275:	b8 01 00 00 00       	mov    $0x1,%eax
8010527a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010527e:	89 3c 24             	mov    %edi,(%esp)
80105281:	e8 2a c4 ff ff       	call   801016b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105286:	83 c4 10             	add    $0x10,%esp
80105289:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010528e:	74 50                	je     801052e0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105290:	83 ec 04             	sub    $0x4,%esp
80105293:	ff 77 04             	pushl  0x4(%edi)
80105296:	56                   	push   %esi
80105297:	53                   	push   %ebx
80105298:	e8 63 cc ff ff       	call   80101f00 <dirlink>
8010529d:	83 c4 10             	add    $0x10,%esp
801052a0:	85 c0                	test   %eax,%eax
801052a2:	0f 88 8f 00 00 00    	js     80105337 <create+0x177>
  iunlockput(dp);
801052a8:	83 ec 0c             	sub    $0xc,%esp
801052ab:	53                   	push   %ebx
801052ac:	e8 3f c7 ff ff       	call   801019f0 <iunlockput>
  return ip;
801052b1:	83 c4 10             	add    $0x10,%esp
}
801052b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052b7:	89 f8                	mov    %edi,%eax
801052b9:	5b                   	pop    %ebx
801052ba:	5e                   	pop    %esi
801052bb:	5f                   	pop    %edi
801052bc:	5d                   	pop    %ebp
801052bd:	c3                   	ret    
801052be:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	57                   	push   %edi
    return 0;
801052c4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801052c6:	e8 25 c7 ff ff       	call   801019f0 <iunlockput>
    return 0;
801052cb:	83 c4 10             	add    $0x10,%esp
}
801052ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052d1:	89 f8                	mov    %edi,%eax
801052d3:	5b                   	pop    %ebx
801052d4:	5e                   	pop    %esi
801052d5:	5f                   	pop    %edi
801052d6:	5d                   	pop    %ebp
801052d7:	c3                   	ret    
801052d8:	90                   	nop
801052d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801052e0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801052e5:	83 ec 0c             	sub    $0xc,%esp
801052e8:	53                   	push   %ebx
801052e9:	e8 c2 c3 ff ff       	call   801016b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052ee:	83 c4 0c             	add    $0xc,%esp
801052f1:	ff 77 04             	pushl  0x4(%edi)
801052f4:	68 f4 81 10 80       	push   $0x801081f4
801052f9:	57                   	push   %edi
801052fa:	e8 01 cc ff ff       	call   80101f00 <dirlink>
801052ff:	83 c4 10             	add    $0x10,%esp
80105302:	85 c0                	test   %eax,%eax
80105304:	78 1c                	js     80105322 <create+0x162>
80105306:	83 ec 04             	sub    $0x4,%esp
80105309:	ff 73 04             	pushl  0x4(%ebx)
8010530c:	68 f3 81 10 80       	push   $0x801081f3
80105311:	57                   	push   %edi
80105312:	e8 e9 cb ff ff       	call   80101f00 <dirlink>
80105317:	83 c4 10             	add    $0x10,%esp
8010531a:	85 c0                	test   %eax,%eax
8010531c:	0f 89 6e ff ff ff    	jns    80105290 <create+0xd0>
      panic("create dots");
80105322:	83 ec 0c             	sub    $0xc,%esp
80105325:	68 e7 81 10 80       	push   $0x801081e7
8010532a:	e8 61 b0 ff ff       	call   80100390 <panic>
8010532f:	90                   	nop
    return 0;
80105330:	31 ff                	xor    %edi,%edi
80105332:	e9 ff fe ff ff       	jmp    80105236 <create+0x76>
    panic("create: dirlink");
80105337:	83 ec 0c             	sub    $0xc,%esp
8010533a:	68 f6 81 10 80       	push   $0x801081f6
8010533f:	e8 4c b0 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105344:	83 ec 0c             	sub    $0xc,%esp
80105347:	68 d8 81 10 80       	push   $0x801081d8
8010534c:	e8 3f b0 ff ff       	call   80100390 <panic>
80105351:	eb 0d                	jmp    80105360 <argfd.constprop.0>
80105353:	90                   	nop
80105354:	90                   	nop
80105355:	90                   	nop
80105356:	90                   	nop
80105357:	90                   	nop
80105358:	90                   	nop
80105359:	90                   	nop
8010535a:	90                   	nop
8010535b:	90                   	nop
8010535c:	90                   	nop
8010535d:	90                   	nop
8010535e:	90                   	nop
8010535f:	90                   	nop

80105360 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	56                   	push   %esi
80105364:	53                   	push   %ebx
80105365:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105367:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010536a:	89 d6                	mov    %edx,%esi
8010536c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010536f:	50                   	push   %eax
80105370:	6a 00                	push   $0x0
80105372:	e8 e9 fc ff ff       	call   80105060 <argint>
80105377:	83 c4 10             	add    $0x10,%esp
8010537a:	85 c0                	test   %eax,%eax
8010537c:	78 2a                	js     801053a8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010537e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105382:	77 24                	ja     801053a8 <argfd.constprop.0+0x48>
80105384:	e8 e7 e5 ff ff       	call   80103970 <myproc>
80105389:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010538c:	8b 44 90 18          	mov    0x18(%eax,%edx,4),%eax
80105390:	85 c0                	test   %eax,%eax
80105392:	74 14                	je     801053a8 <argfd.constprop.0+0x48>
  if(pfd)
80105394:	85 db                	test   %ebx,%ebx
80105396:	74 02                	je     8010539a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105398:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010539a:	89 06                	mov    %eax,(%esi)
  return 0;
8010539c:	31 c0                	xor    %eax,%eax
}
8010539e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053a1:	5b                   	pop    %ebx
801053a2:	5e                   	pop    %esi
801053a3:	5d                   	pop    %ebp
801053a4:	c3                   	ret    
801053a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801053a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ad:	eb ef                	jmp    8010539e <argfd.constprop.0+0x3e>
801053af:	90                   	nop

801053b0 <sys_dup>:
{
801053b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801053b1:	31 c0                	xor    %eax,%eax
{
801053b3:	89 e5                	mov    %esp,%ebp
801053b5:	56                   	push   %esi
801053b6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801053b7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801053ba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801053bd:	e8 9e ff ff ff       	call   80105360 <argfd.constprop.0>
801053c2:	85 c0                	test   %eax,%eax
801053c4:	78 42                	js     80105408 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
801053c6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801053c9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801053cb:	e8 a0 e5 ff ff       	call   80103970 <myproc>
801053d0:	eb 0e                	jmp    801053e0 <sys_dup+0x30>
801053d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801053d8:	83 c3 01             	add    $0x1,%ebx
801053db:	83 fb 10             	cmp    $0x10,%ebx
801053de:	74 28                	je     80105408 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
801053e0:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
801053e4:	85 d2                	test   %edx,%edx
801053e6:	75 f0                	jne    801053d8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801053e8:	89 74 98 18          	mov    %esi,0x18(%eax,%ebx,4)
  filedup(f);
801053ec:	83 ec 0c             	sub    $0xc,%esp
801053ef:	ff 75 f4             	pushl  -0xc(%ebp)
801053f2:	e8 c9 ba ff ff       	call   80100ec0 <filedup>
  return fd;
801053f7:	83 c4 10             	add    $0x10,%esp
}
801053fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053fd:	89 d8                	mov    %ebx,%eax
801053ff:	5b                   	pop    %ebx
80105400:	5e                   	pop    %esi
80105401:	5d                   	pop    %ebp
80105402:	c3                   	ret    
80105403:	90                   	nop
80105404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105408:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010540b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105410:	89 d8                	mov    %ebx,%eax
80105412:	5b                   	pop    %ebx
80105413:	5e                   	pop    %esi
80105414:	5d                   	pop    %ebp
80105415:	c3                   	ret    
80105416:	8d 76 00             	lea    0x0(%esi),%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105420 <sys_read>:
{
80105420:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105421:	31 c0                	xor    %eax,%eax
{
80105423:	89 e5                	mov    %esp,%ebp
80105425:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105428:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010542b:	e8 30 ff ff ff       	call   80105360 <argfd.constprop.0>
80105430:	85 c0                	test   %eax,%eax
80105432:	78 4c                	js     80105480 <sys_read+0x60>
80105434:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105437:	83 ec 08             	sub    $0x8,%esp
8010543a:	50                   	push   %eax
8010543b:	6a 02                	push   $0x2
8010543d:	e8 1e fc ff ff       	call   80105060 <argint>
80105442:	83 c4 10             	add    $0x10,%esp
80105445:	85 c0                	test   %eax,%eax
80105447:	78 37                	js     80105480 <sys_read+0x60>
80105449:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010544c:	83 ec 04             	sub    $0x4,%esp
8010544f:	ff 75 f0             	pushl  -0x10(%ebp)
80105452:	50                   	push   %eax
80105453:	6a 01                	push   $0x1
80105455:	e8 56 fc ff ff       	call   801050b0 <argptr>
8010545a:	83 c4 10             	add    $0x10,%esp
8010545d:	85 c0                	test   %eax,%eax
8010545f:	78 1f                	js     80105480 <sys_read+0x60>
  return fileread(f, p, n);
80105461:	83 ec 04             	sub    $0x4,%esp
80105464:	ff 75 f0             	pushl  -0x10(%ebp)
80105467:	ff 75 f4             	pushl  -0xc(%ebp)
8010546a:	ff 75 ec             	pushl  -0x14(%ebp)
8010546d:	e8 be bb ff ff       	call   80101030 <fileread>
80105472:	83 c4 10             	add    $0x10,%esp
}
80105475:	c9                   	leave  
80105476:	c3                   	ret    
80105477:	89 f6                	mov    %esi,%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105485:	c9                   	leave  
80105486:	c3                   	ret    
80105487:	89 f6                	mov    %esi,%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105490 <sys_write>:
{
80105490:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105491:	31 c0                	xor    %eax,%eax
{
80105493:	89 e5                	mov    %esp,%ebp
80105495:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105498:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010549b:	e8 c0 fe ff ff       	call   80105360 <argfd.constprop.0>
801054a0:	85 c0                	test   %eax,%eax
801054a2:	78 4c                	js     801054f0 <sys_write+0x60>
801054a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054a7:	83 ec 08             	sub    $0x8,%esp
801054aa:	50                   	push   %eax
801054ab:	6a 02                	push   $0x2
801054ad:	e8 ae fb ff ff       	call   80105060 <argint>
801054b2:	83 c4 10             	add    $0x10,%esp
801054b5:	85 c0                	test   %eax,%eax
801054b7:	78 37                	js     801054f0 <sys_write+0x60>
801054b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054bc:	83 ec 04             	sub    $0x4,%esp
801054bf:	ff 75 f0             	pushl  -0x10(%ebp)
801054c2:	50                   	push   %eax
801054c3:	6a 01                	push   $0x1
801054c5:	e8 e6 fb ff ff       	call   801050b0 <argptr>
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	85 c0                	test   %eax,%eax
801054cf:	78 1f                	js     801054f0 <sys_write+0x60>
  return filewrite(f, p, n);
801054d1:	83 ec 04             	sub    $0x4,%esp
801054d4:	ff 75 f0             	pushl  -0x10(%ebp)
801054d7:	ff 75 f4             	pushl  -0xc(%ebp)
801054da:	ff 75 ec             	pushl  -0x14(%ebp)
801054dd:	e8 de bb ff ff       	call   801010c0 <filewrite>
801054e2:	83 c4 10             	add    $0x10,%esp
}
801054e5:	c9                   	leave  
801054e6:	c3                   	ret    
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f5:	c9                   	leave  
801054f6:	c3                   	ret    
801054f7:	89 f6                	mov    %esi,%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <sys_close>:
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105506:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105509:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010550c:	e8 4f fe ff ff       	call   80105360 <argfd.constprop.0>
80105511:	85 c0                	test   %eax,%eax
80105513:	78 2b                	js     80105540 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105515:	e8 56 e4 ff ff       	call   80103970 <myproc>
8010551a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010551d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105520:	c7 44 90 18 00 00 00 	movl   $0x0,0x18(%eax,%edx,4)
80105527:	00 
  fileclose(f);
80105528:	ff 75 f4             	pushl  -0xc(%ebp)
8010552b:	e8 e0 b9 ff ff       	call   80100f10 <fileclose>
  return 0;
80105530:	83 c4 10             	add    $0x10,%esp
80105533:	31 c0                	xor    %eax,%eax
}
80105535:	c9                   	leave  
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105545:	c9                   	leave  
80105546:	c3                   	ret    
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105550 <sys_fstat>:
{
80105550:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105551:	31 c0                	xor    %eax,%eax
{
80105553:	89 e5                	mov    %esp,%ebp
80105555:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105558:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010555b:	e8 00 fe ff ff       	call   80105360 <argfd.constprop.0>
80105560:	85 c0                	test   %eax,%eax
80105562:	78 2c                	js     80105590 <sys_fstat+0x40>
80105564:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105567:	83 ec 04             	sub    $0x4,%esp
8010556a:	6a 14                	push   $0x14
8010556c:	50                   	push   %eax
8010556d:	6a 01                	push   $0x1
8010556f:	e8 3c fb ff ff       	call   801050b0 <argptr>
80105574:	83 c4 10             	add    $0x10,%esp
80105577:	85 c0                	test   %eax,%eax
80105579:	78 15                	js     80105590 <sys_fstat+0x40>
  return filestat(f, st);
8010557b:	83 ec 08             	sub    $0x8,%esp
8010557e:	ff 75 f4             	pushl  -0xc(%ebp)
80105581:	ff 75 f0             	pushl  -0x10(%ebp)
80105584:	e8 57 ba ff ff       	call   80100fe0 <filestat>
80105589:	83 c4 10             	add    $0x10,%esp
}
8010558c:	c9                   	leave  
8010558d:	c3                   	ret    
8010558e:	66 90                	xchg   %ax,%ax
    return -1;
80105590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105595:	c9                   	leave  
80105596:	c3                   	ret    
80105597:	89 f6                	mov    %esi,%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055a0 <sys_link>:
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
801055a5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055a6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801055a9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055ac:	50                   	push   %eax
801055ad:	6a 00                	push   $0x0
801055af:	e8 5c fb ff ff       	call   80105110 <argstr>
801055b4:	83 c4 10             	add    $0x10,%esp
801055b7:	85 c0                	test   %eax,%eax
801055b9:	0f 88 fb 00 00 00    	js     801056ba <sys_link+0x11a>
801055bf:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055c2:	83 ec 08             	sub    $0x8,%esp
801055c5:	50                   	push   %eax
801055c6:	6a 01                	push   $0x1
801055c8:	e8 43 fb ff ff       	call   80105110 <argstr>
801055cd:	83 c4 10             	add    $0x10,%esp
801055d0:	85 c0                	test   %eax,%eax
801055d2:	0f 88 e2 00 00 00    	js     801056ba <sys_link+0x11a>
  begin_op();
801055d8:	e8 a3 d6 ff ff       	call   80102c80 <begin_op>
  if((ip = namei(old)) == 0){
801055dd:	83 ec 0c             	sub    $0xc,%esp
801055e0:	ff 75 d4             	pushl  -0x2c(%ebp)
801055e3:	e8 d8 c9 ff ff       	call   80101fc0 <namei>
801055e8:	83 c4 10             	add    $0x10,%esp
801055eb:	85 c0                	test   %eax,%eax
801055ed:	89 c3                	mov    %eax,%ebx
801055ef:	0f 84 ea 00 00 00    	je     801056df <sys_link+0x13f>
  ilock(ip);
801055f5:	83 ec 0c             	sub    $0xc,%esp
801055f8:	50                   	push   %eax
801055f9:	e8 62 c1 ff ff       	call   80101760 <ilock>
  if(ip->type == T_DIR){
801055fe:	83 c4 10             	add    $0x10,%esp
80105601:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105606:	0f 84 bb 00 00 00    	je     801056c7 <sys_link+0x127>
  ip->nlink++;
8010560c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105611:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105614:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105617:	53                   	push   %ebx
80105618:	e8 93 c0 ff ff       	call   801016b0 <iupdate>
  iunlock(ip);
8010561d:	89 1c 24             	mov    %ebx,(%esp)
80105620:	e8 1b c2 ff ff       	call   80101840 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105625:	58                   	pop    %eax
80105626:	5a                   	pop    %edx
80105627:	57                   	push   %edi
80105628:	ff 75 d0             	pushl  -0x30(%ebp)
8010562b:	e8 b0 c9 ff ff       	call   80101fe0 <nameiparent>
80105630:	83 c4 10             	add    $0x10,%esp
80105633:	85 c0                	test   %eax,%eax
80105635:	89 c6                	mov    %eax,%esi
80105637:	74 5b                	je     80105694 <sys_link+0xf4>
  ilock(dp);
80105639:	83 ec 0c             	sub    $0xc,%esp
8010563c:	50                   	push   %eax
8010563d:	e8 1e c1 ff ff       	call   80101760 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105642:	83 c4 10             	add    $0x10,%esp
80105645:	8b 03                	mov    (%ebx),%eax
80105647:	39 06                	cmp    %eax,(%esi)
80105649:	75 3d                	jne    80105688 <sys_link+0xe8>
8010564b:	83 ec 04             	sub    $0x4,%esp
8010564e:	ff 73 04             	pushl  0x4(%ebx)
80105651:	57                   	push   %edi
80105652:	56                   	push   %esi
80105653:	e8 a8 c8 ff ff       	call   80101f00 <dirlink>
80105658:	83 c4 10             	add    $0x10,%esp
8010565b:	85 c0                	test   %eax,%eax
8010565d:	78 29                	js     80105688 <sys_link+0xe8>
  iunlockput(dp);
8010565f:	83 ec 0c             	sub    $0xc,%esp
80105662:	56                   	push   %esi
80105663:	e8 88 c3 ff ff       	call   801019f0 <iunlockput>
  iput(ip);
80105668:	89 1c 24             	mov    %ebx,(%esp)
8010566b:	e8 20 c2 ff ff       	call   80101890 <iput>
  end_op();
80105670:	e8 7b d6 ff ff       	call   80102cf0 <end_op>
  return 0;
80105675:	83 c4 10             	add    $0x10,%esp
80105678:	31 c0                	xor    %eax,%eax
}
8010567a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010567d:	5b                   	pop    %ebx
8010567e:	5e                   	pop    %esi
8010567f:	5f                   	pop    %edi
80105680:	5d                   	pop    %ebp
80105681:	c3                   	ret    
80105682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105688:	83 ec 0c             	sub    $0xc,%esp
8010568b:	56                   	push   %esi
8010568c:	e8 5f c3 ff ff       	call   801019f0 <iunlockput>
    goto bad;
80105691:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105694:	83 ec 0c             	sub    $0xc,%esp
80105697:	53                   	push   %ebx
80105698:	e8 c3 c0 ff ff       	call   80101760 <ilock>
  ip->nlink--;
8010569d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056a2:	89 1c 24             	mov    %ebx,(%esp)
801056a5:	e8 06 c0 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
801056aa:	89 1c 24             	mov    %ebx,(%esp)
801056ad:	e8 3e c3 ff ff       	call   801019f0 <iunlockput>
  end_op();
801056b2:	e8 39 d6 ff ff       	call   80102cf0 <end_op>
  return -1;
801056b7:	83 c4 10             	add    $0x10,%esp
}
801056ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801056bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056c2:	5b                   	pop    %ebx
801056c3:	5e                   	pop    %esi
801056c4:	5f                   	pop    %edi
801056c5:	5d                   	pop    %ebp
801056c6:	c3                   	ret    
    iunlockput(ip);
801056c7:	83 ec 0c             	sub    $0xc,%esp
801056ca:	53                   	push   %ebx
801056cb:	e8 20 c3 ff ff       	call   801019f0 <iunlockput>
    end_op();
801056d0:	e8 1b d6 ff ff       	call   80102cf0 <end_op>
    return -1;
801056d5:	83 c4 10             	add    $0x10,%esp
801056d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056dd:	eb 9b                	jmp    8010567a <sys_link+0xda>
    end_op();
801056df:	e8 0c d6 ff ff       	call   80102cf0 <end_op>
    return -1;
801056e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e9:	eb 8f                	jmp    8010567a <sys_link+0xda>
801056eb:	90                   	nop
801056ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056f0 <sys_unlink>:
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	57                   	push   %edi
801056f4:	56                   	push   %esi
801056f5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
801056f6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801056f9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801056fc:	50                   	push   %eax
801056fd:	6a 00                	push   $0x0
801056ff:	e8 0c fa ff ff       	call   80105110 <argstr>
80105704:	83 c4 10             	add    $0x10,%esp
80105707:	85 c0                	test   %eax,%eax
80105709:	0f 88 77 01 00 00    	js     80105886 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010570f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105712:	e8 69 d5 ff ff       	call   80102c80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105717:	83 ec 08             	sub    $0x8,%esp
8010571a:	53                   	push   %ebx
8010571b:	ff 75 c0             	pushl  -0x40(%ebp)
8010571e:	e8 bd c8 ff ff       	call   80101fe0 <nameiparent>
80105723:	83 c4 10             	add    $0x10,%esp
80105726:	85 c0                	test   %eax,%eax
80105728:	89 c6                	mov    %eax,%esi
8010572a:	0f 84 60 01 00 00    	je     80105890 <sys_unlink+0x1a0>
  ilock(dp);
80105730:	83 ec 0c             	sub    $0xc,%esp
80105733:	50                   	push   %eax
80105734:	e8 27 c0 ff ff       	call   80101760 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105739:	58                   	pop    %eax
8010573a:	5a                   	pop    %edx
8010573b:	68 f4 81 10 80       	push   $0x801081f4
80105740:	53                   	push   %ebx
80105741:	e8 2a c5 ff ff       	call   80101c70 <namecmp>
80105746:	83 c4 10             	add    $0x10,%esp
80105749:	85 c0                	test   %eax,%eax
8010574b:	0f 84 03 01 00 00    	je     80105854 <sys_unlink+0x164>
80105751:	83 ec 08             	sub    $0x8,%esp
80105754:	68 f3 81 10 80       	push   $0x801081f3
80105759:	53                   	push   %ebx
8010575a:	e8 11 c5 ff ff       	call   80101c70 <namecmp>
8010575f:	83 c4 10             	add    $0x10,%esp
80105762:	85 c0                	test   %eax,%eax
80105764:	0f 84 ea 00 00 00    	je     80105854 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010576a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010576d:	83 ec 04             	sub    $0x4,%esp
80105770:	50                   	push   %eax
80105771:	53                   	push   %ebx
80105772:	56                   	push   %esi
80105773:	e8 18 c5 ff ff       	call   80101c90 <dirlookup>
80105778:	83 c4 10             	add    $0x10,%esp
8010577b:	85 c0                	test   %eax,%eax
8010577d:	89 c3                	mov    %eax,%ebx
8010577f:	0f 84 cf 00 00 00    	je     80105854 <sys_unlink+0x164>
  ilock(ip);
80105785:	83 ec 0c             	sub    $0xc,%esp
80105788:	50                   	push   %eax
80105789:	e8 d2 bf ff ff       	call   80101760 <ilock>
  if(ip->nlink < 1)
8010578e:	83 c4 10             	add    $0x10,%esp
80105791:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105796:	0f 8e 10 01 00 00    	jle    801058ac <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010579c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057a1:	74 6d                	je     80105810 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801057a3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057a6:	83 ec 04             	sub    $0x4,%esp
801057a9:	6a 10                	push   $0x10
801057ab:	6a 00                	push   $0x0
801057ad:	50                   	push   %eax
801057ae:	e8 ad f5 ff ff       	call   80104d60 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057b3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057b6:	6a 10                	push   $0x10
801057b8:	ff 75 c4             	pushl  -0x3c(%ebp)
801057bb:	50                   	push   %eax
801057bc:	56                   	push   %esi
801057bd:	e8 7e c3 ff ff       	call   80101b40 <writei>
801057c2:	83 c4 20             	add    $0x20,%esp
801057c5:	83 f8 10             	cmp    $0x10,%eax
801057c8:	0f 85 eb 00 00 00    	jne    801058b9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801057ce:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057d3:	0f 84 97 00 00 00    	je     80105870 <sys_unlink+0x180>
  iunlockput(dp);
801057d9:	83 ec 0c             	sub    $0xc,%esp
801057dc:	56                   	push   %esi
801057dd:	e8 0e c2 ff ff       	call   801019f0 <iunlockput>
  ip->nlink--;
801057e2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801057e7:	89 1c 24             	mov    %ebx,(%esp)
801057ea:	e8 c1 be ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
801057ef:	89 1c 24             	mov    %ebx,(%esp)
801057f2:	e8 f9 c1 ff ff       	call   801019f0 <iunlockput>
  end_op();
801057f7:	e8 f4 d4 ff ff       	call   80102cf0 <end_op>
  return 0;
801057fc:	83 c4 10             	add    $0x10,%esp
801057ff:	31 c0                	xor    %eax,%eax
}
80105801:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105804:	5b                   	pop    %ebx
80105805:	5e                   	pop    %esi
80105806:	5f                   	pop    %edi
80105807:	5d                   	pop    %ebp
80105808:	c3                   	ret    
80105809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105810:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105814:	76 8d                	jbe    801057a3 <sys_unlink+0xb3>
80105816:	bf 20 00 00 00       	mov    $0x20,%edi
8010581b:	eb 0f                	jmp    8010582c <sys_unlink+0x13c>
8010581d:	8d 76 00             	lea    0x0(%esi),%esi
80105820:	83 c7 10             	add    $0x10,%edi
80105823:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105826:	0f 83 77 ff ff ff    	jae    801057a3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010582c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010582f:	6a 10                	push   $0x10
80105831:	57                   	push   %edi
80105832:	50                   	push   %eax
80105833:	53                   	push   %ebx
80105834:	e8 07 c2 ff ff       	call   80101a40 <readi>
80105839:	83 c4 10             	add    $0x10,%esp
8010583c:	83 f8 10             	cmp    $0x10,%eax
8010583f:	75 5e                	jne    8010589f <sys_unlink+0x1af>
    if(de.inum != 0)
80105841:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105846:	74 d8                	je     80105820 <sys_unlink+0x130>
    iunlockput(ip);
80105848:	83 ec 0c             	sub    $0xc,%esp
8010584b:	53                   	push   %ebx
8010584c:	e8 9f c1 ff ff       	call   801019f0 <iunlockput>
    goto bad;
80105851:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105854:	83 ec 0c             	sub    $0xc,%esp
80105857:	56                   	push   %esi
80105858:	e8 93 c1 ff ff       	call   801019f0 <iunlockput>
  end_op();
8010585d:	e8 8e d4 ff ff       	call   80102cf0 <end_op>
  return -1;
80105862:	83 c4 10             	add    $0x10,%esp
80105865:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586a:	eb 95                	jmp    80105801 <sys_unlink+0x111>
8010586c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105870:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105875:	83 ec 0c             	sub    $0xc,%esp
80105878:	56                   	push   %esi
80105879:	e8 32 be ff ff       	call   801016b0 <iupdate>
8010587e:	83 c4 10             	add    $0x10,%esp
80105881:	e9 53 ff ff ff       	jmp    801057d9 <sys_unlink+0xe9>
    return -1;
80105886:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010588b:	e9 71 ff ff ff       	jmp    80105801 <sys_unlink+0x111>
    end_op();
80105890:	e8 5b d4 ff ff       	call   80102cf0 <end_op>
    return -1;
80105895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010589a:	e9 62 ff ff ff       	jmp    80105801 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010589f:	83 ec 0c             	sub    $0xc,%esp
801058a2:	68 18 82 10 80       	push   $0x80108218
801058a7:	e8 e4 aa ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801058ac:	83 ec 0c             	sub    $0xc,%esp
801058af:	68 06 82 10 80       	push   $0x80108206
801058b4:	e8 d7 aa ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801058b9:	83 ec 0c             	sub    $0xc,%esp
801058bc:	68 2a 82 10 80       	push   $0x8010822a
801058c1:	e8 ca aa ff ff       	call   80100390 <panic>
801058c6:	8d 76 00             	lea    0x0(%esi),%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058d0 <sys_open>:

int
sys_open(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	57                   	push   %edi
801058d4:	56                   	push   %esi
801058d5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801058d9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058dc:	50                   	push   %eax
801058dd:	6a 00                	push   $0x0
801058df:	e8 2c f8 ff ff       	call   80105110 <argstr>
801058e4:	83 c4 10             	add    $0x10,%esp
801058e7:	85 c0                	test   %eax,%eax
801058e9:	0f 88 1d 01 00 00    	js     80105a0c <sys_open+0x13c>
801058ef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058f2:	83 ec 08             	sub    $0x8,%esp
801058f5:	50                   	push   %eax
801058f6:	6a 01                	push   $0x1
801058f8:	e8 63 f7 ff ff       	call   80105060 <argint>
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	85 c0                	test   %eax,%eax
80105902:	0f 88 04 01 00 00    	js     80105a0c <sys_open+0x13c>
    return -1;

  begin_op();
80105908:	e8 73 d3 ff ff       	call   80102c80 <begin_op>

  if(omode & O_CREATE){
8010590d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105911:	0f 85 a9 00 00 00    	jne    801059c0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105917:	83 ec 0c             	sub    $0xc,%esp
8010591a:	ff 75 e0             	pushl  -0x20(%ebp)
8010591d:	e8 9e c6 ff ff       	call   80101fc0 <namei>
80105922:	83 c4 10             	add    $0x10,%esp
80105925:	85 c0                	test   %eax,%eax
80105927:	89 c6                	mov    %eax,%esi
80105929:	0f 84 b2 00 00 00    	je     801059e1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010592f:	83 ec 0c             	sub    $0xc,%esp
80105932:	50                   	push   %eax
80105933:	e8 28 be ff ff       	call   80101760 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105938:	83 c4 10             	add    $0x10,%esp
8010593b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105940:	0f 84 aa 00 00 00    	je     801059f0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105946:	e8 05 b5 ff ff       	call   80100e50 <filealloc>
8010594b:	85 c0                	test   %eax,%eax
8010594d:	89 c7                	mov    %eax,%edi
8010594f:	0f 84 a6 00 00 00    	je     801059fb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105955:	e8 16 e0 ff ff       	call   80103970 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010595a:	31 db                	xor    %ebx,%ebx
8010595c:	eb 0e                	jmp    8010596c <sys_open+0x9c>
8010595e:	66 90                	xchg   %ax,%ax
80105960:	83 c3 01             	add    $0x1,%ebx
80105963:	83 fb 10             	cmp    $0x10,%ebx
80105966:	0f 84 ac 00 00 00    	je     80105a18 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010596c:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
80105970:	85 d2                	test   %edx,%edx
80105972:	75 ec                	jne    80105960 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105974:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105977:	89 7c 98 18          	mov    %edi,0x18(%eax,%ebx,4)
  iunlock(ip);
8010597b:	56                   	push   %esi
8010597c:	e8 bf be ff ff       	call   80101840 <iunlock>
  end_op();
80105981:	e8 6a d3 ff ff       	call   80102cf0 <end_op>

  f->type = FD_INODE;
80105986:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010598c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010598f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105992:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105995:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010599c:	89 d0                	mov    %edx,%eax
8010599e:	f7 d0                	not    %eax
801059a0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059a3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059a6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059a9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059b0:	89 d8                	mov    %ebx,%eax
801059b2:	5b                   	pop    %ebx
801059b3:	5e                   	pop    %esi
801059b4:	5f                   	pop    %edi
801059b5:	5d                   	pop    %ebp
801059b6:	c3                   	ret    
801059b7:	89 f6                	mov    %esi,%esi
801059b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801059c0:	83 ec 0c             	sub    $0xc,%esp
801059c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801059c6:	31 c9                	xor    %ecx,%ecx
801059c8:	6a 00                	push   $0x0
801059ca:	ba 02 00 00 00       	mov    $0x2,%edx
801059cf:	e8 ec f7 ff ff       	call   801051c0 <create>
    if(ip == 0){
801059d4:	83 c4 10             	add    $0x10,%esp
801059d7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801059d9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801059db:	0f 85 65 ff ff ff    	jne    80105946 <sys_open+0x76>
      end_op();
801059e1:	e8 0a d3 ff ff       	call   80102cf0 <end_op>
      return -1;
801059e6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059eb:	eb c0                	jmp    801059ad <sys_open+0xdd>
801059ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801059f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801059f3:	85 c9                	test   %ecx,%ecx
801059f5:	0f 84 4b ff ff ff    	je     80105946 <sys_open+0x76>
    iunlockput(ip);
801059fb:	83 ec 0c             	sub    $0xc,%esp
801059fe:	56                   	push   %esi
801059ff:	e8 ec bf ff ff       	call   801019f0 <iunlockput>
    end_op();
80105a04:	e8 e7 d2 ff ff       	call   80102cf0 <end_op>
    return -1;
80105a09:	83 c4 10             	add    $0x10,%esp
80105a0c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a11:	eb 9a                	jmp    801059ad <sys_open+0xdd>
80105a13:	90                   	nop
80105a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105a18:	83 ec 0c             	sub    $0xc,%esp
80105a1b:	57                   	push   %edi
80105a1c:	e8 ef b4 ff ff       	call   80100f10 <fileclose>
80105a21:	83 c4 10             	add    $0x10,%esp
80105a24:	eb d5                	jmp    801059fb <sys_open+0x12b>
80105a26:	8d 76 00             	lea    0x0(%esi),%esi
80105a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a30 <sys_mkdir>:

int
sys_mkdir(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a36:	e8 45 d2 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105a3b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a3e:	83 ec 08             	sub    $0x8,%esp
80105a41:	50                   	push   %eax
80105a42:	6a 00                	push   $0x0
80105a44:	e8 c7 f6 ff ff       	call   80105110 <argstr>
80105a49:	83 c4 10             	add    $0x10,%esp
80105a4c:	85 c0                	test   %eax,%eax
80105a4e:	78 30                	js     80105a80 <sys_mkdir+0x50>
80105a50:	83 ec 0c             	sub    $0xc,%esp
80105a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a56:	31 c9                	xor    %ecx,%ecx
80105a58:	6a 00                	push   $0x0
80105a5a:	ba 01 00 00 00       	mov    $0x1,%edx
80105a5f:	e8 5c f7 ff ff       	call   801051c0 <create>
80105a64:	83 c4 10             	add    $0x10,%esp
80105a67:	85 c0                	test   %eax,%eax
80105a69:	74 15                	je     80105a80 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a6b:	83 ec 0c             	sub    $0xc,%esp
80105a6e:	50                   	push   %eax
80105a6f:	e8 7c bf ff ff       	call   801019f0 <iunlockput>
  end_op();
80105a74:	e8 77 d2 ff ff       	call   80102cf0 <end_op>
  return 0;
80105a79:	83 c4 10             	add    $0x10,%esp
80105a7c:	31 c0                	xor    %eax,%eax
}
80105a7e:	c9                   	leave  
80105a7f:	c3                   	ret    
    end_op();
80105a80:	e8 6b d2 ff ff       	call   80102cf0 <end_op>
    return -1;
80105a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a8a:	c9                   	leave  
80105a8b:	c3                   	ret    
80105a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a90 <sys_mknod>:

int
sys_mknod(void)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105a96:	e8 e5 d1 ff ff       	call   80102c80 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105a9b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a9e:	83 ec 08             	sub    $0x8,%esp
80105aa1:	50                   	push   %eax
80105aa2:	6a 00                	push   $0x0
80105aa4:	e8 67 f6 ff ff       	call   80105110 <argstr>
80105aa9:	83 c4 10             	add    $0x10,%esp
80105aac:	85 c0                	test   %eax,%eax
80105aae:	78 60                	js     80105b10 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105ab0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ab3:	83 ec 08             	sub    $0x8,%esp
80105ab6:	50                   	push   %eax
80105ab7:	6a 01                	push   $0x1
80105ab9:	e8 a2 f5 ff ff       	call   80105060 <argint>
  if((argstr(0, &path)) < 0 ||
80105abe:	83 c4 10             	add    $0x10,%esp
80105ac1:	85 c0                	test   %eax,%eax
80105ac3:	78 4b                	js     80105b10 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105ac5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ac8:	83 ec 08             	sub    $0x8,%esp
80105acb:	50                   	push   %eax
80105acc:	6a 02                	push   $0x2
80105ace:	e8 8d f5 ff ff       	call   80105060 <argint>
     argint(1, &major) < 0 ||
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	85 c0                	test   %eax,%eax
80105ad8:	78 36                	js     80105b10 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105ada:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105ade:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105ae1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105ae5:	ba 03 00 00 00       	mov    $0x3,%edx
80105aea:	50                   	push   %eax
80105aeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105aee:	e8 cd f6 ff ff       	call   801051c0 <create>
80105af3:	83 c4 10             	add    $0x10,%esp
80105af6:	85 c0                	test   %eax,%eax
80105af8:	74 16                	je     80105b10 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105afa:	83 ec 0c             	sub    $0xc,%esp
80105afd:	50                   	push   %eax
80105afe:	e8 ed be ff ff       	call   801019f0 <iunlockput>
  end_op();
80105b03:	e8 e8 d1 ff ff       	call   80102cf0 <end_op>
  return 0;
80105b08:	83 c4 10             	add    $0x10,%esp
80105b0b:	31 c0                	xor    %eax,%eax
}
80105b0d:	c9                   	leave  
80105b0e:	c3                   	ret    
80105b0f:	90                   	nop
    end_op();
80105b10:	e8 db d1 ff ff       	call   80102cf0 <end_op>
    return -1;
80105b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b1a:	c9                   	leave  
80105b1b:	c3                   	ret    
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b20 <sys_chdir>:

int
sys_chdir(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	56                   	push   %esi
80105b24:	53                   	push   %ebx
80105b25:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b28:	e8 43 de ff ff       	call   80103970 <myproc>
80105b2d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105b2f:	e8 4c d1 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105b34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b37:	83 ec 08             	sub    $0x8,%esp
80105b3a:	50                   	push   %eax
80105b3b:	6a 00                	push   $0x0
80105b3d:	e8 ce f5 ff ff       	call   80105110 <argstr>
80105b42:	83 c4 10             	add    $0x10,%esp
80105b45:	85 c0                	test   %eax,%eax
80105b47:	78 77                	js     80105bc0 <sys_chdir+0xa0>
80105b49:	83 ec 0c             	sub    $0xc,%esp
80105b4c:	ff 75 f4             	pushl  -0xc(%ebp)
80105b4f:	e8 6c c4 ff ff       	call   80101fc0 <namei>
80105b54:	83 c4 10             	add    $0x10,%esp
80105b57:	85 c0                	test   %eax,%eax
80105b59:	89 c3                	mov    %eax,%ebx
80105b5b:	74 63                	je     80105bc0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105b5d:	83 ec 0c             	sub    $0xc,%esp
80105b60:	50                   	push   %eax
80105b61:	e8 fa bb ff ff       	call   80101760 <ilock>
  if(ip->type != T_DIR){
80105b66:	83 c4 10             	add    $0x10,%esp
80105b69:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b6e:	75 30                	jne    80105ba0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b70:	83 ec 0c             	sub    $0xc,%esp
80105b73:	53                   	push   %ebx
80105b74:	e8 c7 bc ff ff       	call   80101840 <iunlock>
  iput(curproc->cwd);
80105b79:	58                   	pop    %eax
80105b7a:	ff 76 58             	pushl  0x58(%esi)
80105b7d:	e8 0e bd ff ff       	call   80101890 <iput>
  end_op();
80105b82:	e8 69 d1 ff ff       	call   80102cf0 <end_op>
  curproc->cwd = ip;
80105b87:	89 5e 58             	mov    %ebx,0x58(%esi)
  return 0;
80105b8a:	83 c4 10             	add    $0x10,%esp
80105b8d:	31 c0                	xor    %eax,%eax
}
80105b8f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b92:	5b                   	pop    %ebx
80105b93:	5e                   	pop    %esi
80105b94:	5d                   	pop    %ebp
80105b95:	c3                   	ret    
80105b96:	8d 76 00             	lea    0x0(%esi),%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105ba0:	83 ec 0c             	sub    $0xc,%esp
80105ba3:	53                   	push   %ebx
80105ba4:	e8 47 be ff ff       	call   801019f0 <iunlockput>
    end_op();
80105ba9:	e8 42 d1 ff ff       	call   80102cf0 <end_op>
    return -1;
80105bae:	83 c4 10             	add    $0x10,%esp
80105bb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bb6:	eb d7                	jmp    80105b8f <sys_chdir+0x6f>
80105bb8:	90                   	nop
80105bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105bc0:	e8 2b d1 ff ff       	call   80102cf0 <end_op>
    return -1;
80105bc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bca:	eb c3                	jmp    80105b8f <sys_chdir+0x6f>
80105bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bd0 <sys_exec>:

int
sys_exec(void)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	57                   	push   %edi
80105bd4:	56                   	push   %esi
80105bd5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105bd6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105bdc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105be2:	50                   	push   %eax
80105be3:	6a 00                	push   $0x0
80105be5:	e8 26 f5 ff ff       	call   80105110 <argstr>
80105bea:	83 c4 10             	add    $0x10,%esp
80105bed:	85 c0                	test   %eax,%eax
80105bef:	0f 88 87 00 00 00    	js     80105c7c <sys_exec+0xac>
80105bf5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105bfb:	83 ec 08             	sub    $0x8,%esp
80105bfe:	50                   	push   %eax
80105bff:	6a 01                	push   $0x1
80105c01:	e8 5a f4 ff ff       	call   80105060 <argint>
80105c06:	83 c4 10             	add    $0x10,%esp
80105c09:	85 c0                	test   %eax,%eax
80105c0b:	78 6f                	js     80105c7c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c0d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c13:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105c16:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105c18:	68 80 00 00 00       	push   $0x80
80105c1d:	6a 00                	push   $0x0
80105c1f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c25:	50                   	push   %eax
80105c26:	e8 35 f1 ff ff       	call   80104d60 <memset>
80105c2b:	83 c4 10             	add    $0x10,%esp
80105c2e:	eb 2c                	jmp    80105c5c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105c30:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c36:	85 c0                	test   %eax,%eax
80105c38:	74 56                	je     80105c90 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c3a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c40:	83 ec 08             	sub    $0x8,%esp
80105c43:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c46:	52                   	push   %edx
80105c47:	50                   	push   %eax
80105c48:	e8 a3 f3 ff ff       	call   80104ff0 <fetchstr>
80105c4d:	83 c4 10             	add    $0x10,%esp
80105c50:	85 c0                	test   %eax,%eax
80105c52:	78 28                	js     80105c7c <sys_exec+0xac>
  for(i=0;; i++){
80105c54:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105c57:	83 fb 20             	cmp    $0x20,%ebx
80105c5a:	74 20                	je     80105c7c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105c5c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c62:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105c69:	83 ec 08             	sub    $0x8,%esp
80105c6c:	57                   	push   %edi
80105c6d:	01 f0                	add    %esi,%eax
80105c6f:	50                   	push   %eax
80105c70:	e8 3b f3 ff ff       	call   80104fb0 <fetchint>
80105c75:	83 c4 10             	add    $0x10,%esp
80105c78:	85 c0                	test   %eax,%eax
80105c7a:	79 b4                	jns    80105c30 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105c7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105c7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c84:	5b                   	pop    %ebx
80105c85:	5e                   	pop    %esi
80105c86:	5f                   	pop    %edi
80105c87:	5d                   	pop    %ebp
80105c88:	c3                   	ret    
80105c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105c90:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c96:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105c99:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ca0:	00 00 00 00 
  return exec(path, argv);
80105ca4:	50                   	push   %eax
80105ca5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105cab:	e8 60 ad ff ff       	call   80100a10 <exec>
80105cb0:	83 c4 10             	add    $0x10,%esp
}
80105cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cb6:	5b                   	pop    %ebx
80105cb7:	5e                   	pop    %esi
80105cb8:	5f                   	pop    %edi
80105cb9:	5d                   	pop    %ebp
80105cba:	c3                   	ret    
80105cbb:	90                   	nop
80105cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <sys_pipe>:

int
sys_pipe(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	57                   	push   %edi
80105cc4:	56                   	push   %esi
80105cc5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105cc6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105cc9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105ccc:	6a 08                	push   $0x8
80105cce:	50                   	push   %eax
80105ccf:	6a 00                	push   $0x0
80105cd1:	e8 da f3 ff ff       	call   801050b0 <argptr>
80105cd6:	83 c4 10             	add    $0x10,%esp
80105cd9:	85 c0                	test   %eax,%eax
80105cdb:	0f 88 ae 00 00 00    	js     80105d8f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105ce1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ce4:	83 ec 08             	sub    $0x8,%esp
80105ce7:	50                   	push   %eax
80105ce8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ceb:	50                   	push   %eax
80105cec:	e8 2f d6 ff ff       	call   80103320 <pipealloc>
80105cf1:	83 c4 10             	add    $0x10,%esp
80105cf4:	85 c0                	test   %eax,%eax
80105cf6:	0f 88 93 00 00 00    	js     80105d8f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cfc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105cff:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d01:	e8 6a dc ff ff       	call   80103970 <myproc>
80105d06:	eb 10                	jmp    80105d18 <sys_pipe+0x58>
80105d08:	90                   	nop
80105d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105d10:	83 c3 01             	add    $0x1,%ebx
80105d13:	83 fb 10             	cmp    $0x10,%ebx
80105d16:	74 60                	je     80105d78 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105d18:	8b 74 98 18          	mov    0x18(%eax,%ebx,4),%esi
80105d1c:	85 f6                	test   %esi,%esi
80105d1e:	75 f0                	jne    80105d10 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105d20:	8d 73 04             	lea    0x4(%ebx),%esi
80105d23:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d27:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105d2a:	e8 41 dc ff ff       	call   80103970 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d2f:	31 d2                	xor    %edx,%edx
80105d31:	eb 0d                	jmp    80105d40 <sys_pipe+0x80>
80105d33:	90                   	nop
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d38:	83 c2 01             	add    $0x1,%edx
80105d3b:	83 fa 10             	cmp    $0x10,%edx
80105d3e:	74 28                	je     80105d68 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105d40:	8b 4c 90 18          	mov    0x18(%eax,%edx,4),%ecx
80105d44:	85 c9                	test   %ecx,%ecx
80105d46:	75 f0                	jne    80105d38 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105d48:	89 7c 90 18          	mov    %edi,0x18(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105d4c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d4f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105d51:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d54:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d57:	31 c0                	xor    %eax,%eax
}
80105d59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d5c:	5b                   	pop    %ebx
80105d5d:	5e                   	pop    %esi
80105d5e:	5f                   	pop    %edi
80105d5f:	5d                   	pop    %ebp
80105d60:	c3                   	ret    
80105d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105d68:	e8 03 dc ff ff       	call   80103970 <myproc>
80105d6d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105d74:	00 
80105d75:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105d78:	83 ec 0c             	sub    $0xc,%esp
80105d7b:	ff 75 e0             	pushl  -0x20(%ebp)
80105d7e:	e8 8d b1 ff ff       	call   80100f10 <fileclose>
    fileclose(wf);
80105d83:	58                   	pop    %eax
80105d84:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d87:	e8 84 b1 ff ff       	call   80100f10 <fileclose>
    return -1;
80105d8c:	83 c4 10             	add    $0x10,%esp
80105d8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d94:	eb c3                	jmp    80105d59 <sys_pipe+0x99>
80105d96:	66 90                	xchg   %ax,%ax
80105d98:	66 90                	xchg   %ax,%ax
80105d9a:	66 90                	xchg   %ax,%ax
80105d9c:	66 90                	xchg   %ax,%ax
80105d9e:	66 90                	xchg   %ax,%ax

80105da0 <sys_fork>:
#include "proc.h"
#include "kthread.h"

int
sys_fork(void)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105da3:	5d                   	pop    %ebp
  return fork();
80105da4:	e9 d7 dd ff ff       	jmp    80103b80 <fork>
80105da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105db0 <sys_exit>:

int
sys_exit(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105db6:	e8 b5 e0 ff ff       	call   80103e70 <exit>
  return 0;  // not reached
}
80105dbb:	31 c0                	xor    %eax,%eax
80105dbd:	c9                   	leave  
80105dbe:	c3                   	ret    
80105dbf:	90                   	nop

80105dc0 <sys_wait>:

int
sys_wait(void)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105dc3:	5d                   	pop    %ebp
  return wait();
80105dc4:	e9 27 e3 ff ff       	jmp    801040f0 <wait>
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <sys_kill>:

int
sys_kill(void)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105dd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dd9:	50                   	push   %eax
80105dda:	6a 00                	push   $0x0
80105ddc:	e8 7f f2 ff ff       	call   80105060 <argint>
80105de1:	83 c4 10             	add    $0x10,%esp
80105de4:	85 c0                	test   %eax,%eax
80105de6:	78 18                	js     80105e00 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105de8:	83 ec 0c             	sub    $0xc,%esp
80105deb:	ff 75 f4             	pushl  -0xc(%ebp)
80105dee:	e8 bd e4 ff ff       	call   801042b0 <kill>
80105df3:	83 c4 10             	add    $0x10,%esp
}
80105df6:	c9                   	leave  
80105df7:	c3                   	ret    
80105df8:	90                   	nop
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e05:	c9                   	leave  
80105e06:	c3                   	ret    
80105e07:	89 f6                	mov    %esi,%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e10 <sys_getpid>:

int
sys_getpid(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105e16:	e8 55 db ff ff       	call   80103970 <myproc>
80105e1b:	8b 40 0c             	mov    0xc(%eax),%eax
}
80105e1e:	c9                   	leave  
80105e1f:	c3                   	ret    

80105e20 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105e24:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e27:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e2a:	50                   	push   %eax
80105e2b:	6a 00                	push   $0x0
80105e2d:	e8 2e f2 ff ff       	call   80105060 <argint>
80105e32:	83 c4 10             	add    $0x10,%esp
80105e35:	85 c0                	test   %eax,%eax
80105e37:	78 27                	js     80105e60 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105e39:	e8 32 db ff ff       	call   80103970 <myproc>
  if(growproc(n) < 0)
80105e3e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105e41:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e43:	ff 75 f4             	pushl  -0xc(%ebp)
80105e46:	e8 85 dc ff ff       	call   80103ad0 <growproc>
80105e4b:	83 c4 10             	add    $0x10,%esp
80105e4e:	85 c0                	test   %eax,%eax
80105e50:	78 0e                	js     80105e60 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105e52:	89 d8                	mov    %ebx,%eax
80105e54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e57:	c9                   	leave  
80105e58:	c3                   	ret    
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e60:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e65:	eb eb                	jmp    80105e52 <sys_sbrk+0x32>
80105e67:	89 f6                	mov    %esi,%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e70 <sys_sleep>:

int
sys_sleep(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e7a:	50                   	push   %eax
80105e7b:	6a 00                	push   $0x0
80105e7d:	e8 de f1 ff ff       	call   80105060 <argint>
80105e82:	83 c4 10             	add    $0x10,%esp
80105e85:	85 c0                	test   %eax,%eax
80105e87:	0f 88 8a 00 00 00    	js     80105f17 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105e8d:	83 ec 0c             	sub    $0xc,%esp
80105e90:	68 c0 fa 11 80       	push   $0x8011fac0
80105e95:	e8 b6 ed ff ff       	call   80104c50 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e9d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105ea0:	8b 1d 00 03 12 80    	mov    0x80120300,%ebx
  while(ticks - ticks0 < n){
80105ea6:	85 d2                	test   %edx,%edx
80105ea8:	75 27                	jne    80105ed1 <sys_sleep+0x61>
80105eaa:	eb 54                	jmp    80105f00 <sys_sleep+0x90>
80105eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105eb0:	83 ec 08             	sub    $0x8,%esp
80105eb3:	68 c0 fa 11 80       	push   $0x8011fac0
80105eb8:	68 00 03 12 80       	push   $0x80120300
80105ebd:	e8 6e e1 ff ff       	call   80104030 <sleep>
  while(ticks - ticks0 < n){
80105ec2:	a1 00 03 12 80       	mov    0x80120300,%eax
80105ec7:	83 c4 10             	add    $0x10,%esp
80105eca:	29 d8                	sub    %ebx,%eax
80105ecc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105ecf:	73 2f                	jae    80105f00 <sys_sleep+0x90>
    if(myproc()->killed){
80105ed1:	e8 9a da ff ff       	call   80103970 <myproc>
80105ed6:	8b 40 14             	mov    0x14(%eax),%eax
80105ed9:	85 c0                	test   %eax,%eax
80105edb:	74 d3                	je     80105eb0 <sys_sleep+0x40>
      release(&tickslock);
80105edd:	83 ec 0c             	sub    $0xc,%esp
80105ee0:	68 c0 fa 11 80       	push   $0x8011fac0
80105ee5:	e8 26 ee ff ff       	call   80104d10 <release>
      return -1;
80105eea:	83 c4 10             	add    $0x10,%esp
80105eed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105ef2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef5:	c9                   	leave  
80105ef6:	c3                   	ret    
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105f00:	83 ec 0c             	sub    $0xc,%esp
80105f03:	68 c0 fa 11 80       	push   $0x8011fac0
80105f08:	e8 03 ee ff ff       	call   80104d10 <release>
  return 0;
80105f0d:	83 c4 10             	add    $0x10,%esp
80105f10:	31 c0                	xor    %eax,%eax
}
80105f12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f15:	c9                   	leave  
80105f16:	c3                   	ret    
    return -1;
80105f17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f1c:	eb f4                	jmp    80105f12 <sys_sleep+0xa2>
80105f1e:	66 90                	xchg   %ax,%ax

80105f20 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	53                   	push   %ebx
80105f24:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105f27:	68 c0 fa 11 80       	push   $0x8011fac0
80105f2c:	e8 1f ed ff ff       	call   80104c50 <acquire>
  xticks = ticks;
80105f31:	8b 1d 00 03 12 80    	mov    0x80120300,%ebx
  release(&tickslock);
80105f37:	c7 04 24 c0 fa 11 80 	movl   $0x8011fac0,(%esp)
80105f3e:	e8 cd ed ff ff       	call   80104d10 <release>
  return xticks;
}
80105f43:	89 d8                	mov    %ebx,%eax
80105f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f48:	c9                   	leave  
80105f49:	c3                   	ret    
80105f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f50 <sys_kthread_exit>:

int
sys_kthread_exit(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	83 ec 08             	sub    $0x8,%esp
  kthread_exit();
80105f56:	e8 05 e6 ff ff       	call   80104560 <kthread_exit>
  return 0;  // not reached
}
80105f5b:	31 c0                	xor    %eax,%eax
80105f5d:	c9                   	leave  
80105f5e:	c3                   	ret    
80105f5f:	90                   	nop

80105f60 <sys_kthread_create>:

int
sys_kthread_create(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	83 ec 1c             	sub    $0x1c,%esp
  void* start_func;
  void* stack;

  if ((argptr(0, (char**)(&start_func), sizeof(int)) < 0) || (argptr(1, (char**)(&stack), sizeof(int)) < 0))
80105f66:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f69:	6a 04                	push   $0x4
80105f6b:	50                   	push   %eax
80105f6c:	6a 00                	push   $0x0
80105f6e:	e8 3d f1 ff ff       	call   801050b0 <argptr>
80105f73:	83 c4 10             	add    $0x10,%esp
80105f76:	85 c0                	test   %eax,%eax
80105f78:	78 2e                	js     80105fa8 <sys_kthread_create+0x48>
80105f7a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f7d:	83 ec 04             	sub    $0x4,%esp
80105f80:	6a 04                	push   $0x4
80105f82:	50                   	push   %eax
80105f83:	6a 01                	push   $0x1
80105f85:	e8 26 f1 ff ff       	call   801050b0 <argptr>
80105f8a:	83 c4 10             	add    $0x10,%esp
80105f8d:	85 c0                	test   %eax,%eax
80105f8f:	78 17                	js     80105fa8 <sys_kthread_create+0x48>
    return -1;
  return kthread_create(start_func,stack);
80105f91:	83 ec 08             	sub    $0x8,%esp
80105f94:	ff 75 f4             	pushl  -0xc(%ebp)
80105f97:	ff 75 f0             	pushl  -0x10(%ebp)
80105f9a:	e8 a1 e4 ff ff       	call   80104440 <kthread_create>
80105f9f:	83 c4 10             	add    $0x10,%esp
}
80105fa2:	c9                   	leave  
80105fa3:	c3                   	ret    
80105fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fad:	c9                   	leave  
80105fae:	c3                   	ret    
80105faf:	90                   	nop

80105fb0 <sys_kthread_id>:

int
sys_kthread_id(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
  return kthread_id();
}
80105fb3:	5d                   	pop    %ebp
  return kthread_id();
80105fb4:	e9 97 e5 ff ff       	jmp    80104550 <kthread_id>
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fc0 <sys_kthread_join>:

int
sys_kthread_join(void)
{
80105fc0:	55                   	push   %ebp
80105fc1:	89 e5                	mov    %esp,%ebp
80105fc3:	83 ec 20             	sub    $0x20,%esp
  int n;

  if(argint(0, &n) < 0)
80105fc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fc9:	50                   	push   %eax
80105fca:	6a 00                	push   $0x0
80105fcc:	e8 8f f0 ff ff       	call   80105060 <argint>
80105fd1:	83 c4 10             	add    $0x10,%esp
80105fd4:	85 c0                	test   %eax,%eax
80105fd6:	78 18                	js     80105ff0 <sys_kthread_join+0x30>
    return -1;
  return kthread_join(n);
80105fd8:	83 ec 0c             	sub    $0xc,%esp
80105fdb:	ff 75 f4             	pushl  -0xc(%ebp)
80105fde:	e8 5d e6 ff ff       	call   80104640 <kthread_join>
80105fe3:	83 c4 10             	add    $0x10,%esp
}
80105fe6:	c9                   	leave  
80105fe7:	c3                   	ret    
80105fe8:	90                   	nop
80105fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ff5:	c9                   	leave  
80105ff6:	c3                   	ret    
80105ff7:	89 f6                	mov    %esi,%esi
80105ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106000 <sys_kthread_mutex_alloc>:

int
sys_kthread_mutex_alloc(void)
{
80106000:	55                   	push   %ebp
80106001:	89 e5                	mov    %esp,%ebp
  return kthread_mutex_alloc();
}
80106003:	5d                   	pop    %ebp
  return kthread_mutex_alloc();
80106004:	e9 17 e7 ff ff       	jmp    80104720 <kthread_mutex_alloc>
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106010 <sys_kthread_mutex_dealloc>:

int
sys_kthread_mutex_dealloc(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 20             	sub    $0x20,%esp
  int mid;

  if(argint(0, &mid) < 0)
80106016:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106019:	50                   	push   %eax
8010601a:	6a 00                	push   $0x0
8010601c:	e8 3f f0 ff ff       	call   80105060 <argint>
80106021:	83 c4 10             	add    $0x10,%esp
80106024:	85 c0                	test   %eax,%eax
80106026:	78 18                	js     80106040 <sys_kthread_mutex_dealloc+0x30>
    return -1;
  return kthread_mutex_dealloc(mid);
80106028:	83 ec 0c             	sub    $0xc,%esp
8010602b:	ff 75 f4             	pushl  -0xc(%ebp)
8010602e:	e8 6d e7 ff ff       	call   801047a0 <kthread_mutex_dealloc>
80106033:	83 c4 10             	add    $0x10,%esp
}
80106036:	c9                   	leave  
80106037:	c3                   	ret    
80106038:	90                   	nop
80106039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106045:	c9                   	leave  
80106046:	c3                   	ret    
80106047:	89 f6                	mov    %esi,%esi
80106049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106050 <sys_kthread_mutex_lock>:

int
sys_kthread_mutex_lock(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	83 ec 20             	sub    $0x20,%esp
  int mid;

  if(argint(0, &mid) < 0)
80106056:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106059:	50                   	push   %eax
8010605a:	6a 00                	push   $0x0
8010605c:	e8 ff ef ff ff       	call   80105060 <argint>
80106061:	83 c4 10             	add    $0x10,%esp
80106064:	85 c0                	test   %eax,%eax
80106066:	78 18                	js     80106080 <sys_kthread_mutex_lock+0x30>
    return -1;
  return kthread_mutex_lock(mid);
80106068:	83 ec 0c             	sub    $0xc,%esp
8010606b:	ff 75 f4             	pushl  -0xc(%ebp)
8010606e:	e8 cd e7 ff ff       	call   80104840 <kthread_mutex_lock>
80106073:	83 c4 10             	add    $0x10,%esp
}
80106076:	c9                   	leave  
80106077:	c3                   	ret    
80106078:	90                   	nop
80106079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106085:	c9                   	leave  
80106086:	c3                   	ret    
80106087:	89 f6                	mov    %esi,%esi
80106089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106090 <sys_kthread_mutex_unlock>:

int
sys_kthread_mutex_unlock(void)
{
80106090:	55                   	push   %ebp
80106091:	89 e5                	mov    %esp,%ebp
80106093:	83 ec 20             	sub    $0x20,%esp
  int mid;

  if(argint(0, &mid) < 0)
80106096:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106099:	50                   	push   %eax
8010609a:	6a 00                	push   $0x0
8010609c:	e8 bf ef ff ff       	call   80105060 <argint>
801060a1:	83 c4 10             	add    $0x10,%esp
801060a4:	85 c0                	test   %eax,%eax
801060a6:	78 18                	js     801060c0 <sys_kthread_mutex_unlock+0x30>
    return -1;
  return kthread_mutex_unlock(mid);
801060a8:	83 ec 0c             	sub    $0xc,%esp
801060ab:	ff 75 f4             	pushl  -0xc(%ebp)
801060ae:	e8 7d e8 ff ff       	call   80104930 <kthread_mutex_unlock>
801060b3:	83 c4 10             	add    $0x10,%esp
}
801060b6:	c9                   	leave  
801060b7:	c3                   	ret    
801060b8:	90                   	nop
801060b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060c5:	c9                   	leave  
801060c6:	c3                   	ret    

801060c7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801060c7:	1e                   	push   %ds
  pushl %es
801060c8:	06                   	push   %es
  pushl %fs
801060c9:	0f a0                	push   %fs
  pushl %gs
801060cb:	0f a8                	push   %gs
  pushal
801060cd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801060ce:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801060d2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801060d4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801060d6:	54                   	push   %esp
  call trap
801060d7:	e8 c4 00 00 00       	call   801061a0 <trap>
  addl $4, %esp
801060dc:	83 c4 04             	add    $0x4,%esp

801060df <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801060df:	61                   	popa   
  popl %gs
801060e0:	0f a9                	pop    %gs
  popl %fs
801060e2:	0f a1                	pop    %fs
  popl %es
801060e4:	07                   	pop    %es
  popl %ds
801060e5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801060e6:	83 c4 08             	add    $0x8,%esp
  iret
801060e9:	cf                   	iret   
801060ea:	66 90                	xchg   %ax,%ax
801060ec:	66 90                	xchg   %ax,%ax
801060ee:	66 90                	xchg   %ax,%ax

801060f0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801060f0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801060f1:	31 c0                	xor    %eax,%eax
{
801060f3:	89 e5                	mov    %esp,%ebp
801060f5:	83 ec 08             	sub    $0x8,%esp
801060f8:	90                   	nop
801060f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106100:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106107:	c7 04 c5 02 fb 11 80 	movl   $0x8e000008,-0x7fee04fe(,%eax,8)
8010610e:	08 00 00 8e 
80106112:	66 89 14 c5 00 fb 11 	mov    %dx,-0x7fee0500(,%eax,8)
80106119:	80 
8010611a:	c1 ea 10             	shr    $0x10,%edx
8010611d:	66 89 14 c5 06 fb 11 	mov    %dx,-0x7fee04fa(,%eax,8)
80106124:	80 
  for(i = 0; i < 256; i++)
80106125:	83 c0 01             	add    $0x1,%eax
80106128:	3d 00 01 00 00       	cmp    $0x100,%eax
8010612d:	75 d1                	jne    80106100 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010612f:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
80106134:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106137:	c7 05 02 fd 11 80 08 	movl   $0xef000008,0x8011fd02
8010613e:	00 00 ef 
  initlock(&tickslock, "time");
80106141:	68 39 82 10 80       	push   $0x80108239
80106146:	68 c0 fa 11 80       	push   $0x8011fac0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010614b:	66 a3 00 fd 11 80    	mov    %ax,0x8011fd00
80106151:	c1 e8 10             	shr    $0x10,%eax
80106154:	66 a3 06 fd 11 80    	mov    %ax,0x8011fd06
  initlock(&tickslock, "time");
8010615a:	e8 b1 e9 ff ff       	call   80104b10 <initlock>
}
8010615f:	83 c4 10             	add    $0x10,%esp
80106162:	c9                   	leave  
80106163:	c3                   	ret    
80106164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010616a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106170 <idtinit>:

void
idtinit(void)
{
80106170:	55                   	push   %ebp
  pd[0] = size-1;
80106171:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106176:	89 e5                	mov    %esp,%ebp
80106178:	83 ec 10             	sub    $0x10,%esp
8010617b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010617f:	b8 00 fb 11 80       	mov    $0x8011fb00,%eax
80106184:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106188:	c1 e8 10             	shr    $0x10,%eax
8010618b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010618f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106192:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106195:	c9                   	leave  
80106196:	c3                   	ret    
80106197:	89 f6                	mov    %esi,%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	57                   	push   %edi
801061a4:	56                   	push   %esi
801061a5:	53                   	push   %ebx
801061a6:	83 ec 1c             	sub    $0x1c,%esp
801061a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801061ac:	8b 43 30             	mov    0x30(%ebx),%eax
801061af:	83 f8 40             	cmp    $0x40,%eax
801061b2:	0f 84 e8 00 00 00    	je     801062a0 <trap+0x100>
    if(mythread()->exitRequest)
      kthread_exit();
    return;
  }

  switch(tf->trapno){
801061b8:	83 e8 20             	sub    $0x20,%eax
801061bb:	83 f8 1f             	cmp    $0x1f,%eax
801061be:	0f 87 04 02 00 00    	ja     801063c8 <trap+0x228>
801061c4:	ff 24 85 e0 82 10 80 	jmp    *-0x7fef7d20(,%eax,4)
801061cb:	90                   	nop
801061cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801061d0:	e8 7b d7 ff ff       	call   80103950 <cpuid>
801061d5:	85 c0                	test   %eax,%eax
801061d7:	0f 84 cb 02 00 00    	je     801064a8 <trap+0x308>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
801061dd:	e8 4e c6 ff ff       	call   80102830 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061e2:	e8 89 d7 ff ff       	call   80103970 <myproc>
801061e7:	85 c0                	test   %eax,%eax
801061e9:	74 1d                	je     80106208 <trap+0x68>
801061eb:	e8 80 d7 ff ff       	call   80103970 <myproc>
801061f0:	8b 70 14             	mov    0x14(%eax),%esi
801061f3:	85 f6                	test   %esi,%esi
801061f5:	74 11                	je     80106208 <trap+0x68>
801061f7:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061fb:	83 e0 03             	and    $0x3,%eax
801061fe:	66 83 f8 03          	cmp    $0x3,%ax
80106202:	0f 84 90 02 00 00    	je     80106498 <trap+0x2f8>
    exit();
  if(mythread() && mythread()->exitRequest && (tf->cs&3) == DPL_USER)
80106208:	e8 93 d7 ff ff       	call   801039a0 <mythread>
8010620d:	85 c0                	test   %eax,%eax
8010620f:	74 1d                	je     8010622e <trap+0x8e>
80106211:	e8 8a d7 ff ff       	call   801039a0 <mythread>
80106216:	8b 48 20             	mov    0x20(%eax),%ecx
80106219:	85 c9                	test   %ecx,%ecx
8010621b:	74 11                	je     8010622e <trap+0x8e>
8010621d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106221:	83 e0 03             	and    $0x3,%eax
80106224:	66 83 f8 03          	cmp    $0x3,%ax
80106228:	0f 84 5a 02 00 00    	je     80106488 <trap+0x2e8>
    kthread_exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(mythread() && mythread()->state == RUNNING &&
8010622e:	e8 6d d7 ff ff       	call   801039a0 <mythread>
80106233:	85 c0                	test   %eax,%eax
80106235:	74 0f                	je     80106246 <trap+0xa6>
80106237:	e8 64 d7 ff ff       	call   801039a0 <mythread>
8010623c:	83 78 08 03          	cmpl   $0x3,0x8(%eax)
80106240:	0f 84 b2 00 00 00    	je     801062f8 <trap+0x158>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106246:	e8 25 d7 ff ff       	call   80103970 <myproc>
8010624b:	85 c0                	test   %eax,%eax
8010624d:	74 1d                	je     8010626c <trap+0xcc>
8010624f:	e8 1c d7 ff ff       	call   80103970 <myproc>
80106254:	8b 50 14             	mov    0x14(%eax),%edx
80106257:	85 d2                	test   %edx,%edx
80106259:	74 11                	je     8010626c <trap+0xcc>
8010625b:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010625f:	83 e0 03             	and    $0x3,%eax
80106262:	66 83 f8 03          	cmp    $0x3,%ax
80106266:	0f 84 0c 02 00 00    	je     80106478 <trap+0x2d8>
    exit();
  if(mythread() && mythread()->exitRequest && (tf->cs&3) == DPL_USER)
8010626c:	e8 2f d7 ff ff       	call   801039a0 <mythread>
80106271:	85 c0                	test   %eax,%eax
80106273:	74 19                	je     8010628e <trap+0xee>
80106275:	e8 26 d7 ff ff       	call   801039a0 <mythread>
8010627a:	8b 40 20             	mov    0x20(%eax),%eax
8010627d:	85 c0                	test   %eax,%eax
8010627f:	74 0d                	je     8010628e <trap+0xee>
80106281:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106285:	83 e0 03             	and    $0x3,%eax
80106288:	66 83 f8 03          	cmp    $0x3,%ax
8010628c:	74 5b                	je     801062e9 <trap+0x149>
    kthread_exit();
}
8010628e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106291:	5b                   	pop    %ebx
80106292:	5e                   	pop    %esi
80106293:	5f                   	pop    %edi
80106294:	5d                   	pop    %ebp
80106295:	c3                   	ret    
80106296:	8d 76 00             	lea    0x0(%esi),%esi
80106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(myproc()->killed)
801062a0:	e8 cb d6 ff ff       	call   80103970 <myproc>
801062a5:	8b 40 14             	mov    0x14(%eax),%eax
801062a8:	85 c0                	test   %eax,%eax
801062aa:	0f 85 08 01 00 00    	jne    801063b8 <trap+0x218>
    if(mythread()->exitRequest)
801062b0:	e8 eb d6 ff ff       	call   801039a0 <mythread>
801062b5:	8b 40 20             	mov    0x20(%eax),%eax
801062b8:	85 c0                	test   %eax,%eax
801062ba:	0f 85 e8 00 00 00    	jne    801063a8 <trap+0x208>
    mythread()->tf = tf;
801062c0:	e8 db d6 ff ff       	call   801039a0 <mythread>
801062c5:	89 58 14             	mov    %ebx,0x14(%eax)
    syscall();
801062c8:	e8 83 ee ff ff       	call   80105150 <syscall>
    if(myproc()->killed)
801062cd:	e8 9e d6 ff ff       	call   80103970 <myproc>
801062d2:	8b 40 14             	mov    0x14(%eax),%eax
801062d5:	85 c0                	test   %eax,%eax
801062d7:	0f 85 bb 00 00 00    	jne    80106398 <trap+0x1f8>
    if(mythread()->exitRequest)
801062dd:	e8 be d6 ff ff       	call   801039a0 <mythread>
801062e2:	8b 78 20             	mov    0x20(%eax),%edi
801062e5:	85 ff                	test   %edi,%edi
801062e7:	74 a5                	je     8010628e <trap+0xee>
}
801062e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062ec:	5b                   	pop    %ebx
801062ed:	5e                   	pop    %esi
801062ee:	5f                   	pop    %edi
801062ef:	5d                   	pop    %ebp
      kthread_exit();
801062f0:	e9 6b e2 ff ff       	jmp    80104560 <kthread_exit>
801062f5:	8d 76 00             	lea    0x0(%esi),%esi
  if(mythread() && mythread()->state == RUNNING &&
801062f8:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801062fc:	0f 85 44 ff ff ff    	jne    80106246 <trap+0xa6>
    yield();
80106302:	e8 d9 dc ff ff       	call   80103fe0 <yield>
80106307:	e9 3a ff ff ff       	jmp    80106246 <trap+0xa6>
8010630c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106310:	e8 db c3 ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80106315:	e8 16 c5 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010631a:	e8 51 d6 ff ff       	call   80103970 <myproc>
8010631f:	85 c0                	test   %eax,%eax
80106321:	0f 85 c4 fe ff ff    	jne    801061eb <trap+0x4b>
80106327:	e9 dc fe ff ff       	jmp    80106208 <trap+0x68>
8010632c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106330:	e8 4b 03 00 00       	call   80106680 <uartintr>
    lapiceoi();
80106335:	e8 f6 c4 ff ff       	call   80102830 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010633a:	e8 31 d6 ff ff       	call   80103970 <myproc>
8010633f:	85 c0                	test   %eax,%eax
80106341:	0f 85 a4 fe ff ff    	jne    801061eb <trap+0x4b>
80106347:	e9 bc fe ff ff       	jmp    80106208 <trap+0x68>
8010634c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106350:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106354:	8b 7b 38             	mov    0x38(%ebx),%edi
80106357:	e8 f4 d5 ff ff       	call   80103950 <cpuid>
8010635c:	57                   	push   %edi
8010635d:	56                   	push   %esi
8010635e:	50                   	push   %eax
8010635f:	68 44 82 10 80       	push   $0x80108244
80106364:	e8 f7 a2 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106369:	e8 c2 c4 ff ff       	call   80102830 <lapiceoi>
    break;
8010636e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106371:	e8 fa d5 ff ff       	call   80103970 <myproc>
80106376:	85 c0                	test   %eax,%eax
80106378:	0f 85 6d fe ff ff    	jne    801061eb <trap+0x4b>
8010637e:	e9 85 fe ff ff       	jmp    80106208 <trap+0x68>
80106383:	90                   	nop
80106384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106388:	e8 d3 bd ff ff       	call   80102160 <ideintr>
8010638d:	e9 4b fe ff ff       	jmp    801061dd <trap+0x3d>
80106392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106398:	e8 d3 da ff ff       	call   80103e70 <exit>
8010639d:	e9 3b ff ff ff       	jmp    801062dd <trap+0x13d>
801063a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kthread_exit();
801063a8:	e8 b3 e1 ff ff       	call   80104560 <kthread_exit>
801063ad:	e9 0e ff ff ff       	jmp    801062c0 <trap+0x120>
801063b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801063b8:	e8 b3 da ff ff       	call   80103e70 <exit>
801063bd:	e9 ee fe ff ff       	jmp    801062b0 <trap+0x110>
801063c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801063c8:	e8 a3 d5 ff ff       	call   80103970 <myproc>
801063cd:	85 c0                	test   %eax,%eax
801063cf:	8b 7b 38             	mov    0x38(%ebx),%edi
801063d2:	0f 84 04 01 00 00    	je     801064dc <trap+0x33c>
801063d8:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801063dc:	0f 84 fa 00 00 00    	je     801064dc <trap+0x33c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801063e2:	0f 20 d1             	mov    %cr2,%ecx
801063e5:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801063e8:	e8 63 d5 ff ff       	call   80103950 <cpuid>
801063ed:	89 45 dc             	mov    %eax,-0x24(%ebp)
801063f0:	8b 43 34             	mov    0x34(%ebx),%eax
801063f3:	8b 73 30             	mov    0x30(%ebx),%esi
801063f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801063f9:	e8 72 d5 ff ff       	call   80103970 <myproc>
801063fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106401:	e8 6a d5 ff ff       	call   80103970 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106406:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106409:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010640c:	51                   	push   %ecx
8010640d:	57                   	push   %edi
8010640e:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
8010640f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106412:	ff 75 e4             	pushl  -0x1c(%ebp)
80106415:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106416:	83 c2 5c             	add    $0x5c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106419:	52                   	push   %edx
8010641a:	ff 70 0c             	pushl  0xc(%eax)
8010641d:	68 9c 82 10 80       	push   $0x8010829c
80106422:	e8 39 a2 ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
80106427:	83 c4 20             	add    $0x20,%esp
8010642a:	e8 41 d5 ff ff       	call   80103970 <myproc>
8010642f:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    for(t = myproc()->threads ; t < &myproc()->threads[NTHREAD] ; t++){
80106436:	e8 35 d5 ff ff       	call   80103970 <myproc>
8010643b:	8b 70 6c             	mov    0x6c(%eax),%esi
8010643e:	eb 10                	jmp    80106450 <trap+0x2b0>
      if(t->state == SLEEPING)
80106440:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
80106444:	75 07                	jne    8010644d <trap+0x2ad>
        t->state = RUNNABLE;
80106446:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
    for(t = myproc()->threads ; t < &myproc()->threads[NTHREAD] ; t++){
8010644d:	83 c6 24             	add    $0x24,%esi
80106450:	e8 1b d5 ff ff       	call   80103970 <myproc>
80106455:	8b 40 6c             	mov    0x6c(%eax),%eax
80106458:	05 40 02 00 00       	add    $0x240,%eax
8010645d:	39 c6                	cmp    %eax,%esi
8010645f:	72 df                	jb     80106440 <trap+0x2a0>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106461:	e8 0a d5 ff ff       	call   80103970 <myproc>
80106466:	85 c0                	test   %eax,%eax
80106468:	0f 85 7d fd ff ff    	jne    801061eb <trap+0x4b>
8010646e:	e9 95 fd ff ff       	jmp    80106208 <trap+0x68>
80106473:	90                   	nop
80106474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106478:	e8 f3 d9 ff ff       	call   80103e70 <exit>
8010647d:	e9 ea fd ff ff       	jmp    8010626c <trap+0xcc>
80106482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kthread_exit();
80106488:	e8 d3 e0 ff ff       	call   80104560 <kthread_exit>
8010648d:	e9 9c fd ff ff       	jmp    8010622e <trap+0x8e>
80106492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106498:	e8 d3 d9 ff ff       	call   80103e70 <exit>
8010649d:	e9 66 fd ff ff       	jmp    80106208 <trap+0x68>
801064a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801064a8:	83 ec 0c             	sub    $0xc,%esp
801064ab:	68 c0 fa 11 80       	push   $0x8011fac0
801064b0:	e8 9b e7 ff ff       	call   80104c50 <acquire>
      wakeup(&ticks);
801064b5:	c7 04 24 00 03 12 80 	movl   $0x80120300,(%esp)
      ticks++;
801064bc:	83 05 00 03 12 80 01 	addl   $0x1,0x80120300
      wakeup(&ticks);
801064c3:	e8 b8 dd ff ff       	call   80104280 <wakeup>
      release(&tickslock);
801064c8:	c7 04 24 c0 fa 11 80 	movl   $0x8011fac0,(%esp)
801064cf:	e8 3c e8 ff ff       	call   80104d10 <release>
801064d4:	83 c4 10             	add    $0x10,%esp
801064d7:	e9 01 fd ff ff       	jmp    801061dd <trap+0x3d>
801064dc:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801064df:	e8 6c d4 ff ff       	call   80103950 <cpuid>
801064e4:	83 ec 0c             	sub    $0xc,%esp
801064e7:	56                   	push   %esi
801064e8:	57                   	push   %edi
801064e9:	50                   	push   %eax
801064ea:	ff 73 30             	pushl  0x30(%ebx)
801064ed:	68 68 82 10 80       	push   $0x80108268
801064f2:	e8 69 a1 ff ff       	call   80100660 <cprintf>
      panic("trap");
801064f7:	83 c4 14             	add    $0x14,%esp
801064fa:	68 3e 82 10 80       	push   $0x8010823e
801064ff:	e8 8c 9e ff ff       	call   80100390 <panic>
80106504:	66 90                	xchg   %ax,%ax
80106506:	66 90                	xchg   %ax,%ax
80106508:	66 90                	xchg   %ax,%ax
8010650a:	66 90                	xchg   %ax,%ax
8010650c:	66 90                	xchg   %ax,%ax
8010650e:	66 90                	xchg   %ax,%ax

80106510 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106510:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
80106515:	55                   	push   %ebp
80106516:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106518:	85 c0                	test   %eax,%eax
8010651a:	74 1c                	je     80106538 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010651c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106521:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106522:	a8 01                	test   $0x1,%al
80106524:	74 12                	je     80106538 <uartgetc+0x28>
80106526:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010652b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010652c:	0f b6 c0             	movzbl %al,%eax
}
8010652f:	5d                   	pop    %ebp
80106530:	c3                   	ret    
80106531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106538:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010653d:	5d                   	pop    %ebp
8010653e:	c3                   	ret    
8010653f:	90                   	nop

80106540 <uartputc.part.0>:
uartputc(int c)
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	57                   	push   %edi
80106544:	56                   	push   %esi
80106545:	53                   	push   %ebx
80106546:	89 c7                	mov    %eax,%edi
80106548:	bb 80 00 00 00       	mov    $0x80,%ebx
8010654d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106552:	83 ec 0c             	sub    $0xc,%esp
80106555:	eb 1b                	jmp    80106572 <uartputc.part.0+0x32>
80106557:	89 f6                	mov    %esi,%esi
80106559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106560:	83 ec 0c             	sub    $0xc,%esp
80106563:	6a 0a                	push   $0xa
80106565:	e8 e6 c2 ff ff       	call   80102850 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010656a:	83 c4 10             	add    $0x10,%esp
8010656d:	83 eb 01             	sub    $0x1,%ebx
80106570:	74 07                	je     80106579 <uartputc.part.0+0x39>
80106572:	89 f2                	mov    %esi,%edx
80106574:	ec                   	in     (%dx),%al
80106575:	a8 20                	test   $0x20,%al
80106577:	74 e7                	je     80106560 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106579:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010657e:	89 f8                	mov    %edi,%eax
80106580:	ee                   	out    %al,(%dx)
}
80106581:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106584:	5b                   	pop    %ebx
80106585:	5e                   	pop    %esi
80106586:	5f                   	pop    %edi
80106587:	5d                   	pop    %ebp
80106588:	c3                   	ret    
80106589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106590 <uartinit>:
{
80106590:	55                   	push   %ebp
80106591:	31 c9                	xor    %ecx,%ecx
80106593:	89 c8                	mov    %ecx,%eax
80106595:	89 e5                	mov    %esp,%ebp
80106597:	57                   	push   %edi
80106598:	56                   	push   %esi
80106599:	53                   	push   %ebx
8010659a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010659f:	89 da                	mov    %ebx,%edx
801065a1:	83 ec 0c             	sub    $0xc,%esp
801065a4:	ee                   	out    %al,(%dx)
801065a5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801065aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801065af:	89 fa                	mov    %edi,%edx
801065b1:	ee                   	out    %al,(%dx)
801065b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801065b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065bc:	ee                   	out    %al,(%dx)
801065bd:	be f9 03 00 00       	mov    $0x3f9,%esi
801065c2:	89 c8                	mov    %ecx,%eax
801065c4:	89 f2                	mov    %esi,%edx
801065c6:	ee                   	out    %al,(%dx)
801065c7:	b8 03 00 00 00       	mov    $0x3,%eax
801065cc:	89 fa                	mov    %edi,%edx
801065ce:	ee                   	out    %al,(%dx)
801065cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801065d4:	89 c8                	mov    %ecx,%eax
801065d6:	ee                   	out    %al,(%dx)
801065d7:	b8 01 00 00 00       	mov    $0x1,%eax
801065dc:	89 f2                	mov    %esi,%edx
801065de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801065df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801065e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801065e5:	3c ff                	cmp    $0xff,%al
801065e7:	74 5a                	je     80106643 <uartinit+0xb3>
  uart = 1;
801065e9:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
801065f0:	00 00 00 
801065f3:	89 da                	mov    %ebx,%edx
801065f5:	ec                   	in     (%dx),%al
801065f6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065fb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801065fc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801065ff:	bb 60 83 10 80       	mov    $0x80108360,%ebx
  ioapicenable(IRQ_COM1, 0);
80106604:	6a 00                	push   $0x0
80106606:	6a 04                	push   $0x4
80106608:	e8 a3 bd ff ff       	call   801023b0 <ioapicenable>
8010660d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106610:	b8 78 00 00 00       	mov    $0x78,%eax
80106615:	eb 13                	jmp    8010662a <uartinit+0x9a>
80106617:	89 f6                	mov    %esi,%esi
80106619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106620:	83 c3 01             	add    $0x1,%ebx
80106623:	0f be 03             	movsbl (%ebx),%eax
80106626:	84 c0                	test   %al,%al
80106628:	74 19                	je     80106643 <uartinit+0xb3>
  if(!uart)
8010662a:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80106630:	85 d2                	test   %edx,%edx
80106632:	74 ec                	je     80106620 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106634:	83 c3 01             	add    $0x1,%ebx
80106637:	e8 04 ff ff ff       	call   80106540 <uartputc.part.0>
8010663c:	0f be 03             	movsbl (%ebx),%eax
8010663f:	84 c0                	test   %al,%al
80106641:	75 e7                	jne    8010662a <uartinit+0x9a>
}
80106643:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106646:	5b                   	pop    %ebx
80106647:	5e                   	pop    %esi
80106648:	5f                   	pop    %edi
80106649:	5d                   	pop    %ebp
8010664a:	c3                   	ret    
8010664b:	90                   	nop
8010664c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106650 <uartputc>:
  if(!uart)
80106650:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
80106656:	55                   	push   %ebp
80106657:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106659:	85 d2                	test   %edx,%edx
{
8010665b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010665e:	74 10                	je     80106670 <uartputc+0x20>
}
80106660:	5d                   	pop    %ebp
80106661:	e9 da fe ff ff       	jmp    80106540 <uartputc.part.0>
80106666:	8d 76 00             	lea    0x0(%esi),%esi
80106669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106670:	5d                   	pop    %ebp
80106671:	c3                   	ret    
80106672:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106680 <uartintr>:

void
uartintr(void)
{
80106680:	55                   	push   %ebp
80106681:	89 e5                	mov    %esp,%ebp
80106683:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106686:	68 10 65 10 80       	push   $0x80106510
8010668b:	e8 80 a1 ff ff       	call   80100810 <consoleintr>
}
80106690:	83 c4 10             	add    $0x10,%esp
80106693:	c9                   	leave  
80106694:	c3                   	ret    

80106695 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106695:	6a 00                	push   $0x0
  pushl $0
80106697:	6a 00                	push   $0x0
  jmp alltraps
80106699:	e9 29 fa ff ff       	jmp    801060c7 <alltraps>

8010669e <vector1>:
.globl vector1
vector1:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $1
801066a0:	6a 01                	push   $0x1
  jmp alltraps
801066a2:	e9 20 fa ff ff       	jmp    801060c7 <alltraps>

801066a7 <vector2>:
.globl vector2
vector2:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $2
801066a9:	6a 02                	push   $0x2
  jmp alltraps
801066ab:	e9 17 fa ff ff       	jmp    801060c7 <alltraps>

801066b0 <vector3>:
.globl vector3
vector3:
  pushl $0
801066b0:	6a 00                	push   $0x0
  pushl $3
801066b2:	6a 03                	push   $0x3
  jmp alltraps
801066b4:	e9 0e fa ff ff       	jmp    801060c7 <alltraps>

801066b9 <vector4>:
.globl vector4
vector4:
  pushl $0
801066b9:	6a 00                	push   $0x0
  pushl $4
801066bb:	6a 04                	push   $0x4
  jmp alltraps
801066bd:	e9 05 fa ff ff       	jmp    801060c7 <alltraps>

801066c2 <vector5>:
.globl vector5
vector5:
  pushl $0
801066c2:	6a 00                	push   $0x0
  pushl $5
801066c4:	6a 05                	push   $0x5
  jmp alltraps
801066c6:	e9 fc f9 ff ff       	jmp    801060c7 <alltraps>

801066cb <vector6>:
.globl vector6
vector6:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $6
801066cd:	6a 06                	push   $0x6
  jmp alltraps
801066cf:	e9 f3 f9 ff ff       	jmp    801060c7 <alltraps>

801066d4 <vector7>:
.globl vector7
vector7:
  pushl $0
801066d4:	6a 00                	push   $0x0
  pushl $7
801066d6:	6a 07                	push   $0x7
  jmp alltraps
801066d8:	e9 ea f9 ff ff       	jmp    801060c7 <alltraps>

801066dd <vector8>:
.globl vector8
vector8:
  pushl $8
801066dd:	6a 08                	push   $0x8
  jmp alltraps
801066df:	e9 e3 f9 ff ff       	jmp    801060c7 <alltraps>

801066e4 <vector9>:
.globl vector9
vector9:
  pushl $0
801066e4:	6a 00                	push   $0x0
  pushl $9
801066e6:	6a 09                	push   $0x9
  jmp alltraps
801066e8:	e9 da f9 ff ff       	jmp    801060c7 <alltraps>

801066ed <vector10>:
.globl vector10
vector10:
  pushl $10
801066ed:	6a 0a                	push   $0xa
  jmp alltraps
801066ef:	e9 d3 f9 ff ff       	jmp    801060c7 <alltraps>

801066f4 <vector11>:
.globl vector11
vector11:
  pushl $11
801066f4:	6a 0b                	push   $0xb
  jmp alltraps
801066f6:	e9 cc f9 ff ff       	jmp    801060c7 <alltraps>

801066fb <vector12>:
.globl vector12
vector12:
  pushl $12
801066fb:	6a 0c                	push   $0xc
  jmp alltraps
801066fd:	e9 c5 f9 ff ff       	jmp    801060c7 <alltraps>

80106702 <vector13>:
.globl vector13
vector13:
  pushl $13
80106702:	6a 0d                	push   $0xd
  jmp alltraps
80106704:	e9 be f9 ff ff       	jmp    801060c7 <alltraps>

80106709 <vector14>:
.globl vector14
vector14:
  pushl $14
80106709:	6a 0e                	push   $0xe
  jmp alltraps
8010670b:	e9 b7 f9 ff ff       	jmp    801060c7 <alltraps>

80106710 <vector15>:
.globl vector15
vector15:
  pushl $0
80106710:	6a 00                	push   $0x0
  pushl $15
80106712:	6a 0f                	push   $0xf
  jmp alltraps
80106714:	e9 ae f9 ff ff       	jmp    801060c7 <alltraps>

80106719 <vector16>:
.globl vector16
vector16:
  pushl $0
80106719:	6a 00                	push   $0x0
  pushl $16
8010671b:	6a 10                	push   $0x10
  jmp alltraps
8010671d:	e9 a5 f9 ff ff       	jmp    801060c7 <alltraps>

80106722 <vector17>:
.globl vector17
vector17:
  pushl $17
80106722:	6a 11                	push   $0x11
  jmp alltraps
80106724:	e9 9e f9 ff ff       	jmp    801060c7 <alltraps>

80106729 <vector18>:
.globl vector18
vector18:
  pushl $0
80106729:	6a 00                	push   $0x0
  pushl $18
8010672b:	6a 12                	push   $0x12
  jmp alltraps
8010672d:	e9 95 f9 ff ff       	jmp    801060c7 <alltraps>

80106732 <vector19>:
.globl vector19
vector19:
  pushl $0
80106732:	6a 00                	push   $0x0
  pushl $19
80106734:	6a 13                	push   $0x13
  jmp alltraps
80106736:	e9 8c f9 ff ff       	jmp    801060c7 <alltraps>

8010673b <vector20>:
.globl vector20
vector20:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $20
8010673d:	6a 14                	push   $0x14
  jmp alltraps
8010673f:	e9 83 f9 ff ff       	jmp    801060c7 <alltraps>

80106744 <vector21>:
.globl vector21
vector21:
  pushl $0
80106744:	6a 00                	push   $0x0
  pushl $21
80106746:	6a 15                	push   $0x15
  jmp alltraps
80106748:	e9 7a f9 ff ff       	jmp    801060c7 <alltraps>

8010674d <vector22>:
.globl vector22
vector22:
  pushl $0
8010674d:	6a 00                	push   $0x0
  pushl $22
8010674f:	6a 16                	push   $0x16
  jmp alltraps
80106751:	e9 71 f9 ff ff       	jmp    801060c7 <alltraps>

80106756 <vector23>:
.globl vector23
vector23:
  pushl $0
80106756:	6a 00                	push   $0x0
  pushl $23
80106758:	6a 17                	push   $0x17
  jmp alltraps
8010675a:	e9 68 f9 ff ff       	jmp    801060c7 <alltraps>

8010675f <vector24>:
.globl vector24
vector24:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $24
80106761:	6a 18                	push   $0x18
  jmp alltraps
80106763:	e9 5f f9 ff ff       	jmp    801060c7 <alltraps>

80106768 <vector25>:
.globl vector25
vector25:
  pushl $0
80106768:	6a 00                	push   $0x0
  pushl $25
8010676a:	6a 19                	push   $0x19
  jmp alltraps
8010676c:	e9 56 f9 ff ff       	jmp    801060c7 <alltraps>

80106771 <vector26>:
.globl vector26
vector26:
  pushl $0
80106771:	6a 00                	push   $0x0
  pushl $26
80106773:	6a 1a                	push   $0x1a
  jmp alltraps
80106775:	e9 4d f9 ff ff       	jmp    801060c7 <alltraps>

8010677a <vector27>:
.globl vector27
vector27:
  pushl $0
8010677a:	6a 00                	push   $0x0
  pushl $27
8010677c:	6a 1b                	push   $0x1b
  jmp alltraps
8010677e:	e9 44 f9 ff ff       	jmp    801060c7 <alltraps>

80106783 <vector28>:
.globl vector28
vector28:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $28
80106785:	6a 1c                	push   $0x1c
  jmp alltraps
80106787:	e9 3b f9 ff ff       	jmp    801060c7 <alltraps>

8010678c <vector29>:
.globl vector29
vector29:
  pushl $0
8010678c:	6a 00                	push   $0x0
  pushl $29
8010678e:	6a 1d                	push   $0x1d
  jmp alltraps
80106790:	e9 32 f9 ff ff       	jmp    801060c7 <alltraps>

80106795 <vector30>:
.globl vector30
vector30:
  pushl $0
80106795:	6a 00                	push   $0x0
  pushl $30
80106797:	6a 1e                	push   $0x1e
  jmp alltraps
80106799:	e9 29 f9 ff ff       	jmp    801060c7 <alltraps>

8010679e <vector31>:
.globl vector31
vector31:
  pushl $0
8010679e:	6a 00                	push   $0x0
  pushl $31
801067a0:	6a 1f                	push   $0x1f
  jmp alltraps
801067a2:	e9 20 f9 ff ff       	jmp    801060c7 <alltraps>

801067a7 <vector32>:
.globl vector32
vector32:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $32
801067a9:	6a 20                	push   $0x20
  jmp alltraps
801067ab:	e9 17 f9 ff ff       	jmp    801060c7 <alltraps>

801067b0 <vector33>:
.globl vector33
vector33:
  pushl $0
801067b0:	6a 00                	push   $0x0
  pushl $33
801067b2:	6a 21                	push   $0x21
  jmp alltraps
801067b4:	e9 0e f9 ff ff       	jmp    801060c7 <alltraps>

801067b9 <vector34>:
.globl vector34
vector34:
  pushl $0
801067b9:	6a 00                	push   $0x0
  pushl $34
801067bb:	6a 22                	push   $0x22
  jmp alltraps
801067bd:	e9 05 f9 ff ff       	jmp    801060c7 <alltraps>

801067c2 <vector35>:
.globl vector35
vector35:
  pushl $0
801067c2:	6a 00                	push   $0x0
  pushl $35
801067c4:	6a 23                	push   $0x23
  jmp alltraps
801067c6:	e9 fc f8 ff ff       	jmp    801060c7 <alltraps>

801067cb <vector36>:
.globl vector36
vector36:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $36
801067cd:	6a 24                	push   $0x24
  jmp alltraps
801067cf:	e9 f3 f8 ff ff       	jmp    801060c7 <alltraps>

801067d4 <vector37>:
.globl vector37
vector37:
  pushl $0
801067d4:	6a 00                	push   $0x0
  pushl $37
801067d6:	6a 25                	push   $0x25
  jmp alltraps
801067d8:	e9 ea f8 ff ff       	jmp    801060c7 <alltraps>

801067dd <vector38>:
.globl vector38
vector38:
  pushl $0
801067dd:	6a 00                	push   $0x0
  pushl $38
801067df:	6a 26                	push   $0x26
  jmp alltraps
801067e1:	e9 e1 f8 ff ff       	jmp    801060c7 <alltraps>

801067e6 <vector39>:
.globl vector39
vector39:
  pushl $0
801067e6:	6a 00                	push   $0x0
  pushl $39
801067e8:	6a 27                	push   $0x27
  jmp alltraps
801067ea:	e9 d8 f8 ff ff       	jmp    801060c7 <alltraps>

801067ef <vector40>:
.globl vector40
vector40:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $40
801067f1:	6a 28                	push   $0x28
  jmp alltraps
801067f3:	e9 cf f8 ff ff       	jmp    801060c7 <alltraps>

801067f8 <vector41>:
.globl vector41
vector41:
  pushl $0
801067f8:	6a 00                	push   $0x0
  pushl $41
801067fa:	6a 29                	push   $0x29
  jmp alltraps
801067fc:	e9 c6 f8 ff ff       	jmp    801060c7 <alltraps>

80106801 <vector42>:
.globl vector42
vector42:
  pushl $0
80106801:	6a 00                	push   $0x0
  pushl $42
80106803:	6a 2a                	push   $0x2a
  jmp alltraps
80106805:	e9 bd f8 ff ff       	jmp    801060c7 <alltraps>

8010680a <vector43>:
.globl vector43
vector43:
  pushl $0
8010680a:	6a 00                	push   $0x0
  pushl $43
8010680c:	6a 2b                	push   $0x2b
  jmp alltraps
8010680e:	e9 b4 f8 ff ff       	jmp    801060c7 <alltraps>

80106813 <vector44>:
.globl vector44
vector44:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $44
80106815:	6a 2c                	push   $0x2c
  jmp alltraps
80106817:	e9 ab f8 ff ff       	jmp    801060c7 <alltraps>

8010681c <vector45>:
.globl vector45
vector45:
  pushl $0
8010681c:	6a 00                	push   $0x0
  pushl $45
8010681e:	6a 2d                	push   $0x2d
  jmp alltraps
80106820:	e9 a2 f8 ff ff       	jmp    801060c7 <alltraps>

80106825 <vector46>:
.globl vector46
vector46:
  pushl $0
80106825:	6a 00                	push   $0x0
  pushl $46
80106827:	6a 2e                	push   $0x2e
  jmp alltraps
80106829:	e9 99 f8 ff ff       	jmp    801060c7 <alltraps>

8010682e <vector47>:
.globl vector47
vector47:
  pushl $0
8010682e:	6a 00                	push   $0x0
  pushl $47
80106830:	6a 2f                	push   $0x2f
  jmp alltraps
80106832:	e9 90 f8 ff ff       	jmp    801060c7 <alltraps>

80106837 <vector48>:
.globl vector48
vector48:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $48
80106839:	6a 30                	push   $0x30
  jmp alltraps
8010683b:	e9 87 f8 ff ff       	jmp    801060c7 <alltraps>

80106840 <vector49>:
.globl vector49
vector49:
  pushl $0
80106840:	6a 00                	push   $0x0
  pushl $49
80106842:	6a 31                	push   $0x31
  jmp alltraps
80106844:	e9 7e f8 ff ff       	jmp    801060c7 <alltraps>

80106849 <vector50>:
.globl vector50
vector50:
  pushl $0
80106849:	6a 00                	push   $0x0
  pushl $50
8010684b:	6a 32                	push   $0x32
  jmp alltraps
8010684d:	e9 75 f8 ff ff       	jmp    801060c7 <alltraps>

80106852 <vector51>:
.globl vector51
vector51:
  pushl $0
80106852:	6a 00                	push   $0x0
  pushl $51
80106854:	6a 33                	push   $0x33
  jmp alltraps
80106856:	e9 6c f8 ff ff       	jmp    801060c7 <alltraps>

8010685b <vector52>:
.globl vector52
vector52:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $52
8010685d:	6a 34                	push   $0x34
  jmp alltraps
8010685f:	e9 63 f8 ff ff       	jmp    801060c7 <alltraps>

80106864 <vector53>:
.globl vector53
vector53:
  pushl $0
80106864:	6a 00                	push   $0x0
  pushl $53
80106866:	6a 35                	push   $0x35
  jmp alltraps
80106868:	e9 5a f8 ff ff       	jmp    801060c7 <alltraps>

8010686d <vector54>:
.globl vector54
vector54:
  pushl $0
8010686d:	6a 00                	push   $0x0
  pushl $54
8010686f:	6a 36                	push   $0x36
  jmp alltraps
80106871:	e9 51 f8 ff ff       	jmp    801060c7 <alltraps>

80106876 <vector55>:
.globl vector55
vector55:
  pushl $0
80106876:	6a 00                	push   $0x0
  pushl $55
80106878:	6a 37                	push   $0x37
  jmp alltraps
8010687a:	e9 48 f8 ff ff       	jmp    801060c7 <alltraps>

8010687f <vector56>:
.globl vector56
vector56:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $56
80106881:	6a 38                	push   $0x38
  jmp alltraps
80106883:	e9 3f f8 ff ff       	jmp    801060c7 <alltraps>

80106888 <vector57>:
.globl vector57
vector57:
  pushl $0
80106888:	6a 00                	push   $0x0
  pushl $57
8010688a:	6a 39                	push   $0x39
  jmp alltraps
8010688c:	e9 36 f8 ff ff       	jmp    801060c7 <alltraps>

80106891 <vector58>:
.globl vector58
vector58:
  pushl $0
80106891:	6a 00                	push   $0x0
  pushl $58
80106893:	6a 3a                	push   $0x3a
  jmp alltraps
80106895:	e9 2d f8 ff ff       	jmp    801060c7 <alltraps>

8010689a <vector59>:
.globl vector59
vector59:
  pushl $0
8010689a:	6a 00                	push   $0x0
  pushl $59
8010689c:	6a 3b                	push   $0x3b
  jmp alltraps
8010689e:	e9 24 f8 ff ff       	jmp    801060c7 <alltraps>

801068a3 <vector60>:
.globl vector60
vector60:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $60
801068a5:	6a 3c                	push   $0x3c
  jmp alltraps
801068a7:	e9 1b f8 ff ff       	jmp    801060c7 <alltraps>

801068ac <vector61>:
.globl vector61
vector61:
  pushl $0
801068ac:	6a 00                	push   $0x0
  pushl $61
801068ae:	6a 3d                	push   $0x3d
  jmp alltraps
801068b0:	e9 12 f8 ff ff       	jmp    801060c7 <alltraps>

801068b5 <vector62>:
.globl vector62
vector62:
  pushl $0
801068b5:	6a 00                	push   $0x0
  pushl $62
801068b7:	6a 3e                	push   $0x3e
  jmp alltraps
801068b9:	e9 09 f8 ff ff       	jmp    801060c7 <alltraps>

801068be <vector63>:
.globl vector63
vector63:
  pushl $0
801068be:	6a 00                	push   $0x0
  pushl $63
801068c0:	6a 3f                	push   $0x3f
  jmp alltraps
801068c2:	e9 00 f8 ff ff       	jmp    801060c7 <alltraps>

801068c7 <vector64>:
.globl vector64
vector64:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $64
801068c9:	6a 40                	push   $0x40
  jmp alltraps
801068cb:	e9 f7 f7 ff ff       	jmp    801060c7 <alltraps>

801068d0 <vector65>:
.globl vector65
vector65:
  pushl $0
801068d0:	6a 00                	push   $0x0
  pushl $65
801068d2:	6a 41                	push   $0x41
  jmp alltraps
801068d4:	e9 ee f7 ff ff       	jmp    801060c7 <alltraps>

801068d9 <vector66>:
.globl vector66
vector66:
  pushl $0
801068d9:	6a 00                	push   $0x0
  pushl $66
801068db:	6a 42                	push   $0x42
  jmp alltraps
801068dd:	e9 e5 f7 ff ff       	jmp    801060c7 <alltraps>

801068e2 <vector67>:
.globl vector67
vector67:
  pushl $0
801068e2:	6a 00                	push   $0x0
  pushl $67
801068e4:	6a 43                	push   $0x43
  jmp alltraps
801068e6:	e9 dc f7 ff ff       	jmp    801060c7 <alltraps>

801068eb <vector68>:
.globl vector68
vector68:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $68
801068ed:	6a 44                	push   $0x44
  jmp alltraps
801068ef:	e9 d3 f7 ff ff       	jmp    801060c7 <alltraps>

801068f4 <vector69>:
.globl vector69
vector69:
  pushl $0
801068f4:	6a 00                	push   $0x0
  pushl $69
801068f6:	6a 45                	push   $0x45
  jmp alltraps
801068f8:	e9 ca f7 ff ff       	jmp    801060c7 <alltraps>

801068fd <vector70>:
.globl vector70
vector70:
  pushl $0
801068fd:	6a 00                	push   $0x0
  pushl $70
801068ff:	6a 46                	push   $0x46
  jmp alltraps
80106901:	e9 c1 f7 ff ff       	jmp    801060c7 <alltraps>

80106906 <vector71>:
.globl vector71
vector71:
  pushl $0
80106906:	6a 00                	push   $0x0
  pushl $71
80106908:	6a 47                	push   $0x47
  jmp alltraps
8010690a:	e9 b8 f7 ff ff       	jmp    801060c7 <alltraps>

8010690f <vector72>:
.globl vector72
vector72:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $72
80106911:	6a 48                	push   $0x48
  jmp alltraps
80106913:	e9 af f7 ff ff       	jmp    801060c7 <alltraps>

80106918 <vector73>:
.globl vector73
vector73:
  pushl $0
80106918:	6a 00                	push   $0x0
  pushl $73
8010691a:	6a 49                	push   $0x49
  jmp alltraps
8010691c:	e9 a6 f7 ff ff       	jmp    801060c7 <alltraps>

80106921 <vector74>:
.globl vector74
vector74:
  pushl $0
80106921:	6a 00                	push   $0x0
  pushl $74
80106923:	6a 4a                	push   $0x4a
  jmp alltraps
80106925:	e9 9d f7 ff ff       	jmp    801060c7 <alltraps>

8010692a <vector75>:
.globl vector75
vector75:
  pushl $0
8010692a:	6a 00                	push   $0x0
  pushl $75
8010692c:	6a 4b                	push   $0x4b
  jmp alltraps
8010692e:	e9 94 f7 ff ff       	jmp    801060c7 <alltraps>

80106933 <vector76>:
.globl vector76
vector76:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $76
80106935:	6a 4c                	push   $0x4c
  jmp alltraps
80106937:	e9 8b f7 ff ff       	jmp    801060c7 <alltraps>

8010693c <vector77>:
.globl vector77
vector77:
  pushl $0
8010693c:	6a 00                	push   $0x0
  pushl $77
8010693e:	6a 4d                	push   $0x4d
  jmp alltraps
80106940:	e9 82 f7 ff ff       	jmp    801060c7 <alltraps>

80106945 <vector78>:
.globl vector78
vector78:
  pushl $0
80106945:	6a 00                	push   $0x0
  pushl $78
80106947:	6a 4e                	push   $0x4e
  jmp alltraps
80106949:	e9 79 f7 ff ff       	jmp    801060c7 <alltraps>

8010694e <vector79>:
.globl vector79
vector79:
  pushl $0
8010694e:	6a 00                	push   $0x0
  pushl $79
80106950:	6a 4f                	push   $0x4f
  jmp alltraps
80106952:	e9 70 f7 ff ff       	jmp    801060c7 <alltraps>

80106957 <vector80>:
.globl vector80
vector80:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $80
80106959:	6a 50                	push   $0x50
  jmp alltraps
8010695b:	e9 67 f7 ff ff       	jmp    801060c7 <alltraps>

80106960 <vector81>:
.globl vector81
vector81:
  pushl $0
80106960:	6a 00                	push   $0x0
  pushl $81
80106962:	6a 51                	push   $0x51
  jmp alltraps
80106964:	e9 5e f7 ff ff       	jmp    801060c7 <alltraps>

80106969 <vector82>:
.globl vector82
vector82:
  pushl $0
80106969:	6a 00                	push   $0x0
  pushl $82
8010696b:	6a 52                	push   $0x52
  jmp alltraps
8010696d:	e9 55 f7 ff ff       	jmp    801060c7 <alltraps>

80106972 <vector83>:
.globl vector83
vector83:
  pushl $0
80106972:	6a 00                	push   $0x0
  pushl $83
80106974:	6a 53                	push   $0x53
  jmp alltraps
80106976:	e9 4c f7 ff ff       	jmp    801060c7 <alltraps>

8010697b <vector84>:
.globl vector84
vector84:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $84
8010697d:	6a 54                	push   $0x54
  jmp alltraps
8010697f:	e9 43 f7 ff ff       	jmp    801060c7 <alltraps>

80106984 <vector85>:
.globl vector85
vector85:
  pushl $0
80106984:	6a 00                	push   $0x0
  pushl $85
80106986:	6a 55                	push   $0x55
  jmp alltraps
80106988:	e9 3a f7 ff ff       	jmp    801060c7 <alltraps>

8010698d <vector86>:
.globl vector86
vector86:
  pushl $0
8010698d:	6a 00                	push   $0x0
  pushl $86
8010698f:	6a 56                	push   $0x56
  jmp alltraps
80106991:	e9 31 f7 ff ff       	jmp    801060c7 <alltraps>

80106996 <vector87>:
.globl vector87
vector87:
  pushl $0
80106996:	6a 00                	push   $0x0
  pushl $87
80106998:	6a 57                	push   $0x57
  jmp alltraps
8010699a:	e9 28 f7 ff ff       	jmp    801060c7 <alltraps>

8010699f <vector88>:
.globl vector88
vector88:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $88
801069a1:	6a 58                	push   $0x58
  jmp alltraps
801069a3:	e9 1f f7 ff ff       	jmp    801060c7 <alltraps>

801069a8 <vector89>:
.globl vector89
vector89:
  pushl $0
801069a8:	6a 00                	push   $0x0
  pushl $89
801069aa:	6a 59                	push   $0x59
  jmp alltraps
801069ac:	e9 16 f7 ff ff       	jmp    801060c7 <alltraps>

801069b1 <vector90>:
.globl vector90
vector90:
  pushl $0
801069b1:	6a 00                	push   $0x0
  pushl $90
801069b3:	6a 5a                	push   $0x5a
  jmp alltraps
801069b5:	e9 0d f7 ff ff       	jmp    801060c7 <alltraps>

801069ba <vector91>:
.globl vector91
vector91:
  pushl $0
801069ba:	6a 00                	push   $0x0
  pushl $91
801069bc:	6a 5b                	push   $0x5b
  jmp alltraps
801069be:	e9 04 f7 ff ff       	jmp    801060c7 <alltraps>

801069c3 <vector92>:
.globl vector92
vector92:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $92
801069c5:	6a 5c                	push   $0x5c
  jmp alltraps
801069c7:	e9 fb f6 ff ff       	jmp    801060c7 <alltraps>

801069cc <vector93>:
.globl vector93
vector93:
  pushl $0
801069cc:	6a 00                	push   $0x0
  pushl $93
801069ce:	6a 5d                	push   $0x5d
  jmp alltraps
801069d0:	e9 f2 f6 ff ff       	jmp    801060c7 <alltraps>

801069d5 <vector94>:
.globl vector94
vector94:
  pushl $0
801069d5:	6a 00                	push   $0x0
  pushl $94
801069d7:	6a 5e                	push   $0x5e
  jmp alltraps
801069d9:	e9 e9 f6 ff ff       	jmp    801060c7 <alltraps>

801069de <vector95>:
.globl vector95
vector95:
  pushl $0
801069de:	6a 00                	push   $0x0
  pushl $95
801069e0:	6a 5f                	push   $0x5f
  jmp alltraps
801069e2:	e9 e0 f6 ff ff       	jmp    801060c7 <alltraps>

801069e7 <vector96>:
.globl vector96
vector96:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $96
801069e9:	6a 60                	push   $0x60
  jmp alltraps
801069eb:	e9 d7 f6 ff ff       	jmp    801060c7 <alltraps>

801069f0 <vector97>:
.globl vector97
vector97:
  pushl $0
801069f0:	6a 00                	push   $0x0
  pushl $97
801069f2:	6a 61                	push   $0x61
  jmp alltraps
801069f4:	e9 ce f6 ff ff       	jmp    801060c7 <alltraps>

801069f9 <vector98>:
.globl vector98
vector98:
  pushl $0
801069f9:	6a 00                	push   $0x0
  pushl $98
801069fb:	6a 62                	push   $0x62
  jmp alltraps
801069fd:	e9 c5 f6 ff ff       	jmp    801060c7 <alltraps>

80106a02 <vector99>:
.globl vector99
vector99:
  pushl $0
80106a02:	6a 00                	push   $0x0
  pushl $99
80106a04:	6a 63                	push   $0x63
  jmp alltraps
80106a06:	e9 bc f6 ff ff       	jmp    801060c7 <alltraps>

80106a0b <vector100>:
.globl vector100
vector100:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $100
80106a0d:	6a 64                	push   $0x64
  jmp alltraps
80106a0f:	e9 b3 f6 ff ff       	jmp    801060c7 <alltraps>

80106a14 <vector101>:
.globl vector101
vector101:
  pushl $0
80106a14:	6a 00                	push   $0x0
  pushl $101
80106a16:	6a 65                	push   $0x65
  jmp alltraps
80106a18:	e9 aa f6 ff ff       	jmp    801060c7 <alltraps>

80106a1d <vector102>:
.globl vector102
vector102:
  pushl $0
80106a1d:	6a 00                	push   $0x0
  pushl $102
80106a1f:	6a 66                	push   $0x66
  jmp alltraps
80106a21:	e9 a1 f6 ff ff       	jmp    801060c7 <alltraps>

80106a26 <vector103>:
.globl vector103
vector103:
  pushl $0
80106a26:	6a 00                	push   $0x0
  pushl $103
80106a28:	6a 67                	push   $0x67
  jmp alltraps
80106a2a:	e9 98 f6 ff ff       	jmp    801060c7 <alltraps>

80106a2f <vector104>:
.globl vector104
vector104:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $104
80106a31:	6a 68                	push   $0x68
  jmp alltraps
80106a33:	e9 8f f6 ff ff       	jmp    801060c7 <alltraps>

80106a38 <vector105>:
.globl vector105
vector105:
  pushl $0
80106a38:	6a 00                	push   $0x0
  pushl $105
80106a3a:	6a 69                	push   $0x69
  jmp alltraps
80106a3c:	e9 86 f6 ff ff       	jmp    801060c7 <alltraps>

80106a41 <vector106>:
.globl vector106
vector106:
  pushl $0
80106a41:	6a 00                	push   $0x0
  pushl $106
80106a43:	6a 6a                	push   $0x6a
  jmp alltraps
80106a45:	e9 7d f6 ff ff       	jmp    801060c7 <alltraps>

80106a4a <vector107>:
.globl vector107
vector107:
  pushl $0
80106a4a:	6a 00                	push   $0x0
  pushl $107
80106a4c:	6a 6b                	push   $0x6b
  jmp alltraps
80106a4e:	e9 74 f6 ff ff       	jmp    801060c7 <alltraps>

80106a53 <vector108>:
.globl vector108
vector108:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $108
80106a55:	6a 6c                	push   $0x6c
  jmp alltraps
80106a57:	e9 6b f6 ff ff       	jmp    801060c7 <alltraps>

80106a5c <vector109>:
.globl vector109
vector109:
  pushl $0
80106a5c:	6a 00                	push   $0x0
  pushl $109
80106a5e:	6a 6d                	push   $0x6d
  jmp alltraps
80106a60:	e9 62 f6 ff ff       	jmp    801060c7 <alltraps>

80106a65 <vector110>:
.globl vector110
vector110:
  pushl $0
80106a65:	6a 00                	push   $0x0
  pushl $110
80106a67:	6a 6e                	push   $0x6e
  jmp alltraps
80106a69:	e9 59 f6 ff ff       	jmp    801060c7 <alltraps>

80106a6e <vector111>:
.globl vector111
vector111:
  pushl $0
80106a6e:	6a 00                	push   $0x0
  pushl $111
80106a70:	6a 6f                	push   $0x6f
  jmp alltraps
80106a72:	e9 50 f6 ff ff       	jmp    801060c7 <alltraps>

80106a77 <vector112>:
.globl vector112
vector112:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $112
80106a79:	6a 70                	push   $0x70
  jmp alltraps
80106a7b:	e9 47 f6 ff ff       	jmp    801060c7 <alltraps>

80106a80 <vector113>:
.globl vector113
vector113:
  pushl $0
80106a80:	6a 00                	push   $0x0
  pushl $113
80106a82:	6a 71                	push   $0x71
  jmp alltraps
80106a84:	e9 3e f6 ff ff       	jmp    801060c7 <alltraps>

80106a89 <vector114>:
.globl vector114
vector114:
  pushl $0
80106a89:	6a 00                	push   $0x0
  pushl $114
80106a8b:	6a 72                	push   $0x72
  jmp alltraps
80106a8d:	e9 35 f6 ff ff       	jmp    801060c7 <alltraps>

80106a92 <vector115>:
.globl vector115
vector115:
  pushl $0
80106a92:	6a 00                	push   $0x0
  pushl $115
80106a94:	6a 73                	push   $0x73
  jmp alltraps
80106a96:	e9 2c f6 ff ff       	jmp    801060c7 <alltraps>

80106a9b <vector116>:
.globl vector116
vector116:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $116
80106a9d:	6a 74                	push   $0x74
  jmp alltraps
80106a9f:	e9 23 f6 ff ff       	jmp    801060c7 <alltraps>

80106aa4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106aa4:	6a 00                	push   $0x0
  pushl $117
80106aa6:	6a 75                	push   $0x75
  jmp alltraps
80106aa8:	e9 1a f6 ff ff       	jmp    801060c7 <alltraps>

80106aad <vector118>:
.globl vector118
vector118:
  pushl $0
80106aad:	6a 00                	push   $0x0
  pushl $118
80106aaf:	6a 76                	push   $0x76
  jmp alltraps
80106ab1:	e9 11 f6 ff ff       	jmp    801060c7 <alltraps>

80106ab6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ab6:	6a 00                	push   $0x0
  pushl $119
80106ab8:	6a 77                	push   $0x77
  jmp alltraps
80106aba:	e9 08 f6 ff ff       	jmp    801060c7 <alltraps>

80106abf <vector120>:
.globl vector120
vector120:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $120
80106ac1:	6a 78                	push   $0x78
  jmp alltraps
80106ac3:	e9 ff f5 ff ff       	jmp    801060c7 <alltraps>

80106ac8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ac8:	6a 00                	push   $0x0
  pushl $121
80106aca:	6a 79                	push   $0x79
  jmp alltraps
80106acc:	e9 f6 f5 ff ff       	jmp    801060c7 <alltraps>

80106ad1 <vector122>:
.globl vector122
vector122:
  pushl $0
80106ad1:	6a 00                	push   $0x0
  pushl $122
80106ad3:	6a 7a                	push   $0x7a
  jmp alltraps
80106ad5:	e9 ed f5 ff ff       	jmp    801060c7 <alltraps>

80106ada <vector123>:
.globl vector123
vector123:
  pushl $0
80106ada:	6a 00                	push   $0x0
  pushl $123
80106adc:	6a 7b                	push   $0x7b
  jmp alltraps
80106ade:	e9 e4 f5 ff ff       	jmp    801060c7 <alltraps>

80106ae3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $124
80106ae5:	6a 7c                	push   $0x7c
  jmp alltraps
80106ae7:	e9 db f5 ff ff       	jmp    801060c7 <alltraps>

80106aec <vector125>:
.globl vector125
vector125:
  pushl $0
80106aec:	6a 00                	push   $0x0
  pushl $125
80106aee:	6a 7d                	push   $0x7d
  jmp alltraps
80106af0:	e9 d2 f5 ff ff       	jmp    801060c7 <alltraps>

80106af5 <vector126>:
.globl vector126
vector126:
  pushl $0
80106af5:	6a 00                	push   $0x0
  pushl $126
80106af7:	6a 7e                	push   $0x7e
  jmp alltraps
80106af9:	e9 c9 f5 ff ff       	jmp    801060c7 <alltraps>

80106afe <vector127>:
.globl vector127
vector127:
  pushl $0
80106afe:	6a 00                	push   $0x0
  pushl $127
80106b00:	6a 7f                	push   $0x7f
  jmp alltraps
80106b02:	e9 c0 f5 ff ff       	jmp    801060c7 <alltraps>

80106b07 <vector128>:
.globl vector128
vector128:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $128
80106b09:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106b0e:	e9 b4 f5 ff ff       	jmp    801060c7 <alltraps>

80106b13 <vector129>:
.globl vector129
vector129:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $129
80106b15:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106b1a:	e9 a8 f5 ff ff       	jmp    801060c7 <alltraps>

80106b1f <vector130>:
.globl vector130
vector130:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $130
80106b21:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106b26:	e9 9c f5 ff ff       	jmp    801060c7 <alltraps>

80106b2b <vector131>:
.globl vector131
vector131:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $131
80106b2d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106b32:	e9 90 f5 ff ff       	jmp    801060c7 <alltraps>

80106b37 <vector132>:
.globl vector132
vector132:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $132
80106b39:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106b3e:	e9 84 f5 ff ff       	jmp    801060c7 <alltraps>

80106b43 <vector133>:
.globl vector133
vector133:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $133
80106b45:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106b4a:	e9 78 f5 ff ff       	jmp    801060c7 <alltraps>

80106b4f <vector134>:
.globl vector134
vector134:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $134
80106b51:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106b56:	e9 6c f5 ff ff       	jmp    801060c7 <alltraps>

80106b5b <vector135>:
.globl vector135
vector135:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $135
80106b5d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106b62:	e9 60 f5 ff ff       	jmp    801060c7 <alltraps>

80106b67 <vector136>:
.globl vector136
vector136:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $136
80106b69:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106b6e:	e9 54 f5 ff ff       	jmp    801060c7 <alltraps>

80106b73 <vector137>:
.globl vector137
vector137:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $137
80106b75:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106b7a:	e9 48 f5 ff ff       	jmp    801060c7 <alltraps>

80106b7f <vector138>:
.globl vector138
vector138:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $138
80106b81:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106b86:	e9 3c f5 ff ff       	jmp    801060c7 <alltraps>

80106b8b <vector139>:
.globl vector139
vector139:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $139
80106b8d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106b92:	e9 30 f5 ff ff       	jmp    801060c7 <alltraps>

80106b97 <vector140>:
.globl vector140
vector140:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $140
80106b99:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106b9e:	e9 24 f5 ff ff       	jmp    801060c7 <alltraps>

80106ba3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $141
80106ba5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106baa:	e9 18 f5 ff ff       	jmp    801060c7 <alltraps>

80106baf <vector142>:
.globl vector142
vector142:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $142
80106bb1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106bb6:	e9 0c f5 ff ff       	jmp    801060c7 <alltraps>

80106bbb <vector143>:
.globl vector143
vector143:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $143
80106bbd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106bc2:	e9 00 f5 ff ff       	jmp    801060c7 <alltraps>

80106bc7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $144
80106bc9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106bce:	e9 f4 f4 ff ff       	jmp    801060c7 <alltraps>

80106bd3 <vector145>:
.globl vector145
vector145:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $145
80106bd5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106bda:	e9 e8 f4 ff ff       	jmp    801060c7 <alltraps>

80106bdf <vector146>:
.globl vector146
vector146:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $146
80106be1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106be6:	e9 dc f4 ff ff       	jmp    801060c7 <alltraps>

80106beb <vector147>:
.globl vector147
vector147:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $147
80106bed:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106bf2:	e9 d0 f4 ff ff       	jmp    801060c7 <alltraps>

80106bf7 <vector148>:
.globl vector148
vector148:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $148
80106bf9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106bfe:	e9 c4 f4 ff ff       	jmp    801060c7 <alltraps>

80106c03 <vector149>:
.globl vector149
vector149:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $149
80106c05:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106c0a:	e9 b8 f4 ff ff       	jmp    801060c7 <alltraps>

80106c0f <vector150>:
.globl vector150
vector150:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $150
80106c11:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106c16:	e9 ac f4 ff ff       	jmp    801060c7 <alltraps>

80106c1b <vector151>:
.globl vector151
vector151:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $151
80106c1d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106c22:	e9 a0 f4 ff ff       	jmp    801060c7 <alltraps>

80106c27 <vector152>:
.globl vector152
vector152:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $152
80106c29:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106c2e:	e9 94 f4 ff ff       	jmp    801060c7 <alltraps>

80106c33 <vector153>:
.globl vector153
vector153:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $153
80106c35:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106c3a:	e9 88 f4 ff ff       	jmp    801060c7 <alltraps>

80106c3f <vector154>:
.globl vector154
vector154:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $154
80106c41:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106c46:	e9 7c f4 ff ff       	jmp    801060c7 <alltraps>

80106c4b <vector155>:
.globl vector155
vector155:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $155
80106c4d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106c52:	e9 70 f4 ff ff       	jmp    801060c7 <alltraps>

80106c57 <vector156>:
.globl vector156
vector156:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $156
80106c59:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106c5e:	e9 64 f4 ff ff       	jmp    801060c7 <alltraps>

80106c63 <vector157>:
.globl vector157
vector157:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $157
80106c65:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106c6a:	e9 58 f4 ff ff       	jmp    801060c7 <alltraps>

80106c6f <vector158>:
.globl vector158
vector158:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $158
80106c71:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106c76:	e9 4c f4 ff ff       	jmp    801060c7 <alltraps>

80106c7b <vector159>:
.globl vector159
vector159:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $159
80106c7d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106c82:	e9 40 f4 ff ff       	jmp    801060c7 <alltraps>

80106c87 <vector160>:
.globl vector160
vector160:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $160
80106c89:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106c8e:	e9 34 f4 ff ff       	jmp    801060c7 <alltraps>

80106c93 <vector161>:
.globl vector161
vector161:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $161
80106c95:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106c9a:	e9 28 f4 ff ff       	jmp    801060c7 <alltraps>

80106c9f <vector162>:
.globl vector162
vector162:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $162
80106ca1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106ca6:	e9 1c f4 ff ff       	jmp    801060c7 <alltraps>

80106cab <vector163>:
.globl vector163
vector163:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $163
80106cad:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106cb2:	e9 10 f4 ff ff       	jmp    801060c7 <alltraps>

80106cb7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $164
80106cb9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106cbe:	e9 04 f4 ff ff       	jmp    801060c7 <alltraps>

80106cc3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $165
80106cc5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106cca:	e9 f8 f3 ff ff       	jmp    801060c7 <alltraps>

80106ccf <vector166>:
.globl vector166
vector166:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $166
80106cd1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106cd6:	e9 ec f3 ff ff       	jmp    801060c7 <alltraps>

80106cdb <vector167>:
.globl vector167
vector167:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $167
80106cdd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ce2:	e9 e0 f3 ff ff       	jmp    801060c7 <alltraps>

80106ce7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $168
80106ce9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106cee:	e9 d4 f3 ff ff       	jmp    801060c7 <alltraps>

80106cf3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $169
80106cf5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106cfa:	e9 c8 f3 ff ff       	jmp    801060c7 <alltraps>

80106cff <vector170>:
.globl vector170
vector170:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $170
80106d01:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106d06:	e9 bc f3 ff ff       	jmp    801060c7 <alltraps>

80106d0b <vector171>:
.globl vector171
vector171:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $171
80106d0d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106d12:	e9 b0 f3 ff ff       	jmp    801060c7 <alltraps>

80106d17 <vector172>:
.globl vector172
vector172:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $172
80106d19:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106d1e:	e9 a4 f3 ff ff       	jmp    801060c7 <alltraps>

80106d23 <vector173>:
.globl vector173
vector173:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $173
80106d25:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106d2a:	e9 98 f3 ff ff       	jmp    801060c7 <alltraps>

80106d2f <vector174>:
.globl vector174
vector174:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $174
80106d31:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106d36:	e9 8c f3 ff ff       	jmp    801060c7 <alltraps>

80106d3b <vector175>:
.globl vector175
vector175:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $175
80106d3d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106d42:	e9 80 f3 ff ff       	jmp    801060c7 <alltraps>

80106d47 <vector176>:
.globl vector176
vector176:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $176
80106d49:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106d4e:	e9 74 f3 ff ff       	jmp    801060c7 <alltraps>

80106d53 <vector177>:
.globl vector177
vector177:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $177
80106d55:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106d5a:	e9 68 f3 ff ff       	jmp    801060c7 <alltraps>

80106d5f <vector178>:
.globl vector178
vector178:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $178
80106d61:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106d66:	e9 5c f3 ff ff       	jmp    801060c7 <alltraps>

80106d6b <vector179>:
.globl vector179
vector179:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $179
80106d6d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106d72:	e9 50 f3 ff ff       	jmp    801060c7 <alltraps>

80106d77 <vector180>:
.globl vector180
vector180:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $180
80106d79:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106d7e:	e9 44 f3 ff ff       	jmp    801060c7 <alltraps>

80106d83 <vector181>:
.globl vector181
vector181:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $181
80106d85:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106d8a:	e9 38 f3 ff ff       	jmp    801060c7 <alltraps>

80106d8f <vector182>:
.globl vector182
vector182:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $182
80106d91:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106d96:	e9 2c f3 ff ff       	jmp    801060c7 <alltraps>

80106d9b <vector183>:
.globl vector183
vector183:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $183
80106d9d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106da2:	e9 20 f3 ff ff       	jmp    801060c7 <alltraps>

80106da7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $184
80106da9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106dae:	e9 14 f3 ff ff       	jmp    801060c7 <alltraps>

80106db3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $185
80106db5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106dba:	e9 08 f3 ff ff       	jmp    801060c7 <alltraps>

80106dbf <vector186>:
.globl vector186
vector186:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $186
80106dc1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106dc6:	e9 fc f2 ff ff       	jmp    801060c7 <alltraps>

80106dcb <vector187>:
.globl vector187
vector187:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $187
80106dcd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106dd2:	e9 f0 f2 ff ff       	jmp    801060c7 <alltraps>

80106dd7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $188
80106dd9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106dde:	e9 e4 f2 ff ff       	jmp    801060c7 <alltraps>

80106de3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $189
80106de5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106dea:	e9 d8 f2 ff ff       	jmp    801060c7 <alltraps>

80106def <vector190>:
.globl vector190
vector190:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $190
80106df1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106df6:	e9 cc f2 ff ff       	jmp    801060c7 <alltraps>

80106dfb <vector191>:
.globl vector191
vector191:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $191
80106dfd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106e02:	e9 c0 f2 ff ff       	jmp    801060c7 <alltraps>

80106e07 <vector192>:
.globl vector192
vector192:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $192
80106e09:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106e0e:	e9 b4 f2 ff ff       	jmp    801060c7 <alltraps>

80106e13 <vector193>:
.globl vector193
vector193:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $193
80106e15:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106e1a:	e9 a8 f2 ff ff       	jmp    801060c7 <alltraps>

80106e1f <vector194>:
.globl vector194
vector194:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $194
80106e21:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106e26:	e9 9c f2 ff ff       	jmp    801060c7 <alltraps>

80106e2b <vector195>:
.globl vector195
vector195:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $195
80106e2d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106e32:	e9 90 f2 ff ff       	jmp    801060c7 <alltraps>

80106e37 <vector196>:
.globl vector196
vector196:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $196
80106e39:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106e3e:	e9 84 f2 ff ff       	jmp    801060c7 <alltraps>

80106e43 <vector197>:
.globl vector197
vector197:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $197
80106e45:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106e4a:	e9 78 f2 ff ff       	jmp    801060c7 <alltraps>

80106e4f <vector198>:
.globl vector198
vector198:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $198
80106e51:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106e56:	e9 6c f2 ff ff       	jmp    801060c7 <alltraps>

80106e5b <vector199>:
.globl vector199
vector199:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $199
80106e5d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106e62:	e9 60 f2 ff ff       	jmp    801060c7 <alltraps>

80106e67 <vector200>:
.globl vector200
vector200:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $200
80106e69:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106e6e:	e9 54 f2 ff ff       	jmp    801060c7 <alltraps>

80106e73 <vector201>:
.globl vector201
vector201:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $201
80106e75:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106e7a:	e9 48 f2 ff ff       	jmp    801060c7 <alltraps>

80106e7f <vector202>:
.globl vector202
vector202:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $202
80106e81:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106e86:	e9 3c f2 ff ff       	jmp    801060c7 <alltraps>

80106e8b <vector203>:
.globl vector203
vector203:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $203
80106e8d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106e92:	e9 30 f2 ff ff       	jmp    801060c7 <alltraps>

80106e97 <vector204>:
.globl vector204
vector204:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $204
80106e99:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106e9e:	e9 24 f2 ff ff       	jmp    801060c7 <alltraps>

80106ea3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $205
80106ea5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106eaa:	e9 18 f2 ff ff       	jmp    801060c7 <alltraps>

80106eaf <vector206>:
.globl vector206
vector206:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $206
80106eb1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106eb6:	e9 0c f2 ff ff       	jmp    801060c7 <alltraps>

80106ebb <vector207>:
.globl vector207
vector207:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $207
80106ebd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106ec2:	e9 00 f2 ff ff       	jmp    801060c7 <alltraps>

80106ec7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $208
80106ec9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106ece:	e9 f4 f1 ff ff       	jmp    801060c7 <alltraps>

80106ed3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $209
80106ed5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106eda:	e9 e8 f1 ff ff       	jmp    801060c7 <alltraps>

80106edf <vector210>:
.globl vector210
vector210:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $210
80106ee1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106ee6:	e9 dc f1 ff ff       	jmp    801060c7 <alltraps>

80106eeb <vector211>:
.globl vector211
vector211:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $211
80106eed:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106ef2:	e9 d0 f1 ff ff       	jmp    801060c7 <alltraps>

80106ef7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $212
80106ef9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106efe:	e9 c4 f1 ff ff       	jmp    801060c7 <alltraps>

80106f03 <vector213>:
.globl vector213
vector213:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $213
80106f05:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106f0a:	e9 b8 f1 ff ff       	jmp    801060c7 <alltraps>

80106f0f <vector214>:
.globl vector214
vector214:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $214
80106f11:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106f16:	e9 ac f1 ff ff       	jmp    801060c7 <alltraps>

80106f1b <vector215>:
.globl vector215
vector215:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $215
80106f1d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106f22:	e9 a0 f1 ff ff       	jmp    801060c7 <alltraps>

80106f27 <vector216>:
.globl vector216
vector216:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $216
80106f29:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106f2e:	e9 94 f1 ff ff       	jmp    801060c7 <alltraps>

80106f33 <vector217>:
.globl vector217
vector217:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $217
80106f35:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106f3a:	e9 88 f1 ff ff       	jmp    801060c7 <alltraps>

80106f3f <vector218>:
.globl vector218
vector218:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $218
80106f41:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106f46:	e9 7c f1 ff ff       	jmp    801060c7 <alltraps>

80106f4b <vector219>:
.globl vector219
vector219:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $219
80106f4d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106f52:	e9 70 f1 ff ff       	jmp    801060c7 <alltraps>

80106f57 <vector220>:
.globl vector220
vector220:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $220
80106f59:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106f5e:	e9 64 f1 ff ff       	jmp    801060c7 <alltraps>

80106f63 <vector221>:
.globl vector221
vector221:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $221
80106f65:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106f6a:	e9 58 f1 ff ff       	jmp    801060c7 <alltraps>

80106f6f <vector222>:
.globl vector222
vector222:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $222
80106f71:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106f76:	e9 4c f1 ff ff       	jmp    801060c7 <alltraps>

80106f7b <vector223>:
.globl vector223
vector223:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $223
80106f7d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106f82:	e9 40 f1 ff ff       	jmp    801060c7 <alltraps>

80106f87 <vector224>:
.globl vector224
vector224:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $224
80106f89:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106f8e:	e9 34 f1 ff ff       	jmp    801060c7 <alltraps>

80106f93 <vector225>:
.globl vector225
vector225:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $225
80106f95:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106f9a:	e9 28 f1 ff ff       	jmp    801060c7 <alltraps>

80106f9f <vector226>:
.globl vector226
vector226:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $226
80106fa1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106fa6:	e9 1c f1 ff ff       	jmp    801060c7 <alltraps>

80106fab <vector227>:
.globl vector227
vector227:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $227
80106fad:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106fb2:	e9 10 f1 ff ff       	jmp    801060c7 <alltraps>

80106fb7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $228
80106fb9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106fbe:	e9 04 f1 ff ff       	jmp    801060c7 <alltraps>

80106fc3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $229
80106fc5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106fca:	e9 f8 f0 ff ff       	jmp    801060c7 <alltraps>

80106fcf <vector230>:
.globl vector230
vector230:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $230
80106fd1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106fd6:	e9 ec f0 ff ff       	jmp    801060c7 <alltraps>

80106fdb <vector231>:
.globl vector231
vector231:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $231
80106fdd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106fe2:	e9 e0 f0 ff ff       	jmp    801060c7 <alltraps>

80106fe7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $232
80106fe9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106fee:	e9 d4 f0 ff ff       	jmp    801060c7 <alltraps>

80106ff3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $233
80106ff5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106ffa:	e9 c8 f0 ff ff       	jmp    801060c7 <alltraps>

80106fff <vector234>:
.globl vector234
vector234:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $234
80107001:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107006:	e9 bc f0 ff ff       	jmp    801060c7 <alltraps>

8010700b <vector235>:
.globl vector235
vector235:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $235
8010700d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107012:	e9 b0 f0 ff ff       	jmp    801060c7 <alltraps>

80107017 <vector236>:
.globl vector236
vector236:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $236
80107019:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010701e:	e9 a4 f0 ff ff       	jmp    801060c7 <alltraps>

80107023 <vector237>:
.globl vector237
vector237:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $237
80107025:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010702a:	e9 98 f0 ff ff       	jmp    801060c7 <alltraps>

8010702f <vector238>:
.globl vector238
vector238:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $238
80107031:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107036:	e9 8c f0 ff ff       	jmp    801060c7 <alltraps>

8010703b <vector239>:
.globl vector239
vector239:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $239
8010703d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107042:	e9 80 f0 ff ff       	jmp    801060c7 <alltraps>

80107047 <vector240>:
.globl vector240
vector240:
  pushl $0
80107047:	6a 00                	push   $0x0
  pushl $240
80107049:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010704e:	e9 74 f0 ff ff       	jmp    801060c7 <alltraps>

80107053 <vector241>:
.globl vector241
vector241:
  pushl $0
80107053:	6a 00                	push   $0x0
  pushl $241
80107055:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010705a:	e9 68 f0 ff ff       	jmp    801060c7 <alltraps>

8010705f <vector242>:
.globl vector242
vector242:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $242
80107061:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107066:	e9 5c f0 ff ff       	jmp    801060c7 <alltraps>

8010706b <vector243>:
.globl vector243
vector243:
  pushl $0
8010706b:	6a 00                	push   $0x0
  pushl $243
8010706d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107072:	e9 50 f0 ff ff       	jmp    801060c7 <alltraps>

80107077 <vector244>:
.globl vector244
vector244:
  pushl $0
80107077:	6a 00                	push   $0x0
  pushl $244
80107079:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010707e:	e9 44 f0 ff ff       	jmp    801060c7 <alltraps>

80107083 <vector245>:
.globl vector245
vector245:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $245
80107085:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010708a:	e9 38 f0 ff ff       	jmp    801060c7 <alltraps>

8010708f <vector246>:
.globl vector246
vector246:
  pushl $0
8010708f:	6a 00                	push   $0x0
  pushl $246
80107091:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107096:	e9 2c f0 ff ff       	jmp    801060c7 <alltraps>

8010709b <vector247>:
.globl vector247
vector247:
  pushl $0
8010709b:	6a 00                	push   $0x0
  pushl $247
8010709d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801070a2:	e9 20 f0 ff ff       	jmp    801060c7 <alltraps>

801070a7 <vector248>:
.globl vector248
vector248:
  pushl $0
801070a7:	6a 00                	push   $0x0
  pushl $248
801070a9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801070ae:	e9 14 f0 ff ff       	jmp    801060c7 <alltraps>

801070b3 <vector249>:
.globl vector249
vector249:
  pushl $0
801070b3:	6a 00                	push   $0x0
  pushl $249
801070b5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801070ba:	e9 08 f0 ff ff       	jmp    801060c7 <alltraps>

801070bf <vector250>:
.globl vector250
vector250:
  pushl $0
801070bf:	6a 00                	push   $0x0
  pushl $250
801070c1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801070c6:	e9 fc ef ff ff       	jmp    801060c7 <alltraps>

801070cb <vector251>:
.globl vector251
vector251:
  pushl $0
801070cb:	6a 00                	push   $0x0
  pushl $251
801070cd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801070d2:	e9 f0 ef ff ff       	jmp    801060c7 <alltraps>

801070d7 <vector252>:
.globl vector252
vector252:
  pushl $0
801070d7:	6a 00                	push   $0x0
  pushl $252
801070d9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801070de:	e9 e4 ef ff ff       	jmp    801060c7 <alltraps>

801070e3 <vector253>:
.globl vector253
vector253:
  pushl $0
801070e3:	6a 00                	push   $0x0
  pushl $253
801070e5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801070ea:	e9 d8 ef ff ff       	jmp    801060c7 <alltraps>

801070ef <vector254>:
.globl vector254
vector254:
  pushl $0
801070ef:	6a 00                	push   $0x0
  pushl $254
801070f1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801070f6:	e9 cc ef ff ff       	jmp    801060c7 <alltraps>

801070fb <vector255>:
.globl vector255
vector255:
  pushl $0
801070fb:	6a 00                	push   $0x0
  pushl $255
801070fd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107102:	e9 c0 ef ff ff       	jmp    801060c7 <alltraps>
80107107:	66 90                	xchg   %ax,%ax
80107109:	66 90                	xchg   %ax,%ax
8010710b:	66 90                	xchg   %ax,%ax
8010710d:	66 90                	xchg   %ax,%ax
8010710f:	90                   	nop

80107110 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	57                   	push   %edi
80107114:	56                   	push   %esi
80107115:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107116:	89 d3                	mov    %edx,%ebx
{
80107118:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010711a:	c1 eb 16             	shr    $0x16,%ebx
8010711d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107120:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107123:	8b 06                	mov    (%esi),%eax
80107125:	a8 01                	test   $0x1,%al
80107127:	74 27                	je     80107150 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010712e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107134:	c1 ef 0a             	shr    $0xa,%edi
}
80107137:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010713a:	89 fa                	mov    %edi,%edx
8010713c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107142:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107145:	5b                   	pop    %ebx
80107146:	5e                   	pop    %esi
80107147:	5f                   	pop    %edi
80107148:	5d                   	pop    %ebp
80107149:	c3                   	ret    
8010714a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107150:	85 c9                	test   %ecx,%ecx
80107152:	74 2c                	je     80107180 <walkpgdir+0x70>
80107154:	e8 47 b4 ff ff       	call   801025a0 <kalloc>
80107159:	85 c0                	test   %eax,%eax
8010715b:	89 c3                	mov    %eax,%ebx
8010715d:	74 21                	je     80107180 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010715f:	83 ec 04             	sub    $0x4,%esp
80107162:	68 00 10 00 00       	push   $0x1000
80107167:	6a 00                	push   $0x0
80107169:	50                   	push   %eax
8010716a:	e8 f1 db ff ff       	call   80104d60 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010716f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107175:	83 c4 10             	add    $0x10,%esp
80107178:	83 c8 07             	or     $0x7,%eax
8010717b:	89 06                	mov    %eax,(%esi)
8010717d:	eb b5                	jmp    80107134 <walkpgdir+0x24>
8010717f:	90                   	nop
}
80107180:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107183:	31 c0                	xor    %eax,%eax
}
80107185:	5b                   	pop    %ebx
80107186:	5e                   	pop    %esi
80107187:	5f                   	pop    %edi
80107188:	5d                   	pop    %ebp
80107189:	c3                   	ret    
8010718a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107190 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107196:	89 d3                	mov    %edx,%ebx
80107198:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010719e:	83 ec 1c             	sub    $0x1c,%esp
801071a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801071a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801071a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801071ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801071b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801071b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801071b6:	29 df                	sub    %ebx,%edi
801071b8:	83 c8 01             	or     $0x1,%eax
801071bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801071be:	eb 15                	jmp    801071d5 <mappages+0x45>
    if(*pte & PTE_P)
801071c0:	f6 00 01             	testb  $0x1,(%eax)
801071c3:	75 45                	jne    8010720a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801071c5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801071c8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801071cb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801071cd:	74 31                	je     80107200 <mappages+0x70>
      break;
    a += PGSIZE;
801071cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801071d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071d8:	b9 01 00 00 00       	mov    $0x1,%ecx
801071dd:	89 da                	mov    %ebx,%edx
801071df:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801071e2:	e8 29 ff ff ff       	call   80107110 <walkpgdir>
801071e7:	85 c0                	test   %eax,%eax
801071e9:	75 d5                	jne    801071c0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801071eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801071ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071f3:	5b                   	pop    %ebx
801071f4:	5e                   	pop    %esi
801071f5:	5f                   	pop    %edi
801071f6:	5d                   	pop    %ebp
801071f7:	c3                   	ret    
801071f8:	90                   	nop
801071f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107200:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107203:	31 c0                	xor    %eax,%eax
}
80107205:	5b                   	pop    %ebx
80107206:	5e                   	pop    %esi
80107207:	5f                   	pop    %edi
80107208:	5d                   	pop    %ebp
80107209:	c3                   	ret    
      panic("remap");
8010720a:	83 ec 0c             	sub    $0xc,%esp
8010720d:	68 68 83 10 80       	push   $0x80108368
80107212:	e8 79 91 ff ff       	call   80100390 <panic>
80107217:	89 f6                	mov    %esi,%esi
80107219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107220 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	57                   	push   %edi
80107224:	56                   	push   %esi
80107225:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107226:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010722c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010722e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107234:	83 ec 1c             	sub    $0x1c,%esp
80107237:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010723a:	39 d3                	cmp    %edx,%ebx
8010723c:	73 66                	jae    801072a4 <deallocuvm.part.0+0x84>
8010723e:	89 d6                	mov    %edx,%esi
80107240:	eb 3d                	jmp    8010727f <deallocuvm.part.0+0x5f>
80107242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107248:	8b 10                	mov    (%eax),%edx
8010724a:	f6 c2 01             	test   $0x1,%dl
8010724d:	74 26                	je     80107275 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010724f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107255:	74 58                	je     801072af <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107257:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010725a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107260:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107263:	52                   	push   %edx
80107264:	e8 87 b1 ff ff       	call   801023f0 <kfree>
      *pte = 0;
80107269:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010726c:	83 c4 10             	add    $0x10,%esp
8010726f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107275:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010727b:	39 f3                	cmp    %esi,%ebx
8010727d:	73 25                	jae    801072a4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010727f:	31 c9                	xor    %ecx,%ecx
80107281:	89 da                	mov    %ebx,%edx
80107283:	89 f8                	mov    %edi,%eax
80107285:	e8 86 fe ff ff       	call   80107110 <walkpgdir>
    if(!pte)
8010728a:	85 c0                	test   %eax,%eax
8010728c:	75 ba                	jne    80107248 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010728e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107294:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010729a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072a0:	39 f3                	cmp    %esi,%ebx
801072a2:	72 db                	jb     8010727f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801072a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072aa:	5b                   	pop    %ebx
801072ab:	5e                   	pop    %esi
801072ac:	5f                   	pop    %edi
801072ad:	5d                   	pop    %ebp
801072ae:	c3                   	ret    
        panic("kfree");
801072af:	83 ec 0c             	sub    $0xc,%esp
801072b2:	68 a6 7c 10 80       	push   $0x80107ca6
801072b7:	e8 d4 90 ff ff       	call   80100390 <panic>
801072bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801072c0 <seginit>:
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801072c6:	e8 85 c6 ff ff       	call   80103950 <cpuid>
801072cb:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
801072d1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801072d6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801072da:	c7 80 f8 37 11 80 ff 	movl   $0xffff,-0x7feec808(%eax)
801072e1:	ff 00 00 
801072e4:	c7 80 fc 37 11 80 00 	movl   $0xcf9a00,-0x7feec804(%eax)
801072eb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801072ee:	c7 80 00 38 11 80 ff 	movl   $0xffff,-0x7feec800(%eax)
801072f5:	ff 00 00 
801072f8:	c7 80 04 38 11 80 00 	movl   $0xcf9200,-0x7feec7fc(%eax)
801072ff:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107302:	c7 80 08 38 11 80 ff 	movl   $0xffff,-0x7feec7f8(%eax)
80107309:	ff 00 00 
8010730c:	c7 80 0c 38 11 80 00 	movl   $0xcffa00,-0x7feec7f4(%eax)
80107313:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107316:	c7 80 10 38 11 80 ff 	movl   $0xffff,-0x7feec7f0(%eax)
8010731d:	ff 00 00 
80107320:	c7 80 14 38 11 80 00 	movl   $0xcff200,-0x7feec7ec(%eax)
80107327:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010732a:	05 f0 37 11 80       	add    $0x801137f0,%eax
  pd[1] = (uint)p;
8010732f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107333:	c1 e8 10             	shr    $0x10,%eax
80107336:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010733a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010733d:	0f 01 10             	lgdtl  (%eax)
}
80107340:	c9                   	leave  
80107341:	c3                   	ret    
80107342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107350 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107350:	a1 04 03 12 80       	mov    0x80120304,%eax
{
80107355:	55                   	push   %ebp
80107356:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107358:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010735d:	0f 22 d8             	mov    %eax,%cr3
}
80107360:	5d                   	pop    %ebp
80107361:	c3                   	ret    
80107362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107370 <switchuvm>:
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	57                   	push   %edi
80107374:	56                   	push   %esi
80107375:	53                   	push   %ebx
80107376:	83 ec 1c             	sub    $0x1c,%esp
80107379:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010737c:	85 f6                	test   %esi,%esi
8010737e:	0f 84 d3 00 00 00    	je     80107457 <switchuvm+0xe7>
  if(mythread()->kstack == 0)
80107384:	e8 17 c6 ff ff       	call   801039a0 <mythread>
80107389:	8b 00                	mov    (%eax),%eax
8010738b:	85 c0                	test   %eax,%eax
8010738d:	0f 84 de 00 00 00    	je     80107471 <switchuvm+0x101>
  if(p->pgdir == 0)
80107393:	8b 46 04             	mov    0x4(%esi),%eax
80107396:	85 c0                	test   %eax,%eax
80107398:	0f 84 c6 00 00 00    	je     80107464 <switchuvm+0xf4>
  pushcli();
8010739e:	e8 dd d7 ff ff       	call   80104b80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801073a3:	e8 28 c5 ff ff       	call   801038d0 <mycpu>
801073a8:	89 c3                	mov    %eax,%ebx
801073aa:	e8 21 c5 ff ff       	call   801038d0 <mycpu>
801073af:	89 c7                	mov    %eax,%edi
801073b1:	e8 1a c5 ff ff       	call   801038d0 <mycpu>
801073b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073b9:	83 c7 08             	add    $0x8,%edi
801073bc:	e8 0f c5 ff ff       	call   801038d0 <mycpu>
801073c1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801073c4:	83 c0 08             	add    $0x8,%eax
801073c7:	ba 67 00 00 00       	mov    $0x67,%edx
801073cc:	c1 e8 18             	shr    $0x18,%eax
801073cf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
801073d6:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801073dd:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801073e3:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801073e8:	83 c1 08             	add    $0x8,%ecx
801073eb:	c1 e9 10             	shr    $0x10,%ecx
801073ee:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801073f4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801073f9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107400:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107405:	e8 c6 c4 ff ff       	call   801038d0 <mycpu>
8010740a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107411:	e8 ba c4 ff ff       	call   801038d0 <mycpu>
80107416:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)mythread()->kstack + KSTACKSIZE;
8010741a:	e8 81 c5 ff ff       	call   801039a0 <mythread>
8010741f:	8b 18                	mov    (%eax),%ebx
80107421:	e8 aa c4 ff ff       	call   801038d0 <mycpu>
80107426:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010742c:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010742f:	e8 9c c4 ff ff       	call   801038d0 <mycpu>
80107434:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107438:	b8 28 00 00 00       	mov    $0x28,%eax
8010743d:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107440:	8b 46 04             	mov    0x4(%esi),%eax
80107443:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107448:	0f 22 d8             	mov    %eax,%cr3
}
8010744b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010744e:	5b                   	pop    %ebx
8010744f:	5e                   	pop    %esi
80107450:	5f                   	pop    %edi
80107451:	5d                   	pop    %ebp
  popcli();
80107452:	e9 69 d7 ff ff       	jmp    80104bc0 <popcli>
    panic("switchuvm: no process");
80107457:	83 ec 0c             	sub    $0xc,%esp
8010745a:	68 6e 83 10 80       	push   $0x8010836e
8010745f:	e8 2c 8f ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107464:	83 ec 0c             	sub    $0xc,%esp
80107467:	68 99 83 10 80       	push   $0x80108399
8010746c:	e8 1f 8f ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107471:	83 ec 0c             	sub    $0xc,%esp
80107474:	68 84 83 10 80       	push   $0x80108384
80107479:	e8 12 8f ff ff       	call   80100390 <panic>
8010747e:	66 90                	xchg   %ax,%ax

80107480 <inituvm>:
{
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	57                   	push   %edi
80107484:	56                   	push   %esi
80107485:	53                   	push   %ebx
80107486:	83 ec 1c             	sub    $0x1c,%esp
80107489:	8b 75 10             	mov    0x10(%ebp),%esi
8010748c:	8b 45 08             	mov    0x8(%ebp),%eax
8010748f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107492:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010749b:	77 49                	ja     801074e6 <inituvm+0x66>
  mem = kalloc();
8010749d:	e8 fe b0 ff ff       	call   801025a0 <kalloc>
  memset(mem, 0, PGSIZE);
801074a2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801074a5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801074a7:	68 00 10 00 00       	push   $0x1000
801074ac:	6a 00                	push   $0x0
801074ae:	50                   	push   %eax
801074af:	e8 ac d8 ff ff       	call   80104d60 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801074b4:	58                   	pop    %eax
801074b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074c0:	5a                   	pop    %edx
801074c1:	6a 06                	push   $0x6
801074c3:	50                   	push   %eax
801074c4:	31 d2                	xor    %edx,%edx
801074c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074c9:	e8 c2 fc ff ff       	call   80107190 <mappages>
  memmove(mem, init, sz);
801074ce:	89 75 10             	mov    %esi,0x10(%ebp)
801074d1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801074d4:	83 c4 10             	add    $0x10,%esp
801074d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801074da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074dd:	5b                   	pop    %ebx
801074de:	5e                   	pop    %esi
801074df:	5f                   	pop    %edi
801074e0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801074e1:	e9 2a d9 ff ff       	jmp    80104e10 <memmove>
    panic("inituvm: more than a page");
801074e6:	83 ec 0c             	sub    $0xc,%esp
801074e9:	68 ad 83 10 80       	push   $0x801083ad
801074ee:	e8 9d 8e ff ff       	call   80100390 <panic>
801074f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107500 <loaduvm>:
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	57                   	push   %edi
80107504:	56                   	push   %esi
80107505:	53                   	push   %ebx
80107506:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107509:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107510:	0f 85 91 00 00 00    	jne    801075a7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107516:	8b 75 18             	mov    0x18(%ebp),%esi
80107519:	31 db                	xor    %ebx,%ebx
8010751b:	85 f6                	test   %esi,%esi
8010751d:	75 1a                	jne    80107539 <loaduvm+0x39>
8010751f:	eb 6f                	jmp    80107590 <loaduvm+0x90>
80107521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107528:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010752e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107534:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107537:	76 57                	jbe    80107590 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107539:	8b 55 0c             	mov    0xc(%ebp),%edx
8010753c:	8b 45 08             	mov    0x8(%ebp),%eax
8010753f:	31 c9                	xor    %ecx,%ecx
80107541:	01 da                	add    %ebx,%edx
80107543:	e8 c8 fb ff ff       	call   80107110 <walkpgdir>
80107548:	85 c0                	test   %eax,%eax
8010754a:	74 4e                	je     8010759a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010754c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010754e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107551:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107556:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010755b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107561:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107564:	01 d9                	add    %ebx,%ecx
80107566:	05 00 00 00 80       	add    $0x80000000,%eax
8010756b:	57                   	push   %edi
8010756c:	51                   	push   %ecx
8010756d:	50                   	push   %eax
8010756e:	ff 75 10             	pushl  0x10(%ebp)
80107571:	e8 ca a4 ff ff       	call   80101a40 <readi>
80107576:	83 c4 10             	add    $0x10,%esp
80107579:	39 f8                	cmp    %edi,%eax
8010757b:	74 ab                	je     80107528 <loaduvm+0x28>
}
8010757d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107585:	5b                   	pop    %ebx
80107586:	5e                   	pop    %esi
80107587:	5f                   	pop    %edi
80107588:	5d                   	pop    %ebp
80107589:	c3                   	ret    
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107590:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107593:	31 c0                	xor    %eax,%eax
}
80107595:	5b                   	pop    %ebx
80107596:	5e                   	pop    %esi
80107597:	5f                   	pop    %edi
80107598:	5d                   	pop    %ebp
80107599:	c3                   	ret    
      panic("loaduvm: address should exist");
8010759a:	83 ec 0c             	sub    $0xc,%esp
8010759d:	68 c7 83 10 80       	push   $0x801083c7
801075a2:	e8 e9 8d ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801075a7:	83 ec 0c             	sub    $0xc,%esp
801075aa:	68 68 84 10 80       	push   $0x80108468
801075af:	e8 dc 8d ff ff       	call   80100390 <panic>
801075b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801075c0 <allocuvm>:
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
801075c6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801075c9:	8b 7d 10             	mov    0x10(%ebp),%edi
801075cc:	85 ff                	test   %edi,%edi
801075ce:	0f 88 8e 00 00 00    	js     80107662 <allocuvm+0xa2>
  if(newsz < oldsz)
801075d4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801075d7:	0f 82 93 00 00 00    	jb     80107670 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
801075dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801075e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801075e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801075ec:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801075ef:	0f 86 7e 00 00 00    	jbe    80107673 <allocuvm+0xb3>
801075f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801075f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801075fb:	eb 42                	jmp    8010763f <allocuvm+0x7f>
801075fd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107600:	83 ec 04             	sub    $0x4,%esp
80107603:	68 00 10 00 00       	push   $0x1000
80107608:	6a 00                	push   $0x0
8010760a:	50                   	push   %eax
8010760b:	e8 50 d7 ff ff       	call   80104d60 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107610:	58                   	pop    %eax
80107611:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107617:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010761c:	5a                   	pop    %edx
8010761d:	6a 06                	push   $0x6
8010761f:	50                   	push   %eax
80107620:	89 da                	mov    %ebx,%edx
80107622:	89 f8                	mov    %edi,%eax
80107624:	e8 67 fb ff ff       	call   80107190 <mappages>
80107629:	83 c4 10             	add    $0x10,%esp
8010762c:	85 c0                	test   %eax,%eax
8010762e:	78 50                	js     80107680 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107630:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107636:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107639:	0f 86 81 00 00 00    	jbe    801076c0 <allocuvm+0x100>
    mem = kalloc();
8010763f:	e8 5c af ff ff       	call   801025a0 <kalloc>
    if(mem == 0){
80107644:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107646:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107648:	75 b6                	jne    80107600 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010764a:	83 ec 0c             	sub    $0xc,%esp
8010764d:	68 e5 83 10 80       	push   $0x801083e5
80107652:	e8 09 90 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107657:	83 c4 10             	add    $0x10,%esp
8010765a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010765d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107660:	77 6e                	ja     801076d0 <allocuvm+0x110>
}
80107662:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107665:	31 ff                	xor    %edi,%edi
}
80107667:	89 f8                	mov    %edi,%eax
80107669:	5b                   	pop    %ebx
8010766a:	5e                   	pop    %esi
8010766b:	5f                   	pop    %edi
8010766c:	5d                   	pop    %ebp
8010766d:	c3                   	ret    
8010766e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107670:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107673:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107676:	89 f8                	mov    %edi,%eax
80107678:	5b                   	pop    %ebx
80107679:	5e                   	pop    %esi
8010767a:	5f                   	pop    %edi
8010767b:	5d                   	pop    %ebp
8010767c:	c3                   	ret    
8010767d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107680:	83 ec 0c             	sub    $0xc,%esp
80107683:	68 fd 83 10 80       	push   $0x801083fd
80107688:	e8 d3 8f ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010768d:	83 c4 10             	add    $0x10,%esp
80107690:	8b 45 0c             	mov    0xc(%ebp),%eax
80107693:	39 45 10             	cmp    %eax,0x10(%ebp)
80107696:	76 0d                	jbe    801076a5 <allocuvm+0xe5>
80107698:	89 c1                	mov    %eax,%ecx
8010769a:	8b 55 10             	mov    0x10(%ebp),%edx
8010769d:	8b 45 08             	mov    0x8(%ebp),%eax
801076a0:	e8 7b fb ff ff       	call   80107220 <deallocuvm.part.0>
      kfree(mem);
801076a5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801076a8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801076aa:	56                   	push   %esi
801076ab:	e8 40 ad ff ff       	call   801023f0 <kfree>
      return 0;
801076b0:	83 c4 10             	add    $0x10,%esp
}
801076b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076b6:	89 f8                	mov    %edi,%eax
801076b8:	5b                   	pop    %ebx
801076b9:	5e                   	pop    %esi
801076ba:	5f                   	pop    %edi
801076bb:	5d                   	pop    %ebp
801076bc:	c3                   	ret    
801076bd:	8d 76 00             	lea    0x0(%esi),%esi
801076c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801076c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076c6:	5b                   	pop    %ebx
801076c7:	89 f8                	mov    %edi,%eax
801076c9:	5e                   	pop    %esi
801076ca:	5f                   	pop    %edi
801076cb:	5d                   	pop    %ebp
801076cc:	c3                   	ret    
801076cd:	8d 76 00             	lea    0x0(%esi),%esi
801076d0:	89 c1                	mov    %eax,%ecx
801076d2:	8b 55 10             	mov    0x10(%ebp),%edx
801076d5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801076d8:	31 ff                	xor    %edi,%edi
801076da:	e8 41 fb ff ff       	call   80107220 <deallocuvm.part.0>
801076df:	eb 92                	jmp    80107673 <allocuvm+0xb3>
801076e1:	eb 0d                	jmp    801076f0 <deallocuvm>
801076e3:	90                   	nop
801076e4:	90                   	nop
801076e5:	90                   	nop
801076e6:	90                   	nop
801076e7:	90                   	nop
801076e8:	90                   	nop
801076e9:	90                   	nop
801076ea:	90                   	nop
801076eb:	90                   	nop
801076ec:	90                   	nop
801076ed:	90                   	nop
801076ee:	90                   	nop
801076ef:	90                   	nop

801076f0 <deallocuvm>:
{
801076f0:	55                   	push   %ebp
801076f1:	89 e5                	mov    %esp,%ebp
801076f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801076f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801076f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801076fc:	39 d1                	cmp    %edx,%ecx
801076fe:	73 10                	jae    80107710 <deallocuvm+0x20>
}
80107700:	5d                   	pop    %ebp
80107701:	e9 1a fb ff ff       	jmp    80107220 <deallocuvm.part.0>
80107706:	8d 76 00             	lea    0x0(%esi),%esi
80107709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107710:	89 d0                	mov    %edx,%eax
80107712:	5d                   	pop    %ebp
80107713:	c3                   	ret    
80107714:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010771a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107720 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107720:	55                   	push   %ebp
80107721:	89 e5                	mov    %esp,%ebp
80107723:	57                   	push   %edi
80107724:	56                   	push   %esi
80107725:	53                   	push   %ebx
80107726:	83 ec 0c             	sub    $0xc,%esp
80107729:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010772c:	85 f6                	test   %esi,%esi
8010772e:	74 59                	je     80107789 <freevm+0x69>
80107730:	31 c9                	xor    %ecx,%ecx
80107732:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107737:	89 f0                	mov    %esi,%eax
80107739:	e8 e2 fa ff ff       	call   80107220 <deallocuvm.part.0>
8010773e:	89 f3                	mov    %esi,%ebx
80107740:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107746:	eb 0f                	jmp    80107757 <freevm+0x37>
80107748:	90                   	nop
80107749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107750:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107753:	39 fb                	cmp    %edi,%ebx
80107755:	74 23                	je     8010777a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107757:	8b 03                	mov    (%ebx),%eax
80107759:	a8 01                	test   $0x1,%al
8010775b:	74 f3                	je     80107750 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010775d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107762:	83 ec 0c             	sub    $0xc,%esp
80107765:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107768:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010776d:	50                   	push   %eax
8010776e:	e8 7d ac ff ff       	call   801023f0 <kfree>
80107773:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107776:	39 fb                	cmp    %edi,%ebx
80107778:	75 dd                	jne    80107757 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010777a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010777d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107780:	5b                   	pop    %ebx
80107781:	5e                   	pop    %esi
80107782:	5f                   	pop    %edi
80107783:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107784:	e9 67 ac ff ff       	jmp    801023f0 <kfree>
    panic("freevm: no pgdir");
80107789:	83 ec 0c             	sub    $0xc,%esp
8010778c:	68 19 84 10 80       	push   $0x80108419
80107791:	e8 fa 8b ff ff       	call   80100390 <panic>
80107796:	8d 76 00             	lea    0x0(%esi),%esi
80107799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077a0 <setupkvm>:
{
801077a0:	55                   	push   %ebp
801077a1:	89 e5                	mov    %esp,%ebp
801077a3:	56                   	push   %esi
801077a4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801077a5:	e8 f6 ad ff ff       	call   801025a0 <kalloc>
801077aa:	85 c0                	test   %eax,%eax
801077ac:	89 c6                	mov    %eax,%esi
801077ae:	74 42                	je     801077f2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801077b0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801077b3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801077b8:	68 00 10 00 00       	push   $0x1000
801077bd:	6a 00                	push   $0x0
801077bf:	50                   	push   %eax
801077c0:	e8 9b d5 ff ff       	call   80104d60 <memset>
801077c5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801077c8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801077cb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801077ce:	83 ec 08             	sub    $0x8,%esp
801077d1:	8b 13                	mov    (%ebx),%edx
801077d3:	ff 73 0c             	pushl  0xc(%ebx)
801077d6:	50                   	push   %eax
801077d7:	29 c1                	sub    %eax,%ecx
801077d9:	89 f0                	mov    %esi,%eax
801077db:	e8 b0 f9 ff ff       	call   80107190 <mappages>
801077e0:	83 c4 10             	add    $0x10,%esp
801077e3:	85 c0                	test   %eax,%eax
801077e5:	78 19                	js     80107800 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801077e7:	83 c3 10             	add    $0x10,%ebx
801077ea:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801077f0:	75 d6                	jne    801077c8 <setupkvm+0x28>
}
801077f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801077f5:	89 f0                	mov    %esi,%eax
801077f7:	5b                   	pop    %ebx
801077f8:	5e                   	pop    %esi
801077f9:	5d                   	pop    %ebp
801077fa:	c3                   	ret    
801077fb:	90                   	nop
801077fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107800:	83 ec 0c             	sub    $0xc,%esp
80107803:	56                   	push   %esi
      return 0;
80107804:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107806:	e8 15 ff ff ff       	call   80107720 <freevm>
      return 0;
8010780b:	83 c4 10             	add    $0x10,%esp
}
8010780e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107811:	89 f0                	mov    %esi,%eax
80107813:	5b                   	pop    %ebx
80107814:	5e                   	pop    %esi
80107815:	5d                   	pop    %ebp
80107816:	c3                   	ret    
80107817:	89 f6                	mov    %esi,%esi
80107819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107820 <kvmalloc>:
{
80107820:	55                   	push   %ebp
80107821:	89 e5                	mov    %esp,%ebp
80107823:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107826:	e8 75 ff ff ff       	call   801077a0 <setupkvm>
8010782b:	a3 04 03 12 80       	mov    %eax,0x80120304
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107830:	05 00 00 00 80       	add    $0x80000000,%eax
80107835:	0f 22 d8             	mov    %eax,%cr3
}
80107838:	c9                   	leave  
80107839:	c3                   	ret    
8010783a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107840 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107840:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107841:	31 c9                	xor    %ecx,%ecx
{
80107843:	89 e5                	mov    %esp,%ebp
80107845:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107848:	8b 55 0c             	mov    0xc(%ebp),%edx
8010784b:	8b 45 08             	mov    0x8(%ebp),%eax
8010784e:	e8 bd f8 ff ff       	call   80107110 <walkpgdir>
  if(pte == 0)
80107853:	85 c0                	test   %eax,%eax
80107855:	74 05                	je     8010785c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107857:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010785a:	c9                   	leave  
8010785b:	c3                   	ret    
    panic("clearpteu");
8010785c:	83 ec 0c             	sub    $0xc,%esp
8010785f:	68 2a 84 10 80       	push   $0x8010842a
80107864:	e8 27 8b ff ff       	call   80100390 <panic>
80107869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107870 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107870:	55                   	push   %ebp
80107871:	89 e5                	mov    %esp,%ebp
80107873:	57                   	push   %edi
80107874:	56                   	push   %esi
80107875:	53                   	push   %ebx
80107876:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107879:	e8 22 ff ff ff       	call   801077a0 <setupkvm>
8010787e:	85 c0                	test   %eax,%eax
80107880:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107883:	0f 84 9f 00 00 00    	je     80107928 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107889:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010788c:	85 c9                	test   %ecx,%ecx
8010788e:	0f 84 94 00 00 00    	je     80107928 <copyuvm+0xb8>
80107894:	31 ff                	xor    %edi,%edi
80107896:	eb 4a                	jmp    801078e2 <copyuvm+0x72>
80107898:	90                   	nop
80107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801078a0:	83 ec 04             	sub    $0x4,%esp
801078a3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801078a9:	68 00 10 00 00       	push   $0x1000
801078ae:	53                   	push   %ebx
801078af:	50                   	push   %eax
801078b0:	e8 5b d5 ff ff       	call   80104e10 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801078b5:	58                   	pop    %eax
801078b6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801078bc:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078c1:	5a                   	pop    %edx
801078c2:	ff 75 e4             	pushl  -0x1c(%ebp)
801078c5:	50                   	push   %eax
801078c6:	89 fa                	mov    %edi,%edx
801078c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078cb:	e8 c0 f8 ff ff       	call   80107190 <mappages>
801078d0:	83 c4 10             	add    $0x10,%esp
801078d3:	85 c0                	test   %eax,%eax
801078d5:	78 61                	js     80107938 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801078d7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801078dd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801078e0:	76 46                	jbe    80107928 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801078e2:	8b 45 08             	mov    0x8(%ebp),%eax
801078e5:	31 c9                	xor    %ecx,%ecx
801078e7:	89 fa                	mov    %edi,%edx
801078e9:	e8 22 f8 ff ff       	call   80107110 <walkpgdir>
801078ee:	85 c0                	test   %eax,%eax
801078f0:	74 61                	je     80107953 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801078f2:	8b 00                	mov    (%eax),%eax
801078f4:	a8 01                	test   $0x1,%al
801078f6:	74 4e                	je     80107946 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801078f8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801078fa:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801078ff:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107905:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107908:	e8 93 ac ff ff       	call   801025a0 <kalloc>
8010790d:	85 c0                	test   %eax,%eax
8010790f:	89 c6                	mov    %eax,%esi
80107911:	75 8d                	jne    801078a0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107913:	83 ec 0c             	sub    $0xc,%esp
80107916:	ff 75 e0             	pushl  -0x20(%ebp)
80107919:	e8 02 fe ff ff       	call   80107720 <freevm>
  return 0;
8010791e:	83 c4 10             	add    $0x10,%esp
80107921:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107928:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010792b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010792e:	5b                   	pop    %ebx
8010792f:	5e                   	pop    %esi
80107930:	5f                   	pop    %edi
80107931:	5d                   	pop    %ebp
80107932:	c3                   	ret    
80107933:	90                   	nop
80107934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107938:	83 ec 0c             	sub    $0xc,%esp
8010793b:	56                   	push   %esi
8010793c:	e8 af aa ff ff       	call   801023f0 <kfree>
      goto bad;
80107941:	83 c4 10             	add    $0x10,%esp
80107944:	eb cd                	jmp    80107913 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107946:	83 ec 0c             	sub    $0xc,%esp
80107949:	68 4e 84 10 80       	push   $0x8010844e
8010794e:	e8 3d 8a ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107953:	83 ec 0c             	sub    $0xc,%esp
80107956:	68 34 84 10 80       	push   $0x80108434
8010795b:	e8 30 8a ff ff       	call   80100390 <panic>

80107960 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107960:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107961:	31 c9                	xor    %ecx,%ecx
{
80107963:	89 e5                	mov    %esp,%ebp
80107965:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107968:	8b 55 0c             	mov    0xc(%ebp),%edx
8010796b:	8b 45 08             	mov    0x8(%ebp),%eax
8010796e:	e8 9d f7 ff ff       	call   80107110 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107973:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107975:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107976:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107978:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010797d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107980:	05 00 00 00 80       	add    $0x80000000,%eax
80107985:	83 fa 05             	cmp    $0x5,%edx
80107988:	ba 00 00 00 00       	mov    $0x0,%edx
8010798d:	0f 45 c2             	cmovne %edx,%eax
}
80107990:	c3                   	ret    
80107991:	eb 0d                	jmp    801079a0 <copyout>
80107993:	90                   	nop
80107994:	90                   	nop
80107995:	90                   	nop
80107996:	90                   	nop
80107997:	90                   	nop
80107998:	90                   	nop
80107999:	90                   	nop
8010799a:	90                   	nop
8010799b:	90                   	nop
8010799c:	90                   	nop
8010799d:	90                   	nop
8010799e:	90                   	nop
8010799f:	90                   	nop

801079a0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801079a0:	55                   	push   %ebp
801079a1:	89 e5                	mov    %esp,%ebp
801079a3:	57                   	push   %edi
801079a4:	56                   	push   %esi
801079a5:	53                   	push   %ebx
801079a6:	83 ec 1c             	sub    $0x1c,%esp
801079a9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801079ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801079af:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801079b2:	85 db                	test   %ebx,%ebx
801079b4:	75 40                	jne    801079f6 <copyout+0x56>
801079b6:	eb 70                	jmp    80107a28 <copyout+0x88>
801079b8:	90                   	nop
801079b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801079c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801079c3:	89 f1                	mov    %esi,%ecx
801079c5:	29 d1                	sub    %edx,%ecx
801079c7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801079cd:	39 d9                	cmp    %ebx,%ecx
801079cf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801079d2:	29 f2                	sub    %esi,%edx
801079d4:	83 ec 04             	sub    $0x4,%esp
801079d7:	01 d0                	add    %edx,%eax
801079d9:	51                   	push   %ecx
801079da:	57                   	push   %edi
801079db:	50                   	push   %eax
801079dc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801079df:	e8 2c d4 ff ff       	call   80104e10 <memmove>
    len -= n;
    buf += n;
801079e4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801079e7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801079ea:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801079f0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801079f2:	29 cb                	sub    %ecx,%ebx
801079f4:	74 32                	je     80107a28 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801079f6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801079f8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801079fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801079fe:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a04:	56                   	push   %esi
80107a05:	ff 75 08             	pushl  0x8(%ebp)
80107a08:	e8 53 ff ff ff       	call   80107960 <uva2ka>
    if(pa0 == 0)
80107a0d:	83 c4 10             	add    $0x10,%esp
80107a10:	85 c0                	test   %eax,%eax
80107a12:	75 ac                	jne    801079c0 <copyout+0x20>
  }
  return 0;
}
80107a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a1c:	5b                   	pop    %ebx
80107a1d:	5e                   	pop    %esi
80107a1e:	5f                   	pop    %edi
80107a1f:	5d                   	pop    %ebp
80107a20:	c3                   	ret    
80107a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a28:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a2b:	31 c0                	xor    %eax,%eax
}
80107a2d:	5b                   	pop    %ebx
80107a2e:	5e                   	pop    %esi
80107a2f:	5f                   	pop    %edi
80107a30:	5d                   	pop    %ebp
80107a31:	c3                   	ret    
