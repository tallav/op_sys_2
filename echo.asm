
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  for(i = 1; i < argc; i++)
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 3f                	jle    5c <main+0x5c>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	eb 18                	jmp    3d <main+0x3d>
  25:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  28:	68 e4 0b 00 00       	push   $0xbe4
  2d:	50                   	push   %eax
  2e:	68 c4 0b 00 00       	push   $0xbc4
  33:	6a 01                	push   $0x1
  35:	e8 16 04 00 00       	call   450 <printf>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	83 c3 04             	add    $0x4,%ebx
  40:	8b 43 fc             	mov    -0x4(%ebx),%eax
  43:	39 f3                	cmp    %esi,%ebx
  45:	75 e1                	jne    28 <main+0x28>
  47:	68 ee 0b 00 00       	push   $0xbee
  4c:	50                   	push   %eax
  4d:	68 c4 0b 00 00       	push   $0xbc4
  52:	6a 01                	push   $0x1
  54:	e8 f7 03 00 00       	call   450 <printf>
  59:	83 c4 10             	add    $0x10,%esp
  exit();
  5c:	e8 61 02 00 00       	call   2c2 <exit>
  61:	66 90                	xchg   %ax,%ax
  63:	66 90                	xchg   %ax,%ax
  65:	66 90                	xchg   %ax,%ax
  67:	66 90                	xchg   %ax,%ax
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	83 c1 01             	add    $0x1,%ecx
  83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	84 db                	test   %bl,%bl
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	75 ef                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  91:	5b                   	pop    %ebx
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	84 c0                	test   %al,%al
  b2:	75 1c                	jne    d0 <strcmp+0x30>
  b4:	eb 2a                	jmp    e0 <strcmp+0x40>
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  c6:	83 c1 01             	add    $0x1,%ecx
  c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  cc:	84 c0                	test   %al,%al
  ce:	74 10                	je     e0 <strcmp+0x40>
  d0:	38 d8                	cmp    %bl,%al
  d2:	74 ec                	je     c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  d4:	29 d8                	sub    %ebx,%eax
}
  d6:	5b                   	pop    %ebx
  d7:	5d                   	pop    %ebp
  d8:	c3                   	ret    
  d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e2:	29 d8                	sub    %ebx,%eax
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 39 00             	cmpb   $0x0,(%ecx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 d2                	xor    %edx,%edx
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 110:	31 c0                	xor    %eax,%eax
}
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	74 1d                	je     16e <strchr+0x2e>
    if(*s == c)
 151:	38 d3                	cmp    %dl,%bl
 153:	89 d9                	mov    %ebx,%ecx
 155:	75 0d                	jne    164 <strchr+0x24>
 157:	eb 17                	jmp    170 <strchr+0x30>
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 0c                	je     170 <strchr+0x30>
  for(; *s; s++)
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 10             	movzbl (%eax),%edx
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strchr+0x20>
      return (char*)s;
  return 0;
 16e:	31 c0                	xor    %eax,%eax
}
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 186:	31 f6                	xor    %esi,%esi
 188:	89 f3                	mov    %esi,%ebx
{
 18a:	83 ec 1c             	sub    $0x1c,%esp
 18d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 190:	eb 2f                	jmp    1c1 <gets+0x41>
 192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 198:	8d 45 e7             	lea    -0x19(%ebp),%eax
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	6a 01                	push   $0x1
 1a0:	50                   	push   %eax
 1a1:	6a 00                	push   $0x0
 1a3:	e8 32 01 00 00       	call   2da <read>
    if(cc < 1)
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	85 c0                	test   %eax,%eax
 1ad:	7e 1c                	jle    1cb <gets+0x4b>
      break;
    buf[i++] = c;
 1af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b3:	83 c7 01             	add    $0x1,%edi
 1b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1b9:	3c 0a                	cmp    $0xa,%al
 1bb:	74 23                	je     1e0 <gets+0x60>
 1bd:	3c 0d                	cmp    $0xd,%al
 1bf:	74 1f                	je     1e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1c1:	83 c3 01             	add    $0x1,%ebx
 1c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c7:	89 fe                	mov    %edi,%esi
 1c9:	7c cd                	jl     198 <gets+0x18>
 1cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1d0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1d6:	5b                   	pop    %ebx
 1d7:	5e                   	pop    %esi
 1d8:	5f                   	pop    %edi
 1d9:	5d                   	pop    %ebp
 1da:	c3                   	ret    
 1db:	90                   	nop
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e0:	8b 75 08             	mov    0x8(%ebp),%esi
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	01 de                	add    %ebx,%esi
 1e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f0:	5b                   	pop    %ebx
 1f1:	5e                   	pop    %esi
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	pushl  0x8(%ebp)
 20d:	e8 f0 00 00 00       	call   302 <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	pushl  0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 f3 00 00 00       	call   31a <fstat>
  close(fd);
 227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 22a:	89 c6                	mov    %eax,%esi
  close(fd);
 22c:	e8 b9 00 00 00       	call   2ea <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
}
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 11             	movsbl (%ecx),%edx
 25a:	8d 42 d0             	lea    -0x30(%edx),%eax
 25d:	3c 09                	cmp    $0x9,%al
  n = 0;
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 264:	77 1f                	ja     285 <atoi+0x35>
 266:	8d 76 00             	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 270:	8d 04 80             	lea    (%eax,%eax,4),%eax
 273:	83 c1 01             	add    $0x1,%ecx
 276:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 27a:	0f be 11             	movsbl (%ecx),%edx
 27d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	5b                   	pop    %ebx
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 5d 10             	mov    0x10(%ebp),%ebx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 14                	jle    2b6 <memmove+0x26>
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2b2:	39 d3                	cmp    %edx,%ebx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
  return vdst;
}
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    

000002ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ba:	b8 01 00 00 00       	mov    $0x1,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <exit>:
SYSCALL(exit)
 2c2:	b8 02 00 00 00       	mov    $0x2,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <wait>:
SYSCALL(wait)
 2ca:	b8 03 00 00 00       	mov    $0x3,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <pipe>:
SYSCALL(pipe)
 2d2:	b8 04 00 00 00       	mov    $0x4,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <read>:
SYSCALL(read)
 2da:	b8 05 00 00 00       	mov    $0x5,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <write>:
SYSCALL(write)
 2e2:	b8 10 00 00 00       	mov    $0x10,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <close>:
SYSCALL(close)
 2ea:	b8 15 00 00 00       	mov    $0x15,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <kill>:
SYSCALL(kill)
 2f2:	b8 06 00 00 00       	mov    $0x6,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <exec>:
SYSCALL(exec)
 2fa:	b8 07 00 00 00       	mov    $0x7,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <open>:
SYSCALL(open)
 302:	b8 0f 00 00 00       	mov    $0xf,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mknod>:
SYSCALL(mknod)
 30a:	b8 11 00 00 00       	mov    $0x11,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <unlink>:
SYSCALL(unlink)
 312:	b8 12 00 00 00       	mov    $0x12,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <fstat>:
SYSCALL(fstat)
 31a:	b8 08 00 00 00       	mov    $0x8,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <link>:
SYSCALL(link)
 322:	b8 13 00 00 00       	mov    $0x13,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <mkdir>:
SYSCALL(mkdir)
 32a:	b8 14 00 00 00       	mov    $0x14,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <chdir>:
SYSCALL(chdir)
 332:	b8 09 00 00 00       	mov    $0x9,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <dup>:
SYSCALL(dup)
 33a:	b8 0a 00 00 00       	mov    $0xa,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getpid>:
SYSCALL(getpid)
 342:	b8 0b 00 00 00       	mov    $0xb,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sbrk>:
SYSCALL(sbrk)
 34a:	b8 0c 00 00 00       	mov    $0xc,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <sleep>:
SYSCALL(sleep)
 352:	b8 0d 00 00 00       	mov    $0xd,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <uptime>:
SYSCALL(uptime)
 35a:	b8 0e 00 00 00       	mov    $0xe,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kthread_create>:
SYSCALL(kthread_create)
 362:	b8 16 00 00 00       	mov    $0x16,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <kthread_id>:
SYSCALL(kthread_id)
 36a:	b8 17 00 00 00       	mov    $0x17,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kthread_exit>:
SYSCALL(kthread_exit)
 372:	b8 18 00 00 00       	mov    $0x18,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <kthread_join>:
SYSCALL(kthread_join)
 37a:	b8 19 00 00 00       	mov    $0x19,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 382:	b8 1a 00 00 00       	mov    $0x1a,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 38a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 392:	b8 1c 00 00 00       	mov    $0x1c,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 39a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    
 3a2:	66 90                	xchg   %ax,%ax
 3a4:	66 90                	xchg   %ax,%ax
 3a6:	66 90                	xchg   %ax,%ax
 3a8:	66 90                	xchg   %ax,%ax
 3aa:	66 90                	xchg   %ax,%ax
 3ac:	66 90                	xchg   %ax,%ax
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b9:	85 d2                	test   %edx,%edx
{
 3bb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 3be:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3c0:	79 76                	jns    438 <printint+0x88>
 3c2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3c6:	74 70                	je     438 <printint+0x88>
    x = -xx;
 3c8:	f7 d8                	neg    %eax
    neg = 1;
 3ca:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3d1:	31 f6                	xor    %esi,%esi
 3d3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3d6:	eb 0a                	jmp    3e2 <printint+0x32>
 3d8:	90                   	nop
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	89 fe                	mov    %edi,%esi
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	8d 7e 01             	lea    0x1(%esi),%edi
 3e7:	f7 f1                	div    %ecx
 3e9:	0f b6 92 d0 0b 00 00 	movzbl 0xbd0(%edx),%edx
  }while((x /= base) != 0);
 3f0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3f2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3f5:	75 e9                	jne    3e0 <printint+0x30>
  if(neg)
 3f7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3fa:	85 c0                	test   %eax,%eax
 3fc:	74 08                	je     406 <printint+0x56>
    buf[i++] = '-';
 3fe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 403:	8d 7e 02             	lea    0x2(%esi),%edi
 406:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 40a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 413:	83 ec 04             	sub    $0x4,%esp
 416:	83 ee 01             	sub    $0x1,%esi
 419:	6a 01                	push   $0x1
 41b:	53                   	push   %ebx
 41c:	57                   	push   %edi
 41d:	88 45 d7             	mov    %al,-0x29(%ebp)
 420:	e8 bd fe ff ff       	call   2e2 <write>

  while(--i >= 0)
 425:	83 c4 10             	add    $0x10,%esp
 428:	39 de                	cmp    %ebx,%esi
 42a:	75 e4                	jne    410 <printint+0x60>
    putc(fd, buf[i]);
}
 42c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42f:	5b                   	pop    %ebx
 430:	5e                   	pop    %esi
 431:	5f                   	pop    %edi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 438:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 43f:	eb 90                	jmp    3d1 <printint+0x21>
 441:	eb 0d                	jmp    450 <printf>
 443:	90                   	nop
 444:	90                   	nop
 445:	90                   	nop
 446:	90                   	nop
 447:	90                   	nop
 448:	90                   	nop
 449:	90                   	nop
 44a:	90                   	nop
 44b:	90                   	nop
 44c:	90                   	nop
 44d:	90                   	nop
 44e:	90                   	nop
 44f:	90                   	nop

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 459:	8b 75 0c             	mov    0xc(%ebp),%esi
 45c:	0f b6 1e             	movzbl (%esi),%ebx
 45f:	84 db                	test   %bl,%bl
 461:	0f 84 b3 00 00 00    	je     51a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 467:	8d 45 10             	lea    0x10(%ebp),%eax
 46a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 46d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 46f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 472:	eb 2f                	jmp    4a3 <printf+0x53>
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 478:	83 f8 25             	cmp    $0x25,%eax
 47b:	0f 84 a7 00 00 00    	je     528 <printf+0xd8>
  write(fd, &c, 1);
 481:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 484:	83 ec 04             	sub    $0x4,%esp
 487:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 48a:	6a 01                	push   $0x1
 48c:	50                   	push   %eax
 48d:	ff 75 08             	pushl  0x8(%ebp)
 490:	e8 4d fe ff ff       	call   2e2 <write>
 495:	83 c4 10             	add    $0x10,%esp
 498:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 49b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 49f:	84 db                	test   %bl,%bl
 4a1:	74 77                	je     51a <printf+0xca>
    if(state == 0){
 4a3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4a5:	0f be cb             	movsbl %bl,%ecx
 4a8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4ab:	74 cb                	je     478 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4ad:	83 ff 25             	cmp    $0x25,%edi
 4b0:	75 e6                	jne    498 <printf+0x48>
      if(c == 'd'){
 4b2:	83 f8 64             	cmp    $0x64,%eax
 4b5:	0f 84 05 01 00 00    	je     5c0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4bb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4c1:	83 f9 70             	cmp    $0x70,%ecx
 4c4:	74 72                	je     538 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4c6:	83 f8 73             	cmp    $0x73,%eax
 4c9:	0f 84 99 00 00 00    	je     568 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4cf:	83 f8 63             	cmp    $0x63,%eax
 4d2:	0f 84 08 01 00 00    	je     5e0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4d8:	83 f8 25             	cmp    $0x25,%eax
 4db:	0f 84 ef 00 00 00    	je     5d0 <printf+0x180>
  write(fd, &c, 1);
 4e1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e4:	83 ec 04             	sub    $0x4,%esp
 4e7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4eb:	6a 01                	push   $0x1
 4ed:	50                   	push   %eax
 4ee:	ff 75 08             	pushl  0x8(%ebp)
 4f1:	e8 ec fd ff ff       	call   2e2 <write>
 4f6:	83 c4 0c             	add    $0xc,%esp
 4f9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4fc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4ff:	6a 01                	push   $0x1
 501:	50                   	push   %eax
 502:	ff 75 08             	pushl  0x8(%ebp)
 505:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 508:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 50a:	e8 d3 fd ff ff       	call   2e2 <write>
  for(i = 0; fmt[i]; i++){
 50f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 513:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 516:	84 db                	test   %bl,%bl
 518:	75 89                	jne    4a3 <printf+0x53>
    }
  }
}
 51a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51d:	5b                   	pop    %ebx
 51e:	5e                   	pop    %esi
 51f:	5f                   	pop    %edi
 520:	5d                   	pop    %ebp
 521:	c3                   	ret    
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 528:	bf 25 00 00 00       	mov    $0x25,%edi
 52d:	e9 66 ff ff ff       	jmp    498 <printf+0x48>
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 538:	83 ec 0c             	sub    $0xc,%esp
 53b:	b9 10 00 00 00       	mov    $0x10,%ecx
 540:	6a 00                	push   $0x0
 542:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 545:	8b 45 08             	mov    0x8(%ebp),%eax
 548:	8b 17                	mov    (%edi),%edx
 54a:	e8 61 fe ff ff       	call   3b0 <printint>
        ap++;
 54f:	89 f8                	mov    %edi,%eax
 551:	83 c4 10             	add    $0x10,%esp
      state = 0;
 554:	31 ff                	xor    %edi,%edi
        ap++;
 556:	83 c0 04             	add    $0x4,%eax
 559:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 55c:	e9 37 ff ff ff       	jmp    498 <printf+0x48>
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 568:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 56b:	8b 08                	mov    (%eax),%ecx
        ap++;
 56d:	83 c0 04             	add    $0x4,%eax
 570:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 573:	85 c9                	test   %ecx,%ecx
 575:	0f 84 8e 00 00 00    	je     609 <printf+0x1b9>
        while(*s != 0){
 57b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 57e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 580:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 582:	84 c0                	test   %al,%al
 584:	0f 84 0e ff ff ff    	je     498 <printf+0x48>
 58a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 58d:	89 de                	mov    %ebx,%esi
 58f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 592:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 595:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 598:	83 ec 04             	sub    $0x4,%esp
          s++;
 59b:	83 c6 01             	add    $0x1,%esi
 59e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5a1:	6a 01                	push   $0x1
 5a3:	57                   	push   %edi
 5a4:	53                   	push   %ebx
 5a5:	e8 38 fd ff ff       	call   2e2 <write>
        while(*s != 0){
 5aa:	0f b6 06             	movzbl (%esi),%eax
 5ad:	83 c4 10             	add    $0x10,%esp
 5b0:	84 c0                	test   %al,%al
 5b2:	75 e4                	jne    598 <printf+0x148>
 5b4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 5b7:	31 ff                	xor    %edi,%edi
 5b9:	e9 da fe ff ff       	jmp    498 <printf+0x48>
 5be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5c8:	6a 01                	push   $0x1
 5ca:	e9 73 ff ff ff       	jmp    542 <printf+0xf2>
 5cf:	90                   	nop
  write(fd, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5d6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5d9:	6a 01                	push   $0x1
 5db:	e9 21 ff ff ff       	jmp    501 <printf+0xb1>
        putc(fd, *ap);
 5e0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
        ap++;
 5ea:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5ed:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5f0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5f3:	50                   	push   %eax
 5f4:	ff 75 08             	pushl  0x8(%ebp)
 5f7:	e8 e6 fc ff ff       	call   2e2 <write>
        ap++;
 5fc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5ff:	83 c4 10             	add    $0x10,%esp
      state = 0;
 602:	31 ff                	xor    %edi,%edi
 604:	e9 8f fe ff ff       	jmp    498 <printf+0x48>
          s = "(null)";
 609:	bb c9 0b 00 00       	mov    $0xbc9,%ebx
        while(*s != 0){
 60e:	b8 28 00 00 00       	mov    $0x28,%eax
 613:	e9 72 ff ff ff       	jmp    58a <printf+0x13a>
 618:	66 90                	xchg   %ax,%ax
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 3c 10 00 00       	mov    0x103c,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 638:	39 c8                	cmp    %ecx,%eax
 63a:	8b 10                	mov    (%eax),%edx
 63c:	73 32                	jae    670 <free+0x50>
 63e:	39 d1                	cmp    %edx,%ecx
 640:	72 04                	jb     646 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 642:	39 d0                	cmp    %edx,%eax
 644:	72 32                	jb     678 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 646:	8b 73 fc             	mov    -0x4(%ebx),%esi
 649:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 64c:	39 fa                	cmp    %edi,%edx
 64e:	74 30                	je     680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 650:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 653:	8b 50 04             	mov    0x4(%eax),%edx
 656:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 659:	39 f1                	cmp    %esi,%ecx
 65b:	74 3a                	je     697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 65d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 65f:	a3 3c 10 00 00       	mov    %eax,0x103c
}
 664:	5b                   	pop    %ebx
 665:	5e                   	pop    %esi
 666:	5f                   	pop    %edi
 667:	5d                   	pop    %ebp
 668:	c3                   	ret    
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 670:	39 d0                	cmp    %edx,%eax
 672:	72 04                	jb     678 <free+0x58>
 674:	39 d1                	cmp    %edx,%ecx
 676:	72 ce                	jb     646 <free+0x26>
{
 678:	89 d0                	mov    %edx,%eax
 67a:	eb bc                	jmp    638 <free+0x18>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 680:	03 72 04             	add    0x4(%edx),%esi
 683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	75 c6                	jne    65d <free+0x3d>
    p->s.size += bp->s.size;
 697:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 69a:	a3 3c 10 00 00       	mov    %eax,0x103c
    p->s.size += bp->s.size;
 69f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6a5:	89 10                	mov    %edx,(%eax)
}
 6a7:	5b                   	pop    %ebx
 6a8:	5e                   	pop    %esi
 6a9:	5f                   	pop    %edi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret    
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 15 3c 10 00 00    	mov    0x103c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 78 07             	lea    0x7(%eax),%edi
 6c5:	c1 ef 03             	shr    $0x3,%edi
 6c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6cb:	85 d2                	test   %edx,%edx
 6cd:	0f 84 9d 00 00 00    	je     770 <malloc+0xc0>
 6d3:	8b 02                	mov    (%edx),%eax
 6d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6d8:	39 cf                	cmp    %ecx,%edi
 6da:	76 6c                	jbe    748 <malloc+0x98>
 6dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6e7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ea:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6f1:	eb 0e                	jmp    701 <malloc+0x51>
 6f3:	90                   	nop
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6fa:	8b 48 04             	mov    0x4(%eax),%ecx
 6fd:	39 f9                	cmp    %edi,%ecx
 6ff:	73 47                	jae    748 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 701:	39 05 3c 10 00 00    	cmp    %eax,0x103c
 707:	89 c2                	mov    %eax,%edx
 709:	75 ed                	jne    6f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 70b:	83 ec 0c             	sub    $0xc,%esp
 70e:	56                   	push   %esi
 70f:	e8 36 fc ff ff       	call   34a <sbrk>
  if(p == (char*)-1)
 714:	83 c4 10             	add    $0x10,%esp
 717:	83 f8 ff             	cmp    $0xffffffff,%eax
 71a:	74 1c                	je     738 <malloc+0x88>
  hp->s.size = nu;
 71c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 71f:	83 ec 0c             	sub    $0xc,%esp
 722:	83 c0 08             	add    $0x8,%eax
 725:	50                   	push   %eax
 726:	e8 f5 fe ff ff       	call   620 <free>
  return freep;
 72b:	8b 15 3c 10 00 00    	mov    0x103c,%edx
      if((p = morecore(nunits)) == 0)
 731:	83 c4 10             	add    $0x10,%esp
 734:	85 d2                	test   %edx,%edx
 736:	75 c0                	jne    6f8 <malloc+0x48>
        return 0;
  }
}
 738:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 73b:	31 c0                	xor    %eax,%eax
}
 73d:	5b                   	pop    %ebx
 73e:	5e                   	pop    %esi
 73f:	5f                   	pop    %edi
 740:	5d                   	pop    %ebp
 741:	c3                   	ret    
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 748:	39 cf                	cmp    %ecx,%edi
 74a:	74 54                	je     7a0 <malloc+0xf0>
        p->s.size -= nunits;
 74c:	29 f9                	sub    %edi,%ecx
 74e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 751:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 754:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 757:	89 15 3c 10 00 00    	mov    %edx,0x103c
}
 75d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 760:	83 c0 08             	add    $0x8,%eax
}
 763:	5b                   	pop    %ebx
 764:	5e                   	pop    %esi
 765:	5f                   	pop    %edi
 766:	5d                   	pop    %ebp
 767:	c3                   	ret    
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 770:	c7 05 3c 10 00 00 40 	movl   $0x1040,0x103c
 777:	10 00 00 
 77a:	c7 05 40 10 00 00 40 	movl   $0x1040,0x1040
 781:	10 00 00 
    base.s.size = 0;
 784:	b8 40 10 00 00       	mov    $0x1040,%eax
 789:	c7 05 44 10 00 00 00 	movl   $0x0,0x1044
 790:	00 00 00 
 793:	e9 44 ff ff ff       	jmp    6dc <malloc+0x2c>
 798:	90                   	nop
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7a0:	8b 08                	mov    (%eax),%ecx
 7a2:	89 0a                	mov    %ecx,(%edx)
 7a4:	eb b1                	jmp    757 <malloc+0xa7>
 7a6:	66 90                	xchg   %ax,%ax
 7a8:	66 90                	xchg   %ax,%ax
 7aa:	66 90                	xchg   %ax,%ax
 7ac:	66 90                	xchg   %ax,%ax
 7ae:	66 90                	xchg   %ax,%ax

000007b0 <create_tree>:
}

int index = 0;
int curLevel = -2;

void create_tree(struct tree_node* node, int depth){
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 1c             	sub    $0x1c,%esp
 7b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
 7bf:	85 f6                	test   %esi,%esi
 7c1:	0f 84 8a 00 00 00    	je     851 <create_tree+0xa1>
 7c7:	8d 04 b5 fc ff ff ff 	lea    -0x4(,%esi,4),%eax
 7ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7d1:	8d 4e fe             	lea    -0x2(%esi),%ecx
 7d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 7d7:	03 15 50 10 00 00    	add    0x1050,%edx
        return;
    }
    if(curLevel != depth-2){
 7dd:	39 0d 38 10 00 00    	cmp    %ecx,0x1038
 7e3:	a1 48 10 00 00       	mov    0x1048,%eax
 7e8:	74 08                	je     7f2 <create_tree+0x42>
        index = level_index[depth-1];
 7ea:	8b 02                	mov    (%edx),%eax
        curLevel = depth-2;
 7ec:	89 0d 38 10 00 00    	mov    %ecx,0x1038
    }
    node->level = curLevel;
    node->index = index;
 7f2:	89 43 10             	mov    %eax,0x10(%ebx)
    index++;
 7f5:	83 c0 01             	add    $0x1,%eax
    level_index[depth-1] = index;
    if(depth == 1){
 7f8:	83 fe 01             	cmp    $0x1,%esi
    node->level = curLevel;
 7fb:	89 4b 14             	mov    %ecx,0x14(%ebx)
    index++;
 7fe:	a3 48 10 00 00       	mov    %eax,0x1048
    level_index[depth-1] = index;
 803:	89 02                	mov    %eax,(%edx)
    if(depth == 1){
 805:	74 59                	je     860 <create_tree+0xb0>
        node->left_child = 0;
        node->right_child = 0;
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    }else{
        struct tree_node *left = malloc(sizeof(struct tree_node));
 807:	83 ec 0c             	sub    $0xc,%esp
        left->parent = node;
        right->parent = node;
        node->left_child = left;
        node->right_child = right;
        node->mutex_id = kthread_mutex_alloc();
        create_tree(left, depth-1);
 80a:	83 ee 01             	sub    $0x1,%esi
        struct tree_node *left = malloc(sizeof(struct tree_node));
 80d:	6a 1c                	push   $0x1c
 80f:	e8 9c fe ff ff       	call   6b0 <malloc>
 814:	89 c7                	mov    %eax,%edi
        struct tree_node *right = malloc(sizeof(struct tree_node));
 816:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
 81d:	e8 8e fe ff ff       	call   6b0 <malloc>
        left->parent = node;
 822:	89 5f 08             	mov    %ebx,0x8(%edi)
        right->parent = node;
 825:	89 58 08             	mov    %ebx,0x8(%eax)
        node->left_child = left;
 828:	89 3b                	mov    %edi,(%ebx)
        node->right_child = right;
 82a:	89 43 04             	mov    %eax,0x4(%ebx)
 82d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        node->mutex_id = kthread_mutex_alloc();
 830:	e8 4d fb ff ff       	call   382 <kthread_mutex_alloc>
 835:	89 43 0c             	mov    %eax,0xc(%ebx)
        create_tree(left, depth-1);
 838:	58                   	pop    %eax
 839:	5a                   	pop    %edx
 83a:	56                   	push   %esi
 83b:	57                   	push   %edi
 83c:	e8 6f ff ff ff       	call   7b0 <create_tree>
 841:	8b 55 e0             	mov    -0x20(%ebp),%edx
 844:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
    if(depth == 0){
 848:	83 c4 10             	add    $0x10,%esp
 84b:	85 f6                	test   %esi,%esi
 84d:	89 d3                	mov    %edx,%ebx
 84f:	75 80                	jne    7d1 <create_tree+0x21>
        create_tree(right, depth-1);
    }
    return;
}
 851:	8d 65 f4             	lea    -0xc(%ebp),%esp
 854:	5b                   	pop    %ebx
 855:	5e                   	pop    %esi
 856:	5f                   	pop    %edi
 857:	5d                   	pop    %ebp
 858:	c3                   	ret    
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        node->left_child = 0;
 860:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 866:	a1 4c 10 00 00       	mov    0x104c,%eax
 86b:	83 ec 0c             	sub    $0xc,%esp
        node->right_child = 0;
 86e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 875:	c1 e0 02             	shl    $0x2,%eax
 878:	50                   	push   %eax
 879:	e8 32 fe ff ff       	call   6b0 <malloc>
 87e:	83 c4 10             	add    $0x10,%esp
 881:	89 43 18             	mov    %eax,0x18(%ebx)
}
 884:	8d 65 f4             	lea    -0xc(%ebp),%esp
 887:	5b                   	pop    %ebx
 888:	5e                   	pop    %esi
 889:	5f                   	pop    %edi
 88a:	5d                   	pop    %ebp
 88b:	c3                   	ret    
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000890 <trnmnt_tree_alloc>:
trnmnt_tree* trnmnt_tree_alloc(int depth){
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	56                   	push   %esi
 894:	53                   	push   %ebx
 895:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth < 1) // illegal depth
 898:	85 db                	test   %ebx,%ebx
 89a:	7e 74                	jle    910 <trnmnt_tree_alloc+0x80>
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 89c:	83 ec 0c             	sub    $0xc,%esp
 89f:	6a 08                	push   $0x8
 8a1:	e8 0a fe ff ff       	call   6b0 <malloc>
    struct tree_node *root = malloc(sizeof(struct tree_node));
 8a6:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 8ad:	89 c6                	mov    %eax,%esi
    struct tree_node *root = malloc(sizeof(struct tree_node));
 8af:	e8 fc fd ff ff       	call   6b0 <malloc>
    int arr[depth+1];
 8b4:	8d 53 01             	lea    0x1(%ebx),%edx
    treeDepth = depth;
 8b7:	89 1d 4c 10 00 00    	mov    %ebx,0x104c
    tree->depth = depth;
 8bd:	89 5e 04             	mov    %ebx,0x4(%esi)
    tree->root = root;
 8c0:	89 06                	mov    %eax,(%esi)
    root->parent = 0;
 8c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    int arr[depth+1];
 8c9:	83 c4 10             	add    $0x10,%esp
 8cc:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
 8d3:	83 e0 f0             	and    $0xfffffff0,%eax
 8d6:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < depth+1; i++)
 8d8:	31 c0                	xor    %eax,%eax
    int arr[depth+1];
 8da:	89 e1                	mov    %esp,%ecx
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        arr[i] = 0;
 8e0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    for(int i = 0; i < depth+1; i++)
 8e7:	83 c0 01             	add    $0x1,%eax
 8ea:	39 c2                	cmp    %eax,%edx
 8ec:	75 f2                	jne    8e0 <trnmnt_tree_alloc+0x50>
    create_tree(tree->root, depth+1);
 8ee:	83 ec 08             	sub    $0x8,%esp
    level_index = arr;
 8f1:	89 0d 50 10 00 00    	mov    %ecx,0x1050
    create_tree(tree->root, depth+1);
 8f7:	52                   	push   %edx
 8f8:	ff 36                	pushl  (%esi)
 8fa:	e8 b1 fe ff ff       	call   7b0 <create_tree>
    return tree;
 8ff:	83 c4 10             	add    $0x10,%esp
}
 902:	8d 65 f8             	lea    -0x8(%ebp),%esp
 905:	89 f0                	mov    %esi,%eax
 907:	5b                   	pop    %ebx
 908:	5e                   	pop    %esi
 909:	5d                   	pop    %ebp
 90a:	c3                   	ret    
 90b:	90                   	nop
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 910:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return 0;
 913:	31 f6                	xor    %esi,%esi
}
 915:	89 f0                	mov    %esi,%eax
 917:	5b                   	pop    %ebx
 918:	5e                   	pop    %esi
 919:	5d                   	pop    %ebp
 91a:	c3                   	ret    
 91b:	90                   	nop
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000920 <print_node>:

void print_node(struct tree_node *n,int l){
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 1c             	sub    $0x1c,%esp
 929:	8b 75 08             	mov    0x8(%ebp),%esi
 92c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
 92f:	85 f6                	test   %esi,%esi
 931:	74 5a                	je     98d <print_node+0x6d>
    int i;
	print_node(n->right_child,l+1);
 933:	8d 43 01             	lea    0x1(%ebx),%eax
 936:	83 ec 08             	sub    $0x8,%esp
 939:	50                   	push   %eax
 93a:	ff 76 04             	pushl  0x4(%esi)
 93d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 940:	e8 db ff ff ff       	call   920 <print_node>
	for(i=0;i<l;++i){
 945:	83 c4 10             	add    $0x10,%esp
 948:	85 db                	test   %ebx,%ebx
 94a:	7e 1d                	jle    969 <print_node+0x49>
 94c:	31 ff                	xor    %edi,%edi
 94e:	66 90                	xchg   %ax,%ax
		printf(1,"    ");
 950:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
 953:	83 c7 01             	add    $0x1,%edi
		printf(1,"    ");
 956:	68 e1 0b 00 00       	push   $0xbe1
 95b:	6a 01                	push   $0x1
 95d:	e8 ee fa ff ff       	call   450 <printf>
	for(i=0;i<l;++i){
 962:	83 c4 10             	add    $0x10,%esp
 965:	39 df                	cmp    %ebx,%edi
 967:	75 e7                	jne    950 <print_node+0x30>
    }
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
 969:	83 ec 0c             	sub    $0xc,%esp
 96c:	ff 76 0c             	pushl  0xc(%esi)
 96f:	ff 76 10             	pushl  0x10(%esi)
 972:	ff 76 14             	pushl  0x14(%esi)
 975:	68 e6 0b 00 00       	push   $0xbe6
 97a:	6a 01                	push   $0x1
 97c:	e8 cf fa ff ff       	call   450 <printf>
	print_node(n->left_child,l+1);
 981:	8b 36                	mov    (%esi),%esi
	if(!n) return;
 983:	83 c4 20             	add    $0x20,%esp
	print_node(n->left_child,l+1);
 986:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
 989:	85 f6                	test   %esi,%esi
 98b:	75 a6                	jne    933 <print_node+0x13>
}
 98d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 990:	5b                   	pop    %ebx
 991:	5e                   	pop    %esi
 992:	5f                   	pop    %edi
 993:	5d                   	pop    %ebp
 994:	c3                   	ret    
 995:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <print_tree>:

void print_tree(trnmnt_tree *t){
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	83 ec 08             	sub    $0x8,%esp
 9a6:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
 9a9:	85 c0                	test   %eax,%eax
 9ab:	74 0f                	je     9bc <print_tree+0x1c>
	print_node(t->root,0);
 9ad:	83 ec 08             	sub    $0x8,%esp
 9b0:	6a 00                	push   $0x0
 9b2:	ff 30                	pushl  (%eax)
 9b4:	e8 67 ff ff ff       	call   920 <print_node>
 9b9:	83 c4 10             	add    $0x10,%esp
}
 9bc:	c9                   	leave  
 9bd:	c3                   	ret    
 9be:	66 90                	xchg   %ax,%ax

000009c0 <delete_node>:

int delete_node(struct tree_node *node){
 9c0:	55                   	push   %ebp
            node->lockPath = 0;
        }
        // then delete the node
        free(node); 
    }
    return 0;
 9c1:	31 c0                	xor    %eax,%eax
int delete_node(struct tree_node *node){
 9c3:	89 e5                	mov    %esp,%ebp
 9c5:	53                   	push   %ebx
 9c6:	83 ec 04             	sub    $0x4,%esp
 9c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (node != 0){ 
 9cc:	85 db                	test   %ebx,%ebx
 9ce:	74 5e                	je     a2e <delete_node+0x6e>
        if(kthread_mutex_dealloc(node->mutex_id) == -1){
 9d0:	83 ec 0c             	sub    $0xc,%esp
 9d3:	ff 73 0c             	pushl  0xc(%ebx)
 9d6:	e8 af f9 ff ff       	call   38a <kthread_mutex_dealloc>
 9db:	83 c4 10             	add    $0x10,%esp
 9de:	83 f8 ff             	cmp    $0xffffffff,%eax
 9e1:	74 4b                	je     a2e <delete_node+0x6e>
        delete_node(node->left_child); 
 9e3:	83 ec 0c             	sub    $0xc,%esp
 9e6:	ff 33                	pushl  (%ebx)
 9e8:	e8 d3 ff ff ff       	call   9c0 <delete_node>
        delete_node(node->right_child); 
 9ed:	58                   	pop    %eax
 9ee:	ff 73 04             	pushl  0x4(%ebx)
 9f1:	e8 ca ff ff ff       	call   9c0 <delete_node>
        if(node->lockPath){
 9f6:	8b 43 18             	mov    0x18(%ebx),%eax
 9f9:	83 c4 10             	add    $0x10,%esp
        node->left_child = 0;
 9fc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
 a02:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        if(node->lockPath){
 a09:	85 c0                	test   %eax,%eax
 a0b:	74 13                	je     a20 <delete_node+0x60>
            free(node->lockPath);
 a0d:	83 ec 0c             	sub    $0xc,%esp
 a10:	50                   	push   %eax
 a11:	e8 0a fc ff ff       	call   620 <free>
            node->lockPath = 0;
 a16:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
 a1d:	83 c4 10             	add    $0x10,%esp
        free(node); 
 a20:	83 ec 0c             	sub    $0xc,%esp
 a23:	53                   	push   %ebx
 a24:	e8 f7 fb ff ff       	call   620 <free>
 a29:	83 c4 10             	add    $0x10,%esp
 a2c:	31 c0                	xor    %eax,%eax
}
 a2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a31:	c9                   	leave  
 a32:	c3                   	ret    
 a33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a40 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(trnmnt_tree* tree){
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	56                   	push   %esi
 a44:	53                   	push   %ebx
 a45:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
 a48:	83 ec 0c             	sub    $0xc,%esp
 a4b:	ff 33                	pushl  (%ebx)
 a4d:	e8 6e ff ff ff       	call   9c0 <delete_node>
 a52:	83 c4 10             	add    $0x10,%esp
 a55:	85 c0                	test   %eax,%eax
 a57:	75 27                	jne    a80 <trnmnt_tree_dealloc+0x40>
        tree->root = 0;
        free(tree);
 a59:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
 a5c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
 a62:	89 c6                	mov    %eax,%esi
        free(tree);
 a64:	53                   	push   %ebx
 a65:	e8 b6 fb ff ff       	call   620 <free>
        tree = 0;
        return 0;
 a6a:	83 c4 10             	add    $0x10,%esp
    }else{
        return -1;
    }
}
 a6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a70:	89 f0                	mov    %esi,%eax
 a72:	5b                   	pop    %ebx
 a73:	5e                   	pop    %esi
 a74:	5d                   	pop    %ebp
 a75:	c3                   	ret    
 a76:	8d 76 00             	lea    0x0(%esi),%esi
 a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
 a80:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a85:	eb e6                	jmp    a6d <trnmnt_tree_dealloc+0x2d>
 a87:	89 f6                	mov    %esi,%esi
 a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a90 <find_leaf>:
        leaf->lockPath[i] = 0;
    }
    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 0c             	sub    $0xc,%esp
 a99:	8b 55 08             	mov    0x8(%ebp),%edx
 a9c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if(node->right_child == 0 && node->left_child == 0){ 
 a9f:	8b 72 04             	mov    0x4(%edx),%esi
 aa2:	8b 02                	mov    (%edx),%eax
 aa4:	85 f6                	test   %esi,%esi
 aa6:	75 18                	jne    ac0 <find_leaf+0x30>
 aa8:	85 c0                	test   %eax,%eax
 aaa:	75 14                	jne    ac0 <find_leaf+0x30>
        if(ID == node->index){
 aac:	39 5a 10             	cmp    %ebx,0x10(%edx)
 aaf:	0f 44 c2             	cmove  %edx,%eax
        if(leaf1)
            return leaf1;
        else
            return leaf2;
    }
} 
 ab2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ab5:	5b                   	pop    %ebx
 ab6:	5e                   	pop    %esi
 ab7:	5f                   	pop    %edi
 ab8:	5d                   	pop    %ebp
 ab9:	c3                   	ret    
 aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 ac0:	83 ec 08             	sub    $0x8,%esp
 ac3:	53                   	push   %ebx
 ac4:	50                   	push   %eax
 ac5:	e8 c6 ff ff ff       	call   a90 <find_leaf>
 aca:	5a                   	pop    %edx
 acb:	59                   	pop    %ecx
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 acc:	53                   	push   %ebx
 acd:	56                   	push   %esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 ace:	89 c7                	mov    %eax,%edi
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 ad0:	e8 bb ff ff ff       	call   a90 <find_leaf>
 ad5:	83 c4 10             	add    $0x10,%esp
        if(leaf1)
 ad8:	85 ff                	test   %edi,%edi
 ada:	0f 45 c7             	cmovne %edi,%eax
} 
 add:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ae0:	5b                   	pop    %ebx
 ae1:	5e                   	pop    %esi
 ae2:	5f                   	pop    %edi
 ae3:	5d                   	pop    %ebp
 ae4:	c3                   	ret    
 ae5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000af0 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
 af0:	55                   	push   %ebp
 af1:	89 e5                	mov    %esp,%ebp
 af3:	57                   	push   %edi
 af4:	56                   	push   %esi
 af5:	53                   	push   %ebx
 af6:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 af9:	8b 45 08             	mov    0x8(%ebp),%eax
 afc:	ff 75 0c             	pushl  0xc(%ebp)
 aff:	ff 30                	pushl  (%eax)
 b01:	e8 8a ff ff ff       	call   a90 <find_leaf>
 b06:	8b 50 08             	mov    0x8(%eax),%edx
 b09:	83 c4 10             	add    $0x10,%esp
 b0c:	89 c7                	mov    %eax,%edi
    while(curNode->parent){
 b0e:	89 c3                	mov    %eax,%ebx
 b10:	85 d2                	test   %edx,%edx
 b12:	74 32                	je     b46 <trnmnt_tree_acquire+0x56>
        int level = curNode->parent->level;
 b14:	8b 72 14             	mov    0x14(%edx),%esi
        int mutex_lock = kthread_mutex_lock(mutexID);
 b17:	83 ec 0c             	sub    $0xc,%esp
 b1a:	ff 72 0c             	pushl  0xc(%edx)
 b1d:	e8 70 f8 ff ff       	call   392 <kthread_mutex_lock>
        leaf->lockPath[level] = curNode->parent->mutex_id;
 b22:	8b 53 08             	mov    0x8(%ebx),%edx
        if(mutex_lock == -1){
 b25:	83 c4 10             	add    $0x10,%esp
 b28:	83 f8 ff             	cmp    $0xffffffff,%eax
        leaf->lockPath[level] = curNode->parent->mutex_id;
 b2b:	8b 4a 0c             	mov    0xc(%edx),%ecx
 b2e:	8b 57 18             	mov    0x18(%edi),%edx
 b31:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
        if(mutex_lock == -1){
 b34:	74 12                	je     b48 <trnmnt_tree_acquire+0x58>
        if(mutex_lock == 0){
 b36:	85 c0                	test   %eax,%eax
 b38:	8b 53 08             	mov    0x8(%ebx),%edx
 b3b:	75 d3                	jne    b10 <trnmnt_tree_acquire+0x20>
 b3d:	89 d3                	mov    %edx,%ebx
 b3f:	8b 52 08             	mov    0x8(%edx),%edx
    while(curNode->parent){
 b42:	85 d2                	test   %edx,%edx
 b44:	75 ce                	jne    b14 <trnmnt_tree_acquire+0x24>
    return 0;
 b46:	31 c0                	xor    %eax,%eax
}
 b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b4b:	5b                   	pop    %ebx
 b4c:	5e                   	pop    %esi
 b4d:	5f                   	pop    %edi
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret    

00000b50 <trnmnt_tree_release>:
int trnmnt_tree_release(trnmnt_tree* tree,int ID){
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b59:	8b 45 08             	mov    0x8(%ebp),%eax
 b5c:	ff 75 0c             	pushl  0xc(%ebp)
 b5f:	ff 30                	pushl  (%eax)
 b61:	e8 2a ff ff ff       	call   a90 <find_leaf>
    for(int i = treeDepth-1; i >= 0; i--){
 b66:	8b 35 4c 10 00 00    	mov    0x104c,%esi
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b6c:	83 c4 10             	add    $0x10,%esp
    for(int i = treeDepth-1; i >= 0; i--){
 b6f:	83 ee 01             	sub    $0x1,%esi
 b72:	78 44                	js     bb8 <trnmnt_tree_release+0x68>
 b74:	89 c7                	mov    %eax,%edi
 b76:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
 b7d:	eb 16                	jmp    b95 <trnmnt_tree_release+0x45>
 b7f:	90                   	nop
        leaf->lockPath[i] = 0;
 b80:	8b 47 18             	mov    0x18(%edi),%eax
    for(int i = treeDepth-1; i >= 0; i--){
 b83:	83 ee 01             	sub    $0x1,%esi
        leaf->lockPath[i] = 0;
 b86:	c7 04 18 00 00 00 00 	movl   $0x0,(%eax,%ebx,1)
 b8d:	83 eb 04             	sub    $0x4,%ebx
    for(int i = treeDepth-1; i >= 0; i--){
 b90:	83 fe ff             	cmp    $0xffffffff,%esi
 b93:	74 23                	je     bb8 <trnmnt_tree_release+0x68>
        int res = kthread_mutex_unlock(leaf->lockPath[i]);
 b95:	8b 47 18             	mov    0x18(%edi),%eax
 b98:	83 ec 0c             	sub    $0xc,%esp
 b9b:	ff 34 18             	pushl  (%eax,%ebx,1)
 b9e:	e8 f7 f7 ff ff       	call   39a <kthread_mutex_unlock>
        if(res == -1){
 ba3:	83 c4 10             	add    $0x10,%esp
 ba6:	83 f8 ff             	cmp    $0xffffffff,%eax
 ba9:	75 d5                	jne    b80 <trnmnt_tree_release+0x30>
}
 bab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bae:	5b                   	pop    %ebx
 baf:	5e                   	pop    %esi
 bb0:	5f                   	pop    %edi
 bb1:	5d                   	pop    %ebp
 bb2:	c3                   	ret    
 bb3:	90                   	nop
 bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 bbb:	31 c0                	xor    %eax,%eax
}
 bbd:	5b                   	pop    %ebx
 bbe:	5e                   	pop    %esi
 bbf:	5f                   	pop    %edi
 bc0:	5d                   	pop    %ebp
 bc1:	c3                   	ret    
