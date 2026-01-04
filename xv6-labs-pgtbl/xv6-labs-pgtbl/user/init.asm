
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	97250513          	addi	a0,a0,-1678 # 980 <malloc+0xfe>
  16:	390000ef          	jal	3a6 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	3be000ef          	jal	3de <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	3b8000ef          	jal	3de <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	95e90913          	addi	s2,s2,-1698 # 988 <malloc+0x106>
  32:	854a                	mv	a0,s2
  34:	79a000ef          	jal	7ce <printf>
    pid = fork();
  38:	326000ef          	jal	35e <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	328000ef          	jal	36e <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	98650513          	addi	a0,a0,-1658 # 9d8 <malloc+0x156>
  5a:	774000ef          	jal	7ce <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	306000ef          	jal	366 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	91850513          	addi	a0,a0,-1768 # 980 <malloc+0xfe>
  70:	33e000ef          	jal	3ae <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	90a50513          	addi	a0,a0,-1782 # 980 <malloc+0xfe>
  7e:	328000ef          	jal	3a6 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	91c50513          	addi	a0,a0,-1764 # 9a0 <malloc+0x11e>
  8c:	742000ef          	jal	7ce <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	2d4000ef          	jal	366 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	91a50513          	addi	a0,a0,-1766 # 9b8 <malloc+0x136>
  a6:	2f8000ef          	jal	39e <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	91650513          	addi	a0,a0,-1770 # 9c0 <malloc+0x13e>
  b2:	71c000ef          	jal	7ce <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	2ae000ef          	jal	366 <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  c4:	f3dff0ef          	jal	0 <main>
  exit(r);
  c8:	29e000ef          	jal	366 <exit>

00000000000000cc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d2:	87aa                	mv	a5,a0
  d4:	0585                	addi	a1,a1,1
  d6:	0785                	addi	a5,a5,1
  d8:	fff5c703          	lbu	a4,-1(a1)
  dc:	fee78fa3          	sb	a4,-1(a5)
  e0:	fb75                	bnez	a4,d4 <strcpy+0x8>
    ;
  return os;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	cb91                	beqz	a5,106 <strcmp+0x1e>
  f4:	0005c703          	lbu	a4,0(a1)
  f8:	00f71763          	bne	a4,a5,106 <strcmp+0x1e>
    p++, q++;
  fc:	0505                	addi	a0,a0,1
  fe:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	fbe5                	bnez	a5,f4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 106:	0005c503          	lbu	a0,0(a1)
}
 10a:	40a7853b          	subw	a0,a5,a0
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret

0000000000000114 <strlen>:

uint
strlen(const char *s)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	cf91                	beqz	a5,13a <strlen+0x26>
 120:	0505                	addi	a0,a0,1
 122:	87aa                	mv	a5,a0
 124:	86be                	mv	a3,a5
 126:	0785                	addi	a5,a5,1
 128:	fff7c703          	lbu	a4,-1(a5)
 12c:	ff65                	bnez	a4,124 <strlen+0x10>
 12e:	40a6853b          	subw	a0,a3,a0
 132:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret
  for(n = 0; s[n]; n++)
 13a:	4501                	li	a0,0
 13c:	bfe5                	j	134 <strlen+0x20>

000000000000013e <memset>:

void*
memset(void *dst, int c, uint n)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 144:	ca19                	beqz	a2,15a <memset+0x1c>
 146:	87aa                	mv	a5,a0
 148:	1602                	slli	a2,a2,0x20
 14a:	9201                	srli	a2,a2,0x20
 14c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 150:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 154:	0785                	addi	a5,a5,1
 156:	fee79de3          	bne	a5,a4,150 <memset+0x12>
  }
  return dst;
}
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret

0000000000000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  for(; *s; s++)
 166:	00054783          	lbu	a5,0(a0)
 16a:	cb99                	beqz	a5,180 <strchr+0x20>
    if(*s == c)
 16c:	00f58763          	beq	a1,a5,17a <strchr+0x1a>
  for(; *s; s++)
 170:	0505                	addi	a0,a0,1
 172:	00054783          	lbu	a5,0(a0)
 176:	fbfd                	bnez	a5,16c <strchr+0xc>
      return (char*)s;
  return 0;
 178:	4501                	li	a0,0
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret
  return 0;
 180:	4501                	li	a0,0
 182:	bfe5                	j	17a <strchr+0x1a>

0000000000000184 <gets>:

char*
gets(char *buf, int max)
{
 184:	711d                	addi	sp,sp,-96
 186:	ec86                	sd	ra,88(sp)
 188:	e8a2                	sd	s0,80(sp)
 18a:	e4a6                	sd	s1,72(sp)
 18c:	e0ca                	sd	s2,64(sp)
 18e:	fc4e                	sd	s3,56(sp)
 190:	f852                	sd	s4,48(sp)
 192:	f456                	sd	s5,40(sp)
 194:	f05a                	sd	s6,32(sp)
 196:	ec5e                	sd	s7,24(sp)
 198:	1080                	addi	s0,sp,96
 19a:	8baa                	mv	s7,a0
 19c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	892a                	mv	s2,a0
 1a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1a2:	4aa9                	li	s5,10
 1a4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1a6:	89a6                	mv	s3,s1
 1a8:	2485                	addiw	s1,s1,1
 1aa:	0344d663          	bge	s1,s4,1d6 <gets+0x52>
    cc = read(0, &c, 1);
 1ae:	4605                	li	a2,1
 1b0:	faf40593          	addi	a1,s0,-81
 1b4:	4501                	li	a0,0
 1b6:	1c8000ef          	jal	37e <read>
    if(cc < 1)
 1ba:	00a05e63          	blez	a0,1d6 <gets+0x52>
    buf[i++] = c;
 1be:	faf44783          	lbu	a5,-81(s0)
 1c2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c6:	01578763          	beq	a5,s5,1d4 <gets+0x50>
 1ca:	0905                	addi	s2,s2,1
 1cc:	fd679de3          	bne	a5,s6,1a6 <gets+0x22>
    buf[i++] = c;
 1d0:	89a6                	mv	s3,s1
 1d2:	a011                	j	1d6 <gets+0x52>
 1d4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d6:	99de                	add	s3,s3,s7
 1d8:	00098023          	sb	zero,0(s3)
  return buf;
}
 1dc:	855e                	mv	a0,s7
 1de:	60e6                	ld	ra,88(sp)
 1e0:	6446                	ld	s0,80(sp)
 1e2:	64a6                	ld	s1,72(sp)
 1e4:	6906                	ld	s2,64(sp)
 1e6:	79e2                	ld	s3,56(sp)
 1e8:	7a42                	ld	s4,48(sp)
 1ea:	7aa2                	ld	s5,40(sp)
 1ec:	7b02                	ld	s6,32(sp)
 1ee:	6be2                	ld	s7,24(sp)
 1f0:	6125                	addi	sp,sp,96
 1f2:	8082                	ret

00000000000001f4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f4:	1101                	addi	sp,sp,-32
 1f6:	ec06                	sd	ra,24(sp)
 1f8:	e822                	sd	s0,16(sp)
 1fa:	e04a                	sd	s2,0(sp)
 1fc:	1000                	addi	s0,sp,32
 1fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 200:	4581                	li	a1,0
 202:	1a4000ef          	jal	3a6 <open>
  if(fd < 0)
 206:	02054263          	bltz	a0,22a <stat+0x36>
 20a:	e426                	sd	s1,8(sp)
 20c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20e:	85ca                	mv	a1,s2
 210:	1ae000ef          	jal	3be <fstat>
 214:	892a                	mv	s2,a0
  close(fd);
 216:	8526                	mv	a0,s1
 218:	176000ef          	jal	38e <close>
  return r;
 21c:	64a2                	ld	s1,8(sp)
}
 21e:	854a                	mv	a0,s2
 220:	60e2                	ld	ra,24(sp)
 222:	6442                	ld	s0,16(sp)
 224:	6902                	ld	s2,0(sp)
 226:	6105                	addi	sp,sp,32
 228:	8082                	ret
    return -1;
 22a:	597d                	li	s2,-1
 22c:	bfcd                	j	21e <stat+0x2a>

000000000000022e <atoi>:

int
atoi(const char *s)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 234:	00054683          	lbu	a3,0(a0)
 238:	fd06879b          	addiw	a5,a3,-48
 23c:	0ff7f793          	zext.b	a5,a5
 240:	4625                	li	a2,9
 242:	02f66863          	bltu	a2,a5,272 <atoi+0x44>
 246:	872a                	mv	a4,a0
  n = 0;
 248:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24a:	0705                	addi	a4,a4,1
 24c:	0025179b          	slliw	a5,a0,0x2
 250:	9fa9                	addw	a5,a5,a0
 252:	0017979b          	slliw	a5,a5,0x1
 256:	9fb5                	addw	a5,a5,a3
 258:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25c:	00074683          	lbu	a3,0(a4)
 260:	fd06879b          	addiw	a5,a3,-48
 264:	0ff7f793          	zext.b	a5,a5
 268:	fef671e3          	bgeu	a2,a5,24a <atoi+0x1c>
  return n;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
  n = 0;
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <atoi+0x3e>

0000000000000276 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27c:	02b57463          	bgeu	a0,a1,2a4 <memmove+0x2e>
    while(n-- > 0)
 280:	00c05f63          	blez	a2,29e <memmove+0x28>
 284:	1602                	slli	a2,a2,0x20
 286:	9201                	srli	a2,a2,0x20
 288:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28c:	872a                	mv	a4,a0
      *dst++ = *src++;
 28e:	0585                	addi	a1,a1,1
 290:	0705                	addi	a4,a4,1
 292:	fff5c683          	lbu	a3,-1(a1)
 296:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29a:	fef71ae3          	bne	a4,a5,28e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
    dst += n;
 2a4:	00c50733          	add	a4,a0,a2
    src += n;
 2a8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2aa:	fec05ae3          	blez	a2,29e <memmove+0x28>
 2ae:	fff6079b          	addiw	a5,a2,-1
 2b2:	1782                	slli	a5,a5,0x20
 2b4:	9381                	srli	a5,a5,0x20
 2b6:	fff7c793          	not	a5,a5
 2ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2bc:	15fd                	addi	a1,a1,-1
 2be:	177d                	addi	a4,a4,-1
 2c0:	0005c683          	lbu	a3,0(a1)
 2c4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c8:	fee79ae3          	bne	a5,a4,2bc <memmove+0x46>
 2cc:	bfc9                	j	29e <memmove+0x28>

00000000000002ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d4:	ca05                	beqz	a2,304 <memcmp+0x36>
 2d6:	fff6069b          	addiw	a3,a2,-1
 2da:	1682                	slli	a3,a3,0x20
 2dc:	9281                	srli	a3,a3,0x20
 2de:	0685                	addi	a3,a3,1
 2e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	0005c703          	lbu	a4,0(a1)
 2ea:	00e79863          	bne	a5,a4,2fa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ee:	0505                	addi	a0,a0,1
    p2++;
 2f0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f2:	fed518e3          	bne	a0,a3,2e2 <memcmp+0x14>
  }
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	a019                	j	2fe <memcmp+0x30>
      return *p1 - *p2;
 2fa:	40e7853b          	subw	a0,a5,a4
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret
  return 0;
 304:	4501                	li	a0,0
 306:	bfe5                	j	2fe <memcmp+0x30>

0000000000000308 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 310:	f67ff0ef          	jal	276 <memmove>
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret

000000000000031c <sbrk>:

char *
sbrk(int n) {
 31c:	1141                	addi	sp,sp,-16
 31e:	e406                	sd	ra,8(sp)
 320:	e022                	sd	s0,0(sp)
 322:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 324:	4585                	li	a1,1
 326:	0c8000ef          	jal	3ee <sys_sbrk>
}
 32a:	60a2                	ld	ra,8(sp)
 32c:	6402                	ld	s0,0(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret

0000000000000332 <sbrklazy>:

char *
sbrklazy(int n) {
 332:	1141                	addi	sp,sp,-16
 334:	e406                	sd	ra,8(sp)
 336:	e022                	sd	s0,0(sp)
 338:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 33a:	4589                	li	a1,2
 33c:	0b2000ef          	jal	3ee <sys_sbrk>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e422                	sd	s0,8(sp)
 34c:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 34e:	040007b7          	lui	a5,0x4000
 352:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffefdd>
 354:	07b2                	slli	a5,a5,0xc
}
 356:	4388                	lw	a0,0(a5)
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret

000000000000035e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 35e:	4885                	li	a7,1
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <exit>:
.global exit
exit:
 li a7, SYS_exit
 366:	4889                	li	a7,2
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <wait>:
.global wait
wait:
 li a7, SYS_wait
 36e:	488d                	li	a7,3
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 376:	4891                	li	a7,4
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <read>:
.global read
read:
 li a7, SYS_read
 37e:	4895                	li	a7,5
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <write>:
.global write
write:
 li a7, SYS_write
 386:	48c1                	li	a7,16
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <close>:
.global close
close:
 li a7, SYS_close
 38e:	48d5                	li	a7,21
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <kill>:
.global kill
kill:
 li a7, SYS_kill
 396:	4899                	li	a7,6
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <exec>:
.global exec
exec:
 li a7, SYS_exec
 39e:	489d                	li	a7,7
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <open>:
.global open
open:
 li a7, SYS_open
 3a6:	48bd                	li	a7,15
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ae:	48c5                	li	a7,17
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3b6:	48c9                	li	a7,18
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3be:	48a1                	li	a7,8
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <link>:
.global link
link:
 li a7, SYS_link
 3c6:	48cd                	li	a7,19
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ce:	48d1                	li	a7,20
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d6:	48a5                	li	a7,9
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <dup>:
.global dup
dup:
 li a7, SYS_dup
 3de:	48a9                	li	a7,10
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e6:	48ad                	li	a7,11
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ee:	48b1                	li	a7,12
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3f6:	48b5                	li	a7,13
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3fe:	48b9                	li	a7,14
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <bind>:
.global bind
bind:
 li a7, SYS_bind
 406:	48f5                	li	a7,29
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 40e:	48f9                	li	a7,30
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <send>:
.global send
send:
 li a7, SYS_send
 416:	48fd                	li	a7,31
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <recv>:
.global recv
recv:
 li a7, SYS_recv
 41e:	02000893          	li	a7,32
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 428:	02100893          	li	a7,33
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 432:	02200893          	li	a7,34
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <prac>:
.global prac
prac:
 li a7, SYS_prac
 43c:	02300893          	li	a7,35
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 446:	1101                	addi	sp,sp,-32
 448:	ec06                	sd	ra,24(sp)
 44a:	e822                	sd	s0,16(sp)
 44c:	1000                	addi	s0,sp,32
 44e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 452:	4605                	li	a2,1
 454:	fef40593          	addi	a1,s0,-17
 458:	f2fff0ef          	jal	386 <write>
}
 45c:	60e2                	ld	ra,24(sp)
 45e:	6442                	ld	s0,16(sp)
 460:	6105                	addi	sp,sp,32
 462:	8082                	ret

0000000000000464 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 464:	715d                	addi	sp,sp,-80
 466:	e486                	sd	ra,72(sp)
 468:	e0a2                	sd	s0,64(sp)
 46a:	f84a                	sd	s2,48(sp)
 46c:	0880                	addi	s0,sp,80
 46e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 470:	c299                	beqz	a3,476 <printint+0x12>
 472:	0805c363          	bltz	a1,4f8 <printint+0x94>
  neg = 0;
 476:	4881                	li	a7,0
 478:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 47c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 47e:	00000517          	auipc	a0,0x0
 482:	58250513          	addi	a0,a0,1410 # a00 <digits>
 486:	883e                	mv	a6,a5
 488:	2785                	addiw	a5,a5,1
 48a:	02c5f733          	remu	a4,a1,a2
 48e:	972a                	add	a4,a4,a0
 490:	00074703          	lbu	a4,0(a4)
 494:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 498:	872e                	mv	a4,a1
 49a:	02c5d5b3          	divu	a1,a1,a2
 49e:	0685                	addi	a3,a3,1
 4a0:	fec773e3          	bgeu	a4,a2,486 <printint+0x22>
  if(neg)
 4a4:	00088b63          	beqz	a7,4ba <printint+0x56>
    buf[i++] = '-';
 4a8:	fd078793          	addi	a5,a5,-48
 4ac:	97a2                	add	a5,a5,s0
 4ae:	02d00713          	li	a4,45
 4b2:	fee78423          	sb	a4,-24(a5)
 4b6:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4ba:	02f05a63          	blez	a5,4ee <printint+0x8a>
 4be:	fc26                	sd	s1,56(sp)
 4c0:	f44e                	sd	s3,40(sp)
 4c2:	fb840713          	addi	a4,s0,-72
 4c6:	00f704b3          	add	s1,a4,a5
 4ca:	fff70993          	addi	s3,a4,-1
 4ce:	99be                	add	s3,s3,a5
 4d0:	37fd                	addiw	a5,a5,-1
 4d2:	1782                	slli	a5,a5,0x20
 4d4:	9381                	srli	a5,a5,0x20
 4d6:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4da:	fff4c583          	lbu	a1,-1(s1)
 4de:	854a                	mv	a0,s2
 4e0:	f67ff0ef          	jal	446 <putc>
  while(--i >= 0)
 4e4:	14fd                	addi	s1,s1,-1
 4e6:	ff349ae3          	bne	s1,s3,4da <printint+0x76>
 4ea:	74e2                	ld	s1,56(sp)
 4ec:	79a2                	ld	s3,40(sp)
}
 4ee:	60a6                	ld	ra,72(sp)
 4f0:	6406                	ld	s0,64(sp)
 4f2:	7942                	ld	s2,48(sp)
 4f4:	6161                	addi	sp,sp,80
 4f6:	8082                	ret
    x = -xx;
 4f8:	40b005b3          	neg	a1,a1
    neg = 1;
 4fc:	4885                	li	a7,1
    x = -xx;
 4fe:	bfad                	j	478 <printint+0x14>

0000000000000500 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 500:	711d                	addi	sp,sp,-96
 502:	ec86                	sd	ra,88(sp)
 504:	e8a2                	sd	s0,80(sp)
 506:	e0ca                	sd	s2,64(sp)
 508:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 50a:	0005c903          	lbu	s2,0(a1)
 50e:	28090663          	beqz	s2,79a <vprintf+0x29a>
 512:	e4a6                	sd	s1,72(sp)
 514:	fc4e                	sd	s3,56(sp)
 516:	f852                	sd	s4,48(sp)
 518:	f456                	sd	s5,40(sp)
 51a:	f05a                	sd	s6,32(sp)
 51c:	ec5e                	sd	s7,24(sp)
 51e:	e862                	sd	s8,16(sp)
 520:	e466                	sd	s9,8(sp)
 522:	8b2a                	mv	s6,a0
 524:	8a2e                	mv	s4,a1
 526:	8bb2                	mv	s7,a2
  state = 0;
 528:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 52a:	4481                	li	s1,0
 52c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 52e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 532:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 536:	06c00c93          	li	s9,108
 53a:	a005                	j	55a <vprintf+0x5a>
        putc(fd, c0);
 53c:	85ca                	mv	a1,s2
 53e:	855a                	mv	a0,s6
 540:	f07ff0ef          	jal	446 <putc>
 544:	a019                	j	54a <vprintf+0x4a>
    } else if(state == '%'){
 546:	03598263          	beq	s3,s5,56a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 54a:	2485                	addiw	s1,s1,1
 54c:	8726                	mv	a4,s1
 54e:	009a07b3          	add	a5,s4,s1
 552:	0007c903          	lbu	s2,0(a5)
 556:	22090a63          	beqz	s2,78a <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 55a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 55e:	fe0994e3          	bnez	s3,546 <vprintf+0x46>
      if(c0 == '%'){
 562:	fd579de3          	bne	a5,s5,53c <vprintf+0x3c>
        state = '%';
 566:	89be                	mv	s3,a5
 568:	b7cd                	j	54a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 56a:	00ea06b3          	add	a3,s4,a4
 56e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 572:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 574:	c681                	beqz	a3,57c <vprintf+0x7c>
 576:	9752                	add	a4,a4,s4
 578:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 57c:	05878363          	beq	a5,s8,5c2 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 580:	05978d63          	beq	a5,s9,5da <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 584:	07500713          	li	a4,117
 588:	0ee78763          	beq	a5,a4,676 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 58c:	07800713          	li	a4,120
 590:	12e78963          	beq	a5,a4,6c2 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 594:	07000713          	li	a4,112
 598:	14e78e63          	beq	a5,a4,6f4 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 59c:	06300713          	li	a4,99
 5a0:	18e78e63          	beq	a5,a4,73c <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5a4:	07300713          	li	a4,115
 5a8:	1ae78463          	beq	a5,a4,750 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5ac:	02500713          	li	a4,37
 5b0:	04e79563          	bne	a5,a4,5fa <vprintf+0xfa>
        putc(fd, '%');
 5b4:	02500593          	li	a1,37
 5b8:	855a                	mv	a0,s6
 5ba:	e8dff0ef          	jal	446 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b769                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5c2:	008b8913          	addi	s2,s7,8
 5c6:	4685                	li	a3,1
 5c8:	4629                	li	a2,10
 5ca:	000ba583          	lw	a1,0(s7)
 5ce:	855a                	mv	a0,s6
 5d0:	e95ff0ef          	jal	464 <printint>
 5d4:	8bca                	mv	s7,s2
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	bf8d                	j	54a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5da:	06400793          	li	a5,100
 5de:	02f68963          	beq	a3,a5,610 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5e2:	06c00793          	li	a5,108
 5e6:	04f68263          	beq	a3,a5,62a <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 5ea:	07500793          	li	a5,117
 5ee:	0af68063          	beq	a3,a5,68e <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 5f2:	07800793          	li	a5,120
 5f6:	0ef68263          	beq	a3,a5,6da <vprintf+0x1da>
        putc(fd, '%');
 5fa:	02500593          	li	a1,37
 5fe:	855a                	mv	a0,s6
 600:	e47ff0ef          	jal	446 <putc>
        putc(fd, c0);
 604:	85ca                	mv	a1,s2
 606:	855a                	mv	a0,s6
 608:	e3fff0ef          	jal	446 <putc>
      state = 0;
 60c:	4981                	li	s3,0
 60e:	bf35                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 610:	008b8913          	addi	s2,s7,8
 614:	4685                	li	a3,1
 616:	4629                	li	a2,10
 618:	000bb583          	ld	a1,0(s7)
 61c:	855a                	mv	a0,s6
 61e:	e47ff0ef          	jal	464 <printint>
        i += 1;
 622:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 624:	8bca                	mv	s7,s2
      state = 0;
 626:	4981                	li	s3,0
        i += 1;
 628:	b70d                	j	54a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 62a:	06400793          	li	a5,100
 62e:	02f60763          	beq	a2,a5,65c <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 632:	07500793          	li	a5,117
 636:	06f60963          	beq	a2,a5,6a8 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 63a:	07800793          	li	a5,120
 63e:	faf61ee3          	bne	a2,a5,5fa <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 642:	008b8913          	addi	s2,s7,8
 646:	4681                	li	a3,0
 648:	4641                	li	a2,16
 64a:	000bb583          	ld	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	e15ff0ef          	jal	464 <printint>
        i += 2;
 654:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 656:	8bca                	mv	s7,s2
      state = 0;
 658:	4981                	li	s3,0
        i += 2;
 65a:	bdc5                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 65c:	008b8913          	addi	s2,s7,8
 660:	4685                	li	a3,1
 662:	4629                	li	a2,10
 664:	000bb583          	ld	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	dfbff0ef          	jal	464 <printint>
        i += 2;
 66e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 670:	8bca                	mv	s7,s2
      state = 0;
 672:	4981                	li	s3,0
        i += 2;
 674:	bdd9                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 676:	008b8913          	addi	s2,s7,8
 67a:	4681                	li	a3,0
 67c:	4629                	li	a2,10
 67e:	000be583          	lwu	a1,0(s7)
 682:	855a                	mv	a0,s6
 684:	de1ff0ef          	jal	464 <printint>
 688:	8bca                	mv	s7,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bd7d                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 68e:	008b8913          	addi	s2,s7,8
 692:	4681                	li	a3,0
 694:	4629                	li	a2,10
 696:	000bb583          	ld	a1,0(s7)
 69a:	855a                	mv	a0,s6
 69c:	dc9ff0ef          	jal	464 <printint>
        i += 1;
 6a0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a2:	8bca                	mv	s7,s2
      state = 0;
 6a4:	4981                	li	s3,0
        i += 1;
 6a6:	b555                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a8:	008b8913          	addi	s2,s7,8
 6ac:	4681                	li	a3,0
 6ae:	4629                	li	a2,10
 6b0:	000bb583          	ld	a1,0(s7)
 6b4:	855a                	mv	a0,s6
 6b6:	dafff0ef          	jal	464 <printint>
        i += 2;
 6ba:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6bc:	8bca                	mv	s7,s2
      state = 0;
 6be:	4981                	li	s3,0
        i += 2;
 6c0:	b569                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6c2:	008b8913          	addi	s2,s7,8
 6c6:	4681                	li	a3,0
 6c8:	4641                	li	a2,16
 6ca:	000be583          	lwu	a1,0(s7)
 6ce:	855a                	mv	a0,s6
 6d0:	d95ff0ef          	jal	464 <printint>
 6d4:	8bca                	mv	s7,s2
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	bd8d                	j	54a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6da:	008b8913          	addi	s2,s7,8
 6de:	4681                	li	a3,0
 6e0:	4641                	li	a2,16
 6e2:	000bb583          	ld	a1,0(s7)
 6e6:	855a                	mv	a0,s6
 6e8:	d7dff0ef          	jal	464 <printint>
        i += 1;
 6ec:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ee:	8bca                	mv	s7,s2
      state = 0;
 6f0:	4981                	li	s3,0
        i += 1;
 6f2:	bda1                	j	54a <vprintf+0x4a>
 6f4:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6f6:	008b8d13          	addi	s10,s7,8
 6fa:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6fe:	03000593          	li	a1,48
 702:	855a                	mv	a0,s6
 704:	d43ff0ef          	jal	446 <putc>
  putc(fd, 'x');
 708:	07800593          	li	a1,120
 70c:	855a                	mv	a0,s6
 70e:	d39ff0ef          	jal	446 <putc>
 712:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 714:	00000b97          	auipc	s7,0x0
 718:	2ecb8b93          	addi	s7,s7,748 # a00 <digits>
 71c:	03c9d793          	srli	a5,s3,0x3c
 720:	97de                	add	a5,a5,s7
 722:	0007c583          	lbu	a1,0(a5)
 726:	855a                	mv	a0,s6
 728:	d1fff0ef          	jal	446 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 72c:	0992                	slli	s3,s3,0x4
 72e:	397d                	addiw	s2,s2,-1
 730:	fe0916e3          	bnez	s2,71c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 734:	8bea                	mv	s7,s10
      state = 0;
 736:	4981                	li	s3,0
 738:	6d02                	ld	s10,0(sp)
 73a:	bd01                	j	54a <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 73c:	008b8913          	addi	s2,s7,8
 740:	000bc583          	lbu	a1,0(s7)
 744:	855a                	mv	a0,s6
 746:	d01ff0ef          	jal	446 <putc>
 74a:	8bca                	mv	s7,s2
      state = 0;
 74c:	4981                	li	s3,0
 74e:	bbf5                	j	54a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 750:	008b8993          	addi	s3,s7,8
 754:	000bb903          	ld	s2,0(s7)
 758:	00090f63          	beqz	s2,776 <vprintf+0x276>
        for(; *s; s++)
 75c:	00094583          	lbu	a1,0(s2)
 760:	c195                	beqz	a1,784 <vprintf+0x284>
          putc(fd, *s);
 762:	855a                	mv	a0,s6
 764:	ce3ff0ef          	jal	446 <putc>
        for(; *s; s++)
 768:	0905                	addi	s2,s2,1
 76a:	00094583          	lbu	a1,0(s2)
 76e:	f9f5                	bnez	a1,762 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 770:	8bce                	mv	s7,s3
      state = 0;
 772:	4981                	li	s3,0
 774:	bbd9                	j	54a <vprintf+0x4a>
          s = "(null)";
 776:	00000917          	auipc	s2,0x0
 77a:	28290913          	addi	s2,s2,642 # 9f8 <malloc+0x176>
        for(; *s; s++)
 77e:	02800593          	li	a1,40
 782:	b7c5                	j	762 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 784:	8bce                	mv	s7,s3
      state = 0;
 786:	4981                	li	s3,0
 788:	b3c9                	j	54a <vprintf+0x4a>
 78a:	64a6                	ld	s1,72(sp)
 78c:	79e2                	ld	s3,56(sp)
 78e:	7a42                	ld	s4,48(sp)
 790:	7aa2                	ld	s5,40(sp)
 792:	7b02                	ld	s6,32(sp)
 794:	6be2                	ld	s7,24(sp)
 796:	6c42                	ld	s8,16(sp)
 798:	6ca2                	ld	s9,8(sp)
    }
  }
}
 79a:	60e6                	ld	ra,88(sp)
 79c:	6446                	ld	s0,80(sp)
 79e:	6906                	ld	s2,64(sp)
 7a0:	6125                	addi	sp,sp,96
 7a2:	8082                	ret

00000000000007a4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a4:	715d                	addi	sp,sp,-80
 7a6:	ec06                	sd	ra,24(sp)
 7a8:	e822                	sd	s0,16(sp)
 7aa:	1000                	addi	s0,sp,32
 7ac:	e010                	sd	a2,0(s0)
 7ae:	e414                	sd	a3,8(s0)
 7b0:	e818                	sd	a4,16(s0)
 7b2:	ec1c                	sd	a5,24(s0)
 7b4:	03043023          	sd	a6,32(s0)
 7b8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7bc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c0:	8622                	mv	a2,s0
 7c2:	d3fff0ef          	jal	500 <vprintf>
}
 7c6:	60e2                	ld	ra,24(sp)
 7c8:	6442                	ld	s0,16(sp)
 7ca:	6161                	addi	sp,sp,80
 7cc:	8082                	ret

00000000000007ce <printf>:

void
printf(const char *fmt, ...)
{
 7ce:	711d                	addi	sp,sp,-96
 7d0:	ec06                	sd	ra,24(sp)
 7d2:	e822                	sd	s0,16(sp)
 7d4:	1000                	addi	s0,sp,32
 7d6:	e40c                	sd	a1,8(s0)
 7d8:	e810                	sd	a2,16(s0)
 7da:	ec14                	sd	a3,24(s0)
 7dc:	f018                	sd	a4,32(s0)
 7de:	f41c                	sd	a5,40(s0)
 7e0:	03043823          	sd	a6,48(s0)
 7e4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7e8:	00840613          	addi	a2,s0,8
 7ec:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f0:	85aa                	mv	a1,a0
 7f2:	4505                	li	a0,1
 7f4:	d0dff0ef          	jal	500 <vprintf>
}
 7f8:	60e2                	ld	ra,24(sp)
 7fa:	6442                	ld	s0,16(sp)
 7fc:	6125                	addi	sp,sp,96
 7fe:	8082                	ret

0000000000000800 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 800:	1141                	addi	sp,sp,-16
 802:	e422                	sd	s0,8(sp)
 804:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 806:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80a:	00001797          	auipc	a5,0x1
 80e:	8067b783          	ld	a5,-2042(a5) # 1010 <freep>
 812:	a02d                	j	83c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 814:	4618                	lw	a4,8(a2)
 816:	9f2d                	addw	a4,a4,a1
 818:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 81c:	6398                	ld	a4,0(a5)
 81e:	6310                	ld	a2,0(a4)
 820:	a83d                	j	85e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 822:	ff852703          	lw	a4,-8(a0)
 826:	9f31                	addw	a4,a4,a2
 828:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 82a:	ff053683          	ld	a3,-16(a0)
 82e:	a091                	j	872 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 830:	6398                	ld	a4,0(a5)
 832:	00e7e463          	bltu	a5,a4,83a <free+0x3a>
 836:	00e6ea63          	bltu	a3,a4,84a <free+0x4a>
{
 83a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83c:	fed7fae3          	bgeu	a5,a3,830 <free+0x30>
 840:	6398                	ld	a4,0(a5)
 842:	00e6e463          	bltu	a3,a4,84a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 846:	fee7eae3          	bltu	a5,a4,83a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 84a:	ff852583          	lw	a1,-8(a0)
 84e:	6390                	ld	a2,0(a5)
 850:	02059813          	slli	a6,a1,0x20
 854:	01c85713          	srli	a4,a6,0x1c
 858:	9736                	add	a4,a4,a3
 85a:	fae60de3          	beq	a2,a4,814 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 85e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 862:	4790                	lw	a2,8(a5)
 864:	02061593          	slli	a1,a2,0x20
 868:	01c5d713          	srli	a4,a1,0x1c
 86c:	973e                	add	a4,a4,a5
 86e:	fae68ae3          	beq	a3,a4,822 <free+0x22>
    p->s.ptr = bp->s.ptr;
 872:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 874:	00000717          	auipc	a4,0x0
 878:	78f73e23          	sd	a5,1948(a4) # 1010 <freep>
}
 87c:	6422                	ld	s0,8(sp)
 87e:	0141                	addi	sp,sp,16
 880:	8082                	ret

0000000000000882 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 882:	7139                	addi	sp,sp,-64
 884:	fc06                	sd	ra,56(sp)
 886:	f822                	sd	s0,48(sp)
 888:	f426                	sd	s1,40(sp)
 88a:	ec4e                	sd	s3,24(sp)
 88c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88e:	02051493          	slli	s1,a0,0x20
 892:	9081                	srli	s1,s1,0x20
 894:	04bd                	addi	s1,s1,15
 896:	8091                	srli	s1,s1,0x4
 898:	0014899b          	addiw	s3,s1,1
 89c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 89e:	00000517          	auipc	a0,0x0
 8a2:	77253503          	ld	a0,1906(a0) # 1010 <freep>
 8a6:	c915                	beqz	a0,8da <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8aa:	4798                	lw	a4,8(a5)
 8ac:	08977a63          	bgeu	a4,s1,940 <malloc+0xbe>
 8b0:	f04a                	sd	s2,32(sp)
 8b2:	e852                	sd	s4,16(sp)
 8b4:	e456                	sd	s5,8(sp)
 8b6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8b8:	8a4e                	mv	s4,s3
 8ba:	0009871b          	sext.w	a4,s3
 8be:	6685                	lui	a3,0x1
 8c0:	00d77363          	bgeu	a4,a3,8c6 <malloc+0x44>
 8c4:	6a05                	lui	s4,0x1
 8c6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ca:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8ce:	00000917          	auipc	s2,0x0
 8d2:	74290913          	addi	s2,s2,1858 # 1010 <freep>
  if(p == SBRK_ERROR)
 8d6:	5afd                	li	s5,-1
 8d8:	a081                	j	918 <malloc+0x96>
 8da:	f04a                	sd	s2,32(sp)
 8dc:	e852                	sd	s4,16(sp)
 8de:	e456                	sd	s5,8(sp)
 8e0:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8e2:	00000797          	auipc	a5,0x0
 8e6:	73e78793          	addi	a5,a5,1854 # 1020 <base>
 8ea:	00000717          	auipc	a4,0x0
 8ee:	72f73323          	sd	a5,1830(a4) # 1010 <freep>
 8f2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8f4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8f8:	b7c1                	j	8b8 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8fa:	6398                	ld	a4,0(a5)
 8fc:	e118                	sd	a4,0(a0)
 8fe:	a8a9                	j	958 <malloc+0xd6>
  hp->s.size = nu;
 900:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 904:	0541                	addi	a0,a0,16
 906:	efbff0ef          	jal	800 <free>
  return freep;
 90a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 90e:	c12d                	beqz	a0,970 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 910:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 912:	4798                	lw	a4,8(a5)
 914:	02977263          	bgeu	a4,s1,938 <malloc+0xb6>
    if(p == freep)
 918:	00093703          	ld	a4,0(s2)
 91c:	853e                	mv	a0,a5
 91e:	fef719e3          	bne	a4,a5,910 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 922:	8552                	mv	a0,s4
 924:	9f9ff0ef          	jal	31c <sbrk>
  if(p == SBRK_ERROR)
 928:	fd551ce3          	bne	a0,s5,900 <malloc+0x7e>
        return 0;
 92c:	4501                	li	a0,0
 92e:	7902                	ld	s2,32(sp)
 930:	6a42                	ld	s4,16(sp)
 932:	6aa2                	ld	s5,8(sp)
 934:	6b02                	ld	s6,0(sp)
 936:	a03d                	j	964 <malloc+0xe2>
 938:	7902                	ld	s2,32(sp)
 93a:	6a42                	ld	s4,16(sp)
 93c:	6aa2                	ld	s5,8(sp)
 93e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 940:	fae48de3          	beq	s1,a4,8fa <malloc+0x78>
        p->s.size -= nunits;
 944:	4137073b          	subw	a4,a4,s3
 948:	c798                	sw	a4,8(a5)
        p += p->s.size;
 94a:	02071693          	slli	a3,a4,0x20
 94e:	01c6d713          	srli	a4,a3,0x1c
 952:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 954:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 958:	00000717          	auipc	a4,0x0
 95c:	6aa73c23          	sd	a0,1720(a4) # 1010 <freep>
      return (void*)(p + 1);
 960:	01078513          	addi	a0,a5,16
  }
}
 964:	70e2                	ld	ra,56(sp)
 966:	7442                	ld	s0,48(sp)
 968:	74a2                	ld	s1,40(sp)
 96a:	69e2                	ld	s3,24(sp)
 96c:	6121                	addi	sp,sp,64
 96e:	8082                	ret
 970:	7902                	ld	s2,32(sp)
 972:	6a42                	ld	s4,16(sp)
 974:	6aa2                	ld	s5,8(sp)
 976:	6b02                	ld	s6,0(sp)
 978:	b7f5                	j	964 <malloc+0xe2>
