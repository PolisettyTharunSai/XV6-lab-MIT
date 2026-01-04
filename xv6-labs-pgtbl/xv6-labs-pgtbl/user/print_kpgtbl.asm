
user/_print_kpgtbl:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  kpgtbl();
   8:	380000ef          	jal	388 <kpgtbl>
  exit(0);
   c:	4501                	li	a0,0
   e:	2ae000ef          	jal	2bc <exit>

0000000000000012 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  12:	1141                	addi	sp,sp,-16
  14:	e406                	sd	ra,8(sp)
  16:	e022                	sd	s0,0(sp)
  18:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  1a:	fe7ff0ef          	jal	0 <main>
  exit(r);
  1e:	29e000ef          	jal	2bc <exit>

0000000000000022 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  22:	1141                	addi	sp,sp,-16
  24:	e422                	sd	s0,8(sp)
  26:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  28:	87aa                	mv	a5,a0
  2a:	0585                	addi	a1,a1,1
  2c:	0785                	addi	a5,a5,1
  2e:	fff5c703          	lbu	a4,-1(a1)
  32:	fee78fa3          	sb	a4,-1(a5)
  36:	fb75                	bnez	a4,2a <strcpy+0x8>
    ;
  return os;
}
  38:	6422                	ld	s0,8(sp)
  3a:	0141                	addi	sp,sp,16
  3c:	8082                	ret

000000000000003e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  3e:	1141                	addi	sp,sp,-16
  40:	e422                	sd	s0,8(sp)
  42:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  44:	00054783          	lbu	a5,0(a0)
  48:	cb91                	beqz	a5,5c <strcmp+0x1e>
  4a:	0005c703          	lbu	a4,0(a1)
  4e:	00f71763          	bne	a4,a5,5c <strcmp+0x1e>
    p++, q++;
  52:	0505                	addi	a0,a0,1
  54:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  56:	00054783          	lbu	a5,0(a0)
  5a:	fbe5                	bnez	a5,4a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  5c:	0005c503          	lbu	a0,0(a1)
}
  60:	40a7853b          	subw	a0,a5,a0
  64:	6422                	ld	s0,8(sp)
  66:	0141                	addi	sp,sp,16
  68:	8082                	ret

000000000000006a <strlen>:

uint
strlen(const char *s)
{
  6a:	1141                	addi	sp,sp,-16
  6c:	e422                	sd	s0,8(sp)
  6e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  70:	00054783          	lbu	a5,0(a0)
  74:	cf91                	beqz	a5,90 <strlen+0x26>
  76:	0505                	addi	a0,a0,1
  78:	87aa                	mv	a5,a0
  7a:	86be                	mv	a3,a5
  7c:	0785                	addi	a5,a5,1
  7e:	fff7c703          	lbu	a4,-1(a5)
  82:	ff65                	bnez	a4,7a <strlen+0x10>
  84:	40a6853b          	subw	a0,a3,a0
  88:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  8a:	6422                	ld	s0,8(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
  for(n = 0; s[n]; n++)
  90:	4501                	li	a0,0
  92:	bfe5                	j	8a <strlen+0x20>

0000000000000094 <memset>:

void*
memset(void *dst, int c, uint n)
{
  94:	1141                	addi	sp,sp,-16
  96:	e422                	sd	s0,8(sp)
  98:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  9a:	ca19                	beqz	a2,b0 <memset+0x1c>
  9c:	87aa                	mv	a5,a0
  9e:	1602                	slli	a2,a2,0x20
  a0:	9201                	srli	a2,a2,0x20
  a2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  aa:	0785                	addi	a5,a5,1
  ac:	fee79de3          	bne	a5,a4,a6 <memset+0x12>
  }
  return dst;
}
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strchr>:

char*
strchr(const char *s, char c)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cb99                	beqz	a5,d6 <strchr+0x20>
    if(*s == c)
  c2:	00f58763          	beq	a1,a5,d0 <strchr+0x1a>
  for(; *s; s++)
  c6:	0505                	addi	a0,a0,1
  c8:	00054783          	lbu	a5,0(a0)
  cc:	fbfd                	bnez	a5,c2 <strchr+0xc>
      return (char*)s;
  return 0;
  ce:	4501                	li	a0,0
}
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	addi	sp,sp,16
  d4:	8082                	ret
  return 0;
  d6:	4501                	li	a0,0
  d8:	bfe5                	j	d0 <strchr+0x1a>

00000000000000da <gets>:

char*
gets(char *buf, int max)
{
  da:	711d                	addi	sp,sp,-96
  dc:	ec86                	sd	ra,88(sp)
  de:	e8a2                	sd	s0,80(sp)
  e0:	e4a6                	sd	s1,72(sp)
  e2:	e0ca                	sd	s2,64(sp)
  e4:	fc4e                	sd	s3,56(sp)
  e6:	f852                	sd	s4,48(sp)
  e8:	f456                	sd	s5,40(sp)
  ea:	f05a                	sd	s6,32(sp)
  ec:	ec5e                	sd	s7,24(sp)
  ee:	1080                	addi	s0,sp,96
  f0:	8baa                	mv	s7,a0
  f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f4:	892a                	mv	s2,a0
  f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
  f8:	4aa9                	li	s5,10
  fa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
  fc:	89a6                	mv	s3,s1
  fe:	2485                	addiw	s1,s1,1
 100:	0344d663          	bge	s1,s4,12c <gets+0x52>
    cc = read(0, &c, 1);
 104:	4605                	li	a2,1
 106:	faf40593          	addi	a1,s0,-81
 10a:	4501                	li	a0,0
 10c:	1c8000ef          	jal	2d4 <read>
    if(cc < 1)
 110:	00a05e63          	blez	a0,12c <gets+0x52>
    buf[i++] = c;
 114:	faf44783          	lbu	a5,-81(s0)
 118:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 11c:	01578763          	beq	a5,s5,12a <gets+0x50>
 120:	0905                	addi	s2,s2,1
 122:	fd679de3          	bne	a5,s6,fc <gets+0x22>
    buf[i++] = c;
 126:	89a6                	mv	s3,s1
 128:	a011                	j	12c <gets+0x52>
 12a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 12c:	99de                	add	s3,s3,s7
 12e:	00098023          	sb	zero,0(s3)
  return buf;
}
 132:	855e                	mv	a0,s7
 134:	60e6                	ld	ra,88(sp)
 136:	6446                	ld	s0,80(sp)
 138:	64a6                	ld	s1,72(sp)
 13a:	6906                	ld	s2,64(sp)
 13c:	79e2                	ld	s3,56(sp)
 13e:	7a42                	ld	s4,48(sp)
 140:	7aa2                	ld	s5,40(sp)
 142:	7b02                	ld	s6,32(sp)
 144:	6be2                	ld	s7,24(sp)
 146:	6125                	addi	sp,sp,96
 148:	8082                	ret

000000000000014a <stat>:

int
stat(const char *n, struct stat *st)
{
 14a:	1101                	addi	sp,sp,-32
 14c:	ec06                	sd	ra,24(sp)
 14e:	e822                	sd	s0,16(sp)
 150:	e04a                	sd	s2,0(sp)
 152:	1000                	addi	s0,sp,32
 154:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 156:	4581                	li	a1,0
 158:	1a4000ef          	jal	2fc <open>
  if(fd < 0)
 15c:	02054263          	bltz	a0,180 <stat+0x36>
 160:	e426                	sd	s1,8(sp)
 162:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 164:	85ca                	mv	a1,s2
 166:	1ae000ef          	jal	314 <fstat>
 16a:	892a                	mv	s2,a0
  close(fd);
 16c:	8526                	mv	a0,s1
 16e:	176000ef          	jal	2e4 <close>
  return r;
 172:	64a2                	ld	s1,8(sp)
}
 174:	854a                	mv	a0,s2
 176:	60e2                	ld	ra,24(sp)
 178:	6442                	ld	s0,16(sp)
 17a:	6902                	ld	s2,0(sp)
 17c:	6105                	addi	sp,sp,32
 17e:	8082                	ret
    return -1;
 180:	597d                	li	s2,-1
 182:	bfcd                	j	174 <stat+0x2a>

0000000000000184 <atoi>:

int
atoi(const char *s)
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 18a:	00054683          	lbu	a3,0(a0)
 18e:	fd06879b          	addiw	a5,a3,-48
 192:	0ff7f793          	zext.b	a5,a5
 196:	4625                	li	a2,9
 198:	02f66863          	bltu	a2,a5,1c8 <atoi+0x44>
 19c:	872a                	mv	a4,a0
  n = 0;
 19e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1a0:	0705                	addi	a4,a4,1
 1a2:	0025179b          	slliw	a5,a0,0x2
 1a6:	9fa9                	addw	a5,a5,a0
 1a8:	0017979b          	slliw	a5,a5,0x1
 1ac:	9fb5                	addw	a5,a5,a3
 1ae:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1b2:	00074683          	lbu	a3,0(a4)
 1b6:	fd06879b          	addiw	a5,a3,-48
 1ba:	0ff7f793          	zext.b	a5,a5
 1be:	fef671e3          	bgeu	a2,a5,1a0 <atoi+0x1c>
  return n;
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret
  n = 0;
 1c8:	4501                	li	a0,0
 1ca:	bfe5                	j	1c2 <atoi+0x3e>

00000000000001cc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1d2:	02b57463          	bgeu	a0,a1,1fa <memmove+0x2e>
    while(n-- > 0)
 1d6:	00c05f63          	blez	a2,1f4 <memmove+0x28>
 1da:	1602                	slli	a2,a2,0x20
 1dc:	9201                	srli	a2,a2,0x20
 1de:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1e2:	872a                	mv	a4,a0
      *dst++ = *src++;
 1e4:	0585                	addi	a1,a1,1
 1e6:	0705                	addi	a4,a4,1
 1e8:	fff5c683          	lbu	a3,-1(a1)
 1ec:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1f0:	fef71ae3          	bne	a4,a5,1e4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret
    dst += n;
 1fa:	00c50733          	add	a4,a0,a2
    src += n;
 1fe:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 200:	fec05ae3          	blez	a2,1f4 <memmove+0x28>
 204:	fff6079b          	addiw	a5,a2,-1
 208:	1782                	slli	a5,a5,0x20
 20a:	9381                	srli	a5,a5,0x20
 20c:	fff7c793          	not	a5,a5
 210:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 212:	15fd                	addi	a1,a1,-1
 214:	177d                	addi	a4,a4,-1
 216:	0005c683          	lbu	a3,0(a1)
 21a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 21e:	fee79ae3          	bne	a5,a4,212 <memmove+0x46>
 222:	bfc9                	j	1f4 <memmove+0x28>

0000000000000224 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 224:	1141                	addi	sp,sp,-16
 226:	e422                	sd	s0,8(sp)
 228:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 22a:	ca05                	beqz	a2,25a <memcmp+0x36>
 22c:	fff6069b          	addiw	a3,a2,-1
 230:	1682                	slli	a3,a3,0x20
 232:	9281                	srli	a3,a3,0x20
 234:	0685                	addi	a3,a3,1
 236:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 238:	00054783          	lbu	a5,0(a0)
 23c:	0005c703          	lbu	a4,0(a1)
 240:	00e79863          	bne	a5,a4,250 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 244:	0505                	addi	a0,a0,1
    p2++;
 246:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 248:	fed518e3          	bne	a0,a3,238 <memcmp+0x14>
  }
  return 0;
 24c:	4501                	li	a0,0
 24e:	a019                	j	254 <memcmp+0x30>
      return *p1 - *p2;
 250:	40e7853b          	subw	a0,a5,a4
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
  return 0;
 25a:	4501                	li	a0,0
 25c:	bfe5                	j	254 <memcmp+0x30>

000000000000025e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e406                	sd	ra,8(sp)
 262:	e022                	sd	s0,0(sp)
 264:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 266:	f67ff0ef          	jal	1cc <memmove>
}
 26a:	60a2                	ld	ra,8(sp)
 26c:	6402                	ld	s0,0(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret

0000000000000272 <sbrk>:

char *
sbrk(int n) {
 272:	1141                	addi	sp,sp,-16
 274:	e406                	sd	ra,8(sp)
 276:	e022                	sd	s0,0(sp)
 278:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 27a:	4585                	li	a1,1
 27c:	0c8000ef          	jal	344 <sys_sbrk>
}
 280:	60a2                	ld	ra,8(sp)
 282:	6402                	ld	s0,0(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <sbrklazy>:

char *
sbrklazy(int n) {
 288:	1141                	addi	sp,sp,-16
 28a:	e406                	sd	ra,8(sp)
 28c:	e022                	sd	s0,0(sp)
 28e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 290:	4589                	li	a1,2
 292:	0b2000ef          	jal	344 <sys_sbrk>
}
 296:	60a2                	ld	ra,8(sp)
 298:	6402                	ld	s0,0(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret

000000000000029e <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2a4:	040007b7          	lui	a5,0x4000
 2a8:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 2aa:	07b2                	slli	a5,a5,0xc
}
 2ac:	4388                	lw	a0,0(a5)
 2ae:	6422                	ld	s0,8(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2b4:	4885                	li	a7,1
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 2bc:	4889                	li	a7,2
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2c4:	488d                	li	a7,3
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2cc:	4891                	li	a7,4
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <read>:
.global read
read:
 li a7, SYS_read
 2d4:	4895                	li	a7,5
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <write>:
.global write
write:
 li a7, SYS_write
 2dc:	48c1                	li	a7,16
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <close>:
.global close
close:
 li a7, SYS_close
 2e4:	48d5                	li	a7,21
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 2ec:	4899                	li	a7,6
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2f4:	489d                	li	a7,7
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <open>:
.global open
open:
 li a7, SYS_open
 2fc:	48bd                	li	a7,15
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 304:	48c5                	li	a7,17
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 30c:	48c9                	li	a7,18
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 314:	48a1                	li	a7,8
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <link>:
.global link
link:
 li a7, SYS_link
 31c:	48cd                	li	a7,19
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 324:	48d1                	li	a7,20
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 32c:	48a5                	li	a7,9
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <dup>:
.global dup
dup:
 li a7, SYS_dup
 334:	48a9                	li	a7,10
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 33c:	48ad                	li	a7,11
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 344:	48b1                	li	a7,12
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <pause>:
.global pause
pause:
 li a7, SYS_pause
 34c:	48b5                	li	a7,13
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 354:	48b9                	li	a7,14
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <bind>:
.global bind
bind:
 li a7, SYS_bind
 35c:	48f5                	li	a7,29
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 364:	48f9                	li	a7,30
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <send>:
.global send
send:
 li a7, SYS_send
 36c:	48fd                	li	a7,31
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <recv>:
.global recv
recv:
 li a7, SYS_recv
 374:	02000893          	li	a7,32
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 37e:	02100893          	li	a7,33
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 388:	02200893          	li	a7,34
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <prac>:
.global prac
prac:
 li a7, SYS_prac
 392:	02300893          	li	a7,35
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 39c:	1101                	addi	sp,sp,-32
 39e:	ec06                	sd	ra,24(sp)
 3a0:	e822                	sd	s0,16(sp)
 3a2:	1000                	addi	s0,sp,32
 3a4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a8:	4605                	li	a2,1
 3aa:	fef40593          	addi	a1,s0,-17
 3ae:	f2fff0ef          	jal	2dc <write>
}
 3b2:	60e2                	ld	ra,24(sp)
 3b4:	6442                	ld	s0,16(sp)
 3b6:	6105                	addi	sp,sp,32
 3b8:	8082                	ret

00000000000003ba <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3ba:	715d                	addi	sp,sp,-80
 3bc:	e486                	sd	ra,72(sp)
 3be:	e0a2                	sd	s0,64(sp)
 3c0:	f84a                	sd	s2,48(sp)
 3c2:	0880                	addi	s0,sp,80
 3c4:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 3c6:	c299                	beqz	a3,3cc <printint+0x12>
 3c8:	0805c363          	bltz	a1,44e <printint+0x94>
  neg = 0;
 3cc:	4881                	li	a7,0
 3ce:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3d2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3d4:	00000517          	auipc	a0,0x0
 3d8:	50450513          	addi	a0,a0,1284 # 8d8 <digits>
 3dc:	883e                	mv	a6,a5
 3de:	2785                	addiw	a5,a5,1
 3e0:	02c5f733          	remu	a4,a1,a2
 3e4:	972a                	add	a4,a4,a0
 3e6:	00074703          	lbu	a4,0(a4)
 3ea:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3ee:	872e                	mv	a4,a1
 3f0:	02c5d5b3          	divu	a1,a1,a2
 3f4:	0685                	addi	a3,a3,1
 3f6:	fec773e3          	bgeu	a4,a2,3dc <printint+0x22>
  if(neg)
 3fa:	00088b63          	beqz	a7,410 <printint+0x56>
    buf[i++] = '-';
 3fe:	fd078793          	addi	a5,a5,-48
 402:	97a2                	add	a5,a5,s0
 404:	02d00713          	li	a4,45
 408:	fee78423          	sb	a4,-24(a5)
 40c:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 410:	02f05a63          	blez	a5,444 <printint+0x8a>
 414:	fc26                	sd	s1,56(sp)
 416:	f44e                	sd	s3,40(sp)
 418:	fb840713          	addi	a4,s0,-72
 41c:	00f704b3          	add	s1,a4,a5
 420:	fff70993          	addi	s3,a4,-1
 424:	99be                	add	s3,s3,a5
 426:	37fd                	addiw	a5,a5,-1
 428:	1782                	slli	a5,a5,0x20
 42a:	9381                	srli	a5,a5,0x20
 42c:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 430:	fff4c583          	lbu	a1,-1(s1)
 434:	854a                	mv	a0,s2
 436:	f67ff0ef          	jal	39c <putc>
  while(--i >= 0)
 43a:	14fd                	addi	s1,s1,-1
 43c:	ff349ae3          	bne	s1,s3,430 <printint+0x76>
 440:	74e2                	ld	s1,56(sp)
 442:	79a2                	ld	s3,40(sp)
}
 444:	60a6                	ld	ra,72(sp)
 446:	6406                	ld	s0,64(sp)
 448:	7942                	ld	s2,48(sp)
 44a:	6161                	addi	sp,sp,80
 44c:	8082                	ret
    x = -xx;
 44e:	40b005b3          	neg	a1,a1
    neg = 1;
 452:	4885                	li	a7,1
    x = -xx;
 454:	bfad                	j	3ce <printint+0x14>

0000000000000456 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 456:	711d                	addi	sp,sp,-96
 458:	ec86                	sd	ra,88(sp)
 45a:	e8a2                	sd	s0,80(sp)
 45c:	e0ca                	sd	s2,64(sp)
 45e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 460:	0005c903          	lbu	s2,0(a1)
 464:	28090663          	beqz	s2,6f0 <vprintf+0x29a>
 468:	e4a6                	sd	s1,72(sp)
 46a:	fc4e                	sd	s3,56(sp)
 46c:	f852                	sd	s4,48(sp)
 46e:	f456                	sd	s5,40(sp)
 470:	f05a                	sd	s6,32(sp)
 472:	ec5e                	sd	s7,24(sp)
 474:	e862                	sd	s8,16(sp)
 476:	e466                	sd	s9,8(sp)
 478:	8b2a                	mv	s6,a0
 47a:	8a2e                	mv	s4,a1
 47c:	8bb2                	mv	s7,a2
  state = 0;
 47e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 480:	4481                	li	s1,0
 482:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 484:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 488:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 48c:	06c00c93          	li	s9,108
 490:	a005                	j	4b0 <vprintf+0x5a>
        putc(fd, c0);
 492:	85ca                	mv	a1,s2
 494:	855a                	mv	a0,s6
 496:	f07ff0ef          	jal	39c <putc>
 49a:	a019                	j	4a0 <vprintf+0x4a>
    } else if(state == '%'){
 49c:	03598263          	beq	s3,s5,4c0 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 4a0:	2485                	addiw	s1,s1,1
 4a2:	8726                	mv	a4,s1
 4a4:	009a07b3          	add	a5,s4,s1
 4a8:	0007c903          	lbu	s2,0(a5)
 4ac:	22090a63          	beqz	s2,6e0 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 4b0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4b4:	fe0994e3          	bnez	s3,49c <vprintf+0x46>
      if(c0 == '%'){
 4b8:	fd579de3          	bne	a5,s5,492 <vprintf+0x3c>
        state = '%';
 4bc:	89be                	mv	s3,a5
 4be:	b7cd                	j	4a0 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4c0:	00ea06b3          	add	a3,s4,a4
 4c4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4c8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4ca:	c681                	beqz	a3,4d2 <vprintf+0x7c>
 4cc:	9752                	add	a4,a4,s4
 4ce:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4d2:	05878363          	beq	a5,s8,518 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 4d6:	05978d63          	beq	a5,s9,530 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4da:	07500713          	li	a4,117
 4de:	0ee78763          	beq	a5,a4,5cc <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4e2:	07800713          	li	a4,120
 4e6:	12e78963          	beq	a5,a4,618 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4ea:	07000713          	li	a4,112
 4ee:	14e78e63          	beq	a5,a4,64a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 4f2:	06300713          	li	a4,99
 4f6:	18e78e63          	beq	a5,a4,692 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 4fa:	07300713          	li	a4,115
 4fe:	1ae78463          	beq	a5,a4,6a6 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 502:	02500713          	li	a4,37
 506:	04e79563          	bne	a5,a4,550 <vprintf+0xfa>
        putc(fd, '%');
 50a:	02500593          	li	a1,37
 50e:	855a                	mv	a0,s6
 510:	e8dff0ef          	jal	39c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 514:	4981                	li	s3,0
 516:	b769                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 518:	008b8913          	addi	s2,s7,8
 51c:	4685                	li	a3,1
 51e:	4629                	li	a2,10
 520:	000ba583          	lw	a1,0(s7)
 524:	855a                	mv	a0,s6
 526:	e95ff0ef          	jal	3ba <printint>
 52a:	8bca                	mv	s7,s2
      state = 0;
 52c:	4981                	li	s3,0
 52e:	bf8d                	j	4a0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 530:	06400793          	li	a5,100
 534:	02f68963          	beq	a3,a5,566 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 538:	06c00793          	li	a5,108
 53c:	04f68263          	beq	a3,a5,580 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 540:	07500793          	li	a5,117
 544:	0af68063          	beq	a3,a5,5e4 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 548:	07800793          	li	a5,120
 54c:	0ef68263          	beq	a3,a5,630 <vprintf+0x1da>
        putc(fd, '%');
 550:	02500593          	li	a1,37
 554:	855a                	mv	a0,s6
 556:	e47ff0ef          	jal	39c <putc>
        putc(fd, c0);
 55a:	85ca                	mv	a1,s2
 55c:	855a                	mv	a0,s6
 55e:	e3fff0ef          	jal	39c <putc>
      state = 0;
 562:	4981                	li	s3,0
 564:	bf35                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 566:	008b8913          	addi	s2,s7,8
 56a:	4685                	li	a3,1
 56c:	4629                	li	a2,10
 56e:	000bb583          	ld	a1,0(s7)
 572:	855a                	mv	a0,s6
 574:	e47ff0ef          	jal	3ba <printint>
        i += 1;
 578:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 57a:	8bca                	mv	s7,s2
      state = 0;
 57c:	4981                	li	s3,0
        i += 1;
 57e:	b70d                	j	4a0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 580:	06400793          	li	a5,100
 584:	02f60763          	beq	a2,a5,5b2 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 588:	07500793          	li	a5,117
 58c:	06f60963          	beq	a2,a5,5fe <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 590:	07800793          	li	a5,120
 594:	faf61ee3          	bne	a2,a5,550 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 598:	008b8913          	addi	s2,s7,8
 59c:	4681                	li	a3,0
 59e:	4641                	li	a2,16
 5a0:	000bb583          	ld	a1,0(s7)
 5a4:	855a                	mv	a0,s6
 5a6:	e15ff0ef          	jal	3ba <printint>
        i += 2;
 5aa:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ac:	8bca                	mv	s7,s2
      state = 0;
 5ae:	4981                	li	s3,0
        i += 2;
 5b0:	bdc5                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5b2:	008b8913          	addi	s2,s7,8
 5b6:	4685                	li	a3,1
 5b8:	4629                	li	a2,10
 5ba:	000bb583          	ld	a1,0(s7)
 5be:	855a                	mv	a0,s6
 5c0:	dfbff0ef          	jal	3ba <printint>
        i += 2;
 5c4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c6:	8bca                	mv	s7,s2
      state = 0;
 5c8:	4981                	li	s3,0
        i += 2;
 5ca:	bdd9                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	4681                	li	a3,0
 5d2:	4629                	li	a2,10
 5d4:	000be583          	lwu	a1,0(s7)
 5d8:	855a                	mv	a0,s6
 5da:	de1ff0ef          	jal	3ba <printint>
 5de:	8bca                	mv	s7,s2
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	bd7d                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e4:	008b8913          	addi	s2,s7,8
 5e8:	4681                	li	a3,0
 5ea:	4629                	li	a2,10
 5ec:	000bb583          	ld	a1,0(s7)
 5f0:	855a                	mv	a0,s6
 5f2:	dc9ff0ef          	jal	3ba <printint>
        i += 1;
 5f6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f8:	8bca                	mv	s7,s2
      state = 0;
 5fa:	4981                	li	s3,0
        i += 1;
 5fc:	b555                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5fe:	008b8913          	addi	s2,s7,8
 602:	4681                	li	a3,0
 604:	4629                	li	a2,10
 606:	000bb583          	ld	a1,0(s7)
 60a:	855a                	mv	a0,s6
 60c:	dafff0ef          	jal	3ba <printint>
        i += 2;
 610:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 612:	8bca                	mv	s7,s2
      state = 0;
 614:	4981                	li	s3,0
        i += 2;
 616:	b569                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 618:	008b8913          	addi	s2,s7,8
 61c:	4681                	li	a3,0
 61e:	4641                	li	a2,16
 620:	000be583          	lwu	a1,0(s7)
 624:	855a                	mv	a0,s6
 626:	d95ff0ef          	jal	3ba <printint>
 62a:	8bca                	mv	s7,s2
      state = 0;
 62c:	4981                	li	s3,0
 62e:	bd8d                	j	4a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 630:	008b8913          	addi	s2,s7,8
 634:	4681                	li	a3,0
 636:	4641                	li	a2,16
 638:	000bb583          	ld	a1,0(s7)
 63c:	855a                	mv	a0,s6
 63e:	d7dff0ef          	jal	3ba <printint>
        i += 1;
 642:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 644:	8bca                	mv	s7,s2
      state = 0;
 646:	4981                	li	s3,0
        i += 1;
 648:	bda1                	j	4a0 <vprintf+0x4a>
 64a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 64c:	008b8d13          	addi	s10,s7,8
 650:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 654:	03000593          	li	a1,48
 658:	855a                	mv	a0,s6
 65a:	d43ff0ef          	jal	39c <putc>
  putc(fd, 'x');
 65e:	07800593          	li	a1,120
 662:	855a                	mv	a0,s6
 664:	d39ff0ef          	jal	39c <putc>
 668:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 66a:	00000b97          	auipc	s7,0x0
 66e:	26eb8b93          	addi	s7,s7,622 # 8d8 <digits>
 672:	03c9d793          	srli	a5,s3,0x3c
 676:	97de                	add	a5,a5,s7
 678:	0007c583          	lbu	a1,0(a5)
 67c:	855a                	mv	a0,s6
 67e:	d1fff0ef          	jal	39c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 682:	0992                	slli	s3,s3,0x4
 684:	397d                	addiw	s2,s2,-1
 686:	fe0916e3          	bnez	s2,672 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 68a:	8bea                	mv	s7,s10
      state = 0;
 68c:	4981                	li	s3,0
 68e:	6d02                	ld	s10,0(sp)
 690:	bd01                	j	4a0 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 692:	008b8913          	addi	s2,s7,8
 696:	000bc583          	lbu	a1,0(s7)
 69a:	855a                	mv	a0,s6
 69c:	d01ff0ef          	jal	39c <putc>
 6a0:	8bca                	mv	s7,s2
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	bbf5                	j	4a0 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6a6:	008b8993          	addi	s3,s7,8
 6aa:	000bb903          	ld	s2,0(s7)
 6ae:	00090f63          	beqz	s2,6cc <vprintf+0x276>
        for(; *s; s++)
 6b2:	00094583          	lbu	a1,0(s2)
 6b6:	c195                	beqz	a1,6da <vprintf+0x284>
          putc(fd, *s);
 6b8:	855a                	mv	a0,s6
 6ba:	ce3ff0ef          	jal	39c <putc>
        for(; *s; s++)
 6be:	0905                	addi	s2,s2,1
 6c0:	00094583          	lbu	a1,0(s2)
 6c4:	f9f5                	bnez	a1,6b8 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 6c6:	8bce                	mv	s7,s3
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	bbd9                	j	4a0 <vprintf+0x4a>
          s = "(null)";
 6cc:	00000917          	auipc	s2,0x0
 6d0:	20490913          	addi	s2,s2,516 # 8d0 <malloc+0xf8>
        for(; *s; s++)
 6d4:	02800593          	li	a1,40
 6d8:	b7c5                	j	6b8 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 6da:	8bce                	mv	s7,s3
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	b3c9                	j	4a0 <vprintf+0x4a>
 6e0:	64a6                	ld	s1,72(sp)
 6e2:	79e2                	ld	s3,56(sp)
 6e4:	7a42                	ld	s4,48(sp)
 6e6:	7aa2                	ld	s5,40(sp)
 6e8:	7b02                	ld	s6,32(sp)
 6ea:	6be2                	ld	s7,24(sp)
 6ec:	6c42                	ld	s8,16(sp)
 6ee:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6f0:	60e6                	ld	ra,88(sp)
 6f2:	6446                	ld	s0,80(sp)
 6f4:	6906                	ld	s2,64(sp)
 6f6:	6125                	addi	sp,sp,96
 6f8:	8082                	ret

00000000000006fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6fa:	715d                	addi	sp,sp,-80
 6fc:	ec06                	sd	ra,24(sp)
 6fe:	e822                	sd	s0,16(sp)
 700:	1000                	addi	s0,sp,32
 702:	e010                	sd	a2,0(s0)
 704:	e414                	sd	a3,8(s0)
 706:	e818                	sd	a4,16(s0)
 708:	ec1c                	sd	a5,24(s0)
 70a:	03043023          	sd	a6,32(s0)
 70e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 712:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 716:	8622                	mv	a2,s0
 718:	d3fff0ef          	jal	456 <vprintf>
}
 71c:	60e2                	ld	ra,24(sp)
 71e:	6442                	ld	s0,16(sp)
 720:	6161                	addi	sp,sp,80
 722:	8082                	ret

0000000000000724 <printf>:

void
printf(const char *fmt, ...)
{
 724:	711d                	addi	sp,sp,-96
 726:	ec06                	sd	ra,24(sp)
 728:	e822                	sd	s0,16(sp)
 72a:	1000                	addi	s0,sp,32
 72c:	e40c                	sd	a1,8(s0)
 72e:	e810                	sd	a2,16(s0)
 730:	ec14                	sd	a3,24(s0)
 732:	f018                	sd	a4,32(s0)
 734:	f41c                	sd	a5,40(s0)
 736:	03043823          	sd	a6,48(s0)
 73a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 73e:	00840613          	addi	a2,s0,8
 742:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 746:	85aa                	mv	a1,a0
 748:	4505                	li	a0,1
 74a:	d0dff0ef          	jal	456 <vprintf>
}
 74e:	60e2                	ld	ra,24(sp)
 750:	6442                	ld	s0,16(sp)
 752:	6125                	addi	sp,sp,96
 754:	8082                	ret

0000000000000756 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 756:	1141                	addi	sp,sp,-16
 758:	e422                	sd	s0,8(sp)
 75a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 75c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 760:	00001797          	auipc	a5,0x1
 764:	8a07b783          	ld	a5,-1888(a5) # 1000 <freep>
 768:	a02d                	j	792 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 76a:	4618                	lw	a4,8(a2)
 76c:	9f2d                	addw	a4,a4,a1
 76e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 772:	6398                	ld	a4,0(a5)
 774:	6310                	ld	a2,0(a4)
 776:	a83d                	j	7b4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 778:	ff852703          	lw	a4,-8(a0)
 77c:	9f31                	addw	a4,a4,a2
 77e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 780:	ff053683          	ld	a3,-16(a0)
 784:	a091                	j	7c8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 786:	6398                	ld	a4,0(a5)
 788:	00e7e463          	bltu	a5,a4,790 <free+0x3a>
 78c:	00e6ea63          	bltu	a3,a4,7a0 <free+0x4a>
{
 790:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 792:	fed7fae3          	bgeu	a5,a3,786 <free+0x30>
 796:	6398                	ld	a4,0(a5)
 798:	00e6e463          	bltu	a3,a4,7a0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79c:	fee7eae3          	bltu	a5,a4,790 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7a0:	ff852583          	lw	a1,-8(a0)
 7a4:	6390                	ld	a2,0(a5)
 7a6:	02059813          	slli	a6,a1,0x20
 7aa:	01c85713          	srli	a4,a6,0x1c
 7ae:	9736                	add	a4,a4,a3
 7b0:	fae60de3          	beq	a2,a4,76a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7b4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b8:	4790                	lw	a2,8(a5)
 7ba:	02061593          	slli	a1,a2,0x20
 7be:	01c5d713          	srli	a4,a1,0x1c
 7c2:	973e                	add	a4,a4,a5
 7c4:	fae68ae3          	beq	a3,a4,778 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7c8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7ca:	00001717          	auipc	a4,0x1
 7ce:	82f73b23          	sd	a5,-1994(a4) # 1000 <freep>
}
 7d2:	6422                	ld	s0,8(sp)
 7d4:	0141                	addi	sp,sp,16
 7d6:	8082                	ret

00000000000007d8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d8:	7139                	addi	sp,sp,-64
 7da:	fc06                	sd	ra,56(sp)
 7dc:	f822                	sd	s0,48(sp)
 7de:	f426                	sd	s1,40(sp)
 7e0:	ec4e                	sd	s3,24(sp)
 7e2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e4:	02051493          	slli	s1,a0,0x20
 7e8:	9081                	srli	s1,s1,0x20
 7ea:	04bd                	addi	s1,s1,15
 7ec:	8091                	srli	s1,s1,0x4
 7ee:	0014899b          	addiw	s3,s1,1
 7f2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7f4:	00001517          	auipc	a0,0x1
 7f8:	80c53503          	ld	a0,-2036(a0) # 1000 <freep>
 7fc:	c915                	beqz	a0,830 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 800:	4798                	lw	a4,8(a5)
 802:	08977a63          	bgeu	a4,s1,896 <malloc+0xbe>
 806:	f04a                	sd	s2,32(sp)
 808:	e852                	sd	s4,16(sp)
 80a:	e456                	sd	s5,8(sp)
 80c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 80e:	8a4e                	mv	s4,s3
 810:	0009871b          	sext.w	a4,s3
 814:	6685                	lui	a3,0x1
 816:	00d77363          	bgeu	a4,a3,81c <malloc+0x44>
 81a:	6a05                	lui	s4,0x1
 81c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 820:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 824:	00000917          	auipc	s2,0x0
 828:	7dc90913          	addi	s2,s2,2012 # 1000 <freep>
  if(p == SBRK_ERROR)
 82c:	5afd                	li	s5,-1
 82e:	a081                	j	86e <malloc+0x96>
 830:	f04a                	sd	s2,32(sp)
 832:	e852                	sd	s4,16(sp)
 834:	e456                	sd	s5,8(sp)
 836:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 838:	00000797          	auipc	a5,0x0
 83c:	7d878793          	addi	a5,a5,2008 # 1010 <base>
 840:	00000717          	auipc	a4,0x0
 844:	7cf73023          	sd	a5,1984(a4) # 1000 <freep>
 848:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 84a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 84e:	b7c1                	j	80e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 850:	6398                	ld	a4,0(a5)
 852:	e118                	sd	a4,0(a0)
 854:	a8a9                	j	8ae <malloc+0xd6>
  hp->s.size = nu;
 856:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 85a:	0541                	addi	a0,a0,16
 85c:	efbff0ef          	jal	756 <free>
  return freep;
 860:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 864:	c12d                	beqz	a0,8c6 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 868:	4798                	lw	a4,8(a5)
 86a:	02977263          	bgeu	a4,s1,88e <malloc+0xb6>
    if(p == freep)
 86e:	00093703          	ld	a4,0(s2)
 872:	853e                	mv	a0,a5
 874:	fef719e3          	bne	a4,a5,866 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 878:	8552                	mv	a0,s4
 87a:	9f9ff0ef          	jal	272 <sbrk>
  if(p == SBRK_ERROR)
 87e:	fd551ce3          	bne	a0,s5,856 <malloc+0x7e>
        return 0;
 882:	4501                	li	a0,0
 884:	7902                	ld	s2,32(sp)
 886:	6a42                	ld	s4,16(sp)
 888:	6aa2                	ld	s5,8(sp)
 88a:	6b02                	ld	s6,0(sp)
 88c:	a03d                	j	8ba <malloc+0xe2>
 88e:	7902                	ld	s2,32(sp)
 890:	6a42                	ld	s4,16(sp)
 892:	6aa2                	ld	s5,8(sp)
 894:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 896:	fae48de3          	beq	s1,a4,850 <malloc+0x78>
        p->s.size -= nunits;
 89a:	4137073b          	subw	a4,a4,s3
 89e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a0:	02071693          	slli	a3,a4,0x20
 8a4:	01c6d713          	srli	a4,a3,0x1c
 8a8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8aa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	74a73923          	sd	a0,1874(a4) # 1000 <freep>
      return (void*)(p + 1);
 8b6:	01078513          	addi	a0,a5,16
  }
}
 8ba:	70e2                	ld	ra,56(sp)
 8bc:	7442                	ld	s0,48(sp)
 8be:	74a2                	ld	s1,40(sp)
 8c0:	69e2                	ld	s3,24(sp)
 8c2:	6121                	addi	sp,sp,64
 8c4:	8082                	ret
 8c6:	7902                	ld	s2,32(sp)
 8c8:	6a42                	ld	s4,16(sp)
 8ca:	6aa2                	ld	s5,8(sp)
 8cc:	6b02                	ld	s6,0(sp)
 8ce:	b7f5                	j	8ba <malloc+0xe2>
