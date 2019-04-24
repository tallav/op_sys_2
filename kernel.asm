
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
80100028:	bc d0 c5 10 80       	mov    $0x8010c5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 70 2f 10 80       	mov    $0x80102f70,%eax
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
80100044:	bb 14 c6 10 80       	mov    $0x8010c614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 7a 10 80       	push   $0x80107aa0
80100051:	68 e0 c5 10 80       	push   $0x8010c5e0
80100056:	e8 05 4b 00 00       	call   80104b60 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c 0d 11 80 dc 	movl   $0x80110cdc,0x80110d2c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 0d 11 80 dc 	movl   $0x80110cdc,0x80110d30
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc 0c 11 80       	mov    $0x80110cdc,%edx
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
8010008b:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 7a 10 80       	push   $0x80107aa7
80100097:	50                   	push   %eax
80100098:	e8 93 49 00 00       	call   80104a30 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 0d 11 80       	mov    0x80110d30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc 0c 11 80       	cmp    $0x80110cdc,%eax
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
801000df:	68 e0 c5 10 80       	push   $0x8010c5e0
801000e4:	e8 b7 4b 00 00       	call   80104ca0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 0d 11 80    	mov    0x80110d30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
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
80100120:	8b 1d 2c 0d 11 80    	mov    0x80110d2c,%ebx
80100126:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
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
8010015d:	68 e0 c5 10 80       	push   $0x8010c5e0
80100162:	e8 f9 4b 00 00       	call   80104d60 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 48 00 00       	call   80104a70 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 20 00 00       	call   801021f0 <iderw>
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
80100193:	68 ae 7a 10 80       	push   $0x80107aae
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
801001ae:	e8 5d 49 00 00       	call   80104b10 <holdingsleep>
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
801001c4:	e9 27 20 00 00       	jmp    801021f0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 7a 10 80       	push   $0x80107abf
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
801001ef:	e8 1c 49 00 00       	call   80104b10 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 48 00 00       	call   80104ad0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
8010020b:	e8 90 4a 00 00       	call   80104ca0 <acquire>
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
80100232:	a1 30 0d 11 80       	mov    0x80110d30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 0d 11 80       	mov    0x80110d30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 ff 4a 00 00       	jmp    80104d60 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 7a 10 80       	push   $0x80107ac6
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
80100280:	e8 ab 15 00 00       	call   80101830 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 0f 4a 00 00       	call   80104ca0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 c0 0f 11 80    	mov    0x80110fc0,%edx
801002a7:	39 15 c4 0f 11 80    	cmp    %edx,0x80110fc4
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
801002c0:	68 c0 0f 11 80       	push   $0x80110fc0
801002c5:	e8 76 3d 00 00       	call   80104040 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 c0 0f 11 80    	mov    0x80110fc0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 c4 0f 11 80    	cmp    0x80110fc4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 80 36 00 00       	call   80103960 <myproc>
801002e0:	8b 40 14             	mov    0x14(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 6c 4a 00 00       	call   80104d60 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 54 14 00 00       	call   80101750 <ilock>
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
80100313:	a3 c0 0f 11 80       	mov    %eax,0x80110fc0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 40 0f 11 80 	movsbl -0x7feef0c0(%eax),%eax
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
8010034d:	e8 0e 4a 00 00       	call   80104d60 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 f6 13 00 00       	call   80101750 <ilock>
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
80100372:	89 15 c0 0f 11 80    	mov    %edx,0x80110fc0
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
801003a9:	e8 52 24 00 00       	call   80102800 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 cd 7a 10 80       	push   $0x80107acd
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 f7 84 10 80 	movl   $0x801084f7,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 a3 47 00 00       	call   80104b80 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 e1 7a 10 80       	push   $0x80107ae1
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
8010043a:	e8 61 62 00 00       	call   801066a0 <uartputc>
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
801004ec:	e8 af 61 00 00       	call   801066a0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 a3 61 00 00       	call   801066a0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 97 61 00 00       	call   801066a0 <uartputc>
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
80100524:	e8 37 49 00 00       	call   80104e60 <memmove>
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
80100541:	e8 6a 48 00 00       	call   80104db0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 e5 7a 10 80       	push   $0x80107ae5
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
801005b1:	0f b6 92 10 7b 10 80 	movzbl -0x7fef84f0(%edx),%edx
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
8010060f:	e8 1c 12 00 00       	call   80101830 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 80 46 00 00       	call   80104ca0 <acquire>
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
80100647:	e8 14 47 00 00       	call   80104d60 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 fb 10 00 00       	call   80101750 <ilock>

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
8010071f:	e8 3c 46 00 00       	call   80104d60 <release>
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
801007d0:	ba f8 7a 10 80       	mov    $0x80107af8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 ab 44 00 00       	call   80104ca0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 ff 7a 10 80       	push   $0x80107aff
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
80100823:	e8 78 44 00 00       	call   80104ca0 <acquire>
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
80100851:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100856:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
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
80100888:	e8 d3 44 00 00       	call   80104d60 <release>
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
801008a9:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 c0 0f 11 80    	sub    0x80110fc0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 c8 0f 11 80    	mov    %edx,0x80110fc8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 40 0f 11 80    	mov    %cl,-0x7feef0c0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 c8 0f 11 80    	cmp    %eax,0x80110fc8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 c4 0f 11 80       	mov    %eax,0x80110fc4
          wakeup(&input.r);
80100911:	68 c0 0f 11 80       	push   $0x80110fc0
80100916:	e8 95 39 00 00       	call   801042b0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
8010093d:	39 05 c4 0f 11 80    	cmp    %eax,0x80110fc4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100964:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 40 0f 11 80 0a 	cmpb   $0xa,-0x7feef0c0(%edx)
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
80100997:	e9 f4 39 00 00       	jmp    80104390 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 40 0f 11 80 0a 	movb   $0xa,-0x7feef0c0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
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
801009c6:	68 08 7b 10 80       	push   $0x80107b08
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 8b 41 00 00       	call   80104b60 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 8c 19 11 80 00 	movl   $0x80100600,0x8011198c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 88 19 11 80 70 	movl   $0x80100270,0x80111988
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 a2 19 00 00       	call   801023a0 <ioapicenable>
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
80100a21:	89 c7                	mov    %eax,%edi
  struct kthread *curthread = mythread();
80100a23:	e8 68 2f 00 00       	call   80103990 <mythread>

  // check if you got exit request before executing
  if(curthread->exitRequest == 1){
80100a28:	83 78 20 01          	cmpl   $0x1,0x20(%eax)
80100a2c:	0f 84 b5 01 00 00    	je     80100be7 <exec+0x1d7>
    cprintf("exec: thread got exit request\n");
    kthread_exit();
    return -1;
  }else{
    acquire(&ptable.lock);
80100a32:	83 ec 0c             	sub    $0xc,%esp
80100a35:	89 c3                	mov    %eax,%ebx
80100a37:	68 a0 4e 11 80       	push   $0x80114ea0
80100a3c:	e8 5f 42 00 00       	call   80104ca0 <acquire>
    struct kthread *t;
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80100a41:	8b 4f 6c             	mov    0x6c(%edi),%ecx
80100a44:	83 c4 10             	add    $0x10,%esp
80100a47:	89 c8                	mov    %ecx,%eax
80100a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80100a50:	39 c3                	cmp    %eax,%ebx
80100a52:	74 16                	je     80100a6a <exec+0x5a>
80100a54:	8b 50 08             	mov    0x8(%eax),%edx
80100a57:	83 fa 05             	cmp    $0x5,%edx
80100a5a:	74 0e                	je     80100a6a <exec+0x5a>
80100a5c:	85 d2                	test   %edx,%edx
80100a5e:	74 0a                	je     80100a6a <exec+0x5a>
        t->exitRequest = 1;
80100a60:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
80100a67:	8b 4f 6c             	mov    0x6c(%edi),%ecx
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80100a6a:	8d 91 40 02 00 00    	lea    0x240(%ecx),%edx
80100a70:	83 c0 24             	add    $0x24,%eax
80100a73:	39 d0                	cmp    %edx,%eax
80100a75:	72 d9                	jb     80100a50 <exec+0x40>
      }
    }
    release(&ptable.lock);
80100a77:	83 ec 0c             	sub    $0xc,%esp
80100a7a:	68 a0 4e 11 80       	push   $0x80114ea0
80100a7f:	e8 dc 42 00 00       	call   80104d60 <release>
      allTerminated = 1;
    }
  }
  release(&ptable.lock);
  */
  begin_op();
80100a84:	e8 e7 21 00 00       	call   80102c70 <begin_op>

  if((ip = namei(path)) == 0){
80100a89:	59                   	pop    %ecx
80100a8a:	ff 75 08             	pushl  0x8(%ebp)
80100a8d:	e8 1e 15 00 00       	call   80101fb0 <namei>
80100a92:	83 c4 10             	add    $0x10,%esp
80100a95:	85 c0                	test   %eax,%eax
80100a97:	89 c6                	mov    %eax,%esi
80100a99:	0f 84 e3 01 00 00    	je     80100c82 <exec+0x272>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a9f:	83 ec 0c             	sub    $0xc,%esp
80100aa2:	50                   	push   %eax
80100aa3:	e8 a8 0c 00 00       	call   80101750 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aa8:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100aae:	6a 34                	push   $0x34
80100ab0:	6a 00                	push   $0x0
80100ab2:	50                   	push   %eax
80100ab3:	56                   	push   %esi
80100ab4:	e8 77 0f 00 00       	call   80101a30 <readi>
80100ab9:	83 c4 20             	add    $0x20,%esp
80100abc:	83 f8 34             	cmp    $0x34,%eax
80100abf:	74 1f                	je     80100ae0 <exec+0xd0>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ac1:	83 ec 0c             	sub    $0xc,%esp
80100ac4:	56                   	push   %esi
80100ac5:	e8 16 0f 00 00       	call   801019e0 <iunlockput>
    end_op();
80100aca:	e8 11 22 00 00       	call   80102ce0 <end_op>
80100acf:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ad2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ad7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ada:	5b                   	pop    %ebx
80100adb:	5e                   	pop    %esi
80100adc:	5f                   	pop    %edi
80100add:	5d                   	pop    %ebp
80100ade:	c3                   	ret    
80100adf:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100ae0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ae7:	45 4c 46 
80100aea:	75 d5                	jne    80100ac1 <exec+0xb1>
  if((pgdir = setupkvm()) == 0)
80100aec:	e8 ff 6c 00 00       	call   801077f0 <setupkvm>
80100af1:	85 c0                	test   %eax,%eax
80100af3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100af9:	74 c6                	je     80100ac1 <exec+0xb1>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100afb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b02:	00 
80100b03:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100b09:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b0f:	0f 84 e9 02 00 00    	je     80100dfe <exec+0x3ee>
  sz = 0;
80100b15:	31 c9                	xor    %ecx,%ecx
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b17:	31 c0                	xor    %eax,%eax
80100b19:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100b1f:	89 9d e8 fe ff ff    	mov    %ebx,-0x118(%ebp)
80100b25:	89 cf                	mov    %ecx,%edi
80100b27:	89 c3                	mov    %eax,%ebx
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
80100b5e:	e8 ad 6a 00 00       	call   80107610 <allocuvm>
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
80100b88:	56                   	push   %esi
80100b89:	50                   	push   %eax
80100b8a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b90:	e8 bb 69 00 00       	call   80107550 <loaduvm>
80100b95:	83 c4 20             	add    $0x20,%esp
80100b98:	85 c0                	test   %eax,%eax
80100b9a:	78 35                	js     80100bd1 <exec+0x1c1>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b9c:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100ba3:	83 c3 01             	add    $0x1,%ebx
80100ba6:	39 d8                	cmp    %ebx,%eax
80100ba8:	7e 5c                	jle    80100c06 <exec+0x1f6>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100baa:	89 d8                	mov    %ebx,%eax
80100bac:	6a 20                	push   $0x20
80100bae:	c1 e0 05             	shl    $0x5,%eax
80100bb1:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100bb7:	50                   	push   %eax
80100bb8:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bbe:	50                   	push   %eax
80100bbf:	56                   	push   %esi
80100bc0:	e8 6b 0e 00 00       	call   80101a30 <readi>
80100bc5:	83 c4 10             	add    $0x10,%esp
80100bc8:	83 f8 20             	cmp    $0x20,%eax
80100bcb:	0f 84 5f ff ff ff    	je     80100b30 <exec+0x120>
    freevm(pgdir);
80100bd1:	83 ec 0c             	sub    $0xc,%esp
80100bd4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bda:	e8 91 6b 00 00       	call   80107770 <freevm>
80100bdf:	83 c4 10             	add    $0x10,%esp
80100be2:	e9 da fe ff ff       	jmp    80100ac1 <exec+0xb1>
    cprintf("exec: thread got exit request\n");
80100be7:	83 ec 0c             	sub    $0xc,%esp
80100bea:	68 24 7b 10 80       	push   $0x80107b24
80100bef:	e8 6c fa ff ff       	call   80100660 <cprintf>
    kthread_exit();
80100bf4:	e8 d7 39 00 00       	call   801045d0 <kthread_exit>
    return -1;
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c01:	e9 d1 fe ff ff       	jmp    80100ad7 <exec+0xc7>
80100c06:	89 f8                	mov    %edi,%eax
80100c08:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100c0e:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100c14:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100c1e:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
  iunlockput(ip);
80100c24:	83 ec 0c             	sub    $0xc,%esp
80100c27:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100c2d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c33:	56                   	push   %esi
80100c34:	e8 a7 0d 00 00       	call   801019e0 <iunlockput>
  end_op();
80100c39:	e8 a2 20 00 00       	call   80102ce0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c3e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
80100c44:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c4a:	83 c4 0c             	add    $0xc,%esp
80100c4d:	52                   	push   %edx
80100c4e:	50                   	push   %eax
80100c4f:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c55:	e8 b6 69 00 00       	call   80107610 <allocuvm>
80100c5a:	83 c4 10             	add    $0x10,%esp
80100c5d:	85 c0                	test   %eax,%eax
80100c5f:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c65:	75 3a                	jne    80100ca1 <exec+0x291>
    freevm(pgdir);
80100c67:	83 ec 0c             	sub    $0xc,%esp
80100c6a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c70:	e8 fb 6a 00 00       	call   80107770 <freevm>
80100c75:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c7d:	e9 55 fe ff ff       	jmp    80100ad7 <exec+0xc7>
    end_op();
80100c82:	e8 59 20 00 00       	call   80102ce0 <end_op>
    cprintf("exec: fail\n");
80100c87:	83 ec 0c             	sub    $0xc,%esp
80100c8a:	68 43 7b 10 80       	push   $0x80107b43
80100c8f:	e8 cc f9 ff ff       	call   80100660 <cprintf>
    return -1;
80100c94:	83 c4 10             	add    $0x10,%esp
80100c97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c9c:	e9 36 fe ff ff       	jmp    80100ad7 <exec+0xc7>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ca1:	89 c6                	mov    %eax,%esi
80100ca3:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100ca9:	83 ec 08             	sub    $0x8,%esp
80100cac:	50                   	push   %eax
80100cad:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cb3:	e8 d8 6b 00 00       	call   80107890 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cbb:	83 c4 10             	add    $0x10,%esp
80100cbe:	31 d2                	xor    %edx,%edx
80100cc0:	8b 00                	mov    (%eax),%eax
80100cc2:	85 c0                	test   %eax,%eax
80100cc4:	0f 84 40 01 00 00    	je     80100e0a <exec+0x3fa>
80100cca:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100cd0:	89 d7                	mov    %edx,%edi
80100cd2:	eb 05                	jmp    80100cd9 <exec+0x2c9>
    if(argc >= MAXARG)
80100cd4:	83 ff 20             	cmp    $0x20,%edi
80100cd7:	74 8e                	je     80100c67 <exec+0x257>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cd9:	83 ec 0c             	sub    $0xc,%esp
80100cdc:	50                   	push   %eax
80100cdd:	e8 ee 42 00 00       	call   80104fd0 <strlen>
80100ce2:	f7 d0                	not    %eax
80100ce4:	01 c6                	add    %eax,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ce9:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cea:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ced:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cf0:	e8 db 42 00 00       	call   80104fd0 <strlen>
80100cf5:	83 c0 01             	add    $0x1,%eax
80100cf8:	50                   	push   %eax
80100cf9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cfc:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cff:	56                   	push   %esi
80100d00:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d06:	e8 e5 6c 00 00       	call   801079f0 <copyout>
80100d0b:	83 c4 20             	add    $0x20,%esp
80100d0e:	85 c0                	test   %eax,%eax
80100d10:	0f 88 51 ff ff ff    	js     80100c67 <exec+0x257>
  for(argc = 0; argv[argc]; argc++) {
80100d16:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d19:	89 b4 bd 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d20:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d23:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100d29:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d2c:	85 c0                	test   %eax,%eax
80100d2e:	75 a4                	jne    80100cd4 <exec+0x2c4>
80100d30:	89 fa                	mov    %edi,%edx
80100d32:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d38:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[3+argc] = 0;
80100d3f:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100d46:	00 00 00 00 
  ustack[1] = argc;
80100d4a:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d50:	89 f2                	mov    %esi,%edx
  ustack[0] = 0xffffffff;  // fake return PC
80100d52:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d59:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5c:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100d5e:	83 c0 0c             	add    $0xc,%eax
80100d61:	29 c6                	sub    %eax,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d63:	50                   	push   %eax
80100d64:	51                   	push   %ecx
80100d65:	56                   	push   %esi
80100d66:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d6c:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d72:	e8 79 6c 00 00       	call   801079f0 <copyout>
80100d77:	83 c4 10             	add    $0x10,%esp
80100d7a:	85 c0                	test   %eax,%eax
80100d7c:	0f 88 e5 fe ff ff    	js     80100c67 <exec+0x257>
  for(last=s=path; *s; s++)
80100d82:	8b 45 08             	mov    0x8(%ebp),%eax
80100d85:	0f b6 00             	movzbl (%eax),%eax
80100d88:	84 c0                	test   %al,%al
80100d8a:	74 17                	je     80100da3 <exec+0x393>
80100d8c:	8b 55 08             	mov    0x8(%ebp),%edx
80100d8f:	89 d1                	mov    %edx,%ecx
80100d91:	83 c1 01             	add    $0x1,%ecx
80100d94:	3c 2f                	cmp    $0x2f,%al
80100d96:	0f b6 01             	movzbl (%ecx),%eax
80100d99:	0f 44 d1             	cmove  %ecx,%edx
80100d9c:	84 c0                	test   %al,%al
80100d9e:	75 f1                	jne    80100d91 <exec+0x381>
80100da0:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100da3:	50                   	push   %eax
80100da4:	8d 47 5c             	lea    0x5c(%edi),%eax
80100da7:	6a 10                	push   $0x10
80100da9:	ff 75 08             	pushl  0x8(%ebp)
80100dac:	50                   	push   %eax
80100dad:	e8 de 41 00 00       	call   80104f90 <safestrcpy>
  oldpgdir = curproc->pgdir;
80100db2:	8b 47 04             	mov    0x4(%edi),%eax
80100db5:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  curproc->pgdir = pgdir;
80100dbb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100dc1:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100dc4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100dca:	89 07                	mov    %eax,(%edi)
  curthread->tf->eip = elf.entry;  // main
80100dcc:	8b 53 14             	mov    0x14(%ebx),%edx
80100dcf:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100dd5:	89 4a 38             	mov    %ecx,0x38(%edx)
  curthread->tf->esp = sp;
80100dd8:	8b 53 14             	mov    0x14(%ebx),%edx
80100ddb:	89 72 44             	mov    %esi,0x44(%edx)
  switchuvm(curproc);
80100dde:	89 3c 24             	mov    %edi,(%esp)
80100de1:	e8 da 65 00 00       	call   801073c0 <switchuvm>
  freevm(oldpgdir);
80100de6:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100dec:	89 04 24             	mov    %eax,(%esp)
80100def:	e8 7c 69 00 00       	call   80107770 <freevm>
  return 0;
80100df4:	83 c4 10             	add    $0x10,%esp
80100df7:	31 c0                	xor    %eax,%eax
80100df9:	e9 d9 fc ff ff       	jmp    80100ad7 <exec+0xc7>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dfe:	31 c0                	xor    %eax,%eax
80100e00:	ba 00 20 00 00       	mov    $0x2000,%edx
80100e05:	e9 1a fe ff ff       	jmp    80100c24 <exec+0x214>
  for(argc = 0; argv[argc]; argc++) {
80100e0a:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100e10:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e16:	e9 1d ff ff ff       	jmp    80100d38 <exec+0x328>
80100e1b:	66 90                	xchg   %ax,%ax
80100e1d:	66 90                	xchg   %ax,%ax
80100e1f:	90                   	nop

80100e20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e26:	68 4f 7b 10 80       	push   $0x80107b4f
80100e2b:	68 e0 0f 11 80       	push   $0x80110fe0
80100e30:	e8 2b 3d 00 00       	call   80104b60 <initlock>
}
80100e35:	83 c4 10             	add    $0x10,%esp
80100e38:	c9                   	leave  
80100e39:	c3                   	ret    
80100e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e44:	bb 14 10 11 80       	mov    $0x80111014,%ebx
{
80100e49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e4c:	68 e0 0f 11 80       	push   $0x80110fe0
80100e51:	e8 4a 3e 00 00       	call   80104ca0 <acquire>
80100e56:	83 c4 10             	add    $0x10,%esp
80100e59:	eb 10                	jmp    80100e6b <filealloc+0x2b>
80100e5b:	90                   	nop
80100e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e60:	83 c3 18             	add    $0x18,%ebx
80100e63:	81 fb 74 19 11 80    	cmp    $0x80111974,%ebx
80100e69:	73 25                	jae    80100e90 <filealloc+0x50>
    if(f->ref == 0){
80100e6b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e6e:	85 c0                	test   %eax,%eax
80100e70:	75 ee                	jne    80100e60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e72:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e7c:	68 e0 0f 11 80       	push   $0x80110fe0
80100e81:	e8 da 3e 00 00       	call   80104d60 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e86:	89 d8                	mov    %ebx,%eax
      return f;
80100e88:	83 c4 10             	add    $0x10,%esp
}
80100e8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e8e:	c9                   	leave  
80100e8f:	c3                   	ret    
  release(&ftable.lock);
80100e90:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e93:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e95:	68 e0 0f 11 80       	push   $0x80110fe0
80100e9a:	e8 c1 3e 00 00       	call   80104d60 <release>
}
80100e9f:	89 d8                	mov    %ebx,%eax
  return 0;
80100ea1:	83 c4 10             	add    $0x10,%esp
}
80100ea4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea7:	c9                   	leave  
80100ea8:	c3                   	ret    
80100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	53                   	push   %ebx
80100eb4:	83 ec 10             	sub    $0x10,%esp
80100eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eba:	68 e0 0f 11 80       	push   $0x80110fe0
80100ebf:	e8 dc 3d 00 00       	call   80104ca0 <acquire>
  if(f->ref < 1)
80100ec4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ec7:	83 c4 10             	add    $0x10,%esp
80100eca:	85 c0                	test   %eax,%eax
80100ecc:	7e 1a                	jle    80100ee8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ece:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ed1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ed4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ed7:	68 e0 0f 11 80       	push   $0x80110fe0
80100edc:	e8 7f 3e 00 00       	call   80104d60 <release>
  return f;
}
80100ee1:	89 d8                	mov    %ebx,%eax
80100ee3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee6:	c9                   	leave  
80100ee7:	c3                   	ret    
    panic("filedup");
80100ee8:	83 ec 0c             	sub    $0xc,%esp
80100eeb:	68 56 7b 10 80       	push   $0x80107b56
80100ef0:	e8 9b f4 ff ff       	call   80100390 <panic>
80100ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f00 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	57                   	push   %edi
80100f04:	56                   	push   %esi
80100f05:	53                   	push   %ebx
80100f06:	83 ec 28             	sub    $0x28,%esp
80100f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f0c:	68 e0 0f 11 80       	push   $0x80110fe0
80100f11:	e8 8a 3d 00 00       	call   80104ca0 <acquire>
  if(f->ref < 1)
80100f16:	8b 43 04             	mov    0x4(%ebx),%eax
80100f19:	83 c4 10             	add    $0x10,%esp
80100f1c:	85 c0                	test   %eax,%eax
80100f1e:	0f 8e 9b 00 00 00    	jle    80100fbf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100f24:	83 e8 01             	sub    $0x1,%eax
80100f27:	85 c0                	test   %eax,%eax
80100f29:	89 43 04             	mov    %eax,0x4(%ebx)
80100f2c:	74 1a                	je     80100f48 <fileclose+0x48>
    release(&ftable.lock);
80100f2e:	c7 45 08 e0 0f 11 80 	movl   $0x80110fe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f38:	5b                   	pop    %ebx
80100f39:	5e                   	pop    %esi
80100f3a:	5f                   	pop    %edi
80100f3b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f3c:	e9 1f 3e 00 00       	jmp    80104d60 <release>
80100f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f48:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f4c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f4e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f51:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f54:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f5a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f5d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f60:	68 e0 0f 11 80       	push   $0x80110fe0
  ff = *f;
80100f65:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f68:	e8 f3 3d 00 00       	call   80104d60 <release>
  if(ff.type == FD_PIPE)
80100f6d:	83 c4 10             	add    $0x10,%esp
80100f70:	83 ff 01             	cmp    $0x1,%edi
80100f73:	74 13                	je     80100f88 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f75:	83 ff 02             	cmp    $0x2,%edi
80100f78:	74 26                	je     80100fa0 <fileclose+0xa0>
}
80100f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7d:	5b                   	pop    %ebx
80100f7e:	5e                   	pop    %esi
80100f7f:	5f                   	pop    %edi
80100f80:	5d                   	pop    %ebp
80100f81:	c3                   	ret    
80100f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f88:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f8c:	83 ec 08             	sub    $0x8,%esp
80100f8f:	53                   	push   %ebx
80100f90:	56                   	push   %esi
80100f91:	e8 8a 24 00 00       	call   80103420 <pipeclose>
80100f96:	83 c4 10             	add    $0x10,%esp
80100f99:	eb df                	jmp    80100f7a <fileclose+0x7a>
80100f9b:	90                   	nop
80100f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100fa0:	e8 cb 1c 00 00       	call   80102c70 <begin_op>
    iput(ff.ip);
80100fa5:	83 ec 0c             	sub    $0xc,%esp
80100fa8:	ff 75 e0             	pushl  -0x20(%ebp)
80100fab:	e8 d0 08 00 00       	call   80101880 <iput>
    end_op();
80100fb0:	83 c4 10             	add    $0x10,%esp
}
80100fb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb6:	5b                   	pop    %ebx
80100fb7:	5e                   	pop    %esi
80100fb8:	5f                   	pop    %edi
80100fb9:	5d                   	pop    %ebp
    end_op();
80100fba:	e9 21 1d 00 00       	jmp    80102ce0 <end_op>
    panic("fileclose");
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	68 5e 7b 10 80       	push   $0x80107b5e
80100fc7:	e8 c4 f3 ff ff       	call   80100390 <panic>
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	pushl  0x10(%ebx)
80100fe5:	e8 66 07 00 00       	call   80101750 <ilock>
    stati(f->ip, st);
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	pushl  0xc(%ebp)
80100fef:	ff 73 10             	pushl  0x10(%ebx)
80100ff2:	e8 09 0a 00 00       	call   80101a00 <stati>
    iunlock(f->ip);
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	pushl  0x10(%ebx)
80100ffb:	e8 30 08 00 00       	call   80101830 <iunlock>
    return 0;
80101000:	83 c4 10             	add    $0x10,%esp
80101003:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101005:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101015:	eb ee                	jmp    80101005 <filestat+0x35>
80101017:	89 f6                	mov    %esi,%esi
80101019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101020 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
    ilock(f->ip);
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	pushl  0x10(%ebx)
8010104a:	e8 01 07 00 00       	call   80101750 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	pushl  0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	pushl  0x10(%ebx)
80101057:	e8 d4 09 00 00       	call   80101a30 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	85 c0                	test   %eax,%eax
80101061:	89 c6                	mov    %eax,%esi
80101063:	7e 03                	jle    80101068 <fileread+0x48>
      f->off += r;
80101065:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	pushl  0x10(%ebx)
8010106e:	e8 bd 07 00 00       	call   80101830 <iunlock>
    return r;
80101073:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010108d:	e9 3e 25 00 00       	jmp    801035d0 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
  panic("fileread");
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 68 7b 10 80       	push   $0x80107b68
801010a7:	e8 e4 f2 ff ff       	call   80100390 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	57                   	push   %edi
801010b4:	56                   	push   %esi
801010b5:	53                   	push   %ebx
801010b6:	83 ec 1c             	sub    $0x1c,%esp
801010b9:	8b 75 08             	mov    0x8(%ebp),%esi
801010bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
801010bf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801010c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010c6:	8b 45 10             	mov    0x10(%ebp),%eax
801010c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010cc:	0f 84 aa 00 00 00    	je     8010117c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
801010d2:	8b 06                	mov    (%esi),%eax
801010d4:	83 f8 01             	cmp    $0x1,%eax
801010d7:	0f 84 c3 00 00 00    	je     801011a0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	0f 85 d9 00 00 00    	jne    801011bf <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010e9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 34                	jg     80101123 <filewrite+0x73>
801010ef:	e9 9c 00 00 00       	jmp    80101190 <filewrite+0xe0>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010f8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101101:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101104:	e8 27 07 00 00       	call   80101830 <iunlock>
      end_op();
80101109:	e8 d2 1b 00 00       	call   80102ce0 <end_op>
8010110e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101111:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101114:	39 c3                	cmp    %eax,%ebx
80101116:	0f 85 96 00 00 00    	jne    801011b2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010111c:	01 df                	add    %ebx,%edi
    while(i < n){
8010111e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101121:	7e 6d                	jle    80101190 <filewrite+0xe0>
      int n1 = n - i;
80101123:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101126:	b8 00 06 00 00       	mov    $0x600,%eax
8010112b:	29 fb                	sub    %edi,%ebx
8010112d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101133:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101136:	e8 35 1b 00 00       	call   80102c70 <begin_op>
      ilock(f->ip);
8010113b:	83 ec 0c             	sub    $0xc,%esp
8010113e:	ff 76 10             	pushl  0x10(%esi)
80101141:	e8 0a 06 00 00       	call   80101750 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101146:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101149:	53                   	push   %ebx
8010114a:	ff 76 14             	pushl  0x14(%esi)
8010114d:	01 f8                	add    %edi,%eax
8010114f:	50                   	push   %eax
80101150:	ff 76 10             	pushl  0x10(%esi)
80101153:	e8 d8 09 00 00       	call   80101b30 <writei>
80101158:	83 c4 20             	add    $0x20,%esp
8010115b:	85 c0                	test   %eax,%eax
8010115d:	7f 99                	jg     801010f8 <filewrite+0x48>
      iunlock(f->ip);
8010115f:	83 ec 0c             	sub    $0xc,%esp
80101162:	ff 76 10             	pushl  0x10(%esi)
80101165:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101168:	e8 c3 06 00 00       	call   80101830 <iunlock>
      end_op();
8010116d:	e8 6e 1b 00 00       	call   80102ce0 <end_op>
      if(r < 0)
80101172:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101175:	83 c4 10             	add    $0x10,%esp
80101178:	85 c0                	test   %eax,%eax
8010117a:	74 98                	je     80101114 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010117c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010117f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101184:	89 f8                	mov    %edi,%eax
80101186:	5b                   	pop    %ebx
80101187:	5e                   	pop    %esi
80101188:	5f                   	pop    %edi
80101189:	5d                   	pop    %ebp
8010118a:	c3                   	ret    
8010118b:	90                   	nop
8010118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101190:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101193:	75 e7                	jne    8010117c <filewrite+0xcc>
}
80101195:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101198:	89 f8                	mov    %edi,%eax
8010119a:	5b                   	pop    %ebx
8010119b:	5e                   	pop    %esi
8010119c:	5f                   	pop    %edi
8010119d:	5d                   	pop    %ebp
8010119e:	c3                   	ret    
8010119f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801011a0:	8b 46 0c             	mov    0xc(%esi),%eax
801011a3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a9:	5b                   	pop    %ebx
801011aa:	5e                   	pop    %esi
801011ab:	5f                   	pop    %edi
801011ac:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011ad:	e9 0e 23 00 00       	jmp    801034c0 <pipewrite>
        panic("short filewrite");
801011b2:	83 ec 0c             	sub    $0xc,%esp
801011b5:	68 71 7b 10 80       	push   $0x80107b71
801011ba:	e8 d1 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
801011bf:	83 ec 0c             	sub    $0xc,%esp
801011c2:	68 77 7b 10 80       	push   $0x80107b77
801011c7:	e8 c4 f1 ff ff       	call   80100390 <panic>
801011cc:	66 90                	xchg   %ax,%ax
801011ce:	66 90                	xchg   %ax,%ax

801011d0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011d0:	55                   	push   %ebp
801011d1:	89 e5                	mov    %esp,%ebp
801011d3:	57                   	push   %edi
801011d4:	56                   	push   %esi
801011d5:	53                   	push   %ebx
801011d6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011d9:	8b 0d e0 19 11 80    	mov    0x801119e0,%ecx
{
801011df:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011e2:	85 c9                	test   %ecx,%ecx
801011e4:	0f 84 87 00 00 00    	je     80101271 <balloc+0xa1>
801011ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011f4:	83 ec 08             	sub    $0x8,%esp
801011f7:	89 f0                	mov    %esi,%eax
801011f9:	c1 f8 0c             	sar    $0xc,%eax
801011fc:	03 05 f8 19 11 80    	add    0x801119f8,%eax
80101202:	50                   	push   %eax
80101203:	ff 75 d8             	pushl  -0x28(%ebp)
80101206:	e8 c5 ee ff ff       	call   801000d0 <bread>
8010120b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010120e:	a1 e0 19 11 80       	mov    0x801119e0,%eax
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101219:	31 c0                	xor    %eax,%eax
8010121b:	eb 2f                	jmp    8010124c <balloc+0x7c>
8010121d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101220:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101222:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101225:	bb 01 00 00 00       	mov    $0x1,%ebx
8010122a:	83 e1 07             	and    $0x7,%ecx
8010122d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010122f:	89 c1                	mov    %eax,%ecx
80101231:	c1 f9 03             	sar    $0x3,%ecx
80101234:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101239:	85 df                	test   %ebx,%edi
8010123b:	89 fa                	mov    %edi,%edx
8010123d:	74 41                	je     80101280 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010123f:	83 c0 01             	add    $0x1,%eax
80101242:	83 c6 01             	add    $0x1,%esi
80101245:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010124a:	74 05                	je     80101251 <balloc+0x81>
8010124c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010124f:	77 cf                	ja     80101220 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101251:	83 ec 0c             	sub    $0xc,%esp
80101254:	ff 75 e4             	pushl  -0x1c(%ebp)
80101257:	e8 84 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010125c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101263:	83 c4 10             	add    $0x10,%esp
80101266:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101269:	39 05 e0 19 11 80    	cmp    %eax,0x801119e0
8010126f:	77 80                	ja     801011f1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101271:	83 ec 0c             	sub    $0xc,%esp
80101274:	68 81 7b 10 80       	push   $0x80107b81
80101279:	e8 12 f1 ff ff       	call   80100390 <panic>
8010127e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101280:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101283:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101286:	09 da                	or     %ebx,%edx
80101288:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010128c:	57                   	push   %edi
8010128d:	e8 ae 1b 00 00       	call   80102e40 <log_write>
        brelse(bp);
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 46 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010129a:	58                   	pop    %eax
8010129b:	5a                   	pop    %edx
8010129c:	56                   	push   %esi
8010129d:	ff 75 d8             	pushl  -0x28(%ebp)
801012a0:	e8 2b ee ff ff       	call   801000d0 <bread>
801012a5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801012aa:	83 c4 0c             	add    $0xc,%esp
801012ad:	68 00 02 00 00       	push   $0x200
801012b2:	6a 00                	push   $0x0
801012b4:	50                   	push   %eax
801012b5:	e8 f6 3a 00 00       	call   80104db0 <memset>
  log_write(bp);
801012ba:	89 1c 24             	mov    %ebx,(%esp)
801012bd:	e8 7e 1b 00 00       	call   80102e40 <log_write>
  brelse(bp);
801012c2:	89 1c 24             	mov    %ebx,(%esp)
801012c5:	e8 16 ef ff ff       	call   801001e0 <brelse>
}
801012ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012cd:	89 f0                	mov    %esi,%eax
801012cf:	5b                   	pop    %ebx
801012d0:	5e                   	pop    %esi
801012d1:	5f                   	pop    %edi
801012d2:	5d                   	pop    %ebp
801012d3:	c3                   	ret    
801012d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801012e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012e8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ea:	bb 34 1a 11 80       	mov    $0x80111a34,%ebx
{
801012ef:	83 ec 28             	sub    $0x28,%esp
801012f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012f5:	68 00 1a 11 80       	push   $0x80111a00
801012fa:	e8 a1 39 00 00       	call   80104ca0 <acquire>
801012ff:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101302:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101305:	eb 17                	jmp    8010131e <iget+0x3e>
80101307:	89 f6                	mov    %esi,%esi
80101309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101310:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101316:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
8010131c:	73 22                	jae    80101340 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010131e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101321:	85 c9                	test   %ecx,%ecx
80101323:	7e 04                	jle    80101329 <iget+0x49>
80101325:	39 3b                	cmp    %edi,(%ebx)
80101327:	74 4f                	je     80101378 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101329:	85 f6                	test   %esi,%esi
8010132b:	75 e3                	jne    80101310 <iget+0x30>
8010132d:	85 c9                	test   %ecx,%ecx
8010132f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101332:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101338:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
8010133e:	72 de                	jb     8010131e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101340:	85 f6                	test   %esi,%esi
80101342:	74 5b                	je     8010139f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101344:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101347:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101349:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010134c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101353:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010135a:	68 00 1a 11 80       	push   $0x80111a00
8010135f:	e8 fc 39 00 00       	call   80104d60 <release>

  return ip;
80101364:	83 c4 10             	add    $0x10,%esp
}
80101367:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136a:	89 f0                	mov    %esi,%eax
8010136c:	5b                   	pop    %ebx
8010136d:	5e                   	pop    %esi
8010136e:	5f                   	pop    %edi
8010136f:	5d                   	pop    %ebp
80101370:	c3                   	ret    
80101371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101378:	39 53 04             	cmp    %edx,0x4(%ebx)
8010137b:	75 ac                	jne    80101329 <iget+0x49>
      release(&icache.lock);
8010137d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101380:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101383:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101385:	68 00 1a 11 80       	push   $0x80111a00
      ip->ref++;
8010138a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010138d:	e8 ce 39 00 00       	call   80104d60 <release>
      return ip;
80101392:	83 c4 10             	add    $0x10,%esp
}
80101395:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101398:	89 f0                	mov    %esi,%eax
8010139a:	5b                   	pop    %ebx
8010139b:	5e                   	pop    %esi
8010139c:	5f                   	pop    %edi
8010139d:	5d                   	pop    %ebp
8010139e:	c3                   	ret    
    panic("iget: no inodes");
8010139f:	83 ec 0c             	sub    $0xc,%esp
801013a2:	68 97 7b 10 80       	push   $0x80107b97
801013a7:	e8 e4 ef ff ff       	call   80100390 <panic>
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
801013b4:	56                   	push   %esi
801013b5:	53                   	push   %ebx
801013b6:	89 c6                	mov    %eax,%esi
801013b8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013bb:	83 fa 0b             	cmp    $0xb,%edx
801013be:	77 18                	ja     801013d8 <bmap+0x28>
801013c0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013c3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013c6:	85 db                	test   %ebx,%ebx
801013c8:	74 76                	je     80101440 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013cd:	89 d8                	mov    %ebx,%eax
801013cf:	5b                   	pop    %ebx
801013d0:	5e                   	pop    %esi
801013d1:	5f                   	pop    %edi
801013d2:	5d                   	pop    %ebp
801013d3:	c3                   	ret    
801013d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801013d8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801013db:	83 fb 7f             	cmp    $0x7f,%ebx
801013de:	0f 87 90 00 00 00    	ja     80101474 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801013e4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013ea:	8b 00                	mov    (%eax),%eax
801013ec:	85 d2                	test   %edx,%edx
801013ee:	74 70                	je     80101460 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013f0:	83 ec 08             	sub    $0x8,%esp
801013f3:	52                   	push   %edx
801013f4:	50                   	push   %eax
801013f5:	e8 d6 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013fa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013fe:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101401:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101403:	8b 1a                	mov    (%edx),%ebx
80101405:	85 db                	test   %ebx,%ebx
80101407:	75 1d                	jne    80101426 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101409:	8b 06                	mov    (%esi),%eax
8010140b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010140e:	e8 bd fd ff ff       	call   801011d0 <balloc>
80101413:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101416:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101419:	89 c3                	mov    %eax,%ebx
8010141b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010141d:	57                   	push   %edi
8010141e:	e8 1d 1a 00 00       	call   80102e40 <log_write>
80101423:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101426:	83 ec 0c             	sub    $0xc,%esp
80101429:	57                   	push   %edi
8010142a:	e8 b1 ed ff ff       	call   801001e0 <brelse>
8010142f:	83 c4 10             	add    $0x10,%esp
}
80101432:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101435:	89 d8                	mov    %ebx,%eax
80101437:	5b                   	pop    %ebx
80101438:	5e                   	pop    %esi
80101439:	5f                   	pop    %edi
8010143a:	5d                   	pop    %ebp
8010143b:	c3                   	ret    
8010143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101440:	8b 00                	mov    (%eax),%eax
80101442:	e8 89 fd ff ff       	call   801011d0 <balloc>
80101447:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010144a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010144d:	89 c3                	mov    %eax,%ebx
}
8010144f:	89 d8                	mov    %ebx,%eax
80101451:	5b                   	pop    %ebx
80101452:	5e                   	pop    %esi
80101453:	5f                   	pop    %edi
80101454:	5d                   	pop    %ebp
80101455:	c3                   	ret    
80101456:	8d 76 00             	lea    0x0(%esi),%esi
80101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101460:	e8 6b fd ff ff       	call   801011d0 <balloc>
80101465:	89 c2                	mov    %eax,%edx
80101467:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010146d:	8b 06                	mov    (%esi),%eax
8010146f:	e9 7c ff ff ff       	jmp    801013f0 <bmap+0x40>
  panic("bmap: out of range");
80101474:	83 ec 0c             	sub    $0xc,%esp
80101477:	68 a7 7b 10 80       	push   $0x80107ba7
8010147c:	e8 0f ef ff ff       	call   80100390 <panic>
80101481:	eb 0d                	jmp    80101490 <readsb>
80101483:	90                   	nop
80101484:	90                   	nop
80101485:	90                   	nop
80101486:	90                   	nop
80101487:	90                   	nop
80101488:	90                   	nop
80101489:	90                   	nop
8010148a:	90                   	nop
8010148b:	90                   	nop
8010148c:	90                   	nop
8010148d:	90                   	nop
8010148e:	90                   	nop
8010148f:	90                   	nop

80101490 <readsb>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	56                   	push   %esi
80101494:	53                   	push   %ebx
80101495:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101498:	83 ec 08             	sub    $0x8,%esp
8010149b:	6a 01                	push   $0x1
8010149d:	ff 75 08             	pushl  0x8(%ebp)
801014a0:	e8 2b ec ff ff       	call   801000d0 <bread>
801014a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801014a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801014aa:	83 c4 0c             	add    $0xc,%esp
801014ad:	6a 1c                	push   $0x1c
801014af:	50                   	push   %eax
801014b0:	56                   	push   %esi
801014b1:	e8 aa 39 00 00       	call   80104e60 <memmove>
  brelse(bp);
801014b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014b9:	83 c4 10             	add    $0x10,%esp
}
801014bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014bf:	5b                   	pop    %ebx
801014c0:	5e                   	pop    %esi
801014c1:	5d                   	pop    %ebp
  brelse(bp);
801014c2:	e9 19 ed ff ff       	jmp    801001e0 <brelse>
801014c7:	89 f6                	mov    %esi,%esi
801014c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014d0 <bfree>:
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	56                   	push   %esi
801014d4:	53                   	push   %ebx
801014d5:	89 d3                	mov    %edx,%ebx
801014d7:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
801014d9:	83 ec 08             	sub    $0x8,%esp
801014dc:	68 e0 19 11 80       	push   $0x801119e0
801014e1:	50                   	push   %eax
801014e2:	e8 a9 ff ff ff       	call   80101490 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014e7:	58                   	pop    %eax
801014e8:	5a                   	pop    %edx
801014e9:	89 da                	mov    %ebx,%edx
801014eb:	c1 ea 0c             	shr    $0xc,%edx
801014ee:	03 15 f8 19 11 80    	add    0x801119f8,%edx
801014f4:	52                   	push   %edx
801014f5:	56                   	push   %esi
801014f6:	e8 d5 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014fb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014fd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101500:	ba 01 00 00 00       	mov    $0x1,%edx
80101505:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101508:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010150e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101511:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101513:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101518:	85 d1                	test   %edx,%ecx
8010151a:	74 25                	je     80101541 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010151c:	f7 d2                	not    %edx
8010151e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101520:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101523:	21 ca                	and    %ecx,%edx
80101525:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101529:	56                   	push   %esi
8010152a:	e8 11 19 00 00       	call   80102e40 <log_write>
  brelse(bp);
8010152f:	89 34 24             	mov    %esi,(%esp)
80101532:	e8 a9 ec ff ff       	call   801001e0 <brelse>
}
80101537:	83 c4 10             	add    $0x10,%esp
8010153a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010153d:	5b                   	pop    %ebx
8010153e:	5e                   	pop    %esi
8010153f:	5d                   	pop    %ebp
80101540:	c3                   	ret    
    panic("freeing free block");
80101541:	83 ec 0c             	sub    $0xc,%esp
80101544:	68 ba 7b 10 80       	push   $0x80107bba
80101549:	e8 42 ee ff ff       	call   80100390 <panic>
8010154e:	66 90                	xchg   %ax,%ax

80101550 <iinit>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	53                   	push   %ebx
80101554:	bb 40 1a 11 80       	mov    $0x80111a40,%ebx
80101559:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010155c:	68 cd 7b 10 80       	push   $0x80107bcd
80101561:	68 00 1a 11 80       	push   $0x80111a00
80101566:	e8 f5 35 00 00       	call   80104b60 <initlock>
8010156b:	83 c4 10             	add    $0x10,%esp
8010156e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101570:	83 ec 08             	sub    $0x8,%esp
80101573:	68 d4 7b 10 80       	push   $0x80107bd4
80101578:	53                   	push   %ebx
80101579:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010157f:	e8 ac 34 00 00       	call   80104a30 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101584:	83 c4 10             	add    $0x10,%esp
80101587:	81 fb 60 36 11 80    	cmp    $0x80113660,%ebx
8010158d:	75 e1                	jne    80101570 <iinit+0x20>
  readsb(dev, &sb);
8010158f:	83 ec 08             	sub    $0x8,%esp
80101592:	68 e0 19 11 80       	push   $0x801119e0
80101597:	ff 75 08             	pushl  0x8(%ebp)
8010159a:	e8 f1 fe ff ff       	call   80101490 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010159f:	ff 35 f8 19 11 80    	pushl  0x801119f8
801015a5:	ff 35 f4 19 11 80    	pushl  0x801119f4
801015ab:	ff 35 f0 19 11 80    	pushl  0x801119f0
801015b1:	ff 35 ec 19 11 80    	pushl  0x801119ec
801015b7:	ff 35 e8 19 11 80    	pushl  0x801119e8
801015bd:	ff 35 e4 19 11 80    	pushl  0x801119e4
801015c3:	ff 35 e0 19 11 80    	pushl  0x801119e0
801015c9:	68 38 7c 10 80       	push   $0x80107c38
801015ce:	e8 8d f0 ff ff       	call   80100660 <cprintf>
}
801015d3:	83 c4 30             	add    $0x30,%esp
801015d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015d9:	c9                   	leave  
801015da:	c3                   	ret    
801015db:	90                   	nop
801015dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015e0 <ialloc>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	57                   	push   %edi
801015e4:	56                   	push   %esi
801015e5:	53                   	push   %ebx
801015e6:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015e9:	83 3d e8 19 11 80 01 	cmpl   $0x1,0x801119e8
{
801015f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801015f3:	8b 75 08             	mov    0x8(%ebp),%esi
801015f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015f9:	0f 86 91 00 00 00    	jbe    80101690 <ialloc+0xb0>
801015ff:	bb 01 00 00 00       	mov    $0x1,%ebx
80101604:	eb 21                	jmp    80101627 <ialloc+0x47>
80101606:	8d 76 00             	lea    0x0(%esi),%esi
80101609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101610:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101613:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101616:	57                   	push   %edi
80101617:	e8 c4 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010161c:	83 c4 10             	add    $0x10,%esp
8010161f:	39 1d e8 19 11 80    	cmp    %ebx,0x801119e8
80101625:	76 69                	jbe    80101690 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101627:	89 d8                	mov    %ebx,%eax
80101629:	83 ec 08             	sub    $0x8,%esp
8010162c:	c1 e8 03             	shr    $0x3,%eax
8010162f:	03 05 f4 19 11 80    	add    0x801119f4,%eax
80101635:	50                   	push   %eax
80101636:	56                   	push   %esi
80101637:	e8 94 ea ff ff       	call   801000d0 <bread>
8010163c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010163e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101640:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101643:	83 e0 07             	and    $0x7,%eax
80101646:	c1 e0 06             	shl    $0x6,%eax
80101649:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010164d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101651:	75 bd                	jne    80101610 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101653:	83 ec 04             	sub    $0x4,%esp
80101656:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101659:	6a 40                	push   $0x40
8010165b:	6a 00                	push   $0x0
8010165d:	51                   	push   %ecx
8010165e:	e8 4d 37 00 00       	call   80104db0 <memset>
      dip->type = type;
80101663:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101667:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010166a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010166d:	89 3c 24             	mov    %edi,(%esp)
80101670:	e8 cb 17 00 00       	call   80102e40 <log_write>
      brelse(bp);
80101675:	89 3c 24             	mov    %edi,(%esp)
80101678:	e8 63 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010167d:	83 c4 10             	add    $0x10,%esp
}
80101680:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101683:	89 da                	mov    %ebx,%edx
80101685:	89 f0                	mov    %esi,%eax
}
80101687:	5b                   	pop    %ebx
80101688:	5e                   	pop    %esi
80101689:	5f                   	pop    %edi
8010168a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010168b:	e9 50 fc ff ff       	jmp    801012e0 <iget>
  panic("ialloc: no inodes");
80101690:	83 ec 0c             	sub    $0xc,%esp
80101693:	68 da 7b 10 80       	push   $0x80107bda
80101698:	e8 f3 ec ff ff       	call   80100390 <panic>
8010169d:	8d 76 00             	lea    0x0(%esi),%esi

801016a0 <iupdate>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	56                   	push   %esi
801016a4:	53                   	push   %ebx
801016a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a8:	83 ec 08             	sub    $0x8,%esp
801016ab:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ae:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b1:	c1 e8 03             	shr    $0x3,%eax
801016b4:	03 05 f4 19 11 80    	add    0x801119f4,%eax
801016ba:	50                   	push   %eax
801016bb:	ff 73 a4             	pushl  -0x5c(%ebx)
801016be:	e8 0d ea ff ff       	call   801000d0 <bread>
801016c3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016c5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801016c8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016cc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016d9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016dc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016e0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016e3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016e7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016eb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016ef:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016f3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016f7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016fa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016fd:	6a 34                	push   $0x34
801016ff:	53                   	push   %ebx
80101700:	50                   	push   %eax
80101701:	e8 5a 37 00 00       	call   80104e60 <memmove>
  log_write(bp);
80101706:	89 34 24             	mov    %esi,(%esp)
80101709:	e8 32 17 00 00       	call   80102e40 <log_write>
  brelse(bp);
8010170e:	89 75 08             	mov    %esi,0x8(%ebp)
80101711:	83 c4 10             	add    $0x10,%esp
}
80101714:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101717:	5b                   	pop    %ebx
80101718:	5e                   	pop    %esi
80101719:	5d                   	pop    %ebp
  brelse(bp);
8010171a:	e9 c1 ea ff ff       	jmp    801001e0 <brelse>
8010171f:	90                   	nop

80101720 <idup>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	53                   	push   %ebx
80101724:	83 ec 10             	sub    $0x10,%esp
80101727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010172a:	68 00 1a 11 80       	push   $0x80111a00
8010172f:	e8 6c 35 00 00       	call   80104ca0 <acquire>
  ip->ref++;
80101734:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101738:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
8010173f:	e8 1c 36 00 00       	call   80104d60 <release>
}
80101744:	89 d8                	mov    %ebx,%eax
80101746:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101749:	c9                   	leave  
8010174a:	c3                   	ret    
8010174b:	90                   	nop
8010174c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101750 <ilock>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101758:	85 db                	test   %ebx,%ebx
8010175a:	0f 84 b7 00 00 00    	je     80101817 <ilock+0xc7>
80101760:	8b 53 08             	mov    0x8(%ebx),%edx
80101763:	85 d2                	test   %edx,%edx
80101765:	0f 8e ac 00 00 00    	jle    80101817 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010176b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010176e:	83 ec 0c             	sub    $0xc,%esp
80101771:	50                   	push   %eax
80101772:	e8 f9 32 00 00       	call   80104a70 <acquiresleep>
  if(ip->valid == 0){
80101777:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010177a:	83 c4 10             	add    $0x10,%esp
8010177d:	85 c0                	test   %eax,%eax
8010177f:	74 0f                	je     80101790 <ilock+0x40>
}
80101781:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101784:	5b                   	pop    %ebx
80101785:	5e                   	pop    %esi
80101786:	5d                   	pop    %ebp
80101787:	c3                   	ret    
80101788:	90                   	nop
80101789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101790:	8b 43 04             	mov    0x4(%ebx),%eax
80101793:	83 ec 08             	sub    $0x8,%esp
80101796:	c1 e8 03             	shr    $0x3,%eax
80101799:	03 05 f4 19 11 80    	add    0x801119f4,%eax
8010179f:	50                   	push   %eax
801017a0:	ff 33                	pushl  (%ebx)
801017a2:	e8 29 e9 ff ff       	call   801000d0 <bread>
801017a7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017a9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ac:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017af:	83 e0 07             	and    $0x7,%eax
801017b2:	c1 e0 06             	shl    $0x6,%eax
801017b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017b9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017bc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017bf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017c3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017c7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017cb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017cf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017d3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017d7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017db:	8b 50 fc             	mov    -0x4(%eax),%edx
801017de:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017e1:	6a 34                	push   $0x34
801017e3:	50                   	push   %eax
801017e4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017e7:	50                   	push   %eax
801017e8:	e8 73 36 00 00       	call   80104e60 <memmove>
    brelse(bp);
801017ed:	89 34 24             	mov    %esi,(%esp)
801017f0:	e8 eb e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801017f5:	83 c4 10             	add    $0x10,%esp
801017f8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017fd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101804:	0f 85 77 ff ff ff    	jne    80101781 <ilock+0x31>
      panic("ilock: no type");
8010180a:	83 ec 0c             	sub    $0xc,%esp
8010180d:	68 f2 7b 10 80       	push   $0x80107bf2
80101812:	e8 79 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101817:	83 ec 0c             	sub    $0xc,%esp
8010181a:	68 ec 7b 10 80       	push   $0x80107bec
8010181f:	e8 6c eb ff ff       	call   80100390 <panic>
80101824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010182a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101830 <iunlock>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	56                   	push   %esi
80101834:	53                   	push   %ebx
80101835:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101838:	85 db                	test   %ebx,%ebx
8010183a:	74 28                	je     80101864 <iunlock+0x34>
8010183c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010183f:	83 ec 0c             	sub    $0xc,%esp
80101842:	56                   	push   %esi
80101843:	e8 c8 32 00 00       	call   80104b10 <holdingsleep>
80101848:	83 c4 10             	add    $0x10,%esp
8010184b:	85 c0                	test   %eax,%eax
8010184d:	74 15                	je     80101864 <iunlock+0x34>
8010184f:	8b 43 08             	mov    0x8(%ebx),%eax
80101852:	85 c0                	test   %eax,%eax
80101854:	7e 0e                	jle    80101864 <iunlock+0x34>
  releasesleep(&ip->lock);
80101856:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101859:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010185c:	5b                   	pop    %ebx
8010185d:	5e                   	pop    %esi
8010185e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010185f:	e9 6c 32 00 00       	jmp    80104ad0 <releasesleep>
    panic("iunlock");
80101864:	83 ec 0c             	sub    $0xc,%esp
80101867:	68 01 7c 10 80       	push   $0x80107c01
8010186c:	e8 1f eb ff ff       	call   80100390 <panic>
80101871:	eb 0d                	jmp    80101880 <iput>
80101873:	90                   	nop
80101874:	90                   	nop
80101875:	90                   	nop
80101876:	90                   	nop
80101877:	90                   	nop
80101878:	90                   	nop
80101879:	90                   	nop
8010187a:	90                   	nop
8010187b:	90                   	nop
8010187c:	90                   	nop
8010187d:	90                   	nop
8010187e:	90                   	nop
8010187f:	90                   	nop

80101880 <iput>:
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	57                   	push   %edi
80101884:	56                   	push   %esi
80101885:	53                   	push   %ebx
80101886:	83 ec 28             	sub    $0x28,%esp
80101889:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010188c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010188f:	57                   	push   %edi
80101890:	e8 db 31 00 00       	call   80104a70 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101895:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101898:	83 c4 10             	add    $0x10,%esp
8010189b:	85 d2                	test   %edx,%edx
8010189d:	74 07                	je     801018a6 <iput+0x26>
8010189f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018a4:	74 32                	je     801018d8 <iput+0x58>
  releasesleep(&ip->lock);
801018a6:	83 ec 0c             	sub    $0xc,%esp
801018a9:	57                   	push   %edi
801018aa:	e8 21 32 00 00       	call   80104ad0 <releasesleep>
  acquire(&icache.lock);
801018af:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
801018b6:	e8 e5 33 00 00       	call   80104ca0 <acquire>
  ip->ref--;
801018bb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018bf:	83 c4 10             	add    $0x10,%esp
801018c2:	c7 45 08 00 1a 11 80 	movl   $0x80111a00,0x8(%ebp)
}
801018c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018cc:	5b                   	pop    %ebx
801018cd:	5e                   	pop    %esi
801018ce:	5f                   	pop    %edi
801018cf:	5d                   	pop    %ebp
  release(&icache.lock);
801018d0:	e9 8b 34 00 00       	jmp    80104d60 <release>
801018d5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018d8:	83 ec 0c             	sub    $0xc,%esp
801018db:	68 00 1a 11 80       	push   $0x80111a00
801018e0:	e8 bb 33 00 00       	call   80104ca0 <acquire>
    int r = ip->ref;
801018e5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018e8:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
801018ef:	e8 6c 34 00 00       	call   80104d60 <release>
    if(r == 1){
801018f4:	83 c4 10             	add    $0x10,%esp
801018f7:	83 fe 01             	cmp    $0x1,%esi
801018fa:	75 aa                	jne    801018a6 <iput+0x26>
801018fc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101902:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101905:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101908:	89 cf                	mov    %ecx,%edi
8010190a:	eb 0b                	jmp    80101917 <iput+0x97>
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101910:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101913:	39 fe                	cmp    %edi,%esi
80101915:	74 19                	je     80101930 <iput+0xb0>
    if(ip->addrs[i]){
80101917:	8b 16                	mov    (%esi),%edx
80101919:	85 d2                	test   %edx,%edx
8010191b:	74 f3                	je     80101910 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010191d:	8b 03                	mov    (%ebx),%eax
8010191f:	e8 ac fb ff ff       	call   801014d0 <bfree>
      ip->addrs[i] = 0;
80101924:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010192a:	eb e4                	jmp    80101910 <iput+0x90>
8010192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101930:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101936:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101939:	85 c0                	test   %eax,%eax
8010193b:	75 33                	jne    80101970 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010193d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101940:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101947:	53                   	push   %ebx
80101948:	e8 53 fd ff ff       	call   801016a0 <iupdate>
      ip->type = 0;
8010194d:	31 c0                	xor    %eax,%eax
8010194f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101953:	89 1c 24             	mov    %ebx,(%esp)
80101956:	e8 45 fd ff ff       	call   801016a0 <iupdate>
      ip->valid = 0;
8010195b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101962:	83 c4 10             	add    $0x10,%esp
80101965:	e9 3c ff ff ff       	jmp    801018a6 <iput+0x26>
8010196a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101970:	83 ec 08             	sub    $0x8,%esp
80101973:	50                   	push   %eax
80101974:	ff 33                	pushl  (%ebx)
80101976:	e8 55 e7 ff ff       	call   801000d0 <bread>
8010197b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101981:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101984:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101987:	8d 70 5c             	lea    0x5c(%eax),%esi
8010198a:	83 c4 10             	add    $0x10,%esp
8010198d:	89 cf                	mov    %ecx,%edi
8010198f:	eb 0e                	jmp    8010199f <iput+0x11f>
80101991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101998:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010199b:	39 fe                	cmp    %edi,%esi
8010199d:	74 0f                	je     801019ae <iput+0x12e>
      if(a[j])
8010199f:	8b 16                	mov    (%esi),%edx
801019a1:	85 d2                	test   %edx,%edx
801019a3:	74 f3                	je     80101998 <iput+0x118>
        bfree(ip->dev, a[j]);
801019a5:	8b 03                	mov    (%ebx),%eax
801019a7:	e8 24 fb ff ff       	call   801014d0 <bfree>
801019ac:	eb ea                	jmp    80101998 <iput+0x118>
    brelse(bp);
801019ae:	83 ec 0c             	sub    $0xc,%esp
801019b1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019b7:	e8 24 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019bc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019c2:	8b 03                	mov    (%ebx),%eax
801019c4:	e8 07 fb ff ff       	call   801014d0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019c9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019d0:	00 00 00 
801019d3:	83 c4 10             	add    $0x10,%esp
801019d6:	e9 62 ff ff ff       	jmp    8010193d <iput+0xbd>
801019db:	90                   	nop
801019dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019e0 <iunlockput>:
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	53                   	push   %ebx
801019e4:	83 ec 10             	sub    $0x10,%esp
801019e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019ea:	53                   	push   %ebx
801019eb:	e8 40 fe ff ff       	call   80101830 <iunlock>
  iput(ip);
801019f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019f3:	83 c4 10             	add    $0x10,%esp
}
801019f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019f9:	c9                   	leave  
  iput(ip);
801019fa:	e9 81 fe ff ff       	jmp    80101880 <iput>
801019ff:	90                   	nop

80101a00 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	8b 55 08             	mov    0x8(%ebp),%edx
80101a06:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a09:	8b 0a                	mov    (%edx),%ecx
80101a0b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a0e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a11:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a14:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a18:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a1b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a1f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a23:	8b 52 58             	mov    0x58(%edx),%edx
80101a26:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a29:	5d                   	pop    %ebp
80101a2a:	c3                   	ret    
80101a2b:	90                   	nop
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a30 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a30:	55                   	push   %ebp
80101a31:	89 e5                	mov    %esp,%ebp
80101a33:	57                   	push   %edi
80101a34:	56                   	push   %esi
80101a35:	53                   	push   %ebx
80101a36:	83 ec 1c             	sub    $0x1c,%esp
80101a39:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a3f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a42:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a47:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101a4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a4d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a50:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a53:	0f 84 a7 00 00 00    	je     80101b00 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a5c:	8b 40 58             	mov    0x58(%eax),%eax
80101a5f:	39 c6                	cmp    %eax,%esi
80101a61:	0f 87 ba 00 00 00    	ja     80101b21 <readi+0xf1>
80101a67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a6a:	89 f9                	mov    %edi,%ecx
80101a6c:	01 f1                	add    %esi,%ecx
80101a6e:	0f 82 ad 00 00 00    	jb     80101b21 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a74:	89 c2                	mov    %eax,%edx
80101a76:	29 f2                	sub    %esi,%edx
80101a78:	39 c8                	cmp    %ecx,%eax
80101a7a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a7d:	31 ff                	xor    %edi,%edi
80101a7f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101a81:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a84:	74 6c                	je     80101af2 <readi+0xc2>
80101a86:	8d 76 00             	lea    0x0(%esi),%esi
80101a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a90:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a93:	89 f2                	mov    %esi,%edx
80101a95:	c1 ea 09             	shr    $0x9,%edx
80101a98:	89 d8                	mov    %ebx,%eax
80101a9a:	e8 11 f9 ff ff       	call   801013b0 <bmap>
80101a9f:	83 ec 08             	sub    $0x8,%esp
80101aa2:	50                   	push   %eax
80101aa3:	ff 33                	pushl  (%ebx)
80101aa5:	e8 26 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aaa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aad:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aaf:	89 f0                	mov    %esi,%eax
80101ab1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ab6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101abb:	83 c4 0c             	add    $0xc,%esp
80101abe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ac0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101ac4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac7:	29 fb                	sub    %edi,%ebx
80101ac9:	39 d9                	cmp    %ebx,%ecx
80101acb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ace:	53                   	push   %ebx
80101acf:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ad0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ad2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ad5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ad7:	e8 84 33 00 00       	call   80104e60 <memmove>
    brelse(bp);
80101adc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101adf:	89 14 24             	mov    %edx,(%esp)
80101ae2:	e8 f9 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101aea:	83 c4 10             	add    $0x10,%esp
80101aed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101af0:	77 9e                	ja     80101a90 <readi+0x60>
  }
  return n;
80101af2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101af5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101af8:	5b                   	pop    %ebx
80101af9:	5e                   	pop    %esi
80101afa:	5f                   	pop    %edi
80101afb:	5d                   	pop    %ebp
80101afc:	c3                   	ret    
80101afd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b04:	66 83 f8 09          	cmp    $0x9,%ax
80101b08:	77 17                	ja     80101b21 <readi+0xf1>
80101b0a:	8b 04 c5 80 19 11 80 	mov    -0x7feee680(,%eax,8),%eax
80101b11:	85 c0                	test   %eax,%eax
80101b13:	74 0c                	je     80101b21 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b15:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1b:	5b                   	pop    %ebx
80101b1c:	5e                   	pop    %esi
80101b1d:	5f                   	pop    %edi
80101b1e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b1f:	ff e0                	jmp    *%eax
      return -1;
80101b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b26:	eb cd                	jmp    80101af5 <readi+0xc5>
80101b28:	90                   	nop
80101b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b30 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	57                   	push   %edi
80101b34:	56                   	push   %esi
80101b35:	53                   	push   %ebx
80101b36:	83 ec 1c             	sub    $0x1c,%esp
80101b39:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b3f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b42:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b47:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b4d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b50:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b53:	0f 84 b7 00 00 00    	je     80101c10 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b5f:	0f 82 eb 00 00 00    	jb     80101c50 <writei+0x120>
80101b65:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b68:	31 d2                	xor    %edx,%edx
80101b6a:	89 f8                	mov    %edi,%eax
80101b6c:	01 f0                	add    %esi,%eax
80101b6e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b71:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b76:	0f 87 d4 00 00 00    	ja     80101c50 <writei+0x120>
80101b7c:	85 d2                	test   %edx,%edx
80101b7e:	0f 85 cc 00 00 00    	jne    80101c50 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b84:	85 ff                	test   %edi,%edi
80101b86:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b8d:	74 72                	je     80101c01 <writei+0xd1>
80101b8f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b90:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b93:	89 f2                	mov    %esi,%edx
80101b95:	c1 ea 09             	shr    $0x9,%edx
80101b98:	89 f8                	mov    %edi,%eax
80101b9a:	e8 11 f8 ff ff       	call   801013b0 <bmap>
80101b9f:	83 ec 08             	sub    $0x8,%esp
80101ba2:	50                   	push   %eax
80101ba3:	ff 37                	pushl  (%edi)
80101ba5:	e8 26 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101baa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bad:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bb2:	89 f0                	mov    %esi,%eax
80101bb4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bb9:	83 c4 0c             	add    $0xc,%esp
80101bbc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bc1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bc3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc7:	39 d9                	cmp    %ebx,%ecx
80101bc9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bcc:	53                   	push   %ebx
80101bcd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bd0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101bd2:	50                   	push   %eax
80101bd3:	e8 88 32 00 00       	call   80104e60 <memmove>
    log_write(bp);
80101bd8:	89 3c 24             	mov    %edi,(%esp)
80101bdb:	e8 60 12 00 00       	call   80102e40 <log_write>
    brelse(bp);
80101be0:	89 3c 24             	mov    %edi,(%esp)
80101be3:	e8 f8 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101beb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bee:	83 c4 10             	add    $0x10,%esp
80101bf1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bf4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101bf7:	77 97                	ja     80101b90 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101bf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bff:	77 37                	ja     80101c38 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c01:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c07:	5b                   	pop    %ebx
80101c08:	5e                   	pop    %esi
80101c09:	5f                   	pop    %edi
80101c0a:	5d                   	pop    %ebp
80101c0b:	c3                   	ret    
80101c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c14:	66 83 f8 09          	cmp    $0x9,%ax
80101c18:	77 36                	ja     80101c50 <writei+0x120>
80101c1a:	8b 04 c5 84 19 11 80 	mov    -0x7feee67c(,%eax,8),%eax
80101c21:	85 c0                	test   %eax,%eax
80101c23:	74 2b                	je     80101c50 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101c25:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c2b:	5b                   	pop    %ebx
80101c2c:	5e                   	pop    %esi
80101c2d:	5f                   	pop    %edi
80101c2e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c2f:	ff e0                	jmp    *%eax
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c38:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c3b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c3e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c41:	50                   	push   %eax
80101c42:	e8 59 fa ff ff       	call   801016a0 <iupdate>
80101c47:	83 c4 10             	add    $0x10,%esp
80101c4a:	eb b5                	jmp    80101c01 <writei+0xd1>
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c55:	eb ad                	jmp    80101c04 <writei+0xd4>
80101c57:	89 f6                	mov    %esi,%esi
80101c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c60 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c66:	6a 0e                	push   $0xe
80101c68:	ff 75 0c             	pushl  0xc(%ebp)
80101c6b:	ff 75 08             	pushl  0x8(%ebp)
80101c6e:	e8 5d 32 00 00       	call   80104ed0 <strncmp>
}
80101c73:	c9                   	leave  
80101c74:	c3                   	ret    
80101c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c80 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	83 ec 1c             	sub    $0x1c,%esp
80101c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c8c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c91:	0f 85 85 00 00 00    	jne    80101d1c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c97:	8b 53 58             	mov    0x58(%ebx),%edx
80101c9a:	31 ff                	xor    %edi,%edi
80101c9c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c9f:	85 d2                	test   %edx,%edx
80101ca1:	74 3e                	je     80101ce1 <dirlookup+0x61>
80101ca3:	90                   	nop
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ca8:	6a 10                	push   $0x10
80101caa:	57                   	push   %edi
80101cab:	56                   	push   %esi
80101cac:	53                   	push   %ebx
80101cad:	e8 7e fd ff ff       	call   80101a30 <readi>
80101cb2:	83 c4 10             	add    $0x10,%esp
80101cb5:	83 f8 10             	cmp    $0x10,%eax
80101cb8:	75 55                	jne    80101d0f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101cba:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cbf:	74 18                	je     80101cd9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101cc1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cc4:	83 ec 04             	sub    $0x4,%esp
80101cc7:	6a 0e                	push   $0xe
80101cc9:	50                   	push   %eax
80101cca:	ff 75 0c             	pushl  0xc(%ebp)
80101ccd:	e8 fe 31 00 00       	call   80104ed0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cd2:	83 c4 10             	add    $0x10,%esp
80101cd5:	85 c0                	test   %eax,%eax
80101cd7:	74 17                	je     80101cf0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101cd9:	83 c7 10             	add    $0x10,%edi
80101cdc:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cdf:	72 c7                	jb     80101ca8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101ce4:	31 c0                	xor    %eax,%eax
}
80101ce6:	5b                   	pop    %ebx
80101ce7:	5e                   	pop    %esi
80101ce8:	5f                   	pop    %edi
80101ce9:	5d                   	pop    %ebp
80101cea:	c3                   	ret    
80101ceb:	90                   	nop
80101cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101cf0:	8b 45 10             	mov    0x10(%ebp),%eax
80101cf3:	85 c0                	test   %eax,%eax
80101cf5:	74 05                	je     80101cfc <dirlookup+0x7c>
        *poff = off;
80101cf7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cfa:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cfc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d00:	8b 03                	mov    (%ebx),%eax
80101d02:	e8 d9 f5 ff ff       	call   801012e0 <iget>
}
80101d07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0a:	5b                   	pop    %ebx
80101d0b:	5e                   	pop    %esi
80101d0c:	5f                   	pop    %edi
80101d0d:	5d                   	pop    %ebp
80101d0e:	c3                   	ret    
      panic("dirlookup read");
80101d0f:	83 ec 0c             	sub    $0xc,%esp
80101d12:	68 1b 7c 10 80       	push   $0x80107c1b
80101d17:	e8 74 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d1c:	83 ec 0c             	sub    $0xc,%esp
80101d1f:	68 09 7c 10 80       	push   $0x80107c09
80101d24:	e8 67 e6 ff ff       	call   80100390 <panic>
80101d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d30 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	57                   	push   %edi
80101d34:	56                   	push   %esi
80101d35:	53                   	push   %ebx
80101d36:	89 cf                	mov    %ecx,%edi
80101d38:	89 c3                	mov    %eax,%ebx
80101d3a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d3d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d40:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d43:	0f 84 67 01 00 00    	je     80101eb0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d49:	e8 12 1c 00 00       	call   80103960 <myproc>
  acquire(&icache.lock);
80101d4e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d51:	8b 70 58             	mov    0x58(%eax),%esi
  acquire(&icache.lock);
80101d54:	68 00 1a 11 80       	push   $0x80111a00
80101d59:	e8 42 2f 00 00       	call   80104ca0 <acquire>
  ip->ref++;
80101d5e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d62:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101d69:	e8 f2 2f 00 00       	call   80104d60 <release>
80101d6e:	83 c4 10             	add    $0x10,%esp
80101d71:	eb 08                	jmp    80101d7b <namex+0x4b>
80101d73:	90                   	nop
80101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101d78:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d7b:	0f b6 03             	movzbl (%ebx),%eax
80101d7e:	3c 2f                	cmp    $0x2f,%al
80101d80:	74 f6                	je     80101d78 <namex+0x48>
  if(*path == 0)
80101d82:	84 c0                	test   %al,%al
80101d84:	0f 84 ee 00 00 00    	je     80101e78 <namex+0x148>
  while(*path != '/' && *path != 0)
80101d8a:	0f b6 03             	movzbl (%ebx),%eax
80101d8d:	3c 2f                	cmp    $0x2f,%al
80101d8f:	0f 84 b3 00 00 00    	je     80101e48 <namex+0x118>
80101d95:	84 c0                	test   %al,%al
80101d97:	89 da                	mov    %ebx,%edx
80101d99:	75 09                	jne    80101da4 <namex+0x74>
80101d9b:	e9 a8 00 00 00       	jmp    80101e48 <namex+0x118>
80101da0:	84 c0                	test   %al,%al
80101da2:	74 0a                	je     80101dae <namex+0x7e>
    path++;
80101da4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101da7:	0f b6 02             	movzbl (%edx),%eax
80101daa:	3c 2f                	cmp    $0x2f,%al
80101dac:	75 f2                	jne    80101da0 <namex+0x70>
80101dae:	89 d1                	mov    %edx,%ecx
80101db0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101db2:	83 f9 0d             	cmp    $0xd,%ecx
80101db5:	0f 8e 91 00 00 00    	jle    80101e4c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101dbb:	83 ec 04             	sub    $0x4,%esp
80101dbe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101dc1:	6a 0e                	push   $0xe
80101dc3:	53                   	push   %ebx
80101dc4:	57                   	push   %edi
80101dc5:	e8 96 30 00 00       	call   80104e60 <memmove>
    path++;
80101dca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101dcd:	83 c4 10             	add    $0x10,%esp
    path++;
80101dd0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101dd2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101dd5:	75 11                	jne    80101de8 <namex+0xb8>
80101dd7:	89 f6                	mov    %esi,%esi
80101dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101de0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101de3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101de6:	74 f8                	je     80101de0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	56                   	push   %esi
80101dec:	e8 5f f9 ff ff       	call   80101750 <ilock>
    if(ip->type != T_DIR){
80101df1:	83 c4 10             	add    $0x10,%esp
80101df4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101df9:	0f 85 91 00 00 00    	jne    80101e90 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101dff:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e02:	85 d2                	test   %edx,%edx
80101e04:	74 09                	je     80101e0f <namex+0xdf>
80101e06:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e09:	0f 84 b7 00 00 00    	je     80101ec6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e0f:	83 ec 04             	sub    $0x4,%esp
80101e12:	6a 00                	push   $0x0
80101e14:	57                   	push   %edi
80101e15:	56                   	push   %esi
80101e16:	e8 65 fe ff ff       	call   80101c80 <dirlookup>
80101e1b:	83 c4 10             	add    $0x10,%esp
80101e1e:	85 c0                	test   %eax,%eax
80101e20:	74 6e                	je     80101e90 <namex+0x160>
  iunlock(ip);
80101e22:	83 ec 0c             	sub    $0xc,%esp
80101e25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e28:	56                   	push   %esi
80101e29:	e8 02 fa ff ff       	call   80101830 <iunlock>
  iput(ip);
80101e2e:	89 34 24             	mov    %esi,(%esp)
80101e31:	e8 4a fa ff ff       	call   80101880 <iput>
80101e36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e39:	83 c4 10             	add    $0x10,%esp
80101e3c:	89 c6                	mov    %eax,%esi
80101e3e:	e9 38 ff ff ff       	jmp    80101d7b <namex+0x4b>
80101e43:	90                   	nop
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e48:	89 da                	mov    %ebx,%edx
80101e4a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e4c:	83 ec 04             	sub    $0x4,%esp
80101e4f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e52:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e55:	51                   	push   %ecx
80101e56:	53                   	push   %ebx
80101e57:	57                   	push   %edi
80101e58:	e8 03 30 00 00       	call   80104e60 <memmove>
    name[len] = 0;
80101e5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e60:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e63:	83 c4 10             	add    $0x10,%esp
80101e66:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e6a:	89 d3                	mov    %edx,%ebx
80101e6c:	e9 61 ff ff ff       	jmp    80101dd2 <namex+0xa2>
80101e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e7b:	85 c0                	test   %eax,%eax
80101e7d:	75 5d                	jne    80101edc <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e82:	89 f0                	mov    %esi,%eax
80101e84:	5b                   	pop    %ebx
80101e85:	5e                   	pop    %esi
80101e86:	5f                   	pop    %edi
80101e87:	5d                   	pop    %ebp
80101e88:	c3                   	ret    
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	56                   	push   %esi
80101e94:	e8 97 f9 ff ff       	call   80101830 <iunlock>
  iput(ip);
80101e99:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e9c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e9e:	e8 dd f9 ff ff       	call   80101880 <iput>
      return 0;
80101ea3:	83 c4 10             	add    $0x10,%esp
}
80101ea6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea9:	89 f0                	mov    %esi,%eax
80101eab:	5b                   	pop    %ebx
80101eac:	5e                   	pop    %esi
80101ead:	5f                   	pop    %edi
80101eae:	5d                   	pop    %ebp
80101eaf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101eb0:	ba 01 00 00 00       	mov    $0x1,%edx
80101eb5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eba:	e8 21 f4 ff ff       	call   801012e0 <iget>
80101ebf:	89 c6                	mov    %eax,%esi
80101ec1:	e9 b5 fe ff ff       	jmp    80101d7b <namex+0x4b>
      iunlock(ip);
80101ec6:	83 ec 0c             	sub    $0xc,%esp
80101ec9:	56                   	push   %esi
80101eca:	e8 61 f9 ff ff       	call   80101830 <iunlock>
      return ip;
80101ecf:	83 c4 10             	add    $0x10,%esp
}
80101ed2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed5:	89 f0                	mov    %esi,%eax
80101ed7:	5b                   	pop    %ebx
80101ed8:	5e                   	pop    %esi
80101ed9:	5f                   	pop    %edi
80101eda:	5d                   	pop    %ebp
80101edb:	c3                   	ret    
    iput(ip);
80101edc:	83 ec 0c             	sub    $0xc,%esp
80101edf:	56                   	push   %esi
    return 0;
80101ee0:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee2:	e8 99 f9 ff ff       	call   80101880 <iput>
    return 0;
80101ee7:	83 c4 10             	add    $0x10,%esp
80101eea:	eb 93                	jmp    80101e7f <namex+0x14f>
80101eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ef0 <dirlink>:
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	83 ec 20             	sub    $0x20,%esp
80101ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101efc:	6a 00                	push   $0x0
80101efe:	ff 75 0c             	pushl  0xc(%ebp)
80101f01:	53                   	push   %ebx
80101f02:	e8 79 fd ff ff       	call   80101c80 <dirlookup>
80101f07:	83 c4 10             	add    $0x10,%esp
80101f0a:	85 c0                	test   %eax,%eax
80101f0c:	75 67                	jne    80101f75 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f0e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f11:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f14:	85 ff                	test   %edi,%edi
80101f16:	74 29                	je     80101f41 <dirlink+0x51>
80101f18:	31 ff                	xor    %edi,%edi
80101f1a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f1d:	eb 09                	jmp    80101f28 <dirlink+0x38>
80101f1f:	90                   	nop
80101f20:	83 c7 10             	add    $0x10,%edi
80101f23:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f26:	73 19                	jae    80101f41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f28:	6a 10                	push   $0x10
80101f2a:	57                   	push   %edi
80101f2b:	56                   	push   %esi
80101f2c:	53                   	push   %ebx
80101f2d:	e8 fe fa ff ff       	call   80101a30 <readi>
80101f32:	83 c4 10             	add    $0x10,%esp
80101f35:	83 f8 10             	cmp    $0x10,%eax
80101f38:	75 4e                	jne    80101f88 <dirlink+0x98>
    if(de.inum == 0)
80101f3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f3f:	75 df                	jne    80101f20 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f41:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f44:	83 ec 04             	sub    $0x4,%esp
80101f47:	6a 0e                	push   $0xe
80101f49:	ff 75 0c             	pushl  0xc(%ebp)
80101f4c:	50                   	push   %eax
80101f4d:	e8 de 2f 00 00       	call   80104f30 <strncpy>
  de.inum = inum;
80101f52:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f55:	6a 10                	push   $0x10
80101f57:	57                   	push   %edi
80101f58:	56                   	push   %esi
80101f59:	53                   	push   %ebx
  de.inum = inum;
80101f5a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f5e:	e8 cd fb ff ff       	call   80101b30 <writei>
80101f63:	83 c4 20             	add    $0x20,%esp
80101f66:	83 f8 10             	cmp    $0x10,%eax
80101f69:	75 2a                	jne    80101f95 <dirlink+0xa5>
  return 0;
80101f6b:	31 c0                	xor    %eax,%eax
}
80101f6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f70:	5b                   	pop    %ebx
80101f71:	5e                   	pop    %esi
80101f72:	5f                   	pop    %edi
80101f73:	5d                   	pop    %ebp
80101f74:	c3                   	ret    
    iput(ip);
80101f75:	83 ec 0c             	sub    $0xc,%esp
80101f78:	50                   	push   %eax
80101f79:	e8 02 f9 ff ff       	call   80101880 <iput>
    return -1;
80101f7e:	83 c4 10             	add    $0x10,%esp
80101f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f86:	eb e5                	jmp    80101f6d <dirlink+0x7d>
      panic("dirlink read");
80101f88:	83 ec 0c             	sub    $0xc,%esp
80101f8b:	68 2a 7c 10 80       	push   $0x80107c2a
80101f90:	e8 fb e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f95:	83 ec 0c             	sub    $0xc,%esp
80101f98:	68 de 82 10 80       	push   $0x801082de
80101f9d:	e8 ee e3 ff ff       	call   80100390 <panic>
80101fa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fb0 <namei>:

struct inode*
namei(char *path)
{
80101fb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fb1:	31 d2                	xor    %edx,%edx
{
80101fb3:	89 e5                	mov    %esp,%ebp
80101fb5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fbe:	e8 6d fd ff ff       	call   80101d30 <namex>
}
80101fc3:	c9                   	leave  
80101fc4:	c3                   	ret    
80101fc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fd0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fd1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fd6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fd8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101fdb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fde:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fdf:	e9 4c fd ff ff       	jmp    80101d30 <namex>
80101fe4:	66 90                	xchg   %ax,%ax
80101fe6:	66 90                	xchg   %ax,%ax
80101fe8:	66 90                	xchg   %ax,%ax
80101fea:	66 90                	xchg   %ax,%ax
80101fec:	66 90                	xchg   %ax,%ax
80101fee:	66 90                	xchg   %ax,%ax

80101ff0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101ff9:	85 c0                	test   %eax,%eax
80101ffb:	0f 84 b4 00 00 00    	je     801020b5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102001:	8b 58 08             	mov    0x8(%eax),%ebx
80102004:	89 c6                	mov    %eax,%esi
80102006:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010200c:	0f 87 96 00 00 00    	ja     801020a8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102012:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102017:	89 f6                	mov    %esi,%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102020:	89 ca                	mov    %ecx,%edx
80102022:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102023:	83 e0 c0             	and    $0xffffffc0,%eax
80102026:	3c 40                	cmp    $0x40,%al
80102028:	75 f6                	jne    80102020 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010202a:	31 ff                	xor    %edi,%edi
8010202c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102031:	89 f8                	mov    %edi,%eax
80102033:	ee                   	out    %al,(%dx)
80102034:	b8 01 00 00 00       	mov    $0x1,%eax
80102039:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010203e:	ee                   	out    %al,(%dx)
8010203f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102044:	89 d8                	mov    %ebx,%eax
80102046:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102047:	89 d8                	mov    %ebx,%eax
80102049:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010204e:	c1 f8 08             	sar    $0x8,%eax
80102051:	ee                   	out    %al,(%dx)
80102052:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102057:	89 f8                	mov    %edi,%eax
80102059:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010205a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010205e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102063:	c1 e0 04             	shl    $0x4,%eax
80102066:	83 e0 10             	and    $0x10,%eax
80102069:	83 c8 e0             	or     $0xffffffe0,%eax
8010206c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010206d:	f6 06 04             	testb  $0x4,(%esi)
80102070:	75 16                	jne    80102088 <idestart+0x98>
80102072:	b8 20 00 00 00       	mov    $0x20,%eax
80102077:	89 ca                	mov    %ecx,%edx
80102079:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010207a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010207d:	5b                   	pop    %ebx
8010207e:	5e                   	pop    %esi
8010207f:	5f                   	pop    %edi
80102080:	5d                   	pop    %ebp
80102081:	c3                   	ret    
80102082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102088:	b8 30 00 00 00       	mov    $0x30,%eax
8010208d:	89 ca                	mov    %ecx,%edx
8010208f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102090:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102095:	83 c6 5c             	add    $0x5c,%esi
80102098:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010209d:	fc                   	cld    
8010209e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020a3:	5b                   	pop    %ebx
801020a4:	5e                   	pop    %esi
801020a5:	5f                   	pop    %edi
801020a6:	5d                   	pop    %ebp
801020a7:	c3                   	ret    
    panic("incorrect blockno");
801020a8:	83 ec 0c             	sub    $0xc,%esp
801020ab:	68 94 7c 10 80       	push   $0x80107c94
801020b0:	e8 db e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020b5:	83 ec 0c             	sub    $0xc,%esp
801020b8:	68 8b 7c 10 80       	push   $0x80107c8b
801020bd:	e8 ce e2 ff ff       	call   80100390 <panic>
801020c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020d0 <ideinit>:
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020d6:	68 a6 7c 10 80       	push   $0x80107ca6
801020db:	68 80 b5 10 80       	push   $0x8010b580
801020e0:	e8 7b 2a 00 00       	call   80104b60 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020e5:	58                   	pop    %eax
801020e6:	a1 40 3d 11 80       	mov    0x80113d40,%eax
801020eb:	5a                   	pop    %edx
801020ec:	83 e8 01             	sub    $0x1,%eax
801020ef:	50                   	push   %eax
801020f0:	6a 0e                	push   $0xe
801020f2:	e8 a9 02 00 00       	call   801023a0 <ioapicenable>
801020f7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ff:	90                   	nop
80102100:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102101:	83 e0 c0             	and    $0xffffffc0,%eax
80102104:	3c 40                	cmp    $0x40,%al
80102106:	75 f8                	jne    80102100 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102108:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010210d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102112:	ee                   	out    %al,(%dx)
80102113:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102118:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010211d:	eb 06                	jmp    80102125 <ideinit+0x55>
8010211f:	90                   	nop
  for(i=0; i<1000; i++){
80102120:	83 e9 01             	sub    $0x1,%ecx
80102123:	74 0f                	je     80102134 <ideinit+0x64>
80102125:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102126:	84 c0                	test   %al,%al
80102128:	74 f6                	je     80102120 <ideinit+0x50>
      havedisk1 = 1;
8010212a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102131:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102134:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102139:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010213e:	ee                   	out    %al,(%dx)
}
8010213f:	c9                   	leave  
80102140:	c3                   	ret    
80102141:	eb 0d                	jmp    80102150 <ideintr>
80102143:	90                   	nop
80102144:	90                   	nop
80102145:	90                   	nop
80102146:	90                   	nop
80102147:	90                   	nop
80102148:	90                   	nop
80102149:	90                   	nop
8010214a:	90                   	nop
8010214b:	90                   	nop
8010214c:	90                   	nop
8010214d:	90                   	nop
8010214e:	90                   	nop
8010214f:	90                   	nop

80102150 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102159:	68 80 b5 10 80       	push   $0x8010b580
8010215e:	e8 3d 2b 00 00       	call   80104ca0 <acquire>

  if((b = idequeue) == 0){
80102163:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102169:	83 c4 10             	add    $0x10,%esp
8010216c:	85 db                	test   %ebx,%ebx
8010216e:	74 67                	je     801021d7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102170:	8b 43 58             	mov    0x58(%ebx),%eax
80102173:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102178:	8b 3b                	mov    (%ebx),%edi
8010217a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102180:	75 31                	jne    801021b3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102182:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102187:	89 f6                	mov    %esi,%esi
80102189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102190:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102191:	89 c6                	mov    %eax,%esi
80102193:	83 e6 c0             	and    $0xffffffc0,%esi
80102196:	89 f1                	mov    %esi,%ecx
80102198:	80 f9 40             	cmp    $0x40,%cl
8010219b:	75 f3                	jne    80102190 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010219d:	a8 21                	test   $0x21,%al
8010219f:	75 12                	jne    801021b3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801021a1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021a4:	b9 80 00 00 00       	mov    $0x80,%ecx
801021a9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021ae:	fc                   	cld    
801021af:	f3 6d                	rep insl (%dx),%es:(%edi)
801021b1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021b3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801021b6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021b9:	89 f9                	mov    %edi,%ecx
801021bb:	83 c9 02             	or     $0x2,%ecx
801021be:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021c0:	53                   	push   %ebx
801021c1:	e8 ea 20 00 00       	call   801042b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021c6:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801021cb:	83 c4 10             	add    $0x10,%esp
801021ce:	85 c0                	test   %eax,%eax
801021d0:	74 05                	je     801021d7 <ideintr+0x87>
    idestart(idequeue);
801021d2:	e8 19 fe ff ff       	call   80101ff0 <idestart>
    release(&idelock);
801021d7:	83 ec 0c             	sub    $0xc,%esp
801021da:	68 80 b5 10 80       	push   $0x8010b580
801021df:	e8 7c 2b 00 00       	call   80104d60 <release>

  release(&idelock);
}
801021e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021e7:	5b                   	pop    %ebx
801021e8:	5e                   	pop    %esi
801021e9:	5f                   	pop    %edi
801021ea:	5d                   	pop    %ebp
801021eb:	c3                   	ret    
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	53                   	push   %ebx
801021f4:	83 ec 10             	sub    $0x10,%esp
801021f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801021fd:	50                   	push   %eax
801021fe:	e8 0d 29 00 00       	call   80104b10 <holdingsleep>
80102203:	83 c4 10             	add    $0x10,%esp
80102206:	85 c0                	test   %eax,%eax
80102208:	0f 84 c6 00 00 00    	je     801022d4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010220e:	8b 03                	mov    (%ebx),%eax
80102210:	83 e0 06             	and    $0x6,%eax
80102213:	83 f8 02             	cmp    $0x2,%eax
80102216:	0f 84 ab 00 00 00    	je     801022c7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010221c:	8b 53 04             	mov    0x4(%ebx),%edx
8010221f:	85 d2                	test   %edx,%edx
80102221:	74 0d                	je     80102230 <iderw+0x40>
80102223:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102228:	85 c0                	test   %eax,%eax
8010222a:	0f 84 b1 00 00 00    	je     801022e1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102230:	83 ec 0c             	sub    $0xc,%esp
80102233:	68 80 b5 10 80       	push   $0x8010b580
80102238:	e8 63 2a 00 00       	call   80104ca0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010223d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
80102243:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102246:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224d:	85 d2                	test   %edx,%edx
8010224f:	75 09                	jne    8010225a <iderw+0x6a>
80102251:	eb 6d                	jmp    801022c0 <iderw+0xd0>
80102253:	90                   	nop
80102254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102258:	89 c2                	mov    %eax,%edx
8010225a:	8b 42 58             	mov    0x58(%edx),%eax
8010225d:	85 c0                	test   %eax,%eax
8010225f:	75 f7                	jne    80102258 <iderw+0x68>
80102261:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102264:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102266:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
8010226c:	74 42                	je     801022b0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010226e:	8b 03                	mov    (%ebx),%eax
80102270:	83 e0 06             	and    $0x6,%eax
80102273:	83 f8 02             	cmp    $0x2,%eax
80102276:	74 23                	je     8010229b <iderw+0xab>
80102278:	90                   	nop
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102280:	83 ec 08             	sub    $0x8,%esp
80102283:	68 80 b5 10 80       	push   $0x8010b580
80102288:	53                   	push   %ebx
80102289:	e8 b2 1d 00 00       	call   80104040 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010228e:	8b 03                	mov    (%ebx),%eax
80102290:	83 c4 10             	add    $0x10,%esp
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x90>
  }


  release(&idelock);
8010229b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801022a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022a5:	c9                   	leave  
  release(&idelock);
801022a6:	e9 b5 2a 00 00       	jmp    80104d60 <release>
801022ab:	90                   	nop
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 39 fd ff ff       	call   80101ff0 <idestart>
801022b7:	eb b5                	jmp    8010226e <iderw+0x7e>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801022c5:	eb 9d                	jmp    80102264 <iderw+0x74>
    panic("iderw: nothing to do");
801022c7:	83 ec 0c             	sub    $0xc,%esp
801022ca:	68 c0 7c 10 80       	push   $0x80107cc0
801022cf:	e8 bc e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022d4:	83 ec 0c             	sub    $0xc,%esp
801022d7:	68 aa 7c 10 80       	push   $0x80107caa
801022dc:	e8 af e0 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801022e1:	83 ec 0c             	sub    $0xc,%esp
801022e4:	68 d5 7c 10 80       	push   $0x80107cd5
801022e9:	e8 a2 e0 ff ff       	call   80100390 <panic>
801022ee:	66 90                	xchg   %ax,%ax

801022f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f1:	c7 05 54 36 11 80 00 	movl   $0xfec00000,0x80113654
801022f8:	00 c0 fe 
{
801022fb:	89 e5                	mov    %esp,%ebp
801022fd:	56                   	push   %esi
801022fe:	53                   	push   %ebx
  ioapic->reg = reg;
801022ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102306:	00 00 00 
  return ioapic->data;
80102309:	a1 54 36 11 80       	mov    0x80113654,%eax
8010230e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102311:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102317:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010231d:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102324:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102327:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010232a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010232d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102330:	39 c2                	cmp    %eax,%edx
80102332:	74 16                	je     8010234a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102334:	83 ec 0c             	sub    $0xc,%esp
80102337:	68 f4 7c 10 80       	push   $0x80107cf4
8010233c:	e8 1f e3 ff ff       	call   80100660 <cprintf>
80102341:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
80102347:	83 c4 10             	add    $0x10,%esp
8010234a:	83 c3 21             	add    $0x21,%ebx
{
8010234d:	ba 10 00 00 00       	mov    $0x10,%edx
80102352:	b8 20 00 00 00       	mov    $0x20,%eax
80102357:	89 f6                	mov    %esi,%esi
80102359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102360:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102362:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102368:	89 c6                	mov    %eax,%esi
8010236a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102370:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102373:	89 71 10             	mov    %esi,0x10(%ecx)
80102376:	8d 72 01             	lea    0x1(%edx),%esi
80102379:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010237c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010237e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102380:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
80102386:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010238d:	75 d1                	jne    80102360 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010238f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102392:	5b                   	pop    %ebx
80102393:	5e                   	pop    %esi
80102394:	5d                   	pop    %ebp
80102395:	c3                   	ret    
80102396:	8d 76 00             	lea    0x0(%esi),%esi
80102399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023a0:	55                   	push   %ebp
  ioapic->reg = reg;
801023a1:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
{
801023a7:	89 e5                	mov    %esp,%ebp
801023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023ac:	8d 50 20             	lea    0x20(%eax),%edx
801023af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023b5:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023be:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c6:	a1 54 36 11 80       	mov    0x80113654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023cb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023ce:	89 50 10             	mov    %edx,0x10(%eax)
}
801023d1:	5d                   	pop    %ebp
801023d2:	c3                   	ret    
801023d3:	66 90                	xchg   %ax,%ax
801023d5:	66 90                	xchg   %ax,%ax
801023d7:	66 90                	xchg   %ax,%ax
801023d9:	66 90                	xchg   %ax,%ax
801023db:	66 90                	xchg   %ax,%ax
801023dd:	66 90                	xchg   %ax,%ax
801023df:	90                   	nop

801023e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	53                   	push   %ebx
801023e4:	83 ec 04             	sub    $0x4,%esp
801023e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023f0:	75 70                	jne    80102462 <kfree+0x82>
801023f2:	81 fb 28 03 12 80    	cmp    $0x80120328,%ebx
801023f8:	72 68                	jb     80102462 <kfree+0x82>
801023fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102400:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102405:	77 5b                	ja     80102462 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102407:	83 ec 04             	sub    $0x4,%esp
8010240a:	68 00 10 00 00       	push   $0x1000
8010240f:	6a 01                	push   $0x1
80102411:	53                   	push   %ebx
80102412:	e8 99 29 00 00       	call   80104db0 <memset>

  if(kmem.use_lock)
80102417:	8b 15 94 36 11 80    	mov    0x80113694,%edx
8010241d:	83 c4 10             	add    $0x10,%esp
80102420:	85 d2                	test   %edx,%edx
80102422:	75 2c                	jne    80102450 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102424:	a1 98 36 11 80       	mov    0x80113698,%eax
80102429:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010242b:	a1 94 36 11 80       	mov    0x80113694,%eax
  kmem.freelist = r;
80102430:	89 1d 98 36 11 80    	mov    %ebx,0x80113698
  if(kmem.use_lock)
80102436:	85 c0                	test   %eax,%eax
80102438:	75 06                	jne    80102440 <kfree+0x60>
    release(&kmem.lock);
}
8010243a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010243d:	c9                   	leave  
8010243e:	c3                   	ret    
8010243f:	90                   	nop
    release(&kmem.lock);
80102440:	c7 45 08 60 36 11 80 	movl   $0x80113660,0x8(%ebp)
}
80102447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010244a:	c9                   	leave  
    release(&kmem.lock);
8010244b:	e9 10 29 00 00       	jmp    80104d60 <release>
    acquire(&kmem.lock);
80102450:	83 ec 0c             	sub    $0xc,%esp
80102453:	68 60 36 11 80       	push   $0x80113660
80102458:	e8 43 28 00 00       	call   80104ca0 <acquire>
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	eb c2                	jmp    80102424 <kfree+0x44>
    panic("kfree");
80102462:	83 ec 0c             	sub    $0xc,%esp
80102465:	68 26 7d 10 80       	push   $0x80107d26
8010246a:	e8 21 df ff ff       	call   80100390 <panic>
8010246f:	90                   	nop

80102470 <freerange>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102475:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102478:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102481:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248d:	39 de                	cmp    %ebx,%esi
8010248f:	72 23                	jb     801024b4 <freerange+0x44>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102498:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010249e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024a7:	50                   	push   %eax
801024a8:	e8 33 ff ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ad:	83 c4 10             	add    $0x10,%esp
801024b0:	39 f3                	cmp    %esi,%ebx
801024b2:	76 e4                	jbe    80102498 <freerange+0x28>
}
801024b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024b7:	5b                   	pop    %ebx
801024b8:	5e                   	pop    %esi
801024b9:	5d                   	pop    %ebp
801024ba:	c3                   	ret    
801024bb:	90                   	nop
801024bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024c0 <kinit1>:
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	56                   	push   %esi
801024c4:	53                   	push   %ebx
801024c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024c8:	83 ec 08             	sub    $0x8,%esp
801024cb:	68 2c 7d 10 80       	push   $0x80107d2c
801024d0:	68 60 36 11 80       	push   $0x80113660
801024d5:	e8 86 26 00 00       	call   80104b60 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024dd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801024e0:	c7 05 94 36 11 80 00 	movl   $0x0,0x80113694
801024e7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801024ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024fc:	39 de                	cmp    %ebx,%esi
801024fe:	72 1c                	jb     8010251c <kinit1+0x5c>
    kfree(p);
80102500:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102506:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102509:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010250f:	50                   	push   %eax
80102510:	e8 cb fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102515:	83 c4 10             	add    $0x10,%esp
80102518:	39 de                	cmp    %ebx,%esi
8010251a:	73 e4                	jae    80102500 <kinit1+0x40>
}
8010251c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010251f:	5b                   	pop    %ebx
80102520:	5e                   	pop    %esi
80102521:	5d                   	pop    %ebp
80102522:	c3                   	ret    
80102523:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102530 <kinit2>:
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102535:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102538:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010253b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102541:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102547:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010254d:	39 de                	cmp    %ebx,%esi
8010254f:	72 23                	jb     80102574 <kinit2+0x44>
80102551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102558:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010255e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102561:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102567:	50                   	push   %eax
80102568:	e8 73 fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	39 de                	cmp    %ebx,%esi
80102572:	73 e4                	jae    80102558 <kinit2+0x28>
  kmem.use_lock = 1;
80102574:	c7 05 94 36 11 80 01 	movl   $0x1,0x80113694
8010257b:	00 00 00 
}
8010257e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102581:	5b                   	pop    %ebx
80102582:	5e                   	pop    %esi
80102583:	5d                   	pop    %ebp
80102584:	c3                   	ret    
80102585:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102590 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102590:	a1 94 36 11 80       	mov    0x80113694,%eax
80102595:	85 c0                	test   %eax,%eax
80102597:	75 1f                	jne    801025b8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102599:	a1 98 36 11 80       	mov    0x80113698,%eax
  if(r)
8010259e:	85 c0                	test   %eax,%eax
801025a0:	74 0e                	je     801025b0 <kalloc+0x20>
    kmem.freelist = r->next;
801025a2:	8b 10                	mov    (%eax),%edx
801025a4:	89 15 98 36 11 80    	mov    %edx,0x80113698
801025aa:	c3                   	ret    
801025ab:	90                   	nop
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025b0:	f3 c3                	repz ret 
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801025b8:	55                   	push   %ebp
801025b9:	89 e5                	mov    %esp,%ebp
801025bb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801025be:	68 60 36 11 80       	push   $0x80113660
801025c3:	e8 d8 26 00 00       	call   80104ca0 <acquire>
  r = kmem.freelist;
801025c8:	a1 98 36 11 80       	mov    0x80113698,%eax
  if(r)
801025cd:	83 c4 10             	add    $0x10,%esp
801025d0:	8b 15 94 36 11 80    	mov    0x80113694,%edx
801025d6:	85 c0                	test   %eax,%eax
801025d8:	74 08                	je     801025e2 <kalloc+0x52>
    kmem.freelist = r->next;
801025da:	8b 08                	mov    (%eax),%ecx
801025dc:	89 0d 98 36 11 80    	mov    %ecx,0x80113698
  if(kmem.use_lock)
801025e2:	85 d2                	test   %edx,%edx
801025e4:	74 16                	je     801025fc <kalloc+0x6c>
    release(&kmem.lock);
801025e6:	83 ec 0c             	sub    $0xc,%esp
801025e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025ec:	68 60 36 11 80       	push   $0x80113660
801025f1:	e8 6a 27 00 00       	call   80104d60 <release>
  return (char*)r;
801025f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801025f9:	83 c4 10             	add    $0x10,%esp
}
801025fc:	c9                   	leave  
801025fd:	c3                   	ret    
801025fe:	66 90                	xchg   %ax,%ax

80102600 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102600:	ba 64 00 00 00       	mov    $0x64,%edx
80102605:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102606:	a8 01                	test   $0x1,%al
80102608:	0f 84 c2 00 00 00    	je     801026d0 <kbdgetc+0xd0>
8010260e:	ba 60 00 00 00       	mov    $0x60,%edx
80102613:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102614:	0f b6 d0             	movzbl %al,%edx
80102617:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
8010261d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102623:	0f 84 7f 00 00 00    	je     801026a8 <kbdgetc+0xa8>
{
80102629:	55                   	push   %ebp
8010262a:	89 e5                	mov    %esp,%ebp
8010262c:	53                   	push   %ebx
8010262d:	89 cb                	mov    %ecx,%ebx
8010262f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102632:	84 c0                	test   %al,%al
80102634:	78 4a                	js     80102680 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102636:	85 db                	test   %ebx,%ebx
80102638:	74 09                	je     80102643 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010263a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010263d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102640:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102643:	0f b6 82 60 7e 10 80 	movzbl -0x7fef81a0(%edx),%eax
8010264a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010264c:	0f b6 82 60 7d 10 80 	movzbl -0x7fef82a0(%edx),%eax
80102653:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102655:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102657:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010265d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102660:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102663:	8b 04 85 40 7d 10 80 	mov    -0x7fef82c0(,%eax,4),%eax
8010266a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010266e:	74 31                	je     801026a1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102670:	8d 50 9f             	lea    -0x61(%eax),%edx
80102673:	83 fa 19             	cmp    $0x19,%edx
80102676:	77 40                	ja     801026b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102678:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010267b:	5b                   	pop    %ebx
8010267c:	5d                   	pop    %ebp
8010267d:	c3                   	ret    
8010267e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102680:	83 e0 7f             	and    $0x7f,%eax
80102683:	85 db                	test   %ebx,%ebx
80102685:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102688:	0f b6 82 60 7e 10 80 	movzbl -0x7fef81a0(%edx),%eax
8010268f:	83 c8 40             	or     $0x40,%eax
80102692:	0f b6 c0             	movzbl %al,%eax
80102695:	f7 d0                	not    %eax
80102697:	21 c1                	and    %eax,%ecx
    return 0;
80102699:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010269b:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
801026a1:	5b                   	pop    %ebx
801026a2:	5d                   	pop    %ebp
801026a3:	c3                   	ret    
801026a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026a8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801026ab:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026ad:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
801026b3:	c3                   	ret    
801026b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026bb:	8d 50 20             	lea    0x20(%eax),%edx
}
801026be:	5b                   	pop    %ebx
      c += 'a' - 'A';
801026bf:	83 f9 1a             	cmp    $0x1a,%ecx
801026c2:	0f 42 c2             	cmovb  %edx,%eax
}
801026c5:	5d                   	pop    %ebp
801026c6:	c3                   	ret    
801026c7:	89 f6                	mov    %esi,%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801026d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026d5:	c3                   	ret    
801026d6:	8d 76 00             	lea    0x0(%esi),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026e0 <kbdintr>:

void
kbdintr(void)
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026e6:	68 00 26 10 80       	push   $0x80102600
801026eb:	e8 20 e1 ff ff       	call   80100810 <consoleintr>
}
801026f0:	83 c4 10             	add    $0x10,%esp
801026f3:	c9                   	leave  
801026f4:	c3                   	ret    
801026f5:	66 90                	xchg   %ax,%ax
801026f7:	66 90                	xchg   %ax,%ax
801026f9:	66 90                	xchg   %ax,%ax
801026fb:	66 90                	xchg   %ax,%ax
801026fd:	66 90                	xchg   %ax,%ax
801026ff:	90                   	nop

80102700 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102700:	a1 9c 36 11 80       	mov    0x8011369c,%eax
{
80102705:	55                   	push   %ebp
80102706:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102708:	85 c0                	test   %eax,%eax
8010270a:	0f 84 c8 00 00 00    	je     801027d8 <lapicinit+0xd8>
  lapic[index] = value;
80102710:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102717:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010271a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010271d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102724:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102727:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010272a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102731:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102734:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102737:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010273e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102741:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102744:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010274b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102751:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102758:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010275e:	8b 50 30             	mov    0x30(%eax),%edx
80102761:	c1 ea 10             	shr    $0x10,%edx
80102764:	80 fa 03             	cmp    $0x3,%dl
80102767:	77 77                	ja     801027e0 <lapicinit+0xe0>
  lapic[index] = value;
80102769:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102770:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102773:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102776:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010277d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102780:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102783:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010278a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010278d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102790:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102797:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010279d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027aa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027b1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027b4:	8b 50 20             	mov    0x20(%eax),%edx
801027b7:	89 f6                	mov    %esi,%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027c0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027c6:	80 e6 10             	and    $0x10,%dh
801027c9:	75 f5                	jne    801027c0 <lapicinit+0xc0>
  lapic[index] = value;
801027cb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027d2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027d8:	5d                   	pop    %ebp
801027d9:	c3                   	ret    
801027da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801027e0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027e7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027ea:	8b 50 20             	mov    0x20(%eax),%edx
801027ed:	e9 77 ff ff ff       	jmp    80102769 <lapicinit+0x69>
801027f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102800 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102800:	8b 15 9c 36 11 80    	mov    0x8011369c,%edx
{
80102806:	55                   	push   %ebp
80102807:	31 c0                	xor    %eax,%eax
80102809:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010280b:	85 d2                	test   %edx,%edx
8010280d:	74 06                	je     80102815 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010280f:	8b 42 20             	mov    0x20(%edx),%eax
80102812:	c1 e8 18             	shr    $0x18,%eax
}
80102815:	5d                   	pop    %ebp
80102816:	c3                   	ret    
80102817:	89 f6                	mov    %esi,%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102820:	a1 9c 36 11 80       	mov    0x8011369c,%eax
{
80102825:	55                   	push   %ebp
80102826:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102828:	85 c0                	test   %eax,%eax
8010282a:	74 0d                	je     80102839 <lapiceoi+0x19>
  lapic[index] = value;
8010282c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102833:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102836:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102839:	5d                   	pop    %ebp
8010283a:	c3                   	ret    
8010283b:	90                   	nop
8010283c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102840 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
}
80102843:	5d                   	pop    %ebp
80102844:	c3                   	ret    
80102845:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102850 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102850:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102851:	b8 0f 00 00 00       	mov    $0xf,%eax
80102856:	ba 70 00 00 00       	mov    $0x70,%edx
8010285b:	89 e5                	mov    %esp,%ebp
8010285d:	53                   	push   %ebx
8010285e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102861:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102864:	ee                   	out    %al,(%dx)
80102865:	b8 0a 00 00 00       	mov    $0xa,%eax
8010286a:	ba 71 00 00 00       	mov    $0x71,%edx
8010286f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102870:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102872:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102875:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010287b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010287d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102880:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102883:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102885:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102888:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010288e:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102893:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102899:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010289c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028bc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028da:	5b                   	pop    %ebx
801028db:	5d                   	pop    %ebp
801028dc:	c3                   	ret    
801028dd:	8d 76 00             	lea    0x0(%esi),%esi

801028e0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028e0:	55                   	push   %ebp
801028e1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028e6:	ba 70 00 00 00       	mov    $0x70,%edx
801028eb:	89 e5                	mov    %esp,%ebp
801028ed:	57                   	push   %edi
801028ee:	56                   	push   %esi
801028ef:	53                   	push   %ebx
801028f0:	83 ec 4c             	sub    $0x4c,%esp
801028f3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f4:	ba 71 00 00 00       	mov    $0x71,%edx
801028f9:	ec                   	in     (%dx),%al
801028fa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028fd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102902:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102905:	8d 76 00             	lea    0x0(%esi),%esi
80102908:	31 c0                	xor    %eax,%eax
8010290a:	89 da                	mov    %ebx,%edx
8010290c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102912:	89 ca                	mov    %ecx,%edx
80102914:	ec                   	in     (%dx),%al
80102915:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102918:	89 da                	mov    %ebx,%edx
8010291a:	b8 02 00 00 00       	mov    $0x2,%eax
8010291f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	89 ca                	mov    %ecx,%edx
80102922:	ec                   	in     (%dx),%al
80102923:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102926:	89 da                	mov    %ebx,%edx
80102928:	b8 04 00 00 00       	mov    $0x4,%eax
8010292d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292e:	89 ca                	mov    %ecx,%edx
80102930:	ec                   	in     (%dx),%al
80102931:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102934:	89 da                	mov    %ebx,%edx
80102936:	b8 07 00 00 00       	mov    $0x7,%eax
8010293b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293c:	89 ca                	mov    %ecx,%edx
8010293e:	ec                   	in     (%dx),%al
8010293f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102942:	89 da                	mov    %ebx,%edx
80102944:	b8 08 00 00 00       	mov    $0x8,%eax
80102949:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294a:	89 ca                	mov    %ecx,%edx
8010294c:	ec                   	in     (%dx),%al
8010294d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010294f:	89 da                	mov    %ebx,%edx
80102951:	b8 09 00 00 00       	mov    $0x9,%eax
80102956:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102957:	89 ca                	mov    %ecx,%edx
80102959:	ec                   	in     (%dx),%al
8010295a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295c:	89 da                	mov    %ebx,%edx
8010295e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102963:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102964:	89 ca                	mov    %ecx,%edx
80102966:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102967:	84 c0                	test   %al,%al
80102969:	78 9d                	js     80102908 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010296b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010296f:	89 fa                	mov    %edi,%edx
80102971:	0f b6 fa             	movzbl %dl,%edi
80102974:	89 f2                	mov    %esi,%edx
80102976:	0f b6 f2             	movzbl %dl,%esi
80102979:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297c:	89 da                	mov    %ebx,%edx
8010297e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102981:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102984:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102988:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010298b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010298f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102992:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102996:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102999:	31 c0                	xor    %eax,%eax
8010299b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299c:	89 ca                	mov    %ecx,%edx
8010299e:	ec                   	in     (%dx),%al
8010299f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a2:	89 da                	mov    %ebx,%edx
801029a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029a7:	b8 02 00 00 00       	mov    $0x2,%eax
801029ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ad:	89 ca                	mov    %ecx,%edx
801029af:	ec                   	in     (%dx),%al
801029b0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b3:	89 da                	mov    %ebx,%edx
801029b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029b8:	b8 04 00 00 00       	mov    $0x4,%eax
801029bd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029be:	89 ca                	mov    %ecx,%edx
801029c0:	ec                   	in     (%dx),%al
801029c1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c4:	89 da                	mov    %ebx,%edx
801029c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029c9:	b8 07 00 00 00       	mov    $0x7,%eax
801029ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cf:	89 ca                	mov    %ecx,%edx
801029d1:	ec                   	in     (%dx),%al
801029d2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d5:	89 da                	mov    %ebx,%edx
801029d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029da:	b8 08 00 00 00       	mov    $0x8,%eax
801029df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e0:	89 ca                	mov    %ecx,%edx
801029e2:	ec                   	in     (%dx),%al
801029e3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e6:	89 da                	mov    %ebx,%edx
801029e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029eb:	b8 09 00 00 00       	mov    $0x9,%eax
801029f0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f1:	89 ca                	mov    %ecx,%edx
801029f3:	ec                   	in     (%dx),%al
801029f4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029f7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801029fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029fd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a00:	6a 18                	push   $0x18
80102a02:	50                   	push   %eax
80102a03:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a06:	50                   	push   %eax
80102a07:	e8 f4 23 00 00       	call   80104e00 <memcmp>
80102a0c:	83 c4 10             	add    $0x10,%esp
80102a0f:	85 c0                	test   %eax,%eax
80102a11:	0f 85 f1 fe ff ff    	jne    80102908 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a17:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a1b:	75 78                	jne    80102a95 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a1d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a20:	89 c2                	mov    %eax,%edx
80102a22:	83 e0 0f             	and    $0xf,%eax
80102a25:	c1 ea 04             	shr    $0x4,%edx
80102a28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a2e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a31:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a34:	89 c2                	mov    %eax,%edx
80102a36:	83 e0 0f             	and    $0xf,%eax
80102a39:	c1 ea 04             	shr    $0x4,%edx
80102a3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a42:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a45:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a48:	89 c2                	mov    %eax,%edx
80102a4a:	83 e0 0f             	and    $0xf,%eax
80102a4d:	c1 ea 04             	shr    $0x4,%edx
80102a50:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a53:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a56:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a5c:	89 c2                	mov    %eax,%edx
80102a5e:	83 e0 0f             	and    $0xf,%eax
80102a61:	c1 ea 04             	shr    $0x4,%edx
80102a64:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a67:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a6d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a70:	89 c2                	mov    %eax,%edx
80102a72:	83 e0 0f             	and    $0xf,%eax
80102a75:	c1 ea 04             	shr    $0x4,%edx
80102a78:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a7e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a81:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a84:	89 c2                	mov    %eax,%edx
80102a86:	83 e0 0f             	and    $0xf,%eax
80102a89:	c1 ea 04             	shr    $0x4,%edx
80102a8c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a8f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a92:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a95:	8b 75 08             	mov    0x8(%ebp),%esi
80102a98:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a9b:	89 06                	mov    %eax,(%esi)
80102a9d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102aa0:	89 46 04             	mov    %eax,0x4(%esi)
80102aa3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102aa6:	89 46 08             	mov    %eax,0x8(%esi)
80102aa9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102aac:	89 46 0c             	mov    %eax,0xc(%esi)
80102aaf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ab2:	89 46 10             	mov    %eax,0x10(%esi)
80102ab5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ab8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102abb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ac2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ac5:	5b                   	pop    %ebx
80102ac6:	5e                   	pop    %esi
80102ac7:	5f                   	pop    %edi
80102ac8:	5d                   	pop    %ebp
80102ac9:	c3                   	ret    
80102aca:	66 90                	xchg   %ax,%ax
80102acc:	66 90                	xchg   %ax,%ax
80102ace:	66 90                	xchg   %ax,%ax

80102ad0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ad0:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102ad6:	85 c9                	test   %ecx,%ecx
80102ad8:	0f 8e 8a 00 00 00    	jle    80102b68 <install_trans+0x98>
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	57                   	push   %edi
80102ae2:	56                   	push   %esi
80102ae3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ae4:	31 db                	xor    %ebx,%ebx
{
80102ae6:	83 ec 0c             	sub    $0xc,%esp
80102ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102af0:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102af5:	83 ec 08             	sub    $0x8,%esp
80102af8:	01 d8                	add    %ebx,%eax
80102afa:	83 c0 01             	add    $0x1,%eax
80102afd:	50                   	push   %eax
80102afe:	ff 35 e4 36 11 80    	pushl  0x801136e4
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	58                   	pop    %eax
80102b0c:	5a                   	pop    %edx
80102b0d:	ff 34 9d ec 36 11 80 	pushl  -0x7feec914(,%ebx,4)
80102b14:	ff 35 e4 36 11 80    	pushl  0x801136e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b1a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1d:	e8 ae d5 ff ff       	call   801000d0 <bread>
80102b22:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b24:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b27:	83 c4 0c             	add    $0xc,%esp
80102b2a:	68 00 02 00 00       	push   $0x200
80102b2f:	50                   	push   %eax
80102b30:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b33:	50                   	push   %eax
80102b34:	e8 27 23 00 00       	call   80104e60 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b39:	89 34 24             	mov    %esi,(%esp)
80102b3c:	e8 5f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b41:	89 3c 24             	mov    %edi,(%esp)
80102b44:	e8 97 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b49:	89 34 24             	mov    %esi,(%esp)
80102b4c:	e8 8f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b51:	83 c4 10             	add    $0x10,%esp
80102b54:	39 1d e8 36 11 80    	cmp    %ebx,0x801136e8
80102b5a:	7f 94                	jg     80102af0 <install_trans+0x20>
  }
}
80102b5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b5f:	5b                   	pop    %ebx
80102b60:	5e                   	pop    %esi
80102b61:	5f                   	pop    %edi
80102b62:	5d                   	pop    %ebp
80102b63:	c3                   	ret    
80102b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b68:	f3 c3                	repz ret 
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	56                   	push   %esi
80102b74:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102b75:	83 ec 08             	sub    $0x8,%esp
80102b78:	ff 35 d4 36 11 80    	pushl  0x801136d4
80102b7e:	ff 35 e4 36 11 80    	pushl  0x801136e4
80102b84:	e8 47 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b89:	8b 1d e8 36 11 80    	mov    0x801136e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b8f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b92:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102b94:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102b96:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b99:	7e 16                	jle    80102bb1 <write_head+0x41>
80102b9b:	c1 e3 02             	shl    $0x2,%ebx
80102b9e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ba0:	8b 8a ec 36 11 80    	mov    -0x7feec914(%edx),%ecx
80102ba6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102baa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bad:	39 da                	cmp    %ebx,%edx
80102baf:	75 ef                	jne    80102ba0 <write_head+0x30>
  }
  bwrite(buf);
80102bb1:	83 ec 0c             	sub    $0xc,%esp
80102bb4:	56                   	push   %esi
80102bb5:	e8 e6 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bba:	89 34 24             	mov    %esi,(%esp)
80102bbd:	e8 1e d6 ff ff       	call   801001e0 <brelse>
}
80102bc2:	83 c4 10             	add    $0x10,%esp
80102bc5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102bc8:	5b                   	pop    %ebx
80102bc9:	5e                   	pop    %esi
80102bca:	5d                   	pop    %ebp
80102bcb:	c3                   	ret    
80102bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102bd0 <initlog>:
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	53                   	push   %ebx
80102bd4:	83 ec 2c             	sub    $0x2c,%esp
80102bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bda:	68 60 7f 10 80       	push   $0x80107f60
80102bdf:	68 a0 36 11 80       	push   $0x801136a0
80102be4:	e8 77 1f 00 00       	call   80104b60 <initlock>
  readsb(dev, &sb);
80102be9:	58                   	pop    %eax
80102bea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bed:	5a                   	pop    %edx
80102bee:	50                   	push   %eax
80102bef:	53                   	push   %ebx
80102bf0:	e8 9b e8 ff ff       	call   80101490 <readsb>
  log.size = sb.nlog;
80102bf5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102bf8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102bfb:	59                   	pop    %ecx
  log.dev = dev;
80102bfc:	89 1d e4 36 11 80    	mov    %ebx,0x801136e4
  log.size = sb.nlog;
80102c02:	89 15 d8 36 11 80    	mov    %edx,0x801136d8
  log.start = sb.logstart;
80102c08:	a3 d4 36 11 80       	mov    %eax,0x801136d4
  struct buf *buf = bread(log.dev, log.start);
80102c0d:	5a                   	pop    %edx
80102c0e:	50                   	push   %eax
80102c0f:	53                   	push   %ebx
80102c10:	e8 bb d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c15:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c18:	83 c4 10             	add    $0x10,%esp
80102c1b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c1d:	89 1d e8 36 11 80    	mov    %ebx,0x801136e8
  for (i = 0; i < log.lh.n; i++) {
80102c23:	7e 1c                	jle    80102c41 <initlog+0x71>
80102c25:	c1 e3 02             	shl    $0x2,%ebx
80102c28:	31 d2                	xor    %edx,%edx
80102c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c34:	83 c2 04             	add    $0x4,%edx
80102c37:	89 8a e8 36 11 80    	mov    %ecx,-0x7feec918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c3d:	39 d3                	cmp    %edx,%ebx
80102c3f:	75 ef                	jne    80102c30 <initlog+0x60>
  brelse(buf);
80102c41:	83 ec 0c             	sub    $0xc,%esp
80102c44:	50                   	push   %eax
80102c45:	e8 96 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c4a:	e8 81 fe ff ff       	call   80102ad0 <install_trans>
  log.lh.n = 0;
80102c4f:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
80102c56:	00 00 00 
  write_head(); // clear the log
80102c59:	e8 12 ff ff ff       	call   80102b70 <write_head>
}
80102c5e:	83 c4 10             	add    $0x10,%esp
80102c61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c64:	c9                   	leave  
80102c65:	c3                   	ret    
80102c66:	8d 76 00             	lea    0x0(%esi),%esi
80102c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c76:	68 a0 36 11 80       	push   $0x801136a0
80102c7b:	e8 20 20 00 00       	call   80104ca0 <acquire>
80102c80:	83 c4 10             	add    $0x10,%esp
80102c83:	eb 18                	jmp    80102c9d <begin_op+0x2d>
80102c85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c88:	83 ec 08             	sub    $0x8,%esp
80102c8b:	68 a0 36 11 80       	push   $0x801136a0
80102c90:	68 a0 36 11 80       	push   $0x801136a0
80102c95:	e8 a6 13 00 00       	call   80104040 <sleep>
80102c9a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102c9d:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	75 e2                	jne    80102c88 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ca6:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102cab:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80102cb1:	83 c0 01             	add    $0x1,%eax
80102cb4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cb7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cba:	83 fa 1e             	cmp    $0x1e,%edx
80102cbd:	7f c9                	jg     80102c88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cbf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cc2:	a3 dc 36 11 80       	mov    %eax,0x801136dc
      release(&log.lock);
80102cc7:	68 a0 36 11 80       	push   $0x801136a0
80102ccc:	e8 8f 20 00 00       	call   80104d60 <release>
      break;
    }
  }
}
80102cd1:	83 c4 10             	add    $0x10,%esp
80102cd4:	c9                   	leave  
80102cd5:	c3                   	ret    
80102cd6:	8d 76 00             	lea    0x0(%esi),%esi
80102cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ce0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	57                   	push   %edi
80102ce4:	56                   	push   %esi
80102ce5:	53                   	push   %ebx
80102ce6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ce9:	68 a0 36 11 80       	push   $0x801136a0
80102cee:	e8 ad 1f 00 00       	call   80104ca0 <acquire>
  log.outstanding -= 1;
80102cf3:	a1 dc 36 11 80       	mov    0x801136dc,%eax
  if(log.committing)
80102cf8:	8b 35 e0 36 11 80    	mov    0x801136e0,%esi
80102cfe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d01:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d04:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102d06:	89 1d dc 36 11 80    	mov    %ebx,0x801136dc
  if(log.committing)
80102d0c:	0f 85 1a 01 00 00    	jne    80102e2c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d12:	85 db                	test   %ebx,%ebx
80102d14:	0f 85 ee 00 00 00    	jne    80102e08 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d1a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d1d:	c7 05 e0 36 11 80 01 	movl   $0x1,0x801136e0
80102d24:	00 00 00 
  release(&log.lock);
80102d27:	68 a0 36 11 80       	push   $0x801136a0
80102d2c:	e8 2f 20 00 00       	call   80104d60 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d31:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102d37:	83 c4 10             	add    $0x10,%esp
80102d3a:	85 c9                	test   %ecx,%ecx
80102d3c:	0f 8e 85 00 00 00    	jle    80102dc7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d42:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102d47:	83 ec 08             	sub    $0x8,%esp
80102d4a:	01 d8                	add    %ebx,%eax
80102d4c:	83 c0 01             	add    $0x1,%eax
80102d4f:	50                   	push   %eax
80102d50:	ff 35 e4 36 11 80    	pushl  0x801136e4
80102d56:	e8 75 d3 ff ff       	call   801000d0 <bread>
80102d5b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d5d:	58                   	pop    %eax
80102d5e:	5a                   	pop    %edx
80102d5f:	ff 34 9d ec 36 11 80 	pushl  -0x7feec914(,%ebx,4)
80102d66:	ff 35 e4 36 11 80    	pushl  0x801136e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d6c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d6f:	e8 5c d3 ff ff       	call   801000d0 <bread>
80102d74:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d76:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d79:	83 c4 0c             	add    $0xc,%esp
80102d7c:	68 00 02 00 00       	push   $0x200
80102d81:	50                   	push   %eax
80102d82:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d85:	50                   	push   %eax
80102d86:	e8 d5 20 00 00       	call   80104e60 <memmove>
    bwrite(to);  // write the log
80102d8b:	89 34 24             	mov    %esi,(%esp)
80102d8e:	e8 0d d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d93:	89 3c 24             	mov    %edi,(%esp)
80102d96:	e8 45 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d9b:	89 34 24             	mov    %esi,(%esp)
80102d9e:	e8 3d d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102da3:	83 c4 10             	add    $0x10,%esp
80102da6:	3b 1d e8 36 11 80    	cmp    0x801136e8,%ebx
80102dac:	7c 94                	jl     80102d42 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dae:	e8 bd fd ff ff       	call   80102b70 <write_head>
    install_trans(); // Now install writes to home locations
80102db3:	e8 18 fd ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102db8:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
80102dbf:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dc2:	e8 a9 fd ff ff       	call   80102b70 <write_head>
    acquire(&log.lock);
80102dc7:	83 ec 0c             	sub    $0xc,%esp
80102dca:	68 a0 36 11 80       	push   $0x801136a0
80102dcf:	e8 cc 1e 00 00       	call   80104ca0 <acquire>
    wakeup(&log);
80102dd4:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
    log.committing = 0;
80102ddb:	c7 05 e0 36 11 80 00 	movl   $0x0,0x801136e0
80102de2:	00 00 00 
    wakeup(&log);
80102de5:	e8 c6 14 00 00       	call   801042b0 <wakeup>
    release(&log.lock);
80102dea:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
80102df1:	e8 6a 1f 00 00       	call   80104d60 <release>
80102df6:	83 c4 10             	add    $0x10,%esp
}
80102df9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dfc:	5b                   	pop    %ebx
80102dfd:	5e                   	pop    %esi
80102dfe:	5f                   	pop    %edi
80102dff:	5d                   	pop    %ebp
80102e00:	c3                   	ret    
80102e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102e08:	83 ec 0c             	sub    $0xc,%esp
80102e0b:	68 a0 36 11 80       	push   $0x801136a0
80102e10:	e8 9b 14 00 00       	call   801042b0 <wakeup>
  release(&log.lock);
80102e15:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
80102e1c:	e8 3f 1f 00 00       	call   80104d60 <release>
80102e21:	83 c4 10             	add    $0x10,%esp
}
80102e24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e27:	5b                   	pop    %ebx
80102e28:	5e                   	pop    %esi
80102e29:	5f                   	pop    %edi
80102e2a:	5d                   	pop    %ebp
80102e2b:	c3                   	ret    
    panic("log.committing");
80102e2c:	83 ec 0c             	sub    $0xc,%esp
80102e2f:	68 64 7f 10 80       	push   $0x80107f64
80102e34:	e8 57 d5 ff ff       	call   80100390 <panic>
80102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	53                   	push   %ebx
80102e44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e47:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
{
80102e4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e50:	83 fa 1d             	cmp    $0x1d,%edx
80102e53:	0f 8f 9d 00 00 00    	jg     80102ef6 <log_write+0xb6>
80102e59:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102e5e:	83 e8 01             	sub    $0x1,%eax
80102e61:	39 c2                	cmp    %eax,%edx
80102e63:	0f 8d 8d 00 00 00    	jge    80102ef6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e69:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e6e:	85 c0                	test   %eax,%eax
80102e70:	0f 8e 8d 00 00 00    	jle    80102f03 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e76:	83 ec 0c             	sub    $0xc,%esp
80102e79:	68 a0 36 11 80       	push   $0x801136a0
80102e7e:	e8 1d 1e 00 00       	call   80104ca0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e83:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102e89:	83 c4 10             	add    $0x10,%esp
80102e8c:	83 f9 00             	cmp    $0x0,%ecx
80102e8f:	7e 57                	jle    80102ee8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e91:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e94:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e96:	3b 15 ec 36 11 80    	cmp    0x801136ec,%edx
80102e9c:	75 0b                	jne    80102ea9 <log_write+0x69>
80102e9e:	eb 38                	jmp    80102ed8 <log_write+0x98>
80102ea0:	39 14 85 ec 36 11 80 	cmp    %edx,-0x7feec914(,%eax,4)
80102ea7:	74 2f                	je     80102ed8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102ea9:	83 c0 01             	add    $0x1,%eax
80102eac:	39 c1                	cmp    %eax,%ecx
80102eae:	75 f0                	jne    80102ea0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102eb0:	89 14 85 ec 36 11 80 	mov    %edx,-0x7feec914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102eb7:	83 c0 01             	add    $0x1,%eax
80102eba:	a3 e8 36 11 80       	mov    %eax,0x801136e8
  b->flags |= B_DIRTY; // prevent eviction
80102ebf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ec2:	c7 45 08 a0 36 11 80 	movl   $0x801136a0,0x8(%ebp)
}
80102ec9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ecc:	c9                   	leave  
  release(&log.lock);
80102ecd:	e9 8e 1e 00 00       	jmp    80104d60 <release>
80102ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ed8:	89 14 85 ec 36 11 80 	mov    %edx,-0x7feec914(,%eax,4)
80102edf:	eb de                	jmp    80102ebf <log_write+0x7f>
80102ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ee8:	8b 43 08             	mov    0x8(%ebx),%eax
80102eeb:	a3 ec 36 11 80       	mov    %eax,0x801136ec
  if (i == log.lh.n)
80102ef0:	75 cd                	jne    80102ebf <log_write+0x7f>
80102ef2:	31 c0                	xor    %eax,%eax
80102ef4:	eb c1                	jmp    80102eb7 <log_write+0x77>
    panic("too big a transaction");
80102ef6:	83 ec 0c             	sub    $0xc,%esp
80102ef9:	68 73 7f 10 80       	push   $0x80107f73
80102efe:	e8 8d d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102f03:	83 ec 0c             	sub    $0xc,%esp
80102f06:	68 89 7f 10 80       	push   $0x80107f89
80102f0b:	e8 80 d4 ff ff       	call   80100390 <panic>

80102f10 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f17:	e8 24 0a 00 00       	call   80103940 <cpuid>
80102f1c:	89 c3                	mov    %eax,%ebx
80102f1e:	e8 1d 0a 00 00       	call   80103940 <cpuid>
80102f23:	83 ec 04             	sub    $0x4,%esp
80102f26:	53                   	push   %ebx
80102f27:	50                   	push   %eax
80102f28:	68 a4 7f 10 80       	push   $0x80107fa4
80102f2d:	e8 2e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 89 32 00 00       	call   801061c0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f37:	e8 84 09 00 00       	call   801038c0 <mycpu>
80102f3c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f3e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f43:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f4a:	e8 71 0d 00 00       	call   80103cc0 <scheduler>
80102f4f:	90                   	nop

80102f50 <mpenter>:
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f56:	e8 45 44 00 00       	call   801073a0 <switchkvm>
  seginit();
80102f5b:	e8 b0 43 00 00       	call   80107310 <seginit>
  lapicinit();
80102f60:	e8 9b f7 ff ff       	call   80102700 <lapicinit>
  mpmain();
80102f65:	e8 a6 ff ff ff       	call   80102f10 <mpmain>
80102f6a:	66 90                	xchg   %ax,%ax
80102f6c:	66 90                	xchg   %ax,%ax
80102f6e:	66 90                	xchg   %ax,%ax

80102f70 <main>:
{
80102f70:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f74:	83 e4 f0             	and    $0xfffffff0,%esp
80102f77:	ff 71 fc             	pushl  -0x4(%ecx)
80102f7a:	55                   	push   %ebp
80102f7b:	89 e5                	mov    %esp,%ebp
80102f7d:	53                   	push   %ebx
80102f7e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f7f:	83 ec 08             	sub    $0x8,%esp
80102f82:	68 00 00 40 80       	push   $0x80400000
80102f87:	68 28 03 12 80       	push   $0x80120328
80102f8c:	e8 2f f5 ff ff       	call   801024c0 <kinit1>
  kvmalloc();      // kernel page table
80102f91:	e8 da 48 00 00       	call   80107870 <kvmalloc>
  mpinit();        // detect other processors
80102f96:	e8 75 01 00 00       	call   80103110 <mpinit>
  lapicinit();     // interrupt controller
80102f9b:	e8 60 f7 ff ff       	call   80102700 <lapicinit>
  seginit();       // segment descriptors
80102fa0:	e8 6b 43 00 00       	call   80107310 <seginit>
  picinit();       // disable pic
80102fa5:	e8 46 03 00 00       	call   801032f0 <picinit>
  ioapicinit();    // another interrupt controller
80102faa:	e8 41 f3 ff ff       	call   801022f0 <ioapicinit>
  consoleinit();   // console hardware
80102faf:	e8 0c da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102fb4:	e8 27 36 00 00       	call   801065e0 <uartinit>
  pinit();         // process table
80102fb9:	e8 d2 08 00 00       	call   80103890 <pinit>
  tvinit();        // trap vectors
80102fbe:	e8 7d 31 00 00       	call   80106140 <tvinit>
  binit();         // buffer cache
80102fc3:	e8 78 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fc8:	e8 53 de ff ff       	call   80100e20 <fileinit>
  ideinit();       // disk 
80102fcd:	e8 fe f0 ff ff       	call   801020d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fd2:	83 c4 0c             	add    $0xc,%esp
80102fd5:	68 8a 00 00 00       	push   $0x8a
80102fda:	68 8c b4 10 80       	push   $0x8010b48c
80102fdf:	68 00 70 00 80       	push   $0x80007000
80102fe4:	e8 77 1e 00 00       	call   80104e60 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fe9:	69 05 40 3d 11 80 b4 	imul   $0xb4,0x80113d40,%eax
80102ff0:	00 00 00 
80102ff3:	83 c4 10             	add    $0x10,%esp
80102ff6:	05 a0 37 11 80       	add    $0x801137a0,%eax
80102ffb:	3d a0 37 11 80       	cmp    $0x801137a0,%eax
80103000:	76 71                	jbe    80103073 <main+0x103>
80103002:	bb a0 37 11 80       	mov    $0x801137a0,%ebx
80103007:	89 f6                	mov    %esi,%esi
80103009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103010:	e8 ab 08 00 00       	call   801038c0 <mycpu>
80103015:	39 d8                	cmp    %ebx,%eax
80103017:	74 41                	je     8010305a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103019:	e8 72 f5 ff ff       	call   80102590 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010301e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103023:	c7 05 f8 6f 00 80 50 	movl   $0x80102f50,0x80006ff8
8010302a:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010302d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103034:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103037:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010303c:	0f b6 03             	movzbl (%ebx),%eax
8010303f:	83 ec 08             	sub    $0x8,%esp
80103042:	68 00 70 00 00       	push   $0x7000
80103047:	50                   	push   %eax
80103048:	e8 03 f8 ff ff       	call   80102850 <lapicstartap>
8010304d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103050:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103056:	85 c0                	test   %eax,%eax
80103058:	74 f6                	je     80103050 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010305a:	69 05 40 3d 11 80 b4 	imul   $0xb4,0x80113d40,%eax
80103061:	00 00 00 
80103064:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
8010306a:	05 a0 37 11 80       	add    $0x801137a0,%eax
8010306f:	39 c3                	cmp    %eax,%ebx
80103071:	72 9d                	jb     80103010 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103073:	83 ec 08             	sub    $0x8,%esp
80103076:	68 00 00 00 8e       	push   $0x8e000000
8010307b:	68 00 00 40 80       	push   $0x80400000
80103080:	e8 ab f4 ff ff       	call   80102530 <kinit2>
  userinit();      // first user process
80103085:	e8 36 09 00 00       	call   801039c0 <userinit>
  mpmain();        // finish this processor's setup
8010308a:	e8 81 fe ff ff       	call   80102f10 <mpmain>
8010308f:	90                   	nop

80103090 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	57                   	push   %edi
80103094:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103095:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010309b:	53                   	push   %ebx
  e = addr+len;
8010309c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010309f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801030a2:	39 de                	cmp    %ebx,%esi
801030a4:	72 10                	jb     801030b6 <mpsearch1+0x26>
801030a6:	eb 50                	jmp    801030f8 <mpsearch1+0x68>
801030a8:	90                   	nop
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030b0:	39 fb                	cmp    %edi,%ebx
801030b2:	89 fe                	mov    %edi,%esi
801030b4:	76 42                	jbe    801030f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030b6:	83 ec 04             	sub    $0x4,%esp
801030b9:	8d 7e 10             	lea    0x10(%esi),%edi
801030bc:	6a 04                	push   $0x4
801030be:	68 b8 7f 10 80       	push   $0x80107fb8
801030c3:	56                   	push   %esi
801030c4:	e8 37 1d 00 00       	call   80104e00 <memcmp>
801030c9:	83 c4 10             	add    $0x10,%esp
801030cc:	85 c0                	test   %eax,%eax
801030ce:	75 e0                	jne    801030b0 <mpsearch1+0x20>
801030d0:	89 f1                	mov    %esi,%ecx
801030d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030d8:	0f b6 11             	movzbl (%ecx),%edx
801030db:	83 c1 01             	add    $0x1,%ecx
801030de:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801030e0:	39 f9                	cmp    %edi,%ecx
801030e2:	75 f4                	jne    801030d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030e4:	84 c0                	test   %al,%al
801030e6:	75 c8                	jne    801030b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030eb:	89 f0                	mov    %esi,%eax
801030ed:	5b                   	pop    %ebx
801030ee:	5e                   	pop    %esi
801030ef:	5f                   	pop    %edi
801030f0:	5d                   	pop    %ebp
801030f1:	c3                   	ret    
801030f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801030fb:	31 f6                	xor    %esi,%esi
}
801030fd:	89 f0                	mov    %esi,%eax
801030ff:	5b                   	pop    %ebx
80103100:	5e                   	pop    %esi
80103101:	5f                   	pop    %edi
80103102:	5d                   	pop    %ebp
80103103:	c3                   	ret    
80103104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010310a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103110 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	57                   	push   %edi
80103114:	56                   	push   %esi
80103115:	53                   	push   %ebx
80103116:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103119:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103120:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103127:	c1 e0 08             	shl    $0x8,%eax
8010312a:	09 d0                	or     %edx,%eax
8010312c:	c1 e0 04             	shl    $0x4,%eax
8010312f:	85 c0                	test   %eax,%eax
80103131:	75 1b                	jne    8010314e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103133:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010313a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103141:	c1 e0 08             	shl    $0x8,%eax
80103144:	09 d0                	or     %edx,%eax
80103146:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103149:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010314e:	ba 00 04 00 00       	mov    $0x400,%edx
80103153:	e8 38 ff ff ff       	call   80103090 <mpsearch1>
80103158:	85 c0                	test   %eax,%eax
8010315a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010315d:	0f 84 3d 01 00 00    	je     801032a0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103166:	8b 58 04             	mov    0x4(%eax),%ebx
80103169:	85 db                	test   %ebx,%ebx
8010316b:	0f 84 4f 01 00 00    	je     801032c0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103171:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103177:	83 ec 04             	sub    $0x4,%esp
8010317a:	6a 04                	push   $0x4
8010317c:	68 d5 7f 10 80       	push   $0x80107fd5
80103181:	56                   	push   %esi
80103182:	e8 79 1c 00 00       	call   80104e00 <memcmp>
80103187:	83 c4 10             	add    $0x10,%esp
8010318a:	85 c0                	test   %eax,%eax
8010318c:	0f 85 2e 01 00 00    	jne    801032c0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103192:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103199:	3c 01                	cmp    $0x1,%al
8010319b:	0f 95 c2             	setne  %dl
8010319e:	3c 04                	cmp    $0x4,%al
801031a0:	0f 95 c0             	setne  %al
801031a3:	20 c2                	and    %al,%dl
801031a5:	0f 85 15 01 00 00    	jne    801032c0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801031ab:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801031b2:	66 85 ff             	test   %di,%di
801031b5:	74 1a                	je     801031d1 <mpinit+0xc1>
801031b7:	89 f0                	mov    %esi,%eax
801031b9:	01 f7                	add    %esi,%edi
  sum = 0;
801031bb:	31 d2                	xor    %edx,%edx
801031bd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801031c0:	0f b6 08             	movzbl (%eax),%ecx
801031c3:	83 c0 01             	add    $0x1,%eax
801031c6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031c8:	39 c7                	cmp    %eax,%edi
801031ca:	75 f4                	jne    801031c0 <mpinit+0xb0>
801031cc:	84 d2                	test   %dl,%dl
801031ce:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031d1:	85 f6                	test   %esi,%esi
801031d3:	0f 84 e7 00 00 00    	je     801032c0 <mpinit+0x1b0>
801031d9:	84 d2                	test   %dl,%dl
801031db:	0f 85 df 00 00 00    	jne    801032c0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031e1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031e7:	a3 9c 36 11 80       	mov    %eax,0x8011369c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031ec:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801031f3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801031f9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031fe:	01 d6                	add    %edx,%esi
80103200:	39 c6                	cmp    %eax,%esi
80103202:	76 23                	jbe    80103227 <mpinit+0x117>
    switch(*p){
80103204:	0f b6 10             	movzbl (%eax),%edx
80103207:	80 fa 04             	cmp    $0x4,%dl
8010320a:	0f 87 ca 00 00 00    	ja     801032da <mpinit+0x1ca>
80103210:	ff 24 95 fc 7f 10 80 	jmp    *-0x7fef8004(,%edx,4)
80103217:	89 f6                	mov    %esi,%esi
80103219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103220:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103223:	39 c6                	cmp    %eax,%esi
80103225:	77 dd                	ja     80103204 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103227:	85 db                	test   %ebx,%ebx
80103229:	0f 84 9e 00 00 00    	je     801032cd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010322f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103232:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103236:	74 15                	je     8010324d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103238:	b8 70 00 00 00       	mov    $0x70,%eax
8010323d:	ba 22 00 00 00       	mov    $0x22,%edx
80103242:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103243:	ba 23 00 00 00       	mov    $0x23,%edx
80103248:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103249:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010324c:	ee                   	out    %al,(%dx)
  }
}
8010324d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103250:	5b                   	pop    %ebx
80103251:	5e                   	pop    %esi
80103252:	5f                   	pop    %edi
80103253:	5d                   	pop    %ebp
80103254:	c3                   	ret    
80103255:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103258:	8b 0d 40 3d 11 80    	mov    0x80113d40,%ecx
8010325e:	83 f9 07             	cmp    $0x7,%ecx
80103261:	7f 19                	jg     8010327c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103263:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103267:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
        ncpu++;
8010326d:	83 c1 01             	add    $0x1,%ecx
80103270:	89 0d 40 3d 11 80    	mov    %ecx,0x80113d40
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103276:	88 97 a0 37 11 80    	mov    %dl,-0x7feec860(%edi)
      p += sizeof(struct mpproc);
8010327c:	83 c0 14             	add    $0x14,%eax
      continue;
8010327f:	e9 7c ff ff ff       	jmp    80103200 <mpinit+0xf0>
80103284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103288:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010328c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010328f:	88 15 80 37 11 80    	mov    %dl,0x80113780
      continue;
80103295:	e9 66 ff ff ff       	jmp    80103200 <mpinit+0xf0>
8010329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801032a0:	ba 00 00 01 00       	mov    $0x10000,%edx
801032a5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032aa:	e8 e1 fd ff ff       	call   80103090 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032af:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801032b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032b4:	0f 85 a9 fe ff ff    	jne    80103163 <mpinit+0x53>
801032ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801032c0:	83 ec 0c             	sub    $0xc,%esp
801032c3:	68 bd 7f 10 80       	push   $0x80107fbd
801032c8:	e8 c3 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801032cd:	83 ec 0c             	sub    $0xc,%esp
801032d0:	68 dc 7f 10 80       	push   $0x80107fdc
801032d5:	e8 b6 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
801032da:	31 db                	xor    %ebx,%ebx
801032dc:	e9 26 ff ff ff       	jmp    80103207 <mpinit+0xf7>
801032e1:	66 90                	xchg   %ax,%ax
801032e3:	66 90                	xchg   %ax,%ax
801032e5:	66 90                	xchg   %ax,%ax
801032e7:	66 90                	xchg   %ax,%ax
801032e9:	66 90                	xchg   %ax,%ax
801032eb:	66 90                	xchg   %ax,%ax
801032ed:	66 90                	xchg   %ax,%ax
801032ef:	90                   	nop

801032f0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032f0:	55                   	push   %ebp
801032f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032f6:	ba 21 00 00 00       	mov    $0x21,%edx
801032fb:	89 e5                	mov    %esp,%ebp
801032fd:	ee                   	out    %al,(%dx)
801032fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103303:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103304:	5d                   	pop    %ebp
80103305:	c3                   	ret    
80103306:	66 90                	xchg   %ax,%ax
80103308:	66 90                	xchg   %ax,%ax
8010330a:	66 90                	xchg   %ax,%ax
8010330c:	66 90                	xchg   %ax,%ax
8010330e:	66 90                	xchg   %ax,%ax

80103310 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	57                   	push   %edi
80103314:	56                   	push   %esi
80103315:	53                   	push   %ebx
80103316:	83 ec 0c             	sub    $0xc,%esp
80103319:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010331c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010331f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103325:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010332b:	e8 10 db ff ff       	call   80100e40 <filealloc>
80103330:	85 c0                	test   %eax,%eax
80103332:	89 03                	mov    %eax,(%ebx)
80103334:	74 22                	je     80103358 <pipealloc+0x48>
80103336:	e8 05 db ff ff       	call   80100e40 <filealloc>
8010333b:	85 c0                	test   %eax,%eax
8010333d:	89 06                	mov    %eax,(%esi)
8010333f:	74 3f                	je     80103380 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103341:	e8 4a f2 ff ff       	call   80102590 <kalloc>
80103346:	85 c0                	test   %eax,%eax
80103348:	89 c7                	mov    %eax,%edi
8010334a:	75 54                	jne    801033a0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010334c:	8b 03                	mov    (%ebx),%eax
8010334e:	85 c0                	test   %eax,%eax
80103350:	75 34                	jne    80103386 <pipealloc+0x76>
80103352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103358:	8b 06                	mov    (%esi),%eax
8010335a:	85 c0                	test   %eax,%eax
8010335c:	74 0c                	je     8010336a <pipealloc+0x5a>
    fileclose(*f1);
8010335e:	83 ec 0c             	sub    $0xc,%esp
80103361:	50                   	push   %eax
80103362:	e8 99 db ff ff       	call   80100f00 <fileclose>
80103367:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010336a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010336d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103372:	5b                   	pop    %ebx
80103373:	5e                   	pop    %esi
80103374:	5f                   	pop    %edi
80103375:	5d                   	pop    %ebp
80103376:	c3                   	ret    
80103377:	89 f6                	mov    %esi,%esi
80103379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103380:	8b 03                	mov    (%ebx),%eax
80103382:	85 c0                	test   %eax,%eax
80103384:	74 e4                	je     8010336a <pipealloc+0x5a>
    fileclose(*f0);
80103386:	83 ec 0c             	sub    $0xc,%esp
80103389:	50                   	push   %eax
8010338a:	e8 71 db ff ff       	call   80100f00 <fileclose>
  if(*f1)
8010338f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103391:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103394:	85 c0                	test   %eax,%eax
80103396:	75 c6                	jne    8010335e <pipealloc+0x4e>
80103398:	eb d0                	jmp    8010336a <pipealloc+0x5a>
8010339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801033a0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801033a3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033aa:	00 00 00 
  p->writeopen = 1;
801033ad:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033b4:	00 00 00 
  p->nwrite = 0;
801033b7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033be:	00 00 00 
  p->nread = 0;
801033c1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033c8:	00 00 00 
  initlock(&p->lock, "pipe");
801033cb:	68 10 80 10 80       	push   $0x80108010
801033d0:	50                   	push   %eax
801033d1:	e8 8a 17 00 00       	call   80104b60 <initlock>
  (*f0)->type = FD_PIPE;
801033d6:	8b 03                	mov    (%ebx),%eax
  return 0;
801033d8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033db:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033e1:	8b 03                	mov    (%ebx),%eax
801033e3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033e7:	8b 03                	mov    (%ebx),%eax
801033e9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033ed:	8b 03                	mov    (%ebx),%eax
801033ef:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033f2:	8b 06                	mov    (%esi),%eax
801033f4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033fa:	8b 06                	mov    (%esi),%eax
801033fc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103400:	8b 06                	mov    (%esi),%eax
80103402:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103406:	8b 06                	mov    (%esi),%eax
80103408:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010340b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010340e:	31 c0                	xor    %eax,%eax
}
80103410:	5b                   	pop    %ebx
80103411:	5e                   	pop    %esi
80103412:	5f                   	pop    %edi
80103413:	5d                   	pop    %ebp
80103414:	c3                   	ret    
80103415:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103420 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	56                   	push   %esi
80103424:	53                   	push   %ebx
80103425:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103428:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010342b:	83 ec 0c             	sub    $0xc,%esp
8010342e:	53                   	push   %ebx
8010342f:	e8 6c 18 00 00       	call   80104ca0 <acquire>
  if(writable){
80103434:	83 c4 10             	add    $0x10,%esp
80103437:	85 f6                	test   %esi,%esi
80103439:	74 45                	je     80103480 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010343b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103441:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103444:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010344b:	00 00 00 
    wakeup(&p->nread);
8010344e:	50                   	push   %eax
8010344f:	e8 5c 0e 00 00       	call   801042b0 <wakeup>
80103454:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103457:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010345d:	85 d2                	test   %edx,%edx
8010345f:	75 0a                	jne    8010346b <pipeclose+0x4b>
80103461:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103467:	85 c0                	test   %eax,%eax
80103469:	74 35                	je     801034a0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010346b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010346e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103471:	5b                   	pop    %ebx
80103472:	5e                   	pop    %esi
80103473:	5d                   	pop    %ebp
    release(&p->lock);
80103474:	e9 e7 18 00 00       	jmp    80104d60 <release>
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103480:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103486:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103489:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103490:	00 00 00 
    wakeup(&p->nwrite);
80103493:	50                   	push   %eax
80103494:	e8 17 0e 00 00       	call   801042b0 <wakeup>
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	eb b9                	jmp    80103457 <pipeclose+0x37>
8010349e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 b7 18 00 00       	call   80104d60 <release>
    kfree((char*)p);
801034a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034ac:	83 c4 10             	add    $0x10,%esp
}
801034af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b2:	5b                   	pop    %ebx
801034b3:	5e                   	pop    %esi
801034b4:	5d                   	pop    %ebp
    kfree((char*)p);
801034b5:	e9 26 ef ff ff       	jmp    801023e0 <kfree>
801034ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	57                   	push   %edi
801034c4:	56                   	push   %esi
801034c5:	53                   	push   %ebx
801034c6:	83 ec 28             	sub    $0x28,%esp
801034c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034cc:	53                   	push   %ebx
801034cd:	e8 ce 17 00 00       	call   80104ca0 <acquire>
  for(i = 0; i < n; i++){
801034d2:	8b 45 10             	mov    0x10(%ebp),%eax
801034d5:	83 c4 10             	add    $0x10,%esp
801034d8:	85 c0                	test   %eax,%eax
801034da:	0f 8e c9 00 00 00    	jle    801035a9 <pipewrite+0xe9>
801034e0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034e3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034ef:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034f2:	03 4d 10             	add    0x10(%ebp),%ecx
801034f5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034f8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801034fe:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103504:	39 d0                	cmp    %edx,%eax
80103506:	75 71                	jne    80103579 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103508:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010350e:	85 c0                	test   %eax,%eax
80103510:	74 4e                	je     80103560 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103512:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103518:	eb 3a                	jmp    80103554 <pipewrite+0x94>
8010351a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	57                   	push   %edi
80103524:	e8 87 0d 00 00       	call   801042b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103529:	5a                   	pop    %edx
8010352a:	59                   	pop    %ecx
8010352b:	53                   	push   %ebx
8010352c:	56                   	push   %esi
8010352d:	e8 0e 0b 00 00       	call   80104040 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103532:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103538:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010353e:	83 c4 10             	add    $0x10,%esp
80103541:	05 00 02 00 00       	add    $0x200,%eax
80103546:	39 c2                	cmp    %eax,%edx
80103548:	75 36                	jne    80103580 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010354a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103550:	85 c0                	test   %eax,%eax
80103552:	74 0c                	je     80103560 <pipewrite+0xa0>
80103554:	e8 07 04 00 00       	call   80103960 <myproc>
80103559:	8b 40 14             	mov    0x14(%eax),%eax
8010355c:	85 c0                	test   %eax,%eax
8010355e:	74 c0                	je     80103520 <pipewrite+0x60>
        release(&p->lock);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	53                   	push   %ebx
80103564:	e8 f7 17 00 00       	call   80104d60 <release>
        return -1;
80103569:	83 c4 10             	add    $0x10,%esp
8010356c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103571:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103574:	5b                   	pop    %ebx
80103575:	5e                   	pop    %esi
80103576:	5f                   	pop    %edi
80103577:	5d                   	pop    %ebp
80103578:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103579:	89 c2                	mov    %eax,%edx
8010357b:	90                   	nop
8010357c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103580:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103583:	8d 42 01             	lea    0x1(%edx),%eax
80103586:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010358c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103592:	83 c6 01             	add    $0x1,%esi
80103595:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103599:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010359c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010359f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801035a3:	0f 85 4f ff ff ff    	jne    801034f8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035a9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035af:	83 ec 0c             	sub    $0xc,%esp
801035b2:	50                   	push   %eax
801035b3:	e8 f8 0c 00 00       	call   801042b0 <wakeup>
  release(&p->lock);
801035b8:	89 1c 24             	mov    %ebx,(%esp)
801035bb:	e8 a0 17 00 00       	call   80104d60 <release>
  return n;
801035c0:	83 c4 10             	add    $0x10,%esp
801035c3:	8b 45 10             	mov    0x10(%ebp),%eax
801035c6:	eb a9                	jmp    80103571 <pipewrite+0xb1>
801035c8:	90                   	nop
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035d0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 18             	sub    $0x18,%esp
801035d9:	8b 75 08             	mov    0x8(%ebp),%esi
801035dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035df:	56                   	push   %esi
801035e0:	e8 bb 16 00 00       	call   80104ca0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035e5:	83 c4 10             	add    $0x10,%esp
801035e8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035ee:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035f4:	75 6a                	jne    80103660 <piperead+0x90>
801035f6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801035fc:	85 db                	test   %ebx,%ebx
801035fe:	0f 84 c4 00 00 00    	je     801036c8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103604:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010360a:	eb 2d                	jmp    80103639 <piperead+0x69>
8010360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103610:	83 ec 08             	sub    $0x8,%esp
80103613:	56                   	push   %esi
80103614:	53                   	push   %ebx
80103615:	e8 26 0a 00 00       	call   80104040 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010361a:	83 c4 10             	add    $0x10,%esp
8010361d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103623:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103629:	75 35                	jne    80103660 <piperead+0x90>
8010362b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103631:	85 d2                	test   %edx,%edx
80103633:	0f 84 8f 00 00 00    	je     801036c8 <piperead+0xf8>
    if(myproc()->killed){
80103639:	e8 22 03 00 00       	call   80103960 <myproc>
8010363e:	8b 48 14             	mov    0x14(%eax),%ecx
80103641:	85 c9                	test   %ecx,%ecx
80103643:	74 cb                	je     80103610 <piperead+0x40>
      release(&p->lock);
80103645:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103648:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010364d:	56                   	push   %esi
8010364e:	e8 0d 17 00 00       	call   80104d60 <release>
      return -1;
80103653:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103656:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103659:	89 d8                	mov    %ebx,%eax
8010365b:	5b                   	pop    %ebx
8010365c:	5e                   	pop    %esi
8010365d:	5f                   	pop    %edi
8010365e:	5d                   	pop    %ebp
8010365f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103660:	8b 45 10             	mov    0x10(%ebp),%eax
80103663:	85 c0                	test   %eax,%eax
80103665:	7e 61                	jle    801036c8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103667:	31 db                	xor    %ebx,%ebx
80103669:	eb 13                	jmp    8010367e <piperead+0xae>
8010366b:	90                   	nop
8010366c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103670:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103676:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010367c:	74 1f                	je     8010369d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010367e:	8d 41 01             	lea    0x1(%ecx),%eax
80103681:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103687:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010368d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103692:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103695:	83 c3 01             	add    $0x1,%ebx
80103698:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010369b:	75 d3                	jne    80103670 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010369d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801036a3:	83 ec 0c             	sub    $0xc,%esp
801036a6:	50                   	push   %eax
801036a7:	e8 04 0c 00 00       	call   801042b0 <wakeup>
  release(&p->lock);
801036ac:	89 34 24             	mov    %esi,(%esp)
801036af:	e8 ac 16 00 00       	call   80104d60 <release>
  return i;
801036b4:	83 c4 10             	add    $0x10,%esp
}
801036b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ba:	89 d8                	mov    %ebx,%eax
801036bc:	5b                   	pop    %ebx
801036bd:	5e                   	pop    %esi
801036be:	5f                   	pop    %edi
801036bf:	5d                   	pop    %ebp
801036c0:	c3                   	ret    
801036c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c8:	31 db                	xor    %ebx,%ebx
801036ca:	eb d1                	jmp    8010369d <piperead+0xcd>
801036cc:	66 90                	xchg   %ax,%ax
801036ce:	66 90                	xchg   %ax,%ax

801036d0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	56                   	push   %esi
801036d4:	53                   	push   %ebx
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801036d5:	bb d4 4e 11 80       	mov    $0x80114ed4,%ebx
801036da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == UNUSED){
801036e0:	8b 53 08             	mov    0x8(%ebx),%edx
801036e3:	85 d2                	test   %edx,%edx
801036e5:	74 39                	je     80103720 <wakeup1+0x50>
      continue;
    }
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801036e7:	8b 73 6c             	mov    0x6c(%ebx),%esi
801036ea:	89 f2                	mov    %esi,%edx
801036ec:	eb 0f                	jmp    801036fd <wakeup1+0x2d>
801036ee:	66 90                	xchg   %ax,%ax
801036f0:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
801036f6:	83 c2 24             	add    $0x24,%edx
801036f9:	39 ca                	cmp    %ecx,%edx
801036fb:	73 23                	jae    80103720 <wakeup1+0x50>
      if(t->state == SLEEPING && t->chan == chan){
801036fd:	83 7a 08 01          	cmpl   $0x1,0x8(%edx)
80103701:	75 ed                	jne    801036f0 <wakeup1+0x20>
80103703:	39 42 1c             	cmp    %eax,0x1c(%edx)
80103706:	75 e8                	jne    801036f0 <wakeup1+0x20>
        t->state = RUNNABLE;
80103708:	c7 42 08 02 00 00 00 	movl   $0x2,0x8(%edx)
8010370f:	8b 73 6c             	mov    0x6c(%ebx),%esi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103712:	83 c2 24             	add    $0x24,%edx
80103715:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
8010371b:	39 ca                	cmp    %ecx,%edx
8010371d:	72 de                	jb     801036fd <wakeup1+0x2d>
8010371f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103720:	83 c3 70             	add    $0x70,%ebx
80103723:	81 fb d4 6a 11 80    	cmp    $0x80116ad4,%ebx
80103729:	72 b5                	jb     801036e0 <wakeup1+0x10>
      }
    }
  }
}
8010372b:	5b                   	pop    %ebx
8010372c:	5e                   	pop    %esi
8010372d:	5d                   	pop    %ebp
8010372e:	c3                   	ret    
8010372f:	90                   	nop

80103730 <allocproc>:
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	56                   	push   %esi
80103734:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103735:	bb d4 4e 11 80       	mov    $0x80114ed4,%ebx
  acquire(&ptable.lock);
8010373a:	83 ec 0c             	sub    $0xc,%esp
8010373d:	68 a0 4e 11 80       	push   $0x80114ea0
80103742:	e8 59 15 00 00       	call   80104ca0 <acquire>
80103747:	83 c4 10             	add    $0x10,%esp
  int i = 0;
8010374a:	31 c0                	xor    %eax,%eax
8010374c:	eb 14                	jmp    80103762 <allocproc+0x32>
8010374e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103750:	83 c3 70             	add    $0x70,%ebx
      i++;
80103753:	83 c0 01             	add    $0x1,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103756:	81 fb d4 6a 11 80    	cmp    $0x80116ad4,%ebx
8010375c:	0f 83 be 00 00 00    	jae    80103820 <allocproc+0xf0>
    if(p->state == UNUSED)
80103762:	8b 53 08             	mov    0x8(%ebx),%edx
80103765:	85 d2                	test   %edx,%edx
80103767:	75 e7                	jne    80103750 <allocproc+0x20>
  p->pid = nextpid++;
80103769:	8b 15 08 b0 10 80    	mov    0x8010b008,%edx
  p->threads = ptable.ttable[i].threads;
8010376f:	8d 04 c0             	lea    (%eax,%eax,8),%eax
  p->state = EMBRYO;
80103772:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  p->threads = ptable.ttable[i].threads;
80103779:	c1 e0 06             	shl    $0x6,%eax
  p->pid = nextpid++;
8010377c:	8d 4a 01             	lea    0x1(%edx),%ecx
  p->threads = ptable.ttable[i].threads;
8010377f:	05 d4 6a 11 80       	add    $0x80116ad4,%eax
  p->pid = nextpid++;
80103784:	89 53 0c             	mov    %edx,0xc(%ebx)
  p->threads = ptable.ttable[i].threads;
80103787:	89 43 6c             	mov    %eax,0x6c(%ebx)
  p->pid = nextpid++;
8010378a:	89 0d 08 b0 10 80    	mov    %ecx,0x8010b008
    tTemp->state = UNINIT;
80103790:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  for(tTemp = p->threads; tTemp < &p->threads[NTHREAD]; tTemp++){
80103797:	8b 73 6c             	mov    0x6c(%ebx),%esi
8010379a:	83 c0 24             	add    $0x24,%eax
8010379d:	8d 96 40 02 00 00    	lea    0x240(%esi),%edx
801037a3:	39 d0                	cmp    %edx,%eax
801037a5:	72 e9                	jb     80103790 <allocproc+0x60>
  t->tid = nexttid++;
801037a7:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  release(&ptable.lock);
801037ac:	83 ec 0c             	sub    $0xc,%esp
  t->tproc = p;
801037af:	89 5e 10             	mov    %ebx,0x10(%esi)
  t->exitRequest = 0;
801037b2:	c7 46 20 00 00 00 00 	movl   $0x0,0x20(%esi)
  t->tid = nexttid++;
801037b9:	8d 50 01             	lea    0x1(%eax),%edx
801037bc:	89 46 0c             	mov    %eax,0xc(%esi)
  release(&ptable.lock);
801037bf:	68 a0 4e 11 80       	push   $0x80114ea0
  t->tid = nexttid++;
801037c4:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801037ca:	e8 91 15 00 00       	call   80104d60 <release>
  if((t->kstack = kalloc()) == 0){
801037cf:	e8 bc ed ff ff       	call   80102590 <kalloc>
801037d4:	83 c4 10             	add    $0x10,%esp
801037d7:	85 c0                	test   %eax,%eax
801037d9:	89 06                	mov    %eax,(%esi)
801037db:	74 5e                	je     8010383b <allocproc+0x10b>
  sp -= sizeof *t->tf;
801037dd:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(t->context, 0, sizeof *t->context);
801037e3:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *t->context;
801037e6:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *t->tf;
801037eb:	89 56 14             	mov    %edx,0x14(%esi)
  *(uint*)sp = (uint)trapret;
801037ee:	c7 40 14 2f 61 10 80 	movl   $0x8010612f,0x14(%eax)
  t->context = (struct context*)sp;
801037f5:	89 46 18             	mov    %eax,0x18(%esi)
  memset(t->context, 0, sizeof *t->context);
801037f8:	6a 14                	push   $0x14
801037fa:	6a 00                	push   $0x0
801037fc:	50                   	push   %eax
801037fd:	e8 ae 15 00 00       	call   80104db0 <memset>
  t->context->eip = (uint)forkret;
80103802:	8b 46 18             	mov    0x18(%esi),%eax
  return p;
80103805:	83 c4 10             	add    $0x10,%esp
  t->context->eip = (uint)forkret;
80103808:	c7 40 10 40 38 10 80 	movl   $0x80103840,0x10(%eax)
}
8010380f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103812:	89 d8                	mov    %ebx,%eax
80103814:	5b                   	pop    %ebx
80103815:	5e                   	pop    %esi
80103816:	5d                   	pop    %ebp
80103817:	c3                   	ret    
80103818:	90                   	nop
80103819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103820:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103823:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103825:	68 a0 4e 11 80       	push   $0x80114ea0
8010382a:	e8 31 15 00 00       	call   80104d60 <release>
  return 0;
8010382f:	83 c4 10             	add    $0x10,%esp
}
80103832:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103835:	89 d8                	mov    %ebx,%eax
80103837:	5b                   	pop    %ebx
80103838:	5e                   	pop    %esi
80103839:	5d                   	pop    %ebp
8010383a:	c3                   	ret    
    return 0;
8010383b:	31 db                	xor    %ebx,%ebx
8010383d:	eb d0                	jmp    8010380f <allocproc+0xdf>
8010383f:	90                   	nop

80103840 <forkret>:
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103846:	68 a0 4e 11 80       	push   $0x80114ea0
8010384b:	e8 10 15 00 00       	call   80104d60 <release>
  if (first) {
80103850:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103855:	83 c4 10             	add    $0x10,%esp
80103858:	85 c0                	test   %eax,%eax
8010385a:	75 04                	jne    80103860 <forkret+0x20>
}
8010385c:	c9                   	leave  
8010385d:	c3                   	ret    
8010385e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103860:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103863:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010386a:	00 00 00 
    iinit(ROOTDEV);
8010386d:	6a 01                	push   $0x1
8010386f:	e8 dc dc ff ff       	call   80101550 <iinit>
    initlog(ROOTDEV);
80103874:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010387b:	e8 50 f3 ff ff       	call   80102bd0 <initlog>
80103880:	83 c4 10             	add    $0x10,%esp
}
80103883:	c9                   	leave  
80103884:	c3                   	ret    
80103885:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103890 <pinit>:
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103896:	68 15 80 10 80       	push   $0x80108015
8010389b:	68 a0 4e 11 80       	push   $0x80114ea0
801038a0:	e8 bb 12 00 00       	call   80104b60 <initlock>
  initlock(&mutexTable.lock, "mutexTable");
801038a5:	58                   	pop    %eax
801038a6:	5a                   	pop    %edx
801038a7:	68 1c 80 10 80       	push   $0x8010801c
801038ac:	68 60 3d 11 80       	push   $0x80113d60
801038b1:	e8 aa 12 00 00       	call   80104b60 <initlock>
}
801038b6:	83 c4 10             	add    $0x10,%esp
801038b9:	c9                   	leave  
801038ba:	c3                   	ret    
801038bb:	90                   	nop
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

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
801038cc:	e8 2f ef ff ff       	call   80102800 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038d1:	8b 35 40 3d 11 80    	mov    0x80113d40,%esi
801038d7:	85 f6                	test   %esi,%esi
801038d9:	7e 42                	jle    8010391d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038db:	0f b6 15 a0 37 11 80 	movzbl 0x801137a0,%edx
801038e2:	39 d0                	cmp    %edx,%eax
801038e4:	74 30                	je     80103916 <mycpu+0x56>
801038e6:	b9 54 38 11 80       	mov    $0x80113854,%ecx
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
8010390a:	05 a0 37 11 80       	add    $0x801137a0,%eax
}
8010390f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103912:	5b                   	pop    %ebx
80103913:	5e                   	pop    %esi
80103914:	5d                   	pop    %ebp
80103915:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103916:	b8 a0 37 11 80       	mov    $0x801137a0,%eax
      return &cpus[i];
8010391b:	eb f2                	jmp    8010390f <mycpu+0x4f>
  panic("unknown apicid\n");
8010391d:	83 ec 0c             	sub    $0xc,%esp
80103920:	68 27 80 10 80       	push   $0x80108027
80103925:	e8 66 ca ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010392a:	83 ec 0c             	sub    $0xc,%esp
8010392d:	68 38 81 10 80       	push   $0x80108138
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
8010394b:	2d a0 37 11 80       	sub    $0x801137a0,%eax
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
80103967:	e8 64 12 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
8010396c:	e8 4f ff ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103971:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103977:	e8 94 12 00 00       	call   80104c10 <popcli>
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
80103997:	e8 34 12 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
8010399c:	e8 1f ff ff ff       	call   801038c0 <mycpu>
  t = c->thread;
801039a1:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
801039a7:	e8 64 12 00 00       	call   80104c10 <popcli>
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
801039c5:	e8 66 fd ff ff       	call   80103730 <allocproc>
801039ca:	89 c6                	mov    %eax,%esi
  initproc = p;
801039cc:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
801039d1:	e8 1a 3e 00 00       	call   801077f0 <setupkvm>
801039d6:	85 c0                	test   %eax,%eax
801039d8:	89 46 04             	mov    %eax,0x4(%esi)
801039db:	0f 84 c9 00 00 00    	je     80103aaa <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039e1:	83 ec 04             	sub    $0x4,%esp
801039e4:	68 2c 00 00 00       	push   $0x2c
801039e9:	68 60 b4 10 80       	push   $0x8010b460
801039ee:	50                   	push   %eax
801039ef:	e8 dc 3a 00 00       	call   801074d0 <inituvm>
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
80103a07:	e8 a4 13 00 00       	call   80104db0 <memset>
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
80103a60:	68 50 80 10 80       	push   $0x80108050
80103a65:	50                   	push   %eax
80103a66:	e8 25 15 00 00       	call   80104f90 <safestrcpy>
  p->cwd = namei("/");
80103a6b:	c7 04 24 59 80 10 80 	movl   $0x80108059,(%esp)
80103a72:	e8 39 e5 ff ff       	call   80101fb0 <namei>
80103a77:	89 46 58             	mov    %eax,0x58(%esi)
  acquire(&ptable.lock);
80103a7a:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80103a81:	e8 1a 12 00 00       	call   80104ca0 <acquire>
  p->state = USED;
80103a86:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
  t->state = RUNNABLE;
80103a8d:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  release(&ptable.lock);
80103a94:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80103a9b:	e8 c0 12 00 00       	call   80104d60 <release>
}
80103aa0:	83 c4 10             	add    $0x10,%esp
80103aa3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa6:	5b                   	pop    %ebx
80103aa7:	5e                   	pop    %esi
80103aa8:	5d                   	pop    %ebp
80103aa9:	c3                   	ret    
    panic("userinit: out of memory?");
80103aaa:	83 ec 0c             	sub    $0xc,%esp
80103aad:	68 37 80 10 80       	push   $0x80108037
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
80103ac8:	e8 03 11 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80103acd:	e8 ee fd ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103ad2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ad8:	e8 33 11 00 00       	call   80104c10 <popcli>
  acquire(&ptable.lock);
80103add:	83 ec 0c             	sub    $0xc,%esp
80103ae0:	68 a0 4e 11 80       	push   $0x80114ea0
80103ae5:	e8 b6 11 00 00       	call   80104ca0 <acquire>
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
80103afc:	e8 bf 38 00 00       	call   801073c0 <switchuvm>
  release(&ptable.lock);
80103b01:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80103b08:	e8 53 12 00 00       	call   80104d60 <release>
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
80103b2a:	e8 e1 3a 00 00       	call   80107610 <allocuvm>
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	85 c0                	test   %eax,%eax
80103b34:	75 c0                	jne    80103af6 <growproc+0x36>
      release(&ptable.lock);
80103b36:	83 ec 0c             	sub    $0xc,%esp
80103b39:	68 a0 4e 11 80       	push   $0x80114ea0
80103b3e:	e8 1d 12 00 00       	call   80104d60 <release>
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
80103b5a:	e8 e1 3b 00 00       	call   80107740 <deallocuvm>
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
80103b79:	e8 52 10 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80103b7e:	e8 3d fd ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103b83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b89:	e8 82 10 00 00       	call   80104c10 <popcli>
  pushcli();
80103b8e:	e8 3d 10 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80103b93:	e8 28 fd ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103b98:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
  popcli();
80103b9e:	e8 6d 10 00 00       	call   80104c10 <popcli>
  if((np = allocproc()) == 0){
80103ba3:	e8 88 fb ff ff       	call   80103730 <allocproc>
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
80103bc6:	e8 f5 3c 00 00       	call   801078c0 <copyuvm>
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
80103c14:	e8 97 d2 ff ff       	call   80100eb0 <filedup>
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
80103c31:	e8 ea da ff ff       	call   80101720 <idup>
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
80103c46:	e8 45 13 00 00       	call   80104f90 <safestrcpy>
  pid = np->pid;
80103c4b:	8b 5f 0c             	mov    0xc(%edi),%ebx
  acquire(&ptable.lock);
80103c4e:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80103c55:	e8 46 10 00 00       	call   80104ca0 <acquire>
  nt->state = RUNNABLE;
80103c5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  np->state = USED;
80103c5d:	c7 47 08 02 00 00 00 	movl   $0x2,0x8(%edi)
  nt->state = RUNNABLE;
80103c64:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)
  release(&ptable.lock);
80103c6b:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80103c72:	e8 e9 10 00 00       	call   80104d60 <release>
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
80103c93:	e8 48 e7 ff ff       	call   801023e0 <kfree>
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
80103cee:	be d4 4e 11 80       	mov    $0x80114ed4,%esi
    acquire(&ptable.lock);
80103cf3:	68 a0 4e 11 80       	push   $0x80114ea0
80103cf8:	e8 a3 0f 00 00       	call   80104ca0 <acquire>
80103cfd:	83 c4 10             	add    $0x10,%esp
80103d00:	eb 11                	jmp    80103d13 <scheduler+0x53>
80103d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d08:	83 c6 70             	add    $0x70,%esi
80103d0b:	81 fe d4 6a 11 80    	cmp    $0x80116ad4,%esi
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
80103d36:	e8 85 36 00 00       	call   801073c0 <switchuvm>
        t->state = RUNNING;
80103d3b:	c7 43 08 03 00 00 00 	movl   $0x3,0x8(%ebx)
        swtch(&(c->scheduler), t->context);
80103d42:	58                   	pop    %eax
80103d43:	5a                   	pop    %edx
80103d44:	ff 73 18             	pushl  0x18(%ebx)
80103d47:	ff 75 e4             	pushl  -0x1c(%ebp)
80103d4a:	e8 9c 12 00 00       	call   80104feb <swtch>
        switchkvm();
80103d4f:	e8 4c 36 00 00       	call   801073a0 <switchkvm>
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
80103d7e:	81 fe d4 6a 11 80    	cmp    $0x80116ad4,%esi
80103d84:	72 8d                	jb     80103d13 <scheduler+0x53>
    release(&ptable.lock);
80103d86:	83 ec 0c             	sub    $0xc,%esp
80103d89:	68 a0 4e 11 80       	push   $0x80114ea0
80103d8e:	e8 cd 0f 00 00       	call   80104d60 <release>
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
80103da5:	e8 26 0e 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80103daa:	e8 11 fb ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103daf:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103db5:	e8 56 0e 00 00       	call   80104c10 <popcli>
  if(!holding(&ptable.lock))
80103dba:	83 ec 0c             	sub    $0xc,%esp
80103dbd:	68 a0 4e 11 80       	push   $0x80114ea0
80103dc2:	e8 a9 0e 00 00       	call   80104c70 <holding>
80103dc7:	83 c4 10             	add    $0x10,%esp
80103dca:	85 c0                	test   %eax,%eax
80103dcc:	74 4f                	je     80103e1d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dce:	e8 ed fa ff ff       	call   801038c0 <mycpu>
80103dd3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dda:	75 76                	jne    80103e52 <sched+0xb2>
  if(t->state == RUNNING){
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
80103e03:	e8 e3 11 00 00       	call   80104feb <swtch>
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
80103e20:	68 5b 80 10 80       	push   $0x8010805b
80103e25:	e8 66 c5 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	68 98 80 10 80       	push   $0x80108098
80103e32:	e8 59 c5 ff ff       	call   80100390 <panic>
    cprintf("sched thread=%d\n", t->tid);
80103e37:	50                   	push   %eax
80103e38:	50                   	push   %eax
80103e39:	ff 73 0c             	pushl  0xc(%ebx)
80103e3c:	68 79 80 10 80       	push   $0x80108079
80103e41:	e8 1a c8 ff ff       	call   80100660 <cprintf>
    panic("sched running");
80103e46:	c7 04 24 8a 80 10 80 	movl   $0x8010808a,(%esp)
80103e4d:	e8 3e c5 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103e52:	83 ec 0c             	sub    $0xc,%esp
80103e55:	68 6d 80 10 80       	push   $0x8010806d
80103e5a:	e8 31 c5 ff ff       	call   80100390 <panic>
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
80103e69:	e8 62 0d 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80103e6e:	e8 4d fa ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80103e73:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e79:	e8 92 0d 00 00       	call   80104c10 <popcli>
  pushcli();
80103e7e:	e8 4d 0d 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80103e83:	e8 38 fa ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80103e88:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80103e8e:	e8 7d 0d 00 00       	call   80104c10 <popcli>
  if(curproc == initproc)
80103e93:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103e99:	74 7e                	je     80103f19 <exit+0xb9>
  acquire(&ptable.lock);
80103e9b:	83 ec 0c             	sub    $0xc,%esp
80103e9e:	68 a0 4e 11 80       	push   $0x80114ea0
80103ea3:	e8 f8 0d 00 00       	call   80104ca0 <acquire>
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103ea8:	8b 7e 6c             	mov    0x6c(%esi),%edi
80103eab:	83 c4 10             	add    $0x10,%esp
80103eae:	89 f9                	mov    %edi,%ecx
    if(t->state != UNINIT && t->state != TERMINATED)
80103eb0:	8b 41 08             	mov    0x8(%ecx),%eax
80103eb3:	85 c0                	test   %eax,%eax
80103eb5:	74 0f                	je     80103ec6 <exit+0x66>
80103eb7:	83 f8 05             	cmp    $0x5,%eax
80103eba:	74 0a                	je     80103ec6 <exit+0x66>
      t->exitRequest = 1;
80103ebc:	c7 41 20 01 00 00 00 	movl   $0x1,0x20(%ecx)
80103ec3:	8b 7e 6c             	mov    0x6c(%esi),%edi
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103ec6:	8d 97 40 02 00 00    	lea    0x240(%edi),%edx
80103ecc:	83 c1 24             	add    $0x24,%ecx
80103ecf:	89 f8                	mov    %edi,%eax
80103ed1:	39 ca                	cmp    %ecx,%edx
80103ed3:	77 db                	ja     80103eb0 <exit+0x50>
  int lastRunning = 1;
80103ed5:	bf 01 00 00 00       	mov    $0x1,%edi
80103eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80103ee0:	39 c3                	cmp    %eax,%ebx
80103ee2:	74 12                	je     80103ef6 <exit+0x96>
80103ee4:	8b 48 08             	mov    0x8(%eax),%ecx
80103ee7:	85 c9                	test   %ecx,%ecx
80103ee9:	74 0b                	je     80103ef6 <exit+0x96>
          lastRunning = 0;
80103eeb:	83 f9 05             	cmp    $0x5,%ecx
80103eee:	b9 00 00 00 00       	mov    $0x0,%ecx
80103ef3:	0f 45 f9             	cmovne %ecx,%edi
  for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
80103ef6:	83 c0 24             	add    $0x24,%eax
80103ef9:	39 c2                	cmp    %eax,%edx
80103efb:	77 e3                	ja     80103ee0 <exit+0x80>
  if(lastRunning){
80103efd:	85 ff                	test   %edi,%edi
80103eff:	75 25                	jne    80103f26 <exit+0xc6>
    release(&ptable.lock);
80103f01:	83 ec 0c             	sub    $0xc,%esp
80103f04:	68 a0 4e 11 80       	push   $0x80114ea0
80103f09:	e8 52 0e 00 00       	call   80104d60 <release>
}
80103f0e:	83 c4 10             	add    $0x10,%esp
80103f11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f14:	5b                   	pop    %ebx
80103f15:	5e                   	pop    %esi
80103f16:	5f                   	pop    %edi
80103f17:	5d                   	pop    %ebp
80103f18:	c3                   	ret    
    panic("init exiting");
80103f19:	83 ec 0c             	sub    $0xc,%esp
80103f1c:	68 ac 80 10 80       	push   $0x801080ac
80103f21:	e8 6a c4 ff ff       	call   80100390 <panic>
    release(&ptable.lock);
80103f26:	83 ec 0c             	sub    $0xc,%esp
80103f29:	8d 7e 18             	lea    0x18(%esi),%edi
80103f2c:	68 a0 4e 11 80       	push   $0x80114ea0
80103f31:	e8 2a 0e 00 00       	call   80104d60 <release>
80103f36:	8d 46 58             	lea    0x58(%esi),%eax
80103f39:	83 c4 10             	add    $0x10,%esp
80103f3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(curproc->ofile[fd]){
80103f3f:	8b 07                	mov    (%edi),%eax
80103f41:	85 c0                	test   %eax,%eax
80103f43:	74 12                	je     80103f57 <exit+0xf7>
        fileclose(curproc->ofile[fd]);
80103f45:	83 ec 0c             	sub    $0xc,%esp
80103f48:	50                   	push   %eax
80103f49:	e8 b2 cf ff ff       	call   80100f00 <fileclose>
        curproc->ofile[fd] = 0;
80103f4e:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103f54:	83 c4 10             	add    $0x10,%esp
80103f57:	83 c7 04             	add    $0x4,%edi
    for(fd = 0; fd < NOFILE; fd++){
80103f5a:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80103f5d:	75 e0                	jne    80103f3f <exit+0xdf>
    begin_op();
80103f5f:	e8 0c ed ff ff       	call   80102c70 <begin_op>
    iput(curproc->cwd);
80103f64:	83 ec 0c             	sub    $0xc,%esp
80103f67:	ff 76 58             	pushl  0x58(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f6a:	bf d4 4e 11 80       	mov    $0x80114ed4,%edi
    iput(curproc->cwd);
80103f6f:	e8 0c d9 ff ff       	call   80101880 <iput>
    end_op();
80103f74:	e8 67 ed ff ff       	call   80102ce0 <end_op>
    curproc->cwd = 0;
80103f79:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
    acquire(&ptable.lock);
80103f80:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80103f87:	e8 14 0d 00 00       	call   80104ca0 <acquire>
    wakeup1(curproc->parent);
80103f8c:	8b 46 10             	mov    0x10(%esi),%eax
80103f8f:	e8 3c f7 ff ff       	call   801036d0 <wakeup1>
80103f94:	83 c4 10             	add    $0x10,%esp
80103f97:	eb 12                	jmp    80103fab <exit+0x14b>
80103f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fa0:	83 c7 70             	add    $0x70,%edi
80103fa3:	81 ff d4 6a 11 80    	cmp    $0x80116ad4,%edi
80103fa9:	73 1a                	jae    80103fc5 <exit+0x165>
      if(p->parent == curproc){
80103fab:	39 77 10             	cmp    %esi,0x10(%edi)
80103fae:	75 f0                	jne    80103fa0 <exit+0x140>
        if(p->state == ZOMBIE)
80103fb0:	83 7f 08 03          	cmpl   $0x3,0x8(%edi)
        p->parent = initproc;
80103fb4:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
80103fb9:	89 47 10             	mov    %eax,0x10(%edi)
        if(p->state == ZOMBIE)
80103fbc:	75 e2                	jne    80103fa0 <exit+0x140>
          wakeup1(initproc);
80103fbe:	e8 0d f7 ff ff       	call   801036d0 <wakeup1>
80103fc3:	eb db                	jmp    80103fa0 <exit+0x140>
    wakeup1(curthread);
80103fc5:	89 d8                	mov    %ebx,%eax
80103fc7:	e8 04 f7 ff ff       	call   801036d0 <wakeup1>
    curproc->state = ZOMBIE;
80103fcc:	c7 46 08 03 00 00 00 	movl   $0x3,0x8(%esi)
    curthread->state = TERMINATED;
80103fd3:	c7 43 08 05 00 00 00 	movl   $0x5,0x8(%ebx)
    sched();
80103fda:	e8 c1 fd ff ff       	call   80103da0 <sched>
    panic("zombie exit");
80103fdf:	83 ec 0c             	sub    $0xc,%esp
80103fe2:	68 b9 80 10 80       	push   $0x801080b9
80103fe7:	e8 a4 c3 ff ff       	call   80100390 <panic>
80103fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ff0 <yield>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	53                   	push   %ebx
80103ff4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ff7:	68 a0 4e 11 80       	push   $0x80114ea0
80103ffc:	e8 9f 0c 00 00       	call   80104ca0 <acquire>
  pushcli();
80104001:	e8 ca 0b 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80104006:	e8 b5 f8 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
8010400b:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
80104011:	e8 fa 0b 00 00       	call   80104c10 <popcli>
  mythread()->state = RUNNABLE;
80104016:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
  sched();
8010401d:	e8 7e fd ff ff       	call   80103da0 <sched>
  release(&ptable.lock);
80104022:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104029:	e8 32 0d 00 00       	call   80104d60 <release>
}
8010402e:	83 c4 10             	add    $0x10,%esp
80104031:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104034:	c9                   	leave  
80104035:	c3                   	ret    
80104036:	8d 76 00             	lea    0x0(%esi),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <sleep>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
80104045:	53                   	push   %ebx
80104046:	83 ec 0c             	sub    $0xc,%esp
80104049:	8b 7d 08             	mov    0x8(%ebp),%edi
8010404c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010404f:	e8 7c 0b 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80104054:	e8 67 f8 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
80104059:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
8010405f:	e8 ac 0b 00 00       	call   80104c10 <popcli>
  if(t == 0)
80104064:	85 db                	test   %ebx,%ebx
80104066:	0f 84 87 00 00 00    	je     801040f3 <sleep+0xb3>
  if(lk == 0)
8010406c:	85 f6                	test   %esi,%esi
8010406e:	74 76                	je     801040e6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104070:	81 fe a0 4e 11 80    	cmp    $0x80114ea0,%esi
80104076:	74 50                	je     801040c8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	68 a0 4e 11 80       	push   $0x80114ea0
80104080:	e8 1b 0c 00 00       	call   80104ca0 <acquire>
    release(lk);
80104085:	89 34 24             	mov    %esi,(%esp)
80104088:	e8 d3 0c 00 00       	call   80104d60 <release>
  t->chan = chan;
8010408d:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
80104090:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
80104097:	e8 04 fd ff ff       	call   80103da0 <sched>
  t->chan = 0;
8010409c:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
    release(&ptable.lock);
801040a3:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
801040aa:	e8 b1 0c 00 00       	call   80104d60 <release>
    acquire(lk);
801040af:	89 75 08             	mov    %esi,0x8(%ebp)
801040b2:	83 c4 10             	add    $0x10,%esp
}
801040b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040b8:	5b                   	pop    %ebx
801040b9:	5e                   	pop    %esi
801040ba:	5f                   	pop    %edi
801040bb:	5d                   	pop    %ebp
    acquire(lk);
801040bc:	e9 df 0b 00 00       	jmp    80104ca0 <acquire>
801040c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  t->chan = chan;
801040c8:	89 7b 1c             	mov    %edi,0x1c(%ebx)
  t->state = SLEEPING;
801040cb:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  sched();
801040d2:	e8 c9 fc ff ff       	call   80103da0 <sched>
  t->chan = 0;
801040d7:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
}
801040de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040e1:	5b                   	pop    %ebx
801040e2:	5e                   	pop    %esi
801040e3:	5f                   	pop    %edi
801040e4:	5d                   	pop    %ebp
801040e5:	c3                   	ret    
    panic("sleep without lk");
801040e6:	83 ec 0c             	sub    $0xc,%esp
801040e9:	68 cb 80 10 80       	push   $0x801080cb
801040ee:	e8 9d c2 ff ff       	call   80100390 <panic>
    panic("sleep");
801040f3:	83 ec 0c             	sub    $0xc,%esp
801040f6:	68 c5 80 10 80       	push   $0x801080c5
801040fb:	e8 90 c2 ff ff       	call   80100390 <panic>

80104100 <wait>:
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
80104104:	56                   	push   %esi
80104105:	53                   	push   %ebx
80104106:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104109:	e8 c2 0a 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
8010410e:	e8 ad f7 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
80104113:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104119:	e8 f2 0a 00 00       	call   80104c10 <popcli>
  acquire(&ptable.lock);
8010411e:	83 ec 0c             	sub    $0xc,%esp
80104121:	68 a0 4e 11 80       	push   $0x80114ea0
80104126:	e8 75 0b 00 00       	call   80104ca0 <acquire>
8010412b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010412e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104130:	bf d4 4e 11 80       	mov    $0x80114ed4,%edi
80104135:	eb 14                	jmp    8010414b <wait+0x4b>
80104137:	89 f6                	mov    %esi,%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104140:	83 c7 70             	add    $0x70,%edi
80104143:	81 ff d4 6a 11 80    	cmp    $0x80116ad4,%edi
80104149:	73 1b                	jae    80104166 <wait+0x66>
      if(p->parent != curproc)
8010414b:	39 5f 10             	cmp    %ebx,0x10(%edi)
8010414e:	75 f0                	jne    80104140 <wait+0x40>
      if(p->state == ZOMBIE){
80104150:	83 7f 08 03          	cmpl   $0x3,0x8(%edi)
80104154:	74 3a                	je     80104190 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104156:	83 c7 70             	add    $0x70,%edi
      havekids = 1;
80104159:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010415e:	81 ff d4 6a 11 80    	cmp    $0x80116ad4,%edi
80104164:	72 e5                	jb     8010414b <wait+0x4b>
    if(!havekids || curproc->killed){
80104166:	85 c0                	test   %eax,%eax
80104168:	0f 84 24 01 00 00    	je     80104292 <wait+0x192>
8010416e:	8b 43 14             	mov    0x14(%ebx),%eax
80104171:	85 c0                	test   %eax,%eax
80104173:	0f 85 19 01 00 00    	jne    80104292 <wait+0x192>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104179:	83 ec 08             	sub    $0x8,%esp
8010417c:	68 a0 4e 11 80       	push   $0x80114ea0
80104181:	53                   	push   %ebx
80104182:	e8 b9 fe ff ff       	call   80104040 <sleep>
    havekids = 0;
80104187:	83 c4 10             	add    $0x10,%esp
8010418a:	eb a2                	jmp    8010412e <wait+0x2e>
8010418c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104190:	8b 77 6c             	mov    0x6c(%edi),%esi
        int hasNonTerminated = 0;
80104193:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010419a:	eb 42                	jmp    801041de <wait+0xde>
8010419c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pushcli();
801041a0:	e8 2b 0a 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
801041a5:	e8 16 f7 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
801041aa:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  popcli();
801041b0:	e8 5b 0a 00 00       	call   80104c10 <popcli>
          if(t != mythread() && t->state != UNINIT && t->state != TERMINATED){
801041b5:	39 f3                	cmp    %esi,%ebx
801041b7:	74 16                	je     801041cf <wait+0xcf>
801041b9:	8b 46 08             	mov    0x8(%esi),%eax
801041bc:	83 f8 05             	cmp    $0x5,%eax
801041bf:	74 0e                	je     801041cf <wait+0xcf>
            hasNonTerminated = 1;
801041c1:	85 c0                	test   %eax,%eax
801041c3:	b8 01 00 00 00       	mov    $0x1,%eax
801041c8:	0f 44 45 e4          	cmove  -0x1c(%ebp),%eax
801041cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801041cf:	8b 47 6c             	mov    0x6c(%edi),%eax
801041d2:	83 c6 24             	add    $0x24,%esi
801041d5:	05 40 02 00 00       	add    $0x240,%eax
801041da:	39 c6                	cmp    %eax,%esi
801041dc:	73 3a                	jae    80104218 <wait+0x118>
          if(t->state == TERMINATED){
801041de:	83 7e 08 05          	cmpl   $0x5,0x8(%esi)
801041e2:	75 bc                	jne    801041a0 <wait+0xa0>
            kfree(t->kstack);
801041e4:	83 ec 0c             	sub    $0xc,%esp
801041e7:	ff 36                	pushl  (%esi)
801041e9:	e8 f2 e1 ff ff       	call   801023e0 <kfree>
            t->kstack = 0;
801041ee:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
            t->tid = 0;
801041f4:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
            t->state = UNINIT;
801041fb:	83 c4 10             	add    $0x10,%esp
            t->tproc = 0;
801041fe:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
            t->exitRequest = 0;
80104205:	c7 46 20 00 00 00 00 	movl   $0x0,0x20(%esi)
            t->state = UNINIT;
8010420c:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
80104213:	eb 8b                	jmp    801041a0 <wait+0xa0>
80104215:	8d 76 00             	lea    0x0(%esi),%esi
        if(!hasNonTerminated){
80104218:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  int havekids, pid = 0;
8010421b:	31 db                	xor    %ebx,%ebx
        if(!hasNonTerminated){
8010421d:	85 d2                	test   %edx,%edx
8010421f:	74 1a                	je     8010423b <wait+0x13b>
        release(&ptable.lock);
80104221:	83 ec 0c             	sub    $0xc,%esp
80104224:	68 a0 4e 11 80       	push   $0x80114ea0
80104229:	e8 32 0b 00 00       	call   80104d60 <release>
        return pid;
8010422e:	83 c4 10             	add    $0x10,%esp
}
80104231:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104234:	89 d8                	mov    %ebx,%eax
80104236:	5b                   	pop    %ebx
80104237:	5e                   	pop    %esi
80104238:	5f                   	pop    %edi
80104239:	5d                   	pop    %ebp
8010423a:	c3                   	ret    
          freevm(p->pgdir);
8010423b:	83 ec 0c             	sub    $0xc,%esp
8010423e:	ff 77 04             	pushl  0x4(%edi)
          pid = p->pid;
80104241:	8b 5f 0c             	mov    0xc(%edi),%ebx
80104244:	be c8 3d 11 80       	mov    $0x80113dc8,%esi
          freevm(p->pgdir);
80104249:	e8 22 35 00 00       	call   80107770 <freevm>
          p->pid = 0;
8010424e:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
          p->parent = 0;
80104255:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
8010425c:	83 c4 10             	add    $0x10,%esp
          p->name[0] = 0;
8010425f:	c6 47 5c 00          	movb   $0x0,0x5c(%edi)
          p->killed = 0;
80104263:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
          p->state = UNUSED;
8010426a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
80104271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_dealloc(mutexTable.mutexes[i].id);
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	ff 36                	pushl  (%esi)
8010427d:	83 c6 44             	add    $0x44,%esi
80104280:	e8 7b 05 00 00       	call   80104800 <kthread_mutex_dealloc>
          for(int i = 0; i < MAX_MUTEXES; i++){
80104285:	83 c4 10             	add    $0x10,%esp
80104288:	81 fe c8 4e 11 80    	cmp    $0x80114ec8,%esi
8010428e:	75 e8                	jne    80104278 <wait+0x178>
80104290:	eb 8f                	jmp    80104221 <wait+0x121>
      release(&ptable.lock);
80104292:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104295:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&ptable.lock);
8010429a:	68 a0 4e 11 80       	push   $0x80114ea0
8010429f:	e8 bc 0a 00 00       	call   80104d60 <release>
      return -1;
801042a4:	83 c4 10             	add    $0x10,%esp
801042a7:	eb 88                	jmp    80104231 <wait+0x131>
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042b0 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	53                   	push   %ebx
801042b4:	83 ec 10             	sub    $0x10,%esp
801042b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801042ba:	68 a0 4e 11 80       	push   $0x80114ea0
801042bf:	e8 dc 09 00 00       	call   80104ca0 <acquire>
  wakeup1(chan);
801042c4:	89 d8                	mov    %ebx,%eax
801042c6:	e8 05 f4 ff ff       	call   801036d0 <wakeup1>
  release(&ptable.lock);
801042cb:	83 c4 10             	add    $0x10,%esp
801042ce:	c7 45 08 a0 4e 11 80 	movl   $0x80114ea0,0x8(%ebp)
}
801042d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042d8:	c9                   	leave  
  release(&ptable.lock);
801042d9:	e9 82 0a 00 00       	jmp    80104d60 <release>
801042de:	66 90                	xchg   %ax,%ax

801042e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	53                   	push   %ebx
801042e6:	83 ec 0c             	sub    $0xc,%esp
801042e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801042ec:	e8 df 08 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
801042f1:	e8 ca f5 ff ff       	call   801038c0 <mycpu>
  t = c->thread;
801042f6:	8b b8 b0 00 00 00    	mov    0xb0(%eax),%edi
  popcli();
801042fc:	e8 0f 09 00 00       	call   80104c10 <popcli>
  pushcli();
80104301:	e8 ca 08 00 00       	call   80104bd0 <pushcli>
  c = mycpu();
80104306:	e8 b5 f5 ff ff       	call   801038c0 <mycpu>
  p = c->proc;
8010430b:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104311:	e8 fa 08 00 00       	call   80104c10 <popcli>
  cprintf("entered kill: process=%p, thread=%p\n", myproc(), mythread());
80104316:	83 ec 04             	sub    $0x4,%esp
80104319:	57                   	push   %edi
8010431a:	56                   	push   %esi
8010431b:	68 60 81 10 80       	push   $0x80108160
80104320:	e8 3b c3 ff ff       	call   80100660 <cprintf>
  struct proc *p;

  acquire(&ptable.lock);
80104325:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
8010432c:	e8 6f 09 00 00       	call   80104ca0 <acquire>
80104331:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104334:	b8 d4 4e 11 80       	mov    $0x80114ed4,%eax
80104339:	eb 0f                	jmp    8010434a <kill+0x6a>
8010433b:	90                   	nop
8010433c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104340:	83 c0 70             	add    $0x70,%eax
80104343:	3d d4 6a 11 80       	cmp    $0x80116ad4,%eax
80104348:	73 26                	jae    80104370 <kill+0x90>
    if(p->pid == pid){
8010434a:	39 58 0c             	cmp    %ebx,0xc(%eax)
8010434d:	75 f1                	jne    80104340 <kill+0x60>
      p->killed = 1;
      // Wake process from sleep if necessary.
      /*if(p->state == SLEEPING)
        p->state = RUNNABLE;*/
      release(&ptable.lock);
8010434f:	83 ec 0c             	sub    $0xc,%esp
      p->killed = 1;
80104352:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
      release(&ptable.lock);
80104359:	68 a0 4e 11 80       	push   $0x80114ea0
8010435e:	e8 fd 09 00 00       	call   80104d60 <release>
      return 0;
80104363:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ptable.lock);
  return -1;
}
80104366:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80104369:	31 c0                	xor    %eax,%eax
}
8010436b:	5b                   	pop    %ebx
8010436c:	5e                   	pop    %esi
8010436d:	5f                   	pop    %edi
8010436e:	5d                   	pop    %ebp
8010436f:	c3                   	ret    
  release(&ptable.lock);
80104370:	83 ec 0c             	sub    $0xc,%esp
80104373:	68 a0 4e 11 80       	push   $0x80114ea0
80104378:	e8 e3 09 00 00       	call   80104d60 <release>
  return -1;
8010437d:	83 c4 10             	add    $0x10,%esp
}
80104380:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104383:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104388:	5b                   	pop    %ebx
80104389:	5e                   	pop    %esi
8010438a:	5f                   	pop    %edi
8010438b:	5d                   	pop    %ebp
8010438c:	c3                   	ret    
8010438d:	8d 76 00             	lea    0x0(%esi),%esi

80104390 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	57                   	push   %edi
80104394:	56                   	push   %esi
80104395:	53                   	push   %ebx
  struct proc *p;
  struct kthread *t;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104396:	bf d4 4e 11 80       	mov    $0x80114ed4,%edi
{
8010439b:	83 ec 3c             	sub    $0x3c,%esp
8010439e:	66 90                	xchg   %ax,%ax
    if(p->state == UNUSED)
801043a0:	8b 57 08             	mov    0x8(%edi),%edx
801043a3:	85 d2                	test   %edx,%edx
801043a5:	0f 84 84 00 00 00    	je     8010442f <procdump+0x9f>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043ab:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
801043ae:	b9 dc 80 10 80       	mov    $0x801080dc,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043b3:	77 11                	ja     801043c6 <procdump+0x36>
801043b5:	8b 0c 95 88 81 10 80 	mov    -0x7fef7e78(,%edx,4),%ecx
      state = "???";
801043bc:	ba dc 80 10 80       	mov    $0x801080dc,%edx
801043c1:	85 c9                	test   %ecx,%ecx
801043c3:	0f 44 ca             	cmove  %edx,%ecx
    cprintf("process: %d %s %s , ", p->pid, state, p->name);
801043c6:	8d 57 5c             	lea    0x5c(%edi),%edx
801043c9:	52                   	push   %edx
801043ca:	51                   	push   %ecx
801043cb:	ff 77 0c             	pushl  0xc(%edi)
801043ce:	68 e0 80 10 80       	push   $0x801080e0
801043d3:	e8 88 c2 ff ff       	call   80100660 <cprintf>
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801043d8:	8b 57 6c             	mov    0x6c(%edi),%edx
801043db:	83 c4 10             	add    $0x10,%esp
801043de:	89 d3                	mov    %edx,%ebx
      if(t->state == UNINIT)
801043e0:	8b 43 08             	mov    0x8(%ebx),%eax
801043e3:	85 c0                	test   %eax,%eax
801043e5:	74 3b                	je     80104422 <procdump+0x92>
        continue;
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043e7:	8b 4f 08             	mov    0x8(%edi),%ecx
        state = states[p->state];
      else
        state = "???";
801043ea:	ba dc 80 10 80       	mov    $0x801080dc,%edx
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043ef:	83 f9 05             	cmp    $0x5,%ecx
801043f2:	77 11                	ja     80104405 <procdump+0x75>
801043f4:	8b 14 8d 88 81 10 80 	mov    -0x7fef7e78(,%ecx,4),%edx
        state = "???";
801043fb:	b9 dc 80 10 80       	mov    $0x801080dc,%ecx
80104400:	85 d2                	test   %edx,%edx
80104402:	0f 44 d1             	cmove  %ecx,%edx
      cprintf("thread: %d %s , ", t->tid, state);
80104405:	83 ec 04             	sub    $0x4,%esp
80104408:	52                   	push   %edx
80104409:	ff 73 0c             	pushl  0xc(%ebx)
8010440c:	68 f5 80 10 80       	push   $0x801080f5
80104411:	e8 4a c2 ff ff       	call   80100660 <cprintf>
      if(t->state == SLEEPING){
80104416:	83 c4 10             	add    $0x10,%esp
80104419:	83 7b 08 01          	cmpl   $0x1,0x8(%ebx)
8010441d:	74 41                	je     80104460 <procdump+0xd0>
8010441f:	8b 57 6c             	mov    0x6c(%edi),%edx
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104422:	8d 8a 40 02 00 00    	lea    0x240(%edx),%ecx
80104428:	83 c3 24             	add    $0x24,%ebx
8010442b:	39 cb                	cmp    %ecx,%ebx
8010442d:	72 b1                	jb     801043e0 <procdump+0x50>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010442f:	83 c7 70             	add    $0x70,%edi
80104432:	81 ff d4 6a 11 80    	cmp    $0x80116ad4,%edi
80104438:	0f 82 62 ff ff ff    	jb     801043a0 <procdump+0x10>
          cprintf(" %p ", pc[i]);
        }
      }
    }
  }
  cprintf("\n");
8010443e:	83 ec 0c             	sub    $0xc,%esp
80104441:	68 f7 84 10 80       	push   $0x801084f7
80104446:	e8 15 c2 ff ff       	call   80100660 <cprintf>
}
8010444b:	83 c4 10             	add    $0x10,%esp
8010444e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104451:	5b                   	pop    %ebx
80104452:	5e                   	pop    %esi
80104453:	5f                   	pop    %edi
80104454:	5d                   	pop    %ebp
80104455:	c3                   	ret    
80104456:	8d 76 00             	lea    0x0(%esi),%esi
80104459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        getcallerpcs((uint*)t->context->ebp+2, pc);
80104460:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104463:	83 ec 08             	sub    $0x8,%esp
80104466:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104469:	50                   	push   %eax
8010446a:	8b 53 18             	mov    0x18(%ebx),%edx
8010446d:	8b 52 0c             	mov    0xc(%edx),%edx
80104470:	83 c2 08             	add    $0x8,%edx
80104473:	52                   	push   %edx
80104474:	e8 07 07 00 00       	call   80104b80 <getcallerpcs>
80104479:	83 c4 10             	add    $0x10,%esp
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(i=0; i<10 && pc[i] != 0; i++){
80104480:	8b 0e                	mov    (%esi),%ecx
80104482:	85 c9                	test   %ecx,%ecx
80104484:	74 99                	je     8010441f <procdump+0x8f>
          cprintf(" %p ", pc[i]);
80104486:	83 ec 08             	sub    $0x8,%esp
80104489:	83 c6 04             	add    $0x4,%esi
8010448c:	51                   	push   %ecx
8010448d:	68 06 81 10 80       	push   $0x80108106
80104492:	e8 c9 c1 ff ff       	call   80100660 <cprintf>
        for(i=0; i<10 && pc[i] != 0; i++){
80104497:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010449a:	83 c4 10             	add    $0x10,%esp
8010449d:	39 f0                	cmp    %esi,%eax
8010449f:	75 df                	jne    80104480 <procdump+0xf0>
801044a1:	e9 79 ff ff ff       	jmp    8010441f <procdump+0x8f>
801044a6:	66 90                	xchg   %ax,%ax
801044a8:	66 90                	xchg   %ax,%ax
801044aa:	66 90                	xchg   %ax,%ax
801044ac:	66 90                	xchg   %ax,%ax
801044ae:	66 90                	xchg   %ax,%ax

801044b0 <kthread_create>:
extern int nexttid;
extern void trapret(void);
extern void forkret(void);
static void wakeupThreads(void *chan);

int kthread_create(void (*start_func)(), void* stack){
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	57                   	push   %edi
801044b4:	56                   	push   %esi
801044b5:	53                   	push   %ebx
801044b6:	83 ec 0c             	sub    $0xc,%esp
    struct proc *p = myproc();
801044b9:	e8 a2 f4 ff ff       	call   80103960 <myproc>
    struct kthread *t = 0;
    char *sp;

    acquire(&ptable.lock);
801044be:	83 ec 0c             	sub    $0xc,%esp
    struct proc *p = myproc();
801044c1:	89 c6                	mov    %eax,%esi
    acquire(&ptable.lock);
801044c3:	68 a0 4e 11 80       	push   $0x80114ea0
801044c8:	e8 d3 07 00 00       	call   80104ca0 <acquire>
    struct kthread *tempT;
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
801044cd:	8b 5e 6c             	mov    0x6c(%esi),%ebx
        if(tempT->state == UNINIT){
801044d0:	83 c4 10             	add    $0x10,%esp
801044d3:	8b 53 08             	mov    0x8(%ebx),%edx
801044d6:	85 d2                	test   %edx,%edx
801044d8:	74 18                	je     801044f2 <kthread_create+0x42>
801044da:	8d 93 40 02 00 00    	lea    0x240(%ebx),%edx
    for(tempT = p->threads; tempT < &p->threads[NTHREAD]; tempT++){
801044e0:	83 c3 24             	add    $0x24,%ebx
801044e3:	39 d3                	cmp    %edx,%ebx
801044e5:	0f 84 b5 00 00 00    	je     801045a0 <kthread_create+0xf0>
        if(tempT->state == UNINIT){
801044eb:	8b 43 08             	mov    0x8(%ebx),%eax
801044ee:	85 c0                	test   %eax,%eax
801044f0:	75 ee                	jne    801044e0 <kthread_create+0x30>
        release(&ptable.lock);
        return -1;
    }

    t->tproc = p;
    t->tid = nexttid++;
801044f2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

    release(&ptable.lock);  
801044f7:	83 ec 0c             	sub    $0xc,%esp
    t->tproc = p;
801044fa:	89 73 10             	mov    %esi,0x10(%ebx)
    t->tid = nexttid++;
801044fd:	8d 50 01             	lea    0x1(%eax),%edx
80104500:	89 43 0c             	mov    %eax,0xc(%ebx)
    release(&ptable.lock);  
80104503:	68 a0 4e 11 80       	push   $0x80114ea0
    t->tid = nexttid++;
80104508:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
    release(&ptable.lock);  
8010450e:	e8 4d 08 00 00       	call   80104d60 <release>

    // Allocate kernel stack for the thread.
    if((t->kstack = kalloc()) == 0){
80104513:	e8 78 e0 ff ff       	call   80102590 <kalloc>
80104518:	89 c2                	mov    %eax,%edx
8010451a:	89 03                	mov    %eax,(%ebx)
8010451c:	83 c4 10             	add    $0x10,%esp
        return 0;
8010451f:	31 c0                	xor    %eax,%eax
    if((t->kstack = kalloc()) == 0){
80104521:	85 d2                	test   %edx,%edx
80104523:	74 6e                	je     80104593 <kthread_create+0xe3>
    }
    sp = t->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *t->tf;
80104525:	8d 82 b4 0f 00 00    	lea    0xfb4(%edx),%eax
    sp -= 4;
    *(uint*)sp = (uint)trapret;

    sp -= sizeof *t->context;
    t->context = (struct context*)sp;
    memset(t->context, 0, sizeof *t->context);
8010452b:	83 ec 04             	sub    $0x4,%esp
    sp -= sizeof *t->context;
8010452e:	81 c2 9c 0f 00 00    	add    $0xf9c,%edx
    sp -= sizeof *t->tf;
80104534:	89 43 14             	mov    %eax,0x14(%ebx)
    *(uint*)sp = (uint)trapret;
80104537:	c7 42 14 2f 61 10 80 	movl   $0x8010612f,0x14(%edx)
    t->context = (struct context*)sp;
8010453e:	89 53 18             	mov    %edx,0x18(%ebx)
    memset(t->context, 0, sizeof *t->context);
80104541:	6a 14                	push   $0x14
80104543:	6a 00                	push   $0x0
80104545:	52                   	push   %edx
80104546:	e8 65 08 00 00       	call   80104db0 <memset>
    t->context->eip = (uint)forkret;
8010454b:	8b 43 18             	mov    0x18(%ebx),%eax
8010454e:	c7 40 10 40 38 10 80 	movl   $0x80103840,0x10(%eax)

    t->exitRequest = 0;
    t->state = RUNNABLE;
    t->ustack = stack;
80104555:	8b 45 0c             	mov    0xc(%ebp),%eax
    t->exitRequest = 0;
80104558:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    t->state = RUNNABLE;
8010455f:	c7 43 08 02 00 00 00 	movl   $0x2,0x8(%ebx)
    t->ustack = stack;
80104566:	89 43 04             	mov    %eax,0x4(%ebx)
    *t->tf = *mythread()->tf;
80104569:	e8 22 f4 ff ff       	call   80103990 <mythread>
8010456e:	8b 7b 14             	mov    0x14(%ebx),%edi
80104571:	8b 70 14             	mov    0x14(%eax),%esi
80104574:	b9 13 00 00 00       	mov    $0x13,%ecx
80104579:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->eip = (uint)start_func;
8010457b:	8b 55 08             	mov    0x8(%ebp),%edx
    t->tf->esp = (uint)(stack);
8010457e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    return t->tid;
80104581:	83 c4 10             	add    $0x10,%esp
    t->tf->eip = (uint)start_func;
80104584:	8b 43 14             	mov    0x14(%ebx),%eax
80104587:	89 50 38             	mov    %edx,0x38(%eax)
    t->tf->esp = (uint)(stack);
8010458a:	8b 43 14             	mov    0x14(%ebx),%eax
8010458d:	89 48 44             	mov    %ecx,0x44(%eax)
    return t->tid;
80104590:	8b 43 0c             	mov    0xc(%ebx),%eax
}
80104593:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104596:	5b                   	pop    %ebx
80104597:	5e                   	pop    %esi
80104598:	5f                   	pop    %edi
80104599:	5d                   	pop    %ebp
8010459a:	c3                   	ret    
8010459b:	90                   	nop
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&ptable.lock);
801045a0:	83 ec 0c             	sub    $0xc,%esp
801045a3:	68 a0 4e 11 80       	push   $0x80114ea0
801045a8:	e8 b3 07 00 00       	call   80104d60 <release>
        return -1;
801045ad:	83 c4 10             	add    $0x10,%esp
}
801045b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
801045b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045b8:	5b                   	pop    %ebx
801045b9:	5e                   	pop    %esi
801045ba:	5f                   	pop    %edi
801045bb:	5d                   	pop    %ebp
801045bc:	c3                   	ret    
801045bd:	8d 76 00             	lea    0x0(%esi),%esi

801045c0 <kthread_id>:

int kthread_id(){
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 08             	sub    $0x8,%esp
    //procdump();
    return mythread()->tid;
801045c6:	e8 c5 f3 ff ff       	call   80103990 <mythread>
801045cb:	8b 40 0c             	mov    0xc(%eax),%eax
}
801045ce:	c9                   	leave  
801045cf:	c3                   	ret    

801045d0 <kthread_exit>:

void kthread_exit(){
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	57                   	push   %edi
801045d4:	56                   	push   %esi
801045d5:	53                   	push   %ebx
    // check if it is the last running thread. if it is, the process execute exit();
    threadProc = curthread->tproc;
    int lastRunning = 1;
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
            lastRunning = 0;
801045d6:	31 f6                	xor    %esi,%esi
    int lastRunning = 1;
801045d8:	bb 01 00 00 00       	mov    $0x1,%ebx
void kthread_exit(){
801045dd:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
801045e0:	e8 ab f3 ff ff       	call   80103990 <mythread>
    acquire(&ptable.lock);
801045e5:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
801045e8:	89 c7                	mov    %eax,%edi
    acquire(&ptable.lock);
801045ea:	68 a0 4e 11 80       	push   $0x80114ea0
801045ef:	e8 ac 06 00 00       	call   80104ca0 <acquire>
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
801045f4:	8b 47 10             	mov    0x10(%edi),%eax
801045f7:	83 c4 10             	add    $0x10,%esp
801045fa:	8b 40 6c             	mov    0x6c(%eax),%eax
801045fd:	8d 88 40 02 00 00    	lea    0x240(%eax),%ecx
80104603:	90                   	nop
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(t != curthread && t->state != TERMINATED && t->state != UNINIT){
80104608:	39 c7                	cmp    %eax,%edi
8010460a:	74 0d                	je     80104619 <kthread_exit+0x49>
8010460c:	8b 50 08             	mov    0x8(%eax),%edx
8010460f:	85 d2                	test   %edx,%edx
80104611:	74 06                	je     80104619 <kthread_exit+0x49>
            lastRunning = 0;
80104613:	83 fa 05             	cmp    $0x5,%edx
80104616:	0f 45 de             	cmovne %esi,%ebx
    for(t = threadProc->threads; t < &threadProc->threads[NTHREAD]; t++){
80104619:	83 c0 24             	add    $0x24,%eax
8010461c:	39 c8                	cmp    %ecx,%eax
8010461e:	75 e8                	jne    80104608 <kthread_exit+0x38>
        }
    }
    if(lastRunning){
80104620:	85 db                	test   %ebx,%ebx
80104622:	75 70                	jne    80104694 <kthread_exit+0xc4>
            lastRunning = 0;
80104624:	bb d4 4e 11 80       	mov    $0x80114ed4,%ebx
80104629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct proc *p;
  struct kthread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED){
80104630:	8b 43 08             	mov    0x8(%ebx),%eax
80104633:	85 c0                	test   %eax,%eax
80104635:	74 39                	je     80104670 <kthread_exit+0xa0>
      continue;
    }
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104637:	8b 73 6c             	mov    0x6c(%ebx),%esi
8010463a:	89 f2                	mov    %esi,%edx
8010463c:	eb 0f                	jmp    8010464d <kthread_exit+0x7d>
8010463e:	66 90                	xchg   %ax,%ax
80104640:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
80104646:	83 c2 24             	add    $0x24,%edx
80104649:	39 ca                	cmp    %ecx,%edx
8010464b:	73 23                	jae    80104670 <kthread_exit+0xa0>
      if(t->state == SLEEPING && t->chan == chan){
8010464d:	83 7a 08 01          	cmpl   $0x1,0x8(%edx)
80104651:	75 ed                	jne    80104640 <kthread_exit+0x70>
80104653:	3b 7a 1c             	cmp    0x1c(%edx),%edi
80104656:	75 e8                	jne    80104640 <kthread_exit+0x70>
        t->state = RUNNABLE;
80104658:	c7 42 08 02 00 00 00 	movl   $0x2,0x8(%edx)
8010465f:	8b 73 6c             	mov    0x6c(%ebx),%esi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104662:	83 c2 24             	add    $0x24,%edx
80104665:	8d 8e 40 02 00 00    	lea    0x240(%esi),%ecx
8010466b:	39 ca                	cmp    %ecx,%edx
8010466d:	72 de                	jb     8010464d <kthread_exit+0x7d>
8010466f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104670:	83 c3 70             	add    $0x70,%ebx
80104673:	81 fb d4 6a 11 80    	cmp    $0x80116ad4,%ebx
80104679:	72 b5                	jb     80104630 <kthread_exit+0x60>
    curthread->state = TERMINATED;
8010467b:	c7 47 08 05 00 00 00 	movl   $0x5,0x8(%edi)
    sched();
80104682:	e8 19 f7 ff ff       	call   80103da0 <sched>
    panic("terminated exit");
80104687:	83 ec 0c             	sub    $0xc,%esp
8010468a:	68 a0 81 10 80       	push   $0x801081a0
8010468f:	e8 fc bc ff ff       	call   80100390 <panic>
        release(&ptable.lock);
80104694:	83 ec 0c             	sub    $0xc,%esp
80104697:	68 a0 4e 11 80       	push   $0x80114ea0
8010469c:	e8 bf 06 00 00       	call   80104d60 <release>
        exit();
801046a1:	e8 ba f7 ff ff       	call   80103e60 <exit>
801046a6:	83 c4 10             	add    $0x10,%esp
801046a9:	e9 76 ff ff ff       	jmp    80104624 <kthread_exit+0x54>
801046ae:	66 90                	xchg   %ax,%ax

801046b0 <kthread_join>:
int kthread_join(int thread_id){
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 75 08             	mov    0x8(%ebp),%esi
    struct proc *curproc = myproc();
801046b8:	e8 a3 f2 ff ff       	call   80103960 <myproc>
801046bd:	89 c3                	mov    %eax,%ebx
    struct kthread *curthread = mythread();
801046bf:	e8 cc f2 ff ff       	call   80103990 <mythread>
    if(curthread->tid == thread_id){
801046c4:	39 70 0c             	cmp    %esi,0xc(%eax)
801046c7:	0f 84 b3 00 00 00    	je     80104780 <kthread_join+0xd0>
    acquire(&ptable.lock);
801046cd:	83 ec 0c             	sub    $0xc,%esp
801046d0:	68 a0 4e 11 80       	push   $0x80114ea0
801046d5:	e8 c6 05 00 00       	call   80104ca0 <acquire>
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
801046da:	8b 5b 6c             	mov    0x6c(%ebx),%ebx
        if (t->tid == thread_id){
801046dd:	83 c4 10             	add    $0x10,%esp
801046e0:	3b 73 0c             	cmp    0xc(%ebx),%esi
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
801046e3:	8d 83 40 02 00 00    	lea    0x240(%ebx),%eax
        if (t->tid == thread_id){
801046e9:	74 11                	je     801046fc <kthread_join+0x4c>
801046eb:	90                   	nop
801046ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(t = curproc->threads; t < &curproc->threads[NTHREAD]; t++){
801046f0:	83 c3 24             	add    $0x24,%ebx
801046f3:	39 c3                	cmp    %eax,%ebx
801046f5:	74 69                	je     80104760 <kthread_join+0xb0>
        if (t->tid == thread_id){
801046f7:	39 73 0c             	cmp    %esi,0xc(%ebx)
801046fa:	75 f4                	jne    801046f0 <kthread_join+0x40>
    if (t->state == UNINIT){ // thread was not initialized - no need to wait
801046fc:	8b 43 08             	mov    0x8(%ebx),%eax
801046ff:	85 c0                	test   %eax,%eax
80104701:	74 66                	je     80104769 <kthread_join+0xb9>
    while (t->state != TERMINATED){ // thread is not finished yet
80104703:	83 f8 05             	cmp    $0x5,%eax
80104706:	74 1f                	je     80104727 <kthread_join+0x77>
80104708:	90                   	nop
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        sleep(t, &ptable.lock);
80104710:	83 ec 08             	sub    $0x8,%esp
80104713:	68 a0 4e 11 80       	push   $0x80114ea0
80104718:	53                   	push   %ebx
80104719:	e8 22 f9 ff ff       	call   80104040 <sleep>
    while (t->state != TERMINATED){ // thread is not finished yet
8010471e:	83 c4 10             	add    $0x10,%esp
80104721:	83 7b 08 05          	cmpl   $0x5,0x8(%ebx)
80104725:	75 e9                	jne    80104710 <kthread_join+0x60>
    kfree(t->kstack);
80104727:	83 ec 0c             	sub    $0xc,%esp
8010472a:	ff 33                	pushl  (%ebx)
8010472c:	e8 af dc ff ff       	call   801023e0 <kfree>
    t->kstack = 0;
80104731:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    t->state = UNINIT;
80104737:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    release(&ptable.lock);
8010473e:	c7 04 24 a0 4e 11 80 	movl   $0x80114ea0,(%esp)
80104745:	e8 16 06 00 00       	call   80104d60 <release>
    return 0;
8010474a:	83 c4 10             	add    $0x10,%esp
8010474d:	31 c0                	xor    %eax,%eax
}
8010474f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104752:	5b                   	pop    %ebx
80104753:	5e                   	pop    %esi
80104754:	5d                   	pop    %ebp
80104755:	c3                   	ret    
80104756:	8d 76 00             	lea    0x0(%esi),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (t == 0 || t->tid != thread_id){ // thread not found
80104760:	85 db                	test   %ebx,%ebx
80104762:	74 05                	je     80104769 <kthread_join+0xb9>
80104764:	39 73 0c             	cmp    %esi,0xc(%ebx)
80104767:	74 93                	je     801046fc <kthread_join+0x4c>
        release(&ptable.lock);
80104769:	83 ec 0c             	sub    $0xc,%esp
8010476c:	68 a0 4e 11 80       	push   $0x80114ea0
80104771:	e8 ea 05 00 00       	call   80104d60 <release>
        return -1;
80104776:	83 c4 10             	add    $0x10,%esp
80104779:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010477e:	eb cf                	jmp    8010474f <kthread_join+0x9f>
        return -1;
80104780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104785:	eb c8                	jmp    8010474f <kthread_join+0x9f>
80104787:	66 90                	xchg   %ax,%ax
80104789:	66 90                	xchg   %ax,%ax
8010478b:	66 90                	xchg   %ax,%ax
8010478d:	66 90                	xchg   %ax,%ax
8010478f:	90                   	nop

80104790 <kthread_mutex_alloc>:
  struct spinlock lock;
  struct kthread_mutex_t mutexes[MAX_MUTEXES];
};
extern struct mutexTable mutexTable;

int kthread_mutex_alloc(){
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
    struct kthread_mutex_t *mutex;
    int i = 0;
80104794:	31 db                	xor    %ebx,%ebx
int kthread_mutex_alloc(){
80104796:	83 ec 10             	sub    $0x10,%esp
    acquire(&mutexTable.lock);
80104799:	68 60 3d 11 80       	push   $0x80113d60
8010479e:	e8 fd 04 00 00       	call   80104ca0 <acquire>
801047a3:	83 c4 10             	add    $0x10,%esp
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
801047a6:	ba 94 3d 11 80       	mov    $0x80113d94,%edx
801047ab:	eb 11                	jmp    801047be <kthread_mutex_alloc+0x2e>
801047ad:	8d 76 00             	lea    0x0(%esi),%esi
801047b0:	83 c2 44             	add    $0x44,%edx
            mutex->locked = 0;
            mutex->tid = 0;
            mutex->used = 1;
            break;
        }
        i++;
801047b3:	83 c3 01             	add    $0x1,%ebx
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
801047b6:	81 fa 94 4e 11 80    	cmp    $0x80114e94,%edx
801047bc:	73 1f                	jae    801047dd <kthread_mutex_alloc+0x4d>
        if(!mutex->used){
801047be:	8b 42 40             	mov    0x40(%edx),%eax
801047c1:	85 c0                	test   %eax,%eax
801047c3:	75 eb                	jne    801047b0 <kthread_mutex_alloc+0x20>
            mutex->id = i;
801047c5:	89 5a 34             	mov    %ebx,0x34(%edx)
            mutex->locked = 0;
801047c8:	c7 42 38 00 00 00 00 	movl   $0x0,0x38(%edx)
            mutex->tid = 0;
801047cf:	c7 42 3c 00 00 00 00 	movl   $0x0,0x3c(%edx)
            mutex->used = 1;
801047d6:	c7 42 40 01 00 00 00 	movl   $0x1,0x40(%edx)
    }
    release(&mutexTable.lock);
801047dd:	83 ec 0c             	sub    $0xc,%esp
801047e0:	68 60 3d 11 80       	push   $0x80113d60
801047e5:	e8 76 05 00 00       	call   80104d60 <release>
    if(i >= MAX_MUTEXES)
801047ea:	83 c4 10             	add    $0x10,%esp
801047ed:	83 fb 40             	cmp    $0x40,%ebx
801047f0:	74 07                	je     801047f9 <kthread_mutex_alloc+0x69>
        return -1;
    else
        return i;
}
801047f2:	89 d8                	mov    %ebx,%eax
801047f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047f7:	c9                   	leave  
801047f8:	c3                   	ret    
        return -1;
801047f9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801047fe:	eb f2                	jmp    801047f2 <kthread_mutex_alloc+0x62>

80104800 <kthread_mutex_dealloc>:

int kthread_mutex_dealloc(int mutex_id){
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	53                   	push   %ebx
80104804:	83 ec 10             	sub    $0x10,%esp
80104807:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct kthread_mutex_t *mutex;
    acquire(&mutexTable.lock);
8010480a:	68 60 3d 11 80       	push   $0x80113d60
8010480f:	e8 8c 04 00 00       	call   80104ca0 <acquire>
80104814:	83 c4 10             	add    $0x10,%esp
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104817:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
8010481c:	eb 0c                	jmp    8010482a <kthread_mutex_dealloc+0x2a>
8010481e:	66 90                	xchg   %ax,%ax
80104820:	83 c0 44             	add    $0x44,%eax
80104823:	3d 94 4e 11 80       	cmp    $0x80114e94,%eax
80104828:	73 46                	jae    80104870 <kthread_mutex_dealloc+0x70>
        if(mutex->id == mutex_id){
8010482a:	39 58 34             	cmp    %ebx,0x34(%eax)
8010482d:	75 f1                	jne    80104820 <kthread_mutex_dealloc+0x20>
            if(mutex->locked == 1){
8010482f:	83 78 38 01          	cmpl   $0x1,0x38(%eax)
80104833:	74 3b                	je     80104870 <kthread_mutex_dealloc+0x70>
                release(&mutexTable.lock);
                return -1;
            }else{
                if(!mutex->used){ // already deallocated
80104835:	8b 50 40             	mov    0x40(%eax),%edx
80104838:	85 d2                	test   %edx,%edx
8010483a:	74 34                	je     80104870 <kthread_mutex_dealloc+0x70>
                }
                mutex->id = 0;
                mutex->locked = 0;
                mutex->tid = 0;
                mutex->used = 0;
                release(&mutexTable.lock);
8010483c:	83 ec 0c             	sub    $0xc,%esp
                mutex->id = 0;
8010483f:	c7 40 34 00 00 00 00 	movl   $0x0,0x34(%eax)
                mutex->locked = 0;
80104846:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
                mutex->tid = 0;
8010484d:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
                mutex->used = 0;
80104854:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%eax)
                release(&mutexTable.lock);
8010485b:	68 60 3d 11 80       	push   $0x80113d60
80104860:	e8 fb 04 00 00       	call   80104d60 <release>
                return 0;
80104865:	83 c4 10             	add    $0x10,%esp
80104868:	31 c0                	xor    %eax,%eax
        release(&mutexTable.lock);
        return -1;
    }
    release(&mutexTable.lock);
    return -1; // mutex_id does not exist
}
8010486a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010486d:	c9                   	leave  
8010486e:	c3                   	ret    
8010486f:	90                   	nop
                release(&mutexTable.lock);
80104870:	83 ec 0c             	sub    $0xc,%esp
80104873:	68 60 3d 11 80       	push   $0x80113d60
80104878:	e8 e3 04 00 00       	call   80104d60 <release>
                return -1;
8010487d:	83 c4 10             	add    $0x10,%esp
80104880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104885:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104888:	c9                   	leave  
80104889:	c3                   	ret    
8010488a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104890 <kthread_mutex_lock>:

int waitingCount = 0;

int kthread_mutex_lock(int mutex_id){
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	57                   	push   %edi
80104894:	56                   	push   %esi
80104895:	53                   	push   %ebx
    //cprintf("thread %d trying to lock mutex %d\n", mythread()->tid, mutex_id);
    struct kthread_mutex_t *mutex;
    // find the mutex with this mutex_id
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104896:	bb 94 3d 11 80       	mov    $0x80113d94,%ebx
int kthread_mutex_lock(int mutex_id){
8010489b:	83 ec 18             	sub    $0x18,%esp
8010489e:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&mutexTable.lock);
801048a1:	68 60 3d 11 80       	push   $0x80113d60
801048a6:	e8 f5 03 00 00       	call   80104ca0 <acquire>
801048ab:	83 c4 10             	add    $0x10,%esp
801048ae:	eb 0b                	jmp    801048bb <kthread_mutex_lock+0x2b>
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
801048b0:	83 c3 44             	add    $0x44,%ebx
801048b3:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
801048b9:	73 05                	jae    801048c0 <kthread_mutex_lock+0x30>
        if(mutex->id == mutex_id)
801048bb:	39 73 34             	cmp    %esi,0x34(%ebx)
801048be:	75 f0                	jne    801048b0 <kthread_mutex_lock+0x20>
            break;
    }
    release(&mutexTable.lock);
801048c0:	83 ec 0c             	sub    $0xc,%esp
801048c3:	68 60 3d 11 80       	push   $0x80113d60
801048c8:	e8 93 04 00 00       	call   80104d60 <release>
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id was not found
801048cd:	83 c4 10             	add    $0x10,%esp
801048d0:	39 73 34             	cmp    %esi,0x34(%ebx)
801048d3:	0f 85 92 00 00 00    	jne    8010496b <kthread_mutex_lock+0xdb>
        return -1;
    }
    if(mutex->used == 0){ // mutex is not allocated
801048d9:	8b 4b 40             	mov    0x40(%ebx),%ecx
801048dc:	85 c9                	test   %ecx,%ecx
801048de:	0f 84 87 00 00 00    	je     8010496b <kthread_mutex_lock+0xdb>
        return -1;
    }
    struct kthread *curthread = mythread();
801048e4:	e8 a7 f0 ff ff       	call   80103990 <mythread>
    acquire(&mutex->lock);
801048e9:	83 ec 0c             	sub    $0xc,%esp
    struct kthread *curthread = mythread();
801048ec:	89 c7                	mov    %eax,%edi
    acquire(&mutex->lock);
801048ee:	53                   	push   %ebx
801048ef:	e8 ac 03 00 00       	call   80104ca0 <acquire>
    /*if (mutex->tid != curthread->tid){
        waitingCount+=1;
    }*/
    while (mutex->locked) { // wait for the lock to be unlocked
801048f4:	8b 53 38             	mov    0x38(%ebx),%edx
801048f7:	83 c4 10             	add    $0x10,%esp
801048fa:	85 d2                	test   %edx,%edx
801048fc:	74 1e                	je     8010491c <kthread_mutex_lock+0x8c>
801048fe:	8d 73 3c             	lea    0x3c(%ebx),%esi
80104901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        //cprintf("------thread %d going to sleep on mutex %d\n", mythread()->tid, mutex->id);
        sleep(&mutex->tid, &mutex->lock);
80104908:	83 ec 08             	sub    $0x8,%esp
8010490b:	53                   	push   %ebx
8010490c:	56                   	push   %esi
8010490d:	e8 2e f7 ff ff       	call   80104040 <sleep>
    while (mutex->locked) { // wait for the lock to be unlocked
80104912:	8b 43 38             	mov    0x38(%ebx),%eax
80104915:	83 c4 10             	add    $0x10,%esp
80104918:	85 c0                	test   %eax,%eax
8010491a:	75 ec                	jne    80104908 <kthread_mutex_lock+0x78>
    if(mutex->locked == 0){ // catch the free lock
        /*if (mutex->tid != curthread->tid ){
            waitingCount-=1;
        }*/
        //if (mutex->tid != curthread->tid || (mutex->tid == curthread->tid && waitingCount == 0)){
        if (mutex->tid != curthread->tid){ // lock only if you are not the previouse thread who locked
8010491c:	8b 47 0c             	mov    0xc(%edi),%eax
8010491f:	39 43 3c             	cmp    %eax,0x3c(%ebx)
80104922:	75 1c                	jne    80104940 <kthread_mutex_lock+0xb0>
            cprintf("thread %d locking the mutex %d\n", mythread()->tid, mutex->id);
            mutex->locked = 1;
            mutex->tid = curthread->tid;
        }
    }
    release(&mutex->lock);
80104924:	83 ec 0c             	sub    $0xc,%esp
80104927:	53                   	push   %ebx
80104928:	e8 33 04 00 00       	call   80104d60 <release>
    return 0;
8010492d:	83 c4 10             	add    $0x10,%esp
80104930:	31 c0                	xor    %eax,%eax
}
80104932:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104935:	5b                   	pop    %ebx
80104936:	5e                   	pop    %esi
80104937:	5f                   	pop    %edi
80104938:	5d                   	pop    %ebp
80104939:	c3                   	ret    
8010493a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            cprintf("thread %d locking the mutex %d\n", mythread()->tid, mutex->id);
80104940:	8b 73 34             	mov    0x34(%ebx),%esi
80104943:	e8 48 f0 ff ff       	call   80103990 <mythread>
80104948:	83 ec 04             	sub    $0x4,%esp
8010494b:	56                   	push   %esi
8010494c:	ff 70 0c             	pushl  0xc(%eax)
8010494f:	68 b0 81 10 80       	push   $0x801081b0
80104954:	e8 07 bd ff ff       	call   80100660 <cprintf>
            mutex->locked = 1;
80104959:	c7 43 38 01 00 00 00 	movl   $0x1,0x38(%ebx)
            mutex->tid = curthread->tid;
80104960:	8b 47 0c             	mov    0xc(%edi),%eax
80104963:	83 c4 10             	add    $0x10,%esp
80104966:	89 43 3c             	mov    %eax,0x3c(%ebx)
80104969:	eb b9                	jmp    80104924 <kthread_mutex_lock+0x94>
        return -1;
8010496b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104970:	eb c0                	jmp    80104932 <kthread_mutex_lock+0xa2>
80104972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <kthread_mutex_unlock>:

int kthread_mutex_unlock(int mutex_id){
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	8b 75 08             	mov    0x8(%ebp),%esi
    //cprintf("thread %d trying to unlock mutex %d\n", mythread()->tid, mutex_id);
    struct kthread_mutex_t *mutex;
    // find the mutex with this mutex_id
    acquire(&mutexTable.lock);
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
80104988:	bb 94 3d 11 80       	mov    $0x80113d94,%ebx
    acquire(&mutexTable.lock);
8010498d:	83 ec 0c             	sub    $0xc,%esp
80104990:	68 60 3d 11 80       	push   $0x80113d60
80104995:	e8 06 03 00 00       	call   80104ca0 <acquire>
8010499a:	83 c4 10             	add    $0x10,%esp
8010499d:	eb 0c                	jmp    801049ab <kthread_mutex_unlock+0x2b>
8010499f:	90                   	nop
    for(mutex = mutexTable.mutexes; mutex < &mutexTable.mutexes[MAX_MUTEXES]; mutex++){
801049a0:	83 c3 44             	add    $0x44,%ebx
801049a3:	81 fb 94 4e 11 80    	cmp    $0x80114e94,%ebx
801049a9:	73 05                	jae    801049b0 <kthread_mutex_unlock+0x30>
        if(mutex->id == mutex_id)
801049ab:	39 73 34             	cmp    %esi,0x34(%ebx)
801049ae:	75 f0                	jne    801049a0 <kthread_mutex_unlock+0x20>
            break;
    }
    release(&mutexTable.lock);
801049b0:	83 ec 0c             	sub    $0xc,%esp
801049b3:	68 60 3d 11 80       	push   $0x80113d60
801049b8:	e8 a3 03 00 00       	call   80104d60 <release>
    if(mutex == 0 || mutex->id != mutex_id){ // mutex_id was not found
801049bd:	83 c4 10             	add    $0x10,%esp
801049c0:	39 73 34             	cmp    %esi,0x34(%ebx)
801049c3:	75 53                	jne    80104a18 <kthread_mutex_unlock+0x98>
        return -1;
    }
    struct kthread *curthread = mythread();
801049c5:	e8 c6 ef ff ff       	call   80103990 <mythread>
    if(curthread->tid != mutex->tid){ // this thread is not holding the lock
801049ca:	8b 53 3c             	mov    0x3c(%ebx),%edx
801049cd:	39 50 0c             	cmp    %edx,0xc(%eax)
801049d0:	75 46                	jne    80104a18 <kthread_mutex_unlock+0x98>
        return -1;
    }
    acquire(&mutex->lock);
801049d2:	83 ec 0c             	sub    $0xc,%esp
801049d5:	53                   	push   %ebx
801049d6:	e8 c5 02 00 00       	call   80104ca0 <acquire>
    if (mutex->locked == 0){ // mutex is not locked
801049db:	8b 43 38             	mov    0x38(%ebx),%eax
801049de:	83 c4 10             	add    $0x10,%esp
801049e1:	85 c0                	test   %eax,%eax
801049e3:	74 27                	je     80104a0c <kthread_mutex_unlock+0x8c>
        return -1;
    }
    //cprintf("thread %d unlocking the mutex %d\n", mythread()->tid, mutex->id);
    mutex->locked = 0; // release the mutex
    //mutex->tid = 0;
    release(&mutex->lock);
801049e5:	83 ec 0c             	sub    $0xc,%esp
    mutex->locked = 0; // release the mutex
801049e8:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%ebx)
    release(&mutex->lock);
801049ef:	53                   	push   %ebx
    wakeup(&mutex->tid);
801049f0:	83 c3 3c             	add    $0x3c,%ebx
    release(&mutex->lock);
801049f3:	e8 68 03 00 00       	call   80104d60 <release>
    wakeup(&mutex->tid);
801049f8:	89 1c 24             	mov    %ebx,(%esp)
801049fb:	e8 b0 f8 ff ff       	call   801042b0 <wakeup>
    //cprintf("wake up threads sleeping on mutex %d\n", mutex->id);
    return 0;
80104a00:	83 c4 10             	add    $0x10,%esp
}
80104a03:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80104a06:	31 c0                	xor    %eax,%eax
}
80104a08:	5b                   	pop    %ebx
80104a09:	5e                   	pop    %esi
80104a0a:	5d                   	pop    %ebp
80104a0b:	c3                   	ret    
        release(&mutex->lock);
80104a0c:	83 ec 0c             	sub    $0xc,%esp
80104a0f:	53                   	push   %ebx
80104a10:	e8 4b 03 00 00       	call   80104d60 <release>
        return -1;
80104a15:	83 c4 10             	add    $0x10,%esp
}
80104a18:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return -1;
80104a1b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a20:	5b                   	pop    %ebx
80104a21:	5e                   	pop    %esi
80104a22:	5d                   	pop    %ebp
80104a23:	c3                   	ret    
80104a24:	66 90                	xchg   %ax,%ax
80104a26:	66 90                	xchg   %ax,%ax
80104a28:	66 90                	xchg   %ax,%ax
80104a2a:	66 90                	xchg   %ax,%ax
80104a2c:	66 90                	xchg   %ax,%ax
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	53                   	push   %ebx
80104a34:	83 ec 0c             	sub    $0xc,%esp
80104a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104a3a:	68 d0 81 10 80       	push   $0x801081d0
80104a3f:	8d 43 04             	lea    0x4(%ebx),%eax
80104a42:	50                   	push   %eax
80104a43:	e8 18 01 00 00       	call   80104b60 <initlock>
  lk->name = name;
80104a48:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104a4b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104a51:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104a54:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104a5b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104a5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a61:	c9                   	leave  
80104a62:	c3                   	ret    
80104a63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a70 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	56                   	push   %esi
80104a74:	53                   	push   %ebx
80104a75:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a78:	83 ec 0c             	sub    $0xc,%esp
80104a7b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a7e:	56                   	push   %esi
80104a7f:	e8 1c 02 00 00       	call   80104ca0 <acquire>
  while (lk->locked) {
80104a84:	8b 13                	mov    (%ebx),%edx
80104a86:	83 c4 10             	add    $0x10,%esp
80104a89:	85 d2                	test   %edx,%edx
80104a8b:	74 16                	je     80104aa3 <acquiresleep+0x33>
80104a8d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104a90:	83 ec 08             	sub    $0x8,%esp
80104a93:	56                   	push   %esi
80104a94:	53                   	push   %ebx
80104a95:	e8 a6 f5 ff ff       	call   80104040 <sleep>
  while (lk->locked) {
80104a9a:	8b 03                	mov    (%ebx),%eax
80104a9c:	83 c4 10             	add    $0x10,%esp
80104a9f:	85 c0                	test   %eax,%eax
80104aa1:	75 ed                	jne    80104a90 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104aa3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104aa9:	e8 b2 ee ff ff       	call   80103960 <myproc>
80104aae:	8b 40 0c             	mov    0xc(%eax),%eax
80104ab1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104ab4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ab7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104aba:	5b                   	pop    %ebx
80104abb:	5e                   	pop    %esi
80104abc:	5d                   	pop    %ebp
  release(&lk->lk);
80104abd:	e9 9e 02 00 00       	jmp    80104d60 <release>
80104ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ad0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	56                   	push   %esi
80104ad4:	53                   	push   %ebx
80104ad5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ad8:	83 ec 0c             	sub    $0xc,%esp
80104adb:	8d 73 04             	lea    0x4(%ebx),%esi
80104ade:	56                   	push   %esi
80104adf:	e8 bc 01 00 00       	call   80104ca0 <acquire>
  lk->locked = 0;
80104ae4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104aea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104af1:	89 1c 24             	mov    %ebx,(%esp)
80104af4:	e8 b7 f7 ff ff       	call   801042b0 <wakeup>
  release(&lk->lk);
80104af9:	89 75 08             	mov    %esi,0x8(%ebp)
80104afc:	83 c4 10             	add    $0x10,%esp
}
80104aff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b02:	5b                   	pop    %ebx
80104b03:	5e                   	pop    %esi
80104b04:	5d                   	pop    %ebp
  release(&lk->lk);
80104b05:	e9 56 02 00 00       	jmp    80104d60 <release>
80104b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b10 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	56                   	push   %esi
80104b15:	53                   	push   %ebx
80104b16:	31 ff                	xor    %edi,%edi
80104b18:	83 ec 18             	sub    $0x18,%esp
80104b1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104b1e:	8d 73 04             	lea    0x4(%ebx),%esi
80104b21:	56                   	push   %esi
80104b22:	e8 79 01 00 00       	call   80104ca0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104b27:	8b 03                	mov    (%ebx),%eax
80104b29:	83 c4 10             	add    $0x10,%esp
80104b2c:	85 c0                	test   %eax,%eax
80104b2e:	74 13                	je     80104b43 <holdingsleep+0x33>
80104b30:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104b33:	e8 28 ee ff ff       	call   80103960 <myproc>
80104b38:	39 58 0c             	cmp    %ebx,0xc(%eax)
80104b3b:	0f 94 c0             	sete   %al
80104b3e:	0f b6 c0             	movzbl %al,%eax
80104b41:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104b43:	83 ec 0c             	sub    $0xc,%esp
80104b46:	56                   	push   %esi
80104b47:	e8 14 02 00 00       	call   80104d60 <release>
  return r;
}
80104b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b4f:	89 f8                	mov    %edi,%eax
80104b51:	5b                   	pop    %ebx
80104b52:	5e                   	pop    %esi
80104b53:	5f                   	pop    %edi
80104b54:	5d                   	pop    %ebp
80104b55:	c3                   	ret    
80104b56:	66 90                	xchg   %ax,%ax
80104b58:	66 90                	xchg   %ax,%ax
80104b5a:	66 90                	xchg   %ax,%ax
80104b5c:	66 90                	xchg   %ax,%ax
80104b5e:	66 90                	xchg   %ax,%ax

80104b60 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104b66:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104b69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104b6f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104b72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b79:	5d                   	pop    %ebp
80104b7a:	c3                   	ret    
80104b7b:	90                   	nop
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b80 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104b80:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b81:	31 d2                	xor    %edx,%edx
{
80104b83:	89 e5                	mov    %esp,%ebp
80104b85:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104b86:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104b89:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b8c:	83 e8 08             	sub    $0x8,%eax
80104b8f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b90:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b96:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b9c:	77 1a                	ja     80104bb8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b9e:	8b 58 04             	mov    0x4(%eax),%ebx
80104ba1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104ba4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104ba7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ba9:	83 fa 0a             	cmp    $0xa,%edx
80104bac:	75 e2                	jne    80104b90 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104bae:	5b                   	pop    %ebx
80104baf:	5d                   	pop    %ebp
80104bb0:	c3                   	ret    
80104bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bb8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104bbb:	83 c1 28             	add    $0x28,%ecx
80104bbe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104bc0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104bc6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104bc9:	39 c1                	cmp    %eax,%ecx
80104bcb:	75 f3                	jne    80104bc0 <getcallerpcs+0x40>
}
80104bcd:	5b                   	pop    %ebx
80104bce:	5d                   	pop    %ebp
80104bcf:	c3                   	ret    

80104bd0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	53                   	push   %ebx
80104bd4:	83 ec 04             	sub    $0x4,%esp
80104bd7:	9c                   	pushf  
80104bd8:	5b                   	pop    %ebx
  asm volatile("cli");
80104bd9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104bda:	e8 e1 ec ff ff       	call   801038c0 <mycpu>
80104bdf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104be5:	85 c0                	test   %eax,%eax
80104be7:	75 11                	jne    80104bfa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104be9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104bef:	e8 cc ec ff ff       	call   801038c0 <mycpu>
80104bf4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104bfa:	e8 c1 ec ff ff       	call   801038c0 <mycpu>
80104bff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104c06:	83 c4 04             	add    $0x4,%esp
80104c09:	5b                   	pop    %ebx
80104c0a:	5d                   	pop    %ebp
80104c0b:	c3                   	ret    
80104c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c10 <popcli>:

void
popcli(void)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104c16:	9c                   	pushf  
80104c17:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104c18:	f6 c4 02             	test   $0x2,%ah
80104c1b:	75 35                	jne    80104c52 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104c1d:	e8 9e ec ff ff       	call   801038c0 <mycpu>
80104c22:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104c29:	78 34                	js     80104c5f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c2b:	e8 90 ec ff ff       	call   801038c0 <mycpu>
80104c30:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104c36:	85 d2                	test   %edx,%edx
80104c38:	74 06                	je     80104c40 <popcli+0x30>
    sti();
}
80104c3a:	c9                   	leave  
80104c3b:	c3                   	ret    
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c40:	e8 7b ec ff ff       	call   801038c0 <mycpu>
80104c45:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c4b:	85 c0                	test   %eax,%eax
80104c4d:	74 eb                	je     80104c3a <popcli+0x2a>
  asm volatile("sti");
80104c4f:	fb                   	sti    
}
80104c50:	c9                   	leave  
80104c51:	c3                   	ret    
    panic("popcli - interruptible");
80104c52:	83 ec 0c             	sub    $0xc,%esp
80104c55:	68 db 81 10 80       	push   $0x801081db
80104c5a:	e8 31 b7 ff ff       	call   80100390 <panic>
    panic("popcli");
80104c5f:	83 ec 0c             	sub    $0xc,%esp
80104c62:	68 f2 81 10 80       	push   $0x801081f2
80104c67:	e8 24 b7 ff ff       	call   80100390 <panic>
80104c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c70 <holding>:
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	56                   	push   %esi
80104c74:	53                   	push   %ebx
80104c75:	8b 75 08             	mov    0x8(%ebp),%esi
80104c78:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c7a:	e8 51 ff ff ff       	call   80104bd0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c7f:	8b 06                	mov    (%esi),%eax
80104c81:	85 c0                	test   %eax,%eax
80104c83:	74 10                	je     80104c95 <holding+0x25>
80104c85:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c88:	e8 33 ec ff ff       	call   801038c0 <mycpu>
80104c8d:	39 c3                	cmp    %eax,%ebx
80104c8f:	0f 94 c3             	sete   %bl
80104c92:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104c95:	e8 76 ff ff ff       	call   80104c10 <popcli>
}
80104c9a:	89 d8                	mov    %ebx,%eax
80104c9c:	5b                   	pop    %ebx
80104c9d:	5e                   	pop    %esi
80104c9e:	5d                   	pop    %ebp
80104c9f:	c3                   	ret    

80104ca0 <acquire>:
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	56                   	push   %esi
80104ca4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104ca5:	e8 26 ff ff ff       	call   80104bd0 <pushcli>
  if(holding(lk))
80104caa:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cad:	83 ec 0c             	sub    $0xc,%esp
80104cb0:	53                   	push   %ebx
80104cb1:	e8 ba ff ff ff       	call   80104c70 <holding>
80104cb6:	83 c4 10             	add    $0x10,%esp
80104cb9:	85 c0                	test   %eax,%eax
80104cbb:	0f 85 83 00 00 00    	jne    80104d44 <acquire+0xa4>
80104cc1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104cc3:	ba 01 00 00 00       	mov    $0x1,%edx
80104cc8:	eb 09                	jmp    80104cd3 <acquire+0x33>
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cd0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cd3:	89 d0                	mov    %edx,%eax
80104cd5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104cd8:	85 c0                	test   %eax,%eax
80104cda:	75 f4                	jne    80104cd0 <acquire+0x30>
  __sync_synchronize();
80104cdc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104ce1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ce4:	e8 d7 eb ff ff       	call   801038c0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104ce9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104cec:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104cef:	89 e8                	mov    %ebp,%eax
80104cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104cf8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104cfe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104d04:	77 1a                	ja     80104d20 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104d06:	8b 48 04             	mov    0x4(%eax),%ecx
80104d09:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104d0c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104d0f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104d11:	83 fe 0a             	cmp    $0xa,%esi
80104d14:	75 e2                	jne    80104cf8 <acquire+0x58>
}
80104d16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d19:	5b                   	pop    %ebx
80104d1a:	5e                   	pop    %esi
80104d1b:	5d                   	pop    %ebp
80104d1c:	c3                   	ret    
80104d1d:	8d 76 00             	lea    0x0(%esi),%esi
80104d20:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104d23:	83 c2 28             	add    $0x28,%edx
80104d26:	8d 76 00             	lea    0x0(%esi),%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104d30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d36:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104d39:	39 d0                	cmp    %edx,%eax
80104d3b:	75 f3                	jne    80104d30 <acquire+0x90>
}
80104d3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d40:	5b                   	pop    %ebx
80104d41:	5e                   	pop    %esi
80104d42:	5d                   	pop    %ebp
80104d43:	c3                   	ret    
    panic("acquire");
80104d44:	83 ec 0c             	sub    $0xc,%esp
80104d47:	68 f9 81 10 80       	push   $0x801081f9
80104d4c:	e8 3f b6 ff ff       	call   80100390 <panic>
80104d51:	eb 0d                	jmp    80104d60 <release>
80104d53:	90                   	nop
80104d54:	90                   	nop
80104d55:	90                   	nop
80104d56:	90                   	nop
80104d57:	90                   	nop
80104d58:	90                   	nop
80104d59:	90                   	nop
80104d5a:	90                   	nop
80104d5b:	90                   	nop
80104d5c:	90                   	nop
80104d5d:	90                   	nop
80104d5e:	90                   	nop
80104d5f:	90                   	nop

80104d60 <release>:
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	53                   	push   %ebx
80104d64:	83 ec 10             	sub    $0x10,%esp
80104d67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d6a:	53                   	push   %ebx
80104d6b:	e8 00 ff ff ff       	call   80104c70 <holding>
80104d70:	83 c4 10             	add    $0x10,%esp
80104d73:	85 c0                	test   %eax,%eax
80104d75:	74 22                	je     80104d99 <release+0x39>
  lk->pcs[0] = 0;
80104d77:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d7e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d85:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d8a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d93:	c9                   	leave  
  popcli();
80104d94:	e9 77 fe ff ff       	jmp    80104c10 <popcli>
    panic("release");
80104d99:	83 ec 0c             	sub    $0xc,%esp
80104d9c:	68 01 82 10 80       	push   $0x80108201
80104da1:	e8 ea b5 ff ff       	call   80100390 <panic>
80104da6:	66 90                	xchg   %ax,%ax
80104da8:	66 90                	xchg   %ax,%ax
80104daa:	66 90                	xchg   %ax,%ax
80104dac:	66 90                	xchg   %ax,%ax
80104dae:	66 90                	xchg   %ax,%ax

80104db0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	57                   	push   %edi
80104db4:	53                   	push   %ebx
80104db5:	8b 55 08             	mov    0x8(%ebp),%edx
80104db8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104dbb:	f6 c2 03             	test   $0x3,%dl
80104dbe:	75 05                	jne    80104dc5 <memset+0x15>
80104dc0:	f6 c1 03             	test   $0x3,%cl
80104dc3:	74 13                	je     80104dd8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104dc5:	89 d7                	mov    %edx,%edi
80104dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dca:	fc                   	cld    
80104dcb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104dcd:	5b                   	pop    %ebx
80104dce:	89 d0                	mov    %edx,%eax
80104dd0:	5f                   	pop    %edi
80104dd1:	5d                   	pop    %ebp
80104dd2:	c3                   	ret    
80104dd3:	90                   	nop
80104dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104dd8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104ddc:	c1 e9 02             	shr    $0x2,%ecx
80104ddf:	89 f8                	mov    %edi,%eax
80104de1:	89 fb                	mov    %edi,%ebx
80104de3:	c1 e0 18             	shl    $0x18,%eax
80104de6:	c1 e3 10             	shl    $0x10,%ebx
80104de9:	09 d8                	or     %ebx,%eax
80104deb:	09 f8                	or     %edi,%eax
80104ded:	c1 e7 08             	shl    $0x8,%edi
80104df0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104df2:	89 d7                	mov    %edx,%edi
80104df4:	fc                   	cld    
80104df5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104df7:	5b                   	pop    %ebx
80104df8:	89 d0                	mov    %edx,%eax
80104dfa:	5f                   	pop    %edi
80104dfb:	5d                   	pop    %ebp
80104dfc:	c3                   	ret    
80104dfd:	8d 76 00             	lea    0x0(%esi),%esi

80104e00 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	53                   	push   %ebx
80104e06:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104e09:	8b 75 08             	mov    0x8(%ebp),%esi
80104e0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104e0f:	85 db                	test   %ebx,%ebx
80104e11:	74 29                	je     80104e3c <memcmp+0x3c>
    if(*s1 != *s2)
80104e13:	0f b6 16             	movzbl (%esi),%edx
80104e16:	0f b6 0f             	movzbl (%edi),%ecx
80104e19:	38 d1                	cmp    %dl,%cl
80104e1b:	75 2b                	jne    80104e48 <memcmp+0x48>
80104e1d:	b8 01 00 00 00       	mov    $0x1,%eax
80104e22:	eb 14                	jmp    80104e38 <memcmp+0x38>
80104e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e28:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104e2c:	83 c0 01             	add    $0x1,%eax
80104e2f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104e34:	38 ca                	cmp    %cl,%dl
80104e36:	75 10                	jne    80104e48 <memcmp+0x48>
  while(n-- > 0){
80104e38:	39 d8                	cmp    %ebx,%eax
80104e3a:	75 ec                	jne    80104e28 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104e3c:	5b                   	pop    %ebx
  return 0;
80104e3d:	31 c0                	xor    %eax,%eax
}
80104e3f:	5e                   	pop    %esi
80104e40:	5f                   	pop    %edi
80104e41:	5d                   	pop    %ebp
80104e42:	c3                   	ret    
80104e43:	90                   	nop
80104e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104e48:	0f b6 c2             	movzbl %dl,%eax
}
80104e4b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104e4c:	29 c8                	sub    %ecx,%eax
}
80104e4e:	5e                   	pop    %esi
80104e4f:	5f                   	pop    %edi
80104e50:	5d                   	pop    %ebp
80104e51:	c3                   	ret    
80104e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	56                   	push   %esi
80104e64:	53                   	push   %ebx
80104e65:	8b 45 08             	mov    0x8(%ebp),%eax
80104e68:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104e6b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e6e:	39 c3                	cmp    %eax,%ebx
80104e70:	73 26                	jae    80104e98 <memmove+0x38>
80104e72:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104e75:	39 c8                	cmp    %ecx,%eax
80104e77:	73 1f                	jae    80104e98 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104e79:	85 f6                	test   %esi,%esi
80104e7b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104e7e:	74 0f                	je     80104e8f <memmove+0x2f>
      *--d = *--s;
80104e80:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e84:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104e87:	83 ea 01             	sub    $0x1,%edx
80104e8a:	83 fa ff             	cmp    $0xffffffff,%edx
80104e8d:	75 f1                	jne    80104e80 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e8f:	5b                   	pop    %ebx
80104e90:	5e                   	pop    %esi
80104e91:	5d                   	pop    %ebp
80104e92:	c3                   	ret    
80104e93:	90                   	nop
80104e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104e98:	31 d2                	xor    %edx,%edx
80104e9a:	85 f6                	test   %esi,%esi
80104e9c:	74 f1                	je     80104e8f <memmove+0x2f>
80104e9e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104ea0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ea4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104ea7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104eaa:	39 d6                	cmp    %edx,%esi
80104eac:	75 f2                	jne    80104ea0 <memmove+0x40>
}
80104eae:	5b                   	pop    %ebx
80104eaf:	5e                   	pop    %esi
80104eb0:	5d                   	pop    %ebp
80104eb1:	c3                   	ret    
80104eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104ec3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104ec4:	eb 9a                	jmp    80104e60 <memmove>
80104ec6:	8d 76 00             	lea    0x0(%esi),%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	57                   	push   %edi
80104ed4:	56                   	push   %esi
80104ed5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104ed8:	53                   	push   %ebx
80104ed9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104edc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104edf:	85 ff                	test   %edi,%edi
80104ee1:	74 2f                	je     80104f12 <strncmp+0x42>
80104ee3:	0f b6 01             	movzbl (%ecx),%eax
80104ee6:	0f b6 1e             	movzbl (%esi),%ebx
80104ee9:	84 c0                	test   %al,%al
80104eeb:	74 37                	je     80104f24 <strncmp+0x54>
80104eed:	38 c3                	cmp    %al,%bl
80104eef:	75 33                	jne    80104f24 <strncmp+0x54>
80104ef1:	01 f7                	add    %esi,%edi
80104ef3:	eb 13                	jmp    80104f08 <strncmp+0x38>
80104ef5:	8d 76 00             	lea    0x0(%esi),%esi
80104ef8:	0f b6 01             	movzbl (%ecx),%eax
80104efb:	84 c0                	test   %al,%al
80104efd:	74 21                	je     80104f20 <strncmp+0x50>
80104eff:	0f b6 1a             	movzbl (%edx),%ebx
80104f02:	89 d6                	mov    %edx,%esi
80104f04:	38 d8                	cmp    %bl,%al
80104f06:	75 1c                	jne    80104f24 <strncmp+0x54>
    n--, p++, q++;
80104f08:	8d 56 01             	lea    0x1(%esi),%edx
80104f0b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104f0e:	39 fa                	cmp    %edi,%edx
80104f10:	75 e6                	jne    80104ef8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104f12:	5b                   	pop    %ebx
    return 0;
80104f13:	31 c0                	xor    %eax,%eax
}
80104f15:	5e                   	pop    %esi
80104f16:	5f                   	pop    %edi
80104f17:	5d                   	pop    %ebp
80104f18:	c3                   	ret    
80104f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f20:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104f24:	29 d8                	sub    %ebx,%eax
}
80104f26:	5b                   	pop    %ebx
80104f27:	5e                   	pop    %esi
80104f28:	5f                   	pop    %edi
80104f29:	5d                   	pop    %ebp
80104f2a:	c3                   	ret    
80104f2b:	90                   	nop
80104f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f30 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
80104f35:	8b 45 08             	mov    0x8(%ebp),%eax
80104f38:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104f3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f3e:	89 c2                	mov    %eax,%edx
80104f40:	eb 19                	jmp    80104f5b <strncpy+0x2b>
80104f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f48:	83 c3 01             	add    $0x1,%ebx
80104f4b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104f4f:	83 c2 01             	add    $0x1,%edx
80104f52:	84 c9                	test   %cl,%cl
80104f54:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f57:	74 09                	je     80104f62 <strncpy+0x32>
80104f59:	89 f1                	mov    %esi,%ecx
80104f5b:	85 c9                	test   %ecx,%ecx
80104f5d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104f60:	7f e6                	jg     80104f48 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f62:	31 c9                	xor    %ecx,%ecx
80104f64:	85 f6                	test   %esi,%esi
80104f66:	7e 17                	jle    80104f7f <strncpy+0x4f>
80104f68:	90                   	nop
80104f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104f70:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104f74:	89 f3                	mov    %esi,%ebx
80104f76:	83 c1 01             	add    $0x1,%ecx
80104f79:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104f7b:	85 db                	test   %ebx,%ebx
80104f7d:	7f f1                	jg     80104f70 <strncpy+0x40>
  return os;
}
80104f7f:	5b                   	pop    %ebx
80104f80:	5e                   	pop    %esi
80104f81:	5d                   	pop    %ebp
80104f82:	c3                   	ret    
80104f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f90 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	56                   	push   %esi
80104f94:	53                   	push   %ebx
80104f95:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f98:	8b 45 08             	mov    0x8(%ebp),%eax
80104f9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104f9e:	85 c9                	test   %ecx,%ecx
80104fa0:	7e 26                	jle    80104fc8 <safestrcpy+0x38>
80104fa2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104fa6:	89 c1                	mov    %eax,%ecx
80104fa8:	eb 17                	jmp    80104fc1 <safestrcpy+0x31>
80104faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104fb0:	83 c2 01             	add    $0x1,%edx
80104fb3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104fb7:	83 c1 01             	add    $0x1,%ecx
80104fba:	84 db                	test   %bl,%bl
80104fbc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104fbf:	74 04                	je     80104fc5 <safestrcpy+0x35>
80104fc1:	39 f2                	cmp    %esi,%edx
80104fc3:	75 eb                	jne    80104fb0 <safestrcpy+0x20>
    ;
  *s = 0;
80104fc5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104fc8:	5b                   	pop    %ebx
80104fc9:	5e                   	pop    %esi
80104fca:	5d                   	pop    %ebp
80104fcb:	c3                   	ret    
80104fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fd0 <strlen>:

int
strlen(const char *s)
{
80104fd0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104fd1:	31 c0                	xor    %eax,%eax
{
80104fd3:	89 e5                	mov    %esp,%ebp
80104fd5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104fd8:	80 3a 00             	cmpb   $0x0,(%edx)
80104fdb:	74 0c                	je     80104fe9 <strlen+0x19>
80104fdd:	8d 76 00             	lea    0x0(%esi),%esi
80104fe0:	83 c0 01             	add    $0x1,%eax
80104fe3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104fe7:	75 f7                	jne    80104fe0 <strlen+0x10>
    ;
  return n;
}
80104fe9:	5d                   	pop    %ebp
80104fea:	c3                   	ret    

80104feb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104feb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104fef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104ff3:	55                   	push   %ebp
  pushl %ebx
80104ff4:	53                   	push   %ebx
  pushl %esi
80104ff5:	56                   	push   %esi
  pushl %edi
80104ff6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104ff7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104ff9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104ffb:	5f                   	pop    %edi
  popl %esi
80104ffc:	5e                   	pop    %esi
  popl %ebx
80104ffd:	5b                   	pop    %ebx
  popl %ebp
80104ffe:	5d                   	pop    %ebp
  ret
80104fff:	c3                   	ret    

80105000 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	53                   	push   %ebx
80105004:	83 ec 04             	sub    $0x4,%esp
80105007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010500a:	e8 51 e9 ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010500f:	8b 00                	mov    (%eax),%eax
80105011:	39 d8                	cmp    %ebx,%eax
80105013:	76 1b                	jbe    80105030 <fetchint+0x30>
80105015:	8d 53 04             	lea    0x4(%ebx),%edx
80105018:	39 d0                	cmp    %edx,%eax
8010501a:	72 14                	jb     80105030 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010501c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010501f:	8b 13                	mov    (%ebx),%edx
80105021:	89 10                	mov    %edx,(%eax)
  return 0;
80105023:	31 c0                	xor    %eax,%eax
}
80105025:	83 c4 04             	add    $0x4,%esp
80105028:	5b                   	pop    %ebx
80105029:	5d                   	pop    %ebp
8010502a:	c3                   	ret    
8010502b:	90                   	nop
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105035:	eb ee                	jmp    80105025 <fetchint+0x25>
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105040 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	53                   	push   %ebx
80105044:	83 ec 04             	sub    $0x4,%esp
80105047:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010504a:	e8 11 e9 ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz)
8010504f:	39 18                	cmp    %ebx,(%eax)
80105051:	76 29                	jbe    8010507c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105053:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105056:	89 da                	mov    %ebx,%edx
80105058:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010505a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010505c:	39 c3                	cmp    %eax,%ebx
8010505e:	73 1c                	jae    8010507c <fetchstr+0x3c>
    if(*s == 0)
80105060:	80 3b 00             	cmpb   $0x0,(%ebx)
80105063:	75 10                	jne    80105075 <fetchstr+0x35>
80105065:	eb 39                	jmp    801050a0 <fetchstr+0x60>
80105067:	89 f6                	mov    %esi,%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105070:	80 3a 00             	cmpb   $0x0,(%edx)
80105073:	74 1b                	je     80105090 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105075:	83 c2 01             	add    $0x1,%edx
80105078:	39 d0                	cmp    %edx,%eax
8010507a:	77 f4                	ja     80105070 <fetchstr+0x30>
    return -1;
8010507c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105081:	83 c4 04             	add    $0x4,%esp
80105084:	5b                   	pop    %ebx
80105085:	5d                   	pop    %ebp
80105086:	c3                   	ret    
80105087:	89 f6                	mov    %esi,%esi
80105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105090:	83 c4 04             	add    $0x4,%esp
80105093:	89 d0                	mov    %edx,%eax
80105095:	29 d8                	sub    %ebx,%eax
80105097:	5b                   	pop    %ebx
80105098:	5d                   	pop    %ebp
80105099:	c3                   	ret    
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801050a0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801050a2:	eb dd                	jmp    80105081 <fetchstr+0x41>
801050a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050b0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
801050b5:	e8 d6 e8 ff ff       	call   80103990 <mythread>
801050ba:	8b 40 14             	mov    0x14(%eax),%eax
801050bd:	8b 55 08             	mov    0x8(%ebp),%edx
801050c0:	8b 40 44             	mov    0x44(%eax),%eax
801050c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801050c6:	e8 95 e8 ff ff       	call   80103960 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050cb:	8b 00                	mov    (%eax),%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
801050cd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050d0:	39 c6                	cmp    %eax,%esi
801050d2:	73 1c                	jae    801050f0 <argint+0x40>
801050d4:	8d 53 08             	lea    0x8(%ebx),%edx
801050d7:	39 d0                	cmp    %edx,%eax
801050d9:	72 15                	jb     801050f0 <argint+0x40>
  *ip = *(int*)(addr);
801050db:	8b 45 0c             	mov    0xc(%ebp),%eax
801050de:	8b 53 04             	mov    0x4(%ebx),%edx
801050e1:	89 10                	mov    %edx,(%eax)
  return 0;
801050e3:	31 c0                	xor    %eax,%eax
}
801050e5:	5b                   	pop    %ebx
801050e6:	5e                   	pop    %esi
801050e7:	5d                   	pop    %ebp
801050e8:	c3                   	ret    
801050e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((mythread()->tf->esp) + 4 + 4*n, ip);
801050f5:	eb ee                	jmp    801050e5 <argint+0x35>
801050f7:	89 f6                	mov    %esi,%esi
801050f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105100 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
80105105:	83 ec 10             	sub    $0x10,%esp
80105108:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010510b:	e8 50 e8 ff ff       	call   80103960 <myproc>
80105110:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105112:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105115:	83 ec 08             	sub    $0x8,%esp
80105118:	50                   	push   %eax
80105119:	ff 75 08             	pushl  0x8(%ebp)
8010511c:	e8 8f ff ff ff       	call   801050b0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105121:	83 c4 10             	add    $0x10,%esp
80105124:	85 c0                	test   %eax,%eax
80105126:	78 28                	js     80105150 <argptr+0x50>
80105128:	85 db                	test   %ebx,%ebx
8010512a:	78 24                	js     80105150 <argptr+0x50>
8010512c:	8b 16                	mov    (%esi),%edx
8010512e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105131:	39 c2                	cmp    %eax,%edx
80105133:	76 1b                	jbe    80105150 <argptr+0x50>
80105135:	01 c3                	add    %eax,%ebx
80105137:	39 da                	cmp    %ebx,%edx
80105139:	72 15                	jb     80105150 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010513b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010513e:	89 02                	mov    %eax,(%edx)
  return 0;
80105140:	31 c0                	xor    %eax,%eax
}
80105142:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105145:	5b                   	pop    %ebx
80105146:	5e                   	pop    %esi
80105147:	5d                   	pop    %ebp
80105148:	c3                   	ret    
80105149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105155:	eb eb                	jmp    80105142 <argptr+0x42>
80105157:	89 f6                	mov    %esi,%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105160 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105166:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105169:	50                   	push   %eax
8010516a:	ff 75 08             	pushl  0x8(%ebp)
8010516d:	e8 3e ff ff ff       	call   801050b0 <argint>
80105172:	83 c4 10             	add    $0x10,%esp
80105175:	85 c0                	test   %eax,%eax
80105177:	78 17                	js     80105190 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105179:	83 ec 08             	sub    $0x8,%esp
8010517c:	ff 75 0c             	pushl  0xc(%ebp)
8010517f:	ff 75 f4             	pushl  -0xc(%ebp)
80105182:	e8 b9 fe ff ff       	call   80105040 <fetchstr>
80105187:	83 c4 10             	add    $0x10,%esp
}
8010518a:	c9                   	leave  
8010518b:	c3                   	ret    
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105195:	c9                   	leave  
80105196:	c3                   	ret    
80105197:	89 f6                	mov    %esi,%esi
80105199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051a0 <syscall>:
[SYS_kthread_mutex_unlock] sys_kthread_mutex_unlock,
};

void
syscall(void)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	56                   	push   %esi
801051a4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
801051a5:	e8 b6 e7 ff ff       	call   80103960 <myproc>
801051aa:	89 c6                	mov    %eax,%esi
  struct kthread *curthread = mythread();
801051ac:	e8 df e7 ff ff       	call   80103990 <mythread>
801051b1:	89 c3                	mov    %eax,%ebx

  num = curthread->tf->eax;
801051b3:	8b 40 14             	mov    0x14(%eax),%eax
801051b6:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801051b9:	8d 50 ff             	lea    -0x1(%eax),%edx
801051bc:	83 fa 1c             	cmp    $0x1c,%edx
801051bf:	77 1f                	ja     801051e0 <syscall+0x40>
801051c1:	8b 14 85 40 82 10 80 	mov    -0x7fef7dc0(,%eax,4),%edx
801051c8:	85 d2                	test   %edx,%edx
801051ca:	74 14                	je     801051e0 <syscall+0x40>
    curthread->tf->eax = syscalls[num]();
801051cc:	ff d2                	call   *%edx
801051ce:	8b 53 14             	mov    0x14(%ebx),%edx
801051d1:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curthread->tf->eax = -1;
  }
}
801051d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051d7:	5b                   	pop    %ebx
801051d8:	5e                   	pop    %esi
801051d9:	5d                   	pop    %ebp
801051da:	c3                   	ret    
801051db:	90                   	nop
801051dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801051e0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801051e1:	8d 46 5c             	lea    0x5c(%esi),%eax
    cprintf("%d %s: unknown sys call %d\n",
801051e4:	50                   	push   %eax
801051e5:	ff 76 0c             	pushl  0xc(%esi)
801051e8:	68 09 82 10 80       	push   $0x80108209
801051ed:	e8 6e b4 ff ff       	call   80100660 <cprintf>
    curthread->tf->eax = -1;
801051f2:	8b 43 14             	mov    0x14(%ebx),%eax
801051f5:	83 c4 10             	add    $0x10,%esp
801051f8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801051ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105202:	5b                   	pop    %ebx
80105203:	5e                   	pop    %esi
80105204:	5d                   	pop    %ebp
80105205:	c3                   	ret    
80105206:	66 90                	xchg   %ax,%ax
80105208:	66 90                	xchg   %ax,%ax
8010520a:	66 90                	xchg   %ax,%ax
8010520c:	66 90                	xchg   %ax,%ax
8010520e:	66 90                	xchg   %ax,%ax

80105210 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	57                   	push   %edi
80105214:	56                   	push   %esi
80105215:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105216:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105219:	83 ec 44             	sub    $0x44,%esp
8010521c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010521f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105222:	56                   	push   %esi
80105223:	50                   	push   %eax
{
80105224:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105227:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010522a:	e8 a1 cd ff ff       	call   80101fd0 <nameiparent>
8010522f:	83 c4 10             	add    $0x10,%esp
80105232:	85 c0                	test   %eax,%eax
80105234:	0f 84 46 01 00 00    	je     80105380 <create+0x170>
    return 0;
  ilock(dp);
8010523a:	83 ec 0c             	sub    $0xc,%esp
8010523d:	89 c3                	mov    %eax,%ebx
8010523f:	50                   	push   %eax
80105240:	e8 0b c5 ff ff       	call   80101750 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105245:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105248:	83 c4 0c             	add    $0xc,%esp
8010524b:	50                   	push   %eax
8010524c:	56                   	push   %esi
8010524d:	53                   	push   %ebx
8010524e:	e8 2d ca ff ff       	call   80101c80 <dirlookup>
80105253:	83 c4 10             	add    $0x10,%esp
80105256:	85 c0                	test   %eax,%eax
80105258:	89 c7                	mov    %eax,%edi
8010525a:	74 34                	je     80105290 <create+0x80>
    iunlockput(dp);
8010525c:	83 ec 0c             	sub    $0xc,%esp
8010525f:	53                   	push   %ebx
80105260:	e8 7b c7 ff ff       	call   801019e0 <iunlockput>
    ilock(ip);
80105265:	89 3c 24             	mov    %edi,(%esp)
80105268:	e8 e3 c4 ff ff       	call   80101750 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010526d:	83 c4 10             	add    $0x10,%esp
80105270:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105275:	0f 85 95 00 00 00    	jne    80105310 <create+0x100>
8010527b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105280:	0f 85 8a 00 00 00    	jne    80105310 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105286:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105289:	89 f8                	mov    %edi,%eax
8010528b:	5b                   	pop    %ebx
8010528c:	5e                   	pop    %esi
8010528d:	5f                   	pop    %edi
8010528e:	5d                   	pop    %ebp
8010528f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105290:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105294:	83 ec 08             	sub    $0x8,%esp
80105297:	50                   	push   %eax
80105298:	ff 33                	pushl  (%ebx)
8010529a:	e8 41 c3 ff ff       	call   801015e0 <ialloc>
8010529f:	83 c4 10             	add    $0x10,%esp
801052a2:	85 c0                	test   %eax,%eax
801052a4:	89 c7                	mov    %eax,%edi
801052a6:	0f 84 e8 00 00 00    	je     80105394 <create+0x184>
  ilock(ip);
801052ac:	83 ec 0c             	sub    $0xc,%esp
801052af:	50                   	push   %eax
801052b0:	e8 9b c4 ff ff       	call   80101750 <ilock>
  ip->major = major;
801052b5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801052b9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801052bd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801052c1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
801052c5:	b8 01 00 00 00       	mov    $0x1,%eax
801052ca:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
801052ce:	89 3c 24             	mov    %edi,(%esp)
801052d1:	e8 ca c3 ff ff       	call   801016a0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801052d6:	83 c4 10             	add    $0x10,%esp
801052d9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801052de:	74 50                	je     80105330 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801052e0:	83 ec 04             	sub    $0x4,%esp
801052e3:	ff 77 04             	pushl  0x4(%edi)
801052e6:	56                   	push   %esi
801052e7:	53                   	push   %ebx
801052e8:	e8 03 cc ff ff       	call   80101ef0 <dirlink>
801052ed:	83 c4 10             	add    $0x10,%esp
801052f0:	85 c0                	test   %eax,%eax
801052f2:	0f 88 8f 00 00 00    	js     80105387 <create+0x177>
  iunlockput(dp);
801052f8:	83 ec 0c             	sub    $0xc,%esp
801052fb:	53                   	push   %ebx
801052fc:	e8 df c6 ff ff       	call   801019e0 <iunlockput>
  return ip;
80105301:	83 c4 10             	add    $0x10,%esp
}
80105304:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105307:	89 f8                	mov    %edi,%eax
80105309:	5b                   	pop    %ebx
8010530a:	5e                   	pop    %esi
8010530b:	5f                   	pop    %edi
8010530c:	5d                   	pop    %ebp
8010530d:	c3                   	ret    
8010530e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105310:	83 ec 0c             	sub    $0xc,%esp
80105313:	57                   	push   %edi
    return 0;
80105314:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105316:	e8 c5 c6 ff ff       	call   801019e0 <iunlockput>
    return 0;
8010531b:	83 c4 10             	add    $0x10,%esp
}
8010531e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105321:	89 f8                	mov    %edi,%eax
80105323:	5b                   	pop    %ebx
80105324:	5e                   	pop    %esi
80105325:	5f                   	pop    %edi
80105326:	5d                   	pop    %ebp
80105327:	c3                   	ret    
80105328:	90                   	nop
80105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105330:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105335:	83 ec 0c             	sub    $0xc,%esp
80105338:	53                   	push   %ebx
80105339:	e8 62 c3 ff ff       	call   801016a0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010533e:	83 c4 0c             	add    $0xc,%esp
80105341:	ff 77 04             	pushl  0x4(%edi)
80105344:	68 d4 82 10 80       	push   $0x801082d4
80105349:	57                   	push   %edi
8010534a:	e8 a1 cb ff ff       	call   80101ef0 <dirlink>
8010534f:	83 c4 10             	add    $0x10,%esp
80105352:	85 c0                	test   %eax,%eax
80105354:	78 1c                	js     80105372 <create+0x162>
80105356:	83 ec 04             	sub    $0x4,%esp
80105359:	ff 73 04             	pushl  0x4(%ebx)
8010535c:	68 d3 82 10 80       	push   $0x801082d3
80105361:	57                   	push   %edi
80105362:	e8 89 cb ff ff       	call   80101ef0 <dirlink>
80105367:	83 c4 10             	add    $0x10,%esp
8010536a:	85 c0                	test   %eax,%eax
8010536c:	0f 89 6e ff ff ff    	jns    801052e0 <create+0xd0>
      panic("create dots");
80105372:	83 ec 0c             	sub    $0xc,%esp
80105375:	68 c7 82 10 80       	push   $0x801082c7
8010537a:	e8 11 b0 ff ff       	call   80100390 <panic>
8010537f:	90                   	nop
    return 0;
80105380:	31 ff                	xor    %edi,%edi
80105382:	e9 ff fe ff ff       	jmp    80105286 <create+0x76>
    panic("create: dirlink");
80105387:	83 ec 0c             	sub    $0xc,%esp
8010538a:	68 d6 82 10 80       	push   $0x801082d6
8010538f:	e8 fc af ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105394:	83 ec 0c             	sub    $0xc,%esp
80105397:	68 b8 82 10 80       	push   $0x801082b8
8010539c:	e8 ef af ff ff       	call   80100390 <panic>
801053a1:	eb 0d                	jmp    801053b0 <argfd.constprop.0>
801053a3:	90                   	nop
801053a4:	90                   	nop
801053a5:	90                   	nop
801053a6:	90                   	nop
801053a7:	90                   	nop
801053a8:	90                   	nop
801053a9:	90                   	nop
801053aa:	90                   	nop
801053ab:	90                   	nop
801053ac:	90                   	nop
801053ad:	90                   	nop
801053ae:	90                   	nop
801053af:	90                   	nop

801053b0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	56                   	push   %esi
801053b4:	53                   	push   %ebx
801053b5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801053b7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801053ba:	89 d6                	mov    %edx,%esi
801053bc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053bf:	50                   	push   %eax
801053c0:	6a 00                	push   $0x0
801053c2:	e8 e9 fc ff ff       	call   801050b0 <argint>
801053c7:	83 c4 10             	add    $0x10,%esp
801053ca:	85 c0                	test   %eax,%eax
801053cc:	78 2a                	js     801053f8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053ce:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053d2:	77 24                	ja     801053f8 <argfd.constprop.0+0x48>
801053d4:	e8 87 e5 ff ff       	call   80103960 <myproc>
801053d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053dc:	8b 44 90 18          	mov    0x18(%eax,%edx,4),%eax
801053e0:	85 c0                	test   %eax,%eax
801053e2:	74 14                	je     801053f8 <argfd.constprop.0+0x48>
  if(pfd)
801053e4:	85 db                	test   %ebx,%ebx
801053e6:	74 02                	je     801053ea <argfd.constprop.0+0x3a>
    *pfd = fd;
801053e8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801053ea:	89 06                	mov    %eax,(%esi)
  return 0;
801053ec:	31 c0                	xor    %eax,%eax
}
801053ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053f1:	5b                   	pop    %ebx
801053f2:	5e                   	pop    %esi
801053f3:	5d                   	pop    %ebp
801053f4:	c3                   	ret    
801053f5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801053f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053fd:	eb ef                	jmp    801053ee <argfd.constprop.0+0x3e>
801053ff:	90                   	nop

80105400 <sys_dup>:
{
80105400:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105401:	31 c0                	xor    %eax,%eax
{
80105403:	89 e5                	mov    %esp,%ebp
80105405:	56                   	push   %esi
80105406:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105407:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010540a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010540d:	e8 9e ff ff ff       	call   801053b0 <argfd.constprop.0>
80105412:	85 c0                	test   %eax,%eax
80105414:	78 42                	js     80105458 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80105416:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105419:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010541b:	e8 40 e5 ff ff       	call   80103960 <myproc>
80105420:	eb 0e                	jmp    80105430 <sys_dup+0x30>
80105422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105428:	83 c3 01             	add    $0x1,%ebx
8010542b:	83 fb 10             	cmp    $0x10,%ebx
8010542e:	74 28                	je     80105458 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105430:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
80105434:	85 d2                	test   %edx,%edx
80105436:	75 f0                	jne    80105428 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105438:	89 74 98 18          	mov    %esi,0x18(%eax,%ebx,4)
  filedup(f);
8010543c:	83 ec 0c             	sub    $0xc,%esp
8010543f:	ff 75 f4             	pushl  -0xc(%ebp)
80105442:	e8 69 ba ff ff       	call   80100eb0 <filedup>
  return fd;
80105447:	83 c4 10             	add    $0x10,%esp
}
8010544a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010544d:	89 d8                	mov    %ebx,%eax
8010544f:	5b                   	pop    %ebx
80105450:	5e                   	pop    %esi
80105451:	5d                   	pop    %ebp
80105452:	c3                   	ret    
80105453:	90                   	nop
80105454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105458:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010545b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105460:	89 d8                	mov    %ebx,%eax
80105462:	5b                   	pop    %ebx
80105463:	5e                   	pop    %esi
80105464:	5d                   	pop    %ebp
80105465:	c3                   	ret    
80105466:	8d 76 00             	lea    0x0(%esi),%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105470 <sys_read>:
{
80105470:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105471:	31 c0                	xor    %eax,%eax
{
80105473:	89 e5                	mov    %esp,%ebp
80105475:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105478:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010547b:	e8 30 ff ff ff       	call   801053b0 <argfd.constprop.0>
80105480:	85 c0                	test   %eax,%eax
80105482:	78 4c                	js     801054d0 <sys_read+0x60>
80105484:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105487:	83 ec 08             	sub    $0x8,%esp
8010548a:	50                   	push   %eax
8010548b:	6a 02                	push   $0x2
8010548d:	e8 1e fc ff ff       	call   801050b0 <argint>
80105492:	83 c4 10             	add    $0x10,%esp
80105495:	85 c0                	test   %eax,%eax
80105497:	78 37                	js     801054d0 <sys_read+0x60>
80105499:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010549c:	83 ec 04             	sub    $0x4,%esp
8010549f:	ff 75 f0             	pushl  -0x10(%ebp)
801054a2:	50                   	push   %eax
801054a3:	6a 01                	push   $0x1
801054a5:	e8 56 fc ff ff       	call   80105100 <argptr>
801054aa:	83 c4 10             	add    $0x10,%esp
801054ad:	85 c0                	test   %eax,%eax
801054af:	78 1f                	js     801054d0 <sys_read+0x60>
  return fileread(f, p, n);
801054b1:	83 ec 04             	sub    $0x4,%esp
801054b4:	ff 75 f0             	pushl  -0x10(%ebp)
801054b7:	ff 75 f4             	pushl  -0xc(%ebp)
801054ba:	ff 75 ec             	pushl  -0x14(%ebp)
801054bd:	e8 5e bb ff ff       	call   80101020 <fileread>
801054c2:	83 c4 10             	add    $0x10,%esp
}
801054c5:	c9                   	leave  
801054c6:	c3                   	ret    
801054c7:	89 f6                	mov    %esi,%esi
801054c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054d5:	c9                   	leave  
801054d6:	c3                   	ret    
801054d7:	89 f6                	mov    %esi,%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054e0 <sys_write>:
{
801054e0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054e1:	31 c0                	xor    %eax,%eax
{
801054e3:	89 e5                	mov    %esp,%ebp
801054e5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054e8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801054eb:	e8 c0 fe ff ff       	call   801053b0 <argfd.constprop.0>
801054f0:	85 c0                	test   %eax,%eax
801054f2:	78 4c                	js     80105540 <sys_write+0x60>
801054f4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054f7:	83 ec 08             	sub    $0x8,%esp
801054fa:	50                   	push   %eax
801054fb:	6a 02                	push   $0x2
801054fd:	e8 ae fb ff ff       	call   801050b0 <argint>
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	85 c0                	test   %eax,%eax
80105507:	78 37                	js     80105540 <sys_write+0x60>
80105509:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010550c:	83 ec 04             	sub    $0x4,%esp
8010550f:	ff 75 f0             	pushl  -0x10(%ebp)
80105512:	50                   	push   %eax
80105513:	6a 01                	push   $0x1
80105515:	e8 e6 fb ff ff       	call   80105100 <argptr>
8010551a:	83 c4 10             	add    $0x10,%esp
8010551d:	85 c0                	test   %eax,%eax
8010551f:	78 1f                	js     80105540 <sys_write+0x60>
  return filewrite(f, p, n);
80105521:	83 ec 04             	sub    $0x4,%esp
80105524:	ff 75 f0             	pushl  -0x10(%ebp)
80105527:	ff 75 f4             	pushl  -0xc(%ebp)
8010552a:	ff 75 ec             	pushl  -0x14(%ebp)
8010552d:	e8 7e bb ff ff       	call   801010b0 <filewrite>
80105532:	83 c4 10             	add    $0x10,%esp
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

80105550 <sys_close>:
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105556:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105559:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010555c:	e8 4f fe ff ff       	call   801053b0 <argfd.constprop.0>
80105561:	85 c0                	test   %eax,%eax
80105563:	78 2b                	js     80105590 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105565:	e8 f6 e3 ff ff       	call   80103960 <myproc>
8010556a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010556d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105570:	c7 44 90 18 00 00 00 	movl   $0x0,0x18(%eax,%edx,4)
80105577:	00 
  fileclose(f);
80105578:	ff 75 f4             	pushl  -0xc(%ebp)
8010557b:	e8 80 b9 ff ff       	call   80100f00 <fileclose>
  return 0;
80105580:	83 c4 10             	add    $0x10,%esp
80105583:	31 c0                	xor    %eax,%eax
}
80105585:	c9                   	leave  
80105586:	c3                   	ret    
80105587:	89 f6                	mov    %esi,%esi
80105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105595:	c9                   	leave  
80105596:	c3                   	ret    
80105597:	89 f6                	mov    %esi,%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055a0 <sys_fstat>:
{
801055a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055a1:	31 c0                	xor    %eax,%eax
{
801055a3:	89 e5                	mov    %esp,%ebp
801055a5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055a8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801055ab:	e8 00 fe ff ff       	call   801053b0 <argfd.constprop.0>
801055b0:	85 c0                	test   %eax,%eax
801055b2:	78 2c                	js     801055e0 <sys_fstat+0x40>
801055b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055b7:	83 ec 04             	sub    $0x4,%esp
801055ba:	6a 14                	push   $0x14
801055bc:	50                   	push   %eax
801055bd:	6a 01                	push   $0x1
801055bf:	e8 3c fb ff ff       	call   80105100 <argptr>
801055c4:	83 c4 10             	add    $0x10,%esp
801055c7:	85 c0                	test   %eax,%eax
801055c9:	78 15                	js     801055e0 <sys_fstat+0x40>
  return filestat(f, st);
801055cb:	83 ec 08             	sub    $0x8,%esp
801055ce:	ff 75 f4             	pushl  -0xc(%ebp)
801055d1:	ff 75 f0             	pushl  -0x10(%ebp)
801055d4:	e8 f7 b9 ff ff       	call   80100fd0 <filestat>
801055d9:	83 c4 10             	add    $0x10,%esp
}
801055dc:	c9                   	leave  
801055dd:	c3                   	ret    
801055de:	66 90                	xchg   %ax,%ax
    return -1;
801055e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055e5:	c9                   	leave  
801055e6:	c3                   	ret    
801055e7:	89 f6                	mov    %esi,%esi
801055e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055f0 <sys_link>:
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
801055f5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055f6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801055f9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801055fc:	50                   	push   %eax
801055fd:	6a 00                	push   $0x0
801055ff:	e8 5c fb ff ff       	call   80105160 <argstr>
80105604:	83 c4 10             	add    $0x10,%esp
80105607:	85 c0                	test   %eax,%eax
80105609:	0f 88 fb 00 00 00    	js     8010570a <sys_link+0x11a>
8010560f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105612:	83 ec 08             	sub    $0x8,%esp
80105615:	50                   	push   %eax
80105616:	6a 01                	push   $0x1
80105618:	e8 43 fb ff ff       	call   80105160 <argstr>
8010561d:	83 c4 10             	add    $0x10,%esp
80105620:	85 c0                	test   %eax,%eax
80105622:	0f 88 e2 00 00 00    	js     8010570a <sys_link+0x11a>
  begin_op();
80105628:	e8 43 d6 ff ff       	call   80102c70 <begin_op>
  if((ip = namei(old)) == 0){
8010562d:	83 ec 0c             	sub    $0xc,%esp
80105630:	ff 75 d4             	pushl  -0x2c(%ebp)
80105633:	e8 78 c9 ff ff       	call   80101fb0 <namei>
80105638:	83 c4 10             	add    $0x10,%esp
8010563b:	85 c0                	test   %eax,%eax
8010563d:	89 c3                	mov    %eax,%ebx
8010563f:	0f 84 ea 00 00 00    	je     8010572f <sys_link+0x13f>
  ilock(ip);
80105645:	83 ec 0c             	sub    $0xc,%esp
80105648:	50                   	push   %eax
80105649:	e8 02 c1 ff ff       	call   80101750 <ilock>
  if(ip->type == T_DIR){
8010564e:	83 c4 10             	add    $0x10,%esp
80105651:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105656:	0f 84 bb 00 00 00    	je     80105717 <sys_link+0x127>
  ip->nlink++;
8010565c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105661:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105664:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105667:	53                   	push   %ebx
80105668:	e8 33 c0 ff ff       	call   801016a0 <iupdate>
  iunlock(ip);
8010566d:	89 1c 24             	mov    %ebx,(%esp)
80105670:	e8 bb c1 ff ff       	call   80101830 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105675:	58                   	pop    %eax
80105676:	5a                   	pop    %edx
80105677:	57                   	push   %edi
80105678:	ff 75 d0             	pushl  -0x30(%ebp)
8010567b:	e8 50 c9 ff ff       	call   80101fd0 <nameiparent>
80105680:	83 c4 10             	add    $0x10,%esp
80105683:	85 c0                	test   %eax,%eax
80105685:	89 c6                	mov    %eax,%esi
80105687:	74 5b                	je     801056e4 <sys_link+0xf4>
  ilock(dp);
80105689:	83 ec 0c             	sub    $0xc,%esp
8010568c:	50                   	push   %eax
8010568d:	e8 be c0 ff ff       	call   80101750 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105692:	83 c4 10             	add    $0x10,%esp
80105695:	8b 03                	mov    (%ebx),%eax
80105697:	39 06                	cmp    %eax,(%esi)
80105699:	75 3d                	jne    801056d8 <sys_link+0xe8>
8010569b:	83 ec 04             	sub    $0x4,%esp
8010569e:	ff 73 04             	pushl  0x4(%ebx)
801056a1:	57                   	push   %edi
801056a2:	56                   	push   %esi
801056a3:	e8 48 c8 ff ff       	call   80101ef0 <dirlink>
801056a8:	83 c4 10             	add    $0x10,%esp
801056ab:	85 c0                	test   %eax,%eax
801056ad:	78 29                	js     801056d8 <sys_link+0xe8>
  iunlockput(dp);
801056af:	83 ec 0c             	sub    $0xc,%esp
801056b2:	56                   	push   %esi
801056b3:	e8 28 c3 ff ff       	call   801019e0 <iunlockput>
  iput(ip);
801056b8:	89 1c 24             	mov    %ebx,(%esp)
801056bb:	e8 c0 c1 ff ff       	call   80101880 <iput>
  end_op();
801056c0:	e8 1b d6 ff ff       	call   80102ce0 <end_op>
  return 0;
801056c5:	83 c4 10             	add    $0x10,%esp
801056c8:	31 c0                	xor    %eax,%eax
}
801056ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056cd:	5b                   	pop    %ebx
801056ce:	5e                   	pop    %esi
801056cf:	5f                   	pop    %edi
801056d0:	5d                   	pop    %ebp
801056d1:	c3                   	ret    
801056d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801056d8:	83 ec 0c             	sub    $0xc,%esp
801056db:	56                   	push   %esi
801056dc:	e8 ff c2 ff ff       	call   801019e0 <iunlockput>
    goto bad;
801056e1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801056e4:	83 ec 0c             	sub    $0xc,%esp
801056e7:	53                   	push   %ebx
801056e8:	e8 63 c0 ff ff       	call   80101750 <ilock>
  ip->nlink--;
801056ed:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056f2:	89 1c 24             	mov    %ebx,(%esp)
801056f5:	e8 a6 bf ff ff       	call   801016a0 <iupdate>
  iunlockput(ip);
801056fa:	89 1c 24             	mov    %ebx,(%esp)
801056fd:	e8 de c2 ff ff       	call   801019e0 <iunlockput>
  end_op();
80105702:	e8 d9 d5 ff ff       	call   80102ce0 <end_op>
  return -1;
80105707:	83 c4 10             	add    $0x10,%esp
}
8010570a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010570d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105712:	5b                   	pop    %ebx
80105713:	5e                   	pop    %esi
80105714:	5f                   	pop    %edi
80105715:	5d                   	pop    %ebp
80105716:	c3                   	ret    
    iunlockput(ip);
80105717:	83 ec 0c             	sub    $0xc,%esp
8010571a:	53                   	push   %ebx
8010571b:	e8 c0 c2 ff ff       	call   801019e0 <iunlockput>
    end_op();
80105720:	e8 bb d5 ff ff       	call   80102ce0 <end_op>
    return -1;
80105725:	83 c4 10             	add    $0x10,%esp
80105728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010572d:	eb 9b                	jmp    801056ca <sys_link+0xda>
    end_op();
8010572f:	e8 ac d5 ff ff       	call   80102ce0 <end_op>
    return -1;
80105734:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105739:	eb 8f                	jmp    801056ca <sys_link+0xda>
8010573b:	90                   	nop
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105740 <sys_unlink>:
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	57                   	push   %edi
80105744:	56                   	push   %esi
80105745:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105746:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105749:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010574c:	50                   	push   %eax
8010574d:	6a 00                	push   $0x0
8010574f:	e8 0c fa ff ff       	call   80105160 <argstr>
80105754:	83 c4 10             	add    $0x10,%esp
80105757:	85 c0                	test   %eax,%eax
80105759:	0f 88 77 01 00 00    	js     801058d6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010575f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105762:	e8 09 d5 ff ff       	call   80102c70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105767:	83 ec 08             	sub    $0x8,%esp
8010576a:	53                   	push   %ebx
8010576b:	ff 75 c0             	pushl  -0x40(%ebp)
8010576e:	e8 5d c8 ff ff       	call   80101fd0 <nameiparent>
80105773:	83 c4 10             	add    $0x10,%esp
80105776:	85 c0                	test   %eax,%eax
80105778:	89 c6                	mov    %eax,%esi
8010577a:	0f 84 60 01 00 00    	je     801058e0 <sys_unlink+0x1a0>
  ilock(dp);
80105780:	83 ec 0c             	sub    $0xc,%esp
80105783:	50                   	push   %eax
80105784:	e8 c7 bf ff ff       	call   80101750 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105789:	58                   	pop    %eax
8010578a:	5a                   	pop    %edx
8010578b:	68 d4 82 10 80       	push   $0x801082d4
80105790:	53                   	push   %ebx
80105791:	e8 ca c4 ff ff       	call   80101c60 <namecmp>
80105796:	83 c4 10             	add    $0x10,%esp
80105799:	85 c0                	test   %eax,%eax
8010579b:	0f 84 03 01 00 00    	je     801058a4 <sys_unlink+0x164>
801057a1:	83 ec 08             	sub    $0x8,%esp
801057a4:	68 d3 82 10 80       	push   $0x801082d3
801057a9:	53                   	push   %ebx
801057aa:	e8 b1 c4 ff ff       	call   80101c60 <namecmp>
801057af:	83 c4 10             	add    $0x10,%esp
801057b2:	85 c0                	test   %eax,%eax
801057b4:	0f 84 ea 00 00 00    	je     801058a4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801057ba:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801057bd:	83 ec 04             	sub    $0x4,%esp
801057c0:	50                   	push   %eax
801057c1:	53                   	push   %ebx
801057c2:	56                   	push   %esi
801057c3:	e8 b8 c4 ff ff       	call   80101c80 <dirlookup>
801057c8:	83 c4 10             	add    $0x10,%esp
801057cb:	85 c0                	test   %eax,%eax
801057cd:	89 c3                	mov    %eax,%ebx
801057cf:	0f 84 cf 00 00 00    	je     801058a4 <sys_unlink+0x164>
  ilock(ip);
801057d5:	83 ec 0c             	sub    $0xc,%esp
801057d8:	50                   	push   %eax
801057d9:	e8 72 bf ff ff       	call   80101750 <ilock>
  if(ip->nlink < 1)
801057de:	83 c4 10             	add    $0x10,%esp
801057e1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801057e6:	0f 8e 10 01 00 00    	jle    801058fc <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801057ec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057f1:	74 6d                	je     80105860 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801057f3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057f6:	83 ec 04             	sub    $0x4,%esp
801057f9:	6a 10                	push   $0x10
801057fb:	6a 00                	push   $0x0
801057fd:	50                   	push   %eax
801057fe:	e8 ad f5 ff ff       	call   80104db0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105803:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105806:	6a 10                	push   $0x10
80105808:	ff 75 c4             	pushl  -0x3c(%ebp)
8010580b:	50                   	push   %eax
8010580c:	56                   	push   %esi
8010580d:	e8 1e c3 ff ff       	call   80101b30 <writei>
80105812:	83 c4 20             	add    $0x20,%esp
80105815:	83 f8 10             	cmp    $0x10,%eax
80105818:	0f 85 eb 00 00 00    	jne    80105909 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010581e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105823:	0f 84 97 00 00 00    	je     801058c0 <sys_unlink+0x180>
  iunlockput(dp);
80105829:	83 ec 0c             	sub    $0xc,%esp
8010582c:	56                   	push   %esi
8010582d:	e8 ae c1 ff ff       	call   801019e0 <iunlockput>
  ip->nlink--;
80105832:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105837:	89 1c 24             	mov    %ebx,(%esp)
8010583a:	e8 61 be ff ff       	call   801016a0 <iupdate>
  iunlockput(ip);
8010583f:	89 1c 24             	mov    %ebx,(%esp)
80105842:	e8 99 c1 ff ff       	call   801019e0 <iunlockput>
  end_op();
80105847:	e8 94 d4 ff ff       	call   80102ce0 <end_op>
  return 0;
8010584c:	83 c4 10             	add    $0x10,%esp
8010584f:	31 c0                	xor    %eax,%eax
}
80105851:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105854:	5b                   	pop    %ebx
80105855:	5e                   	pop    %esi
80105856:	5f                   	pop    %edi
80105857:	5d                   	pop    %ebp
80105858:	c3                   	ret    
80105859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105860:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105864:	76 8d                	jbe    801057f3 <sys_unlink+0xb3>
80105866:	bf 20 00 00 00       	mov    $0x20,%edi
8010586b:	eb 0f                	jmp    8010587c <sys_unlink+0x13c>
8010586d:	8d 76 00             	lea    0x0(%esi),%esi
80105870:	83 c7 10             	add    $0x10,%edi
80105873:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105876:	0f 83 77 ff ff ff    	jae    801057f3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010587c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010587f:	6a 10                	push   $0x10
80105881:	57                   	push   %edi
80105882:	50                   	push   %eax
80105883:	53                   	push   %ebx
80105884:	e8 a7 c1 ff ff       	call   80101a30 <readi>
80105889:	83 c4 10             	add    $0x10,%esp
8010588c:	83 f8 10             	cmp    $0x10,%eax
8010588f:	75 5e                	jne    801058ef <sys_unlink+0x1af>
    if(de.inum != 0)
80105891:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105896:	74 d8                	je     80105870 <sys_unlink+0x130>
    iunlockput(ip);
80105898:	83 ec 0c             	sub    $0xc,%esp
8010589b:	53                   	push   %ebx
8010589c:	e8 3f c1 ff ff       	call   801019e0 <iunlockput>
    goto bad;
801058a1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801058a4:	83 ec 0c             	sub    $0xc,%esp
801058a7:	56                   	push   %esi
801058a8:	e8 33 c1 ff ff       	call   801019e0 <iunlockput>
  end_op();
801058ad:	e8 2e d4 ff ff       	call   80102ce0 <end_op>
  return -1;
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ba:	eb 95                	jmp    80105851 <sys_unlink+0x111>
801058bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801058c0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801058c5:	83 ec 0c             	sub    $0xc,%esp
801058c8:	56                   	push   %esi
801058c9:	e8 d2 bd ff ff       	call   801016a0 <iupdate>
801058ce:	83 c4 10             	add    $0x10,%esp
801058d1:	e9 53 ff ff ff       	jmp    80105829 <sys_unlink+0xe9>
    return -1;
801058d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058db:	e9 71 ff ff ff       	jmp    80105851 <sys_unlink+0x111>
    end_op();
801058e0:	e8 fb d3 ff ff       	call   80102ce0 <end_op>
    return -1;
801058e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ea:	e9 62 ff ff ff       	jmp    80105851 <sys_unlink+0x111>
      panic("isdirempty: readi");
801058ef:	83 ec 0c             	sub    $0xc,%esp
801058f2:	68 f8 82 10 80       	push   $0x801082f8
801058f7:	e8 94 aa ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801058fc:	83 ec 0c             	sub    $0xc,%esp
801058ff:	68 e6 82 10 80       	push   $0x801082e6
80105904:	e8 87 aa ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105909:	83 ec 0c             	sub    $0xc,%esp
8010590c:	68 0a 83 10 80       	push   $0x8010830a
80105911:	e8 7a aa ff ff       	call   80100390 <panic>
80105916:	8d 76 00             	lea    0x0(%esi),%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_open>:

int
sys_open(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	57                   	push   %edi
80105924:	56                   	push   %esi
80105925:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105926:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105929:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010592c:	50                   	push   %eax
8010592d:	6a 00                	push   $0x0
8010592f:	e8 2c f8 ff ff       	call   80105160 <argstr>
80105934:	83 c4 10             	add    $0x10,%esp
80105937:	85 c0                	test   %eax,%eax
80105939:	0f 88 1d 01 00 00    	js     80105a5c <sys_open+0x13c>
8010593f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105942:	83 ec 08             	sub    $0x8,%esp
80105945:	50                   	push   %eax
80105946:	6a 01                	push   $0x1
80105948:	e8 63 f7 ff ff       	call   801050b0 <argint>
8010594d:	83 c4 10             	add    $0x10,%esp
80105950:	85 c0                	test   %eax,%eax
80105952:	0f 88 04 01 00 00    	js     80105a5c <sys_open+0x13c>
    return -1;

  begin_op();
80105958:	e8 13 d3 ff ff       	call   80102c70 <begin_op>

  if(omode & O_CREATE){
8010595d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105961:	0f 85 a9 00 00 00    	jne    80105a10 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105967:	83 ec 0c             	sub    $0xc,%esp
8010596a:	ff 75 e0             	pushl  -0x20(%ebp)
8010596d:	e8 3e c6 ff ff       	call   80101fb0 <namei>
80105972:	83 c4 10             	add    $0x10,%esp
80105975:	85 c0                	test   %eax,%eax
80105977:	89 c6                	mov    %eax,%esi
80105979:	0f 84 b2 00 00 00    	je     80105a31 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010597f:	83 ec 0c             	sub    $0xc,%esp
80105982:	50                   	push   %eax
80105983:	e8 c8 bd ff ff       	call   80101750 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105988:	83 c4 10             	add    $0x10,%esp
8010598b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105990:	0f 84 aa 00 00 00    	je     80105a40 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105996:	e8 a5 b4 ff ff       	call   80100e40 <filealloc>
8010599b:	85 c0                	test   %eax,%eax
8010599d:	89 c7                	mov    %eax,%edi
8010599f:	0f 84 a6 00 00 00    	je     80105a4b <sys_open+0x12b>
  struct proc *curproc = myproc();
801059a5:	e8 b6 df ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059aa:	31 db                	xor    %ebx,%ebx
801059ac:	eb 0e                	jmp    801059bc <sys_open+0x9c>
801059ae:	66 90                	xchg   %ax,%ax
801059b0:	83 c3 01             	add    $0x1,%ebx
801059b3:	83 fb 10             	cmp    $0x10,%ebx
801059b6:	0f 84 ac 00 00 00    	je     80105a68 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801059bc:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
801059c0:	85 d2                	test   %edx,%edx
801059c2:	75 ec                	jne    801059b0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059c4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801059c7:	89 7c 98 18          	mov    %edi,0x18(%eax,%ebx,4)
  iunlock(ip);
801059cb:	56                   	push   %esi
801059cc:	e8 5f be ff ff       	call   80101830 <iunlock>
  end_op();
801059d1:	e8 0a d3 ff ff       	call   80102ce0 <end_op>

  f->type = FD_INODE;
801059d6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059dc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059df:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059e2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801059e5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059ec:	89 d0                	mov    %edx,%eax
801059ee:	f7 d0                	not    %eax
801059f0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059f3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059f6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059f9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a00:	89 d8                	mov    %ebx,%eax
80105a02:	5b                   	pop    %ebx
80105a03:	5e                   	pop    %esi
80105a04:	5f                   	pop    %edi
80105a05:	5d                   	pop    %ebp
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105a16:	31 c9                	xor    %ecx,%ecx
80105a18:	6a 00                	push   $0x0
80105a1a:	ba 02 00 00 00       	mov    $0x2,%edx
80105a1f:	e8 ec f7 ff ff       	call   80105210 <create>
    if(ip == 0){
80105a24:	83 c4 10             	add    $0x10,%esp
80105a27:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105a29:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105a2b:	0f 85 65 ff ff ff    	jne    80105996 <sys_open+0x76>
      end_op();
80105a31:	e8 aa d2 ff ff       	call   80102ce0 <end_op>
      return -1;
80105a36:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a3b:	eb c0                	jmp    801059fd <sys_open+0xdd>
80105a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105a40:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105a43:	85 c9                	test   %ecx,%ecx
80105a45:	0f 84 4b ff ff ff    	je     80105996 <sys_open+0x76>
    iunlockput(ip);
80105a4b:	83 ec 0c             	sub    $0xc,%esp
80105a4e:	56                   	push   %esi
80105a4f:	e8 8c bf ff ff       	call   801019e0 <iunlockput>
    end_op();
80105a54:	e8 87 d2 ff ff       	call   80102ce0 <end_op>
    return -1;
80105a59:	83 c4 10             	add    $0x10,%esp
80105a5c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a61:	eb 9a                	jmp    801059fd <sys_open+0xdd>
80105a63:	90                   	nop
80105a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105a68:	83 ec 0c             	sub    $0xc,%esp
80105a6b:	57                   	push   %edi
80105a6c:	e8 8f b4 ff ff       	call   80100f00 <fileclose>
80105a71:	83 c4 10             	add    $0x10,%esp
80105a74:	eb d5                	jmp    80105a4b <sys_open+0x12b>
80105a76:	8d 76 00             	lea    0x0(%esi),%esi
80105a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a80 <sys_mkdir>:

int
sys_mkdir(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a86:	e8 e5 d1 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105a8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a8e:	83 ec 08             	sub    $0x8,%esp
80105a91:	50                   	push   %eax
80105a92:	6a 00                	push   $0x0
80105a94:	e8 c7 f6 ff ff       	call   80105160 <argstr>
80105a99:	83 c4 10             	add    $0x10,%esp
80105a9c:	85 c0                	test   %eax,%eax
80105a9e:	78 30                	js     80105ad0 <sys_mkdir+0x50>
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aa6:	31 c9                	xor    %ecx,%ecx
80105aa8:	6a 00                	push   $0x0
80105aaa:	ba 01 00 00 00       	mov    $0x1,%edx
80105aaf:	e8 5c f7 ff ff       	call   80105210 <create>
80105ab4:	83 c4 10             	add    $0x10,%esp
80105ab7:	85 c0                	test   %eax,%eax
80105ab9:	74 15                	je     80105ad0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105abb:	83 ec 0c             	sub    $0xc,%esp
80105abe:	50                   	push   %eax
80105abf:	e8 1c bf ff ff       	call   801019e0 <iunlockput>
  end_op();
80105ac4:	e8 17 d2 ff ff       	call   80102ce0 <end_op>
  return 0;
80105ac9:	83 c4 10             	add    $0x10,%esp
80105acc:	31 c0                	xor    %eax,%eax
}
80105ace:	c9                   	leave  
80105acf:	c3                   	ret    
    end_op();
80105ad0:	e8 0b d2 ff ff       	call   80102ce0 <end_op>
    return -1;
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ada:	c9                   	leave  
80105adb:	c3                   	ret    
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <sys_mknod>:

int
sys_mknod(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105ae6:	e8 85 d1 ff ff       	call   80102c70 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105aeb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105aee:	83 ec 08             	sub    $0x8,%esp
80105af1:	50                   	push   %eax
80105af2:	6a 00                	push   $0x0
80105af4:	e8 67 f6 ff ff       	call   80105160 <argstr>
80105af9:	83 c4 10             	add    $0x10,%esp
80105afc:	85 c0                	test   %eax,%eax
80105afe:	78 60                	js     80105b60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105b00:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b03:	83 ec 08             	sub    $0x8,%esp
80105b06:	50                   	push   %eax
80105b07:	6a 01                	push   $0x1
80105b09:	e8 a2 f5 ff ff       	call   801050b0 <argint>
  if((argstr(0, &path)) < 0 ||
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	85 c0                	test   %eax,%eax
80105b13:	78 4b                	js     80105b60 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105b15:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b18:	83 ec 08             	sub    $0x8,%esp
80105b1b:	50                   	push   %eax
80105b1c:	6a 02                	push   $0x2
80105b1e:	e8 8d f5 ff ff       	call   801050b0 <argint>
     argint(1, &major) < 0 ||
80105b23:	83 c4 10             	add    $0x10,%esp
80105b26:	85 c0                	test   %eax,%eax
80105b28:	78 36                	js     80105b60 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b2a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105b2e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b31:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105b35:	ba 03 00 00 00       	mov    $0x3,%edx
80105b3a:	50                   	push   %eax
80105b3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105b3e:	e8 cd f6 ff ff       	call   80105210 <create>
80105b43:	83 c4 10             	add    $0x10,%esp
80105b46:	85 c0                	test   %eax,%eax
80105b48:	74 16                	je     80105b60 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b4a:	83 ec 0c             	sub    $0xc,%esp
80105b4d:	50                   	push   %eax
80105b4e:	e8 8d be ff ff       	call   801019e0 <iunlockput>
  end_op();
80105b53:	e8 88 d1 ff ff       	call   80102ce0 <end_op>
  return 0;
80105b58:	83 c4 10             	add    $0x10,%esp
80105b5b:	31 c0                	xor    %eax,%eax
}
80105b5d:	c9                   	leave  
80105b5e:	c3                   	ret    
80105b5f:	90                   	nop
    end_op();
80105b60:	e8 7b d1 ff ff       	call   80102ce0 <end_op>
    return -1;
80105b65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b6a:	c9                   	leave  
80105b6b:	c3                   	ret    
80105b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b70 <sys_chdir>:

int
sys_chdir(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	56                   	push   %esi
80105b74:	53                   	push   %ebx
80105b75:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b78:	e8 e3 dd ff ff       	call   80103960 <myproc>
80105b7d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105b7f:	e8 ec d0 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105b84:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b87:	83 ec 08             	sub    $0x8,%esp
80105b8a:	50                   	push   %eax
80105b8b:	6a 00                	push   $0x0
80105b8d:	e8 ce f5 ff ff       	call   80105160 <argstr>
80105b92:	83 c4 10             	add    $0x10,%esp
80105b95:	85 c0                	test   %eax,%eax
80105b97:	78 77                	js     80105c10 <sys_chdir+0xa0>
80105b99:	83 ec 0c             	sub    $0xc,%esp
80105b9c:	ff 75 f4             	pushl  -0xc(%ebp)
80105b9f:	e8 0c c4 ff ff       	call   80101fb0 <namei>
80105ba4:	83 c4 10             	add    $0x10,%esp
80105ba7:	85 c0                	test   %eax,%eax
80105ba9:	89 c3                	mov    %eax,%ebx
80105bab:	74 63                	je     80105c10 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105bad:	83 ec 0c             	sub    $0xc,%esp
80105bb0:	50                   	push   %eax
80105bb1:	e8 9a bb ff ff       	call   80101750 <ilock>
  if(ip->type != T_DIR){
80105bb6:	83 c4 10             	add    $0x10,%esp
80105bb9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bbe:	75 30                	jne    80105bf0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105bc0:	83 ec 0c             	sub    $0xc,%esp
80105bc3:	53                   	push   %ebx
80105bc4:	e8 67 bc ff ff       	call   80101830 <iunlock>
  iput(curproc->cwd);
80105bc9:	58                   	pop    %eax
80105bca:	ff 76 58             	pushl  0x58(%esi)
80105bcd:	e8 ae bc ff ff       	call   80101880 <iput>
  end_op();
80105bd2:	e8 09 d1 ff ff       	call   80102ce0 <end_op>
  curproc->cwd = ip;
80105bd7:	89 5e 58             	mov    %ebx,0x58(%esi)
  return 0;
80105bda:	83 c4 10             	add    $0x10,%esp
80105bdd:	31 c0                	xor    %eax,%eax
}
80105bdf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105be2:	5b                   	pop    %ebx
80105be3:	5e                   	pop    %esi
80105be4:	5d                   	pop    %ebp
80105be5:	c3                   	ret    
80105be6:	8d 76 00             	lea    0x0(%esi),%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105bf0:	83 ec 0c             	sub    $0xc,%esp
80105bf3:	53                   	push   %ebx
80105bf4:	e8 e7 bd ff ff       	call   801019e0 <iunlockput>
    end_op();
80105bf9:	e8 e2 d0 ff ff       	call   80102ce0 <end_op>
    return -1;
80105bfe:	83 c4 10             	add    $0x10,%esp
80105c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c06:	eb d7                	jmp    80105bdf <sys_chdir+0x6f>
80105c08:	90                   	nop
80105c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105c10:	e8 cb d0 ff ff       	call   80102ce0 <end_op>
    return -1;
80105c15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c1a:	eb c3                	jmp    80105bdf <sys_chdir+0x6f>
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <sys_exec>:

int
sys_exec(void)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	57                   	push   %edi
80105c24:	56                   	push   %esi
80105c25:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c26:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105c2c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c32:	50                   	push   %eax
80105c33:	6a 00                	push   $0x0
80105c35:	e8 26 f5 ff ff       	call   80105160 <argstr>
80105c3a:	83 c4 10             	add    $0x10,%esp
80105c3d:	85 c0                	test   %eax,%eax
80105c3f:	0f 88 87 00 00 00    	js     80105ccc <sys_exec+0xac>
80105c45:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c4b:	83 ec 08             	sub    $0x8,%esp
80105c4e:	50                   	push   %eax
80105c4f:	6a 01                	push   $0x1
80105c51:	e8 5a f4 ff ff       	call   801050b0 <argint>
80105c56:	83 c4 10             	add    $0x10,%esp
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	78 6f                	js     80105ccc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c5d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c63:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105c66:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105c68:	68 80 00 00 00       	push   $0x80
80105c6d:	6a 00                	push   $0x0
80105c6f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c75:	50                   	push   %eax
80105c76:	e8 35 f1 ff ff       	call   80104db0 <memset>
80105c7b:	83 c4 10             	add    $0x10,%esp
80105c7e:	eb 2c                	jmp    80105cac <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105c80:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c86:	85 c0                	test   %eax,%eax
80105c88:	74 56                	je     80105ce0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c8a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c90:	83 ec 08             	sub    $0x8,%esp
80105c93:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c96:	52                   	push   %edx
80105c97:	50                   	push   %eax
80105c98:	e8 a3 f3 ff ff       	call   80105040 <fetchstr>
80105c9d:	83 c4 10             	add    $0x10,%esp
80105ca0:	85 c0                	test   %eax,%eax
80105ca2:	78 28                	js     80105ccc <sys_exec+0xac>
  for(i=0;; i++){
80105ca4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105ca7:	83 fb 20             	cmp    $0x20,%ebx
80105caa:	74 20                	je     80105ccc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105cac:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105cb2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105cb9:	83 ec 08             	sub    $0x8,%esp
80105cbc:	57                   	push   %edi
80105cbd:	01 f0                	add    %esi,%eax
80105cbf:	50                   	push   %eax
80105cc0:	e8 3b f3 ff ff       	call   80105000 <fetchint>
80105cc5:	83 c4 10             	add    $0x10,%esp
80105cc8:	85 c0                	test   %eax,%eax
80105cca:	79 b4                	jns    80105c80 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105ccc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cd4:	5b                   	pop    %ebx
80105cd5:	5e                   	pop    %esi
80105cd6:	5f                   	pop    %edi
80105cd7:	5d                   	pop    %ebp
80105cd8:	c3                   	ret    
80105cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ce0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105ce6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105ce9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105cf0:	00 00 00 00 
  return exec(path, argv);
80105cf4:	50                   	push   %eax
80105cf5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105cfb:	e8 10 ad ff ff       	call   80100a10 <exec>
80105d00:	83 c4 10             	add    $0x10,%esp
}
80105d03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d06:	5b                   	pop    %ebx
80105d07:	5e                   	pop    %esi
80105d08:	5f                   	pop    %edi
80105d09:	5d                   	pop    %ebp
80105d0a:	c3                   	ret    
80105d0b:	90                   	nop
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d10 <sys_pipe>:

int
sys_pipe(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
80105d15:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d16:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105d19:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d1c:	6a 08                	push   $0x8
80105d1e:	50                   	push   %eax
80105d1f:	6a 00                	push   $0x0
80105d21:	e8 da f3 ff ff       	call   80105100 <argptr>
80105d26:	83 c4 10             	add    $0x10,%esp
80105d29:	85 c0                	test   %eax,%eax
80105d2b:	0f 88 ae 00 00 00    	js     80105ddf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105d31:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d34:	83 ec 08             	sub    $0x8,%esp
80105d37:	50                   	push   %eax
80105d38:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d3b:	50                   	push   %eax
80105d3c:	e8 cf d5 ff ff       	call   80103310 <pipealloc>
80105d41:	83 c4 10             	add    $0x10,%esp
80105d44:	85 c0                	test   %eax,%eax
80105d46:	0f 88 93 00 00 00    	js     80105ddf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d4c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105d4f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d51:	e8 0a dc ff ff       	call   80103960 <myproc>
80105d56:	eb 10                	jmp    80105d68 <sys_pipe+0x58>
80105d58:	90                   	nop
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105d60:	83 c3 01             	add    $0x1,%ebx
80105d63:	83 fb 10             	cmp    $0x10,%ebx
80105d66:	74 60                	je     80105dc8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105d68:	8b 74 98 18          	mov    0x18(%eax,%ebx,4),%esi
80105d6c:	85 f6                	test   %esi,%esi
80105d6e:	75 f0                	jne    80105d60 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105d70:	8d 73 04             	lea    0x4(%ebx),%esi
80105d73:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105d7a:	e8 e1 db ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d7f:	31 d2                	xor    %edx,%edx
80105d81:	eb 0d                	jmp    80105d90 <sys_pipe+0x80>
80105d83:	90                   	nop
80105d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d88:	83 c2 01             	add    $0x1,%edx
80105d8b:	83 fa 10             	cmp    $0x10,%edx
80105d8e:	74 28                	je     80105db8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105d90:	8b 4c 90 18          	mov    0x18(%eax,%edx,4),%ecx
80105d94:	85 c9                	test   %ecx,%ecx
80105d96:	75 f0                	jne    80105d88 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105d98:	89 7c 90 18          	mov    %edi,0x18(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105d9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d9f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105da1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105da4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105da7:	31 c0                	xor    %eax,%eax
}
80105da9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dac:	5b                   	pop    %ebx
80105dad:	5e                   	pop    %esi
80105dae:	5f                   	pop    %edi
80105daf:	5d                   	pop    %ebp
80105db0:	c3                   	ret    
80105db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105db8:	e8 a3 db ff ff       	call   80103960 <myproc>
80105dbd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105dc4:	00 
80105dc5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105dc8:	83 ec 0c             	sub    $0xc,%esp
80105dcb:	ff 75 e0             	pushl  -0x20(%ebp)
80105dce:	e8 2d b1 ff ff       	call   80100f00 <fileclose>
    fileclose(wf);
80105dd3:	58                   	pop    %eax
80105dd4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105dd7:	e8 24 b1 ff ff       	call   80100f00 <fileclose>
    return -1;
80105ddc:	83 c4 10             	add    $0x10,%esp
80105ddf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105de4:	eb c3                	jmp    80105da9 <sys_pipe+0x99>
80105de6:	66 90                	xchg   %ax,%ax
80105de8:	66 90                	xchg   %ax,%ax
80105dea:	66 90                	xchg   %ax,%ax
80105dec:	66 90                	xchg   %ax,%ax
80105dee:	66 90                	xchg   %ax,%ax

80105df0 <sys_fork>:
#include "proc.h"
#include "kthread.h"

int
sys_fork(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105df3:	5d                   	pop    %ebp
  return fork();
80105df4:	e9 77 dd ff ff       	jmp    80103b70 <fork>
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e00 <sys_exit>:

int
sys_exit(void)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	83 ec 08             	sub    $0x8,%esp
  exit();
80105e06:	e8 55 e0 ff ff       	call   80103e60 <exit>
  return 0;  // not reached
}
80105e0b:	31 c0                	xor    %eax,%eax
80105e0d:	c9                   	leave  
80105e0e:	c3                   	ret    
80105e0f:	90                   	nop

80105e10 <sys_wait>:

int
sys_wait(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105e13:	5d                   	pop    %ebp
  return wait();
80105e14:	e9 e7 e2 ff ff       	jmp    80104100 <wait>
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e20 <sys_kill>:

int
sys_kill(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105e26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e29:	50                   	push   %eax
80105e2a:	6a 00                	push   $0x0
80105e2c:	e8 7f f2 ff ff       	call   801050b0 <argint>
80105e31:	83 c4 10             	add    $0x10,%esp
80105e34:	85 c0                	test   %eax,%eax
80105e36:	78 18                	js     80105e50 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105e38:	83 ec 0c             	sub    $0xc,%esp
80105e3b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e3e:	e8 9d e4 ff ff       	call   801042e0 <kill>
80105e43:	83 c4 10             	add    $0x10,%esp
}
80105e46:	c9                   	leave  
80105e47:	c3                   	ret    
80105e48:	90                   	nop
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e55:	c9                   	leave  
80105e56:	c3                   	ret    
80105e57:	89 f6                	mov    %esi,%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e60 <sys_getpid>:

int
sys_getpid(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105e66:	e8 f5 da ff ff       	call   80103960 <myproc>
80105e6b:	8b 40 0c             	mov    0xc(%eax),%eax
}
80105e6e:	c9                   	leave  
80105e6f:	c3                   	ret    

80105e70 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105e74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e7a:	50                   	push   %eax
80105e7b:	6a 00                	push   $0x0
80105e7d:	e8 2e f2 ff ff       	call   801050b0 <argint>
80105e82:	83 c4 10             	add    $0x10,%esp
80105e85:	85 c0                	test   %eax,%eax
80105e87:	78 27                	js     80105eb0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105e89:	e8 d2 da ff ff       	call   80103960 <myproc>
  if(growproc(n) < 0)
80105e8e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105e91:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e93:	ff 75 f4             	pushl  -0xc(%ebp)
80105e96:	e8 25 dc ff ff       	call   80103ac0 <growproc>
80105e9b:	83 c4 10             	add    $0x10,%esp
80105e9e:	85 c0                	test   %eax,%eax
80105ea0:	78 0e                	js     80105eb0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105ea2:	89 d8                	mov    %ebx,%eax
80105ea4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ea7:	c9                   	leave  
80105ea8:	c3                   	ret    
80105ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105eb0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105eb5:	eb eb                	jmp    80105ea2 <sys_sbrk+0x32>
80105eb7:	89 f6                	mov    %esi,%esi
80105eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ec0 <sys_sleep>:

int
sys_sleep(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105ec4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ec7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105eca:	50                   	push   %eax
80105ecb:	6a 00                	push   $0x0
80105ecd:	e8 de f1 ff ff       	call   801050b0 <argint>
80105ed2:	83 c4 10             	add    $0x10,%esp
80105ed5:	85 c0                	test   %eax,%eax
80105ed7:	0f 88 8a 00 00 00    	js     80105f67 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105edd:	83 ec 0c             	sub    $0xc,%esp
80105ee0:	68 e0 fa 11 80       	push   $0x8011fae0
80105ee5:	e8 b6 ed ff ff       	call   80104ca0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105eea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105eed:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105ef0:	8b 1d 20 03 12 80    	mov    0x80120320,%ebx
  while(ticks - ticks0 < n){
80105ef6:	85 d2                	test   %edx,%edx
80105ef8:	75 27                	jne    80105f21 <sys_sleep+0x61>
80105efa:	eb 54                	jmp    80105f50 <sys_sleep+0x90>
80105efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105f00:	83 ec 08             	sub    $0x8,%esp
80105f03:	68 e0 fa 11 80       	push   $0x8011fae0
80105f08:	68 20 03 12 80       	push   $0x80120320
80105f0d:	e8 2e e1 ff ff       	call   80104040 <sleep>
  while(ticks - ticks0 < n){
80105f12:	a1 20 03 12 80       	mov    0x80120320,%eax
80105f17:	83 c4 10             	add    $0x10,%esp
80105f1a:	29 d8                	sub    %ebx,%eax
80105f1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f1f:	73 2f                	jae    80105f50 <sys_sleep+0x90>
    if(myproc()->killed){
80105f21:	e8 3a da ff ff       	call   80103960 <myproc>
80105f26:	8b 40 14             	mov    0x14(%eax),%eax
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	74 d3                	je     80105f00 <sys_sleep+0x40>
      release(&tickslock);
80105f2d:	83 ec 0c             	sub    $0xc,%esp
80105f30:	68 e0 fa 11 80       	push   $0x8011fae0
80105f35:	e8 26 ee ff ff       	call   80104d60 <release>
      return -1;
80105f3a:	83 c4 10             	add    $0x10,%esp
80105f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105f42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f45:	c9                   	leave  
80105f46:	c3                   	ret    
80105f47:	89 f6                	mov    %esi,%esi
80105f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105f50:	83 ec 0c             	sub    $0xc,%esp
80105f53:	68 e0 fa 11 80       	push   $0x8011fae0
80105f58:	e8 03 ee ff ff       	call   80104d60 <release>
  return 0;
80105f5d:	83 c4 10             	add    $0x10,%esp
80105f60:	31 c0                	xor    %eax,%eax
}
80105f62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f65:	c9                   	leave  
80105f66:	c3                   	ret    
    return -1;
80105f67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f6c:	eb f4                	jmp    80105f62 <sys_sleep+0xa2>
80105f6e:	66 90                	xchg   %ax,%ax

80105f70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f70:	55                   	push   %ebp
80105f71:	89 e5                	mov    %esp,%ebp
80105f73:	53                   	push   %ebx
80105f74:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105f77:	68 e0 fa 11 80       	push   $0x8011fae0
80105f7c:	e8 1f ed ff ff       	call   80104ca0 <acquire>
  xticks = ticks;
80105f81:	8b 1d 20 03 12 80    	mov    0x80120320,%ebx
  release(&tickslock);
80105f87:	c7 04 24 e0 fa 11 80 	movl   $0x8011fae0,(%esp)
80105f8e:	e8 cd ed ff ff       	call   80104d60 <release>
  return xticks;
}
80105f93:	89 d8                	mov    %ebx,%eax
80105f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f98:	c9                   	leave  
80105f99:	c3                   	ret    
80105f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105fa0 <sys_kthread_exit>:

int
sys_kthread_exit(void)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	83 ec 08             	sub    $0x8,%esp
  kthread_exit();
80105fa6:	e8 25 e6 ff ff       	call   801045d0 <kthread_exit>
  return 0;  // not reached
}
80105fab:	31 c0                	xor    %eax,%eax
80105fad:	c9                   	leave  
80105fae:	c3                   	ret    
80105faf:	90                   	nop

80105fb0 <sys_kthread_create>:

int
sys_kthread_create(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	83 ec 1c             	sub    $0x1c,%esp
  void* start_func;
  void* stack;

  if ((argptr(0, (char**)(&start_func), sizeof(int)) < 0) || (argptr(1, (char**)(&stack), sizeof(int)) < 0))
80105fb6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fb9:	6a 04                	push   $0x4
80105fbb:	50                   	push   %eax
80105fbc:	6a 00                	push   $0x0
80105fbe:	e8 3d f1 ff ff       	call   80105100 <argptr>
80105fc3:	83 c4 10             	add    $0x10,%esp
80105fc6:	85 c0                	test   %eax,%eax
80105fc8:	78 2e                	js     80105ff8 <sys_kthread_create+0x48>
80105fca:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fcd:	83 ec 04             	sub    $0x4,%esp
80105fd0:	6a 04                	push   $0x4
80105fd2:	50                   	push   %eax
80105fd3:	6a 01                	push   $0x1
80105fd5:	e8 26 f1 ff ff       	call   80105100 <argptr>
80105fda:	83 c4 10             	add    $0x10,%esp
80105fdd:	85 c0                	test   %eax,%eax
80105fdf:	78 17                	js     80105ff8 <sys_kthread_create+0x48>
    return -1;
  return kthread_create(start_func,stack);
80105fe1:	83 ec 08             	sub    $0x8,%esp
80105fe4:	ff 75 f4             	pushl  -0xc(%ebp)
80105fe7:	ff 75 f0             	pushl  -0x10(%ebp)
80105fea:	e8 c1 e4 ff ff       	call   801044b0 <kthread_create>
80105fef:	83 c4 10             	add    $0x10,%esp
}
80105ff2:	c9                   	leave  
80105ff3:	c3                   	ret    
80105ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ff8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ffd:	c9                   	leave  
80105ffe:	c3                   	ret    
80105fff:	90                   	nop

80106000 <sys_kthread_id>:

int
sys_kthread_id(void)
{
80106000:	55                   	push   %ebp
80106001:	89 e5                	mov    %esp,%ebp
  return kthread_id();
}
80106003:	5d                   	pop    %ebp
  return kthread_id();
80106004:	e9 b7 e5 ff ff       	jmp    801045c0 <kthread_id>
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106010 <sys_kthread_join>:

int
sys_kthread_join(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 20             	sub    $0x20,%esp
  int n;

  if(argint(0, &n) < 0)
80106016:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106019:	50                   	push   %eax
8010601a:	6a 00                	push   $0x0
8010601c:	e8 8f f0 ff ff       	call   801050b0 <argint>
80106021:	83 c4 10             	add    $0x10,%esp
80106024:	85 c0                	test   %eax,%eax
80106026:	78 18                	js     80106040 <sys_kthread_join+0x30>
    return -1;
  return kthread_join(n);
80106028:	83 ec 0c             	sub    $0xc,%esp
8010602b:	ff 75 f4             	pushl  -0xc(%ebp)
8010602e:	e8 7d e6 ff ff       	call   801046b0 <kthread_join>
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

80106050 <sys_kthread_mutex_alloc>:

int
sys_kthread_mutex_alloc(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
  return kthread_mutex_alloc();
}
80106053:	5d                   	pop    %ebp
  return kthread_mutex_alloc();
80106054:	e9 37 e7 ff ff       	jmp    80104790 <kthread_mutex_alloc>
80106059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106060 <sys_kthread_mutex_dealloc>:

int
sys_kthread_mutex_dealloc(void)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	83 ec 20             	sub    $0x20,%esp
  int mid;

  if(argint(0, &mid) < 0)
80106066:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106069:	50                   	push   %eax
8010606a:	6a 00                	push   $0x0
8010606c:	e8 3f f0 ff ff       	call   801050b0 <argint>
80106071:	83 c4 10             	add    $0x10,%esp
80106074:	85 c0                	test   %eax,%eax
80106076:	78 18                	js     80106090 <sys_kthread_mutex_dealloc+0x30>
    return -1;
  return kthread_mutex_dealloc(mid);
80106078:	83 ec 0c             	sub    $0xc,%esp
8010607b:	ff 75 f4             	pushl  -0xc(%ebp)
8010607e:	e8 7d e7 ff ff       	call   80104800 <kthread_mutex_dealloc>
80106083:	83 c4 10             	add    $0x10,%esp
}
80106086:	c9                   	leave  
80106087:	c3                   	ret    
80106088:	90                   	nop
80106089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106095:	c9                   	leave  
80106096:	c3                   	ret    
80106097:	89 f6                	mov    %esi,%esi
80106099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060a0 <sys_kthread_mutex_lock>:

int
sys_kthread_mutex_lock(void)
{
801060a0:	55                   	push   %ebp
801060a1:	89 e5                	mov    %esp,%ebp
801060a3:	83 ec 20             	sub    $0x20,%esp
  int mid;

  if(argint(0, &mid) < 0)
801060a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060a9:	50                   	push   %eax
801060aa:	6a 00                	push   $0x0
801060ac:	e8 ff ef ff ff       	call   801050b0 <argint>
801060b1:	83 c4 10             	add    $0x10,%esp
801060b4:	85 c0                	test   %eax,%eax
801060b6:	78 18                	js     801060d0 <sys_kthread_mutex_lock+0x30>
    return -1;
  return kthread_mutex_lock(mid);
801060b8:	83 ec 0c             	sub    $0xc,%esp
801060bb:	ff 75 f4             	pushl  -0xc(%ebp)
801060be:	e8 cd e7 ff ff       	call   80104890 <kthread_mutex_lock>
801060c3:	83 c4 10             	add    $0x10,%esp
}
801060c6:	c9                   	leave  
801060c7:	c3                   	ret    
801060c8:	90                   	nop
801060c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060d5:	c9                   	leave  
801060d6:	c3                   	ret    
801060d7:	89 f6                	mov    %esi,%esi
801060d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060e0 <sys_kthread_mutex_unlock>:

int
sys_kthread_mutex_unlock(void)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	83 ec 20             	sub    $0x20,%esp
  int mid;

  if(argint(0, &mid) < 0)
801060e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060e9:	50                   	push   %eax
801060ea:	6a 00                	push   $0x0
801060ec:	e8 bf ef ff ff       	call   801050b0 <argint>
801060f1:	83 c4 10             	add    $0x10,%esp
801060f4:	85 c0                	test   %eax,%eax
801060f6:	78 18                	js     80106110 <sys_kthread_mutex_unlock+0x30>
    return -1;
  return kthread_mutex_unlock(mid);
801060f8:	83 ec 0c             	sub    $0xc,%esp
801060fb:	ff 75 f4             	pushl  -0xc(%ebp)
801060fe:	e8 7d e8 ff ff       	call   80104980 <kthread_mutex_unlock>
80106103:	83 c4 10             	add    $0x10,%esp
}
80106106:	c9                   	leave  
80106107:	c3                   	ret    
80106108:	90                   	nop
80106109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106115:	c9                   	leave  
80106116:	c3                   	ret    

80106117 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106117:	1e                   	push   %ds
  pushl %es
80106118:	06                   	push   %es
  pushl %fs
80106119:	0f a0                	push   %fs
  pushl %gs
8010611b:	0f a8                	push   %gs
  pushal
8010611d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010611e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106122:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106124:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106126:	54                   	push   %esp
  call trap
80106127:	e8 c4 00 00 00       	call   801061f0 <trap>
  addl $4, %esp
8010612c:	83 c4 04             	add    $0x4,%esp

8010612f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010612f:	61                   	popa   
  popl %gs
80106130:	0f a9                	pop    %gs
  popl %fs
80106132:	0f a1                	pop    %fs
  popl %es
80106134:	07                   	pop    %es
  popl %ds
80106135:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106136:	83 c4 08             	add    $0x8,%esp
  iret
80106139:	cf                   	iret   
8010613a:	66 90                	xchg   %ax,%ax
8010613c:	66 90                	xchg   %ax,%ax
8010613e:	66 90                	xchg   %ax,%ax

80106140 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106140:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106141:	31 c0                	xor    %eax,%eax
{
80106143:	89 e5                	mov    %esp,%ebp
80106145:	83 ec 08             	sub    $0x8,%esp
80106148:	90                   	nop
80106149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106150:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106157:	c7 04 c5 22 fb 11 80 	movl   $0x8e000008,-0x7fee04de(,%eax,8)
8010615e:	08 00 00 8e 
80106162:	66 89 14 c5 20 fb 11 	mov    %dx,-0x7fee04e0(,%eax,8)
80106169:	80 
8010616a:	c1 ea 10             	shr    $0x10,%edx
8010616d:	66 89 14 c5 26 fb 11 	mov    %dx,-0x7fee04da(,%eax,8)
80106174:	80 
  for(i = 0; i < 256; i++)
80106175:	83 c0 01             	add    $0x1,%eax
80106178:	3d 00 01 00 00       	cmp    $0x100,%eax
8010617d:	75 d1                	jne    80106150 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010617f:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
80106184:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106187:	c7 05 22 fd 11 80 08 	movl   $0xef000008,0x8011fd22
8010618e:	00 00 ef 
  initlock(&tickslock, "time");
80106191:	68 19 83 10 80       	push   $0x80108319
80106196:	68 e0 fa 11 80       	push   $0x8011fae0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010619b:	66 a3 20 fd 11 80    	mov    %ax,0x8011fd20
801061a1:	c1 e8 10             	shr    $0x10,%eax
801061a4:	66 a3 26 fd 11 80    	mov    %ax,0x8011fd26
  initlock(&tickslock, "time");
801061aa:	e8 b1 e9 ff ff       	call   80104b60 <initlock>
}
801061af:	83 c4 10             	add    $0x10,%esp
801061b2:	c9                   	leave  
801061b3:	c3                   	ret    
801061b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801061ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801061c0 <idtinit>:

void
idtinit(void)
{
801061c0:	55                   	push   %ebp
  pd[0] = size-1;
801061c1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801061c6:	89 e5                	mov    %esp,%ebp
801061c8:	83 ec 10             	sub    $0x10,%esp
801061cb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801061cf:	b8 20 fb 11 80       	mov    $0x8011fb20,%eax
801061d4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801061d8:	c1 e8 10             	shr    $0x10,%eax
801061db:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801061df:	8d 45 fa             	lea    -0x6(%ebp),%eax
801061e2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801061e5:	c9                   	leave  
801061e6:	c3                   	ret    
801061e7:	89 f6                	mov    %esi,%esi
801061e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061f0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	57                   	push   %edi
801061f4:	56                   	push   %esi
801061f5:	53                   	push   %ebx
801061f6:	83 ec 1c             	sub    $0x1c,%esp
801061f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801061fc:	8b 43 30             	mov    0x30(%ebx),%eax
801061ff:	83 f8 40             	cmp    $0x40,%eax
80106202:	0f 84 e8 00 00 00    	je     801062f0 <trap+0x100>
    if(mythread()->exitRequest)
      kthread_exit();
    return;
  }

  switch(tf->trapno){
80106208:	83 e8 20             	sub    $0x20,%eax
8010620b:	83 f8 1f             	cmp    $0x1f,%eax
8010620e:	0f 87 04 02 00 00    	ja     80106418 <trap+0x228>
80106214:	ff 24 85 c0 83 10 80 	jmp    *-0x7fef7c40(,%eax,4)
8010621b:	90                   	nop
8010621c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106220:	e8 1b d7 ff ff       	call   80103940 <cpuid>
80106225:	85 c0                	test   %eax,%eax
80106227:	0f 84 cb 02 00 00    	je     801064f8 <trap+0x308>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
8010622d:	e8 ee c5 ff ff       	call   80102820 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106232:	e8 29 d7 ff ff       	call   80103960 <myproc>
80106237:	85 c0                	test   %eax,%eax
80106239:	74 1d                	je     80106258 <trap+0x68>
8010623b:	e8 20 d7 ff ff       	call   80103960 <myproc>
80106240:	8b 70 14             	mov    0x14(%eax),%esi
80106243:	85 f6                	test   %esi,%esi
80106245:	74 11                	je     80106258 <trap+0x68>
80106247:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010624b:	83 e0 03             	and    $0x3,%eax
8010624e:	66 83 f8 03          	cmp    $0x3,%ax
80106252:	0f 84 90 02 00 00    	je     801064e8 <trap+0x2f8>
    exit();
  if(mythread() && mythread()->exitRequest && (tf->cs&3) == DPL_USER)
80106258:	e8 33 d7 ff ff       	call   80103990 <mythread>
8010625d:	85 c0                	test   %eax,%eax
8010625f:	74 1d                	je     8010627e <trap+0x8e>
80106261:	e8 2a d7 ff ff       	call   80103990 <mythread>
80106266:	8b 48 20             	mov    0x20(%eax),%ecx
80106269:	85 c9                	test   %ecx,%ecx
8010626b:	74 11                	je     8010627e <trap+0x8e>
8010626d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106271:	83 e0 03             	and    $0x3,%eax
80106274:	66 83 f8 03          	cmp    $0x3,%ax
80106278:	0f 84 5a 02 00 00    	je     801064d8 <trap+0x2e8>
    kthread_exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(mythread() && mythread()->state == RUNNING &&
8010627e:	e8 0d d7 ff ff       	call   80103990 <mythread>
80106283:	85 c0                	test   %eax,%eax
80106285:	74 0f                	je     80106296 <trap+0xa6>
80106287:	e8 04 d7 ff ff       	call   80103990 <mythread>
8010628c:	83 78 08 03          	cmpl   $0x3,0x8(%eax)
80106290:	0f 84 b2 00 00 00    	je     80106348 <trap+0x158>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106296:	e8 c5 d6 ff ff       	call   80103960 <myproc>
8010629b:	85 c0                	test   %eax,%eax
8010629d:	74 1d                	je     801062bc <trap+0xcc>
8010629f:	e8 bc d6 ff ff       	call   80103960 <myproc>
801062a4:	8b 50 14             	mov    0x14(%eax),%edx
801062a7:	85 d2                	test   %edx,%edx
801062a9:	74 11                	je     801062bc <trap+0xcc>
801062ab:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801062af:	83 e0 03             	and    $0x3,%eax
801062b2:	66 83 f8 03          	cmp    $0x3,%ax
801062b6:	0f 84 0c 02 00 00    	je     801064c8 <trap+0x2d8>
    exit();
  if(mythread() && mythread()->exitRequest && (tf->cs&3) == DPL_USER)
801062bc:	e8 cf d6 ff ff       	call   80103990 <mythread>
801062c1:	85 c0                	test   %eax,%eax
801062c3:	74 19                	je     801062de <trap+0xee>
801062c5:	e8 c6 d6 ff ff       	call   80103990 <mythread>
801062ca:	8b 40 20             	mov    0x20(%eax),%eax
801062cd:	85 c0                	test   %eax,%eax
801062cf:	74 0d                	je     801062de <trap+0xee>
801062d1:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801062d5:	83 e0 03             	and    $0x3,%eax
801062d8:	66 83 f8 03          	cmp    $0x3,%ax
801062dc:	74 5b                	je     80106339 <trap+0x149>
    kthread_exit();
}
801062de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062e1:	5b                   	pop    %ebx
801062e2:	5e                   	pop    %esi
801062e3:	5f                   	pop    %edi
801062e4:	5d                   	pop    %ebp
801062e5:	c3                   	ret    
801062e6:	8d 76 00             	lea    0x0(%esi),%esi
801062e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(myproc()->killed)
801062f0:	e8 6b d6 ff ff       	call   80103960 <myproc>
801062f5:	8b 40 14             	mov    0x14(%eax),%eax
801062f8:	85 c0                	test   %eax,%eax
801062fa:	0f 85 08 01 00 00    	jne    80106408 <trap+0x218>
    if(mythread()->exitRequest)
80106300:	e8 8b d6 ff ff       	call   80103990 <mythread>
80106305:	8b 40 20             	mov    0x20(%eax),%eax
80106308:	85 c0                	test   %eax,%eax
8010630a:	0f 85 e8 00 00 00    	jne    801063f8 <trap+0x208>
    mythread()->tf = tf;
80106310:	e8 7b d6 ff ff       	call   80103990 <mythread>
80106315:	89 58 14             	mov    %ebx,0x14(%eax)
    syscall();
80106318:	e8 83 ee ff ff       	call   801051a0 <syscall>
    if(myproc()->killed)
8010631d:	e8 3e d6 ff ff       	call   80103960 <myproc>
80106322:	8b 40 14             	mov    0x14(%eax),%eax
80106325:	85 c0                	test   %eax,%eax
80106327:	0f 85 bb 00 00 00    	jne    801063e8 <trap+0x1f8>
    if(mythread()->exitRequest)
8010632d:	e8 5e d6 ff ff       	call   80103990 <mythread>
80106332:	8b 78 20             	mov    0x20(%eax),%edi
80106335:	85 ff                	test   %edi,%edi
80106337:	74 a5                	je     801062de <trap+0xee>
}
80106339:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010633c:	5b                   	pop    %ebx
8010633d:	5e                   	pop    %esi
8010633e:	5f                   	pop    %edi
8010633f:	5d                   	pop    %ebp
      kthread_exit();
80106340:	e9 8b e2 ff ff       	jmp    801045d0 <kthread_exit>
80106345:	8d 76 00             	lea    0x0(%esi),%esi
  if(mythread() && mythread()->state == RUNNING &&
80106348:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010634c:	0f 85 44 ff ff ff    	jne    80106296 <trap+0xa6>
    yield();
80106352:	e8 99 dc ff ff       	call   80103ff0 <yield>
80106357:	e9 3a ff ff ff       	jmp    80106296 <trap+0xa6>
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106360:	e8 7b c3 ff ff       	call   801026e0 <kbdintr>
    lapiceoi();
80106365:	e8 b6 c4 ff ff       	call   80102820 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010636a:	e8 f1 d5 ff ff       	call   80103960 <myproc>
8010636f:	85 c0                	test   %eax,%eax
80106371:	0f 85 c4 fe ff ff    	jne    8010623b <trap+0x4b>
80106377:	e9 dc fe ff ff       	jmp    80106258 <trap+0x68>
8010637c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106380:	e8 4b 03 00 00       	call   801066d0 <uartintr>
    lapiceoi();
80106385:	e8 96 c4 ff ff       	call   80102820 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010638a:	e8 d1 d5 ff ff       	call   80103960 <myproc>
8010638f:	85 c0                	test   %eax,%eax
80106391:	0f 85 a4 fe ff ff    	jne    8010623b <trap+0x4b>
80106397:	e9 bc fe ff ff       	jmp    80106258 <trap+0x68>
8010639c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801063a0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801063a4:	8b 7b 38             	mov    0x38(%ebx),%edi
801063a7:	e8 94 d5 ff ff       	call   80103940 <cpuid>
801063ac:	57                   	push   %edi
801063ad:	56                   	push   %esi
801063ae:	50                   	push   %eax
801063af:	68 24 83 10 80       	push   $0x80108324
801063b4:	e8 a7 a2 ff ff       	call   80100660 <cprintf>
    lapiceoi();
801063b9:	e8 62 c4 ff ff       	call   80102820 <lapiceoi>
    break;
801063be:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801063c1:	e8 9a d5 ff ff       	call   80103960 <myproc>
801063c6:	85 c0                	test   %eax,%eax
801063c8:	0f 85 6d fe ff ff    	jne    8010623b <trap+0x4b>
801063ce:	e9 85 fe ff ff       	jmp    80106258 <trap+0x68>
801063d3:	90                   	nop
801063d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801063d8:	e8 73 bd ff ff       	call   80102150 <ideintr>
801063dd:	e9 4b fe ff ff       	jmp    8010622d <trap+0x3d>
801063e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801063e8:	e8 73 da ff ff       	call   80103e60 <exit>
801063ed:	e9 3b ff ff ff       	jmp    8010632d <trap+0x13d>
801063f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kthread_exit();
801063f8:	e8 d3 e1 ff ff       	call   801045d0 <kthread_exit>
801063fd:	e9 0e ff ff ff       	jmp    80106310 <trap+0x120>
80106402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106408:	e8 53 da ff ff       	call   80103e60 <exit>
8010640d:	e9 ee fe ff ff       	jmp    80106300 <trap+0x110>
80106412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106418:	e8 43 d5 ff ff       	call   80103960 <myproc>
8010641d:	85 c0                	test   %eax,%eax
8010641f:	8b 7b 38             	mov    0x38(%ebx),%edi
80106422:	0f 84 04 01 00 00    	je     8010652c <trap+0x33c>
80106428:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010642c:	0f 84 fa 00 00 00    	je     8010652c <trap+0x33c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106432:	0f 20 d1             	mov    %cr2,%ecx
80106435:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106438:	e8 03 d5 ff ff       	call   80103940 <cpuid>
8010643d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106440:	8b 43 34             	mov    0x34(%ebx),%eax
80106443:	8b 73 30             	mov    0x30(%ebx),%esi
80106446:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106449:	e8 12 d5 ff ff       	call   80103960 <myproc>
8010644e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106451:	e8 0a d5 ff ff       	call   80103960 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106456:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106459:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010645c:	51                   	push   %ecx
8010645d:	57                   	push   %edi
8010645e:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
8010645f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106462:	ff 75 e4             	pushl  -0x1c(%ebp)
80106465:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106466:	83 c2 5c             	add    $0x5c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106469:	52                   	push   %edx
8010646a:	ff 70 0c             	pushl  0xc(%eax)
8010646d:	68 7c 83 10 80       	push   $0x8010837c
80106472:	e8 e9 a1 ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
80106477:	83 c4 20             	add    $0x20,%esp
8010647a:	e8 e1 d4 ff ff       	call   80103960 <myproc>
8010647f:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    for(t = myproc()->threads ; t < &myproc()->threads[NTHREAD] ; t++){
80106486:	e8 d5 d4 ff ff       	call   80103960 <myproc>
8010648b:	8b 70 6c             	mov    0x6c(%eax),%esi
8010648e:	eb 10                	jmp    801064a0 <trap+0x2b0>
      if(t->state == SLEEPING)
80106490:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
80106494:	75 07                	jne    8010649d <trap+0x2ad>
        t->state = RUNNABLE;
80106496:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
    for(t = myproc()->threads ; t < &myproc()->threads[NTHREAD] ; t++){
8010649d:	83 c6 24             	add    $0x24,%esi
801064a0:	e8 bb d4 ff ff       	call   80103960 <myproc>
801064a5:	8b 40 6c             	mov    0x6c(%eax),%eax
801064a8:	05 40 02 00 00       	add    $0x240,%eax
801064ad:	39 c6                	cmp    %eax,%esi
801064af:	72 df                	jb     80106490 <trap+0x2a0>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064b1:	e8 aa d4 ff ff       	call   80103960 <myproc>
801064b6:	85 c0                	test   %eax,%eax
801064b8:	0f 85 7d fd ff ff    	jne    8010623b <trap+0x4b>
801064be:	e9 95 fd ff ff       	jmp    80106258 <trap+0x68>
801064c3:	90                   	nop
801064c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
801064c8:	e8 93 d9 ff ff       	call   80103e60 <exit>
801064cd:	e9 ea fd ff ff       	jmp    801062bc <trap+0xcc>
801064d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kthread_exit();
801064d8:	e8 f3 e0 ff ff       	call   801045d0 <kthread_exit>
801064dd:	e9 9c fd ff ff       	jmp    8010627e <trap+0x8e>
801064e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801064e8:	e8 73 d9 ff ff       	call   80103e60 <exit>
801064ed:	e9 66 fd ff ff       	jmp    80106258 <trap+0x68>
801064f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801064f8:	83 ec 0c             	sub    $0xc,%esp
801064fb:	68 e0 fa 11 80       	push   $0x8011fae0
80106500:	e8 9b e7 ff ff       	call   80104ca0 <acquire>
      wakeup(&ticks);
80106505:	c7 04 24 20 03 12 80 	movl   $0x80120320,(%esp)
      ticks++;
8010650c:	83 05 20 03 12 80 01 	addl   $0x1,0x80120320
      wakeup(&ticks);
80106513:	e8 98 dd ff ff       	call   801042b0 <wakeup>
      release(&tickslock);
80106518:	c7 04 24 e0 fa 11 80 	movl   $0x8011fae0,(%esp)
8010651f:	e8 3c e8 ff ff       	call   80104d60 <release>
80106524:	83 c4 10             	add    $0x10,%esp
80106527:	e9 01 fd ff ff       	jmp    8010622d <trap+0x3d>
8010652c:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010652f:	e8 0c d4 ff ff       	call   80103940 <cpuid>
80106534:	83 ec 0c             	sub    $0xc,%esp
80106537:	56                   	push   %esi
80106538:	57                   	push   %edi
80106539:	50                   	push   %eax
8010653a:	ff 73 30             	pushl  0x30(%ebx)
8010653d:	68 48 83 10 80       	push   $0x80108348
80106542:	e8 19 a1 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106547:	83 c4 14             	add    $0x14,%esp
8010654a:	68 1e 83 10 80       	push   $0x8010831e
8010654f:	e8 3c 9e ff ff       	call   80100390 <panic>
80106554:	66 90                	xchg   %ax,%ax
80106556:	66 90                	xchg   %ax,%ax
80106558:	66 90                	xchg   %ax,%ax
8010655a:	66 90                	xchg   %ax,%ax
8010655c:	66 90                	xchg   %ax,%ax
8010655e:	66 90                	xchg   %ax,%ax

80106560 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106560:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
{
80106565:	55                   	push   %ebp
80106566:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106568:	85 c0                	test   %eax,%eax
8010656a:	74 1c                	je     80106588 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010656c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106571:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106572:	a8 01                	test   $0x1,%al
80106574:	74 12                	je     80106588 <uartgetc+0x28>
80106576:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010657b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010657c:	0f b6 c0             	movzbl %al,%eax
}
8010657f:	5d                   	pop    %ebp
80106580:	c3                   	ret    
80106581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106588:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010658d:	5d                   	pop    %ebp
8010658e:	c3                   	ret    
8010658f:	90                   	nop

80106590 <uartputc.part.0>:
uartputc(int c)
80106590:	55                   	push   %ebp
80106591:	89 e5                	mov    %esp,%ebp
80106593:	57                   	push   %edi
80106594:	56                   	push   %esi
80106595:	53                   	push   %ebx
80106596:	89 c7                	mov    %eax,%edi
80106598:	bb 80 00 00 00       	mov    $0x80,%ebx
8010659d:	be fd 03 00 00       	mov    $0x3fd,%esi
801065a2:	83 ec 0c             	sub    $0xc,%esp
801065a5:	eb 1b                	jmp    801065c2 <uartputc.part.0+0x32>
801065a7:	89 f6                	mov    %esi,%esi
801065a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801065b0:	83 ec 0c             	sub    $0xc,%esp
801065b3:	6a 0a                	push   $0xa
801065b5:	e8 86 c2 ff ff       	call   80102840 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801065ba:	83 c4 10             	add    $0x10,%esp
801065bd:	83 eb 01             	sub    $0x1,%ebx
801065c0:	74 07                	je     801065c9 <uartputc.part.0+0x39>
801065c2:	89 f2                	mov    %esi,%edx
801065c4:	ec                   	in     (%dx),%al
801065c5:	a8 20                	test   $0x20,%al
801065c7:	74 e7                	je     801065b0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801065c9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065ce:	89 f8                	mov    %edi,%eax
801065d0:	ee                   	out    %al,(%dx)
}
801065d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065d4:	5b                   	pop    %ebx
801065d5:	5e                   	pop    %esi
801065d6:	5f                   	pop    %edi
801065d7:	5d                   	pop    %ebp
801065d8:	c3                   	ret    
801065d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065e0 <uartinit>:
{
801065e0:	55                   	push   %ebp
801065e1:	31 c9                	xor    %ecx,%ecx
801065e3:	89 c8                	mov    %ecx,%eax
801065e5:	89 e5                	mov    %esp,%ebp
801065e7:	57                   	push   %edi
801065e8:	56                   	push   %esi
801065e9:	53                   	push   %ebx
801065ea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801065ef:	89 da                	mov    %ebx,%edx
801065f1:	83 ec 0c             	sub    $0xc,%esp
801065f4:	ee                   	out    %al,(%dx)
801065f5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801065fa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801065ff:	89 fa                	mov    %edi,%edx
80106601:	ee                   	out    %al,(%dx)
80106602:	b8 0c 00 00 00       	mov    $0xc,%eax
80106607:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010660c:	ee                   	out    %al,(%dx)
8010660d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106612:	89 c8                	mov    %ecx,%eax
80106614:	89 f2                	mov    %esi,%edx
80106616:	ee                   	out    %al,(%dx)
80106617:	b8 03 00 00 00       	mov    $0x3,%eax
8010661c:	89 fa                	mov    %edi,%edx
8010661e:	ee                   	out    %al,(%dx)
8010661f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106624:	89 c8                	mov    %ecx,%eax
80106626:	ee                   	out    %al,(%dx)
80106627:	b8 01 00 00 00       	mov    $0x1,%eax
8010662c:	89 f2                	mov    %esi,%edx
8010662e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010662f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106634:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106635:	3c ff                	cmp    $0xff,%al
80106637:	74 5a                	je     80106693 <uartinit+0xb3>
  uart = 1;
80106639:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
80106640:	00 00 00 
80106643:	89 da                	mov    %ebx,%edx
80106645:	ec                   	in     (%dx),%al
80106646:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010664b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010664c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010664f:	bb 40 84 10 80       	mov    $0x80108440,%ebx
  ioapicenable(IRQ_COM1, 0);
80106654:	6a 00                	push   $0x0
80106656:	6a 04                	push   $0x4
80106658:	e8 43 bd ff ff       	call   801023a0 <ioapicenable>
8010665d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106660:	b8 78 00 00 00       	mov    $0x78,%eax
80106665:	eb 13                	jmp    8010667a <uartinit+0x9a>
80106667:	89 f6                	mov    %esi,%esi
80106669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106670:	83 c3 01             	add    $0x1,%ebx
80106673:	0f be 03             	movsbl (%ebx),%eax
80106676:	84 c0                	test   %al,%al
80106678:	74 19                	je     80106693 <uartinit+0xb3>
  if(!uart)
8010667a:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
80106680:	85 d2                	test   %edx,%edx
80106682:	74 ec                	je     80106670 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106684:	83 c3 01             	add    $0x1,%ebx
80106687:	e8 04 ff ff ff       	call   80106590 <uartputc.part.0>
8010668c:	0f be 03             	movsbl (%ebx),%eax
8010668f:	84 c0                	test   %al,%al
80106691:	75 e7                	jne    8010667a <uartinit+0x9a>
}
80106693:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106696:	5b                   	pop    %ebx
80106697:	5e                   	pop    %esi
80106698:	5f                   	pop    %edi
80106699:	5d                   	pop    %ebp
8010669a:	c3                   	ret    
8010669b:	90                   	nop
8010669c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801066a0 <uartputc>:
  if(!uart)
801066a0:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
{
801066a6:	55                   	push   %ebp
801066a7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801066a9:	85 d2                	test   %edx,%edx
{
801066ab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801066ae:	74 10                	je     801066c0 <uartputc+0x20>
}
801066b0:	5d                   	pop    %ebp
801066b1:	e9 da fe ff ff       	jmp    80106590 <uartputc.part.0>
801066b6:	8d 76 00             	lea    0x0(%esi),%esi
801066b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801066c0:	5d                   	pop    %ebp
801066c1:	c3                   	ret    
801066c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066d0 <uartintr>:

void
uartintr(void)
{
801066d0:	55                   	push   %ebp
801066d1:	89 e5                	mov    %esp,%ebp
801066d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801066d6:	68 60 65 10 80       	push   $0x80106560
801066db:	e8 30 a1 ff ff       	call   80100810 <consoleintr>
}
801066e0:	83 c4 10             	add    $0x10,%esp
801066e3:	c9                   	leave  
801066e4:	c3                   	ret    

801066e5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801066e5:	6a 00                	push   $0x0
  pushl $0
801066e7:	6a 00                	push   $0x0
  jmp alltraps
801066e9:	e9 29 fa ff ff       	jmp    80106117 <alltraps>

801066ee <vector1>:
.globl vector1
vector1:
  pushl $0
801066ee:	6a 00                	push   $0x0
  pushl $1
801066f0:	6a 01                	push   $0x1
  jmp alltraps
801066f2:	e9 20 fa ff ff       	jmp    80106117 <alltraps>

801066f7 <vector2>:
.globl vector2
vector2:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $2
801066f9:	6a 02                	push   $0x2
  jmp alltraps
801066fb:	e9 17 fa ff ff       	jmp    80106117 <alltraps>

80106700 <vector3>:
.globl vector3
vector3:
  pushl $0
80106700:	6a 00                	push   $0x0
  pushl $3
80106702:	6a 03                	push   $0x3
  jmp alltraps
80106704:	e9 0e fa ff ff       	jmp    80106117 <alltraps>

80106709 <vector4>:
.globl vector4
vector4:
  pushl $0
80106709:	6a 00                	push   $0x0
  pushl $4
8010670b:	6a 04                	push   $0x4
  jmp alltraps
8010670d:	e9 05 fa ff ff       	jmp    80106117 <alltraps>

80106712 <vector5>:
.globl vector5
vector5:
  pushl $0
80106712:	6a 00                	push   $0x0
  pushl $5
80106714:	6a 05                	push   $0x5
  jmp alltraps
80106716:	e9 fc f9 ff ff       	jmp    80106117 <alltraps>

8010671b <vector6>:
.globl vector6
vector6:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $6
8010671d:	6a 06                	push   $0x6
  jmp alltraps
8010671f:	e9 f3 f9 ff ff       	jmp    80106117 <alltraps>

80106724 <vector7>:
.globl vector7
vector7:
  pushl $0
80106724:	6a 00                	push   $0x0
  pushl $7
80106726:	6a 07                	push   $0x7
  jmp alltraps
80106728:	e9 ea f9 ff ff       	jmp    80106117 <alltraps>

8010672d <vector8>:
.globl vector8
vector8:
  pushl $8
8010672d:	6a 08                	push   $0x8
  jmp alltraps
8010672f:	e9 e3 f9 ff ff       	jmp    80106117 <alltraps>

80106734 <vector9>:
.globl vector9
vector9:
  pushl $0
80106734:	6a 00                	push   $0x0
  pushl $9
80106736:	6a 09                	push   $0x9
  jmp alltraps
80106738:	e9 da f9 ff ff       	jmp    80106117 <alltraps>

8010673d <vector10>:
.globl vector10
vector10:
  pushl $10
8010673d:	6a 0a                	push   $0xa
  jmp alltraps
8010673f:	e9 d3 f9 ff ff       	jmp    80106117 <alltraps>

80106744 <vector11>:
.globl vector11
vector11:
  pushl $11
80106744:	6a 0b                	push   $0xb
  jmp alltraps
80106746:	e9 cc f9 ff ff       	jmp    80106117 <alltraps>

8010674b <vector12>:
.globl vector12
vector12:
  pushl $12
8010674b:	6a 0c                	push   $0xc
  jmp alltraps
8010674d:	e9 c5 f9 ff ff       	jmp    80106117 <alltraps>

80106752 <vector13>:
.globl vector13
vector13:
  pushl $13
80106752:	6a 0d                	push   $0xd
  jmp alltraps
80106754:	e9 be f9 ff ff       	jmp    80106117 <alltraps>

80106759 <vector14>:
.globl vector14
vector14:
  pushl $14
80106759:	6a 0e                	push   $0xe
  jmp alltraps
8010675b:	e9 b7 f9 ff ff       	jmp    80106117 <alltraps>

80106760 <vector15>:
.globl vector15
vector15:
  pushl $0
80106760:	6a 00                	push   $0x0
  pushl $15
80106762:	6a 0f                	push   $0xf
  jmp alltraps
80106764:	e9 ae f9 ff ff       	jmp    80106117 <alltraps>

80106769 <vector16>:
.globl vector16
vector16:
  pushl $0
80106769:	6a 00                	push   $0x0
  pushl $16
8010676b:	6a 10                	push   $0x10
  jmp alltraps
8010676d:	e9 a5 f9 ff ff       	jmp    80106117 <alltraps>

80106772 <vector17>:
.globl vector17
vector17:
  pushl $17
80106772:	6a 11                	push   $0x11
  jmp alltraps
80106774:	e9 9e f9 ff ff       	jmp    80106117 <alltraps>

80106779 <vector18>:
.globl vector18
vector18:
  pushl $0
80106779:	6a 00                	push   $0x0
  pushl $18
8010677b:	6a 12                	push   $0x12
  jmp alltraps
8010677d:	e9 95 f9 ff ff       	jmp    80106117 <alltraps>

80106782 <vector19>:
.globl vector19
vector19:
  pushl $0
80106782:	6a 00                	push   $0x0
  pushl $19
80106784:	6a 13                	push   $0x13
  jmp alltraps
80106786:	e9 8c f9 ff ff       	jmp    80106117 <alltraps>

8010678b <vector20>:
.globl vector20
vector20:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $20
8010678d:	6a 14                	push   $0x14
  jmp alltraps
8010678f:	e9 83 f9 ff ff       	jmp    80106117 <alltraps>

80106794 <vector21>:
.globl vector21
vector21:
  pushl $0
80106794:	6a 00                	push   $0x0
  pushl $21
80106796:	6a 15                	push   $0x15
  jmp alltraps
80106798:	e9 7a f9 ff ff       	jmp    80106117 <alltraps>

8010679d <vector22>:
.globl vector22
vector22:
  pushl $0
8010679d:	6a 00                	push   $0x0
  pushl $22
8010679f:	6a 16                	push   $0x16
  jmp alltraps
801067a1:	e9 71 f9 ff ff       	jmp    80106117 <alltraps>

801067a6 <vector23>:
.globl vector23
vector23:
  pushl $0
801067a6:	6a 00                	push   $0x0
  pushl $23
801067a8:	6a 17                	push   $0x17
  jmp alltraps
801067aa:	e9 68 f9 ff ff       	jmp    80106117 <alltraps>

801067af <vector24>:
.globl vector24
vector24:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $24
801067b1:	6a 18                	push   $0x18
  jmp alltraps
801067b3:	e9 5f f9 ff ff       	jmp    80106117 <alltraps>

801067b8 <vector25>:
.globl vector25
vector25:
  pushl $0
801067b8:	6a 00                	push   $0x0
  pushl $25
801067ba:	6a 19                	push   $0x19
  jmp alltraps
801067bc:	e9 56 f9 ff ff       	jmp    80106117 <alltraps>

801067c1 <vector26>:
.globl vector26
vector26:
  pushl $0
801067c1:	6a 00                	push   $0x0
  pushl $26
801067c3:	6a 1a                	push   $0x1a
  jmp alltraps
801067c5:	e9 4d f9 ff ff       	jmp    80106117 <alltraps>

801067ca <vector27>:
.globl vector27
vector27:
  pushl $0
801067ca:	6a 00                	push   $0x0
  pushl $27
801067cc:	6a 1b                	push   $0x1b
  jmp alltraps
801067ce:	e9 44 f9 ff ff       	jmp    80106117 <alltraps>

801067d3 <vector28>:
.globl vector28
vector28:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $28
801067d5:	6a 1c                	push   $0x1c
  jmp alltraps
801067d7:	e9 3b f9 ff ff       	jmp    80106117 <alltraps>

801067dc <vector29>:
.globl vector29
vector29:
  pushl $0
801067dc:	6a 00                	push   $0x0
  pushl $29
801067de:	6a 1d                	push   $0x1d
  jmp alltraps
801067e0:	e9 32 f9 ff ff       	jmp    80106117 <alltraps>

801067e5 <vector30>:
.globl vector30
vector30:
  pushl $0
801067e5:	6a 00                	push   $0x0
  pushl $30
801067e7:	6a 1e                	push   $0x1e
  jmp alltraps
801067e9:	e9 29 f9 ff ff       	jmp    80106117 <alltraps>

801067ee <vector31>:
.globl vector31
vector31:
  pushl $0
801067ee:	6a 00                	push   $0x0
  pushl $31
801067f0:	6a 1f                	push   $0x1f
  jmp alltraps
801067f2:	e9 20 f9 ff ff       	jmp    80106117 <alltraps>

801067f7 <vector32>:
.globl vector32
vector32:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $32
801067f9:	6a 20                	push   $0x20
  jmp alltraps
801067fb:	e9 17 f9 ff ff       	jmp    80106117 <alltraps>

80106800 <vector33>:
.globl vector33
vector33:
  pushl $0
80106800:	6a 00                	push   $0x0
  pushl $33
80106802:	6a 21                	push   $0x21
  jmp alltraps
80106804:	e9 0e f9 ff ff       	jmp    80106117 <alltraps>

80106809 <vector34>:
.globl vector34
vector34:
  pushl $0
80106809:	6a 00                	push   $0x0
  pushl $34
8010680b:	6a 22                	push   $0x22
  jmp alltraps
8010680d:	e9 05 f9 ff ff       	jmp    80106117 <alltraps>

80106812 <vector35>:
.globl vector35
vector35:
  pushl $0
80106812:	6a 00                	push   $0x0
  pushl $35
80106814:	6a 23                	push   $0x23
  jmp alltraps
80106816:	e9 fc f8 ff ff       	jmp    80106117 <alltraps>

8010681b <vector36>:
.globl vector36
vector36:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $36
8010681d:	6a 24                	push   $0x24
  jmp alltraps
8010681f:	e9 f3 f8 ff ff       	jmp    80106117 <alltraps>

80106824 <vector37>:
.globl vector37
vector37:
  pushl $0
80106824:	6a 00                	push   $0x0
  pushl $37
80106826:	6a 25                	push   $0x25
  jmp alltraps
80106828:	e9 ea f8 ff ff       	jmp    80106117 <alltraps>

8010682d <vector38>:
.globl vector38
vector38:
  pushl $0
8010682d:	6a 00                	push   $0x0
  pushl $38
8010682f:	6a 26                	push   $0x26
  jmp alltraps
80106831:	e9 e1 f8 ff ff       	jmp    80106117 <alltraps>

80106836 <vector39>:
.globl vector39
vector39:
  pushl $0
80106836:	6a 00                	push   $0x0
  pushl $39
80106838:	6a 27                	push   $0x27
  jmp alltraps
8010683a:	e9 d8 f8 ff ff       	jmp    80106117 <alltraps>

8010683f <vector40>:
.globl vector40
vector40:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $40
80106841:	6a 28                	push   $0x28
  jmp alltraps
80106843:	e9 cf f8 ff ff       	jmp    80106117 <alltraps>

80106848 <vector41>:
.globl vector41
vector41:
  pushl $0
80106848:	6a 00                	push   $0x0
  pushl $41
8010684a:	6a 29                	push   $0x29
  jmp alltraps
8010684c:	e9 c6 f8 ff ff       	jmp    80106117 <alltraps>

80106851 <vector42>:
.globl vector42
vector42:
  pushl $0
80106851:	6a 00                	push   $0x0
  pushl $42
80106853:	6a 2a                	push   $0x2a
  jmp alltraps
80106855:	e9 bd f8 ff ff       	jmp    80106117 <alltraps>

8010685a <vector43>:
.globl vector43
vector43:
  pushl $0
8010685a:	6a 00                	push   $0x0
  pushl $43
8010685c:	6a 2b                	push   $0x2b
  jmp alltraps
8010685e:	e9 b4 f8 ff ff       	jmp    80106117 <alltraps>

80106863 <vector44>:
.globl vector44
vector44:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $44
80106865:	6a 2c                	push   $0x2c
  jmp alltraps
80106867:	e9 ab f8 ff ff       	jmp    80106117 <alltraps>

8010686c <vector45>:
.globl vector45
vector45:
  pushl $0
8010686c:	6a 00                	push   $0x0
  pushl $45
8010686e:	6a 2d                	push   $0x2d
  jmp alltraps
80106870:	e9 a2 f8 ff ff       	jmp    80106117 <alltraps>

80106875 <vector46>:
.globl vector46
vector46:
  pushl $0
80106875:	6a 00                	push   $0x0
  pushl $46
80106877:	6a 2e                	push   $0x2e
  jmp alltraps
80106879:	e9 99 f8 ff ff       	jmp    80106117 <alltraps>

8010687e <vector47>:
.globl vector47
vector47:
  pushl $0
8010687e:	6a 00                	push   $0x0
  pushl $47
80106880:	6a 2f                	push   $0x2f
  jmp alltraps
80106882:	e9 90 f8 ff ff       	jmp    80106117 <alltraps>

80106887 <vector48>:
.globl vector48
vector48:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $48
80106889:	6a 30                	push   $0x30
  jmp alltraps
8010688b:	e9 87 f8 ff ff       	jmp    80106117 <alltraps>

80106890 <vector49>:
.globl vector49
vector49:
  pushl $0
80106890:	6a 00                	push   $0x0
  pushl $49
80106892:	6a 31                	push   $0x31
  jmp alltraps
80106894:	e9 7e f8 ff ff       	jmp    80106117 <alltraps>

80106899 <vector50>:
.globl vector50
vector50:
  pushl $0
80106899:	6a 00                	push   $0x0
  pushl $50
8010689b:	6a 32                	push   $0x32
  jmp alltraps
8010689d:	e9 75 f8 ff ff       	jmp    80106117 <alltraps>

801068a2 <vector51>:
.globl vector51
vector51:
  pushl $0
801068a2:	6a 00                	push   $0x0
  pushl $51
801068a4:	6a 33                	push   $0x33
  jmp alltraps
801068a6:	e9 6c f8 ff ff       	jmp    80106117 <alltraps>

801068ab <vector52>:
.globl vector52
vector52:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $52
801068ad:	6a 34                	push   $0x34
  jmp alltraps
801068af:	e9 63 f8 ff ff       	jmp    80106117 <alltraps>

801068b4 <vector53>:
.globl vector53
vector53:
  pushl $0
801068b4:	6a 00                	push   $0x0
  pushl $53
801068b6:	6a 35                	push   $0x35
  jmp alltraps
801068b8:	e9 5a f8 ff ff       	jmp    80106117 <alltraps>

801068bd <vector54>:
.globl vector54
vector54:
  pushl $0
801068bd:	6a 00                	push   $0x0
  pushl $54
801068bf:	6a 36                	push   $0x36
  jmp alltraps
801068c1:	e9 51 f8 ff ff       	jmp    80106117 <alltraps>

801068c6 <vector55>:
.globl vector55
vector55:
  pushl $0
801068c6:	6a 00                	push   $0x0
  pushl $55
801068c8:	6a 37                	push   $0x37
  jmp alltraps
801068ca:	e9 48 f8 ff ff       	jmp    80106117 <alltraps>

801068cf <vector56>:
.globl vector56
vector56:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $56
801068d1:	6a 38                	push   $0x38
  jmp alltraps
801068d3:	e9 3f f8 ff ff       	jmp    80106117 <alltraps>

801068d8 <vector57>:
.globl vector57
vector57:
  pushl $0
801068d8:	6a 00                	push   $0x0
  pushl $57
801068da:	6a 39                	push   $0x39
  jmp alltraps
801068dc:	e9 36 f8 ff ff       	jmp    80106117 <alltraps>

801068e1 <vector58>:
.globl vector58
vector58:
  pushl $0
801068e1:	6a 00                	push   $0x0
  pushl $58
801068e3:	6a 3a                	push   $0x3a
  jmp alltraps
801068e5:	e9 2d f8 ff ff       	jmp    80106117 <alltraps>

801068ea <vector59>:
.globl vector59
vector59:
  pushl $0
801068ea:	6a 00                	push   $0x0
  pushl $59
801068ec:	6a 3b                	push   $0x3b
  jmp alltraps
801068ee:	e9 24 f8 ff ff       	jmp    80106117 <alltraps>

801068f3 <vector60>:
.globl vector60
vector60:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $60
801068f5:	6a 3c                	push   $0x3c
  jmp alltraps
801068f7:	e9 1b f8 ff ff       	jmp    80106117 <alltraps>

801068fc <vector61>:
.globl vector61
vector61:
  pushl $0
801068fc:	6a 00                	push   $0x0
  pushl $61
801068fe:	6a 3d                	push   $0x3d
  jmp alltraps
80106900:	e9 12 f8 ff ff       	jmp    80106117 <alltraps>

80106905 <vector62>:
.globl vector62
vector62:
  pushl $0
80106905:	6a 00                	push   $0x0
  pushl $62
80106907:	6a 3e                	push   $0x3e
  jmp alltraps
80106909:	e9 09 f8 ff ff       	jmp    80106117 <alltraps>

8010690e <vector63>:
.globl vector63
vector63:
  pushl $0
8010690e:	6a 00                	push   $0x0
  pushl $63
80106910:	6a 3f                	push   $0x3f
  jmp alltraps
80106912:	e9 00 f8 ff ff       	jmp    80106117 <alltraps>

80106917 <vector64>:
.globl vector64
vector64:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $64
80106919:	6a 40                	push   $0x40
  jmp alltraps
8010691b:	e9 f7 f7 ff ff       	jmp    80106117 <alltraps>

80106920 <vector65>:
.globl vector65
vector65:
  pushl $0
80106920:	6a 00                	push   $0x0
  pushl $65
80106922:	6a 41                	push   $0x41
  jmp alltraps
80106924:	e9 ee f7 ff ff       	jmp    80106117 <alltraps>

80106929 <vector66>:
.globl vector66
vector66:
  pushl $0
80106929:	6a 00                	push   $0x0
  pushl $66
8010692b:	6a 42                	push   $0x42
  jmp alltraps
8010692d:	e9 e5 f7 ff ff       	jmp    80106117 <alltraps>

80106932 <vector67>:
.globl vector67
vector67:
  pushl $0
80106932:	6a 00                	push   $0x0
  pushl $67
80106934:	6a 43                	push   $0x43
  jmp alltraps
80106936:	e9 dc f7 ff ff       	jmp    80106117 <alltraps>

8010693b <vector68>:
.globl vector68
vector68:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $68
8010693d:	6a 44                	push   $0x44
  jmp alltraps
8010693f:	e9 d3 f7 ff ff       	jmp    80106117 <alltraps>

80106944 <vector69>:
.globl vector69
vector69:
  pushl $0
80106944:	6a 00                	push   $0x0
  pushl $69
80106946:	6a 45                	push   $0x45
  jmp alltraps
80106948:	e9 ca f7 ff ff       	jmp    80106117 <alltraps>

8010694d <vector70>:
.globl vector70
vector70:
  pushl $0
8010694d:	6a 00                	push   $0x0
  pushl $70
8010694f:	6a 46                	push   $0x46
  jmp alltraps
80106951:	e9 c1 f7 ff ff       	jmp    80106117 <alltraps>

80106956 <vector71>:
.globl vector71
vector71:
  pushl $0
80106956:	6a 00                	push   $0x0
  pushl $71
80106958:	6a 47                	push   $0x47
  jmp alltraps
8010695a:	e9 b8 f7 ff ff       	jmp    80106117 <alltraps>

8010695f <vector72>:
.globl vector72
vector72:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $72
80106961:	6a 48                	push   $0x48
  jmp alltraps
80106963:	e9 af f7 ff ff       	jmp    80106117 <alltraps>

80106968 <vector73>:
.globl vector73
vector73:
  pushl $0
80106968:	6a 00                	push   $0x0
  pushl $73
8010696a:	6a 49                	push   $0x49
  jmp alltraps
8010696c:	e9 a6 f7 ff ff       	jmp    80106117 <alltraps>

80106971 <vector74>:
.globl vector74
vector74:
  pushl $0
80106971:	6a 00                	push   $0x0
  pushl $74
80106973:	6a 4a                	push   $0x4a
  jmp alltraps
80106975:	e9 9d f7 ff ff       	jmp    80106117 <alltraps>

8010697a <vector75>:
.globl vector75
vector75:
  pushl $0
8010697a:	6a 00                	push   $0x0
  pushl $75
8010697c:	6a 4b                	push   $0x4b
  jmp alltraps
8010697e:	e9 94 f7 ff ff       	jmp    80106117 <alltraps>

80106983 <vector76>:
.globl vector76
vector76:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $76
80106985:	6a 4c                	push   $0x4c
  jmp alltraps
80106987:	e9 8b f7 ff ff       	jmp    80106117 <alltraps>

8010698c <vector77>:
.globl vector77
vector77:
  pushl $0
8010698c:	6a 00                	push   $0x0
  pushl $77
8010698e:	6a 4d                	push   $0x4d
  jmp alltraps
80106990:	e9 82 f7 ff ff       	jmp    80106117 <alltraps>

80106995 <vector78>:
.globl vector78
vector78:
  pushl $0
80106995:	6a 00                	push   $0x0
  pushl $78
80106997:	6a 4e                	push   $0x4e
  jmp alltraps
80106999:	e9 79 f7 ff ff       	jmp    80106117 <alltraps>

8010699e <vector79>:
.globl vector79
vector79:
  pushl $0
8010699e:	6a 00                	push   $0x0
  pushl $79
801069a0:	6a 4f                	push   $0x4f
  jmp alltraps
801069a2:	e9 70 f7 ff ff       	jmp    80106117 <alltraps>

801069a7 <vector80>:
.globl vector80
vector80:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $80
801069a9:	6a 50                	push   $0x50
  jmp alltraps
801069ab:	e9 67 f7 ff ff       	jmp    80106117 <alltraps>

801069b0 <vector81>:
.globl vector81
vector81:
  pushl $0
801069b0:	6a 00                	push   $0x0
  pushl $81
801069b2:	6a 51                	push   $0x51
  jmp alltraps
801069b4:	e9 5e f7 ff ff       	jmp    80106117 <alltraps>

801069b9 <vector82>:
.globl vector82
vector82:
  pushl $0
801069b9:	6a 00                	push   $0x0
  pushl $82
801069bb:	6a 52                	push   $0x52
  jmp alltraps
801069bd:	e9 55 f7 ff ff       	jmp    80106117 <alltraps>

801069c2 <vector83>:
.globl vector83
vector83:
  pushl $0
801069c2:	6a 00                	push   $0x0
  pushl $83
801069c4:	6a 53                	push   $0x53
  jmp alltraps
801069c6:	e9 4c f7 ff ff       	jmp    80106117 <alltraps>

801069cb <vector84>:
.globl vector84
vector84:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $84
801069cd:	6a 54                	push   $0x54
  jmp alltraps
801069cf:	e9 43 f7 ff ff       	jmp    80106117 <alltraps>

801069d4 <vector85>:
.globl vector85
vector85:
  pushl $0
801069d4:	6a 00                	push   $0x0
  pushl $85
801069d6:	6a 55                	push   $0x55
  jmp alltraps
801069d8:	e9 3a f7 ff ff       	jmp    80106117 <alltraps>

801069dd <vector86>:
.globl vector86
vector86:
  pushl $0
801069dd:	6a 00                	push   $0x0
  pushl $86
801069df:	6a 56                	push   $0x56
  jmp alltraps
801069e1:	e9 31 f7 ff ff       	jmp    80106117 <alltraps>

801069e6 <vector87>:
.globl vector87
vector87:
  pushl $0
801069e6:	6a 00                	push   $0x0
  pushl $87
801069e8:	6a 57                	push   $0x57
  jmp alltraps
801069ea:	e9 28 f7 ff ff       	jmp    80106117 <alltraps>

801069ef <vector88>:
.globl vector88
vector88:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $88
801069f1:	6a 58                	push   $0x58
  jmp alltraps
801069f3:	e9 1f f7 ff ff       	jmp    80106117 <alltraps>

801069f8 <vector89>:
.globl vector89
vector89:
  pushl $0
801069f8:	6a 00                	push   $0x0
  pushl $89
801069fa:	6a 59                	push   $0x59
  jmp alltraps
801069fc:	e9 16 f7 ff ff       	jmp    80106117 <alltraps>

80106a01 <vector90>:
.globl vector90
vector90:
  pushl $0
80106a01:	6a 00                	push   $0x0
  pushl $90
80106a03:	6a 5a                	push   $0x5a
  jmp alltraps
80106a05:	e9 0d f7 ff ff       	jmp    80106117 <alltraps>

80106a0a <vector91>:
.globl vector91
vector91:
  pushl $0
80106a0a:	6a 00                	push   $0x0
  pushl $91
80106a0c:	6a 5b                	push   $0x5b
  jmp alltraps
80106a0e:	e9 04 f7 ff ff       	jmp    80106117 <alltraps>

80106a13 <vector92>:
.globl vector92
vector92:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $92
80106a15:	6a 5c                	push   $0x5c
  jmp alltraps
80106a17:	e9 fb f6 ff ff       	jmp    80106117 <alltraps>

80106a1c <vector93>:
.globl vector93
vector93:
  pushl $0
80106a1c:	6a 00                	push   $0x0
  pushl $93
80106a1e:	6a 5d                	push   $0x5d
  jmp alltraps
80106a20:	e9 f2 f6 ff ff       	jmp    80106117 <alltraps>

80106a25 <vector94>:
.globl vector94
vector94:
  pushl $0
80106a25:	6a 00                	push   $0x0
  pushl $94
80106a27:	6a 5e                	push   $0x5e
  jmp alltraps
80106a29:	e9 e9 f6 ff ff       	jmp    80106117 <alltraps>

80106a2e <vector95>:
.globl vector95
vector95:
  pushl $0
80106a2e:	6a 00                	push   $0x0
  pushl $95
80106a30:	6a 5f                	push   $0x5f
  jmp alltraps
80106a32:	e9 e0 f6 ff ff       	jmp    80106117 <alltraps>

80106a37 <vector96>:
.globl vector96
vector96:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $96
80106a39:	6a 60                	push   $0x60
  jmp alltraps
80106a3b:	e9 d7 f6 ff ff       	jmp    80106117 <alltraps>

80106a40 <vector97>:
.globl vector97
vector97:
  pushl $0
80106a40:	6a 00                	push   $0x0
  pushl $97
80106a42:	6a 61                	push   $0x61
  jmp alltraps
80106a44:	e9 ce f6 ff ff       	jmp    80106117 <alltraps>

80106a49 <vector98>:
.globl vector98
vector98:
  pushl $0
80106a49:	6a 00                	push   $0x0
  pushl $98
80106a4b:	6a 62                	push   $0x62
  jmp alltraps
80106a4d:	e9 c5 f6 ff ff       	jmp    80106117 <alltraps>

80106a52 <vector99>:
.globl vector99
vector99:
  pushl $0
80106a52:	6a 00                	push   $0x0
  pushl $99
80106a54:	6a 63                	push   $0x63
  jmp alltraps
80106a56:	e9 bc f6 ff ff       	jmp    80106117 <alltraps>

80106a5b <vector100>:
.globl vector100
vector100:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $100
80106a5d:	6a 64                	push   $0x64
  jmp alltraps
80106a5f:	e9 b3 f6 ff ff       	jmp    80106117 <alltraps>

80106a64 <vector101>:
.globl vector101
vector101:
  pushl $0
80106a64:	6a 00                	push   $0x0
  pushl $101
80106a66:	6a 65                	push   $0x65
  jmp alltraps
80106a68:	e9 aa f6 ff ff       	jmp    80106117 <alltraps>

80106a6d <vector102>:
.globl vector102
vector102:
  pushl $0
80106a6d:	6a 00                	push   $0x0
  pushl $102
80106a6f:	6a 66                	push   $0x66
  jmp alltraps
80106a71:	e9 a1 f6 ff ff       	jmp    80106117 <alltraps>

80106a76 <vector103>:
.globl vector103
vector103:
  pushl $0
80106a76:	6a 00                	push   $0x0
  pushl $103
80106a78:	6a 67                	push   $0x67
  jmp alltraps
80106a7a:	e9 98 f6 ff ff       	jmp    80106117 <alltraps>

80106a7f <vector104>:
.globl vector104
vector104:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $104
80106a81:	6a 68                	push   $0x68
  jmp alltraps
80106a83:	e9 8f f6 ff ff       	jmp    80106117 <alltraps>

80106a88 <vector105>:
.globl vector105
vector105:
  pushl $0
80106a88:	6a 00                	push   $0x0
  pushl $105
80106a8a:	6a 69                	push   $0x69
  jmp alltraps
80106a8c:	e9 86 f6 ff ff       	jmp    80106117 <alltraps>

80106a91 <vector106>:
.globl vector106
vector106:
  pushl $0
80106a91:	6a 00                	push   $0x0
  pushl $106
80106a93:	6a 6a                	push   $0x6a
  jmp alltraps
80106a95:	e9 7d f6 ff ff       	jmp    80106117 <alltraps>

80106a9a <vector107>:
.globl vector107
vector107:
  pushl $0
80106a9a:	6a 00                	push   $0x0
  pushl $107
80106a9c:	6a 6b                	push   $0x6b
  jmp alltraps
80106a9e:	e9 74 f6 ff ff       	jmp    80106117 <alltraps>

80106aa3 <vector108>:
.globl vector108
vector108:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $108
80106aa5:	6a 6c                	push   $0x6c
  jmp alltraps
80106aa7:	e9 6b f6 ff ff       	jmp    80106117 <alltraps>

80106aac <vector109>:
.globl vector109
vector109:
  pushl $0
80106aac:	6a 00                	push   $0x0
  pushl $109
80106aae:	6a 6d                	push   $0x6d
  jmp alltraps
80106ab0:	e9 62 f6 ff ff       	jmp    80106117 <alltraps>

80106ab5 <vector110>:
.globl vector110
vector110:
  pushl $0
80106ab5:	6a 00                	push   $0x0
  pushl $110
80106ab7:	6a 6e                	push   $0x6e
  jmp alltraps
80106ab9:	e9 59 f6 ff ff       	jmp    80106117 <alltraps>

80106abe <vector111>:
.globl vector111
vector111:
  pushl $0
80106abe:	6a 00                	push   $0x0
  pushl $111
80106ac0:	6a 6f                	push   $0x6f
  jmp alltraps
80106ac2:	e9 50 f6 ff ff       	jmp    80106117 <alltraps>

80106ac7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $112
80106ac9:	6a 70                	push   $0x70
  jmp alltraps
80106acb:	e9 47 f6 ff ff       	jmp    80106117 <alltraps>

80106ad0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106ad0:	6a 00                	push   $0x0
  pushl $113
80106ad2:	6a 71                	push   $0x71
  jmp alltraps
80106ad4:	e9 3e f6 ff ff       	jmp    80106117 <alltraps>

80106ad9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106ad9:	6a 00                	push   $0x0
  pushl $114
80106adb:	6a 72                	push   $0x72
  jmp alltraps
80106add:	e9 35 f6 ff ff       	jmp    80106117 <alltraps>

80106ae2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106ae2:	6a 00                	push   $0x0
  pushl $115
80106ae4:	6a 73                	push   $0x73
  jmp alltraps
80106ae6:	e9 2c f6 ff ff       	jmp    80106117 <alltraps>

80106aeb <vector116>:
.globl vector116
vector116:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $116
80106aed:	6a 74                	push   $0x74
  jmp alltraps
80106aef:	e9 23 f6 ff ff       	jmp    80106117 <alltraps>

80106af4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106af4:	6a 00                	push   $0x0
  pushl $117
80106af6:	6a 75                	push   $0x75
  jmp alltraps
80106af8:	e9 1a f6 ff ff       	jmp    80106117 <alltraps>

80106afd <vector118>:
.globl vector118
vector118:
  pushl $0
80106afd:	6a 00                	push   $0x0
  pushl $118
80106aff:	6a 76                	push   $0x76
  jmp alltraps
80106b01:	e9 11 f6 ff ff       	jmp    80106117 <alltraps>

80106b06 <vector119>:
.globl vector119
vector119:
  pushl $0
80106b06:	6a 00                	push   $0x0
  pushl $119
80106b08:	6a 77                	push   $0x77
  jmp alltraps
80106b0a:	e9 08 f6 ff ff       	jmp    80106117 <alltraps>

80106b0f <vector120>:
.globl vector120
vector120:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $120
80106b11:	6a 78                	push   $0x78
  jmp alltraps
80106b13:	e9 ff f5 ff ff       	jmp    80106117 <alltraps>

80106b18 <vector121>:
.globl vector121
vector121:
  pushl $0
80106b18:	6a 00                	push   $0x0
  pushl $121
80106b1a:	6a 79                	push   $0x79
  jmp alltraps
80106b1c:	e9 f6 f5 ff ff       	jmp    80106117 <alltraps>

80106b21 <vector122>:
.globl vector122
vector122:
  pushl $0
80106b21:	6a 00                	push   $0x0
  pushl $122
80106b23:	6a 7a                	push   $0x7a
  jmp alltraps
80106b25:	e9 ed f5 ff ff       	jmp    80106117 <alltraps>

80106b2a <vector123>:
.globl vector123
vector123:
  pushl $0
80106b2a:	6a 00                	push   $0x0
  pushl $123
80106b2c:	6a 7b                	push   $0x7b
  jmp alltraps
80106b2e:	e9 e4 f5 ff ff       	jmp    80106117 <alltraps>

80106b33 <vector124>:
.globl vector124
vector124:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $124
80106b35:	6a 7c                	push   $0x7c
  jmp alltraps
80106b37:	e9 db f5 ff ff       	jmp    80106117 <alltraps>

80106b3c <vector125>:
.globl vector125
vector125:
  pushl $0
80106b3c:	6a 00                	push   $0x0
  pushl $125
80106b3e:	6a 7d                	push   $0x7d
  jmp alltraps
80106b40:	e9 d2 f5 ff ff       	jmp    80106117 <alltraps>

80106b45 <vector126>:
.globl vector126
vector126:
  pushl $0
80106b45:	6a 00                	push   $0x0
  pushl $126
80106b47:	6a 7e                	push   $0x7e
  jmp alltraps
80106b49:	e9 c9 f5 ff ff       	jmp    80106117 <alltraps>

80106b4e <vector127>:
.globl vector127
vector127:
  pushl $0
80106b4e:	6a 00                	push   $0x0
  pushl $127
80106b50:	6a 7f                	push   $0x7f
  jmp alltraps
80106b52:	e9 c0 f5 ff ff       	jmp    80106117 <alltraps>

80106b57 <vector128>:
.globl vector128
vector128:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $128
80106b59:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106b5e:	e9 b4 f5 ff ff       	jmp    80106117 <alltraps>

80106b63 <vector129>:
.globl vector129
vector129:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $129
80106b65:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106b6a:	e9 a8 f5 ff ff       	jmp    80106117 <alltraps>

80106b6f <vector130>:
.globl vector130
vector130:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $130
80106b71:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106b76:	e9 9c f5 ff ff       	jmp    80106117 <alltraps>

80106b7b <vector131>:
.globl vector131
vector131:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $131
80106b7d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106b82:	e9 90 f5 ff ff       	jmp    80106117 <alltraps>

80106b87 <vector132>:
.globl vector132
vector132:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $132
80106b89:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106b8e:	e9 84 f5 ff ff       	jmp    80106117 <alltraps>

80106b93 <vector133>:
.globl vector133
vector133:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $133
80106b95:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106b9a:	e9 78 f5 ff ff       	jmp    80106117 <alltraps>

80106b9f <vector134>:
.globl vector134
vector134:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $134
80106ba1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106ba6:	e9 6c f5 ff ff       	jmp    80106117 <alltraps>

80106bab <vector135>:
.globl vector135
vector135:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $135
80106bad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106bb2:	e9 60 f5 ff ff       	jmp    80106117 <alltraps>

80106bb7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $136
80106bb9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106bbe:	e9 54 f5 ff ff       	jmp    80106117 <alltraps>

80106bc3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $137
80106bc5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106bca:	e9 48 f5 ff ff       	jmp    80106117 <alltraps>

80106bcf <vector138>:
.globl vector138
vector138:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $138
80106bd1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106bd6:	e9 3c f5 ff ff       	jmp    80106117 <alltraps>

80106bdb <vector139>:
.globl vector139
vector139:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $139
80106bdd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106be2:	e9 30 f5 ff ff       	jmp    80106117 <alltraps>

80106be7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $140
80106be9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106bee:	e9 24 f5 ff ff       	jmp    80106117 <alltraps>

80106bf3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $141
80106bf5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106bfa:	e9 18 f5 ff ff       	jmp    80106117 <alltraps>

80106bff <vector142>:
.globl vector142
vector142:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $142
80106c01:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106c06:	e9 0c f5 ff ff       	jmp    80106117 <alltraps>

80106c0b <vector143>:
.globl vector143
vector143:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $143
80106c0d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106c12:	e9 00 f5 ff ff       	jmp    80106117 <alltraps>

80106c17 <vector144>:
.globl vector144
vector144:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $144
80106c19:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106c1e:	e9 f4 f4 ff ff       	jmp    80106117 <alltraps>

80106c23 <vector145>:
.globl vector145
vector145:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $145
80106c25:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106c2a:	e9 e8 f4 ff ff       	jmp    80106117 <alltraps>

80106c2f <vector146>:
.globl vector146
vector146:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $146
80106c31:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106c36:	e9 dc f4 ff ff       	jmp    80106117 <alltraps>

80106c3b <vector147>:
.globl vector147
vector147:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $147
80106c3d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106c42:	e9 d0 f4 ff ff       	jmp    80106117 <alltraps>

80106c47 <vector148>:
.globl vector148
vector148:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $148
80106c49:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106c4e:	e9 c4 f4 ff ff       	jmp    80106117 <alltraps>

80106c53 <vector149>:
.globl vector149
vector149:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $149
80106c55:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106c5a:	e9 b8 f4 ff ff       	jmp    80106117 <alltraps>

80106c5f <vector150>:
.globl vector150
vector150:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $150
80106c61:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106c66:	e9 ac f4 ff ff       	jmp    80106117 <alltraps>

80106c6b <vector151>:
.globl vector151
vector151:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $151
80106c6d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106c72:	e9 a0 f4 ff ff       	jmp    80106117 <alltraps>

80106c77 <vector152>:
.globl vector152
vector152:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $152
80106c79:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106c7e:	e9 94 f4 ff ff       	jmp    80106117 <alltraps>

80106c83 <vector153>:
.globl vector153
vector153:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $153
80106c85:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106c8a:	e9 88 f4 ff ff       	jmp    80106117 <alltraps>

80106c8f <vector154>:
.globl vector154
vector154:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $154
80106c91:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106c96:	e9 7c f4 ff ff       	jmp    80106117 <alltraps>

80106c9b <vector155>:
.globl vector155
vector155:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $155
80106c9d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ca2:	e9 70 f4 ff ff       	jmp    80106117 <alltraps>

80106ca7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $156
80106ca9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106cae:	e9 64 f4 ff ff       	jmp    80106117 <alltraps>

80106cb3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $157
80106cb5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106cba:	e9 58 f4 ff ff       	jmp    80106117 <alltraps>

80106cbf <vector158>:
.globl vector158
vector158:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $158
80106cc1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106cc6:	e9 4c f4 ff ff       	jmp    80106117 <alltraps>

80106ccb <vector159>:
.globl vector159
vector159:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $159
80106ccd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106cd2:	e9 40 f4 ff ff       	jmp    80106117 <alltraps>

80106cd7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $160
80106cd9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106cde:	e9 34 f4 ff ff       	jmp    80106117 <alltraps>

80106ce3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $161
80106ce5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106cea:	e9 28 f4 ff ff       	jmp    80106117 <alltraps>

80106cef <vector162>:
.globl vector162
vector162:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $162
80106cf1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106cf6:	e9 1c f4 ff ff       	jmp    80106117 <alltraps>

80106cfb <vector163>:
.globl vector163
vector163:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $163
80106cfd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106d02:	e9 10 f4 ff ff       	jmp    80106117 <alltraps>

80106d07 <vector164>:
.globl vector164
vector164:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $164
80106d09:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106d0e:	e9 04 f4 ff ff       	jmp    80106117 <alltraps>

80106d13 <vector165>:
.globl vector165
vector165:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $165
80106d15:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106d1a:	e9 f8 f3 ff ff       	jmp    80106117 <alltraps>

80106d1f <vector166>:
.globl vector166
vector166:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $166
80106d21:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106d26:	e9 ec f3 ff ff       	jmp    80106117 <alltraps>

80106d2b <vector167>:
.globl vector167
vector167:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $167
80106d2d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106d32:	e9 e0 f3 ff ff       	jmp    80106117 <alltraps>

80106d37 <vector168>:
.globl vector168
vector168:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $168
80106d39:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106d3e:	e9 d4 f3 ff ff       	jmp    80106117 <alltraps>

80106d43 <vector169>:
.globl vector169
vector169:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $169
80106d45:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106d4a:	e9 c8 f3 ff ff       	jmp    80106117 <alltraps>

80106d4f <vector170>:
.globl vector170
vector170:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $170
80106d51:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106d56:	e9 bc f3 ff ff       	jmp    80106117 <alltraps>

80106d5b <vector171>:
.globl vector171
vector171:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $171
80106d5d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106d62:	e9 b0 f3 ff ff       	jmp    80106117 <alltraps>

80106d67 <vector172>:
.globl vector172
vector172:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $172
80106d69:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106d6e:	e9 a4 f3 ff ff       	jmp    80106117 <alltraps>

80106d73 <vector173>:
.globl vector173
vector173:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $173
80106d75:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106d7a:	e9 98 f3 ff ff       	jmp    80106117 <alltraps>

80106d7f <vector174>:
.globl vector174
vector174:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $174
80106d81:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106d86:	e9 8c f3 ff ff       	jmp    80106117 <alltraps>

80106d8b <vector175>:
.globl vector175
vector175:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $175
80106d8d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106d92:	e9 80 f3 ff ff       	jmp    80106117 <alltraps>

80106d97 <vector176>:
.globl vector176
vector176:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $176
80106d99:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106d9e:	e9 74 f3 ff ff       	jmp    80106117 <alltraps>

80106da3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $177
80106da5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106daa:	e9 68 f3 ff ff       	jmp    80106117 <alltraps>

80106daf <vector178>:
.globl vector178
vector178:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $178
80106db1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106db6:	e9 5c f3 ff ff       	jmp    80106117 <alltraps>

80106dbb <vector179>:
.globl vector179
vector179:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $179
80106dbd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106dc2:	e9 50 f3 ff ff       	jmp    80106117 <alltraps>

80106dc7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $180
80106dc9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106dce:	e9 44 f3 ff ff       	jmp    80106117 <alltraps>

80106dd3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $181
80106dd5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106dda:	e9 38 f3 ff ff       	jmp    80106117 <alltraps>

80106ddf <vector182>:
.globl vector182
vector182:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $182
80106de1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106de6:	e9 2c f3 ff ff       	jmp    80106117 <alltraps>

80106deb <vector183>:
.globl vector183
vector183:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $183
80106ded:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106df2:	e9 20 f3 ff ff       	jmp    80106117 <alltraps>

80106df7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $184
80106df9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106dfe:	e9 14 f3 ff ff       	jmp    80106117 <alltraps>

80106e03 <vector185>:
.globl vector185
vector185:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $185
80106e05:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106e0a:	e9 08 f3 ff ff       	jmp    80106117 <alltraps>

80106e0f <vector186>:
.globl vector186
vector186:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $186
80106e11:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106e16:	e9 fc f2 ff ff       	jmp    80106117 <alltraps>

80106e1b <vector187>:
.globl vector187
vector187:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $187
80106e1d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106e22:	e9 f0 f2 ff ff       	jmp    80106117 <alltraps>

80106e27 <vector188>:
.globl vector188
vector188:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $188
80106e29:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106e2e:	e9 e4 f2 ff ff       	jmp    80106117 <alltraps>

80106e33 <vector189>:
.globl vector189
vector189:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $189
80106e35:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106e3a:	e9 d8 f2 ff ff       	jmp    80106117 <alltraps>

80106e3f <vector190>:
.globl vector190
vector190:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $190
80106e41:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106e46:	e9 cc f2 ff ff       	jmp    80106117 <alltraps>

80106e4b <vector191>:
.globl vector191
vector191:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $191
80106e4d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106e52:	e9 c0 f2 ff ff       	jmp    80106117 <alltraps>

80106e57 <vector192>:
.globl vector192
vector192:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $192
80106e59:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106e5e:	e9 b4 f2 ff ff       	jmp    80106117 <alltraps>

80106e63 <vector193>:
.globl vector193
vector193:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $193
80106e65:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106e6a:	e9 a8 f2 ff ff       	jmp    80106117 <alltraps>

80106e6f <vector194>:
.globl vector194
vector194:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $194
80106e71:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106e76:	e9 9c f2 ff ff       	jmp    80106117 <alltraps>

80106e7b <vector195>:
.globl vector195
vector195:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $195
80106e7d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106e82:	e9 90 f2 ff ff       	jmp    80106117 <alltraps>

80106e87 <vector196>:
.globl vector196
vector196:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $196
80106e89:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106e8e:	e9 84 f2 ff ff       	jmp    80106117 <alltraps>

80106e93 <vector197>:
.globl vector197
vector197:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $197
80106e95:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106e9a:	e9 78 f2 ff ff       	jmp    80106117 <alltraps>

80106e9f <vector198>:
.globl vector198
vector198:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $198
80106ea1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106ea6:	e9 6c f2 ff ff       	jmp    80106117 <alltraps>

80106eab <vector199>:
.globl vector199
vector199:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $199
80106ead:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106eb2:	e9 60 f2 ff ff       	jmp    80106117 <alltraps>

80106eb7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $200
80106eb9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106ebe:	e9 54 f2 ff ff       	jmp    80106117 <alltraps>

80106ec3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $201
80106ec5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106eca:	e9 48 f2 ff ff       	jmp    80106117 <alltraps>

80106ecf <vector202>:
.globl vector202
vector202:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $202
80106ed1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ed6:	e9 3c f2 ff ff       	jmp    80106117 <alltraps>

80106edb <vector203>:
.globl vector203
vector203:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $203
80106edd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106ee2:	e9 30 f2 ff ff       	jmp    80106117 <alltraps>

80106ee7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $204
80106ee9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106eee:	e9 24 f2 ff ff       	jmp    80106117 <alltraps>

80106ef3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $205
80106ef5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106efa:	e9 18 f2 ff ff       	jmp    80106117 <alltraps>

80106eff <vector206>:
.globl vector206
vector206:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $206
80106f01:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106f06:	e9 0c f2 ff ff       	jmp    80106117 <alltraps>

80106f0b <vector207>:
.globl vector207
vector207:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $207
80106f0d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106f12:	e9 00 f2 ff ff       	jmp    80106117 <alltraps>

80106f17 <vector208>:
.globl vector208
vector208:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $208
80106f19:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106f1e:	e9 f4 f1 ff ff       	jmp    80106117 <alltraps>

80106f23 <vector209>:
.globl vector209
vector209:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $209
80106f25:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106f2a:	e9 e8 f1 ff ff       	jmp    80106117 <alltraps>

80106f2f <vector210>:
.globl vector210
vector210:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $210
80106f31:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106f36:	e9 dc f1 ff ff       	jmp    80106117 <alltraps>

80106f3b <vector211>:
.globl vector211
vector211:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $211
80106f3d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106f42:	e9 d0 f1 ff ff       	jmp    80106117 <alltraps>

80106f47 <vector212>:
.globl vector212
vector212:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $212
80106f49:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106f4e:	e9 c4 f1 ff ff       	jmp    80106117 <alltraps>

80106f53 <vector213>:
.globl vector213
vector213:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $213
80106f55:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106f5a:	e9 b8 f1 ff ff       	jmp    80106117 <alltraps>

80106f5f <vector214>:
.globl vector214
vector214:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $214
80106f61:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106f66:	e9 ac f1 ff ff       	jmp    80106117 <alltraps>

80106f6b <vector215>:
.globl vector215
vector215:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $215
80106f6d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106f72:	e9 a0 f1 ff ff       	jmp    80106117 <alltraps>

80106f77 <vector216>:
.globl vector216
vector216:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $216
80106f79:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106f7e:	e9 94 f1 ff ff       	jmp    80106117 <alltraps>

80106f83 <vector217>:
.globl vector217
vector217:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $217
80106f85:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106f8a:	e9 88 f1 ff ff       	jmp    80106117 <alltraps>

80106f8f <vector218>:
.globl vector218
vector218:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $218
80106f91:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106f96:	e9 7c f1 ff ff       	jmp    80106117 <alltraps>

80106f9b <vector219>:
.globl vector219
vector219:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $219
80106f9d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106fa2:	e9 70 f1 ff ff       	jmp    80106117 <alltraps>

80106fa7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $220
80106fa9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106fae:	e9 64 f1 ff ff       	jmp    80106117 <alltraps>

80106fb3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $221
80106fb5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106fba:	e9 58 f1 ff ff       	jmp    80106117 <alltraps>

80106fbf <vector222>:
.globl vector222
vector222:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $222
80106fc1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106fc6:	e9 4c f1 ff ff       	jmp    80106117 <alltraps>

80106fcb <vector223>:
.globl vector223
vector223:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $223
80106fcd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106fd2:	e9 40 f1 ff ff       	jmp    80106117 <alltraps>

80106fd7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $224
80106fd9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106fde:	e9 34 f1 ff ff       	jmp    80106117 <alltraps>

80106fe3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $225
80106fe5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106fea:	e9 28 f1 ff ff       	jmp    80106117 <alltraps>

80106fef <vector226>:
.globl vector226
vector226:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $226
80106ff1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ff6:	e9 1c f1 ff ff       	jmp    80106117 <alltraps>

80106ffb <vector227>:
.globl vector227
vector227:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $227
80106ffd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107002:	e9 10 f1 ff ff       	jmp    80106117 <alltraps>

80107007 <vector228>:
.globl vector228
vector228:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $228
80107009:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010700e:	e9 04 f1 ff ff       	jmp    80106117 <alltraps>

80107013 <vector229>:
.globl vector229
vector229:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $229
80107015:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010701a:	e9 f8 f0 ff ff       	jmp    80106117 <alltraps>

8010701f <vector230>:
.globl vector230
vector230:
  pushl $0
8010701f:	6a 00                	push   $0x0
  pushl $230
80107021:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107026:	e9 ec f0 ff ff       	jmp    80106117 <alltraps>

8010702b <vector231>:
.globl vector231
vector231:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $231
8010702d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107032:	e9 e0 f0 ff ff       	jmp    80106117 <alltraps>

80107037 <vector232>:
.globl vector232
vector232:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $232
80107039:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010703e:	e9 d4 f0 ff ff       	jmp    80106117 <alltraps>

80107043 <vector233>:
.globl vector233
vector233:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $233
80107045:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010704a:	e9 c8 f0 ff ff       	jmp    80106117 <alltraps>

8010704f <vector234>:
.globl vector234
vector234:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $234
80107051:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107056:	e9 bc f0 ff ff       	jmp    80106117 <alltraps>

8010705b <vector235>:
.globl vector235
vector235:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $235
8010705d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107062:	e9 b0 f0 ff ff       	jmp    80106117 <alltraps>

80107067 <vector236>:
.globl vector236
vector236:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $236
80107069:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010706e:	e9 a4 f0 ff ff       	jmp    80106117 <alltraps>

80107073 <vector237>:
.globl vector237
vector237:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $237
80107075:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010707a:	e9 98 f0 ff ff       	jmp    80106117 <alltraps>

8010707f <vector238>:
.globl vector238
vector238:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $238
80107081:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107086:	e9 8c f0 ff ff       	jmp    80106117 <alltraps>

8010708b <vector239>:
.globl vector239
vector239:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $239
8010708d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107092:	e9 80 f0 ff ff       	jmp    80106117 <alltraps>

80107097 <vector240>:
.globl vector240
vector240:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $240
80107099:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010709e:	e9 74 f0 ff ff       	jmp    80106117 <alltraps>

801070a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $241
801070a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801070aa:	e9 68 f0 ff ff       	jmp    80106117 <alltraps>

801070af <vector242>:
.globl vector242
vector242:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $242
801070b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801070b6:	e9 5c f0 ff ff       	jmp    80106117 <alltraps>

801070bb <vector243>:
.globl vector243
vector243:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $243
801070bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801070c2:	e9 50 f0 ff ff       	jmp    80106117 <alltraps>

801070c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $244
801070c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801070ce:	e9 44 f0 ff ff       	jmp    80106117 <alltraps>

801070d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $245
801070d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801070da:	e9 38 f0 ff ff       	jmp    80106117 <alltraps>

801070df <vector246>:
.globl vector246
vector246:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $246
801070e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801070e6:	e9 2c f0 ff ff       	jmp    80106117 <alltraps>

801070eb <vector247>:
.globl vector247
vector247:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $247
801070ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801070f2:	e9 20 f0 ff ff       	jmp    80106117 <alltraps>

801070f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $248
801070f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801070fe:	e9 14 f0 ff ff       	jmp    80106117 <alltraps>

80107103 <vector249>:
.globl vector249
vector249:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $249
80107105:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010710a:	e9 08 f0 ff ff       	jmp    80106117 <alltraps>

8010710f <vector250>:
.globl vector250
vector250:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $250
80107111:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107116:	e9 fc ef ff ff       	jmp    80106117 <alltraps>

8010711b <vector251>:
.globl vector251
vector251:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $251
8010711d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107122:	e9 f0 ef ff ff       	jmp    80106117 <alltraps>

80107127 <vector252>:
.globl vector252
vector252:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $252
80107129:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010712e:	e9 e4 ef ff ff       	jmp    80106117 <alltraps>

80107133 <vector253>:
.globl vector253
vector253:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $253
80107135:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010713a:	e9 d8 ef ff ff       	jmp    80106117 <alltraps>

8010713f <vector254>:
.globl vector254
vector254:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $254
80107141:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107146:	e9 cc ef ff ff       	jmp    80106117 <alltraps>

8010714b <vector255>:
.globl vector255
vector255:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $255
8010714d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107152:	e9 c0 ef ff ff       	jmp    80106117 <alltraps>
80107157:	66 90                	xchg   %ax,%ax
80107159:	66 90                	xchg   %ax,%ax
8010715b:	66 90                	xchg   %ax,%ax
8010715d:	66 90                	xchg   %ax,%ax
8010715f:	90                   	nop

80107160 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107166:	89 d3                	mov    %edx,%ebx
{
80107168:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010716a:	c1 eb 16             	shr    $0x16,%ebx
8010716d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107170:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107173:	8b 06                	mov    (%esi),%eax
80107175:	a8 01                	test   $0x1,%al
80107177:	74 27                	je     801071a0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107179:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010717e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107184:	c1 ef 0a             	shr    $0xa,%edi
}
80107187:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010718a:	89 fa                	mov    %edi,%edx
8010718c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107192:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107195:	5b                   	pop    %ebx
80107196:	5e                   	pop    %esi
80107197:	5f                   	pop    %edi
80107198:	5d                   	pop    %ebp
80107199:	c3                   	ret    
8010719a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801071a0:	85 c9                	test   %ecx,%ecx
801071a2:	74 2c                	je     801071d0 <walkpgdir+0x70>
801071a4:	e8 e7 b3 ff ff       	call   80102590 <kalloc>
801071a9:	85 c0                	test   %eax,%eax
801071ab:	89 c3                	mov    %eax,%ebx
801071ad:	74 21                	je     801071d0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801071af:	83 ec 04             	sub    $0x4,%esp
801071b2:	68 00 10 00 00       	push   $0x1000
801071b7:	6a 00                	push   $0x0
801071b9:	50                   	push   %eax
801071ba:	e8 f1 db ff ff       	call   80104db0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801071bf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071c5:	83 c4 10             	add    $0x10,%esp
801071c8:	83 c8 07             	or     $0x7,%eax
801071cb:	89 06                	mov    %eax,(%esi)
801071cd:	eb b5                	jmp    80107184 <walkpgdir+0x24>
801071cf:	90                   	nop
}
801071d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801071d3:	31 c0                	xor    %eax,%eax
}
801071d5:	5b                   	pop    %ebx
801071d6:	5e                   	pop    %esi
801071d7:	5f                   	pop    %edi
801071d8:	5d                   	pop    %ebp
801071d9:	c3                   	ret    
801071da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801071e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801071e0:	55                   	push   %ebp
801071e1:	89 e5                	mov    %esp,%ebp
801071e3:	57                   	push   %edi
801071e4:	56                   	push   %esi
801071e5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801071e6:	89 d3                	mov    %edx,%ebx
801071e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801071ee:	83 ec 1c             	sub    $0x1c,%esp
801071f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801071f4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801071f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801071fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107200:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107203:	8b 45 0c             	mov    0xc(%ebp),%eax
80107206:	29 df                	sub    %ebx,%edi
80107208:	83 c8 01             	or     $0x1,%eax
8010720b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010720e:	eb 15                	jmp    80107225 <mappages+0x45>
    if(*pte & PTE_P)
80107210:	f6 00 01             	testb  $0x1,(%eax)
80107213:	75 45                	jne    8010725a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107215:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107218:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010721b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010721d:	74 31                	je     80107250 <mappages+0x70>
      break;
    a += PGSIZE;
8010721f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107225:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107228:	b9 01 00 00 00       	mov    $0x1,%ecx
8010722d:	89 da                	mov    %ebx,%edx
8010722f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107232:	e8 29 ff ff ff       	call   80107160 <walkpgdir>
80107237:	85 c0                	test   %eax,%eax
80107239:	75 d5                	jne    80107210 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010723b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010723e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107243:	5b                   	pop    %ebx
80107244:	5e                   	pop    %esi
80107245:	5f                   	pop    %edi
80107246:	5d                   	pop    %ebp
80107247:	c3                   	ret    
80107248:	90                   	nop
80107249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107250:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107253:	31 c0                	xor    %eax,%eax
}
80107255:	5b                   	pop    %ebx
80107256:	5e                   	pop    %esi
80107257:	5f                   	pop    %edi
80107258:	5d                   	pop    %ebp
80107259:	c3                   	ret    
      panic("remap");
8010725a:	83 ec 0c             	sub    $0xc,%esp
8010725d:	68 48 84 10 80       	push   $0x80108448
80107262:	e8 29 91 ff ff       	call   80100390 <panic>
80107267:	89 f6                	mov    %esi,%esi
80107269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107270 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	56                   	push   %esi
80107275:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107276:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010727c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010727e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107284:	83 ec 1c             	sub    $0x1c,%esp
80107287:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010728a:	39 d3                	cmp    %edx,%ebx
8010728c:	73 66                	jae    801072f4 <deallocuvm.part.0+0x84>
8010728e:	89 d6                	mov    %edx,%esi
80107290:	eb 3d                	jmp    801072cf <deallocuvm.part.0+0x5f>
80107292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107298:	8b 10                	mov    (%eax),%edx
8010729a:	f6 c2 01             	test   $0x1,%dl
8010729d:	74 26                	je     801072c5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010729f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801072a5:	74 58                	je     801072ff <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801072a7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801072aa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801072b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801072b3:	52                   	push   %edx
801072b4:	e8 27 b1 ff ff       	call   801023e0 <kfree>
      *pte = 0;
801072b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072bc:	83 c4 10             	add    $0x10,%esp
801072bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801072c5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072cb:	39 f3                	cmp    %esi,%ebx
801072cd:	73 25                	jae    801072f4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801072cf:	31 c9                	xor    %ecx,%ecx
801072d1:	89 da                	mov    %ebx,%edx
801072d3:	89 f8                	mov    %edi,%eax
801072d5:	e8 86 fe ff ff       	call   80107160 <walkpgdir>
    if(!pte)
801072da:	85 c0                	test   %eax,%eax
801072dc:	75 ba                	jne    80107298 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801072de:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801072e4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801072ea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072f0:	39 f3                	cmp    %esi,%ebx
801072f2:	72 db                	jb     801072cf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801072f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801072f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072fa:	5b                   	pop    %ebx
801072fb:	5e                   	pop    %esi
801072fc:	5f                   	pop    %edi
801072fd:	5d                   	pop    %ebp
801072fe:	c3                   	ret    
        panic("kfree");
801072ff:	83 ec 0c             	sub    $0xc,%esp
80107302:	68 26 7d 10 80       	push   $0x80107d26
80107307:	e8 84 90 ff ff       	call   80100390 <panic>
8010730c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107310 <seginit>:
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107316:	e8 25 c6 ff ff       	call   80103940 <cpuid>
8010731b:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
80107321:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107326:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010732a:	c7 80 18 38 11 80 ff 	movl   $0xffff,-0x7feec7e8(%eax)
80107331:	ff 00 00 
80107334:	c7 80 1c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7e4(%eax)
8010733b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010733e:	c7 80 20 38 11 80 ff 	movl   $0xffff,-0x7feec7e0(%eax)
80107345:	ff 00 00 
80107348:	c7 80 24 38 11 80 00 	movl   $0xcf9200,-0x7feec7dc(%eax)
8010734f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107352:	c7 80 28 38 11 80 ff 	movl   $0xffff,-0x7feec7d8(%eax)
80107359:	ff 00 00 
8010735c:	c7 80 2c 38 11 80 00 	movl   $0xcffa00,-0x7feec7d4(%eax)
80107363:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107366:	c7 80 30 38 11 80 ff 	movl   $0xffff,-0x7feec7d0(%eax)
8010736d:	ff 00 00 
80107370:	c7 80 34 38 11 80 00 	movl   $0xcff200,-0x7feec7cc(%eax)
80107377:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010737a:	05 10 38 11 80       	add    $0x80113810,%eax
  pd[1] = (uint)p;
8010737f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107383:	c1 e8 10             	shr    $0x10,%eax
80107386:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010738a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010738d:	0f 01 10             	lgdtl  (%eax)
}
80107390:	c9                   	leave  
80107391:	c3                   	ret    
80107392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801073a0:	a1 24 03 12 80       	mov    0x80120324,%eax
{
801073a5:	55                   	push   %ebp
801073a6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801073a8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801073ad:	0f 22 d8             	mov    %eax,%cr3
}
801073b0:	5d                   	pop    %ebp
801073b1:	c3                   	ret    
801073b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073c0 <switchuvm>:
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	57                   	push   %edi
801073c4:	56                   	push   %esi
801073c5:	53                   	push   %ebx
801073c6:	83 ec 1c             	sub    $0x1c,%esp
801073c9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801073cc:	85 f6                	test   %esi,%esi
801073ce:	0f 84 d3 00 00 00    	je     801074a7 <switchuvm+0xe7>
  if(mythread()->kstack == 0)
801073d4:	e8 b7 c5 ff ff       	call   80103990 <mythread>
801073d9:	8b 00                	mov    (%eax),%eax
801073db:	85 c0                	test   %eax,%eax
801073dd:	0f 84 de 00 00 00    	je     801074c1 <switchuvm+0x101>
  if(p->pgdir == 0)
801073e3:	8b 46 04             	mov    0x4(%esi),%eax
801073e6:	85 c0                	test   %eax,%eax
801073e8:	0f 84 c6 00 00 00    	je     801074b4 <switchuvm+0xf4>
  pushcli();
801073ee:	e8 dd d7 ff ff       	call   80104bd0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801073f3:	e8 c8 c4 ff ff       	call   801038c0 <mycpu>
801073f8:	89 c3                	mov    %eax,%ebx
801073fa:	e8 c1 c4 ff ff       	call   801038c0 <mycpu>
801073ff:	89 c7                	mov    %eax,%edi
80107401:	e8 ba c4 ff ff       	call   801038c0 <mycpu>
80107406:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107409:	83 c7 08             	add    $0x8,%edi
8010740c:	e8 af c4 ff ff       	call   801038c0 <mycpu>
80107411:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107414:	83 c0 08             	add    $0x8,%eax
80107417:	ba 67 00 00 00       	mov    $0x67,%edx
8010741c:	c1 e8 18             	shr    $0x18,%eax
8010741f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107426:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010742d:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107433:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107438:	83 c1 08             	add    $0x8,%ecx
8010743b:	c1 e9 10             	shr    $0x10,%ecx
8010743e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107444:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107449:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107450:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107455:	e8 66 c4 ff ff       	call   801038c0 <mycpu>
8010745a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107461:	e8 5a c4 ff ff       	call   801038c0 <mycpu>
80107466:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)mythread()->kstack + KSTACKSIZE;
8010746a:	e8 21 c5 ff ff       	call   80103990 <mythread>
8010746f:	8b 18                	mov    (%eax),%ebx
80107471:	e8 4a c4 ff ff       	call   801038c0 <mycpu>
80107476:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010747c:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010747f:	e8 3c c4 ff ff       	call   801038c0 <mycpu>
80107484:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107488:	b8 28 00 00 00       	mov    $0x28,%eax
8010748d:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107490:	8b 46 04             	mov    0x4(%esi),%eax
80107493:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107498:	0f 22 d8             	mov    %eax,%cr3
}
8010749b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010749e:	5b                   	pop    %ebx
8010749f:	5e                   	pop    %esi
801074a0:	5f                   	pop    %edi
801074a1:	5d                   	pop    %ebp
  popcli();
801074a2:	e9 69 d7 ff ff       	jmp    80104c10 <popcli>
    panic("switchuvm: no process");
801074a7:	83 ec 0c             	sub    $0xc,%esp
801074aa:	68 4e 84 10 80       	push   $0x8010844e
801074af:	e8 dc 8e ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801074b4:	83 ec 0c             	sub    $0xc,%esp
801074b7:	68 79 84 10 80       	push   $0x80108479
801074bc:	e8 cf 8e ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801074c1:	83 ec 0c             	sub    $0xc,%esp
801074c4:	68 64 84 10 80       	push   $0x80108464
801074c9:	e8 c2 8e ff ff       	call   80100390 <panic>
801074ce:	66 90                	xchg   %ax,%ax

801074d0 <inituvm>:
{
801074d0:	55                   	push   %ebp
801074d1:	89 e5                	mov    %esp,%ebp
801074d3:	57                   	push   %edi
801074d4:	56                   	push   %esi
801074d5:	53                   	push   %ebx
801074d6:	83 ec 1c             	sub    $0x1c,%esp
801074d9:	8b 75 10             	mov    0x10(%ebp),%esi
801074dc:	8b 45 08             	mov    0x8(%ebp),%eax
801074df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801074e2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801074e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801074eb:	77 49                	ja     80107536 <inituvm+0x66>
  mem = kalloc();
801074ed:	e8 9e b0 ff ff       	call   80102590 <kalloc>
  memset(mem, 0, PGSIZE);
801074f2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801074f5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801074f7:	68 00 10 00 00       	push   $0x1000
801074fc:	6a 00                	push   $0x0
801074fe:	50                   	push   %eax
801074ff:	e8 ac d8 ff ff       	call   80104db0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107504:	58                   	pop    %eax
80107505:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010750b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107510:	5a                   	pop    %edx
80107511:	6a 06                	push   $0x6
80107513:	50                   	push   %eax
80107514:	31 d2                	xor    %edx,%edx
80107516:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107519:	e8 c2 fc ff ff       	call   801071e0 <mappages>
  memmove(mem, init, sz);
8010751e:	89 75 10             	mov    %esi,0x10(%ebp)
80107521:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107524:	83 c4 10             	add    $0x10,%esp
80107527:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010752a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010752d:	5b                   	pop    %ebx
8010752e:	5e                   	pop    %esi
8010752f:	5f                   	pop    %edi
80107530:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107531:	e9 2a d9 ff ff       	jmp    80104e60 <memmove>
    panic("inituvm: more than a page");
80107536:	83 ec 0c             	sub    $0xc,%esp
80107539:	68 8d 84 10 80       	push   $0x8010848d
8010753e:	e8 4d 8e ff ff       	call   80100390 <panic>
80107543:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107550 <loaduvm>:
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107559:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107560:	0f 85 91 00 00 00    	jne    801075f7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107566:	8b 75 18             	mov    0x18(%ebp),%esi
80107569:	31 db                	xor    %ebx,%ebx
8010756b:	85 f6                	test   %esi,%esi
8010756d:	75 1a                	jne    80107589 <loaduvm+0x39>
8010756f:	eb 6f                	jmp    801075e0 <loaduvm+0x90>
80107571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107578:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010757e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107584:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107587:	76 57                	jbe    801075e0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107589:	8b 55 0c             	mov    0xc(%ebp),%edx
8010758c:	8b 45 08             	mov    0x8(%ebp),%eax
8010758f:	31 c9                	xor    %ecx,%ecx
80107591:	01 da                	add    %ebx,%edx
80107593:	e8 c8 fb ff ff       	call   80107160 <walkpgdir>
80107598:	85 c0                	test   %eax,%eax
8010759a:	74 4e                	je     801075ea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010759c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010759e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801075a1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801075a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801075ab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801075b1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075b4:	01 d9                	add    %ebx,%ecx
801075b6:	05 00 00 00 80       	add    $0x80000000,%eax
801075bb:	57                   	push   %edi
801075bc:	51                   	push   %ecx
801075bd:	50                   	push   %eax
801075be:	ff 75 10             	pushl  0x10(%ebp)
801075c1:	e8 6a a4 ff ff       	call   80101a30 <readi>
801075c6:	83 c4 10             	add    $0x10,%esp
801075c9:	39 f8                	cmp    %edi,%eax
801075cb:	74 ab                	je     80107578 <loaduvm+0x28>
}
801075cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801075d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075d5:	5b                   	pop    %ebx
801075d6:	5e                   	pop    %esi
801075d7:	5f                   	pop    %edi
801075d8:	5d                   	pop    %ebp
801075d9:	c3                   	ret    
801075da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801075e3:	31 c0                	xor    %eax,%eax
}
801075e5:	5b                   	pop    %ebx
801075e6:	5e                   	pop    %esi
801075e7:	5f                   	pop    %edi
801075e8:	5d                   	pop    %ebp
801075e9:	c3                   	ret    
      panic("loaduvm: address should exist");
801075ea:	83 ec 0c             	sub    $0xc,%esp
801075ed:	68 a7 84 10 80       	push   $0x801084a7
801075f2:	e8 99 8d ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801075f7:	83 ec 0c             	sub    $0xc,%esp
801075fa:	68 48 85 10 80       	push   $0x80108548
801075ff:	e8 8c 8d ff ff       	call   80100390 <panic>
80107604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010760a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107610 <allocuvm>:
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	57                   	push   %edi
80107614:	56                   	push   %esi
80107615:	53                   	push   %ebx
80107616:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107619:	8b 7d 10             	mov    0x10(%ebp),%edi
8010761c:	85 ff                	test   %edi,%edi
8010761e:	0f 88 8e 00 00 00    	js     801076b2 <allocuvm+0xa2>
  if(newsz < oldsz)
80107624:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107627:	0f 82 93 00 00 00    	jb     801076c0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010762d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107630:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107636:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010763c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010763f:	0f 86 7e 00 00 00    	jbe    801076c3 <allocuvm+0xb3>
80107645:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107648:	8b 7d 08             	mov    0x8(%ebp),%edi
8010764b:	eb 42                	jmp    8010768f <allocuvm+0x7f>
8010764d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107650:	83 ec 04             	sub    $0x4,%esp
80107653:	68 00 10 00 00       	push   $0x1000
80107658:	6a 00                	push   $0x0
8010765a:	50                   	push   %eax
8010765b:	e8 50 d7 ff ff       	call   80104db0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107660:	58                   	pop    %eax
80107661:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107667:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010766c:	5a                   	pop    %edx
8010766d:	6a 06                	push   $0x6
8010766f:	50                   	push   %eax
80107670:	89 da                	mov    %ebx,%edx
80107672:	89 f8                	mov    %edi,%eax
80107674:	e8 67 fb ff ff       	call   801071e0 <mappages>
80107679:	83 c4 10             	add    $0x10,%esp
8010767c:	85 c0                	test   %eax,%eax
8010767e:	78 50                	js     801076d0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107680:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107686:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107689:	0f 86 81 00 00 00    	jbe    80107710 <allocuvm+0x100>
    mem = kalloc();
8010768f:	e8 fc ae ff ff       	call   80102590 <kalloc>
    if(mem == 0){
80107694:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107696:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107698:	75 b6                	jne    80107650 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010769a:	83 ec 0c             	sub    $0xc,%esp
8010769d:	68 c5 84 10 80       	push   $0x801084c5
801076a2:	e8 b9 8f ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801076a7:	83 c4 10             	add    $0x10,%esp
801076aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801076ad:	39 45 10             	cmp    %eax,0x10(%ebp)
801076b0:	77 6e                	ja     80107720 <allocuvm+0x110>
}
801076b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801076b5:	31 ff                	xor    %edi,%edi
}
801076b7:	89 f8                	mov    %edi,%eax
801076b9:	5b                   	pop    %ebx
801076ba:	5e                   	pop    %esi
801076bb:	5f                   	pop    %edi
801076bc:	5d                   	pop    %ebp
801076bd:	c3                   	ret    
801076be:	66 90                	xchg   %ax,%ax
    return oldsz;
801076c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801076c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076c6:	89 f8                	mov    %edi,%eax
801076c8:	5b                   	pop    %ebx
801076c9:	5e                   	pop    %esi
801076ca:	5f                   	pop    %edi
801076cb:	5d                   	pop    %ebp
801076cc:	c3                   	ret    
801076cd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801076d0:	83 ec 0c             	sub    $0xc,%esp
801076d3:	68 dd 84 10 80       	push   $0x801084dd
801076d8:	e8 83 8f ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801076dd:	83 c4 10             	add    $0x10,%esp
801076e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801076e3:	39 45 10             	cmp    %eax,0x10(%ebp)
801076e6:	76 0d                	jbe    801076f5 <allocuvm+0xe5>
801076e8:	89 c1                	mov    %eax,%ecx
801076ea:	8b 55 10             	mov    0x10(%ebp),%edx
801076ed:	8b 45 08             	mov    0x8(%ebp),%eax
801076f0:	e8 7b fb ff ff       	call   80107270 <deallocuvm.part.0>
      kfree(mem);
801076f5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801076f8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801076fa:	56                   	push   %esi
801076fb:	e8 e0 ac ff ff       	call   801023e0 <kfree>
      return 0;
80107700:	83 c4 10             	add    $0x10,%esp
}
80107703:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107706:	89 f8                	mov    %edi,%eax
80107708:	5b                   	pop    %ebx
80107709:	5e                   	pop    %esi
8010770a:	5f                   	pop    %edi
8010770b:	5d                   	pop    %ebp
8010770c:	c3                   	ret    
8010770d:	8d 76 00             	lea    0x0(%esi),%esi
80107710:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107713:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107716:	5b                   	pop    %ebx
80107717:	89 f8                	mov    %edi,%eax
80107719:	5e                   	pop    %esi
8010771a:	5f                   	pop    %edi
8010771b:	5d                   	pop    %ebp
8010771c:	c3                   	ret    
8010771d:	8d 76 00             	lea    0x0(%esi),%esi
80107720:	89 c1                	mov    %eax,%ecx
80107722:	8b 55 10             	mov    0x10(%ebp),%edx
80107725:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107728:	31 ff                	xor    %edi,%edi
8010772a:	e8 41 fb ff ff       	call   80107270 <deallocuvm.part.0>
8010772f:	eb 92                	jmp    801076c3 <allocuvm+0xb3>
80107731:	eb 0d                	jmp    80107740 <deallocuvm>
80107733:	90                   	nop
80107734:	90                   	nop
80107735:	90                   	nop
80107736:	90                   	nop
80107737:	90                   	nop
80107738:	90                   	nop
80107739:	90                   	nop
8010773a:	90                   	nop
8010773b:	90                   	nop
8010773c:	90                   	nop
8010773d:	90                   	nop
8010773e:	90                   	nop
8010773f:	90                   	nop

80107740 <deallocuvm>:
{
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	8b 55 0c             	mov    0xc(%ebp),%edx
80107746:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107749:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010774c:	39 d1                	cmp    %edx,%ecx
8010774e:	73 10                	jae    80107760 <deallocuvm+0x20>
}
80107750:	5d                   	pop    %ebp
80107751:	e9 1a fb ff ff       	jmp    80107270 <deallocuvm.part.0>
80107756:	8d 76 00             	lea    0x0(%esi),%esi
80107759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107760:	89 d0                	mov    %edx,%eax
80107762:	5d                   	pop    %ebp
80107763:	c3                   	ret    
80107764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010776a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107770 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
80107773:	57                   	push   %edi
80107774:	56                   	push   %esi
80107775:	53                   	push   %ebx
80107776:	83 ec 0c             	sub    $0xc,%esp
80107779:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010777c:	85 f6                	test   %esi,%esi
8010777e:	74 59                	je     801077d9 <freevm+0x69>
80107780:	31 c9                	xor    %ecx,%ecx
80107782:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107787:	89 f0                	mov    %esi,%eax
80107789:	e8 e2 fa ff ff       	call   80107270 <deallocuvm.part.0>
8010778e:	89 f3                	mov    %esi,%ebx
80107790:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107796:	eb 0f                	jmp    801077a7 <freevm+0x37>
80107798:	90                   	nop
80107799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077a0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801077a3:	39 fb                	cmp    %edi,%ebx
801077a5:	74 23                	je     801077ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801077a7:	8b 03                	mov    (%ebx),%eax
801077a9:	a8 01                	test   $0x1,%al
801077ab:	74 f3                	je     801077a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801077ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801077b2:	83 ec 0c             	sub    $0xc,%esp
801077b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801077b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801077bd:	50                   	push   %eax
801077be:	e8 1d ac ff ff       	call   801023e0 <kfree>
801077c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801077c6:	39 fb                	cmp    %edi,%ebx
801077c8:	75 dd                	jne    801077a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801077ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801077cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077d0:	5b                   	pop    %ebx
801077d1:	5e                   	pop    %esi
801077d2:	5f                   	pop    %edi
801077d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801077d4:	e9 07 ac ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
801077d9:	83 ec 0c             	sub    $0xc,%esp
801077dc:	68 f9 84 10 80       	push   $0x801084f9
801077e1:	e8 aa 8b ff ff       	call   80100390 <panic>
801077e6:	8d 76 00             	lea    0x0(%esi),%esi
801077e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077f0 <setupkvm>:
{
801077f0:	55                   	push   %ebp
801077f1:	89 e5                	mov    %esp,%ebp
801077f3:	56                   	push   %esi
801077f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801077f5:	e8 96 ad ff ff       	call   80102590 <kalloc>
801077fa:	85 c0                	test   %eax,%eax
801077fc:	89 c6                	mov    %eax,%esi
801077fe:	74 42                	je     80107842 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107800:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107803:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107808:	68 00 10 00 00       	push   $0x1000
8010780d:	6a 00                	push   $0x0
8010780f:	50                   	push   %eax
80107810:	e8 9b d5 ff ff       	call   80104db0 <memset>
80107815:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107818:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010781b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010781e:	83 ec 08             	sub    $0x8,%esp
80107821:	8b 13                	mov    (%ebx),%edx
80107823:	ff 73 0c             	pushl  0xc(%ebx)
80107826:	50                   	push   %eax
80107827:	29 c1                	sub    %eax,%ecx
80107829:	89 f0                	mov    %esi,%eax
8010782b:	e8 b0 f9 ff ff       	call   801071e0 <mappages>
80107830:	83 c4 10             	add    $0x10,%esp
80107833:	85 c0                	test   %eax,%eax
80107835:	78 19                	js     80107850 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107837:	83 c3 10             	add    $0x10,%ebx
8010783a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107840:	75 d6                	jne    80107818 <setupkvm+0x28>
}
80107842:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107845:	89 f0                	mov    %esi,%eax
80107847:	5b                   	pop    %ebx
80107848:	5e                   	pop    %esi
80107849:	5d                   	pop    %ebp
8010784a:	c3                   	ret    
8010784b:	90                   	nop
8010784c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107850:	83 ec 0c             	sub    $0xc,%esp
80107853:	56                   	push   %esi
      return 0;
80107854:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107856:	e8 15 ff ff ff       	call   80107770 <freevm>
      return 0;
8010785b:	83 c4 10             	add    $0x10,%esp
}
8010785e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107861:	89 f0                	mov    %esi,%eax
80107863:	5b                   	pop    %ebx
80107864:	5e                   	pop    %esi
80107865:	5d                   	pop    %ebp
80107866:	c3                   	ret    
80107867:	89 f6                	mov    %esi,%esi
80107869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107870 <kvmalloc>:
{
80107870:	55                   	push   %ebp
80107871:	89 e5                	mov    %esp,%ebp
80107873:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107876:	e8 75 ff ff ff       	call   801077f0 <setupkvm>
8010787b:	a3 24 03 12 80       	mov    %eax,0x80120324
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107880:	05 00 00 00 80       	add    $0x80000000,%eax
80107885:	0f 22 d8             	mov    %eax,%cr3
}
80107888:	c9                   	leave  
80107889:	c3                   	ret    
8010788a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107890 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107890:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107891:	31 c9                	xor    %ecx,%ecx
{
80107893:	89 e5                	mov    %esp,%ebp
80107895:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107898:	8b 55 0c             	mov    0xc(%ebp),%edx
8010789b:	8b 45 08             	mov    0x8(%ebp),%eax
8010789e:	e8 bd f8 ff ff       	call   80107160 <walkpgdir>
  if(pte == 0)
801078a3:	85 c0                	test   %eax,%eax
801078a5:	74 05                	je     801078ac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801078a7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801078aa:	c9                   	leave  
801078ab:	c3                   	ret    
    panic("clearpteu");
801078ac:	83 ec 0c             	sub    $0xc,%esp
801078af:	68 0a 85 10 80       	push   $0x8010850a
801078b4:	e8 d7 8a ff ff       	call   80100390 <panic>
801078b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801078c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801078c0:	55                   	push   %ebp
801078c1:	89 e5                	mov    %esp,%ebp
801078c3:	57                   	push   %edi
801078c4:	56                   	push   %esi
801078c5:	53                   	push   %ebx
801078c6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801078c9:	e8 22 ff ff ff       	call   801077f0 <setupkvm>
801078ce:	85 c0                	test   %eax,%eax
801078d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801078d3:	0f 84 9f 00 00 00    	je     80107978 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801078d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801078dc:	85 c9                	test   %ecx,%ecx
801078de:	0f 84 94 00 00 00    	je     80107978 <copyuvm+0xb8>
801078e4:	31 ff                	xor    %edi,%edi
801078e6:	eb 4a                	jmp    80107932 <copyuvm+0x72>
801078e8:	90                   	nop
801078e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801078f0:	83 ec 04             	sub    $0x4,%esp
801078f3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801078f9:	68 00 10 00 00       	push   $0x1000
801078fe:	53                   	push   %ebx
801078ff:	50                   	push   %eax
80107900:	e8 5b d5 ff ff       	call   80104e60 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107905:	58                   	pop    %eax
80107906:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010790c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107911:	5a                   	pop    %edx
80107912:	ff 75 e4             	pushl  -0x1c(%ebp)
80107915:	50                   	push   %eax
80107916:	89 fa                	mov    %edi,%edx
80107918:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010791b:	e8 c0 f8 ff ff       	call   801071e0 <mappages>
80107920:	83 c4 10             	add    $0x10,%esp
80107923:	85 c0                	test   %eax,%eax
80107925:	78 61                	js     80107988 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107927:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010792d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107930:	76 46                	jbe    80107978 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107932:	8b 45 08             	mov    0x8(%ebp),%eax
80107935:	31 c9                	xor    %ecx,%ecx
80107937:	89 fa                	mov    %edi,%edx
80107939:	e8 22 f8 ff ff       	call   80107160 <walkpgdir>
8010793e:	85 c0                	test   %eax,%eax
80107940:	74 61                	je     801079a3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107942:	8b 00                	mov    (%eax),%eax
80107944:	a8 01                	test   $0x1,%al
80107946:	74 4e                	je     80107996 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107948:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010794a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010794f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107955:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107958:	e8 33 ac ff ff       	call   80102590 <kalloc>
8010795d:	85 c0                	test   %eax,%eax
8010795f:	89 c6                	mov    %eax,%esi
80107961:	75 8d                	jne    801078f0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107963:	83 ec 0c             	sub    $0xc,%esp
80107966:	ff 75 e0             	pushl  -0x20(%ebp)
80107969:	e8 02 fe ff ff       	call   80107770 <freevm>
  return 0;
8010796e:	83 c4 10             	add    $0x10,%esp
80107971:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107978:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010797b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010797e:	5b                   	pop    %ebx
8010797f:	5e                   	pop    %esi
80107980:	5f                   	pop    %edi
80107981:	5d                   	pop    %ebp
80107982:	c3                   	ret    
80107983:	90                   	nop
80107984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107988:	83 ec 0c             	sub    $0xc,%esp
8010798b:	56                   	push   %esi
8010798c:	e8 4f aa ff ff       	call   801023e0 <kfree>
      goto bad;
80107991:	83 c4 10             	add    $0x10,%esp
80107994:	eb cd                	jmp    80107963 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107996:	83 ec 0c             	sub    $0xc,%esp
80107999:	68 2e 85 10 80       	push   $0x8010852e
8010799e:	e8 ed 89 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801079a3:	83 ec 0c             	sub    $0xc,%esp
801079a6:	68 14 85 10 80       	push   $0x80108514
801079ab:	e8 e0 89 ff ff       	call   80100390 <panic>

801079b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801079b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801079b1:	31 c9                	xor    %ecx,%ecx
{
801079b3:	89 e5                	mov    %esp,%ebp
801079b5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801079b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801079bb:	8b 45 08             	mov    0x8(%ebp),%eax
801079be:	e8 9d f7 ff ff       	call   80107160 <walkpgdir>
  if((*pte & PTE_P) == 0)
801079c3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801079c5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801079c6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801079c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801079cd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801079d0:	05 00 00 00 80       	add    $0x80000000,%eax
801079d5:	83 fa 05             	cmp    $0x5,%edx
801079d8:	ba 00 00 00 00       	mov    $0x0,%edx
801079dd:	0f 45 c2             	cmovne %edx,%eax
}
801079e0:	c3                   	ret    
801079e1:	eb 0d                	jmp    801079f0 <copyout>
801079e3:	90                   	nop
801079e4:	90                   	nop
801079e5:	90                   	nop
801079e6:	90                   	nop
801079e7:	90                   	nop
801079e8:	90                   	nop
801079e9:	90                   	nop
801079ea:	90                   	nop
801079eb:	90                   	nop
801079ec:	90                   	nop
801079ed:	90                   	nop
801079ee:	90                   	nop
801079ef:	90                   	nop

801079f0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	57                   	push   %edi
801079f4:	56                   	push   %esi
801079f5:	53                   	push   %ebx
801079f6:	83 ec 1c             	sub    $0x1c,%esp
801079f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801079fc:	8b 55 0c             	mov    0xc(%ebp),%edx
801079ff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107a02:	85 db                	test   %ebx,%ebx
80107a04:	75 40                	jne    80107a46 <copyout+0x56>
80107a06:	eb 70                	jmp    80107a78 <copyout+0x88>
80107a08:	90                   	nop
80107a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107a10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107a13:	89 f1                	mov    %esi,%ecx
80107a15:	29 d1                	sub    %edx,%ecx
80107a17:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107a1d:	39 d9                	cmp    %ebx,%ecx
80107a1f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107a22:	29 f2                	sub    %esi,%edx
80107a24:	83 ec 04             	sub    $0x4,%esp
80107a27:	01 d0                	add    %edx,%eax
80107a29:	51                   	push   %ecx
80107a2a:	57                   	push   %edi
80107a2b:	50                   	push   %eax
80107a2c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107a2f:	e8 2c d4 ff ff       	call   80104e60 <memmove>
    len -= n;
    buf += n;
80107a34:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107a37:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107a3a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107a40:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107a42:	29 cb                	sub    %ecx,%ebx
80107a44:	74 32                	je     80107a78 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107a46:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a48:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107a4b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107a4e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a54:	56                   	push   %esi
80107a55:	ff 75 08             	pushl  0x8(%ebp)
80107a58:	e8 53 ff ff ff       	call   801079b0 <uva2ka>
    if(pa0 == 0)
80107a5d:	83 c4 10             	add    $0x10,%esp
80107a60:	85 c0                	test   %eax,%eax
80107a62:	75 ac                	jne    80107a10 <copyout+0x20>
  }
  return 0;
}
80107a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a6c:	5b                   	pop    %ebx
80107a6d:	5e                   	pop    %esi
80107a6e:	5f                   	pop    %edi
80107a6f:	5d                   	pop    %ebp
80107a70:	c3                   	ret    
80107a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a7b:	31 c0                	xor    %eax,%eax
}
80107a7d:	5b                   	pop    %ebx
80107a7e:	5e                   	pop    %esi
80107a7f:	5f                   	pop    %edi
80107a80:	5d                   	pop    %ebp
80107a81:	c3                   	ret    
