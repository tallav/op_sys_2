
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 2c                	jle    49 <main+0x49>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 0b 02 00 00       	call   240 <atoi>
  35:	89 04 24             	mov    %eax,(%esp)
  38:	e8 a5 02 00 00       	call   2e2 <kill>
  for(i=1; i<argc; i++)
  3d:	83 c4 10             	add    $0x10,%esp
  40:	39 f3                	cmp    %esi,%ebx
  42:	75 e4                	jne    28 <main+0x28>
  exit();
  44:	e8 69 02 00 00       	call   2b2 <exit>
    printf(2, "usage: kill pid...\n");
  49:	50                   	push   %eax
  4a:	50                   	push   %eax
  4b:	68 b4 0b 00 00       	push   $0xbb4
  50:	6a 02                	push   $0x2
  52:	e8 e9 03 00 00       	call   440 <printf>
    exit();
  57:	e8 56 02 00 00       	call   2b2 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b6:	83 c1 01             	add    $0x1,%ecx
  b9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  bc:	84 c0                	test   %al,%al
  be:	74 10                	je     d0 <strcmp+0x40>
  c0:	38 d8                	cmp    %bl,%al
  c2:	74 ec                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c4:	29 d8                	sub    %ebx,%eax
}
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1d                	je     15e <strchr+0x2e>
    if(*s == c)
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d9                	mov    %ebx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	31 f6                	xor    %esi,%esi
 178:	89 f3                	mov    %esi,%ebx
{
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 188:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 32 01 00 00       	call   2ca <read>
    if(cc < 1)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	89 fe                	mov    %edi,%esi
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	8b 75 08             	mov    0x8(%ebp),%esi
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 de                	add    %ebx,%esi
 1d8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1da:	c6 03 00             	movb   $0x0,(%ebx)
}
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 f0 00 00 00       	call   2f2 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 f3 00 00 00       	call   30a <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 b9 00 00 00       	call   2da <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 1f                	ja     275 <atoi+0x35>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 260:	8d 04 80             	lea    (%eax,%eax,4),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 26a:	0f be 11             	movsbl (%ecx),%edx
 26d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 5d 10             	mov    0x10(%ebp),%ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2a2:	39 d3                	cmp    %edx,%ebx
 2a4:	75 f2                	jne    298 <memmove+0x18>
  return vdst;
}
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    

000002aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2aa:	b8 01 00 00 00       	mov    $0x1,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <exit>:
SYSCALL(exit)
 2b2:	b8 02 00 00 00       	mov    $0x2,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <wait>:
SYSCALL(wait)
 2ba:	b8 03 00 00 00       	mov    $0x3,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <pipe>:
SYSCALL(pipe)
 2c2:	b8 04 00 00 00       	mov    $0x4,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <read>:
SYSCALL(read)
 2ca:	b8 05 00 00 00       	mov    $0x5,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <write>:
SYSCALL(write)
 2d2:	b8 10 00 00 00       	mov    $0x10,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <close>:
SYSCALL(close)
 2da:	b8 15 00 00 00       	mov    $0x15,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <kill>:
SYSCALL(kill)
 2e2:	b8 06 00 00 00       	mov    $0x6,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <exec>:
SYSCALL(exec)
 2ea:	b8 07 00 00 00       	mov    $0x7,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <open>:
SYSCALL(open)
 2f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mknod>:
SYSCALL(mknod)
 2fa:	b8 11 00 00 00       	mov    $0x11,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <unlink>:
SYSCALL(unlink)
 302:	b8 12 00 00 00       	mov    $0x12,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <fstat>:
SYSCALL(fstat)
 30a:	b8 08 00 00 00       	mov    $0x8,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <link>:
SYSCALL(link)
 312:	b8 13 00 00 00       	mov    $0x13,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mkdir>:
SYSCALL(mkdir)
 31a:	b8 14 00 00 00       	mov    $0x14,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <chdir>:
SYSCALL(chdir)
 322:	b8 09 00 00 00       	mov    $0x9,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <dup>:
SYSCALL(dup)
 32a:	b8 0a 00 00 00       	mov    $0xa,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getpid>:
SYSCALL(getpid)
 332:	b8 0b 00 00 00       	mov    $0xb,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <sbrk>:
SYSCALL(sbrk)
 33a:	b8 0c 00 00 00       	mov    $0xc,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sleep>:
SYSCALL(sleep)
 342:	b8 0d 00 00 00       	mov    $0xd,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <uptime>:
SYSCALL(uptime)
 34a:	b8 0e 00 00 00       	mov    $0xe,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <kthread_create>:
SYSCALL(kthread_create)
 352:	b8 16 00 00 00       	mov    $0x16,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <kthread_id>:
SYSCALL(kthread_id)
 35a:	b8 17 00 00 00       	mov    $0x17,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kthread_exit>:
SYSCALL(kthread_exit)
 362:	b8 18 00 00 00       	mov    $0x18,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <kthread_join>:
SYSCALL(kthread_join)
 36a:	b8 19 00 00 00       	mov    $0x19,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 372:	b8 1a 00 00 00       	mov    $0x1a,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 37a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 382:	b8 1c 00 00 00       	mov    $0x1c,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 38a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    
 392:	66 90                	xchg   %ax,%ax
 394:	66 90                	xchg   %ax,%ax
 396:	66 90                	xchg   %ax,%ax
 398:	66 90                	xchg   %ax,%ax
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a9:	85 d2                	test   %edx,%edx
{
 3ab:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 3ae:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3b0:	79 76                	jns    428 <printint+0x88>
 3b2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3b6:	74 70                	je     428 <printint+0x88>
    x = -xx;
 3b8:	f7 d8                	neg    %eax
    neg = 1;
 3ba:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3c1:	31 f6                	xor    %esi,%esi
 3c3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3c6:	eb 0a                	jmp    3d2 <printint+0x32>
 3c8:	90                   	nop
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3d0:	89 fe                	mov    %edi,%esi
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	8d 7e 01             	lea    0x1(%esi),%edi
 3d7:	f7 f1                	div    %ecx
 3d9:	0f b6 92 d0 0b 00 00 	movzbl 0xbd0(%edx),%edx
  }while((x /= base) != 0);
 3e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3e2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3e5:	75 e9                	jne    3d0 <printint+0x30>
  if(neg)
 3e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3ea:	85 c0                	test   %eax,%eax
 3ec:	74 08                	je     3f6 <printint+0x56>
    buf[i++] = '-';
 3ee:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3f3:	8d 7e 02             	lea    0x2(%esi),%edi
 3f6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3fa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 403:	83 ec 04             	sub    $0x4,%esp
 406:	83 ee 01             	sub    $0x1,%esi
 409:	6a 01                	push   $0x1
 40b:	53                   	push   %ebx
 40c:	57                   	push   %edi
 40d:	88 45 d7             	mov    %al,-0x29(%ebp)
 410:	e8 bd fe ff ff       	call   2d2 <write>

  while(--i >= 0)
 415:	83 c4 10             	add    $0x10,%esp
 418:	39 de                	cmp    %ebx,%esi
 41a:	75 e4                	jne    400 <printint+0x60>
    putc(fd, buf[i]);
}
 41c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41f:	5b                   	pop    %ebx
 420:	5e                   	pop    %esi
 421:	5f                   	pop    %edi
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 428:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 42f:	eb 90                	jmp    3c1 <printint+0x21>
 431:	eb 0d                	jmp    440 <printf>
 433:	90                   	nop
 434:	90                   	nop
 435:	90                   	nop
 436:	90                   	nop
 437:	90                   	nop
 438:	90                   	nop
 439:	90                   	nop
 43a:	90                   	nop
 43b:	90                   	nop
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 449:	8b 75 0c             	mov    0xc(%ebp),%esi
 44c:	0f b6 1e             	movzbl (%esi),%ebx
 44f:	84 db                	test   %bl,%bl
 451:	0f 84 b3 00 00 00    	je     50a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 457:	8d 45 10             	lea    0x10(%ebp),%eax
 45a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 45d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 45f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 462:	eb 2f                	jmp    493 <printf+0x53>
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 468:	83 f8 25             	cmp    $0x25,%eax
 46b:	0f 84 a7 00 00 00    	je     518 <printf+0xd8>
  write(fd, &c, 1);
 471:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 474:	83 ec 04             	sub    $0x4,%esp
 477:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 47a:	6a 01                	push   $0x1
 47c:	50                   	push   %eax
 47d:	ff 75 08             	pushl  0x8(%ebp)
 480:	e8 4d fe ff ff       	call   2d2 <write>
 485:	83 c4 10             	add    $0x10,%esp
 488:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 48b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 48f:	84 db                	test   %bl,%bl
 491:	74 77                	je     50a <printf+0xca>
    if(state == 0){
 493:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 495:	0f be cb             	movsbl %bl,%ecx
 498:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 49b:	74 cb                	je     468 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 49d:	83 ff 25             	cmp    $0x25,%edi
 4a0:	75 e6                	jne    488 <printf+0x48>
      if(c == 'd'){
 4a2:	83 f8 64             	cmp    $0x64,%eax
 4a5:	0f 84 05 01 00 00    	je     5b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4ab:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4b1:	83 f9 70             	cmp    $0x70,%ecx
 4b4:	74 72                	je     528 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4b6:	83 f8 73             	cmp    $0x73,%eax
 4b9:	0f 84 99 00 00 00    	je     558 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4bf:	83 f8 63             	cmp    $0x63,%eax
 4c2:	0f 84 08 01 00 00    	je     5d0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4c8:	83 f8 25             	cmp    $0x25,%eax
 4cb:	0f 84 ef 00 00 00    	je     5c0 <printf+0x180>
  write(fd, &c, 1);
 4d1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d4:	83 ec 04             	sub    $0x4,%esp
 4d7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4db:	6a 01                	push   $0x1
 4dd:	50                   	push   %eax
 4de:	ff 75 08             	pushl  0x8(%ebp)
 4e1:	e8 ec fd ff ff       	call   2d2 <write>
 4e6:	83 c4 0c             	add    $0xc,%esp
 4e9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4ec:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4ef:	6a 01                	push   $0x1
 4f1:	50                   	push   %eax
 4f2:	ff 75 08             	pushl  0x8(%ebp)
 4f5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4fa:	e8 d3 fd ff ff       	call   2d2 <write>
  for(i = 0; fmt[i]; i++){
 4ff:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 503:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 506:	84 db                	test   %bl,%bl
 508:	75 89                	jne    493 <printf+0x53>
    }
  }
}
 50a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50d:	5b                   	pop    %ebx
 50e:	5e                   	pop    %esi
 50f:	5f                   	pop    %edi
 510:	5d                   	pop    %ebp
 511:	c3                   	ret    
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 518:	bf 25 00 00 00       	mov    $0x25,%edi
 51d:	e9 66 ff ff ff       	jmp    488 <printf+0x48>
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 528:	83 ec 0c             	sub    $0xc,%esp
 52b:	b9 10 00 00 00       	mov    $0x10,%ecx
 530:	6a 00                	push   $0x0
 532:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 535:	8b 45 08             	mov    0x8(%ebp),%eax
 538:	8b 17                	mov    (%edi),%edx
 53a:	e8 61 fe ff ff       	call   3a0 <printint>
        ap++;
 53f:	89 f8                	mov    %edi,%eax
 541:	83 c4 10             	add    $0x10,%esp
      state = 0;
 544:	31 ff                	xor    %edi,%edi
        ap++;
 546:	83 c0 04             	add    $0x4,%eax
 549:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 54c:	e9 37 ff ff ff       	jmp    488 <printf+0x48>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 558:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 55b:	8b 08                	mov    (%eax),%ecx
        ap++;
 55d:	83 c0 04             	add    $0x4,%eax
 560:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 563:	85 c9                	test   %ecx,%ecx
 565:	0f 84 8e 00 00 00    	je     5f9 <printf+0x1b9>
        while(*s != 0){
 56b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 56e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 570:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 572:	84 c0                	test   %al,%al
 574:	0f 84 0e ff ff ff    	je     488 <printf+0x48>
 57a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 57d:	89 de                	mov    %ebx,%esi
 57f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 582:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 585:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 588:	83 ec 04             	sub    $0x4,%esp
          s++;
 58b:	83 c6 01             	add    $0x1,%esi
 58e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 591:	6a 01                	push   $0x1
 593:	57                   	push   %edi
 594:	53                   	push   %ebx
 595:	e8 38 fd ff ff       	call   2d2 <write>
        while(*s != 0){
 59a:	0f b6 06             	movzbl (%esi),%eax
 59d:	83 c4 10             	add    $0x10,%esp
 5a0:	84 c0                	test   %al,%al
 5a2:	75 e4                	jne    588 <printf+0x148>
 5a4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 5a7:	31 ff                	xor    %edi,%edi
 5a9:	e9 da fe ff ff       	jmp    488 <printf+0x48>
 5ae:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b8:	6a 01                	push   $0x1
 5ba:	e9 73 ff ff ff       	jmp    532 <printf+0xf2>
 5bf:	90                   	nop
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5c9:	6a 01                	push   $0x1
 5cb:	e9 21 ff ff ff       	jmp    4f1 <printf+0xb1>
        putc(fd, *ap);
 5d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5d6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5d8:	6a 01                	push   $0x1
        ap++;
 5da:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5dd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5e3:	50                   	push   %eax
 5e4:	ff 75 08             	pushl  0x8(%ebp)
 5e7:	e8 e6 fc ff ff       	call   2d2 <write>
        ap++;
 5ec:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5ef:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5f2:	31 ff                	xor    %edi,%edi
 5f4:	e9 8f fe ff ff       	jmp    488 <printf+0x48>
          s = "(null)";
 5f9:	bb c8 0b 00 00       	mov    $0xbc8,%ebx
        while(*s != 0){
 5fe:	b8 28 00 00 00       	mov    $0x28,%eax
 603:	e9 72 ff ff ff       	jmp    57a <printf+0x13a>
 608:	66 90                	xchg   %ax,%ax
 60a:	66 90                	xchg   %ax,%ax
 60c:	66 90                	xchg   %ax,%ax
 60e:	66 90                	xchg   %ax,%ax

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 3c 10 00 00       	mov    0x103c,%eax
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 61e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 628:	39 c8                	cmp    %ecx,%eax
 62a:	8b 10                	mov    (%eax),%edx
 62c:	73 32                	jae    660 <free+0x50>
 62e:	39 d1                	cmp    %edx,%ecx
 630:	72 04                	jb     636 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 632:	39 d0                	cmp    %edx,%eax
 634:	72 32                	jb     668 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 636:	8b 73 fc             	mov    -0x4(%ebx),%esi
 639:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 63c:	39 fa                	cmp    %edi,%edx
 63e:	74 30                	je     670 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 640:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 643:	8b 50 04             	mov    0x4(%eax),%edx
 646:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 649:	39 f1                	cmp    %esi,%ecx
 64b:	74 3a                	je     687 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 64d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 64f:	a3 3c 10 00 00       	mov    %eax,0x103c
}
 654:	5b                   	pop    %ebx
 655:	5e                   	pop    %esi
 656:	5f                   	pop    %edi
 657:	5d                   	pop    %ebp
 658:	c3                   	ret    
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	39 d0                	cmp    %edx,%eax
 662:	72 04                	jb     668 <free+0x58>
 664:	39 d1                	cmp    %edx,%ecx
 666:	72 ce                	jb     636 <free+0x26>
{
 668:	89 d0                	mov    %edx,%eax
 66a:	eb bc                	jmp    628 <free+0x18>
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 670:	03 72 04             	add    0x4(%edx),%esi
 673:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 676:	8b 10                	mov    (%eax),%edx
 678:	8b 12                	mov    (%edx),%edx
 67a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 50 04             	mov    0x4(%eax),%edx
 680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	75 c6                	jne    64d <free+0x3d>
    p->s.size += bp->s.size;
 687:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 68a:	a3 3c 10 00 00       	mov    %eax,0x103c
    p->s.size += bp->s.size;
 68f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 692:	8b 53 f8             	mov    -0x8(%ebx),%edx
 695:	89 10                	mov    %edx,(%eax)
}
 697:	5b                   	pop    %ebx
 698:	5e                   	pop    %esi
 699:	5f                   	pop    %edi
 69a:	5d                   	pop    %ebp
 69b:	c3                   	ret    
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ac:	8b 15 3c 10 00 00    	mov    0x103c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	8d 78 07             	lea    0x7(%eax),%edi
 6b5:	c1 ef 03             	shr    $0x3,%edi
 6b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6bb:	85 d2                	test   %edx,%edx
 6bd:	0f 84 9d 00 00 00    	je     760 <malloc+0xc0>
 6c3:	8b 02                	mov    (%edx),%eax
 6c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c8:	39 cf                	cmp    %ecx,%edi
 6ca:	76 6c                	jbe    738 <malloc+0x98>
 6cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6e1:	eb 0e                	jmp    6f1 <malloc+0x51>
 6e3:	90                   	nop
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ea:	8b 48 04             	mov    0x4(%eax),%ecx
 6ed:	39 f9                	cmp    %edi,%ecx
 6ef:	73 47                	jae    738 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f1:	39 05 3c 10 00 00    	cmp    %eax,0x103c
 6f7:	89 c2                	mov    %eax,%edx
 6f9:	75 ed                	jne    6e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6fb:	83 ec 0c             	sub    $0xc,%esp
 6fe:	56                   	push   %esi
 6ff:	e8 36 fc ff ff       	call   33a <sbrk>
  if(p == (char*)-1)
 704:	83 c4 10             	add    $0x10,%esp
 707:	83 f8 ff             	cmp    $0xffffffff,%eax
 70a:	74 1c                	je     728 <malloc+0x88>
  hp->s.size = nu;
 70c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 70f:	83 ec 0c             	sub    $0xc,%esp
 712:	83 c0 08             	add    $0x8,%eax
 715:	50                   	push   %eax
 716:	e8 f5 fe ff ff       	call   610 <free>
  return freep;
 71b:	8b 15 3c 10 00 00    	mov    0x103c,%edx
      if((p = morecore(nunits)) == 0)
 721:	83 c4 10             	add    $0x10,%esp
 724:	85 d2                	test   %edx,%edx
 726:	75 c0                	jne    6e8 <malloc+0x48>
        return 0;
  }
}
 728:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 72b:	31 c0                	xor    %eax,%eax
}
 72d:	5b                   	pop    %ebx
 72e:	5e                   	pop    %esi
 72f:	5f                   	pop    %edi
 730:	5d                   	pop    %ebp
 731:	c3                   	ret    
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 738:	39 cf                	cmp    %ecx,%edi
 73a:	74 54                	je     790 <malloc+0xf0>
        p->s.size -= nunits;
 73c:	29 f9                	sub    %edi,%ecx
 73e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 741:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 744:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 747:	89 15 3c 10 00 00    	mov    %edx,0x103c
}
 74d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 750:	83 c0 08             	add    $0x8,%eax
}
 753:	5b                   	pop    %ebx
 754:	5e                   	pop    %esi
 755:	5f                   	pop    %edi
 756:	5d                   	pop    %ebp
 757:	c3                   	ret    
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 760:	c7 05 3c 10 00 00 40 	movl   $0x1040,0x103c
 767:	10 00 00 
 76a:	c7 05 40 10 00 00 40 	movl   $0x1040,0x1040
 771:	10 00 00 
    base.s.size = 0;
 774:	b8 40 10 00 00       	mov    $0x1040,%eax
 779:	c7 05 44 10 00 00 00 	movl   $0x0,0x1044
 780:	00 00 00 
 783:	e9 44 ff ff ff       	jmp    6cc <malloc+0x2c>
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 790:	8b 08                	mov    (%eax),%ecx
 792:	89 0a                	mov    %ecx,(%edx)
 794:	eb b1                	jmp    747 <malloc+0xa7>
 796:	66 90                	xchg   %ax,%ax
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <create_tree>:
}

int index = 0;
int curLevel = -2;

void create_tree(struct tree_node* node, int depth){
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 1c             	sub    $0x1c,%esp
 7a9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
 7af:	85 f6                	test   %esi,%esi
 7b1:	0f 84 8a 00 00 00    	je     841 <create_tree+0xa1>
 7b7:	8d 04 b5 fc ff ff ff 	lea    -0x4(,%esi,4),%eax
 7be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7c1:	8d 4e fe             	lea    -0x2(%esi),%ecx
 7c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 7c7:	03 15 50 10 00 00    	add    0x1050,%edx
        return;
    }
    if(curLevel != depth-2){
 7cd:	39 0d 38 10 00 00    	cmp    %ecx,0x1038
 7d3:	a1 48 10 00 00       	mov    0x1048,%eax
 7d8:	74 08                	je     7e2 <create_tree+0x42>
        index = level_index[depth-1];
 7da:	8b 02                	mov    (%edx),%eax
        curLevel = depth-2;
 7dc:	89 0d 38 10 00 00    	mov    %ecx,0x1038
    }
    node->level = curLevel;
    node->index = index;
 7e2:	89 43 10             	mov    %eax,0x10(%ebx)
    index++;
 7e5:	83 c0 01             	add    $0x1,%eax
    level_index[depth-1] = index;
    if(depth == 1){
 7e8:	83 fe 01             	cmp    $0x1,%esi
    node->level = curLevel;
 7eb:	89 4b 14             	mov    %ecx,0x14(%ebx)
    index++;
 7ee:	a3 48 10 00 00       	mov    %eax,0x1048
    level_index[depth-1] = index;
 7f3:	89 02                	mov    %eax,(%edx)
    if(depth == 1){
 7f5:	74 59                	je     850 <create_tree+0xb0>
        node->left_child = 0;
        node->right_child = 0;
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    }else{
        struct tree_node *left = malloc(sizeof(struct tree_node));
 7f7:	83 ec 0c             	sub    $0xc,%esp
        left->parent = node;
        right->parent = node;
        node->left_child = left;
        node->right_child = right;
        node->mutex_id = kthread_mutex_alloc();
        create_tree(left, depth-1);
 7fa:	83 ee 01             	sub    $0x1,%esi
        struct tree_node *left = malloc(sizeof(struct tree_node));
 7fd:	6a 1c                	push   $0x1c
 7ff:	e8 9c fe ff ff       	call   6a0 <malloc>
 804:	89 c7                	mov    %eax,%edi
        struct tree_node *right = malloc(sizeof(struct tree_node));
 806:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
 80d:	e8 8e fe ff ff       	call   6a0 <malloc>
        left->parent = node;
 812:	89 5f 08             	mov    %ebx,0x8(%edi)
        right->parent = node;
 815:	89 58 08             	mov    %ebx,0x8(%eax)
        node->left_child = left;
 818:	89 3b                	mov    %edi,(%ebx)
        node->right_child = right;
 81a:	89 43 04             	mov    %eax,0x4(%ebx)
 81d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        node->mutex_id = kthread_mutex_alloc();
 820:	e8 4d fb ff ff       	call   372 <kthread_mutex_alloc>
 825:	89 43 0c             	mov    %eax,0xc(%ebx)
        create_tree(left, depth-1);
 828:	58                   	pop    %eax
 829:	5a                   	pop    %edx
 82a:	56                   	push   %esi
 82b:	57                   	push   %edi
 82c:	e8 6f ff ff ff       	call   7a0 <create_tree>
 831:	8b 55 e0             	mov    -0x20(%ebp),%edx
 834:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
    if(depth == 0){
 838:	83 c4 10             	add    $0x10,%esp
 83b:	85 f6                	test   %esi,%esi
 83d:	89 d3                	mov    %edx,%ebx
 83f:	75 80                	jne    7c1 <create_tree+0x21>
        create_tree(right, depth-1);
    }
    return;
}
 841:	8d 65 f4             	lea    -0xc(%ebp),%esp
 844:	5b                   	pop    %ebx
 845:	5e                   	pop    %esi
 846:	5f                   	pop    %edi
 847:	5d                   	pop    %ebp
 848:	c3                   	ret    
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        node->left_child = 0;
 850:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 856:	a1 4c 10 00 00       	mov    0x104c,%eax
 85b:	83 ec 0c             	sub    $0xc,%esp
        node->right_child = 0;
 85e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 865:	c1 e0 02             	shl    $0x2,%eax
 868:	50                   	push   %eax
 869:	e8 32 fe ff ff       	call   6a0 <malloc>
 86e:	83 c4 10             	add    $0x10,%esp
 871:	89 43 18             	mov    %eax,0x18(%ebx)
}
 874:	8d 65 f4             	lea    -0xc(%ebp),%esp
 877:	5b                   	pop    %ebx
 878:	5e                   	pop    %esi
 879:	5f                   	pop    %edi
 87a:	5d                   	pop    %ebp
 87b:	c3                   	ret    
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000880 <trnmnt_tree_alloc>:
trnmnt_tree* trnmnt_tree_alloc(int depth){
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	56                   	push   %esi
 884:	53                   	push   %ebx
 885:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth < 1) // illegal depth
 888:	85 db                	test   %ebx,%ebx
 88a:	7e 74                	jle    900 <trnmnt_tree_alloc+0x80>
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 88c:	83 ec 0c             	sub    $0xc,%esp
 88f:	6a 08                	push   $0x8
 891:	e8 0a fe ff ff       	call   6a0 <malloc>
    struct tree_node *root = malloc(sizeof(struct tree_node));
 896:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 89d:	89 c6                	mov    %eax,%esi
    struct tree_node *root = malloc(sizeof(struct tree_node));
 89f:	e8 fc fd ff ff       	call   6a0 <malloc>
    int arr[depth+1];
 8a4:	8d 53 01             	lea    0x1(%ebx),%edx
    treeDepth = depth;
 8a7:	89 1d 4c 10 00 00    	mov    %ebx,0x104c
    tree->depth = depth;
 8ad:	89 5e 04             	mov    %ebx,0x4(%esi)
    tree->root = root;
 8b0:	89 06                	mov    %eax,(%esi)
    root->parent = 0;
 8b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    int arr[depth+1];
 8b9:	83 c4 10             	add    $0x10,%esp
 8bc:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
 8c3:	83 e0 f0             	and    $0xfffffff0,%eax
 8c6:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < depth+1; i++)
 8c8:	31 c0                	xor    %eax,%eax
    int arr[depth+1];
 8ca:	89 e1                	mov    %esp,%ecx
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        arr[i] = 0;
 8d0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    for(int i = 0; i < depth+1; i++)
 8d7:	83 c0 01             	add    $0x1,%eax
 8da:	39 c2                	cmp    %eax,%edx
 8dc:	75 f2                	jne    8d0 <trnmnt_tree_alloc+0x50>
    create_tree(tree->root, depth+1);
 8de:	83 ec 08             	sub    $0x8,%esp
    level_index = arr;
 8e1:	89 0d 50 10 00 00    	mov    %ecx,0x1050
    create_tree(tree->root, depth+1);
 8e7:	52                   	push   %edx
 8e8:	ff 36                	pushl  (%esi)
 8ea:	e8 b1 fe ff ff       	call   7a0 <create_tree>
    return tree;
 8ef:	83 c4 10             	add    $0x10,%esp
}
 8f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8f5:	89 f0                	mov    %esi,%eax
 8f7:	5b                   	pop    %ebx
 8f8:	5e                   	pop    %esi
 8f9:	5d                   	pop    %ebp
 8fa:	c3                   	ret    
 8fb:	90                   	nop
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 900:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return 0;
 903:	31 f6                	xor    %esi,%esi
}
 905:	89 f0                	mov    %esi,%eax
 907:	5b                   	pop    %ebx
 908:	5e                   	pop    %esi
 909:	5d                   	pop    %ebp
 90a:	c3                   	ret    
 90b:	90                   	nop
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000910 <print_node>:

void print_node(struct tree_node *n,int l){
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 1c             	sub    $0x1c,%esp
 919:	8b 75 08             	mov    0x8(%ebp),%esi
 91c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
 91f:	85 f6                	test   %esi,%esi
 921:	74 5a                	je     97d <print_node+0x6d>
    int i;
	print_node(n->right_child,l+1);
 923:	8d 43 01             	lea    0x1(%ebx),%eax
 926:	83 ec 08             	sub    $0x8,%esp
 929:	50                   	push   %eax
 92a:	ff 76 04             	pushl  0x4(%esi)
 92d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 930:	e8 db ff ff ff       	call   910 <print_node>
	for(i=0;i<l;++i){
 935:	83 c4 10             	add    $0x10,%esp
 938:	85 db                	test   %ebx,%ebx
 93a:	7e 1d                	jle    959 <print_node+0x49>
 93c:	31 ff                	xor    %edi,%edi
 93e:	66 90                	xchg   %ax,%ax
		printf(1,"    ");
 940:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
 943:	83 c7 01             	add    $0x1,%edi
		printf(1,"    ");
 946:	68 e1 0b 00 00       	push   $0xbe1
 94b:	6a 01                	push   $0x1
 94d:	e8 ee fa ff ff       	call   440 <printf>
	for(i=0;i<l;++i){
 952:	83 c4 10             	add    $0x10,%esp
 955:	39 df                	cmp    %ebx,%edi
 957:	75 e7                	jne    940 <print_node+0x30>
    }
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
 959:	83 ec 0c             	sub    $0xc,%esp
 95c:	ff 76 0c             	pushl  0xc(%esi)
 95f:	ff 76 10             	pushl  0x10(%esi)
 962:	ff 76 14             	pushl  0x14(%esi)
 965:	68 e6 0b 00 00       	push   $0xbe6
 96a:	6a 01                	push   $0x1
 96c:	e8 cf fa ff ff       	call   440 <printf>
	print_node(n->left_child,l+1);
 971:	8b 36                	mov    (%esi),%esi
	if(!n) return;
 973:	83 c4 20             	add    $0x20,%esp
	print_node(n->left_child,l+1);
 976:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
 979:	85 f6                	test   %esi,%esi
 97b:	75 a6                	jne    923 <print_node+0x13>
}
 97d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 980:	5b                   	pop    %ebx
 981:	5e                   	pop    %esi
 982:	5f                   	pop    %edi
 983:	5d                   	pop    %ebp
 984:	c3                   	ret    
 985:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <print_tree>:

void print_tree(trnmnt_tree *t){
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
 993:	83 ec 08             	sub    $0x8,%esp
 996:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
 999:	85 c0                	test   %eax,%eax
 99b:	74 0f                	je     9ac <print_tree+0x1c>
	print_node(t->root,0);
 99d:	83 ec 08             	sub    $0x8,%esp
 9a0:	6a 00                	push   $0x0
 9a2:	ff 30                	pushl  (%eax)
 9a4:	e8 67 ff ff ff       	call   910 <print_node>
 9a9:	83 c4 10             	add    $0x10,%esp
}
 9ac:	c9                   	leave  
 9ad:	c3                   	ret    
 9ae:	66 90                	xchg   %ax,%ax

000009b0 <delete_node>:

int delete_node(struct tree_node *node){
 9b0:	55                   	push   %ebp
            node->lockPath = 0;
        }
        // then delete the node
        free(node); 
    }
    return 0;
 9b1:	31 c0                	xor    %eax,%eax
int delete_node(struct tree_node *node){
 9b3:	89 e5                	mov    %esp,%ebp
 9b5:	53                   	push   %ebx
 9b6:	83 ec 04             	sub    $0x4,%esp
 9b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (node != 0){ 
 9bc:	85 db                	test   %ebx,%ebx
 9be:	74 5e                	je     a1e <delete_node+0x6e>
        if(kthread_mutex_dealloc(node->mutex_id) == -1){
 9c0:	83 ec 0c             	sub    $0xc,%esp
 9c3:	ff 73 0c             	pushl  0xc(%ebx)
 9c6:	e8 af f9 ff ff       	call   37a <kthread_mutex_dealloc>
 9cb:	83 c4 10             	add    $0x10,%esp
 9ce:	83 f8 ff             	cmp    $0xffffffff,%eax
 9d1:	74 4b                	je     a1e <delete_node+0x6e>
        delete_node(node->left_child); 
 9d3:	83 ec 0c             	sub    $0xc,%esp
 9d6:	ff 33                	pushl  (%ebx)
 9d8:	e8 d3 ff ff ff       	call   9b0 <delete_node>
        delete_node(node->right_child); 
 9dd:	58                   	pop    %eax
 9de:	ff 73 04             	pushl  0x4(%ebx)
 9e1:	e8 ca ff ff ff       	call   9b0 <delete_node>
        if(node->lockPath){
 9e6:	8b 43 18             	mov    0x18(%ebx),%eax
 9e9:	83 c4 10             	add    $0x10,%esp
        node->left_child = 0;
 9ec:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
 9f2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        if(node->lockPath){
 9f9:	85 c0                	test   %eax,%eax
 9fb:	74 13                	je     a10 <delete_node+0x60>
            free(node->lockPath);
 9fd:	83 ec 0c             	sub    $0xc,%esp
 a00:	50                   	push   %eax
 a01:	e8 0a fc ff ff       	call   610 <free>
            node->lockPath = 0;
 a06:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
 a0d:	83 c4 10             	add    $0x10,%esp
        free(node); 
 a10:	83 ec 0c             	sub    $0xc,%esp
 a13:	53                   	push   %ebx
 a14:	e8 f7 fb ff ff       	call   610 <free>
 a19:	83 c4 10             	add    $0x10,%esp
 a1c:	31 c0                	xor    %eax,%eax
}
 a1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a21:	c9                   	leave  
 a22:	c3                   	ret    
 a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(trnmnt_tree* tree){
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	56                   	push   %esi
 a34:	53                   	push   %ebx
 a35:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
 a38:	83 ec 0c             	sub    $0xc,%esp
 a3b:	ff 33                	pushl  (%ebx)
 a3d:	e8 6e ff ff ff       	call   9b0 <delete_node>
 a42:	83 c4 10             	add    $0x10,%esp
 a45:	85 c0                	test   %eax,%eax
 a47:	75 27                	jne    a70 <trnmnt_tree_dealloc+0x40>
        tree->root = 0;
        free(tree);
 a49:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
 a4c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
 a52:	89 c6                	mov    %eax,%esi
        free(tree);
 a54:	53                   	push   %ebx
 a55:	e8 b6 fb ff ff       	call   610 <free>
        tree = 0;
        return 0;
 a5a:	83 c4 10             	add    $0x10,%esp
    }else{
        return -1;
    }
}
 a5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a60:	89 f0                	mov    %esi,%eax
 a62:	5b                   	pop    %ebx
 a63:	5e                   	pop    %esi
 a64:	5d                   	pop    %ebp
 a65:	c3                   	ret    
 a66:	8d 76 00             	lea    0x0(%esi),%esi
 a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
 a70:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a75:	eb e6                	jmp    a5d <trnmnt_tree_dealloc+0x2d>
 a77:	89 f6                	mov    %esi,%esi
 a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a80 <find_leaf>:
        leaf->lockPath[i] = 0;
    }
    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
 a83:	57                   	push   %edi
 a84:	56                   	push   %esi
 a85:	53                   	push   %ebx
 a86:	83 ec 0c             	sub    $0xc,%esp
 a89:	8b 55 08             	mov    0x8(%ebp),%edx
 a8c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if(node->right_child == 0 && node->left_child == 0){ 
 a8f:	8b 72 04             	mov    0x4(%edx),%esi
 a92:	8b 02                	mov    (%edx),%eax
 a94:	85 f6                	test   %esi,%esi
 a96:	75 18                	jne    ab0 <find_leaf+0x30>
 a98:	85 c0                	test   %eax,%eax
 a9a:	75 14                	jne    ab0 <find_leaf+0x30>
        if(ID == node->index){
 a9c:	39 5a 10             	cmp    %ebx,0x10(%edx)
 a9f:	0f 44 c2             	cmove  %edx,%eax
        if(leaf1)
            return leaf1;
        else
            return leaf2;
    }
} 
 aa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 aa5:	5b                   	pop    %ebx
 aa6:	5e                   	pop    %esi
 aa7:	5f                   	pop    %edi
 aa8:	5d                   	pop    %ebp
 aa9:	c3                   	ret    
 aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 ab0:	83 ec 08             	sub    $0x8,%esp
 ab3:	53                   	push   %ebx
 ab4:	50                   	push   %eax
 ab5:	e8 c6 ff ff ff       	call   a80 <find_leaf>
 aba:	5a                   	pop    %edx
 abb:	59                   	pop    %ecx
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 abc:	53                   	push   %ebx
 abd:	56                   	push   %esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 abe:	89 c7                	mov    %eax,%edi
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 ac0:	e8 bb ff ff ff       	call   a80 <find_leaf>
 ac5:	83 c4 10             	add    $0x10,%esp
        if(leaf1)
 ac8:	85 ff                	test   %edi,%edi
 aca:	0f 45 c7             	cmovne %edi,%eax
} 
 acd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ad0:	5b                   	pop    %ebx
 ad1:	5e                   	pop    %esi
 ad2:	5f                   	pop    %edi
 ad3:	5d                   	pop    %ebp
 ad4:	c3                   	ret    
 ad5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ae0 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	57                   	push   %edi
 ae4:	56                   	push   %esi
 ae5:	53                   	push   %ebx
 ae6:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 ae9:	8b 45 08             	mov    0x8(%ebp),%eax
 aec:	ff 75 0c             	pushl  0xc(%ebp)
 aef:	ff 30                	pushl  (%eax)
 af1:	e8 8a ff ff ff       	call   a80 <find_leaf>
 af6:	8b 50 08             	mov    0x8(%eax),%edx
 af9:	83 c4 10             	add    $0x10,%esp
 afc:	89 c7                	mov    %eax,%edi
    while(curNode->parent){
 afe:	89 c3                	mov    %eax,%ebx
 b00:	85 d2                	test   %edx,%edx
 b02:	74 32                	je     b36 <trnmnt_tree_acquire+0x56>
        int level = curNode->parent->level;
 b04:	8b 72 14             	mov    0x14(%edx),%esi
        int mutex_lock = kthread_mutex_lock(mutexID);
 b07:	83 ec 0c             	sub    $0xc,%esp
 b0a:	ff 72 0c             	pushl  0xc(%edx)
 b0d:	e8 70 f8 ff ff       	call   382 <kthread_mutex_lock>
        leaf->lockPath[level] = curNode->parent->mutex_id;
 b12:	8b 53 08             	mov    0x8(%ebx),%edx
        if(mutex_lock == -1){
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	83 f8 ff             	cmp    $0xffffffff,%eax
        leaf->lockPath[level] = curNode->parent->mutex_id;
 b1b:	8b 4a 0c             	mov    0xc(%edx),%ecx
 b1e:	8b 57 18             	mov    0x18(%edi),%edx
 b21:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
        if(mutex_lock == -1){
 b24:	74 12                	je     b38 <trnmnt_tree_acquire+0x58>
        if(mutex_lock == 0){
 b26:	85 c0                	test   %eax,%eax
 b28:	8b 53 08             	mov    0x8(%ebx),%edx
 b2b:	75 d3                	jne    b00 <trnmnt_tree_acquire+0x20>
 b2d:	89 d3                	mov    %edx,%ebx
 b2f:	8b 52 08             	mov    0x8(%edx),%edx
    while(curNode->parent){
 b32:	85 d2                	test   %edx,%edx
 b34:	75 ce                	jne    b04 <trnmnt_tree_acquire+0x24>
    return 0;
 b36:	31 c0                	xor    %eax,%eax
}
 b38:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b3b:	5b                   	pop    %ebx
 b3c:	5e                   	pop    %esi
 b3d:	5f                   	pop    %edi
 b3e:	5d                   	pop    %ebp
 b3f:	c3                   	ret    

00000b40 <trnmnt_tree_release>:
int trnmnt_tree_release(trnmnt_tree* tree,int ID){
 b40:	55                   	push   %ebp
 b41:	89 e5                	mov    %esp,%ebp
 b43:	57                   	push   %edi
 b44:	56                   	push   %esi
 b45:	53                   	push   %ebx
 b46:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b49:	8b 45 08             	mov    0x8(%ebp),%eax
 b4c:	ff 75 0c             	pushl  0xc(%ebp)
 b4f:	ff 30                	pushl  (%eax)
 b51:	e8 2a ff ff ff       	call   a80 <find_leaf>
    for(int i = treeDepth-1; i >= 0; i--){
 b56:	8b 35 4c 10 00 00    	mov    0x104c,%esi
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b5c:	83 c4 10             	add    $0x10,%esp
    for(int i = treeDepth-1; i >= 0; i--){
 b5f:	83 ee 01             	sub    $0x1,%esi
 b62:	78 44                	js     ba8 <trnmnt_tree_release+0x68>
 b64:	89 c7                	mov    %eax,%edi
 b66:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
 b6d:	eb 16                	jmp    b85 <trnmnt_tree_release+0x45>
 b6f:	90                   	nop
        leaf->lockPath[i] = 0;
 b70:	8b 47 18             	mov    0x18(%edi),%eax
    for(int i = treeDepth-1; i >= 0; i--){
 b73:	83 ee 01             	sub    $0x1,%esi
        leaf->lockPath[i] = 0;
 b76:	c7 04 18 00 00 00 00 	movl   $0x0,(%eax,%ebx,1)
 b7d:	83 eb 04             	sub    $0x4,%ebx
    for(int i = treeDepth-1; i >= 0; i--){
 b80:	83 fe ff             	cmp    $0xffffffff,%esi
 b83:	74 23                	je     ba8 <trnmnt_tree_release+0x68>
        int res = kthread_mutex_unlock(leaf->lockPath[i]);
 b85:	8b 47 18             	mov    0x18(%edi),%eax
 b88:	83 ec 0c             	sub    $0xc,%esp
 b8b:	ff 34 18             	pushl  (%eax,%ebx,1)
 b8e:	e8 f7 f7 ff ff       	call   38a <kthread_mutex_unlock>
        if(res == -1){
 b93:	83 c4 10             	add    $0x10,%esp
 b96:	83 f8 ff             	cmp    $0xffffffff,%eax
 b99:	75 d5                	jne    b70 <trnmnt_tree_release+0x30>
}
 b9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b9e:	5b                   	pop    %ebx
 b9f:	5e                   	pop    %esi
 ba0:	5f                   	pop    %edi
 ba1:	5d                   	pop    %ebp
 ba2:	c3                   	ret    
 ba3:	90                   	nop
 ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 ba8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 bab:	31 c0                	xor    %eax,%eax
}
 bad:	5b                   	pop    %ebx
 bae:	5e                   	pop    %esi
 baf:	5f                   	pop    %edi
 bb0:	5d                   	pop    %ebp
 bb1:	c3                   	ret    
