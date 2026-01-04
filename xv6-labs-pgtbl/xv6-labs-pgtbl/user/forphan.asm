
user/_forphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
  int fd = 0;
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)
  struct stat st;
  char *ff = "file0";
  
  if ((fd = open(ff, O_CREATE|O_WRONLY)) < 0) {
   c:	20100593          	li	a1,513
  10:	00001517          	auipc	a0,0x1
  14:	98050513          	addi	a0,a0,-1664 # 990 <malloc+0x106>
  18:	396000ef          	jal	3ae <open>
  1c:	04054463          	bltz	a0,64 <main+0x64>
    printf("%s: open failed\n", s);
    exit(1);
  }
  if(fstat(fd, &st) < 0){
  20:	fc840593          	addi	a1,s0,-56
  24:	3a2000ef          	jal	3c6 <fstat>
  28:	04054863          	bltz	a0,78 <main+0x78>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
    exit(1);
  }
  if (unlink(ff) < 0) {
  2c:	00001517          	auipc	a0,0x1
  30:	96450513          	addi	a0,a0,-1692 # 990 <malloc+0x106>
  34:	38a000ef          	jal	3be <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	95250513          	addi	a0,a0,-1710 # 990 <malloc+0x106>
  46:	368000ef          	jal	3ae <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	99e50513          	addi	a0,a0,-1634 # 9f0 <malloc+0x166>
  5a:	77c000ef          	jal	7d6 <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	30e000ef          	jal	36e <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	93a50513          	addi	a0,a0,-1734 # 9a0 <malloc+0x116>
  6e:	768000ef          	jal	7d6 <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	2fa000ef          	jal	36e <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	94068693          	addi	a3,a3,-1728 # 9b8 <malloc+0x12e>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	93e58593          	addi	a1,a1,-1730 # 9c0 <malloc+0x136>
  8a:	4509                	li	a0,2
  8c:	720000ef          	jal	7ac <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	2dc000ef          	jal	36e <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	94050513          	addi	a0,a0,-1728 # 9d8 <malloc+0x14e>
  a0:	736000ef          	jal	7d6 <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	2c8000ef          	jal	36e <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	95a50513          	addi	a0,a0,-1702 # a08 <malloc+0x17e>
  b6:	720000ef          	jal	7d6 <printf>
  // sit around until killed
  for(;;) pause(1000);
  ba:	3e800513          	li	a0,1000
  be:	340000ef          	jal	3fe <pause>
  c2:	bfe5                	j	ba <main+0xba>

00000000000000c4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  cc:	f35ff0ef          	jal	0 <main>
  exit(r);
  d0:	29e000ef          	jal	36e <exit>

00000000000000d4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  da:	87aa                	mv	a5,a0
  dc:	0585                	addi	a1,a1,1
  de:	0785                	addi	a5,a5,1
  e0:	fff5c703          	lbu	a4,-1(a1)
  e4:	fee78fa3          	sb	a4,-1(a5)
  e8:	fb75                	bnez	a4,dc <strcpy+0x8>
    ;
  return os;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret

00000000000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	1141                	addi	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb91                	beqz	a5,10e <strcmp+0x1e>
  fc:	0005c703          	lbu	a4,0(a1)
 100:	00f71763          	bne	a4,a5,10e <strcmp+0x1e>
    p++, q++;
 104:	0505                	addi	a0,a0,1
 106:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbe5                	bnez	a5,fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 10e:	0005c503          	lbu	a0,0(a1)
}
 112:	40a7853b          	subw	a0,a5,a0
 116:	6422                	ld	s0,8(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret

000000000000011c <strlen>:

uint
strlen(const char *s)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 122:	00054783          	lbu	a5,0(a0)
 126:	cf91                	beqz	a5,142 <strlen+0x26>
 128:	0505                	addi	a0,a0,1
 12a:	87aa                	mv	a5,a0
 12c:	86be                	mv	a3,a5
 12e:	0785                	addi	a5,a5,1
 130:	fff7c703          	lbu	a4,-1(a5)
 134:	ff65                	bnez	a4,12c <strlen+0x10>
 136:	40a6853b          	subw	a0,a3,a0
 13a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
  for(n = 0; s[n]; n++)
 142:	4501                	li	a0,0
 144:	bfe5                	j	13c <strlen+0x20>

0000000000000146 <memset>:

void*
memset(void *dst, int c, uint n)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 14c:	ca19                	beqz	a2,162 <memset+0x1c>
 14e:	87aa                	mv	a5,a0
 150:	1602                	slli	a2,a2,0x20
 152:	9201                	srli	a2,a2,0x20
 154:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 158:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 15c:	0785                	addi	a5,a5,1
 15e:	fee79de3          	bne	a5,a4,158 <memset+0x12>
  }
  return dst;
}
 162:	6422                	ld	s0,8(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <strchr>:

char*
strchr(const char *s, char c)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 16e:	00054783          	lbu	a5,0(a0)
 172:	cb99                	beqz	a5,188 <strchr+0x20>
    if(*s == c)
 174:	00f58763          	beq	a1,a5,182 <strchr+0x1a>
  for(; *s; s++)
 178:	0505                	addi	a0,a0,1
 17a:	00054783          	lbu	a5,0(a0)
 17e:	fbfd                	bnez	a5,174 <strchr+0xc>
      return (char*)s;
  return 0;
 180:	4501                	li	a0,0
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret
  return 0;
 188:	4501                	li	a0,0
 18a:	bfe5                	j	182 <strchr+0x1a>

000000000000018c <gets>:

char*
gets(char *buf, int max)
{
 18c:	711d                	addi	sp,sp,-96
 18e:	ec86                	sd	ra,88(sp)
 190:	e8a2                	sd	s0,80(sp)
 192:	e4a6                	sd	s1,72(sp)
 194:	e0ca                	sd	s2,64(sp)
 196:	fc4e                	sd	s3,56(sp)
 198:	f852                	sd	s4,48(sp)
 19a:	f456                	sd	s5,40(sp)
 19c:	f05a                	sd	s6,32(sp)
 19e:	ec5e                	sd	s7,24(sp)
 1a0:	1080                	addi	s0,sp,96
 1a2:	8baa                	mv	s7,a0
 1a4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	892a                	mv	s2,a0
 1a8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1aa:	4aa9                	li	s5,10
 1ac:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ae:	89a6                	mv	s3,s1
 1b0:	2485                	addiw	s1,s1,1
 1b2:	0344d663          	bge	s1,s4,1de <gets+0x52>
    cc = read(0, &c, 1);
 1b6:	4605                	li	a2,1
 1b8:	faf40593          	addi	a1,s0,-81
 1bc:	4501                	li	a0,0
 1be:	1c8000ef          	jal	386 <read>
    if(cc < 1)
 1c2:	00a05e63          	blez	a0,1de <gets+0x52>
    buf[i++] = c;
 1c6:	faf44783          	lbu	a5,-81(s0)
 1ca:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ce:	01578763          	beq	a5,s5,1dc <gets+0x50>
 1d2:	0905                	addi	s2,s2,1
 1d4:	fd679de3          	bne	a5,s6,1ae <gets+0x22>
    buf[i++] = c;
 1d8:	89a6                	mv	s3,s1
 1da:	a011                	j	1de <gets+0x52>
 1dc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1de:	99de                	add	s3,s3,s7
 1e0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e4:	855e                	mv	a0,s7
 1e6:	60e6                	ld	ra,88(sp)
 1e8:	6446                	ld	s0,80(sp)
 1ea:	64a6                	ld	s1,72(sp)
 1ec:	6906                	ld	s2,64(sp)
 1ee:	79e2                	ld	s3,56(sp)
 1f0:	7a42                	ld	s4,48(sp)
 1f2:	7aa2                	ld	s5,40(sp)
 1f4:	7b02                	ld	s6,32(sp)
 1f6:	6be2                	ld	s7,24(sp)
 1f8:	6125                	addi	sp,sp,96
 1fa:	8082                	ret

00000000000001fc <stat>:

int
stat(const char *n, struct stat *st)
{
 1fc:	1101                	addi	sp,sp,-32
 1fe:	ec06                	sd	ra,24(sp)
 200:	e822                	sd	s0,16(sp)
 202:	e04a                	sd	s2,0(sp)
 204:	1000                	addi	s0,sp,32
 206:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 208:	4581                	li	a1,0
 20a:	1a4000ef          	jal	3ae <open>
  if(fd < 0)
 20e:	02054263          	bltz	a0,232 <stat+0x36>
 212:	e426                	sd	s1,8(sp)
 214:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 216:	85ca                	mv	a1,s2
 218:	1ae000ef          	jal	3c6 <fstat>
 21c:	892a                	mv	s2,a0
  close(fd);
 21e:	8526                	mv	a0,s1
 220:	176000ef          	jal	396 <close>
  return r;
 224:	64a2                	ld	s1,8(sp)
}
 226:	854a                	mv	a0,s2
 228:	60e2                	ld	ra,24(sp)
 22a:	6442                	ld	s0,16(sp)
 22c:	6902                	ld	s2,0(sp)
 22e:	6105                	addi	sp,sp,32
 230:	8082                	ret
    return -1;
 232:	597d                	li	s2,-1
 234:	bfcd                	j	226 <stat+0x2a>

0000000000000236 <atoi>:

int
atoi(const char *s)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23c:	00054683          	lbu	a3,0(a0)
 240:	fd06879b          	addiw	a5,a3,-48
 244:	0ff7f793          	zext.b	a5,a5
 248:	4625                	li	a2,9
 24a:	02f66863          	bltu	a2,a5,27a <atoi+0x44>
 24e:	872a                	mv	a4,a0
  n = 0;
 250:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 252:	0705                	addi	a4,a4,1
 254:	0025179b          	slliw	a5,a0,0x2
 258:	9fa9                	addw	a5,a5,a0
 25a:	0017979b          	slliw	a5,a5,0x1
 25e:	9fb5                	addw	a5,a5,a3
 260:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 264:	00074683          	lbu	a3,0(a4)
 268:	fd06879b          	addiw	a5,a3,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	fef671e3          	bgeu	a2,a5,252 <atoi+0x1c>
  return n;
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
  n = 0;
 27a:	4501                	li	a0,0
 27c:	bfe5                	j	274 <atoi+0x3e>

000000000000027e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 284:	02b57463          	bgeu	a0,a1,2ac <memmove+0x2e>
    while(n-- > 0)
 288:	00c05f63          	blez	a2,2a6 <memmove+0x28>
 28c:	1602                	slli	a2,a2,0x20
 28e:	9201                	srli	a2,a2,0x20
 290:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 294:	872a                	mv	a4,a0
      *dst++ = *src++;
 296:	0585                	addi	a1,a1,1
 298:	0705                	addi	a4,a4,1
 29a:	fff5c683          	lbu	a3,-1(a1)
 29e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a2:	fef71ae3          	bne	a4,a5,296 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
    dst += n;
 2ac:	00c50733          	add	a4,a0,a2
    src += n;
 2b0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b2:	fec05ae3          	blez	a2,2a6 <memmove+0x28>
 2b6:	fff6079b          	addiw	a5,a2,-1
 2ba:	1782                	slli	a5,a5,0x20
 2bc:	9381                	srli	a5,a5,0x20
 2be:	fff7c793          	not	a5,a5
 2c2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c4:	15fd                	addi	a1,a1,-1
 2c6:	177d                	addi	a4,a4,-1
 2c8:	0005c683          	lbu	a3,0(a1)
 2cc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x46>
 2d4:	bfc9                	j	2a6 <memmove+0x28>

00000000000002d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2dc:	ca05                	beqz	a2,30c <memcmp+0x36>
 2de:	fff6069b          	addiw	a3,a2,-1
 2e2:	1682                	slli	a3,a3,0x20
 2e4:	9281                	srli	a3,a3,0x20
 2e6:	0685                	addi	a3,a3,1
 2e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	0005c703          	lbu	a4,0(a1)
 2f2:	00e79863          	bne	a5,a4,302 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f6:	0505                	addi	a0,a0,1
    p2++;
 2f8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fa:	fed518e3          	bne	a0,a3,2ea <memcmp+0x14>
  }
  return 0;
 2fe:	4501                	li	a0,0
 300:	a019                	j	306 <memcmp+0x30>
      return *p1 - *p2;
 302:	40e7853b          	subw	a0,a5,a4
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  return 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <memcmp+0x30>

0000000000000310 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 318:	f67ff0ef          	jal	27e <memmove>
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <sbrk>:

char *
sbrk(int n) {
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 32c:	4585                	li	a1,1
 32e:	0c8000ef          	jal	3f6 <sys_sbrk>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <sbrklazy>:

char *
sbrklazy(int n) {
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 342:	4589                	li	a1,2
 344:	0b2000ef          	jal	3f6 <sys_sbrk>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 356:	040007b7          	lui	a5,0x4000
 35a:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffedf5>
 35c:	07b2                	slli	a5,a5,0xc
}
 35e:	4388                	lw	a0,0(a5)
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret

0000000000000366 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 366:	4885                	li	a7,1
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <exit>:
.global exit
exit:
 li a7, SYS_exit
 36e:	4889                	li	a7,2
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <wait>:
.global wait
wait:
 li a7, SYS_wait
 376:	488d                	li	a7,3
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 37e:	4891                	li	a7,4
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <read>:
.global read
read:
 li a7, SYS_read
 386:	4895                	li	a7,5
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <write>:
.global write
write:
 li a7, SYS_write
 38e:	48c1                	li	a7,16
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <close>:
.global close
close:
 li a7, SYS_close
 396:	48d5                	li	a7,21
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <kill>:
.global kill
kill:
 li a7, SYS_kill
 39e:	4899                	li	a7,6
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3a6:	489d                	li	a7,7
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <open>:
.global open
open:
 li a7, SYS_open
 3ae:	48bd                	li	a7,15
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3b6:	48c5                	li	a7,17
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3be:	48c9                	li	a7,18
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3c6:	48a1                	li	a7,8
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <link>:
.global link
link:
 li a7, SYS_link
 3ce:	48cd                	li	a7,19
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3d6:	48d1                	li	a7,20
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3de:	48a5                	li	a7,9
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3e6:	48a9                	li	a7,10
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ee:	48ad                	li	a7,11
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3f6:	48b1                	li	a7,12
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <pause>:
.global pause
pause:
 li a7, SYS_pause
 3fe:	48b5                	li	a7,13
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 406:	48b9                	li	a7,14
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <bind>:
.global bind
bind:
 li a7, SYS_bind
 40e:	48f5                	li	a7,29
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 416:	48f9                	li	a7,30
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <send>:
.global send
send:
 li a7, SYS_send
 41e:	48fd                	li	a7,31
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <recv>:
.global recv
recv:
 li a7, SYS_recv
 426:	02000893          	li	a7,32
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 430:	02100893          	li	a7,33
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 43a:	02200893          	li	a7,34
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <prac>:
.global prac
prac:
 li a7, SYS_prac
 444:	02300893          	li	a7,35
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 44e:	1101                	addi	sp,sp,-32
 450:	ec06                	sd	ra,24(sp)
 452:	e822                	sd	s0,16(sp)
 454:	1000                	addi	s0,sp,32
 456:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 45a:	4605                	li	a2,1
 45c:	fef40593          	addi	a1,s0,-17
 460:	f2fff0ef          	jal	38e <write>
}
 464:	60e2                	ld	ra,24(sp)
 466:	6442                	ld	s0,16(sp)
 468:	6105                	addi	sp,sp,32
 46a:	8082                	ret

000000000000046c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 46c:	715d                	addi	sp,sp,-80
 46e:	e486                	sd	ra,72(sp)
 470:	e0a2                	sd	s0,64(sp)
 472:	f84a                	sd	s2,48(sp)
 474:	0880                	addi	s0,sp,80
 476:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 478:	c299                	beqz	a3,47e <printint+0x12>
 47a:	0805c363          	bltz	a1,500 <printint+0x94>
  neg = 0;
 47e:	4881                	li	a7,0
 480:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 484:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 486:	00000517          	auipc	a0,0x0
 48a:	5aa50513          	addi	a0,a0,1450 # a30 <digits>
 48e:	883e                	mv	a6,a5
 490:	2785                	addiw	a5,a5,1
 492:	02c5f733          	remu	a4,a1,a2
 496:	972a                	add	a4,a4,a0
 498:	00074703          	lbu	a4,0(a4)
 49c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4a0:	872e                	mv	a4,a1
 4a2:	02c5d5b3          	divu	a1,a1,a2
 4a6:	0685                	addi	a3,a3,1
 4a8:	fec773e3          	bgeu	a4,a2,48e <printint+0x22>
  if(neg)
 4ac:	00088b63          	beqz	a7,4c2 <printint+0x56>
    buf[i++] = '-';
 4b0:	fd078793          	addi	a5,a5,-48
 4b4:	97a2                	add	a5,a5,s0
 4b6:	02d00713          	li	a4,45
 4ba:	fee78423          	sb	a4,-24(a5)
 4be:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4c2:	02f05a63          	blez	a5,4f6 <printint+0x8a>
 4c6:	fc26                	sd	s1,56(sp)
 4c8:	f44e                	sd	s3,40(sp)
 4ca:	fb840713          	addi	a4,s0,-72
 4ce:	00f704b3          	add	s1,a4,a5
 4d2:	fff70993          	addi	s3,a4,-1
 4d6:	99be                	add	s3,s3,a5
 4d8:	37fd                	addiw	a5,a5,-1
 4da:	1782                	slli	a5,a5,0x20
 4dc:	9381                	srli	a5,a5,0x20
 4de:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4e2:	fff4c583          	lbu	a1,-1(s1)
 4e6:	854a                	mv	a0,s2
 4e8:	f67ff0ef          	jal	44e <putc>
  while(--i >= 0)
 4ec:	14fd                	addi	s1,s1,-1
 4ee:	ff349ae3          	bne	s1,s3,4e2 <printint+0x76>
 4f2:	74e2                	ld	s1,56(sp)
 4f4:	79a2                	ld	s3,40(sp)
}
 4f6:	60a6                	ld	ra,72(sp)
 4f8:	6406                	ld	s0,64(sp)
 4fa:	7942                	ld	s2,48(sp)
 4fc:	6161                	addi	sp,sp,80
 4fe:	8082                	ret
    x = -xx;
 500:	40b005b3          	neg	a1,a1
    neg = 1;
 504:	4885                	li	a7,1
    x = -xx;
 506:	bfad                	j	480 <printint+0x14>

0000000000000508 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 508:	711d                	addi	sp,sp,-96
 50a:	ec86                	sd	ra,88(sp)
 50c:	e8a2                	sd	s0,80(sp)
 50e:	e0ca                	sd	s2,64(sp)
 510:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 512:	0005c903          	lbu	s2,0(a1)
 516:	28090663          	beqz	s2,7a2 <vprintf+0x29a>
 51a:	e4a6                	sd	s1,72(sp)
 51c:	fc4e                	sd	s3,56(sp)
 51e:	f852                	sd	s4,48(sp)
 520:	f456                	sd	s5,40(sp)
 522:	f05a                	sd	s6,32(sp)
 524:	ec5e                	sd	s7,24(sp)
 526:	e862                	sd	s8,16(sp)
 528:	e466                	sd	s9,8(sp)
 52a:	8b2a                	mv	s6,a0
 52c:	8a2e                	mv	s4,a1
 52e:	8bb2                	mv	s7,a2
  state = 0;
 530:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 532:	4481                	li	s1,0
 534:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 536:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 53a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 53e:	06c00c93          	li	s9,108
 542:	a005                	j	562 <vprintf+0x5a>
        putc(fd, c0);
 544:	85ca                	mv	a1,s2
 546:	855a                	mv	a0,s6
 548:	f07ff0ef          	jal	44e <putc>
 54c:	a019                	j	552 <vprintf+0x4a>
    } else if(state == '%'){
 54e:	03598263          	beq	s3,s5,572 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 552:	2485                	addiw	s1,s1,1
 554:	8726                	mv	a4,s1
 556:	009a07b3          	add	a5,s4,s1
 55a:	0007c903          	lbu	s2,0(a5)
 55e:	22090a63          	beqz	s2,792 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 562:	0009079b          	sext.w	a5,s2
    if(state == 0){
 566:	fe0994e3          	bnez	s3,54e <vprintf+0x46>
      if(c0 == '%'){
 56a:	fd579de3          	bne	a5,s5,544 <vprintf+0x3c>
        state = '%';
 56e:	89be                	mv	s3,a5
 570:	b7cd                	j	552 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 572:	00ea06b3          	add	a3,s4,a4
 576:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 57a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 57c:	c681                	beqz	a3,584 <vprintf+0x7c>
 57e:	9752                	add	a4,a4,s4
 580:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 584:	05878363          	beq	a5,s8,5ca <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 588:	05978d63          	beq	a5,s9,5e2 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 58c:	07500713          	li	a4,117
 590:	0ee78763          	beq	a5,a4,67e <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 594:	07800713          	li	a4,120
 598:	12e78963          	beq	a5,a4,6ca <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 59c:	07000713          	li	a4,112
 5a0:	14e78e63          	beq	a5,a4,6fc <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5a4:	06300713          	li	a4,99
 5a8:	18e78e63          	beq	a5,a4,744 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ac:	07300713          	li	a4,115
 5b0:	1ae78463          	beq	a5,a4,758 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5b4:	02500713          	li	a4,37
 5b8:	04e79563          	bne	a5,a4,602 <vprintf+0xfa>
        putc(fd, '%');
 5bc:	02500593          	li	a1,37
 5c0:	855a                	mv	a0,s6
 5c2:	e8dff0ef          	jal	44e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5c6:	4981                	li	s3,0
 5c8:	b769                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5ca:	008b8913          	addi	s2,s7,8
 5ce:	4685                	li	a3,1
 5d0:	4629                	li	a2,10
 5d2:	000ba583          	lw	a1,0(s7)
 5d6:	855a                	mv	a0,s6
 5d8:	e95ff0ef          	jal	46c <printint>
 5dc:	8bca                	mv	s7,s2
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	bf8d                	j	552 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5e2:	06400793          	li	a5,100
 5e6:	02f68963          	beq	a3,a5,618 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5ea:	06c00793          	li	a5,108
 5ee:	04f68263          	beq	a3,a5,632 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 5f2:	07500793          	li	a5,117
 5f6:	0af68063          	beq	a3,a5,696 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 5fa:	07800793          	li	a5,120
 5fe:	0ef68263          	beq	a3,a5,6e2 <vprintf+0x1da>
        putc(fd, '%');
 602:	02500593          	li	a1,37
 606:	855a                	mv	a0,s6
 608:	e47ff0ef          	jal	44e <putc>
        putc(fd, c0);
 60c:	85ca                	mv	a1,s2
 60e:	855a                	mv	a0,s6
 610:	e3fff0ef          	jal	44e <putc>
      state = 0;
 614:	4981                	li	s3,0
 616:	bf35                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 618:	008b8913          	addi	s2,s7,8
 61c:	4685                	li	a3,1
 61e:	4629                	li	a2,10
 620:	000bb583          	ld	a1,0(s7)
 624:	855a                	mv	a0,s6
 626:	e47ff0ef          	jal	46c <printint>
        i += 1;
 62a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 62c:	8bca                	mv	s7,s2
      state = 0;
 62e:	4981                	li	s3,0
        i += 1;
 630:	b70d                	j	552 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 632:	06400793          	li	a5,100
 636:	02f60763          	beq	a2,a5,664 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 63a:	07500793          	li	a5,117
 63e:	06f60963          	beq	a2,a5,6b0 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 642:	07800793          	li	a5,120
 646:	faf61ee3          	bne	a2,a5,602 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 64a:	008b8913          	addi	s2,s7,8
 64e:	4681                	li	a3,0
 650:	4641                	li	a2,16
 652:	000bb583          	ld	a1,0(s7)
 656:	855a                	mv	a0,s6
 658:	e15ff0ef          	jal	46c <printint>
        i += 2;
 65c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 65e:	8bca                	mv	s7,s2
      state = 0;
 660:	4981                	li	s3,0
        i += 2;
 662:	bdc5                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 664:	008b8913          	addi	s2,s7,8
 668:	4685                	li	a3,1
 66a:	4629                	li	a2,10
 66c:	000bb583          	ld	a1,0(s7)
 670:	855a                	mv	a0,s6
 672:	dfbff0ef          	jal	46c <printint>
        i += 2;
 676:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 678:	8bca                	mv	s7,s2
      state = 0;
 67a:	4981                	li	s3,0
        i += 2;
 67c:	bdd9                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 67e:	008b8913          	addi	s2,s7,8
 682:	4681                	li	a3,0
 684:	4629                	li	a2,10
 686:	000be583          	lwu	a1,0(s7)
 68a:	855a                	mv	a0,s6
 68c:	de1ff0ef          	jal	46c <printint>
 690:	8bca                	mv	s7,s2
      state = 0;
 692:	4981                	li	s3,0
 694:	bd7d                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 696:	008b8913          	addi	s2,s7,8
 69a:	4681                	li	a3,0
 69c:	4629                	li	a2,10
 69e:	000bb583          	ld	a1,0(s7)
 6a2:	855a                	mv	a0,s6
 6a4:	dc9ff0ef          	jal	46c <printint>
        i += 1;
 6a8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6aa:	8bca                	mv	s7,s2
      state = 0;
 6ac:	4981                	li	s3,0
        i += 1;
 6ae:	b555                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b0:	008b8913          	addi	s2,s7,8
 6b4:	4681                	li	a3,0
 6b6:	4629                	li	a2,10
 6b8:	000bb583          	ld	a1,0(s7)
 6bc:	855a                	mv	a0,s6
 6be:	dafff0ef          	jal	46c <printint>
        i += 2;
 6c2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c4:	8bca                	mv	s7,s2
      state = 0;
 6c6:	4981                	li	s3,0
        i += 2;
 6c8:	b569                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6ca:	008b8913          	addi	s2,s7,8
 6ce:	4681                	li	a3,0
 6d0:	4641                	li	a2,16
 6d2:	000be583          	lwu	a1,0(s7)
 6d6:	855a                	mv	a0,s6
 6d8:	d95ff0ef          	jal	46c <printint>
 6dc:	8bca                	mv	s7,s2
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	bd8d                	j	552 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e2:	008b8913          	addi	s2,s7,8
 6e6:	4681                	li	a3,0
 6e8:	4641                	li	a2,16
 6ea:	000bb583          	ld	a1,0(s7)
 6ee:	855a                	mv	a0,s6
 6f0:	d7dff0ef          	jal	46c <printint>
        i += 1;
 6f4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f6:	8bca                	mv	s7,s2
      state = 0;
 6f8:	4981                	li	s3,0
        i += 1;
 6fa:	bda1                	j	552 <vprintf+0x4a>
 6fc:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6fe:	008b8d13          	addi	s10,s7,8
 702:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 706:	03000593          	li	a1,48
 70a:	855a                	mv	a0,s6
 70c:	d43ff0ef          	jal	44e <putc>
  putc(fd, 'x');
 710:	07800593          	li	a1,120
 714:	855a                	mv	a0,s6
 716:	d39ff0ef          	jal	44e <putc>
 71a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71c:	00000b97          	auipc	s7,0x0
 720:	314b8b93          	addi	s7,s7,788 # a30 <digits>
 724:	03c9d793          	srli	a5,s3,0x3c
 728:	97de                	add	a5,a5,s7
 72a:	0007c583          	lbu	a1,0(a5)
 72e:	855a                	mv	a0,s6
 730:	d1fff0ef          	jal	44e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 734:	0992                	slli	s3,s3,0x4
 736:	397d                	addiw	s2,s2,-1
 738:	fe0916e3          	bnez	s2,724 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 73c:	8bea                	mv	s7,s10
      state = 0;
 73e:	4981                	li	s3,0
 740:	6d02                	ld	s10,0(sp)
 742:	bd01                	j	552 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 744:	008b8913          	addi	s2,s7,8
 748:	000bc583          	lbu	a1,0(s7)
 74c:	855a                	mv	a0,s6
 74e:	d01ff0ef          	jal	44e <putc>
 752:	8bca                	mv	s7,s2
      state = 0;
 754:	4981                	li	s3,0
 756:	bbf5                	j	552 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 758:	008b8993          	addi	s3,s7,8
 75c:	000bb903          	ld	s2,0(s7)
 760:	00090f63          	beqz	s2,77e <vprintf+0x276>
        for(; *s; s++)
 764:	00094583          	lbu	a1,0(s2)
 768:	c195                	beqz	a1,78c <vprintf+0x284>
          putc(fd, *s);
 76a:	855a                	mv	a0,s6
 76c:	ce3ff0ef          	jal	44e <putc>
        for(; *s; s++)
 770:	0905                	addi	s2,s2,1
 772:	00094583          	lbu	a1,0(s2)
 776:	f9f5                	bnez	a1,76a <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 778:	8bce                	mv	s7,s3
      state = 0;
 77a:	4981                	li	s3,0
 77c:	bbd9                	j	552 <vprintf+0x4a>
          s = "(null)";
 77e:	00000917          	auipc	s2,0x0
 782:	2aa90913          	addi	s2,s2,682 # a28 <malloc+0x19e>
        for(; *s; s++)
 786:	02800593          	li	a1,40
 78a:	b7c5                	j	76a <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 78c:	8bce                	mv	s7,s3
      state = 0;
 78e:	4981                	li	s3,0
 790:	b3c9                	j	552 <vprintf+0x4a>
 792:	64a6                	ld	s1,72(sp)
 794:	79e2                	ld	s3,56(sp)
 796:	7a42                	ld	s4,48(sp)
 798:	7aa2                	ld	s5,40(sp)
 79a:	7b02                	ld	s6,32(sp)
 79c:	6be2                	ld	s7,24(sp)
 79e:	6c42                	ld	s8,16(sp)
 7a0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7a2:	60e6                	ld	ra,88(sp)
 7a4:	6446                	ld	s0,80(sp)
 7a6:	6906                	ld	s2,64(sp)
 7a8:	6125                	addi	sp,sp,96
 7aa:	8082                	ret

00000000000007ac <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ac:	715d                	addi	sp,sp,-80
 7ae:	ec06                	sd	ra,24(sp)
 7b0:	e822                	sd	s0,16(sp)
 7b2:	1000                	addi	s0,sp,32
 7b4:	e010                	sd	a2,0(s0)
 7b6:	e414                	sd	a3,8(s0)
 7b8:	e818                	sd	a4,16(s0)
 7ba:	ec1c                	sd	a5,24(s0)
 7bc:	03043023          	sd	a6,32(s0)
 7c0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7c4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c8:	8622                	mv	a2,s0
 7ca:	d3fff0ef          	jal	508 <vprintf>
}
 7ce:	60e2                	ld	ra,24(sp)
 7d0:	6442                	ld	s0,16(sp)
 7d2:	6161                	addi	sp,sp,80
 7d4:	8082                	ret

00000000000007d6 <printf>:

void
printf(const char *fmt, ...)
{
 7d6:	711d                	addi	sp,sp,-96
 7d8:	ec06                	sd	ra,24(sp)
 7da:	e822                	sd	s0,16(sp)
 7dc:	1000                	addi	s0,sp,32
 7de:	e40c                	sd	a1,8(s0)
 7e0:	e810                	sd	a2,16(s0)
 7e2:	ec14                	sd	a3,24(s0)
 7e4:	f018                	sd	a4,32(s0)
 7e6:	f41c                	sd	a5,40(s0)
 7e8:	03043823          	sd	a6,48(s0)
 7ec:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7f0:	00840613          	addi	a2,s0,8
 7f4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f8:	85aa                	mv	a1,a0
 7fa:	4505                	li	a0,1
 7fc:	d0dff0ef          	jal	508 <vprintf>
}
 800:	60e2                	ld	ra,24(sp)
 802:	6442                	ld	s0,16(sp)
 804:	6125                	addi	sp,sp,96
 806:	8082                	ret

0000000000000808 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 808:	1141                	addi	sp,sp,-16
 80a:	e422                	sd	s0,8(sp)
 80c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 812:	00000797          	auipc	a5,0x0
 816:	7ee7b783          	ld	a5,2030(a5) # 1000 <freep>
 81a:	a02d                	j	844 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 81c:	4618                	lw	a4,8(a2)
 81e:	9f2d                	addw	a4,a4,a1
 820:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 824:	6398                	ld	a4,0(a5)
 826:	6310                	ld	a2,0(a4)
 828:	a83d                	j	866 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 82a:	ff852703          	lw	a4,-8(a0)
 82e:	9f31                	addw	a4,a4,a2
 830:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 832:	ff053683          	ld	a3,-16(a0)
 836:	a091                	j	87a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 838:	6398                	ld	a4,0(a5)
 83a:	00e7e463          	bltu	a5,a4,842 <free+0x3a>
 83e:	00e6ea63          	bltu	a3,a4,852 <free+0x4a>
{
 842:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 844:	fed7fae3          	bgeu	a5,a3,838 <free+0x30>
 848:	6398                	ld	a4,0(a5)
 84a:	00e6e463          	bltu	a3,a4,852 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84e:	fee7eae3          	bltu	a5,a4,842 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 852:	ff852583          	lw	a1,-8(a0)
 856:	6390                	ld	a2,0(a5)
 858:	02059813          	slli	a6,a1,0x20
 85c:	01c85713          	srli	a4,a6,0x1c
 860:	9736                	add	a4,a4,a3
 862:	fae60de3          	beq	a2,a4,81c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 866:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 86a:	4790                	lw	a2,8(a5)
 86c:	02061593          	slli	a1,a2,0x20
 870:	01c5d713          	srli	a4,a1,0x1c
 874:	973e                	add	a4,a4,a5
 876:	fae68ae3          	beq	a3,a4,82a <free+0x22>
    p->s.ptr = bp->s.ptr;
 87a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 87c:	00000717          	auipc	a4,0x0
 880:	78f73223          	sd	a5,1924(a4) # 1000 <freep>
}
 884:	6422                	ld	s0,8(sp)
 886:	0141                	addi	sp,sp,16
 888:	8082                	ret

000000000000088a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 88a:	7139                	addi	sp,sp,-64
 88c:	fc06                	sd	ra,56(sp)
 88e:	f822                	sd	s0,48(sp)
 890:	f426                	sd	s1,40(sp)
 892:	ec4e                	sd	s3,24(sp)
 894:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 896:	02051493          	slli	s1,a0,0x20
 89a:	9081                	srli	s1,s1,0x20
 89c:	04bd                	addi	s1,s1,15
 89e:	8091                	srli	s1,s1,0x4
 8a0:	0014899b          	addiw	s3,s1,1
 8a4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8a6:	00000517          	auipc	a0,0x0
 8aa:	75a53503          	ld	a0,1882(a0) # 1000 <freep>
 8ae:	c915                	beqz	a0,8e2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b2:	4798                	lw	a4,8(a5)
 8b4:	08977a63          	bgeu	a4,s1,948 <malloc+0xbe>
 8b8:	f04a                	sd	s2,32(sp)
 8ba:	e852                	sd	s4,16(sp)
 8bc:	e456                	sd	s5,8(sp)
 8be:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8c0:	8a4e                	mv	s4,s3
 8c2:	0009871b          	sext.w	a4,s3
 8c6:	6685                	lui	a3,0x1
 8c8:	00d77363          	bgeu	a4,a3,8ce <malloc+0x44>
 8cc:	6a05                	lui	s4,0x1
 8ce:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8d2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8d6:	00000917          	auipc	s2,0x0
 8da:	72a90913          	addi	s2,s2,1834 # 1000 <freep>
  if(p == SBRK_ERROR)
 8de:	5afd                	li	s5,-1
 8e0:	a081                	j	920 <malloc+0x96>
 8e2:	f04a                	sd	s2,32(sp)
 8e4:	e852                	sd	s4,16(sp)
 8e6:	e456                	sd	s5,8(sp)
 8e8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ea:	00001797          	auipc	a5,0x1
 8ee:	91e78793          	addi	a5,a5,-1762 # 1208 <base>
 8f2:	00000717          	auipc	a4,0x0
 8f6:	70f73723          	sd	a5,1806(a4) # 1000 <freep>
 8fa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8fc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 900:	b7c1                	j	8c0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 902:	6398                	ld	a4,0(a5)
 904:	e118                	sd	a4,0(a0)
 906:	a8a9                	j	960 <malloc+0xd6>
  hp->s.size = nu;
 908:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 90c:	0541                	addi	a0,a0,16
 90e:	efbff0ef          	jal	808 <free>
  return freep;
 912:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 916:	c12d                	beqz	a0,978 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91a:	4798                	lw	a4,8(a5)
 91c:	02977263          	bgeu	a4,s1,940 <malloc+0xb6>
    if(p == freep)
 920:	00093703          	ld	a4,0(s2)
 924:	853e                	mv	a0,a5
 926:	fef719e3          	bne	a4,a5,918 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 92a:	8552                	mv	a0,s4
 92c:	9f9ff0ef          	jal	324 <sbrk>
  if(p == SBRK_ERROR)
 930:	fd551ce3          	bne	a0,s5,908 <malloc+0x7e>
        return 0;
 934:	4501                	li	a0,0
 936:	7902                	ld	s2,32(sp)
 938:	6a42                	ld	s4,16(sp)
 93a:	6aa2                	ld	s5,8(sp)
 93c:	6b02                	ld	s6,0(sp)
 93e:	a03d                	j	96c <malloc+0xe2>
 940:	7902                	ld	s2,32(sp)
 942:	6a42                	ld	s4,16(sp)
 944:	6aa2                	ld	s5,8(sp)
 946:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 948:	fae48de3          	beq	s1,a4,902 <malloc+0x78>
        p->s.size -= nunits;
 94c:	4137073b          	subw	a4,a4,s3
 950:	c798                	sw	a4,8(a5)
        p += p->s.size;
 952:	02071693          	slli	a3,a4,0x20
 956:	01c6d713          	srli	a4,a3,0x1c
 95a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 95c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 960:	00000717          	auipc	a4,0x0
 964:	6aa73023          	sd	a0,1696(a4) # 1000 <freep>
      return (void*)(p + 1);
 968:	01078513          	addi	a0,a5,16
  }
}
 96c:	70e2                	ld	ra,56(sp)
 96e:	7442                	ld	s0,48(sp)
 970:	74a2                	ld	s1,40(sp)
 972:	69e2                	ld	s3,24(sp)
 974:	6121                	addi	sp,sp,64
 976:	8082                	ret
 978:	7902                	ld	s2,32(sp)
 97a:	6a42                	ld	s4,16(sp)
 97c:	6aa2                	ld	s5,8(sp)
 97e:	6b02                	ld	s6,0(sp)
 980:	b7f5                	j	96c <malloc+0xe2>
