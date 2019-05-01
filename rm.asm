
_rm:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	bf 01 00 00 00       	mov    $0x1,%edi
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	8d 76 00             	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 e8 02 00 00       	call   322 <unlink>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 82 02 00 00       	call   2d2 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 e8 0b 00 00       	push   $0xbe8
  58:	6a 02                	push   $0x2
  5a:	e8 01 04 00 00       	call   460 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: rm files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 d4 0b 00 00       	push   $0xbd4
  6b:	6a 02                	push   $0x2
  6d:	e8 ee 03 00 00       	call   460 <printf>
    exit();
  72:	e8 5b 02 00 00       	call   2d2 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1c                	jne    e0 <strcmp+0x30>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  d6:	83 c1 01             	add    $0x1,%ecx
  d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x40>
  e0:	38 d8                	cmp    %bl,%al
  e2:	74 ec                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e4:	29 d8                	sub    %ebx,%eax
}
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d9                	mov    %ebx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	31 f6                	xor    %esi,%esi
 198:	89 f3                	mov    %esi,%ebx
{
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 32 01 00 00       	call   2ea <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	89 fe                	mov    %edi,%esi
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 f0 00 00 00       	call   312 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f3 00 00 00       	call   32a <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 b9 00 00 00       	call   2fa <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2c2:	39 d3                	cmp    %edx,%ebx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
  return vdst;
}
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    

000002ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ca:	b8 01 00 00 00       	mov    $0x1,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <exit>:
SYSCALL(exit)
 2d2:	b8 02 00 00 00       	mov    $0x2,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <wait>:
SYSCALL(wait)
 2da:	b8 03 00 00 00       	mov    $0x3,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <pipe>:
SYSCALL(pipe)
 2e2:	b8 04 00 00 00       	mov    $0x4,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <read>:
SYSCALL(read)
 2ea:	b8 05 00 00 00       	mov    $0x5,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <write>:
SYSCALL(write)
 2f2:	b8 10 00 00 00       	mov    $0x10,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <close>:
SYSCALL(close)
 2fa:	b8 15 00 00 00       	mov    $0x15,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kill>:
SYSCALL(kill)
 302:	b8 06 00 00 00       	mov    $0x6,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <exec>:
SYSCALL(exec)
 30a:	b8 07 00 00 00       	mov    $0x7,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <open>:
SYSCALL(open)
 312:	b8 0f 00 00 00       	mov    $0xf,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mknod>:
SYSCALL(mknod)
 31a:	b8 11 00 00 00       	mov    $0x11,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <unlink>:
SYSCALL(unlink)
 322:	b8 12 00 00 00       	mov    $0x12,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <fstat>:
SYSCALL(fstat)
 32a:	b8 08 00 00 00       	mov    $0x8,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <link>:
SYSCALL(link)
 332:	b8 13 00 00 00       	mov    $0x13,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <mkdir>:
SYSCALL(mkdir)
 33a:	b8 14 00 00 00       	mov    $0x14,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <chdir>:
SYSCALL(chdir)
 342:	b8 09 00 00 00       	mov    $0x9,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <dup>:
SYSCALL(dup)
 34a:	b8 0a 00 00 00       	mov    $0xa,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <getpid>:
SYSCALL(getpid)
 352:	b8 0b 00 00 00       	mov    $0xb,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <sbrk>:
SYSCALL(sbrk)
 35a:	b8 0c 00 00 00       	mov    $0xc,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <sleep>:
SYSCALL(sleep)
 362:	b8 0d 00 00 00       	mov    $0xd,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <uptime>:
SYSCALL(uptime)
 36a:	b8 0e 00 00 00       	mov    $0xe,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kthread_create>:
SYSCALL(kthread_create)
 372:	b8 16 00 00 00       	mov    $0x16,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <kthread_id>:
SYSCALL(kthread_id)
 37a:	b8 17 00 00 00       	mov    $0x17,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kthread_exit>:
SYSCALL(kthread_exit)
 382:	b8 18 00 00 00       	mov    $0x18,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kthread_join>:
SYSCALL(kthread_join)
 38a:	b8 19 00 00 00       	mov    $0x19,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 392:	b8 1a 00 00 00       	mov    $0x1a,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 39a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 3a2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 3aa:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    
 3b2:	66 90                	xchg   %ax,%ax
 3b4:	66 90                	xchg   %ax,%ax
 3b6:	66 90                	xchg   %ax,%ax
 3b8:	66 90                	xchg   %ax,%ax
 3ba:	66 90                	xchg   %ax,%ax
 3bc:	66 90                	xchg   %ax,%ax
 3be:	66 90                	xchg   %ax,%ax

000003c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c9:	85 d2                	test   %edx,%edx
{
 3cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 3ce:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3d0:	79 76                	jns    448 <printint+0x88>
 3d2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3d6:	74 70                	je     448 <printint+0x88>
    x = -xx;
 3d8:	f7 d8                	neg    %eax
    neg = 1;
 3da:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3e1:	31 f6                	xor    %esi,%esi
 3e3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3e6:	eb 0a                	jmp    3f2 <printint+0x32>
 3e8:	90                   	nop
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3f0:	89 fe                	mov    %edi,%esi
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	8d 7e 01             	lea    0x1(%esi),%edi
 3f7:	f7 f1                	div    %ecx
 3f9:	0f b6 92 08 0c 00 00 	movzbl 0xc08(%edx),%edx
  }while((x /= base) != 0);
 400:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 402:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 405:	75 e9                	jne    3f0 <printint+0x30>
  if(neg)
 407:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 40a:	85 c0                	test   %eax,%eax
 40c:	74 08                	je     416 <printint+0x56>
    buf[i++] = '-';
 40e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 413:	8d 7e 02             	lea    0x2(%esi),%edi
 416:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 41a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 423:	83 ec 04             	sub    $0x4,%esp
 426:	83 ee 01             	sub    $0x1,%esi
 429:	6a 01                	push   $0x1
 42b:	53                   	push   %ebx
 42c:	57                   	push   %edi
 42d:	88 45 d7             	mov    %al,-0x29(%ebp)
 430:	e8 bd fe ff ff       	call   2f2 <write>

  while(--i >= 0)
 435:	83 c4 10             	add    $0x10,%esp
 438:	39 de                	cmp    %ebx,%esi
 43a:	75 e4                	jne    420 <printint+0x60>
    putc(fd, buf[i]);
}
 43c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43f:	5b                   	pop    %ebx
 440:	5e                   	pop    %esi
 441:	5f                   	pop    %edi
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 448:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 44f:	eb 90                	jmp    3e1 <printint+0x21>
 451:	eb 0d                	jmp    460 <printf>
 453:	90                   	nop
 454:	90                   	nop
 455:	90                   	nop
 456:	90                   	nop
 457:	90                   	nop
 458:	90                   	nop
 459:	90                   	nop
 45a:	90                   	nop
 45b:	90                   	nop
 45c:	90                   	nop
 45d:	90                   	nop
 45e:	90                   	nop
 45f:	90                   	nop

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 75 0c             	mov    0xc(%ebp),%esi
 46c:	0f b6 1e             	movzbl (%esi),%ebx
 46f:	84 db                	test   %bl,%bl
 471:	0f 84 b3 00 00 00    	je     52a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 477:	8d 45 10             	lea    0x10(%ebp),%eax
 47a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 47d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 47f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 482:	eb 2f                	jmp    4b3 <printf+0x53>
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 488:	83 f8 25             	cmp    $0x25,%eax
 48b:	0f 84 a7 00 00 00    	je     538 <printf+0xd8>
  write(fd, &c, 1);
 491:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 494:	83 ec 04             	sub    $0x4,%esp
 497:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 49a:	6a 01                	push   $0x1
 49c:	50                   	push   %eax
 49d:	ff 75 08             	pushl  0x8(%ebp)
 4a0:	e8 4d fe ff ff       	call   2f2 <write>
 4a5:	83 c4 10             	add    $0x10,%esp
 4a8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 4ab:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4af:	84 db                	test   %bl,%bl
 4b1:	74 77                	je     52a <printf+0xca>
    if(state == 0){
 4b3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4b5:	0f be cb             	movsbl %bl,%ecx
 4b8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4bb:	74 cb                	je     488 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4bd:	83 ff 25             	cmp    $0x25,%edi
 4c0:	75 e6                	jne    4a8 <printf+0x48>
      if(c == 'd'){
 4c2:	83 f8 64             	cmp    $0x64,%eax
 4c5:	0f 84 05 01 00 00    	je     5d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4cb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4d1:	83 f9 70             	cmp    $0x70,%ecx
 4d4:	74 72                	je     548 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4d6:	83 f8 73             	cmp    $0x73,%eax
 4d9:	0f 84 99 00 00 00    	je     578 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4df:	83 f8 63             	cmp    $0x63,%eax
 4e2:	0f 84 08 01 00 00    	je     5f0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4e8:	83 f8 25             	cmp    $0x25,%eax
 4eb:	0f 84 ef 00 00 00    	je     5e0 <printf+0x180>
  write(fd, &c, 1);
 4f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4f4:	83 ec 04             	sub    $0x4,%esp
 4f7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4fb:	6a 01                	push   $0x1
 4fd:	50                   	push   %eax
 4fe:	ff 75 08             	pushl  0x8(%ebp)
 501:	e8 ec fd ff ff       	call   2f2 <write>
 506:	83 c4 0c             	add    $0xc,%esp
 509:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 50c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 50f:	6a 01                	push   $0x1
 511:	50                   	push   %eax
 512:	ff 75 08             	pushl  0x8(%ebp)
 515:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 518:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 51a:	e8 d3 fd ff ff       	call   2f2 <write>
  for(i = 0; fmt[i]; i++){
 51f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 523:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 526:	84 db                	test   %bl,%bl
 528:	75 89                	jne    4b3 <printf+0x53>
    }
  }
}
 52a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 52d:	5b                   	pop    %ebx
 52e:	5e                   	pop    %esi
 52f:	5f                   	pop    %edi
 530:	5d                   	pop    %ebp
 531:	c3                   	ret    
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 538:	bf 25 00 00 00       	mov    $0x25,%edi
 53d:	e9 66 ff ff ff       	jmp    4a8 <printf+0x48>
 542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 548:	83 ec 0c             	sub    $0xc,%esp
 54b:	b9 10 00 00 00       	mov    $0x10,%ecx
 550:	6a 00                	push   $0x0
 552:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 555:	8b 45 08             	mov    0x8(%ebp),%eax
 558:	8b 17                	mov    (%edi),%edx
 55a:	e8 61 fe ff ff       	call   3c0 <printint>
        ap++;
 55f:	89 f8                	mov    %edi,%eax
 561:	83 c4 10             	add    $0x10,%esp
      state = 0;
 564:	31 ff                	xor    %edi,%edi
        ap++;
 566:	83 c0 04             	add    $0x4,%eax
 569:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 56c:	e9 37 ff ff ff       	jmp    4a8 <printf+0x48>
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 578:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 57b:	8b 08                	mov    (%eax),%ecx
        ap++;
 57d:	83 c0 04             	add    $0x4,%eax
 580:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 583:	85 c9                	test   %ecx,%ecx
 585:	0f 84 8e 00 00 00    	je     619 <printf+0x1b9>
        while(*s != 0){
 58b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 58e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 590:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 592:	84 c0                	test   %al,%al
 594:	0f 84 0e ff ff ff    	je     4a8 <printf+0x48>
 59a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 59d:	89 de                	mov    %ebx,%esi
 59f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5a2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a8:	83 ec 04             	sub    $0x4,%esp
          s++;
 5ab:	83 c6 01             	add    $0x1,%esi
 5ae:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5b1:	6a 01                	push   $0x1
 5b3:	57                   	push   %edi
 5b4:	53                   	push   %ebx
 5b5:	e8 38 fd ff ff       	call   2f2 <write>
        while(*s != 0){
 5ba:	0f b6 06             	movzbl (%esi),%eax
 5bd:	83 c4 10             	add    $0x10,%esp
 5c0:	84 c0                	test   %al,%al
 5c2:	75 e4                	jne    5a8 <printf+0x148>
 5c4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 5c7:	31 ff                	xor    %edi,%edi
 5c9:	e9 da fe ff ff       	jmp    4a8 <printf+0x48>
 5ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	e9 73 ff ff ff       	jmp    552 <printf+0xf2>
 5df:	90                   	nop
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5e9:	6a 01                	push   $0x1
 5eb:	e9 21 ff ff ff       	jmp    511 <printf+0xb1>
        putc(fd, *ap);
 5f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5f6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5f8:	6a 01                	push   $0x1
        ap++;
 5fa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 600:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 603:	50                   	push   %eax
 604:	ff 75 08             	pushl  0x8(%ebp)
 607:	e8 e6 fc ff ff       	call   2f2 <write>
        ap++;
 60c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 60f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 612:	31 ff                	xor    %edi,%edi
 614:	e9 8f fe ff ff       	jmp    4a8 <printf+0x48>
          s = "(null)";
 619:	bb 01 0c 00 00       	mov    $0xc01,%ebx
        while(*s != 0){
 61e:	b8 28 00 00 00       	mov    $0x28,%eax
 623:	e9 72 ff ff ff       	jmp    59a <printf+0x13a>
 628:	66 90                	xchg   %ax,%ax
 62a:	66 90                	xchg   %ax,%ax
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 78 10 00 00       	mov    0x1078,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 648:	39 c8                	cmp    %ecx,%eax
 64a:	8b 10                	mov    (%eax),%edx
 64c:	73 32                	jae    680 <free+0x50>
 64e:	39 d1                	cmp    %edx,%ecx
 650:	72 04                	jb     656 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 652:	39 d0                	cmp    %edx,%eax
 654:	72 32                	jb     688 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 656:	8b 73 fc             	mov    -0x4(%ebx),%esi
 659:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65c:	39 fa                	cmp    %edi,%edx
 65e:	74 30                	je     690 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 660:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 663:	8b 50 04             	mov    0x4(%eax),%edx
 666:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 669:	39 f1                	cmp    %esi,%ecx
 66b:	74 3a                	je     6a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 66d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 66f:	a3 78 10 00 00       	mov    %eax,0x1078
}
 674:	5b                   	pop    %ebx
 675:	5e                   	pop    %esi
 676:	5f                   	pop    %edi
 677:	5d                   	pop    %ebp
 678:	c3                   	ret    
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	39 d0                	cmp    %edx,%eax
 682:	72 04                	jb     688 <free+0x58>
 684:	39 d1                	cmp    %edx,%ecx
 686:	72 ce                	jb     656 <free+0x26>
{
 688:	89 d0                	mov    %edx,%eax
 68a:	eb bc                	jmp    648 <free+0x18>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 690:	03 72 04             	add    0x4(%edx),%esi
 693:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 696:	8b 10                	mov    (%eax),%edx
 698:	8b 12                	mov    (%edx),%edx
 69a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 50 04             	mov    0x4(%eax),%edx
 6a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	75 c6                	jne    66d <free+0x3d>
    p->s.size += bp->s.size;
 6a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6aa:	a3 78 10 00 00       	mov    %eax,0x1078
    p->s.size += bp->s.size;
 6af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6b5:	89 10                	mov    %edx,(%eax)
}
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret    
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 15 78 10 00 00    	mov    0x1078,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 78 07             	lea    0x7(%eax),%edi
 6d5:	c1 ef 03             	shr    $0x3,%edi
 6d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6db:	85 d2                	test   %edx,%edx
 6dd:	0f 84 9d 00 00 00    	je     780 <malloc+0xc0>
 6e3:	8b 02                	mov    (%edx),%eax
 6e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e8:	39 cf                	cmp    %ecx,%edi
 6ea:	76 6c                	jbe    758 <malloc+0x98>
 6ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 701:	eb 0e                	jmp    711 <malloc+0x51>
 703:	90                   	nop
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 708:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 70a:	8b 48 04             	mov    0x4(%eax),%ecx
 70d:	39 f9                	cmp    %edi,%ecx
 70f:	73 47                	jae    758 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	39 05 78 10 00 00    	cmp    %eax,0x1078
 717:	89 c2                	mov    %eax,%edx
 719:	75 ed                	jne    708 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 71b:	83 ec 0c             	sub    $0xc,%esp
 71e:	56                   	push   %esi
 71f:	e8 36 fc ff ff       	call   35a <sbrk>
  if(p == (char*)-1)
 724:	83 c4 10             	add    $0x10,%esp
 727:	83 f8 ff             	cmp    $0xffffffff,%eax
 72a:	74 1c                	je     748 <malloc+0x88>
  hp->s.size = nu;
 72c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 72f:	83 ec 0c             	sub    $0xc,%esp
 732:	83 c0 08             	add    $0x8,%eax
 735:	50                   	push   %eax
 736:	e8 f5 fe ff ff       	call   630 <free>
  return freep;
 73b:	8b 15 78 10 00 00    	mov    0x1078,%edx
      if((p = morecore(nunits)) == 0)
 741:	83 c4 10             	add    $0x10,%esp
 744:	85 d2                	test   %edx,%edx
 746:	75 c0                	jne    708 <malloc+0x48>
        return 0;
  }
}
 748:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 74b:	31 c0                	xor    %eax,%eax
}
 74d:	5b                   	pop    %ebx
 74e:	5e                   	pop    %esi
 74f:	5f                   	pop    %edi
 750:	5d                   	pop    %ebp
 751:	c3                   	ret    
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 758:	39 cf                	cmp    %ecx,%edi
 75a:	74 54                	je     7b0 <malloc+0xf0>
        p->s.size -= nunits;
 75c:	29 f9                	sub    %edi,%ecx
 75e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 761:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 764:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 767:	89 15 78 10 00 00    	mov    %edx,0x1078
}
 76d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 770:	83 c0 08             	add    $0x8,%eax
}
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 78 10 00 00 7c 	movl   $0x107c,0x1078
 787:	10 00 00 
 78a:	c7 05 7c 10 00 00 7c 	movl   $0x107c,0x107c
 791:	10 00 00 
    base.s.size = 0;
 794:	b8 7c 10 00 00       	mov    $0x107c,%eax
 799:	c7 05 80 10 00 00 00 	movl   $0x0,0x1080
 7a0:	00 00 00 
 7a3:	e9 44 ff ff ff       	jmp    6ec <malloc+0x2c>
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b1                	jmp    767 <malloc+0xa7>
 7b6:	66 90                	xchg   %ax,%ax
 7b8:	66 90                	xchg   %ax,%ax
 7ba:	66 90                	xchg   %ax,%ax
 7bc:	66 90                	xchg   %ax,%ax
 7be:	66 90                	xchg   %ax,%ax

000007c0 <create_tree>:
}

int index = 0;
int curLevel = -2;

void create_tree(struct tree_node* node, int depth){
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 1c             	sub    $0x1c,%esp
 7c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
 7cf:	85 f6                	test   %esi,%esi
 7d1:	0f 84 8a 00 00 00    	je     861 <create_tree+0xa1>
 7d7:	8d 04 b5 fc ff ff ff 	lea    -0x4(,%esi,4),%eax
 7de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7e1:	8d 4e fe             	lea    -0x2(%esi),%ecx
 7e4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 7e7:	03 15 8c 10 00 00    	add    0x108c,%edx
        return;
    }
    if(curLevel != depth-2){
 7ed:	39 0d 74 10 00 00    	cmp    %ecx,0x1074
 7f3:	a1 84 10 00 00       	mov    0x1084,%eax
 7f8:	74 08                	je     802 <create_tree+0x42>
        index = level_index[depth-1];
 7fa:	8b 02                	mov    (%edx),%eax
        curLevel = depth-2;
 7fc:	89 0d 74 10 00 00    	mov    %ecx,0x1074
    }
    node->level = curLevel;
    node->index = index;
 802:	89 43 10             	mov    %eax,0x10(%ebx)
    index++;
 805:	83 c0 01             	add    $0x1,%eax
    level_index[depth-1] = index;
    if(depth == 1){
 808:	83 fe 01             	cmp    $0x1,%esi
    node->level = curLevel;
 80b:	89 4b 14             	mov    %ecx,0x14(%ebx)
    index++;
 80e:	a3 84 10 00 00       	mov    %eax,0x1084
    level_index[depth-1] = index;
 813:	89 02                	mov    %eax,(%edx)
    if(depth == 1){
 815:	74 59                	je     870 <create_tree+0xb0>
        node->left_child = 0;
        node->right_child = 0;
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    }else{
        struct tree_node *left = malloc(sizeof(struct tree_node));
 817:	83 ec 0c             	sub    $0xc,%esp
        left->parent = node;
        right->parent = node;
        node->left_child = left;
        node->right_child = right;
        node->mutex_id = kthread_mutex_alloc();
        create_tree(left, depth-1);
 81a:	83 ee 01             	sub    $0x1,%esi
        struct tree_node *left = malloc(sizeof(struct tree_node));
 81d:	6a 1c                	push   $0x1c
 81f:	e8 9c fe ff ff       	call   6c0 <malloc>
 824:	89 c7                	mov    %eax,%edi
        struct tree_node *right = malloc(sizeof(struct tree_node));
 826:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
 82d:	e8 8e fe ff ff       	call   6c0 <malloc>
        left->parent = node;
 832:	89 5f 08             	mov    %ebx,0x8(%edi)
        right->parent = node;
 835:	89 58 08             	mov    %ebx,0x8(%eax)
        node->left_child = left;
 838:	89 3b                	mov    %edi,(%ebx)
        node->right_child = right;
 83a:	89 43 04             	mov    %eax,0x4(%ebx)
 83d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        node->mutex_id = kthread_mutex_alloc();
 840:	e8 4d fb ff ff       	call   392 <kthread_mutex_alloc>
 845:	89 43 0c             	mov    %eax,0xc(%ebx)
        create_tree(left, depth-1);
 848:	58                   	pop    %eax
 849:	5a                   	pop    %edx
 84a:	56                   	push   %esi
 84b:	57                   	push   %edi
 84c:	e8 6f ff ff ff       	call   7c0 <create_tree>
 851:	8b 55 e0             	mov    -0x20(%ebp),%edx
 854:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
    if(depth == 0){
 858:	83 c4 10             	add    $0x10,%esp
 85b:	85 f6                	test   %esi,%esi
 85d:	89 d3                	mov    %edx,%ebx
 85f:	75 80                	jne    7e1 <create_tree+0x21>
        create_tree(right, depth-1);
    }
    return;
}
 861:	8d 65 f4             	lea    -0xc(%ebp),%esp
 864:	5b                   	pop    %ebx
 865:	5e                   	pop    %esi
 866:	5f                   	pop    %edi
 867:	5d                   	pop    %ebp
 868:	c3                   	ret    
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        node->left_child = 0;
 870:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 876:	a1 88 10 00 00       	mov    0x1088,%eax
 87b:	83 ec 0c             	sub    $0xc,%esp
        node->right_child = 0;
 87e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 885:	c1 e0 02             	shl    $0x2,%eax
 888:	50                   	push   %eax
 889:	e8 32 fe ff ff       	call   6c0 <malloc>
 88e:	83 c4 10             	add    $0x10,%esp
 891:	89 43 18             	mov    %eax,0x18(%ebx)
}
 894:	8d 65 f4             	lea    -0xc(%ebp),%esp
 897:	5b                   	pop    %ebx
 898:	5e                   	pop    %esi
 899:	5f                   	pop    %edi
 89a:	5d                   	pop    %ebp
 89b:	c3                   	ret    
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008a0 <trnmnt_tree_alloc>:
trnmnt_tree* trnmnt_tree_alloc(int depth){
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	56                   	push   %esi
 8a4:	53                   	push   %ebx
 8a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth < 1) // illegal depth
 8a8:	85 db                	test   %ebx,%ebx
 8aa:	7e 74                	jle    920 <trnmnt_tree_alloc+0x80>
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 8ac:	83 ec 0c             	sub    $0xc,%esp
 8af:	6a 08                	push   $0x8
 8b1:	e8 0a fe ff ff       	call   6c0 <malloc>
    struct tree_node *root = malloc(sizeof(struct tree_node));
 8b6:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 8bd:	89 c6                	mov    %eax,%esi
    struct tree_node *root = malloc(sizeof(struct tree_node));
 8bf:	e8 fc fd ff ff       	call   6c0 <malloc>
    int arr[depth+1];
 8c4:	8d 53 01             	lea    0x1(%ebx),%edx
    treeDepth = depth;
 8c7:	89 1d 88 10 00 00    	mov    %ebx,0x1088
    tree->depth = depth;
 8cd:	89 5e 04             	mov    %ebx,0x4(%esi)
    tree->root = root;
 8d0:	89 06                	mov    %eax,(%esi)
    root->parent = 0;
 8d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    int arr[depth+1];
 8d9:	83 c4 10             	add    $0x10,%esp
 8dc:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
 8e3:	83 e0 f0             	and    $0xfffffff0,%eax
 8e6:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < depth+1; i++)
 8e8:	31 c0                	xor    %eax,%eax
    int arr[depth+1];
 8ea:	89 e1                	mov    %esp,%ecx
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        arr[i] = 0;
 8f0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    for(int i = 0; i < depth+1; i++)
 8f7:	83 c0 01             	add    $0x1,%eax
 8fa:	39 c2                	cmp    %eax,%edx
 8fc:	75 f2                	jne    8f0 <trnmnt_tree_alloc+0x50>
    create_tree(tree->root, depth+1);
 8fe:	83 ec 08             	sub    $0x8,%esp
    level_index = arr;
 901:	89 0d 8c 10 00 00    	mov    %ecx,0x108c
    create_tree(tree->root, depth+1);
 907:	52                   	push   %edx
 908:	ff 36                	pushl  (%esi)
 90a:	e8 b1 fe ff ff       	call   7c0 <create_tree>
    return tree;
 90f:	83 c4 10             	add    $0x10,%esp
}
 912:	8d 65 f8             	lea    -0x8(%ebp),%esp
 915:	89 f0                	mov    %esi,%eax
 917:	5b                   	pop    %ebx
 918:	5e                   	pop    %esi
 919:	5d                   	pop    %ebp
 91a:	c3                   	ret    
 91b:	90                   	nop
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 920:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return 0;
 923:	31 f6                	xor    %esi,%esi
}
 925:	89 f0                	mov    %esi,%eax
 927:	5b                   	pop    %ebx
 928:	5e                   	pop    %esi
 929:	5d                   	pop    %ebp
 92a:	c3                   	ret    
 92b:	90                   	nop
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000930 <print_node>:

void print_node(struct tree_node *n,int l){
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 1c             	sub    $0x1c,%esp
 939:	8b 75 08             	mov    0x8(%ebp),%esi
 93c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
 93f:	85 f6                	test   %esi,%esi
 941:	74 5a                	je     99d <print_node+0x6d>
    int i;
	print_node(n->right_child,l+1);
 943:	8d 43 01             	lea    0x1(%ebx),%eax
 946:	83 ec 08             	sub    $0x8,%esp
 949:	50                   	push   %eax
 94a:	ff 76 04             	pushl  0x4(%esi)
 94d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 950:	e8 db ff ff ff       	call   930 <print_node>
	for(i=0;i<l;++i){
 955:	83 c4 10             	add    $0x10,%esp
 958:	85 db                	test   %ebx,%ebx
 95a:	7e 1d                	jle    979 <print_node+0x49>
 95c:	31 ff                	xor    %edi,%edi
 95e:	66 90                	xchg   %ax,%ax
		printf(1,"    ");
 960:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
 963:	83 c7 01             	add    $0x1,%edi
		printf(1,"    ");
 966:	68 19 0c 00 00       	push   $0xc19
 96b:	6a 01                	push   $0x1
 96d:	e8 ee fa ff ff       	call   460 <printf>
	for(i=0;i<l;++i){
 972:	83 c4 10             	add    $0x10,%esp
 975:	39 df                	cmp    %ebx,%edi
 977:	75 e7                	jne    960 <print_node+0x30>
    }
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
 979:	83 ec 0c             	sub    $0xc,%esp
 97c:	ff 76 0c             	pushl  0xc(%esi)
 97f:	ff 76 10             	pushl  0x10(%esi)
 982:	ff 76 14             	pushl  0x14(%esi)
 985:	68 1e 0c 00 00       	push   $0xc1e
 98a:	6a 01                	push   $0x1
 98c:	e8 cf fa ff ff       	call   460 <printf>
	print_node(n->left_child,l+1);
 991:	8b 36                	mov    (%esi),%esi
	if(!n) return;
 993:	83 c4 20             	add    $0x20,%esp
	print_node(n->left_child,l+1);
 996:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
 999:	85 f6                	test   %esi,%esi
 99b:	75 a6                	jne    943 <print_node+0x13>
}
 99d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9a0:	5b                   	pop    %ebx
 9a1:	5e                   	pop    %esi
 9a2:	5f                   	pop    %edi
 9a3:	5d                   	pop    %ebp
 9a4:	c3                   	ret    
 9a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <print_tree>:

void print_tree(trnmnt_tree *t){
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	83 ec 08             	sub    $0x8,%esp
 9b6:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
 9b9:	85 c0                	test   %eax,%eax
 9bb:	74 0f                	je     9cc <print_tree+0x1c>
	print_node(t->root,0);
 9bd:	83 ec 08             	sub    $0x8,%esp
 9c0:	6a 00                	push   $0x0
 9c2:	ff 30                	pushl  (%eax)
 9c4:	e8 67 ff ff ff       	call   930 <print_node>
 9c9:	83 c4 10             	add    $0x10,%esp
}
 9cc:	c9                   	leave  
 9cd:	c3                   	ret    
 9ce:	66 90                	xchg   %ax,%ax

000009d0 <delete_node>:

int delete_node(struct tree_node *node){
 9d0:	55                   	push   %ebp
            node->lockPath = 0;
        }
        // then delete the node
        free(node); 
    }
    return 0;
 9d1:	31 c0                	xor    %eax,%eax
int delete_node(struct tree_node *node){
 9d3:	89 e5                	mov    %esp,%ebp
 9d5:	53                   	push   %ebx
 9d6:	83 ec 04             	sub    $0x4,%esp
 9d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (node != 0){ 
 9dc:	85 db                	test   %ebx,%ebx
 9de:	74 5e                	je     a3e <delete_node+0x6e>
        if(kthread_mutex_dealloc(node->mutex_id) == -1){
 9e0:	83 ec 0c             	sub    $0xc,%esp
 9e3:	ff 73 0c             	pushl  0xc(%ebx)
 9e6:	e8 af f9 ff ff       	call   39a <kthread_mutex_dealloc>
 9eb:	83 c4 10             	add    $0x10,%esp
 9ee:	83 f8 ff             	cmp    $0xffffffff,%eax
 9f1:	74 4b                	je     a3e <delete_node+0x6e>
        delete_node(node->left_child); 
 9f3:	83 ec 0c             	sub    $0xc,%esp
 9f6:	ff 33                	pushl  (%ebx)
 9f8:	e8 d3 ff ff ff       	call   9d0 <delete_node>
        delete_node(node->right_child); 
 9fd:	58                   	pop    %eax
 9fe:	ff 73 04             	pushl  0x4(%ebx)
 a01:	e8 ca ff ff ff       	call   9d0 <delete_node>
        if(node->lockPath){
 a06:	8b 43 18             	mov    0x18(%ebx),%eax
 a09:	83 c4 10             	add    $0x10,%esp
        node->left_child = 0;
 a0c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
 a12:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        if(node->lockPath){
 a19:	85 c0                	test   %eax,%eax
 a1b:	74 13                	je     a30 <delete_node+0x60>
            free(node->lockPath);
 a1d:	83 ec 0c             	sub    $0xc,%esp
 a20:	50                   	push   %eax
 a21:	e8 0a fc ff ff       	call   630 <free>
            node->lockPath = 0;
 a26:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
 a2d:	83 c4 10             	add    $0x10,%esp
        free(node); 
 a30:	83 ec 0c             	sub    $0xc,%esp
 a33:	53                   	push   %ebx
 a34:	e8 f7 fb ff ff       	call   630 <free>
 a39:	83 c4 10             	add    $0x10,%esp
 a3c:	31 c0                	xor    %eax,%eax
}
 a3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 a41:	c9                   	leave  
 a42:	c3                   	ret    
 a43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a50 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(trnmnt_tree* tree){
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	56                   	push   %esi
 a54:	53                   	push   %ebx
 a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
 a58:	83 ec 0c             	sub    $0xc,%esp
 a5b:	ff 33                	pushl  (%ebx)
 a5d:	e8 6e ff ff ff       	call   9d0 <delete_node>
 a62:	83 c4 10             	add    $0x10,%esp
 a65:	85 c0                	test   %eax,%eax
 a67:	75 27                	jne    a90 <trnmnt_tree_dealloc+0x40>
        tree->root = 0;
        free(tree);
 a69:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
 a6c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
 a72:	89 c6                	mov    %eax,%esi
        free(tree);
 a74:	53                   	push   %ebx
 a75:	e8 b6 fb ff ff       	call   630 <free>
        tree = 0;
        return 0;
 a7a:	83 c4 10             	add    $0x10,%esp
    }else{
        return -1;
    }
}
 a7d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a80:	89 f0                	mov    %esi,%eax
 a82:	5b                   	pop    %ebx
 a83:	5e                   	pop    %esi
 a84:	5d                   	pop    %ebp
 a85:	c3                   	ret    
 a86:	8d 76 00             	lea    0x0(%esi),%esi
 a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
 a90:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a95:	eb e6                	jmp    a7d <trnmnt_tree_dealloc+0x2d>
 a97:	89 f6                	mov    %esi,%esi
 a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000aa0 <find_leaf>:
        leaf->lockPath[i] = 0;
    }
    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	57                   	push   %edi
 aa4:	56                   	push   %esi
 aa5:	53                   	push   %ebx
 aa6:	83 ec 0c             	sub    $0xc,%esp
 aa9:	8b 55 08             	mov    0x8(%ebp),%edx
 aac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if(node->right_child == 0 && node->left_child == 0){ 
 aaf:	8b 72 04             	mov    0x4(%edx),%esi
 ab2:	8b 02                	mov    (%edx),%eax
 ab4:	85 f6                	test   %esi,%esi
 ab6:	75 18                	jne    ad0 <find_leaf+0x30>
 ab8:	85 c0                	test   %eax,%eax
 aba:	75 14                	jne    ad0 <find_leaf+0x30>
        if(ID == node->index){
 abc:	39 5a 10             	cmp    %ebx,0x10(%edx)
 abf:	0f 44 c2             	cmove  %edx,%eax
        if(leaf1)
            return leaf1;
        else
            return leaf2;
    }
} 
 ac2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ac5:	5b                   	pop    %ebx
 ac6:	5e                   	pop    %esi
 ac7:	5f                   	pop    %edi
 ac8:	5d                   	pop    %ebp
 ac9:	c3                   	ret    
 aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 ad0:	83 ec 08             	sub    $0x8,%esp
 ad3:	53                   	push   %ebx
 ad4:	50                   	push   %eax
 ad5:	e8 c6 ff ff ff       	call   aa0 <find_leaf>
 ada:	5a                   	pop    %edx
 adb:	59                   	pop    %ecx
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 adc:	53                   	push   %ebx
 add:	56                   	push   %esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 ade:	89 c7                	mov    %eax,%edi
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 ae0:	e8 bb ff ff ff       	call   aa0 <find_leaf>
 ae5:	83 c4 10             	add    $0x10,%esp
        if(leaf1)
 ae8:	85 ff                	test   %edi,%edi
 aea:	0f 45 c7             	cmovne %edi,%eax
} 
 aed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 af0:	5b                   	pop    %ebx
 af1:	5e                   	pop    %esi
 af2:	5f                   	pop    %edi
 af3:	5d                   	pop    %ebp
 af4:	c3                   	ret    
 af5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b00 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	57                   	push   %edi
 b04:	56                   	push   %esi
 b05:	53                   	push   %ebx
 b06:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b09:	8b 45 08             	mov    0x8(%ebp),%eax
 b0c:	ff 75 0c             	pushl  0xc(%ebp)
 b0f:	ff 30                	pushl  (%eax)
 b11:	e8 8a ff ff ff       	call   aa0 <find_leaf>
 b16:	8b 50 08             	mov    0x8(%eax),%edx
 b19:	83 c4 10             	add    $0x10,%esp
 b1c:	89 c7                	mov    %eax,%edi
    while(curNode->parent){
 b1e:	89 c3                	mov    %eax,%ebx
 b20:	85 d2                	test   %edx,%edx
 b22:	74 32                	je     b56 <trnmnt_tree_acquire+0x56>
        int level = curNode->parent->level;
 b24:	8b 72 14             	mov    0x14(%edx),%esi
        int mutex_lock = kthread_mutex_lock(mutexID);
 b27:	83 ec 0c             	sub    $0xc,%esp
 b2a:	ff 72 0c             	pushl  0xc(%edx)
 b2d:	e8 70 f8 ff ff       	call   3a2 <kthread_mutex_lock>
        leaf->lockPath[level] = curNode->parent->mutex_id;
 b32:	8b 53 08             	mov    0x8(%ebx),%edx
        if(mutex_lock == -1){
 b35:	83 c4 10             	add    $0x10,%esp
 b38:	83 f8 ff             	cmp    $0xffffffff,%eax
        leaf->lockPath[level] = curNode->parent->mutex_id;
 b3b:	8b 4a 0c             	mov    0xc(%edx),%ecx
 b3e:	8b 57 18             	mov    0x18(%edi),%edx
 b41:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
        if(mutex_lock == -1){
 b44:	74 12                	je     b58 <trnmnt_tree_acquire+0x58>
        if(mutex_lock == 0){
 b46:	85 c0                	test   %eax,%eax
 b48:	8b 53 08             	mov    0x8(%ebx),%edx
 b4b:	75 d3                	jne    b20 <trnmnt_tree_acquire+0x20>
 b4d:	89 d3                	mov    %edx,%ebx
 b4f:	8b 52 08             	mov    0x8(%edx),%edx
    while(curNode->parent){
 b52:	85 d2                	test   %edx,%edx
 b54:	75 ce                	jne    b24 <trnmnt_tree_acquire+0x24>
    return 0;
 b56:	31 c0                	xor    %eax,%eax
}
 b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b5b:	5b                   	pop    %ebx
 b5c:	5e                   	pop    %esi
 b5d:	5f                   	pop    %edi
 b5e:	5d                   	pop    %ebp
 b5f:	c3                   	ret    

00000b60 <trnmnt_tree_release>:
int trnmnt_tree_release(trnmnt_tree* tree,int ID){
 b60:	55                   	push   %ebp
 b61:	89 e5                	mov    %esp,%ebp
 b63:	57                   	push   %edi
 b64:	56                   	push   %esi
 b65:	53                   	push   %ebx
 b66:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b69:	8b 45 08             	mov    0x8(%ebp),%eax
 b6c:	ff 75 0c             	pushl  0xc(%ebp)
 b6f:	ff 30                	pushl  (%eax)
 b71:	e8 2a ff ff ff       	call   aa0 <find_leaf>
    for(int i = treeDepth-1; i >= 0; i--){
 b76:	8b 35 88 10 00 00    	mov    0x1088,%esi
    struct tree_node* leaf = find_leaf(tree->root, ID);
 b7c:	83 c4 10             	add    $0x10,%esp
    for(int i = treeDepth-1; i >= 0; i--){
 b7f:	83 ee 01             	sub    $0x1,%esi
 b82:	78 44                	js     bc8 <trnmnt_tree_release+0x68>
 b84:	89 c7                	mov    %eax,%edi
 b86:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
 b8d:	eb 16                	jmp    ba5 <trnmnt_tree_release+0x45>
 b8f:	90                   	nop
        leaf->lockPath[i] = 0;
 b90:	8b 47 18             	mov    0x18(%edi),%eax
    for(int i = treeDepth-1; i >= 0; i--){
 b93:	83 ee 01             	sub    $0x1,%esi
        leaf->lockPath[i] = 0;
 b96:	c7 04 18 00 00 00 00 	movl   $0x0,(%eax,%ebx,1)
 b9d:	83 eb 04             	sub    $0x4,%ebx
    for(int i = treeDepth-1; i >= 0; i--){
 ba0:	83 fe ff             	cmp    $0xffffffff,%esi
 ba3:	74 23                	je     bc8 <trnmnt_tree_release+0x68>
        int res = kthread_mutex_unlock(leaf->lockPath[i]);
 ba5:	8b 47 18             	mov    0x18(%edi),%eax
 ba8:	83 ec 0c             	sub    $0xc,%esp
 bab:	ff 34 18             	pushl  (%eax,%ebx,1)
 bae:	e8 f7 f7 ff ff       	call   3aa <kthread_mutex_unlock>
        if(res == -1){
 bb3:	83 c4 10             	add    $0x10,%esp
 bb6:	83 f8 ff             	cmp    $0xffffffff,%eax
 bb9:	75 d5                	jne    b90 <trnmnt_tree_release+0x30>
}
 bbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bbe:	5b                   	pop    %ebx
 bbf:	5e                   	pop    %esi
 bc0:	5f                   	pop    %edi
 bc1:	5d                   	pop    %ebp
 bc2:	c3                   	ret    
 bc3:	90                   	nop
 bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 bc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 bcb:	31 c0                	xor    %eax,%eax
}
 bcd:	5b                   	pop    %ebx
 bce:	5e                   	pop    %esi
 bcf:	5f                   	pop    %edi
 bd0:	5d                   	pop    %ebp
 bd1:	c3                   	ret    
