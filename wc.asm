
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

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
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 d6 03 00 00       	call   412 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
    wc(fd, argv[i]);
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 9c 03 00 00       	call   3fa <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 67 03 00 00       	call   3d2 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 f7 0c 00 00       	push   $0xcf7
  73:	6a 01                	push   $0x1
  75:	e8 e6 04 00 00       	call   560 <printf>
      exit();
  7a:	e8 53 03 00 00       	call   3d2 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 33 0d 00 00       	push   $0xd33
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 40 03 00 00       	call   3d2 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  l = w = c = 0;
  a6:	31 db                	xor    %ebx,%ebx
{
  a8:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
  ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 e0 11 00 00       	push   $0x11e0
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 15 03 00 00       	call   3ea <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 c6                	mov    %eax,%esi
  dd:	7e 61                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  df:	31 ff                	xor    %edi,%edi
  e1:	eb 13                	jmp    f6 <wc+0x56>
  e3:	90                   	nop
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        inword = 0;
  e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  ef:	83 c7 01             	add    $0x1,%edi
  f2:	39 fe                	cmp    %edi,%esi
  f4:	74 42                	je     138 <wc+0x98>
      if(buf[i] == '\n')
  f6:	0f be 87 e0 11 00 00 	movsbl 0x11e0(%edi),%eax
        l++;
  fd:	31 c9                	xor    %ecx,%ecx
  ff:	3c 0a                	cmp    $0xa,%al
 101:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 104:	83 ec 08             	sub    $0x8,%esp
 107:	50                   	push   %eax
 108:	68 d4 0c 00 00       	push   $0xcd4
        l++;
 10d:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10f:	e8 3c 01 00 00       	call   250 <strchr>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	75 cd                	jne    e8 <wc+0x48>
      else if(!inword){
 11b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 11e:	85 d2                	test   %edx,%edx
 120:	75 cd                	jne    ef <wc+0x4f>
    for(i=0; i<n; i++){
 122:	83 c7 01             	add    $0x1,%edi
        w++;
 125:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
        inword = 1;
 129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 130:	39 fe                	cmp    %edi,%esi
 132:	75 c2                	jne    f6 <wc+0x56>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	01 75 e0             	add    %esi,-0x20(%ebp)
 13b:	eb 83                	jmp    c0 <wc+0x20>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
 140:	75 24                	jne    166 <wc+0xc6>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 142:	83 ec 08             	sub    $0x8,%esp
 145:	ff 75 0c             	pushl  0xc(%ebp)
 148:	ff 75 e0             	pushl  -0x20(%ebp)
 14b:	ff 75 dc             	pushl  -0x24(%ebp)
 14e:	53                   	push   %ebx
 14f:	68 ea 0c 00 00       	push   $0xcea
 154:	6a 01                	push   $0x1
 156:	e8 05 04 00 00       	call   560 <printf>
}
 15b:	83 c4 20             	add    $0x20,%esp
 15e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5f                   	pop    %edi
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    
    printf(1, "wc: read error\n");
 166:	50                   	push   %eax
 167:	50                   	push   %eax
 168:	68 da 0c 00 00       	push   $0xcda
 16d:	6a 01                	push   $0x1
 16f:	e8 ec 03 00 00       	call   560 <printf>
    exit();
 174:	e8 59 02 00 00       	call   3d2 <exit>
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	0f b6 19             	movzbl (%ecx),%ebx
 1c0:	84 c0                	test   %al,%al
 1c2:	75 1c                	jne    1e0 <strcmp+0x30>
 1c4:	eb 2a                	jmp    1f0 <strcmp+0x40>
 1c6:	8d 76 00             	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1d6:	83 c1 01             	add    $0x1,%ecx
 1d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 1dc:	84 c0                	test   %al,%al
 1de:	74 10                	je     1f0 <strcmp+0x40>
 1e0:	38 d8                	cmp    %bl,%al
 1e2:	74 ec                	je     1d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1e4:	29 d8                	sub    %ebx,%eax
}
 1e6:	5b                   	pop    %ebx
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 15                	je     220 <strlen+0x20>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d9                	mov    %ebx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 296:	31 f6                	xor    %esi,%esi
 298:	89 f3                	mov    %esi,%ebx
{
 29a:	83 ec 1c             	sub    $0x1c,%esp
 29d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2a0:	eb 2f                	jmp    2d1 <gets+0x41>
 2a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2ab:	83 ec 04             	sub    $0x4,%esp
 2ae:	6a 01                	push   $0x1
 2b0:	50                   	push   %eax
 2b1:	6a 00                	push   $0x0
 2b3:	e8 32 01 00 00       	call   3ea <read>
    if(cc < 1)
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	85 c0                	test   %eax,%eax
 2bd:	7e 1c                	jle    2db <gets+0x4b>
      break;
    buf[i++] = c;
 2bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c3:	83 c7 01             	add    $0x1,%edi
 2c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2c9:	3c 0a                	cmp    $0xa,%al
 2cb:	74 23                	je     2f0 <gets+0x60>
 2cd:	3c 0d                	cmp    $0xd,%al
 2cf:	74 1f                	je     2f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 2d1:	83 c3 01             	add    $0x1,%ebx
 2d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d7:	89 fe                	mov    %edi,%esi
 2d9:	7c cd                	jl     2a8 <gets+0x18>
 2db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    
 2eb:	90                   	nop
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f0:	8b 75 08             	mov    0x8(%ebp),%esi
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	01 de                	add    %ebx,%esi
 2f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 2fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 300:	5b                   	pop    %ebx
 301:	5e                   	pop    %esi
 302:	5f                   	pop    %edi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    
 305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	pushl  0x8(%ebp)
 31d:	e8 f0 00 00 00       	call   412 <open>
  if(fd < 0)
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	pushl  0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 f3 00 00 00       	call   42a <fstat>
  close(fd);
 337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33a:	89 c6                	mov    %eax,%esi
  close(fd);
 33c:	e8 b9 00 00 00       	call   3fa <close>
  return r;
 341:	83 c4 10             	add    $0x10,%esp
}
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 11             	movsbl (%ecx),%edx
 36a:	8d 42 d0             	lea    -0x30(%edx),%eax
 36d:	3c 09                	cmp    $0x9,%al
  n = 0;
 36f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 374:	77 1f                	ja     395 <atoi+0x35>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 380:	8d 04 80             	lea    (%eax,%eax,4),%eax
 383:	83 c1 01             	add    $0x1,%ecx
 386:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 38a:	0f be 11             	movsbl (%ecx),%edx
 38d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	5b                   	pop    %ebx
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
 3a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	7e 14                	jle    3c6 <memmove+0x26>
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3c2:	39 d3                	cmp    %edx,%ebx
 3c4:	75 f2                	jne    3b8 <memmove+0x18>
  return vdst;
}
 3c6:	5b                   	pop    %ebx
 3c7:	5e                   	pop    %esi
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    

000003ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ca:	b8 01 00 00 00       	mov    $0x1,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <exit>:
SYSCALL(exit)
 3d2:	b8 02 00 00 00       	mov    $0x2,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <wait>:
SYSCALL(wait)
 3da:	b8 03 00 00 00       	mov    $0x3,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <pipe>:
SYSCALL(pipe)
 3e2:	b8 04 00 00 00       	mov    $0x4,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <read>:
SYSCALL(read)
 3ea:	b8 05 00 00 00       	mov    $0x5,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <write>:
SYSCALL(write)
 3f2:	b8 10 00 00 00       	mov    $0x10,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <close>:
SYSCALL(close)
 3fa:	b8 15 00 00 00       	mov    $0x15,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <kill>:
SYSCALL(kill)
 402:	b8 06 00 00 00       	mov    $0x6,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <exec>:
SYSCALL(exec)
 40a:	b8 07 00 00 00       	mov    $0x7,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <open>:
SYSCALL(open)
 412:	b8 0f 00 00 00       	mov    $0xf,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <mknod>:
SYSCALL(mknod)
 41a:	b8 11 00 00 00       	mov    $0x11,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <unlink>:
SYSCALL(unlink)
 422:	b8 12 00 00 00       	mov    $0x12,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <fstat>:
SYSCALL(fstat)
 42a:	b8 08 00 00 00       	mov    $0x8,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <link>:
SYSCALL(link)
 432:	b8 13 00 00 00       	mov    $0x13,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <mkdir>:
SYSCALL(mkdir)
 43a:	b8 14 00 00 00       	mov    $0x14,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <chdir>:
SYSCALL(chdir)
 442:	b8 09 00 00 00       	mov    $0x9,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <dup>:
SYSCALL(dup)
 44a:	b8 0a 00 00 00       	mov    $0xa,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <getpid>:
SYSCALL(getpid)
 452:	b8 0b 00 00 00       	mov    $0xb,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <sbrk>:
SYSCALL(sbrk)
 45a:	b8 0c 00 00 00       	mov    $0xc,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <sleep>:
SYSCALL(sleep)
 462:	b8 0d 00 00 00       	mov    $0xd,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <uptime>:
SYSCALL(uptime)
 46a:	b8 0e 00 00 00       	mov    $0xe,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kthread_create>:
SYSCALL(kthread_create)
 472:	b8 16 00 00 00       	mov    $0x16,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <kthread_id>:
SYSCALL(kthread_id)
 47a:	b8 17 00 00 00       	mov    $0x17,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <kthread_exit>:
SYSCALL(kthread_exit)
 482:	b8 18 00 00 00       	mov    $0x18,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <kthread_join>:
SYSCALL(kthread_join)
 48a:	b8 19 00 00 00       	mov    $0x19,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 492:	b8 1a 00 00 00       	mov    $0x1a,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 49a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 4a2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 4aa:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    
 4b2:	66 90                	xchg   %ax,%ax
 4b4:	66 90                	xchg   %ax,%ax
 4b6:	66 90                	xchg   %ax,%ax
 4b8:	66 90                	xchg   %ax,%ax
 4ba:	66 90                	xchg   %ax,%ax
 4bc:	66 90                	xchg   %ax,%ax
 4be:	66 90                	xchg   %ax,%ax

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c9:	85 d2                	test   %edx,%edx
{
 4cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 4ce:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 4d0:	79 76                	jns    548 <printint+0x88>
 4d2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4d6:	74 70                	je     548 <printint+0x88>
    x = -xx;
 4d8:	f7 d8                	neg    %eax
    neg = 1;
 4da:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4e1:	31 f6                	xor    %esi,%esi
 4e3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4e6:	eb 0a                	jmp    4f2 <printint+0x32>
 4e8:	90                   	nop
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 4f0:	89 fe                	mov    %edi,%esi
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	8d 7e 01             	lea    0x1(%esi),%edi
 4f7:	f7 f1                	div    %ecx
 4f9:	0f b6 92 14 0d 00 00 	movzbl 0xd14(%edx),%edx
  }while((x /= base) != 0);
 500:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 502:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 505:	75 e9                	jne    4f0 <printint+0x30>
  if(neg)
 507:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 50a:	85 c0                	test   %eax,%eax
 50c:	74 08                	je     516 <printint+0x56>
    buf[i++] = '-';
 50e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 513:	8d 7e 02             	lea    0x2(%esi),%edi
 516:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 51a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 51d:	8d 76 00             	lea    0x0(%esi),%esi
 520:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
 526:	83 ee 01             	sub    $0x1,%esi
 529:	6a 01                	push   $0x1
 52b:	53                   	push   %ebx
 52c:	57                   	push   %edi
 52d:	88 45 d7             	mov    %al,-0x29(%ebp)
 530:	e8 bd fe ff ff       	call   3f2 <write>

  while(--i >= 0)
 535:	83 c4 10             	add    $0x10,%esp
 538:	39 de                	cmp    %ebx,%esi
 53a:	75 e4                	jne    520 <printint+0x60>
    putc(fd, buf[i]);
}
 53c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 548:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 54f:	eb 90                	jmp    4e1 <printint+0x21>
 551:	eb 0d                	jmp    560 <printf>
 553:	90                   	nop
 554:	90                   	nop
 555:	90                   	nop
 556:	90                   	nop
 557:	90                   	nop
 558:	90                   	nop
 559:	90                   	nop
 55a:	90                   	nop
 55b:	90                   	nop
 55c:	90                   	nop
 55d:	90                   	nop
 55e:	90                   	nop
 55f:	90                   	nop

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 75 0c             	mov    0xc(%ebp),%esi
 56c:	0f b6 1e             	movzbl (%esi),%ebx
 56f:	84 db                	test   %bl,%bl
 571:	0f 84 b3 00 00 00    	je     62a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 577:	8d 45 10             	lea    0x10(%ebp),%eax
 57a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 57d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 57f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 582:	eb 2f                	jmp    5b3 <printf+0x53>
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 588:	83 f8 25             	cmp    $0x25,%eax
 58b:	0f 84 a7 00 00 00    	je     638 <printf+0xd8>
  write(fd, &c, 1);
 591:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 594:	83 ec 04             	sub    $0x4,%esp
 597:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 59a:	6a 01                	push   $0x1
 59c:	50                   	push   %eax
 59d:	ff 75 08             	pushl  0x8(%ebp)
 5a0:	e8 4d fe ff ff       	call   3f2 <write>
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 5ab:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5af:	84 db                	test   %bl,%bl
 5b1:	74 77                	je     62a <printf+0xca>
    if(state == 0){
 5b3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5b5:	0f be cb             	movsbl %bl,%ecx
 5b8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5bb:	74 cb                	je     588 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5bd:	83 ff 25             	cmp    $0x25,%edi
 5c0:	75 e6                	jne    5a8 <printf+0x48>
      if(c == 'd'){
 5c2:	83 f8 64             	cmp    $0x64,%eax
 5c5:	0f 84 05 01 00 00    	je     6d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5cb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5d1:	83 f9 70             	cmp    $0x70,%ecx
 5d4:	74 72                	je     648 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5d6:	83 f8 73             	cmp    $0x73,%eax
 5d9:	0f 84 99 00 00 00    	je     678 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5df:	83 f8 63             	cmp    $0x63,%eax
 5e2:	0f 84 08 01 00 00    	je     6f0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5e8:	83 f8 25             	cmp    $0x25,%eax
 5eb:	0f 84 ef 00 00 00    	je     6e0 <printf+0x180>
  write(fd, &c, 1);
 5f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5f4:	83 ec 04             	sub    $0x4,%esp
 5f7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5fb:	6a 01                	push   $0x1
 5fd:	50                   	push   %eax
 5fe:	ff 75 08             	pushl  0x8(%ebp)
 601:	e8 ec fd ff ff       	call   3f2 <write>
 606:	83 c4 0c             	add    $0xc,%esp
 609:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 60c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 60f:	6a 01                	push   $0x1
 611:	50                   	push   %eax
 612:	ff 75 08             	pushl  0x8(%ebp)
 615:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 618:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 61a:	e8 d3 fd ff ff       	call   3f2 <write>
  for(i = 0; fmt[i]; i++){
 61f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 623:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 626:	84 db                	test   %bl,%bl
 628:	75 89                	jne    5b3 <printf+0x53>
    }
  }
}
 62a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 62d:	5b                   	pop    %ebx
 62e:	5e                   	pop    %esi
 62f:	5f                   	pop    %edi
 630:	5d                   	pop    %ebp
 631:	c3                   	ret    
 632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 638:	bf 25 00 00 00       	mov    $0x25,%edi
 63d:	e9 66 ff ff ff       	jmp    5a8 <printf+0x48>
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 648:	83 ec 0c             	sub    $0xc,%esp
 64b:	b9 10 00 00 00       	mov    $0x10,%ecx
 650:	6a 00                	push   $0x0
 652:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 655:	8b 45 08             	mov    0x8(%ebp),%eax
 658:	8b 17                	mov    (%edi),%edx
 65a:	e8 61 fe ff ff       	call   4c0 <printint>
        ap++;
 65f:	89 f8                	mov    %edi,%eax
 661:	83 c4 10             	add    $0x10,%esp
      state = 0;
 664:	31 ff                	xor    %edi,%edi
        ap++;
 666:	83 c0 04             	add    $0x4,%eax
 669:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 66c:	e9 37 ff ff ff       	jmp    5a8 <printf+0x48>
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 67b:	8b 08                	mov    (%eax),%ecx
        ap++;
 67d:	83 c0 04             	add    $0x4,%eax
 680:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 683:	85 c9                	test   %ecx,%ecx
 685:	0f 84 8e 00 00 00    	je     719 <printf+0x1b9>
        while(*s != 0){
 68b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 68e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 690:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 692:	84 c0                	test   %al,%al
 694:	0f 84 0e ff ff ff    	je     5a8 <printf+0x48>
 69a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 69d:	89 de                	mov    %ebx,%esi
 69f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 6a5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6a8:	83 ec 04             	sub    $0x4,%esp
          s++;
 6ab:	83 c6 01             	add    $0x1,%esi
 6ae:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6b1:	6a 01                	push   $0x1
 6b3:	57                   	push   %edi
 6b4:	53                   	push   %ebx
 6b5:	e8 38 fd ff ff       	call   3f2 <write>
        while(*s != 0){
 6ba:	0f b6 06             	movzbl (%esi),%eax
 6bd:	83 c4 10             	add    $0x10,%esp
 6c0:	84 c0                	test   %al,%al
 6c2:	75 e4                	jne    6a8 <printf+0x148>
 6c4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 6c7:	31 ff                	xor    %edi,%edi
 6c9:	e9 da fe ff ff       	jmp    5a8 <printf+0x48>
 6ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6d8:	6a 01                	push   $0x1
 6da:	e9 73 ff ff ff       	jmp    652 <printf+0xf2>
 6df:	90                   	nop
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6e9:	6a 01                	push   $0x1
 6eb:	e9 21 ff ff ff       	jmp    611 <printf+0xb1>
        putc(fd, *ap);
 6f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 6f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6f6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 6f8:	6a 01                	push   $0x1
        ap++;
 6fa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 6fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 700:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 703:	50                   	push   %eax
 704:	ff 75 08             	pushl  0x8(%ebp)
 707:	e8 e6 fc ff ff       	call   3f2 <write>
        ap++;
 70c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 70f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 712:	31 ff                	xor    %edi,%edi
 714:	e9 8f fe ff ff       	jmp    5a8 <printf+0x48>
          s = "(null)";
 719:	bb 0b 0d 00 00       	mov    $0xd0b,%ebx
        while(*s != 0){
 71e:	b8 28 00 00 00       	mov    $0x28,%eax
 723:	e9 72 ff ff ff       	jmp    69a <printf+0x13a>
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 c0 11 00 00       	mov    0x11c0,%eax
{
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 73e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 748:	39 c8                	cmp    %ecx,%eax
 74a:	8b 10                	mov    (%eax),%edx
 74c:	73 32                	jae    780 <free+0x50>
 74e:	39 d1                	cmp    %edx,%ecx
 750:	72 04                	jb     756 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 752:	39 d0                	cmp    %edx,%eax
 754:	72 32                	jb     788 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 756:	8b 73 fc             	mov    -0x4(%ebx),%esi
 759:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75c:	39 fa                	cmp    %edi,%edx
 75e:	74 30                	je     790 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 760:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 763:	8b 50 04             	mov    0x4(%eax),%edx
 766:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 769:	39 f1                	cmp    %esi,%ecx
 76b:	74 3a                	je     7a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 76d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 76f:	a3 c0 11 00 00       	mov    %eax,0x11c0
}
 774:	5b                   	pop    %ebx
 775:	5e                   	pop    %esi
 776:	5f                   	pop    %edi
 777:	5d                   	pop    %ebp
 778:	c3                   	ret    
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	39 d0                	cmp    %edx,%eax
 782:	72 04                	jb     788 <free+0x58>
 784:	39 d1                	cmp    %edx,%ecx
 786:	72 ce                	jb     756 <free+0x26>
{
 788:	89 d0                	mov    %edx,%eax
 78a:	eb bc                	jmp    748 <free+0x18>
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 790:	03 72 04             	add    0x4(%edx),%esi
 793:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	8b 10                	mov    (%eax),%edx
 798:	8b 12                	mov    (%edx),%edx
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	75 c6                	jne    76d <free+0x3d>
    p->s.size += bp->s.size;
 7a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7aa:	a3 c0 11 00 00       	mov    %eax,0x11c0
    p->s.size += bp->s.size;
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7b5:	89 10                	mov    %edx,(%eax)
}
 7b7:	5b                   	pop    %ebx
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret    
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 c0 11 00 00    	mov    0x11c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 78 07             	lea    0x7(%eax),%edi
 7d5:	c1 ef 03             	shr    $0x3,%edi
 7d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7db:	85 d2                	test   %edx,%edx
 7dd:	0f 84 9d 00 00 00    	je     880 <malloc+0xc0>
 7e3:	8b 02                	mov    (%edx),%eax
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7e8:	39 cf                	cmp    %ecx,%edi
 7ea:	76 6c                	jbe    858 <malloc+0x98>
 7ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 801:	eb 0e                	jmp    811 <malloc+0x51>
 803:	90                   	nop
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 808:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 80a:	8b 48 04             	mov    0x4(%eax),%ecx
 80d:	39 f9                	cmp    %edi,%ecx
 80f:	73 47                	jae    858 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 811:	39 05 c0 11 00 00    	cmp    %eax,0x11c0
 817:	89 c2                	mov    %eax,%edx
 819:	75 ed                	jne    808 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 81b:	83 ec 0c             	sub    $0xc,%esp
 81e:	56                   	push   %esi
 81f:	e8 36 fc ff ff       	call   45a <sbrk>
  if(p == (char*)-1)
 824:	83 c4 10             	add    $0x10,%esp
 827:	83 f8 ff             	cmp    $0xffffffff,%eax
 82a:	74 1c                	je     848 <malloc+0x88>
  hp->s.size = nu;
 82c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 82f:	83 ec 0c             	sub    $0xc,%esp
 832:	83 c0 08             	add    $0x8,%eax
 835:	50                   	push   %eax
 836:	e8 f5 fe ff ff       	call   730 <free>
  return freep;
 83b:	8b 15 c0 11 00 00    	mov    0x11c0,%edx
      if((p = morecore(nunits)) == 0)
 841:	83 c4 10             	add    $0x10,%esp
 844:	85 d2                	test   %edx,%edx
 846:	75 c0                	jne    808 <malloc+0x48>
        return 0;
  }
}
 848:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 84b:	31 c0                	xor    %eax,%eax
}
 84d:	5b                   	pop    %ebx
 84e:	5e                   	pop    %esi
 84f:	5f                   	pop    %edi
 850:	5d                   	pop    %ebp
 851:	c3                   	ret    
 852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 858:	39 cf                	cmp    %ecx,%edi
 85a:	74 54                	je     8b0 <malloc+0xf0>
        p->s.size -= nunits;
 85c:	29 f9                	sub    %edi,%ecx
 85e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 861:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 864:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 867:	89 15 c0 11 00 00    	mov    %edx,0x11c0
}
 86d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 870:	83 c0 08             	add    $0x8,%eax
}
 873:	5b                   	pop    %ebx
 874:	5e                   	pop    %esi
 875:	5f                   	pop    %edi
 876:	5d                   	pop    %ebp
 877:	c3                   	ret    
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 880:	c7 05 c0 11 00 00 c4 	movl   $0x11c4,0x11c0
 887:	11 00 00 
 88a:	c7 05 c4 11 00 00 c4 	movl   $0x11c4,0x11c4
 891:	11 00 00 
    base.s.size = 0;
 894:	b8 c4 11 00 00       	mov    $0x11c4,%eax
 899:	c7 05 c8 11 00 00 00 	movl   $0x0,0x11c8
 8a0:	00 00 00 
 8a3:	e9 44 ff ff ff       	jmp    7ec <malloc+0x2c>
 8a8:	90                   	nop
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8b0:	8b 08                	mov    (%eax),%ecx
 8b2:	89 0a                	mov    %ecx,(%edx)
 8b4:	eb b1                	jmp    867 <malloc+0xa7>
 8b6:	66 90                	xchg   %ax,%ax
 8b8:	66 90                	xchg   %ax,%ax
 8ba:	66 90                	xchg   %ax,%ax
 8bc:	66 90                	xchg   %ax,%ax
 8be:	66 90                	xchg   %ax,%ax

000008c0 <create_tree>:
}

int index = 0;
int curLevel = -2;

void create_tree(struct tree_node* node, int depth){
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	56                   	push   %esi
 8c5:	53                   	push   %ebx
 8c6:	83 ec 1c             	sub    $0x1c,%esp
 8c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth == 0){
 8cf:	85 f6                	test   %esi,%esi
 8d1:	0f 84 8a 00 00 00    	je     961 <create_tree+0xa1>
 8d7:	8d 04 b5 fc ff ff ff 	lea    -0x4(,%esi,4),%eax
 8de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8e1:	8d 4e fe             	lea    -0x2(%esi),%ecx
 8e4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8e7:	03 15 e0 13 00 00    	add    0x13e0,%edx
        return;
    }
    if(curLevel != depth-2){
 8ed:	39 0d b0 11 00 00    	cmp    %ecx,0x11b0
 8f3:	a1 cc 11 00 00       	mov    0x11cc,%eax
 8f8:	74 08                	je     902 <create_tree+0x42>
        index = level_index[depth-1];
 8fa:	8b 02                	mov    (%edx),%eax
        curLevel = depth-2;
 8fc:	89 0d b0 11 00 00    	mov    %ecx,0x11b0
    }
    node->level = curLevel;
    node->index = index;
 902:	89 43 10             	mov    %eax,0x10(%ebx)
    index++;
 905:	83 c0 01             	add    $0x1,%eax
    level_index[depth-1] = index;
    if(depth == 1){
 908:	83 fe 01             	cmp    $0x1,%esi
    node->level = curLevel;
 90b:	89 4b 14             	mov    %ecx,0x14(%ebx)
    index++;
 90e:	a3 cc 11 00 00       	mov    %eax,0x11cc
    level_index[depth-1] = index;
 913:	89 02                	mov    %eax,(%edx)
    if(depth == 1){
 915:	74 59                	je     970 <create_tree+0xb0>
        node->left_child = 0;
        node->right_child = 0;
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
    }else{
        struct tree_node *left = malloc(sizeof(struct tree_node));
 917:	83 ec 0c             	sub    $0xc,%esp
        left->parent = node;
        right->parent = node;
        node->left_child = left;
        node->right_child = right;
        node->mutex_id = kthread_mutex_alloc();
        create_tree(left, depth-1);
 91a:	83 ee 01             	sub    $0x1,%esi
        struct tree_node *left = malloc(sizeof(struct tree_node));
 91d:	6a 1c                	push   $0x1c
 91f:	e8 9c fe ff ff       	call   7c0 <malloc>
 924:	89 c7                	mov    %eax,%edi
        struct tree_node *right = malloc(sizeof(struct tree_node));
 926:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
 92d:	e8 8e fe ff ff       	call   7c0 <malloc>
        left->parent = node;
 932:	89 5f 08             	mov    %ebx,0x8(%edi)
        right->parent = node;
 935:	89 58 08             	mov    %ebx,0x8(%eax)
        node->left_child = left;
 938:	89 3b                	mov    %edi,(%ebx)
        node->right_child = right;
 93a:	89 43 04             	mov    %eax,0x4(%ebx)
 93d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        node->mutex_id = kthread_mutex_alloc();
 940:	e8 4d fb ff ff       	call   492 <kthread_mutex_alloc>
 945:	89 43 0c             	mov    %eax,0xc(%ebx)
        create_tree(left, depth-1);
 948:	58                   	pop    %eax
 949:	5a                   	pop    %edx
 94a:	56                   	push   %esi
 94b:	57                   	push   %edi
 94c:	e8 6f ff ff ff       	call   8c0 <create_tree>
 951:	8b 55 e0             	mov    -0x20(%ebp),%edx
 954:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
    if(depth == 0){
 958:	83 c4 10             	add    $0x10,%esp
 95b:	85 f6                	test   %esi,%esi
 95d:	89 d3                	mov    %edx,%ebx
 95f:	75 80                	jne    8e1 <create_tree+0x21>
        create_tree(right, depth-1);
    }
    return;
}
 961:	8d 65 f4             	lea    -0xc(%ebp),%esp
 964:	5b                   	pop    %ebx
 965:	5e                   	pop    %esi
 966:	5f                   	pop    %edi
 967:	5d                   	pop    %ebp
 968:	c3                   	ret    
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        node->left_child = 0;
 970:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 976:	a1 d0 11 00 00       	mov    0x11d0,%eax
 97b:	83 ec 0c             	sub    $0xc,%esp
        node->right_child = 0;
 97e:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        node->lockPath = (int*)malloc(treeDepth*sizeof(int));
 985:	c1 e0 02             	shl    $0x2,%eax
 988:	50                   	push   %eax
 989:	e8 32 fe ff ff       	call   7c0 <malloc>
 98e:	83 c4 10             	add    $0x10,%esp
 991:	89 43 18             	mov    %eax,0x18(%ebx)
}
 994:	8d 65 f4             	lea    -0xc(%ebp),%esp
 997:	5b                   	pop    %ebx
 998:	5e                   	pop    %esi
 999:	5f                   	pop    %edi
 99a:	5d                   	pop    %ebp
 99b:	c3                   	ret    
 99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009a0 <trnmnt_tree_alloc>:
trnmnt_tree* trnmnt_tree_alloc(int depth){
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	56                   	push   %esi
 9a4:	53                   	push   %ebx
 9a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(depth < 1) // illegal depth
 9a8:	85 db                	test   %ebx,%ebx
 9aa:	7e 74                	jle    a20 <trnmnt_tree_alloc+0x80>
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 9ac:	83 ec 0c             	sub    $0xc,%esp
 9af:	6a 08                	push   $0x8
 9b1:	e8 0a fe ff ff       	call   7c0 <malloc>
    struct tree_node *root = malloc(sizeof(struct tree_node));
 9b6:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    trnmnt_tree *tree = malloc(sizeof(trnmnt_tree));
 9bd:	89 c6                	mov    %eax,%esi
    struct tree_node *root = malloc(sizeof(struct tree_node));
 9bf:	e8 fc fd ff ff       	call   7c0 <malloc>
    int arr[depth+1];
 9c4:	8d 53 01             	lea    0x1(%ebx),%edx
    treeDepth = depth;
 9c7:	89 1d d0 11 00 00    	mov    %ebx,0x11d0
    tree->depth = depth;
 9cd:	89 5e 04             	mov    %ebx,0x4(%esi)
    tree->root = root;
 9d0:	89 06                	mov    %eax,(%esi)
    root->parent = 0;
 9d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    int arr[depth+1];
 9d9:	83 c4 10             	add    $0x10,%esp
 9dc:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
 9e3:	83 e0 f0             	and    $0xfffffff0,%eax
 9e6:	29 c4                	sub    %eax,%esp
    for(int i = 0; i < depth+1; i++)
 9e8:	31 c0                	xor    %eax,%eax
    int arr[depth+1];
 9ea:	89 e1                	mov    %esp,%ecx
 9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        arr[i] = 0;
 9f0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    for(int i = 0; i < depth+1; i++)
 9f7:	83 c0 01             	add    $0x1,%eax
 9fa:	39 c2                	cmp    %eax,%edx
 9fc:	75 f2                	jne    9f0 <trnmnt_tree_alloc+0x50>
    create_tree(tree->root, depth+1);
 9fe:	83 ec 08             	sub    $0x8,%esp
    level_index = arr;
 a01:	89 0d e0 13 00 00    	mov    %ecx,0x13e0
    create_tree(tree->root, depth+1);
 a07:	52                   	push   %edx
 a08:	ff 36                	pushl  (%esi)
 a0a:	e8 b1 fe ff ff       	call   8c0 <create_tree>
    return tree;
 a0f:	83 c4 10             	add    $0x10,%esp
}
 a12:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a15:	89 f0                	mov    %esi,%eax
 a17:	5b                   	pop    %ebx
 a18:	5e                   	pop    %esi
 a19:	5d                   	pop    %ebp
 a1a:	c3                   	ret    
 a1b:	90                   	nop
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a20:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return 0;
 a23:	31 f6                	xor    %esi,%esi
}
 a25:	89 f0                	mov    %esi,%eax
 a27:	5b                   	pop    %ebx
 a28:	5e                   	pop    %esi
 a29:	5d                   	pop    %ebp
 a2a:	c3                   	ret    
 a2b:	90                   	nop
 a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a30 <print_node>:

void print_node(struct tree_node *n,int l){
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	57                   	push   %edi
 a34:	56                   	push   %esi
 a35:	53                   	push   %ebx
 a36:	83 ec 1c             	sub    $0x1c,%esp
 a39:	8b 75 08             	mov    0x8(%ebp),%esi
 a3c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if(!n) return;
 a3f:	85 f6                	test   %esi,%esi
 a41:	74 5a                	je     a9d <print_node+0x6d>
    int i;
	print_node(n->right_child,l+1);
 a43:	8d 43 01             	lea    0x1(%ebx),%eax
 a46:	83 ec 08             	sub    $0x8,%esp
 a49:	50                   	push   %eax
 a4a:	ff 76 04             	pushl  0x4(%esi)
 a4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 a50:	e8 db ff ff ff       	call   a30 <print_node>
	for(i=0;i<l;++i){
 a55:	83 c4 10             	add    $0x10,%esp
 a58:	85 db                	test   %ebx,%ebx
 a5a:	7e 1d                	jle    a79 <print_node+0x49>
 a5c:	31 ff                	xor    %edi,%edi
 a5e:	66 90                	xchg   %ax,%ax
		printf(1,"    ");
 a60:	83 ec 08             	sub    $0x8,%esp
	for(i=0;i<l;++i){
 a63:	83 c7 01             	add    $0x1,%edi
		printf(1,"    ");
 a66:	68 25 0d 00 00       	push   $0xd25
 a6b:	6a 01                	push   $0x1
 a6d:	e8 ee fa ff ff       	call   560 <printf>
	for(i=0;i<l;++i){
 a72:	83 c4 10             	add    $0x10,%esp
 a75:	39 df                	cmp    %ebx,%edi
 a77:	75 e7                	jne    a60 <print_node+0x30>
    }
	printf(1,"%d,%d,%d\n",n->level, n->index, n->mutex_id);
 a79:	83 ec 0c             	sub    $0xc,%esp
 a7c:	ff 76 0c             	pushl  0xc(%esi)
 a7f:	ff 76 10             	pushl  0x10(%esi)
 a82:	ff 76 14             	pushl  0x14(%esi)
 a85:	68 2a 0d 00 00       	push   $0xd2a
 a8a:	6a 01                	push   $0x1
 a8c:	e8 cf fa ff ff       	call   560 <printf>
	print_node(n->left_child,l+1);
 a91:	8b 36                	mov    (%esi),%esi
	if(!n) return;
 a93:	83 c4 20             	add    $0x20,%esp
	print_node(n->left_child,l+1);
 a96:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
	if(!n) return;
 a99:	85 f6                	test   %esi,%esi
 a9b:	75 a6                	jne    a43 <print_node+0x13>
}
 a9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 aa0:	5b                   	pop    %ebx
 aa1:	5e                   	pop    %esi
 aa2:	5f                   	pop    %edi
 aa3:	5d                   	pop    %ebp
 aa4:	c3                   	ret    
 aa5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ab0 <print_tree>:

void print_tree(trnmnt_tree *t){
 ab0:	55                   	push   %ebp
 ab1:	89 e5                	mov    %esp,%ebp
 ab3:	83 ec 08             	sub    $0x8,%esp
 ab6:	8b 45 08             	mov    0x8(%ebp),%eax
    if(!t) return;
 ab9:	85 c0                	test   %eax,%eax
 abb:	74 0f                	je     acc <print_tree+0x1c>
	print_node(t->root,0);
 abd:	83 ec 08             	sub    $0x8,%esp
 ac0:	6a 00                	push   $0x0
 ac2:	ff 30                	pushl  (%eax)
 ac4:	e8 67 ff ff ff       	call   a30 <print_node>
 ac9:	83 c4 10             	add    $0x10,%esp
}
 acc:	c9                   	leave  
 acd:	c3                   	ret    
 ace:	66 90                	xchg   %ax,%ax

00000ad0 <delete_node>:

int delete_node(struct tree_node *node){
 ad0:	55                   	push   %ebp
            node->lockPath = 0;
        }
        // then delete the node
        free(node); 
    }
    return 0;
 ad1:	31 c0                	xor    %eax,%eax
int delete_node(struct tree_node *node){
 ad3:	89 e5                	mov    %esp,%ebp
 ad5:	53                   	push   %ebx
 ad6:	83 ec 04             	sub    $0x4,%esp
 ad9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (node != 0){ 
 adc:	85 db                	test   %ebx,%ebx
 ade:	74 5e                	je     b3e <delete_node+0x6e>
        if(kthread_mutex_dealloc(node->mutex_id) == -1){
 ae0:	83 ec 0c             	sub    $0xc,%esp
 ae3:	ff 73 0c             	pushl  0xc(%ebx)
 ae6:	e8 af f9 ff ff       	call   49a <kthread_mutex_dealloc>
 aeb:	83 c4 10             	add    $0x10,%esp
 aee:	83 f8 ff             	cmp    $0xffffffff,%eax
 af1:	74 4b                	je     b3e <delete_node+0x6e>
        delete_node(node->left_child); 
 af3:	83 ec 0c             	sub    $0xc,%esp
 af6:	ff 33                	pushl  (%ebx)
 af8:	e8 d3 ff ff ff       	call   ad0 <delete_node>
        delete_node(node->right_child); 
 afd:	58                   	pop    %eax
 afe:	ff 73 04             	pushl  0x4(%ebx)
 b01:	e8 ca ff ff ff       	call   ad0 <delete_node>
        if(node->lockPath){
 b06:	8b 43 18             	mov    0x18(%ebx),%eax
 b09:	83 c4 10             	add    $0x10,%esp
        node->left_child = 0;
 b0c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        node->right_child = 0;
 b12:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        if(node->lockPath){
 b19:	85 c0                	test   %eax,%eax
 b1b:	74 13                	je     b30 <delete_node+0x60>
            free(node->lockPath);
 b1d:	83 ec 0c             	sub    $0xc,%esp
 b20:	50                   	push   %eax
 b21:	e8 0a fc ff ff       	call   730 <free>
            node->lockPath = 0;
 b26:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
 b2d:	83 c4 10             	add    $0x10,%esp
        free(node); 
 b30:	83 ec 0c             	sub    $0xc,%esp
 b33:	53                   	push   %ebx
 b34:	e8 f7 fb ff ff       	call   730 <free>
 b39:	83 c4 10             	add    $0x10,%esp
 b3c:	31 c0                	xor    %eax,%eax
}
 b3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 b41:	c9                   	leave  
 b42:	c3                   	ret    
 b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(trnmnt_tree* tree){
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	56                   	push   %esi
 b54:	53                   	push   %ebx
 b55:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(delete_node(tree->root) == 0){
 b58:	83 ec 0c             	sub    $0xc,%esp
 b5b:	ff 33                	pushl  (%ebx)
 b5d:	e8 6e ff ff ff       	call   ad0 <delete_node>
 b62:	83 c4 10             	add    $0x10,%esp
 b65:	85 c0                	test   %eax,%eax
 b67:	75 27                	jne    b90 <trnmnt_tree_dealloc+0x40>
        tree->root = 0;
        free(tree);
 b69:	83 ec 0c             	sub    $0xc,%esp
        tree->root = 0;
 b6c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
 b72:	89 c6                	mov    %eax,%esi
        free(tree);
 b74:	53                   	push   %ebx
 b75:	e8 b6 fb ff ff       	call   730 <free>
        tree = 0;
        return 0;
 b7a:	83 c4 10             	add    $0x10,%esp
    }else{
        return -1;
    }
}
 b7d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 b80:	89 f0                	mov    %esi,%eax
 b82:	5b                   	pop    %ebx
 b83:	5e                   	pop    %esi
 b84:	5d                   	pop    %ebp
 b85:	c3                   	ret    
 b86:	8d 76 00             	lea    0x0(%esi),%esi
 b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
 b90:	be ff ff ff ff       	mov    $0xffffffff,%esi
 b95:	eb e6                	jmp    b7d <trnmnt_tree_dealloc+0x2d>
 b97:	89 f6                	mov    %esi,%esi
 b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ba0 <find_leaf>:
        leaf->lockPath[i] = 0;
    }
    return 0;
}

struct tree_node* find_leaf(struct tree_node* node, int ID){
 ba0:	55                   	push   %ebp
 ba1:	89 e5                	mov    %esp,%ebp
 ba3:	57                   	push   %edi
 ba4:	56                   	push   %esi
 ba5:	53                   	push   %ebx
 ba6:	83 ec 0c             	sub    $0xc,%esp
 ba9:	8b 55 08             	mov    0x8(%ebp),%edx
 bac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if(node->right_child == 0 && node->left_child == 0){ 
 baf:	8b 72 04             	mov    0x4(%edx),%esi
 bb2:	8b 02                	mov    (%edx),%eax
 bb4:	85 f6                	test   %esi,%esi
 bb6:	75 18                	jne    bd0 <find_leaf+0x30>
 bb8:	85 c0                	test   %eax,%eax
 bba:	75 14                	jne    bd0 <find_leaf+0x30>
        if(ID == node->index){
 bbc:	39 5a 10             	cmp    %ebx,0x10(%edx)
 bbf:	0f 44 c2             	cmove  %edx,%eax
        if(leaf1)
            return leaf1;
        else
            return leaf2;
    }
} 
 bc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bc5:	5b                   	pop    %ebx
 bc6:	5e                   	pop    %esi
 bc7:	5f                   	pop    %edi
 bc8:	5d                   	pop    %ebp
 bc9:	c3                   	ret    
 bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 bd0:	83 ec 08             	sub    $0x8,%esp
 bd3:	53                   	push   %ebx
 bd4:	50                   	push   %eax
 bd5:	e8 c6 ff ff ff       	call   ba0 <find_leaf>
 bda:	5a                   	pop    %edx
 bdb:	59                   	pop    %ecx
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 bdc:	53                   	push   %ebx
 bdd:	56                   	push   %esi
        struct tree_node* leaf1 = find_leaf(node->left_child, ID);
 bde:	89 c7                	mov    %eax,%edi
        struct tree_node* leaf2 = find_leaf(node->right_child, ID);
 be0:	e8 bb ff ff ff       	call   ba0 <find_leaf>
 be5:	83 c4 10             	add    $0x10,%esp
        if(leaf1)
 be8:	85 ff                	test   %edi,%edi
 bea:	0f 45 c7             	cmovne %edi,%eax
} 
 bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bf0:	5b                   	pop    %ebx
 bf1:	5e                   	pop    %esi
 bf2:	5f                   	pop    %edi
 bf3:	5d                   	pop    %ebp
 bf4:	c3                   	ret    
 bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <trnmnt_tree_acquire>:
int trnmnt_tree_acquire(trnmnt_tree* tree,int ID){
 c00:	55                   	push   %ebp
 c01:	89 e5                	mov    %esp,%ebp
 c03:	57                   	push   %edi
 c04:	56                   	push   %esi
 c05:	53                   	push   %ebx
 c06:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 c09:	8b 45 08             	mov    0x8(%ebp),%eax
 c0c:	ff 75 0c             	pushl  0xc(%ebp)
 c0f:	ff 30                	pushl  (%eax)
 c11:	e8 8a ff ff ff       	call   ba0 <find_leaf>
 c16:	8b 50 08             	mov    0x8(%eax),%edx
 c19:	83 c4 10             	add    $0x10,%esp
 c1c:	89 c7                	mov    %eax,%edi
    while(curNode->parent){
 c1e:	89 c3                	mov    %eax,%ebx
 c20:	85 d2                	test   %edx,%edx
 c22:	74 32                	je     c56 <trnmnt_tree_acquire+0x56>
        int level = curNode->parent->level;
 c24:	8b 72 14             	mov    0x14(%edx),%esi
        int mutex_lock = kthread_mutex_lock(mutexID);
 c27:	83 ec 0c             	sub    $0xc,%esp
 c2a:	ff 72 0c             	pushl  0xc(%edx)
 c2d:	e8 70 f8 ff ff       	call   4a2 <kthread_mutex_lock>
        leaf->lockPath[level] = curNode->parent->mutex_id;
 c32:	8b 53 08             	mov    0x8(%ebx),%edx
        if(mutex_lock == -1){
 c35:	83 c4 10             	add    $0x10,%esp
 c38:	83 f8 ff             	cmp    $0xffffffff,%eax
        leaf->lockPath[level] = curNode->parent->mutex_id;
 c3b:	8b 4a 0c             	mov    0xc(%edx),%ecx
 c3e:	8b 57 18             	mov    0x18(%edi),%edx
 c41:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
        if(mutex_lock == -1){
 c44:	74 12                	je     c58 <trnmnt_tree_acquire+0x58>
        if(mutex_lock == 0){
 c46:	85 c0                	test   %eax,%eax
 c48:	8b 53 08             	mov    0x8(%ebx),%edx
 c4b:	75 d3                	jne    c20 <trnmnt_tree_acquire+0x20>
 c4d:	89 d3                	mov    %edx,%ebx
 c4f:	8b 52 08             	mov    0x8(%edx),%edx
    while(curNode->parent){
 c52:	85 d2                	test   %edx,%edx
 c54:	75 ce                	jne    c24 <trnmnt_tree_acquire+0x24>
    return 0;
 c56:	31 c0                	xor    %eax,%eax
}
 c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c5b:	5b                   	pop    %ebx
 c5c:	5e                   	pop    %esi
 c5d:	5f                   	pop    %edi
 c5e:	5d                   	pop    %ebp
 c5f:	c3                   	ret    

00000c60 <trnmnt_tree_release>:
int trnmnt_tree_release(trnmnt_tree* tree,int ID){
 c60:	55                   	push   %ebp
 c61:	89 e5                	mov    %esp,%ebp
 c63:	57                   	push   %edi
 c64:	56                   	push   %esi
 c65:	53                   	push   %ebx
 c66:	83 ec 14             	sub    $0x14,%esp
    struct tree_node* leaf = find_leaf(tree->root, ID);
 c69:	8b 45 08             	mov    0x8(%ebp),%eax
 c6c:	ff 75 0c             	pushl  0xc(%ebp)
 c6f:	ff 30                	pushl  (%eax)
 c71:	e8 2a ff ff ff       	call   ba0 <find_leaf>
    for(int i = treeDepth-1; i >= 0; i--){
 c76:	8b 35 d0 11 00 00    	mov    0x11d0,%esi
    struct tree_node* leaf = find_leaf(tree->root, ID);
 c7c:	83 c4 10             	add    $0x10,%esp
    for(int i = treeDepth-1; i >= 0; i--){
 c7f:	83 ee 01             	sub    $0x1,%esi
 c82:	78 44                	js     cc8 <trnmnt_tree_release+0x68>
 c84:	89 c7                	mov    %eax,%edi
 c86:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
 c8d:	eb 16                	jmp    ca5 <trnmnt_tree_release+0x45>
 c8f:	90                   	nop
        leaf->lockPath[i] = 0;
 c90:	8b 47 18             	mov    0x18(%edi),%eax
    for(int i = treeDepth-1; i >= 0; i--){
 c93:	83 ee 01             	sub    $0x1,%esi
        leaf->lockPath[i] = 0;
 c96:	c7 04 18 00 00 00 00 	movl   $0x0,(%eax,%ebx,1)
 c9d:	83 eb 04             	sub    $0x4,%ebx
    for(int i = treeDepth-1; i >= 0; i--){
 ca0:	83 fe ff             	cmp    $0xffffffff,%esi
 ca3:	74 23                	je     cc8 <trnmnt_tree_release+0x68>
        int res = kthread_mutex_unlock(leaf->lockPath[i]);
 ca5:	8b 47 18             	mov    0x18(%edi),%eax
 ca8:	83 ec 0c             	sub    $0xc,%esp
 cab:	ff 34 18             	pushl  (%eax,%ebx,1)
 cae:	e8 f7 f7 ff ff       	call   4aa <kthread_mutex_unlock>
        if(res == -1){
 cb3:	83 c4 10             	add    $0x10,%esp
 cb6:	83 f8 ff             	cmp    $0xffffffff,%eax
 cb9:	75 d5                	jne    c90 <trnmnt_tree_release+0x30>
}
 cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 cbe:	5b                   	pop    %ebx
 cbf:	5e                   	pop    %esi
 cc0:	5f                   	pop    %edi
 cc1:	5d                   	pop    %ebp
 cc2:	c3                   	ret    
 cc3:	90                   	nop
 cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 cc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 ccb:	31 c0                	xor    %eax,%eax
}
 ccd:	5b                   	pop    %ebx
 cce:	5e                   	pop    %esi
 ccf:	5f                   	pop    %edi
 cd0:	5d                   	pop    %ebp
 cd1:	c3                   	ret    
