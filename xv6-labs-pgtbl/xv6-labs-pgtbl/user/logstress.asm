
user/_logstress:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
main(int argc, char **argv)
{
  int fd, n;
  enum { N = 250, SZ=2000 };
  
  for (int i = 1; i < argc; i++){
   0:	4785                	li	a5,1
   2:	0ea7df63          	bge	a5,a0,100 <main+0x100>
{
   6:	7139                	addi	sp,sp,-64
   8:	fc06                	sd	ra,56(sp)
   a:	f822                	sd	s0,48(sp)
   c:	f426                	sd	s1,40(sp)
   e:	f04a                	sd	s2,32(sp)
  10:	ec4e                	sd	s3,24(sp)
  12:	0080                	addi	s0,sp,64
  14:	892a                	mv	s2,a0
  16:	89ae                	mv	s3,a1
  for (int i = 1; i < argc; i++){
  18:	4485                	li	s1,1
  1a:	a011                	j	1e <main+0x1e>
  1c:	84be                	mv	s1,a5
    int pid1 = fork();
  1e:	388000ef          	jal	3a6 <fork>
    if(pid1 < 0){
  22:	00054963          	bltz	a0,34 <main+0x34>
      printf("%s: fork failed\n", argv[0]);
      exit(1);
    }
    if(pid1 == 0) {
  26:	c11d                	beqz	a0,4c <main+0x4c>
  for (int i = 1; i < argc; i++){
  28:	0014879b          	addiw	a5,s1,1
  2c:	fef918e3          	bne	s2,a5,1c <main+0x1c>
      }
      exit(0);
    }
  }
  int xstatus;
  for(int i = 1; i < argc; i++){
  30:	4905                	li	s2,1
  32:	a04d                	j	d4 <main+0xd4>
  34:	e852                	sd	s4,16(sp)
      printf("%s: fork failed\n", argv[0]);
  36:	0009b583          	ld	a1,0(s3)
  3a:	00001517          	auipc	a0,0x1
  3e:	99650513          	addi	a0,a0,-1642 # 9d0 <malloc+0x106>
  42:	7d4000ef          	jal	816 <printf>
      exit(1);
  46:	4505                	li	a0,1
  48:	366000ef          	jal	3ae <exit>
  4c:	e852                	sd	s4,16(sp)
      fd = open(argv[i], O_CREATE | O_RDWR);
  4e:	00349a13          	slli	s4,s1,0x3
  52:	9a4e                	add	s4,s4,s3
  54:	20200593          	li	a1,514
  58:	000a3503          	ld	a0,0(s4)
  5c:	392000ef          	jal	3ee <open>
  60:	892a                	mv	s2,a0
      if(fd < 0){
  62:	04054163          	bltz	a0,a4 <main+0xa4>
      memset(buf, '0'+i, SZ);
  66:	7d000613          	li	a2,2000
  6a:	0304859b          	addiw	a1,s1,48
  6e:	00001517          	auipc	a0,0x1
  72:	fa250513          	addi	a0,a0,-94 # 1010 <buf>
  76:	110000ef          	jal	186 <memset>
  7a:	0fa00493          	li	s1,250
        if((n = write(fd, buf, SZ)) != SZ){
  7e:	00001997          	auipc	s3,0x1
  82:	f9298993          	addi	s3,s3,-110 # 1010 <buf>
  86:	7d000613          	li	a2,2000
  8a:	85ce                	mv	a1,s3
  8c:	854a                	mv	a0,s2
  8e:	340000ef          	jal	3ce <write>
  92:	7d000793          	li	a5,2000
  96:	02f51463          	bne	a0,a5,be <main+0xbe>
      for(i = 0; i < N; i++){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f4ed                	bnez	s1,86 <main+0x86>
      exit(0);
  9e:	4501                	li	a0,0
  a0:	30e000ef          	jal	3ae <exit>
        printf("%s: create %s failed\n", argv[0], argv[i]);
  a4:	000a3603          	ld	a2,0(s4)
  a8:	0009b583          	ld	a1,0(s3)
  ac:	00001517          	auipc	a0,0x1
  b0:	93c50513          	addi	a0,a0,-1732 # 9e8 <malloc+0x11e>
  b4:	762000ef          	jal	816 <printf>
        exit(1);
  b8:	4505                	li	a0,1
  ba:	2f4000ef          	jal	3ae <exit>
          printf("write failed %d\n", n);
  be:	85aa                	mv	a1,a0
  c0:	00001517          	auipc	a0,0x1
  c4:	94050513          	addi	a0,a0,-1728 # a00 <malloc+0x136>
  c8:	74e000ef          	jal	816 <printf>
          exit(1);
  cc:	4505                	li	a0,1
  ce:	2e0000ef          	jal	3ae <exit>
  d2:	893e                	mv	s2,a5
    wait(&xstatus);
  d4:	fcc40513          	addi	a0,s0,-52
  d8:	2de000ef          	jal	3b6 <wait>
    if(xstatus != 0)
  dc:	fcc42503          	lw	a0,-52(s0)
  e0:	ed09                	bnez	a0,fa <main+0xfa>
  for(int i = 1; i < argc; i++){
  e2:	0019079b          	addiw	a5,s2,1
  e6:	ff2496e3          	bne	s1,s2,d2 <main+0xd2>
      exit(xstatus);
  }
  return 0;
}
  ea:	4501                	li	a0,0
  ec:	70e2                	ld	ra,56(sp)
  ee:	7442                	ld	s0,48(sp)
  f0:	74a2                	ld	s1,40(sp)
  f2:	7902                	ld	s2,32(sp)
  f4:	69e2                	ld	s3,24(sp)
  f6:	6121                	addi	sp,sp,64
  f8:	8082                	ret
  fa:	e852                	sd	s4,16(sp)
      exit(xstatus);
  fc:	2b2000ef          	jal	3ae <exit>
}
 100:	4501                	li	a0,0
 102:	8082                	ret

0000000000000104 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 10c:	ef5ff0ef          	jal	0 <main>
  exit(r);
 110:	29e000ef          	jal	3ae <exit>

0000000000000114 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0x8>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cb91                	beqz	a5,14e <strcmp+0x1e>
 13c:	0005c703          	lbu	a4,0(a1)
 140:	00f71763          	bne	a4,a5,14e <strcmp+0x1e>
    p++, q++;
 144:	0505                	addi	a0,a0,1
 146:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	fbe5                	bnez	a5,13c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14e:	0005c503          	lbu	a0,0(a1)
}
 152:	40a7853b          	subw	a0,a5,a0
 156:	6422                	ld	s0,8(sp)
 158:	0141                	addi	sp,sp,16
 15a:	8082                	ret

000000000000015c <strlen>:

uint
strlen(const char *s)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 162:	00054783          	lbu	a5,0(a0)
 166:	cf91                	beqz	a5,182 <strlen+0x26>
 168:	0505                	addi	a0,a0,1
 16a:	87aa                	mv	a5,a0
 16c:	86be                	mv	a3,a5
 16e:	0785                	addi	a5,a5,1
 170:	fff7c703          	lbu	a4,-1(a5)
 174:	ff65                	bnez	a4,16c <strlen+0x10>
 176:	40a6853b          	subw	a0,a3,a0
 17a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  for(n = 0; s[n]; n++)
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strlen+0x20>

0000000000000186 <memset>:

void*
memset(void *dst, int c, uint n)
{
 186:	1141                	addi	sp,sp,-16
 188:	e422                	sd	s0,8(sp)
 18a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18c:	ca19                	beqz	a2,1a2 <memset+0x1c>
 18e:	87aa                	mv	a5,a0
 190:	1602                	slli	a2,a2,0x20
 192:	9201                	srli	a2,a2,0x20
 194:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 198:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19c:	0785                	addi	a5,a5,1
 19e:	fee79de3          	bne	a5,a4,198 <memset+0x12>
  }
  return dst;
}
 1a2:	6422                	ld	s0,8(sp)
 1a4:	0141                	addi	sp,sp,16
 1a6:	8082                	ret

00000000000001a8 <strchr>:

char*
strchr(const char *s, char c)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ae:	00054783          	lbu	a5,0(a0)
 1b2:	cb99                	beqz	a5,1c8 <strchr+0x20>
    if(*s == c)
 1b4:	00f58763          	beq	a1,a5,1c2 <strchr+0x1a>
  for(; *s; s++)
 1b8:	0505                	addi	a0,a0,1
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	fbfd                	bnez	a5,1b4 <strchr+0xc>
      return (char*)s;
  return 0;
 1c0:	4501                	li	a0,0
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret
  return 0;
 1c8:	4501                	li	a0,0
 1ca:	bfe5                	j	1c2 <strchr+0x1a>

00000000000001cc <gets>:

char*
gets(char *buf, int max)
{
 1cc:	711d                	addi	sp,sp,-96
 1ce:	ec86                	sd	ra,88(sp)
 1d0:	e8a2                	sd	s0,80(sp)
 1d2:	e4a6                	sd	s1,72(sp)
 1d4:	e0ca                	sd	s2,64(sp)
 1d6:	fc4e                	sd	s3,56(sp)
 1d8:	f852                	sd	s4,48(sp)
 1da:	f456                	sd	s5,40(sp)
 1dc:	f05a                	sd	s6,32(sp)
 1de:	ec5e                	sd	s7,24(sp)
 1e0:	1080                	addi	s0,sp,96
 1e2:	8baa                	mv	s7,a0
 1e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	892a                	mv	s2,a0
 1e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ea:	4aa9                	li	s5,10
 1ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ee:	89a6                	mv	s3,s1
 1f0:	2485                	addiw	s1,s1,1
 1f2:	0344d663          	bge	s1,s4,21e <gets+0x52>
    cc = read(0, &c, 1);
 1f6:	4605                	li	a2,1
 1f8:	faf40593          	addi	a1,s0,-81
 1fc:	4501                	li	a0,0
 1fe:	1c8000ef          	jal	3c6 <read>
    if(cc < 1)
 202:	00a05e63          	blez	a0,21e <gets+0x52>
    buf[i++] = c;
 206:	faf44783          	lbu	a5,-81(s0)
 20a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 20e:	01578763          	beq	a5,s5,21c <gets+0x50>
 212:	0905                	addi	s2,s2,1
 214:	fd679de3          	bne	a5,s6,1ee <gets+0x22>
    buf[i++] = c;
 218:	89a6                	mv	s3,s1
 21a:	a011                	j	21e <gets+0x52>
 21c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 21e:	99de                	add	s3,s3,s7
 220:	00098023          	sb	zero,0(s3)
  return buf;
}
 224:	855e                	mv	a0,s7
 226:	60e6                	ld	ra,88(sp)
 228:	6446                	ld	s0,80(sp)
 22a:	64a6                	ld	s1,72(sp)
 22c:	6906                	ld	s2,64(sp)
 22e:	79e2                	ld	s3,56(sp)
 230:	7a42                	ld	s4,48(sp)
 232:	7aa2                	ld	s5,40(sp)
 234:	7b02                	ld	s6,32(sp)
 236:	6be2                	ld	s7,24(sp)
 238:	6125                	addi	sp,sp,96
 23a:	8082                	ret

000000000000023c <stat>:

int
stat(const char *n, struct stat *st)
{
 23c:	1101                	addi	sp,sp,-32
 23e:	ec06                	sd	ra,24(sp)
 240:	e822                	sd	s0,16(sp)
 242:	e04a                	sd	s2,0(sp)
 244:	1000                	addi	s0,sp,32
 246:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 248:	4581                	li	a1,0
 24a:	1a4000ef          	jal	3ee <open>
  if(fd < 0)
 24e:	02054263          	bltz	a0,272 <stat+0x36>
 252:	e426                	sd	s1,8(sp)
 254:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 256:	85ca                	mv	a1,s2
 258:	1ae000ef          	jal	406 <fstat>
 25c:	892a                	mv	s2,a0
  close(fd);
 25e:	8526                	mv	a0,s1
 260:	176000ef          	jal	3d6 <close>
  return r;
 264:	64a2                	ld	s1,8(sp)
}
 266:	854a                	mv	a0,s2
 268:	60e2                	ld	ra,24(sp)
 26a:	6442                	ld	s0,16(sp)
 26c:	6902                	ld	s2,0(sp)
 26e:	6105                	addi	sp,sp,32
 270:	8082                	ret
    return -1;
 272:	597d                	li	s2,-1
 274:	bfcd                	j	266 <stat+0x2a>

0000000000000276 <atoi>:

int
atoi(const char *s)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27c:	00054683          	lbu	a3,0(a0)
 280:	fd06879b          	addiw	a5,a3,-48
 284:	0ff7f793          	zext.b	a5,a5
 288:	4625                	li	a2,9
 28a:	02f66863          	bltu	a2,a5,2ba <atoi+0x44>
 28e:	872a                	mv	a4,a0
  n = 0;
 290:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 292:	0705                	addi	a4,a4,1
 294:	0025179b          	slliw	a5,a0,0x2
 298:	9fa9                	addw	a5,a5,a0
 29a:	0017979b          	slliw	a5,a5,0x1
 29e:	9fb5                	addw	a5,a5,a3
 2a0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2a4:	00074683          	lbu	a3,0(a4)
 2a8:	fd06879b          	addiw	a5,a3,-48
 2ac:	0ff7f793          	zext.b	a5,a5
 2b0:	fef671e3          	bgeu	a2,a5,292 <atoi+0x1c>
  return n;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  n = 0;
 2ba:	4501                	li	a0,0
 2bc:	bfe5                	j	2b4 <atoi+0x3e>

00000000000002be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2c4:	02b57463          	bgeu	a0,a1,2ec <memmove+0x2e>
    while(n-- > 0)
 2c8:	00c05f63          	blez	a2,2e6 <memmove+0x28>
 2cc:	1602                	slli	a2,a2,0x20
 2ce:	9201                	srli	a2,a2,0x20
 2d0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2d4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d6:	0585                	addi	a1,a1,1
 2d8:	0705                	addi	a4,a4,1
 2da:	fff5c683          	lbu	a3,-1(a1)
 2de:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2e2:	fef71ae3          	bne	a4,a5,2d6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
    dst += n;
 2ec:	00c50733          	add	a4,a0,a2
    src += n;
 2f0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2f2:	fec05ae3          	blez	a2,2e6 <memmove+0x28>
 2f6:	fff6079b          	addiw	a5,a2,-1
 2fa:	1782                	slli	a5,a5,0x20
 2fc:	9381                	srli	a5,a5,0x20
 2fe:	fff7c793          	not	a5,a5
 302:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 304:	15fd                	addi	a1,a1,-1
 306:	177d                	addi	a4,a4,-1
 308:	0005c683          	lbu	a3,0(a1)
 30c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 310:	fee79ae3          	bne	a5,a4,304 <memmove+0x46>
 314:	bfc9                	j	2e6 <memmove+0x28>

0000000000000316 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 316:	1141                	addi	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 31c:	ca05                	beqz	a2,34c <memcmp+0x36>
 31e:	fff6069b          	addiw	a3,a2,-1
 322:	1682                	slli	a3,a3,0x20
 324:	9281                	srli	a3,a3,0x20
 326:	0685                	addi	a3,a3,1
 328:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 32a:	00054783          	lbu	a5,0(a0)
 32e:	0005c703          	lbu	a4,0(a1)
 332:	00e79863          	bne	a5,a4,342 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 336:	0505                	addi	a0,a0,1
    p2++;
 338:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 33a:	fed518e3          	bne	a0,a3,32a <memcmp+0x14>
  }
  return 0;
 33e:	4501                	li	a0,0
 340:	a019                	j	346 <memcmp+0x30>
      return *p1 - *p2;
 342:	40e7853b          	subw	a0,a5,a4
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
  return 0;
 34c:	4501                	li	a0,0
 34e:	bfe5                	j	346 <memcmp+0x30>

0000000000000350 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e406                	sd	ra,8(sp)
 354:	e022                	sd	s0,0(sp)
 356:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 358:	f67ff0ef          	jal	2be <memmove>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <sbrk>:

char *
sbrk(int n) {
 364:	1141                	addi	sp,sp,-16
 366:	e406                	sd	ra,8(sp)
 368:	e022                	sd	s0,0(sp)
 36a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 36c:	4585                	li	a1,1
 36e:	0c8000ef          	jal	436 <sys_sbrk>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <sbrklazy>:

char *
sbrklazy(int n) {
 37a:	1141                	addi	sp,sp,-16
 37c:	e406                	sd	ra,8(sp)
 37e:	e022                	sd	s0,0(sp)
 380:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 382:	4589                	li	a1,2
 384:	0b2000ef          	jal	436 <sys_sbrk>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 390:	1141                	addi	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 396:	040007b7          	lui	a5,0x4000
 39a:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffedf5>
 39c:	07b2                	slli	a5,a5,0xc
}
 39e:	4388                	lw	a0,0(a5)
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret

00000000000003a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a6:	4885                	li	a7,1
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ae:	4889                	li	a7,2
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b6:	488d                	li	a7,3
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3be:	4891                	li	a7,4
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <read>:
.global read
read:
 li a7, SYS_read
 3c6:	4895                	li	a7,5
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <write>:
.global write
write:
 li a7, SYS_write
 3ce:	48c1                	li	a7,16
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <close>:
.global close
close:
 li a7, SYS_close
 3d6:	48d5                	li	a7,21
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <kill>:
.global kill
kill:
 li a7, SYS_kill
 3de:	4899                	li	a7,6
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e6:	489d                	li	a7,7
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <open>:
.global open
open:
 li a7, SYS_open
 3ee:	48bd                	li	a7,15
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f6:	48c5                	li	a7,17
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3fe:	48c9                	li	a7,18
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 406:	48a1                	li	a7,8
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <link>:
.global link
link:
 li a7, SYS_link
 40e:	48cd                	li	a7,19
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 416:	48d1                	li	a7,20
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 41e:	48a5                	li	a7,9
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <dup>:
.global dup
dup:
 li a7, SYS_dup
 426:	48a9                	li	a7,10
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 42e:	48ad                	li	a7,11
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 436:	48b1                	li	a7,12
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <pause>:
.global pause
pause:
 li a7, SYS_pause
 43e:	48b5                	li	a7,13
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 446:	48b9                	li	a7,14
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <bind>:
.global bind
bind:
 li a7, SYS_bind
 44e:	48f5                	li	a7,29
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 456:	48f9                	li	a7,30
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <send>:
.global send
send:
 li a7, SYS_send
 45e:	48fd                	li	a7,31
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <recv>:
.global recv
recv:
 li a7, SYS_recv
 466:	02000893          	li	a7,32
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 470:	02100893          	li	a7,33
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 47a:	02200893          	li	a7,34
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <prac>:
.global prac
prac:
 li a7, SYS_prac
 484:	02300893          	li	a7,35
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 48e:	1101                	addi	sp,sp,-32
 490:	ec06                	sd	ra,24(sp)
 492:	e822                	sd	s0,16(sp)
 494:	1000                	addi	s0,sp,32
 496:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 49a:	4605                	li	a2,1
 49c:	fef40593          	addi	a1,s0,-17
 4a0:	f2fff0ef          	jal	3ce <write>
}
 4a4:	60e2                	ld	ra,24(sp)
 4a6:	6442                	ld	s0,16(sp)
 4a8:	6105                	addi	sp,sp,32
 4aa:	8082                	ret

00000000000004ac <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4ac:	715d                	addi	sp,sp,-80
 4ae:	e486                	sd	ra,72(sp)
 4b0:	e0a2                	sd	s0,64(sp)
 4b2:	f84a                	sd	s2,48(sp)
 4b4:	0880                	addi	s0,sp,80
 4b6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4b8:	c299                	beqz	a3,4be <printint+0x12>
 4ba:	0805c363          	bltz	a1,540 <printint+0x94>
  neg = 0;
 4be:	4881                	li	a7,0
 4c0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4c4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4c6:	00000517          	auipc	a0,0x0
 4ca:	55a50513          	addi	a0,a0,1370 # a20 <digits>
 4ce:	883e                	mv	a6,a5
 4d0:	2785                	addiw	a5,a5,1
 4d2:	02c5f733          	remu	a4,a1,a2
 4d6:	972a                	add	a4,a4,a0
 4d8:	00074703          	lbu	a4,0(a4)
 4dc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4e0:	872e                	mv	a4,a1
 4e2:	02c5d5b3          	divu	a1,a1,a2
 4e6:	0685                	addi	a3,a3,1
 4e8:	fec773e3          	bgeu	a4,a2,4ce <printint+0x22>
  if(neg)
 4ec:	00088b63          	beqz	a7,502 <printint+0x56>
    buf[i++] = '-';
 4f0:	fd078793          	addi	a5,a5,-48
 4f4:	97a2                	add	a5,a5,s0
 4f6:	02d00713          	li	a4,45
 4fa:	fee78423          	sb	a4,-24(a5)
 4fe:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 502:	02f05a63          	blez	a5,536 <printint+0x8a>
 506:	fc26                	sd	s1,56(sp)
 508:	f44e                	sd	s3,40(sp)
 50a:	fb840713          	addi	a4,s0,-72
 50e:	00f704b3          	add	s1,a4,a5
 512:	fff70993          	addi	s3,a4,-1
 516:	99be                	add	s3,s3,a5
 518:	37fd                	addiw	a5,a5,-1
 51a:	1782                	slli	a5,a5,0x20
 51c:	9381                	srli	a5,a5,0x20
 51e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 522:	fff4c583          	lbu	a1,-1(s1)
 526:	854a                	mv	a0,s2
 528:	f67ff0ef          	jal	48e <putc>
  while(--i >= 0)
 52c:	14fd                	addi	s1,s1,-1
 52e:	ff349ae3          	bne	s1,s3,522 <printint+0x76>
 532:	74e2                	ld	s1,56(sp)
 534:	79a2                	ld	s3,40(sp)
}
 536:	60a6                	ld	ra,72(sp)
 538:	6406                	ld	s0,64(sp)
 53a:	7942                	ld	s2,48(sp)
 53c:	6161                	addi	sp,sp,80
 53e:	8082                	ret
    x = -xx;
 540:	40b005b3          	neg	a1,a1
    neg = 1;
 544:	4885                	li	a7,1
    x = -xx;
 546:	bfad                	j	4c0 <printint+0x14>

0000000000000548 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 548:	711d                	addi	sp,sp,-96
 54a:	ec86                	sd	ra,88(sp)
 54c:	e8a2                	sd	s0,80(sp)
 54e:	e0ca                	sd	s2,64(sp)
 550:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 552:	0005c903          	lbu	s2,0(a1)
 556:	28090663          	beqz	s2,7e2 <vprintf+0x29a>
 55a:	e4a6                	sd	s1,72(sp)
 55c:	fc4e                	sd	s3,56(sp)
 55e:	f852                	sd	s4,48(sp)
 560:	f456                	sd	s5,40(sp)
 562:	f05a                	sd	s6,32(sp)
 564:	ec5e                	sd	s7,24(sp)
 566:	e862                	sd	s8,16(sp)
 568:	e466                	sd	s9,8(sp)
 56a:	8b2a                	mv	s6,a0
 56c:	8a2e                	mv	s4,a1
 56e:	8bb2                	mv	s7,a2
  state = 0;
 570:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 572:	4481                	li	s1,0
 574:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 576:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 57a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 57e:	06c00c93          	li	s9,108
 582:	a005                	j	5a2 <vprintf+0x5a>
        putc(fd, c0);
 584:	85ca                	mv	a1,s2
 586:	855a                	mv	a0,s6
 588:	f07ff0ef          	jal	48e <putc>
 58c:	a019                	j	592 <vprintf+0x4a>
    } else if(state == '%'){
 58e:	03598263          	beq	s3,s5,5b2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 592:	2485                	addiw	s1,s1,1
 594:	8726                	mv	a4,s1
 596:	009a07b3          	add	a5,s4,s1
 59a:	0007c903          	lbu	s2,0(a5)
 59e:	22090a63          	beqz	s2,7d2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5a6:	fe0994e3          	bnez	s3,58e <vprintf+0x46>
      if(c0 == '%'){
 5aa:	fd579de3          	bne	a5,s5,584 <vprintf+0x3c>
        state = '%';
 5ae:	89be                	mv	s3,a5
 5b0:	b7cd                	j	592 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5b2:	00ea06b3          	add	a3,s4,a4
 5b6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5ba:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5bc:	c681                	beqz	a3,5c4 <vprintf+0x7c>
 5be:	9752                	add	a4,a4,s4
 5c0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5c4:	05878363          	beq	a5,s8,60a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5c8:	05978d63          	beq	a5,s9,622 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5cc:	07500713          	li	a4,117
 5d0:	0ee78763          	beq	a5,a4,6be <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5d4:	07800713          	li	a4,120
 5d8:	12e78963          	beq	a5,a4,70a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5dc:	07000713          	li	a4,112
 5e0:	14e78e63          	beq	a5,a4,73c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5e4:	06300713          	li	a4,99
 5e8:	18e78e63          	beq	a5,a4,784 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ec:	07300713          	li	a4,115
 5f0:	1ae78463          	beq	a5,a4,798 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5f4:	02500713          	li	a4,37
 5f8:	04e79563          	bne	a5,a4,642 <vprintf+0xfa>
        putc(fd, '%');
 5fc:	02500593          	li	a1,37
 600:	855a                	mv	a0,s6
 602:	e8dff0ef          	jal	48e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 606:	4981                	li	s3,0
 608:	b769                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 60a:	008b8913          	addi	s2,s7,8
 60e:	4685                	li	a3,1
 610:	4629                	li	a2,10
 612:	000ba583          	lw	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	e95ff0ef          	jal	4ac <printint>
 61c:	8bca                	mv	s7,s2
      state = 0;
 61e:	4981                	li	s3,0
 620:	bf8d                	j	592 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 622:	06400793          	li	a5,100
 626:	02f68963          	beq	a3,a5,658 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 62a:	06c00793          	li	a5,108
 62e:	04f68263          	beq	a3,a5,672 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 632:	07500793          	li	a5,117
 636:	0af68063          	beq	a3,a5,6d6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 63a:	07800793          	li	a5,120
 63e:	0ef68263          	beq	a3,a5,722 <vprintf+0x1da>
        putc(fd, '%');
 642:	02500593          	li	a1,37
 646:	855a                	mv	a0,s6
 648:	e47ff0ef          	jal	48e <putc>
        putc(fd, c0);
 64c:	85ca                	mv	a1,s2
 64e:	855a                	mv	a0,s6
 650:	e3fff0ef          	jal	48e <putc>
      state = 0;
 654:	4981                	li	s3,0
 656:	bf35                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 658:	008b8913          	addi	s2,s7,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000bb583          	ld	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e47ff0ef          	jal	4ac <printint>
        i += 1;
 66a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 66c:	8bca                	mv	s7,s2
      state = 0;
 66e:	4981                	li	s3,0
        i += 1;
 670:	b70d                	j	592 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 672:	06400793          	li	a5,100
 676:	02f60763          	beq	a2,a5,6a4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 67a:	07500793          	li	a5,117
 67e:	06f60963          	beq	a2,a5,6f0 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 682:	07800793          	li	a5,120
 686:	faf61ee3          	bne	a2,a5,642 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 68a:	008b8913          	addi	s2,s7,8
 68e:	4681                	li	a3,0
 690:	4641                	li	a2,16
 692:	000bb583          	ld	a1,0(s7)
 696:	855a                	mv	a0,s6
 698:	e15ff0ef          	jal	4ac <printint>
        i += 2;
 69c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 69e:	8bca                	mv	s7,s2
      state = 0;
 6a0:	4981                	li	s3,0
        i += 2;
 6a2:	bdc5                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4685                	li	a3,1
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dfbff0ef          	jal	4ac <printint>
        i += 2;
 6b6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
        i += 2;
 6bc:	bdd9                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6be:	008b8913          	addi	s2,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4629                	li	a2,10
 6c6:	000be583          	lwu	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	de1ff0ef          	jal	4ac <printint>
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bd7d                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4681                	li	a3,0
 6dc:	4629                	li	a2,10
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	dc9ff0ef          	jal	4ac <printint>
        i += 1;
 6e8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 1;
 6ee:	b555                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4629                	li	a2,10
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	dafff0ef          	jal	4ac <printint>
        i += 2;
 702:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
        i += 2;
 708:	b569                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 70a:	008b8913          	addi	s2,s7,8
 70e:	4681                	li	a3,0
 710:	4641                	li	a2,16
 712:	000be583          	lwu	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	d95ff0ef          	jal	4ac <printint>
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bd8d                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 722:	008b8913          	addi	s2,s7,8
 726:	4681                	li	a3,0
 728:	4641                	li	a2,16
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	d7dff0ef          	jal	4ac <printint>
        i += 1;
 734:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 1;
 73a:	bda1                	j	592 <vprintf+0x4a>
 73c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 73e:	008b8d13          	addi	s10,s7,8
 742:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 746:	03000593          	li	a1,48
 74a:	855a                	mv	a0,s6
 74c:	d43ff0ef          	jal	48e <putc>
  putc(fd, 'x');
 750:	07800593          	li	a1,120
 754:	855a                	mv	a0,s6
 756:	d39ff0ef          	jal	48e <putc>
 75a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75c:	00000b97          	auipc	s7,0x0
 760:	2c4b8b93          	addi	s7,s7,708 # a20 <digits>
 764:	03c9d793          	srli	a5,s3,0x3c
 768:	97de                	add	a5,a5,s7
 76a:	0007c583          	lbu	a1,0(a5)
 76e:	855a                	mv	a0,s6
 770:	d1fff0ef          	jal	48e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 774:	0992                	slli	s3,s3,0x4
 776:	397d                	addiw	s2,s2,-1
 778:	fe0916e3          	bnez	s2,764 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 77c:	8bea                	mv	s7,s10
      state = 0;
 77e:	4981                	li	s3,0
 780:	6d02                	ld	s10,0(sp)
 782:	bd01                	j	592 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 784:	008b8913          	addi	s2,s7,8
 788:	000bc583          	lbu	a1,0(s7)
 78c:	855a                	mv	a0,s6
 78e:	d01ff0ef          	jal	48e <putc>
 792:	8bca                	mv	s7,s2
      state = 0;
 794:	4981                	li	s3,0
 796:	bbf5                	j	592 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 798:	008b8993          	addi	s3,s7,8
 79c:	000bb903          	ld	s2,0(s7)
 7a0:	00090f63          	beqz	s2,7be <vprintf+0x276>
        for(; *s; s++)
 7a4:	00094583          	lbu	a1,0(s2)
 7a8:	c195                	beqz	a1,7cc <vprintf+0x284>
          putc(fd, *s);
 7aa:	855a                	mv	a0,s6
 7ac:	ce3ff0ef          	jal	48e <putc>
        for(; *s; s++)
 7b0:	0905                	addi	s2,s2,1
 7b2:	00094583          	lbu	a1,0(s2)
 7b6:	f9f5                	bnez	a1,7aa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7b8:	8bce                	mv	s7,s3
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bbd9                	j	592 <vprintf+0x4a>
          s = "(null)";
 7be:	00000917          	auipc	s2,0x0
 7c2:	25a90913          	addi	s2,s2,602 # a18 <malloc+0x14e>
        for(; *s; s++)
 7c6:	02800593          	li	a1,40
 7ca:	b7c5                	j	7aa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7cc:	8bce                	mv	s7,s3
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b3c9                	j	592 <vprintf+0x4a>
 7d2:	64a6                	ld	s1,72(sp)
 7d4:	79e2                	ld	s3,56(sp)
 7d6:	7a42                	ld	s4,48(sp)
 7d8:	7aa2                	ld	s5,40(sp)
 7da:	7b02                	ld	s6,32(sp)
 7dc:	6be2                	ld	s7,24(sp)
 7de:	6c42                	ld	s8,16(sp)
 7e0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7e2:	60e6                	ld	ra,88(sp)
 7e4:	6446                	ld	s0,80(sp)
 7e6:	6906                	ld	s2,64(sp)
 7e8:	6125                	addi	sp,sp,96
 7ea:	8082                	ret

00000000000007ec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ec:	715d                	addi	sp,sp,-80
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e010                	sd	a2,0(s0)
 7f6:	e414                	sd	a3,8(s0)
 7f8:	e818                	sd	a4,16(s0)
 7fa:	ec1c                	sd	a5,24(s0)
 7fc:	03043023          	sd	a6,32(s0)
 800:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 804:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 808:	8622                	mv	a2,s0
 80a:	d3fff0ef          	jal	548 <vprintf>
}
 80e:	60e2                	ld	ra,24(sp)
 810:	6442                	ld	s0,16(sp)
 812:	6161                	addi	sp,sp,80
 814:	8082                	ret

0000000000000816 <printf>:

void
printf(const char *fmt, ...)
{
 816:	711d                	addi	sp,sp,-96
 818:	ec06                	sd	ra,24(sp)
 81a:	e822                	sd	s0,16(sp)
 81c:	1000                	addi	s0,sp,32
 81e:	e40c                	sd	a1,8(s0)
 820:	e810                	sd	a2,16(s0)
 822:	ec14                	sd	a3,24(s0)
 824:	f018                	sd	a4,32(s0)
 826:	f41c                	sd	a5,40(s0)
 828:	03043823          	sd	a6,48(s0)
 82c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 830:	00840613          	addi	a2,s0,8
 834:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 838:	85aa                	mv	a1,a0
 83a:	4505                	li	a0,1
 83c:	d0dff0ef          	jal	548 <vprintf>
}
 840:	60e2                	ld	ra,24(sp)
 842:	6442                	ld	s0,16(sp)
 844:	6125                	addi	sp,sp,96
 846:	8082                	ret

0000000000000848 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 848:	1141                	addi	sp,sp,-16
 84a:	e422                	sd	s0,8(sp)
 84c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 84e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 852:	00000797          	auipc	a5,0x0
 856:	7ae7b783          	ld	a5,1966(a5) # 1000 <freep>
 85a:	a02d                	j	884 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 85c:	4618                	lw	a4,8(a2)
 85e:	9f2d                	addw	a4,a4,a1
 860:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 864:	6398                	ld	a4,0(a5)
 866:	6310                	ld	a2,0(a4)
 868:	a83d                	j	8a6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 86a:	ff852703          	lw	a4,-8(a0)
 86e:	9f31                	addw	a4,a4,a2
 870:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 872:	ff053683          	ld	a3,-16(a0)
 876:	a091                	j	8ba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 878:	6398                	ld	a4,0(a5)
 87a:	00e7e463          	bltu	a5,a4,882 <free+0x3a>
 87e:	00e6ea63          	bltu	a3,a4,892 <free+0x4a>
{
 882:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 884:	fed7fae3          	bgeu	a5,a3,878 <free+0x30>
 888:	6398                	ld	a4,0(a5)
 88a:	00e6e463          	bltu	a3,a4,892 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88e:	fee7eae3          	bltu	a5,a4,882 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 892:	ff852583          	lw	a1,-8(a0)
 896:	6390                	ld	a2,0(a5)
 898:	02059813          	slli	a6,a1,0x20
 89c:	01c85713          	srli	a4,a6,0x1c
 8a0:	9736                	add	a4,a4,a3
 8a2:	fae60de3          	beq	a2,a4,85c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8aa:	4790                	lw	a2,8(a5)
 8ac:	02061593          	slli	a1,a2,0x20
 8b0:	01c5d713          	srli	a4,a1,0x1c
 8b4:	973e                	add	a4,a4,a5
 8b6:	fae68ae3          	beq	a3,a4,86a <free+0x22>
    p->s.ptr = bp->s.ptr;
 8ba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8bc:	00000717          	auipc	a4,0x0
 8c0:	74f73223          	sd	a5,1860(a4) # 1000 <freep>
}
 8c4:	6422                	ld	s0,8(sp)
 8c6:	0141                	addi	sp,sp,16
 8c8:	8082                	ret

00000000000008ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ca:	7139                	addi	sp,sp,-64
 8cc:	fc06                	sd	ra,56(sp)
 8ce:	f822                	sd	s0,48(sp)
 8d0:	f426                	sd	s1,40(sp)
 8d2:	ec4e                	sd	s3,24(sp)
 8d4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d6:	02051493          	slli	s1,a0,0x20
 8da:	9081                	srli	s1,s1,0x20
 8dc:	04bd                	addi	s1,s1,15
 8de:	8091                	srli	s1,s1,0x4
 8e0:	0014899b          	addiw	s3,s1,1
 8e4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8e6:	00000517          	auipc	a0,0x0
 8ea:	71a53503          	ld	a0,1818(a0) # 1000 <freep>
 8ee:	c915                	beqz	a0,922 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f2:	4798                	lw	a4,8(a5)
 8f4:	08977a63          	bgeu	a4,s1,988 <malloc+0xbe>
 8f8:	f04a                	sd	s2,32(sp)
 8fa:	e852                	sd	s4,16(sp)
 8fc:	e456                	sd	s5,8(sp)
 8fe:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 900:	8a4e                	mv	s4,s3
 902:	0009871b          	sext.w	a4,s3
 906:	6685                	lui	a3,0x1
 908:	00d77363          	bgeu	a4,a3,90e <malloc+0x44>
 90c:	6a05                	lui	s4,0x1
 90e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 912:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 916:	00000917          	auipc	s2,0x0
 91a:	6ea90913          	addi	s2,s2,1770 # 1000 <freep>
  if(p == SBRK_ERROR)
 91e:	5afd                	li	s5,-1
 920:	a081                	j	960 <malloc+0x96>
 922:	f04a                	sd	s2,32(sp)
 924:	e852                	sd	s4,16(sp)
 926:	e456                	sd	s5,8(sp)
 928:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 92a:	00001797          	auipc	a5,0x1
 92e:	8de78793          	addi	a5,a5,-1826 # 1208 <base>
 932:	00000717          	auipc	a4,0x0
 936:	6cf73723          	sd	a5,1742(a4) # 1000 <freep>
 93a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 93c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 940:	b7c1                	j	900 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 942:	6398                	ld	a4,0(a5)
 944:	e118                	sd	a4,0(a0)
 946:	a8a9                	j	9a0 <malloc+0xd6>
  hp->s.size = nu;
 948:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 94c:	0541                	addi	a0,a0,16
 94e:	efbff0ef          	jal	848 <free>
  return freep;
 952:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 956:	c12d                	beqz	a0,9b8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95a:	4798                	lw	a4,8(a5)
 95c:	02977263          	bgeu	a4,s1,980 <malloc+0xb6>
    if(p == freep)
 960:	00093703          	ld	a4,0(s2)
 964:	853e                	mv	a0,a5
 966:	fef719e3          	bne	a4,a5,958 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 96a:	8552                	mv	a0,s4
 96c:	9f9ff0ef          	jal	364 <sbrk>
  if(p == SBRK_ERROR)
 970:	fd551ce3          	bne	a0,s5,948 <malloc+0x7e>
        return 0;
 974:	4501                	li	a0,0
 976:	7902                	ld	s2,32(sp)
 978:	6a42                	ld	s4,16(sp)
 97a:	6aa2                	ld	s5,8(sp)
 97c:	6b02                	ld	s6,0(sp)
 97e:	a03d                	j	9ac <malloc+0xe2>
 980:	7902                	ld	s2,32(sp)
 982:	6a42                	ld	s4,16(sp)
 984:	6aa2                	ld	s5,8(sp)
 986:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 988:	fae48de3          	beq	s1,a4,942 <malloc+0x78>
        p->s.size -= nunits;
 98c:	4137073b          	subw	a4,a4,s3
 990:	c798                	sw	a4,8(a5)
        p += p->s.size;
 992:	02071693          	slli	a3,a4,0x20
 996:	01c6d713          	srli	a4,a3,0x1c
 99a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a0:	00000717          	auipc	a4,0x0
 9a4:	66a73023          	sd	a0,1632(a4) # 1000 <freep>
      return (void*)(p + 1);
 9a8:	01078513          	addi	a0,a5,16
  }
}
 9ac:	70e2                	ld	ra,56(sp)
 9ae:	7442                	ld	s0,48(sp)
 9b0:	74a2                	ld	s1,40(sp)
 9b2:	69e2                	ld	s3,24(sp)
 9b4:	6121                	addi	sp,sp,64
 9b6:	8082                	ret
 9b8:	7902                	ld	s2,32(sp)
 9ba:	6a42                	ld	s4,16(sp)
 9bc:	6aa2                	ld	s5,8(sp)
 9be:	6b02                	ld	s6,0(sp)
 9c0:	b7f5                	j	9ac <malloc+0xe2>
