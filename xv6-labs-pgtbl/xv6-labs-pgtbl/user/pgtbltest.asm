
user/_pgtbltest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <err>:

char *testname = "???";

void
err(char *why)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  printf("pgtbltest: %s failed: %s, pid=%d\n", testname, why, getpid());
   e:	00002917          	auipc	s2,0x2
  12:	ff293903          	ld	s2,-14(s2) # 2000 <testname>
  16:	019000ef          	jal	82e <getpid>
  1a:	86aa                	mv	a3,a0
  1c:	8626                	mv	a2,s1
  1e:	85ca                	mv	a1,s2
  20:	00001517          	auipc	a0,0x1
  24:	db050513          	addi	a0,a0,-592 # dd0 <malloc+0x106>
  28:	3ef000ef          	jal	c16 <printf>
  exit(1);
  2c:	4505                	li	a0,1
  2e:	780000ef          	jal	7ae <exit>

0000000000000032 <print_pte>:
}

void
print_pte(uint64 va)
{
  32:	1101                	addi	sp,sp,-32
  34:	ec06                	sd	ra,24(sp)
  36:	e822                	sd	s0,16(sp)
  38:	e426                	sd	s1,8(sp)
  3a:	1000                	addi	s0,sp,32
  3c:	84aa                	mv	s1,a0
    pte_t pte = (pte_t) pgpte((void *) va);
  3e:	033000ef          	jal	870 <pgpte>
  42:	862a                	mv	a2,a0
    printf("va 0x%lx pte 0x%lx pa 0x%lx perm 0x%lx\n", va, pte, PTE2PA(pte), PTE_FLAGS(pte));
  44:	00a55693          	srli	a3,a0,0xa
  48:	3ff57713          	andi	a4,a0,1023
  4c:	06b2                	slli	a3,a3,0xc
  4e:	85a6                	mv	a1,s1
  50:	00001517          	auipc	a0,0x1
  54:	da850513          	addi	a0,a0,-600 # df8 <malloc+0x12e>
  58:	3bf000ef          	jal	c16 <printf>
}
  5c:	60e2                	ld	ra,24(sp)
  5e:	6442                	ld	s0,16(sp)
  60:	64a2                	ld	s1,8(sp)
  62:	6105                	addi	sp,sp,32
  64:	8082                	ret

0000000000000066 <print_pgtbl>:

void
print_pgtbl()
{
  66:	7179                	addi	sp,sp,-48
  68:	f406                	sd	ra,40(sp)
  6a:	f022                	sd	s0,32(sp)
  6c:	ec26                	sd	s1,24(sp)
  6e:	e84a                	sd	s2,16(sp)
  70:	e44e                	sd	s3,8(sp)
  72:	1800                	addi	s0,sp,48
  printf("print_pgtbl starting\n");
  74:	00001517          	auipc	a0,0x1
  78:	dac50513          	addi	a0,a0,-596 # e20 <malloc+0x156>
  7c:	39b000ef          	jal	c16 <printf>
  80:	4481                	li	s1,0
  for (uint64 i = 0; i < 10; i++) {
  82:	6985                	lui	s3,0x1
  84:	6929                	lui	s2,0xa
    print_pte(i * PGSIZE);
  86:	8526                	mv	a0,s1
  88:	fabff0ef          	jal	32 <print_pte>
  for (uint64 i = 0; i < 10; i++) {
  8c:	94ce                	add	s1,s1,s3
  8e:	ff249ce3          	bne	s1,s2,86 <print_pgtbl+0x20>
  92:	020004b7          	lui	s1,0x2000
  96:	14ed                	addi	s1,s1,-5 # 1fffffb <base+0x1ffdfdb>
  98:	04b6                	slli	s1,s1,0xd
  }
  uint64 top = MAXVA/PGSIZE;
  for (uint64 i = top-10; i < top; i++) {
  9a:	6985                	lui	s3,0x1
  9c:	4905                	li	s2,1
  9e:	191a                	slli	s2,s2,0x26
    print_pte(i * PGSIZE);
  a0:	8526                	mv	a0,s1
  a2:	f91ff0ef          	jal	32 <print_pte>
  for (uint64 i = top-10; i < top; i++) {
  a6:	94ce                	add	s1,s1,s3
  a8:	ff249ce3          	bne	s1,s2,a0 <print_pgtbl+0x3a>
  }
  printf("print_pgtbl: OK\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	d8c50513          	addi	a0,a0,-628 # e38 <malloc+0x16e>
  b4:	363000ef          	jal	c16 <printf>
}
  b8:	70a2                	ld	ra,40(sp)
  ba:	7402                	ld	s0,32(sp)
  bc:	64e2                	ld	s1,24(sp)
  be:	6942                	ld	s2,16(sp)
  c0:	69a2                	ld	s3,8(sp)
  c2:	6145                	addi	sp,sp,48
  c4:	8082                	ret

00000000000000c6 <ugetpid_test>:

void
ugetpid_test()
{
  c6:	7179                	addi	sp,sp,-48
  c8:	f406                	sd	ra,40(sp)
  ca:	f022                	sd	s0,32(sp)
  cc:	ec26                	sd	s1,24(sp)
  ce:	e84a                	sd	s2,16(sp)
  d0:	1800                	addi	s0,sp,48
  int i;

  printf("ugetpid_test starting\n");
  d2:	00001517          	auipc	a0,0x1
  d6:	d7e50513          	addi	a0,a0,-642 # e50 <malloc+0x186>
  da:	33d000ef          	jal	c16 <printf>
  testname = "ugetpid_test";
  de:	00001797          	auipc	a5,0x1
  e2:	d8a78793          	addi	a5,a5,-630 # e68 <malloc+0x19e>
  e6:	00002717          	auipc	a4,0x2
  ea:	f0f73d23          	sd	a5,-230(a4) # 2000 <testname>

  if(getpid() != ugetpid())
  ee:	740000ef          	jal	82e <getpid>
  f2:	892a                	mv	s2,a0
  f4:	69c000ef          	jal	790 <ugetpid>
  f8:	04000493          	li	s1,64
  fc:	02a91c63          	bne	s2,a0,134 <ugetpid_test+0x6e>
    err("mismatched PID #1");

  for (i = 0; i < 64; i++) {
    int ret = fork();
 100:	6a6000ef          	jal	7a6 <fork>
 104:	fca42e23          	sw	a0,-36(s0)
    if (ret != 0) {
 108:	cd1d                	beqz	a0,146 <ugetpid_test+0x80>
      wait(&ret);
 10a:	fdc40513          	addi	a0,s0,-36
 10e:	6a8000ef          	jal	7b6 <wait>
      if (ret != 0)
 112:	fdc42783          	lw	a5,-36(s0)
 116:	e78d                	bnez	a5,140 <ugetpid_test+0x7a>
  for (i = 0; i < 64; i++) {
 118:	34fd                	addiw	s1,s1,-1
 11a:	f0fd                	bnez	s1,100 <ugetpid_test+0x3a>
    }
    if (getpid() != ugetpid())
      err("mismatched PID #2");
    exit(0);
  }
  printf("ugetpid_test: OK\n");
 11c:	00001517          	auipc	a0,0x1
 120:	d8c50513          	addi	a0,a0,-628 # ea8 <malloc+0x1de>
 124:	2f3000ef          	jal	c16 <printf>
}
 128:	70a2                	ld	ra,40(sp)
 12a:	7402                	ld	s0,32(sp)
 12c:	64e2                	ld	s1,24(sp)
 12e:	6942                	ld	s2,16(sp)
 130:	6145                	addi	sp,sp,48
 132:	8082                	ret
    err("mismatched PID #1");
 134:	00001517          	auipc	a0,0x1
 138:	d4450513          	addi	a0,a0,-700 # e78 <malloc+0x1ae>
 13c:	ec5ff0ef          	jal	0 <err>
        exit(1);
 140:	4505                	li	a0,1
 142:	66c000ef          	jal	7ae <exit>
    if (getpid() != ugetpid())
 146:	6e8000ef          	jal	82e <getpid>
 14a:	84aa                	mv	s1,a0
 14c:	644000ef          	jal	790 <ugetpid>
 150:	00a48863          	beq	s1,a0,160 <ugetpid_test+0x9a>
      err("mismatched PID #2");
 154:	00001517          	auipc	a0,0x1
 158:	d3c50513          	addi	a0,a0,-708 # e90 <malloc+0x1c6>
 15c:	ea5ff0ef          	jal	0 <err>
    exit(0);
 160:	4501                	li	a0,0
 162:	64c000ef          	jal	7ae <exit>

0000000000000166 <print_kpgtbl>:

void
print_kpgtbl()
{
 166:	1141                	addi	sp,sp,-16
 168:	e406                	sd	ra,8(sp)
 16a:	e022                	sd	s0,0(sp)
 16c:	0800                	addi	s0,sp,16
  printf("print_kpgtbl starting\n");
 16e:	00001517          	auipc	a0,0x1
 172:	d5250513          	addi	a0,a0,-686 # ec0 <malloc+0x1f6>
 176:	2a1000ef          	jal	c16 <printf>
  kpgtbl();
 17a:	700000ef          	jal	87a <kpgtbl>
  printf("print_kpgtbl: OK\n");
 17e:	00001517          	auipc	a0,0x1
 182:	d5a50513          	addi	a0,a0,-678 # ed8 <malloc+0x20e>
 186:	291000ef          	jal	c16 <printf>
}
 18a:	60a2                	ld	ra,8(sp)
 18c:	6402                	ld	s0,0(sp)
 18e:	0141                	addi	sp,sp,16
 190:	8082                	ret

0000000000000192 <supercheck>:


void
supercheck(char *end)
{
 192:	7139                	addi	sp,sp,-64
 194:	fc06                	sd	ra,56(sp)
 196:	f822                	sd	s0,48(sp)
 198:	f426                	sd	s1,40(sp)
 19a:	f04a                	sd	s2,32(sp)
 19c:	ec4e                	sd	s3,24(sp)
 19e:	e852                	sd	s4,16(sp)
 1a0:	e456                	sd	s5,8(sp)
 1a2:	e05a                	sd	s6,0(sp)
 1a4:	0080                	addi	s0,sp,64
  pte_t last_pte = 0;
  uint64 a = (uint64) end;
  uint64 s = SUPERPGROUNDUP(a);
 1a6:	002009b7          	lui	s3,0x200
 1aa:	19fd                	addi	s3,s3,-1 # 1fffff <base+0x1fdfdf>
 1ac:	99aa                	add	s3,s3,a0
 1ae:	ffe007b7          	lui	a5,0xffe00
 1b2:	00f9f9b3          	and	s3,s3,a5

  for (; a < s; a += PGSIZE) {
 1b6:	01357b63          	bgeu	a0,s3,1cc <supercheck+0x3a>
 1ba:	84aa                	mv	s1,a0
 1bc:	6905                	lui	s2,0x1
    pte_t pte = (pte_t) pgpte((void *) a);
 1be:	8526                	mv	a0,s1
 1c0:	6b0000ef          	jal	870 <pgpte>
    if (pte == 0) {
 1c4:	cd11                	beqz	a0,1e0 <supercheck+0x4e>
  for (; a < s; a += PGSIZE) {
 1c6:	94ca                	add	s1,s1,s2
 1c8:	ff34ebe3          	bltu	s1,s3,1be <supercheck+0x2c>
      err("no pte");
    }
  }

  for (uint64 p = s;  p < s + 512 * PGSIZE; p += PGSIZE) {
 1cc:	00200a37          	lui	s4,0x200
 1d0:	9a4e                	add	s4,s4,s3
 1d2:	0549ff63          	bgeu	s3,s4,230 <supercheck+0x9e>
 1d6:	84ce                	mv	s1,s3
  pte_t last_pte = 0;
 1d8:	4501                	li	a0,0
    if(pte == 0)
      err("no pte");
    if ((uint64) last_pte != 0 && pte != last_pte) {
        err("pte different");
    }
    if((pte & PTE_V) == 0 || (pte & PTE_R) == 0 || (pte & PTE_W) == 0){
 1da:	4b1d                	li	s6,7
  for (uint64 p = s;  p < s + 512 * PGSIZE; p += PGSIZE) {
 1dc:	6a85                	lui	s5,0x1
 1de:	a025                	j	206 <supercheck+0x74>
      err("no pte");
 1e0:	00001517          	auipc	a0,0x1
 1e4:	d1050513          	addi	a0,a0,-752 # ef0 <malloc+0x226>
 1e8:	e19ff0ef          	jal	0 <err>
      err("no pte");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	d0450513          	addi	a0,a0,-764 # ef0 <malloc+0x226>
 1f4:	e0dff0ef          	jal	0 <err>
    if((pte & PTE_V) == 0 || (pte & PTE_R) == 0 || (pte & PTE_W) == 0){
 1f8:	00757793          	andi	a5,a0,7
 1fc:	03679463          	bne	a5,s6,224 <supercheck+0x92>
  for (uint64 p = s;  p < s + 512 * PGSIZE; p += PGSIZE) {
 200:	94d6                	add	s1,s1,s5
 202:	0344f763          	bgeu	s1,s4,230 <supercheck+0x9e>
    pte_t pte = (pte_t) pgpte((void *) p);
 206:	892a                	mv	s2,a0
 208:	8526                	mv	a0,s1
 20a:	666000ef          	jal	870 <pgpte>
    if(pte == 0)
 20e:	dd79                	beqz	a0,1ec <supercheck+0x5a>
    if ((uint64) last_pte != 0 && pte != last_pte) {
 210:	fe0904e3          	beqz	s2,1f8 <supercheck+0x66>
 214:	ff2502e3          	beq	a0,s2,1f8 <supercheck+0x66>
        err("pte different");
 218:	00001517          	auipc	a0,0x1
 21c:	ce050513          	addi	a0,a0,-800 # ef8 <malloc+0x22e>
 220:	de1ff0ef          	jal	0 <err>
      err("pte wrong");
 224:	00001517          	auipc	a0,0x1
 228:	ce450513          	addi	a0,a0,-796 # f08 <malloc+0x23e>
 22c:	dd5ff0ef          	jal	0 <err>
  pte_t last_pte = 0;
 230:	4781                	li	a5,0
    }
    last_pte = pte;
  }

  for(int i = 0; i < 512 * PGSIZE; i += PGSIZE){
 232:	6605                	lui	a2,0x1
 234:	002006b7          	lui	a3,0x200
    *(int*)(s+i) = i;
 238:	01378733          	add	a4,a5,s3
 23c:	c31c                	sw	a5,0(a4)
  for(int i = 0; i < 512 * PGSIZE; i += PGSIZE){
 23e:	97b2                	add	a5,a5,a2
 240:	fed79ce3          	bne	a5,a3,238 <supercheck+0xa6>
 244:	4781                	li	a5,0
  }

  for(int i = 0; i < 512 * PGSIZE; i += PGSIZE){
 246:	6585                	lui	a1,0x1
 248:	00200637          	lui	a2,0x200
    if(*(int*)(s+i) != i)
 24c:	01378733          	add	a4,a5,s3
 250:	4314                	lw	a3,0(a4)
 252:	0007871b          	sext.w	a4,a5
 256:	00e69f63          	bne	a3,a4,274 <supercheck+0xe2>
  for(int i = 0; i < 512 * PGSIZE; i += PGSIZE){
 25a:	97ae                	add	a5,a5,a1
 25c:	fec798e3          	bne	a5,a2,24c <supercheck+0xba>
      err("wrong value");
  }
}
 260:	70e2                	ld	ra,56(sp)
 262:	7442                	ld	s0,48(sp)
 264:	74a2                	ld	s1,40(sp)
 266:	7902                	ld	s2,32(sp)
 268:	69e2                	ld	s3,24(sp)
 26a:	6a42                	ld	s4,16(sp)
 26c:	6aa2                	ld	s5,8(sp)
 26e:	6b02                	ld	s6,0(sp)
 270:	6121                	addi	sp,sp,64
 272:	8082                	ret
      err("wrong value");
 274:	00001517          	auipc	a0,0x1
 278:	ca450513          	addi	a0,a0,-860 # f18 <malloc+0x24e>
 27c:	d85ff0ef          	jal	0 <err>

0000000000000280 <superpg_fork>:

void
superpg_fork()
{
 280:	7179                	addi	sp,sp,-48
 282:	f406                	sd	ra,40(sp)
 284:	f022                	sd	s0,32(sp)
 286:	ec26                	sd	s1,24(sp)
 288:	1800                	addi	s0,sp,48
  int pid;
  
  printf("superpg_fork starting\n");
 28a:	00001517          	auipc	a0,0x1
 28e:	c9e50513          	addi	a0,a0,-866 # f28 <malloc+0x25e>
 292:	185000ef          	jal	c16 <printf>
  testname = "superpg_fork";
 296:	00001797          	auipc	a5,0x1
 29a:	caa78793          	addi	a5,a5,-854 # f40 <malloc+0x276>
 29e:	00002717          	auipc	a4,0x2
 2a2:	d6f73123          	sd	a5,-670(a4) # 2000 <testname>
  
  char *end = sbrk(SZ);
 2a6:	01000537          	lui	a0,0x1000
 2aa:	4ba000ef          	jal	764 <sbrk>
  if (end == 0 || end == SBRK_ERROR)
 2ae:	fff50713          	addi	a4,a0,-1 # ffffff <base+0xffdfdf>
 2b2:	57f5                	li	a5,-3
 2b4:	04e7e963          	bltu	a5,a4,306 <superpg_fork+0x86>
 2b8:	84aa                	mv	s1,a0
    err("sbrk failed");

  // check if parent has super pages
  supercheck(end);
 2ba:	ed9ff0ef          	jal	192 <supercheck>
  if((pid = fork()) < 0) {
 2be:	4e8000ef          	jal	7a6 <fork>
 2c2:	04054863          	bltz	a0,312 <superpg_fork+0x92>
    err("fork");
  } else if(pid == 0) {
 2c6:	cd21                	beqz	a0,31e <superpg_fork+0x9e>
    // check if child's address space has super pages
    supercheck(end);
    exit(0);
  } else {
    int status;
    wait(&status);
 2c8:	fdc40513          	addi	a0,s0,-36
 2cc:	4ea000ef          	jal	7b6 <wait>
    if (status != 0) {
 2d0:	fdc42783          	lw	a5,-36(s0)
 2d4:	ebb9                	bnez	a5,32a <superpg_fork+0xaa>
      exit(0);
    }
  }

  // free super pages
  sbrk(-SZ);
 2d6:	ff000537          	lui	a0,0xff000
 2da:	48a000ef          	jal	764 <sbrk>
  if((pid = fork()) < 0) {
 2de:	4c8000ef          	jal	7a6 <fork>
 2e2:	04054763          	bltz	a0,330 <superpg_fork+0xb0>
    err("fork");
  } else if(pid == 0) {
 2e6:	e939                	bnez	a0,33c <superpg_fork+0xbc>
    // reference freed memory; this should result in page fault and
    // the kernel should kill the child.
    * (end + 1) = '9'; 
 2e8:	03900793          	li	a5,57
 2ec:	00f480a3          	sb	a5,1(s1)
    if (status == 0) {
      err("child was able to reference free memory\n");
      exit(1);
    }
  }  
  printf("superpg_fork: OK\n");  
 2f0:	00001517          	auipc	a0,0x1
 2f4:	ca050513          	addi	a0,a0,-864 # f90 <malloc+0x2c6>
 2f8:	11f000ef          	jal	c16 <printf>
}
 2fc:	70a2                	ld	ra,40(sp)
 2fe:	7402                	ld	s0,32(sp)
 300:	64e2                	ld	s1,24(sp)
 302:	6145                	addi	sp,sp,48
 304:	8082                	ret
    err("sbrk failed");
 306:	00001517          	auipc	a0,0x1
 30a:	c4a50513          	addi	a0,a0,-950 # f50 <malloc+0x286>
 30e:	cf3ff0ef          	jal	0 <err>
    err("fork");
 312:	00001517          	auipc	a0,0x1
 316:	c3650513          	addi	a0,a0,-970 # f48 <malloc+0x27e>
 31a:	ce7ff0ef          	jal	0 <err>
    supercheck(end);
 31e:	8526                	mv	a0,s1
 320:	e73ff0ef          	jal	192 <supercheck>
    exit(0);
 324:	4501                	li	a0,0
 326:	488000ef          	jal	7ae <exit>
      exit(0);
 32a:	4501                	li	a0,0
 32c:	482000ef          	jal	7ae <exit>
    err("fork");
 330:	00001517          	auipc	a0,0x1
 334:	c1850513          	addi	a0,a0,-1000 # f48 <malloc+0x27e>
 338:	cc9ff0ef          	jal	0 <err>
    wait(&status);
 33c:	fdc40513          	addi	a0,s0,-36
 340:	476000ef          	jal	7b6 <wait>
    if (status == 0) {
 344:	fdc42783          	lw	a5,-36(s0)
 348:	f7c5                	bnez	a5,2f0 <superpg_fork+0x70>
      err("child was able to reference free memory\n");
 34a:	00001517          	auipc	a0,0x1
 34e:	c1650513          	addi	a0,a0,-1002 # f60 <malloc+0x296>
 352:	cafff0ef          	jal	0 <err>

0000000000000356 <superpg_free>:

void
superpg_free()
{
 356:	7139                	addi	sp,sp,-64
 358:	fc06                	sd	ra,56(sp)
 35a:	f822                	sd	s0,48(sp)
 35c:	f426                	sd	s1,40(sp)
 35e:	f04a                	sd	s2,32(sp)
 360:	ec4e                	sd	s3,24(sp)
 362:	0080                	addi	s0,sp,64
  int pid;
  
  printf("superpg_free starting\n");
 364:	00001517          	auipc	a0,0x1
 368:	c4450513          	addi	a0,a0,-956 # fa8 <malloc+0x2de>
 36c:	0ab000ef          	jal	c16 <printf>
  testname = "superpg_free";
 370:	00001797          	auipc	a5,0x1
 374:	c5078793          	addi	a5,a5,-944 # fc0 <malloc+0x2f6>
 378:	00002717          	auipc	a4,0x2
 37c:	c8f73423          	sd	a5,-888(a4) # 2000 <testname>

  char *end = sbrk(SZ);
 380:	01000537          	lui	a0,0x1000
 384:	3e0000ef          	jal	764 <sbrk>
  if (end == 0 || end == SBRK_ERROR)
 388:	157d                	addi	a0,a0,-1 # ffffff <base+0xffdfdf>
 38a:	57f5                	li	a5,-3
 38c:	0ea7e263          	bltu	a5,a0,470 <superpg_free+0x11a>
    err("sbrk failed");

  // free pages beyond a super page
  char *a = sbrk(0);
 390:	4501                	li	a0,0
 392:	3d2000ef          	jal	764 <sbrk>
  uint64 s = SUPERPGROUNDDOWN((uint64) a);
 396:	00200737          	lui	a4,0x200
 39a:	fff70793          	addi	a5,a4,-1 # 1fffff <base+0x1fdfdf>
 39e:	97aa                	add	a5,a5,a0
 3a0:	ffe006b7          	lui	a3,0xffe00
 3a4:	8ff5                	and	a5,a5,a3
 3a6:	8f99                	sub	a5,a5,a4
  sbrk(-((uint64) a-s));
 3a8:	40a7853b          	subw	a0,a5,a0
 3ac:	3b8000ef          	jal	764 <sbrk>
  a = sbrk(0);
 3b0:	4501                	li	a0,0
 3b2:	3b2000ef          	jal	764 <sbrk>
 3b6:	84aa                	mv	s1,a0

  pte_t pte1 = (pte_t) pgpte((void *) a-PGSIZE);
 3b8:	757d                	lui	a0,0xfffff
 3ba:	9526                	add	a0,a0,s1
 3bc:	4b4000ef          	jal	870 <pgpte>
 3c0:	892a                	mv	s2,a0
  pte_t pte2 = (pte_t) pgpte((void *) a-2*PGSIZE);
 3c2:	7579                	lui	a0,0xffffe
 3c4:	9526                	add	a0,a0,s1
 3c6:	4aa000ef          	jal	870 <pgpte>
  if (pte1 != pte2) {
 3ca:	0aa91963          	bne	s2,a0,47c <superpg_free+0x126>
    err("not a super page");
  }
  
  // write to the last 8192-byte section of a super page
  * (a - PGSIZE + 1) = '8';
 3ce:	797d                	lui	s2,0xfffff
 3d0:	012487b3          	add	a5,s1,s2
 3d4:	03800713          	li	a4,56
 3d8:	00e780a3          	sb	a4,1(a5)
  * (a - 2*PGSIZE + 1) = '9';
 3dc:	77f9                	lui	a5,0xffffe
 3de:	94be                	add	s1,s1,a5
 3e0:	03900993          	li	s3,57
 3e4:	013480a3          	sb	s3,1(s1)

  // free last 4096 bytes of a super page
  sbrk(-PGSIZE);
 3e8:	757d                	lui	a0,0xfffff
 3ea:	37a000ef          	jal	764 <sbrk>
  a = sbrk(0);
 3ee:	4501                	li	a0,0
 3f0:	374000ef          	jal	764 <sbrk>
 3f4:	84aa                	mv	s1,a0

  if (*(a - PGSIZE + 1) != '9') {
 3f6:	992a                	add	s2,s2,a0
 3f8:	00194783          	lbu	a5,1(s2) # fffffffffffff001 <base+0xffffffffffffcfe1>
 3fc:	09379663          	bne	a5,s3,488 <superpg_free+0x132>
    err("lost content after freeing part of super page");
  }

  if((pid = fork()) < 0) {
 400:	3a6000ef          	jal	7a6 <fork>
 404:	08054863          	bltz	a0,494 <superpg_free+0x13e>
    err("fork");
  } else if(pid == 0) {
 408:	ed51                	bnez	a0,4a4 <superpg_free+0x14e>
     // the memory at address a shouldn't be in the child's address
     // space, since the parent freed it. The following reference
     // should result in page fault and the kernel should kill the
     // child.
    if (* (a + 1) == '9') {
 40a:	0014c703          	lbu	a4,1(s1)
 40e:	03900793          	li	a5,57
 412:	08f70763          	beq	a4,a5,4a0 <superpg_free+0x14a>
      err("child was able to reference free memory\n");
      exit(1);
    }
  }

  pte1 = (pte_t) pgpte((void *) a);
 416:	8526                	mv	a0,s1
 418:	458000ef          	jal	870 <pgpte>
  if(pte1 != 0) {
 41c:	e14d                	bnez	a0,4be <superpg_free+0x168>
    err("pte for freed memory is valid");
  }

  s = SUPERPGROUNDDOWN((uint64) a);
 41e:	002007b7          	lui	a5,0x200
 422:	fff78913          	addi	s2,a5,-1 # 1fffff <base+0x1fdfdf>
 426:	9926                	add	s2,s2,s1
 428:	ffe00737          	lui	a4,0xffe00
 42c:	00e97933          	and	s2,s2,a4
 430:	40f90933          	sub	s2,s2,a5
  for (; (uint64) a > s; a -= PGSIZE) {
 434:	02997163          	bgeu	s2,s1,456 <superpg_free+0x100>
    a = sbrk(-PGSIZE);
 438:	757d                	lui	a0,0xfffff
 43a:	32a000ef          	jal	764 <sbrk>
 43e:	84aa                	mv	s1,a0
    pte1 = (pte_t) pgpte(sbrk(0));
 440:	4501                	li	a0,0
 442:	322000ef          	jal	764 <sbrk>
 446:	42a000ef          	jal	870 <pgpte>
    if(pte1 != 0) {
 44a:	e141                	bnez	a0,4ca <superpg_free+0x174>
  for (; (uint64) a > s; a -= PGSIZE) {
 44c:	77fd                	lui	a5,0xfffff
 44e:	00f48533          	add	a0,s1,a5
 452:	fea963e3          	bltu	s2,a0,438 <superpg_free+0xe2>
      err("page hasn't been freed");
    }
  }
  
  printf("superpg_free: OK\n");  
 456:	00001517          	auipc	a0,0x1
 45a:	bfa50513          	addi	a0,a0,-1030 # 1050 <malloc+0x386>
 45e:	7b8000ef          	jal	c16 <printf>
}
 462:	70e2                	ld	ra,56(sp)
 464:	7442                	ld	s0,48(sp)
 466:	74a2                	ld	s1,40(sp)
 468:	7902                	ld	s2,32(sp)
 46a:	69e2                	ld	s3,24(sp)
 46c:	6121                	addi	sp,sp,64
 46e:	8082                	ret
    err("sbrk failed");
 470:	00001517          	auipc	a0,0x1
 474:	ae050513          	addi	a0,a0,-1312 # f50 <malloc+0x286>
 478:	b89ff0ef          	jal	0 <err>
    err("not a super page");
 47c:	00001517          	auipc	a0,0x1
 480:	b5450513          	addi	a0,a0,-1196 # fd0 <malloc+0x306>
 484:	b7dff0ef          	jal	0 <err>
    err("lost content after freeing part of super page");
 488:	00001517          	auipc	a0,0x1
 48c:	b6050513          	addi	a0,a0,-1184 # fe8 <malloc+0x31e>
 490:	b71ff0ef          	jal	0 <err>
    err("fork");
 494:	00001517          	auipc	a0,0x1
 498:	ab450513          	addi	a0,a0,-1356 # f48 <malloc+0x27e>
 49c:	b65ff0ef          	jal	0 <err>
      exit(0);
 4a0:	30e000ef          	jal	7ae <exit>
    wait(&status);
 4a4:	fcc40513          	addi	a0,s0,-52
 4a8:	30e000ef          	jal	7b6 <wait>
    if (status == 0) {
 4ac:	fcc42783          	lw	a5,-52(s0)
 4b0:	f3bd                	bnez	a5,416 <superpg_free+0xc0>
      err("child was able to reference free memory\n");
 4b2:	00001517          	auipc	a0,0x1
 4b6:	aae50513          	addi	a0,a0,-1362 # f60 <malloc+0x296>
 4ba:	b47ff0ef          	jal	0 <err>
    err("pte for freed memory is valid");
 4be:	00001517          	auipc	a0,0x1
 4c2:	b5a50513          	addi	a0,a0,-1190 # 1018 <malloc+0x34e>
 4c6:	b3bff0ef          	jal	0 <err>
      err("page hasn't been freed");
 4ca:	00001517          	auipc	a0,0x1
 4ce:	b6e50513          	addi	a0,a0,-1170 # 1038 <malloc+0x36e>
 4d2:	b2fff0ef          	jal	0 <err>

00000000000004d6 <main>:
{
 4d6:	1141                	addi	sp,sp,-16
 4d8:	e406                	sd	ra,8(sp)
 4da:	e022                	sd	s0,0(sp)
 4dc:	0800                	addi	s0,sp,16
  print_pgtbl();
 4de:	b89ff0ef          	jal	66 <print_pgtbl>
  ugetpid_test();
 4e2:	be5ff0ef          	jal	c6 <ugetpid_test>
  print_kpgtbl();
 4e6:	c81ff0ef          	jal	166 <print_kpgtbl>
  superpg_fork();
 4ea:	d97ff0ef          	jal	280 <superpg_fork>
  superpg_free();
 4ee:	e69ff0ef          	jal	356 <superpg_free>
  printf("pgtbltest: all tests succeeded\n");
 4f2:	00001517          	auipc	a0,0x1
 4f6:	b7650513          	addi	a0,a0,-1162 # 1068 <malloc+0x39e>
 4fa:	71c000ef          	jal	c16 <printf>
  exit(0);
 4fe:	4501                	li	a0,0
 500:	2ae000ef          	jal	7ae <exit>

0000000000000504 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 504:	1141                	addi	sp,sp,-16
 506:	e406                	sd	ra,8(sp)
 508:	e022                	sd	s0,0(sp)
 50a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 50c:	fcbff0ef          	jal	4d6 <main>
  exit(r);
 510:	29e000ef          	jal	7ae <exit>

0000000000000514 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 514:	1141                	addi	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 51a:	87aa                	mv	a5,a0
 51c:	0585                	addi	a1,a1,1 # 1001 <malloc+0x337>
 51e:	0785                	addi	a5,a5,1 # fffffffffffff001 <base+0xffffffffffffcfe1>
 520:	fff5c703          	lbu	a4,-1(a1)
 524:	fee78fa3          	sb	a4,-1(a5)
 528:	fb75                	bnez	a4,51c <strcpy+0x8>
    ;
  return os;
}
 52a:	6422                	ld	s0,8(sp)
 52c:	0141                	addi	sp,sp,16
 52e:	8082                	ret

0000000000000530 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 530:	1141                	addi	sp,sp,-16
 532:	e422                	sd	s0,8(sp)
 534:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 536:	00054783          	lbu	a5,0(a0)
 53a:	cb91                	beqz	a5,54e <strcmp+0x1e>
 53c:	0005c703          	lbu	a4,0(a1)
 540:	00f71763          	bne	a4,a5,54e <strcmp+0x1e>
    p++, q++;
 544:	0505                	addi	a0,a0,1
 546:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 548:	00054783          	lbu	a5,0(a0)
 54c:	fbe5                	bnez	a5,53c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 54e:	0005c503          	lbu	a0,0(a1)
}
 552:	40a7853b          	subw	a0,a5,a0
 556:	6422                	ld	s0,8(sp)
 558:	0141                	addi	sp,sp,16
 55a:	8082                	ret

000000000000055c <strlen>:

uint
strlen(const char *s)
{
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 562:	00054783          	lbu	a5,0(a0)
 566:	cf91                	beqz	a5,582 <strlen+0x26>
 568:	0505                	addi	a0,a0,1
 56a:	87aa                	mv	a5,a0
 56c:	86be                	mv	a3,a5
 56e:	0785                	addi	a5,a5,1
 570:	fff7c703          	lbu	a4,-1(a5)
 574:	ff65                	bnez	a4,56c <strlen+0x10>
 576:	40a6853b          	subw	a0,a3,a0
 57a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 57c:	6422                	ld	s0,8(sp)
 57e:	0141                	addi	sp,sp,16
 580:	8082                	ret
  for(n = 0; s[n]; n++)
 582:	4501                	li	a0,0
 584:	bfe5                	j	57c <strlen+0x20>

0000000000000586 <memset>:

void*
memset(void *dst, int c, uint n)
{
 586:	1141                	addi	sp,sp,-16
 588:	e422                	sd	s0,8(sp)
 58a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 58c:	ca19                	beqz	a2,5a2 <memset+0x1c>
 58e:	87aa                	mv	a5,a0
 590:	1602                	slli	a2,a2,0x20
 592:	9201                	srli	a2,a2,0x20
 594:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 598:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 59c:	0785                	addi	a5,a5,1
 59e:	fee79de3          	bne	a5,a4,598 <memset+0x12>
  }
  return dst;
}
 5a2:	6422                	ld	s0,8(sp)
 5a4:	0141                	addi	sp,sp,16
 5a6:	8082                	ret

00000000000005a8 <strchr>:

char*
strchr(const char *s, char c)
{
 5a8:	1141                	addi	sp,sp,-16
 5aa:	e422                	sd	s0,8(sp)
 5ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 5ae:	00054783          	lbu	a5,0(a0)
 5b2:	cb99                	beqz	a5,5c8 <strchr+0x20>
    if(*s == c)
 5b4:	00f58763          	beq	a1,a5,5c2 <strchr+0x1a>
  for(; *s; s++)
 5b8:	0505                	addi	a0,a0,1
 5ba:	00054783          	lbu	a5,0(a0)
 5be:	fbfd                	bnez	a5,5b4 <strchr+0xc>
      return (char*)s;
  return 0;
 5c0:	4501                	li	a0,0
}
 5c2:	6422                	ld	s0,8(sp)
 5c4:	0141                	addi	sp,sp,16
 5c6:	8082                	ret
  return 0;
 5c8:	4501                	li	a0,0
 5ca:	bfe5                	j	5c2 <strchr+0x1a>

00000000000005cc <gets>:

char*
gets(char *buf, int max)
{
 5cc:	711d                	addi	sp,sp,-96
 5ce:	ec86                	sd	ra,88(sp)
 5d0:	e8a2                	sd	s0,80(sp)
 5d2:	e4a6                	sd	s1,72(sp)
 5d4:	e0ca                	sd	s2,64(sp)
 5d6:	fc4e                	sd	s3,56(sp)
 5d8:	f852                	sd	s4,48(sp)
 5da:	f456                	sd	s5,40(sp)
 5dc:	f05a                	sd	s6,32(sp)
 5de:	ec5e                	sd	s7,24(sp)
 5e0:	1080                	addi	s0,sp,96
 5e2:	8baa                	mv	s7,a0
 5e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5e6:	892a                	mv	s2,a0
 5e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 5ea:	4aa9                	li	s5,10
 5ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5ee:	89a6                	mv	s3,s1
 5f0:	2485                	addiw	s1,s1,1
 5f2:	0344d663          	bge	s1,s4,61e <gets+0x52>
    cc = read(0, &c, 1);
 5f6:	4605                	li	a2,1
 5f8:	faf40593          	addi	a1,s0,-81
 5fc:	4501                	li	a0,0
 5fe:	1c8000ef          	jal	7c6 <read>
    if(cc < 1)
 602:	00a05e63          	blez	a0,61e <gets+0x52>
    buf[i++] = c;
 606:	faf44783          	lbu	a5,-81(s0)
 60a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 60e:	01578763          	beq	a5,s5,61c <gets+0x50>
 612:	0905                	addi	s2,s2,1
 614:	fd679de3          	bne	a5,s6,5ee <gets+0x22>
    buf[i++] = c;
 618:	89a6                	mv	s3,s1
 61a:	a011                	j	61e <gets+0x52>
 61c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 61e:	99de                	add	s3,s3,s7
 620:	00098023          	sb	zero,0(s3)
  return buf;
}
 624:	855e                	mv	a0,s7
 626:	60e6                	ld	ra,88(sp)
 628:	6446                	ld	s0,80(sp)
 62a:	64a6                	ld	s1,72(sp)
 62c:	6906                	ld	s2,64(sp)
 62e:	79e2                	ld	s3,56(sp)
 630:	7a42                	ld	s4,48(sp)
 632:	7aa2                	ld	s5,40(sp)
 634:	7b02                	ld	s6,32(sp)
 636:	6be2                	ld	s7,24(sp)
 638:	6125                	addi	sp,sp,96
 63a:	8082                	ret

000000000000063c <stat>:

int
stat(const char *n, struct stat *st)
{
 63c:	1101                	addi	sp,sp,-32
 63e:	ec06                	sd	ra,24(sp)
 640:	e822                	sd	s0,16(sp)
 642:	e04a                	sd	s2,0(sp)
 644:	1000                	addi	s0,sp,32
 646:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 648:	4581                	li	a1,0
 64a:	1a4000ef          	jal	7ee <open>
  if(fd < 0)
 64e:	02054263          	bltz	a0,672 <stat+0x36>
 652:	e426                	sd	s1,8(sp)
 654:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 656:	85ca                	mv	a1,s2
 658:	1ae000ef          	jal	806 <fstat>
 65c:	892a                	mv	s2,a0
  close(fd);
 65e:	8526                	mv	a0,s1
 660:	176000ef          	jal	7d6 <close>
  return r;
 664:	64a2                	ld	s1,8(sp)
}
 666:	854a                	mv	a0,s2
 668:	60e2                	ld	ra,24(sp)
 66a:	6442                	ld	s0,16(sp)
 66c:	6902                	ld	s2,0(sp)
 66e:	6105                	addi	sp,sp,32
 670:	8082                	ret
    return -1;
 672:	597d                	li	s2,-1
 674:	bfcd                	j	666 <stat+0x2a>

0000000000000676 <atoi>:

int
atoi(const char *s)
{
 676:	1141                	addi	sp,sp,-16
 678:	e422                	sd	s0,8(sp)
 67a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 67c:	00054683          	lbu	a3,0(a0)
 680:	fd06879b          	addiw	a5,a3,-48 # ffffffffffdfffd0 <base+0xffffffffffdfdfb0>
 684:	0ff7f793          	zext.b	a5,a5
 688:	4625                	li	a2,9
 68a:	02f66863          	bltu	a2,a5,6ba <atoi+0x44>
 68e:	872a                	mv	a4,a0
  n = 0;
 690:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 692:	0705                	addi	a4,a4,1 # ffffffffffe00001 <base+0xffffffffffdfdfe1>
 694:	0025179b          	slliw	a5,a0,0x2
 698:	9fa9                	addw	a5,a5,a0
 69a:	0017979b          	slliw	a5,a5,0x1
 69e:	9fb5                	addw	a5,a5,a3
 6a0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6a4:	00074683          	lbu	a3,0(a4)
 6a8:	fd06879b          	addiw	a5,a3,-48
 6ac:	0ff7f793          	zext.b	a5,a5
 6b0:	fef671e3          	bgeu	a2,a5,692 <atoi+0x1c>
  return n;
}
 6b4:	6422                	ld	s0,8(sp)
 6b6:	0141                	addi	sp,sp,16
 6b8:	8082                	ret
  n = 0;
 6ba:	4501                	li	a0,0
 6bc:	bfe5                	j	6b4 <atoi+0x3e>

00000000000006be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6be:	1141                	addi	sp,sp,-16
 6c0:	e422                	sd	s0,8(sp)
 6c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6c4:	02b57463          	bgeu	a0,a1,6ec <memmove+0x2e>
    while(n-- > 0)
 6c8:	00c05f63          	blez	a2,6e6 <memmove+0x28>
 6cc:	1602                	slli	a2,a2,0x20
 6ce:	9201                	srli	a2,a2,0x20
 6d0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6d4:	872a                	mv	a4,a0
      *dst++ = *src++;
 6d6:	0585                	addi	a1,a1,1
 6d8:	0705                	addi	a4,a4,1
 6da:	fff5c683          	lbu	a3,-1(a1)
 6de:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6e2:	fef71ae3          	bne	a4,a5,6d6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6e6:	6422                	ld	s0,8(sp)
 6e8:	0141                	addi	sp,sp,16
 6ea:	8082                	ret
    dst += n;
 6ec:	00c50733          	add	a4,a0,a2
    src += n;
 6f0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6f2:	fec05ae3          	blez	a2,6e6 <memmove+0x28>
 6f6:	fff6079b          	addiw	a5,a2,-1 # 1fffff <base+0x1fdfdf>
 6fa:	1782                	slli	a5,a5,0x20
 6fc:	9381                	srli	a5,a5,0x20
 6fe:	fff7c793          	not	a5,a5
 702:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 704:	15fd                	addi	a1,a1,-1
 706:	177d                	addi	a4,a4,-1
 708:	0005c683          	lbu	a3,0(a1)
 70c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 710:	fee79ae3          	bne	a5,a4,704 <memmove+0x46>
 714:	bfc9                	j	6e6 <memmove+0x28>

0000000000000716 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 716:	1141                	addi	sp,sp,-16
 718:	e422                	sd	s0,8(sp)
 71a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 71c:	ca05                	beqz	a2,74c <memcmp+0x36>
 71e:	fff6069b          	addiw	a3,a2,-1
 722:	1682                	slli	a3,a3,0x20
 724:	9281                	srli	a3,a3,0x20
 726:	0685                	addi	a3,a3,1
 728:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 72a:	00054783          	lbu	a5,0(a0)
 72e:	0005c703          	lbu	a4,0(a1)
 732:	00e79863          	bne	a5,a4,742 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 736:	0505                	addi	a0,a0,1
    p2++;
 738:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 73a:	fed518e3          	bne	a0,a3,72a <memcmp+0x14>
  }
  return 0;
 73e:	4501                	li	a0,0
 740:	a019                	j	746 <memcmp+0x30>
      return *p1 - *p2;
 742:	40e7853b          	subw	a0,a5,a4
}
 746:	6422                	ld	s0,8(sp)
 748:	0141                	addi	sp,sp,16
 74a:	8082                	ret
  return 0;
 74c:	4501                	li	a0,0
 74e:	bfe5                	j	746 <memcmp+0x30>

0000000000000750 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 750:	1141                	addi	sp,sp,-16
 752:	e406                	sd	ra,8(sp)
 754:	e022                	sd	s0,0(sp)
 756:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 758:	f67ff0ef          	jal	6be <memmove>
}
 75c:	60a2                	ld	ra,8(sp)
 75e:	6402                	ld	s0,0(sp)
 760:	0141                	addi	sp,sp,16
 762:	8082                	ret

0000000000000764 <sbrk>:

char *
sbrk(int n) {
 764:	1141                	addi	sp,sp,-16
 766:	e406                	sd	ra,8(sp)
 768:	e022                	sd	s0,0(sp)
 76a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 76c:	4585                	li	a1,1
 76e:	0c8000ef          	jal	836 <sys_sbrk>
}
 772:	60a2                	ld	ra,8(sp)
 774:	6402                	ld	s0,0(sp)
 776:	0141                	addi	sp,sp,16
 778:	8082                	ret

000000000000077a <sbrklazy>:

char *
sbrklazy(int n) {
 77a:	1141                	addi	sp,sp,-16
 77c:	e406                	sd	ra,8(sp)
 77e:	e022                	sd	s0,0(sp)
 780:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 782:	4589                	li	a1,2
 784:	0b2000ef          	jal	836 <sys_sbrk>
}
 788:	60a2                	ld	ra,8(sp)
 78a:	6402                	ld	s0,0(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret

0000000000000790 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 790:	1141                	addi	sp,sp,-16
 792:	e422                	sd	s0,8(sp)
 794:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 796:	040007b7          	lui	a5,0x4000
 79a:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffdfdd>
 79c:	07b2                	slli	a5,a5,0xc
}
 79e:	4388                	lw	a0,0(a5)
 7a0:	6422                	ld	s0,8(sp)
 7a2:	0141                	addi	sp,sp,16
 7a4:	8082                	ret

00000000000007a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7a6:	4885                	li	a7,1
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 7ae:	4889                	li	a7,2
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7b6:	488d                	li	a7,3
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7be:	4891                	li	a7,4
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <read>:
.global read
read:
 li a7, SYS_read
 7c6:	4895                	li	a7,5
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <write>:
.global write
write:
 li a7, SYS_write
 7ce:	48c1                	li	a7,16
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <close>:
.global close
close:
 li a7, SYS_close
 7d6:	48d5                	li	a7,21
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <kill>:
.global kill
kill:
 li a7, SYS_kill
 7de:	4899                	li	a7,6
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7e6:	489d                	li	a7,7
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <open>:
.global open
open:
 li a7, SYS_open
 7ee:	48bd                	li	a7,15
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7f6:	48c5                	li	a7,17
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7fe:	48c9                	li	a7,18
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 806:	48a1                	li	a7,8
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <link>:
.global link
link:
 li a7, SYS_link
 80e:	48cd                	li	a7,19
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 816:	48d1                	li	a7,20
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 81e:	48a5                	li	a7,9
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <dup>:
.global dup
dup:
 li a7, SYS_dup
 826:	48a9                	li	a7,10
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 82e:	48ad                	li	a7,11
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 836:	48b1                	li	a7,12
 ecall
 838:	00000073          	ecall
 ret
 83c:	8082                	ret

000000000000083e <pause>:
.global pause
pause:
 li a7, SYS_pause
 83e:	48b5                	li	a7,13
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 846:	48b9                	li	a7,14
 ecall
 848:	00000073          	ecall
 ret
 84c:	8082                	ret

000000000000084e <bind>:
.global bind
bind:
 li a7, SYS_bind
 84e:	48f5                	li	a7,29
 ecall
 850:	00000073          	ecall
 ret
 854:	8082                	ret

0000000000000856 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 856:	48f9                	li	a7,30
 ecall
 858:	00000073          	ecall
 ret
 85c:	8082                	ret

000000000000085e <send>:
.global send
send:
 li a7, SYS_send
 85e:	48fd                	li	a7,31
 ecall
 860:	00000073          	ecall
 ret
 864:	8082                	ret

0000000000000866 <recv>:
.global recv
recv:
 li a7, SYS_recv
 866:	02000893          	li	a7,32
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 870:	02100893          	li	a7,33
 ecall
 874:	00000073          	ecall
 ret
 878:	8082                	ret

000000000000087a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 87a:	02200893          	li	a7,34
 ecall
 87e:	00000073          	ecall
 ret
 882:	8082                	ret

0000000000000884 <prac>:
.global prac
prac:
 li a7, SYS_prac
 884:	02300893          	li	a7,35
 ecall
 888:	00000073          	ecall
 ret
 88c:	8082                	ret

000000000000088e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 88e:	1101                	addi	sp,sp,-32
 890:	ec06                	sd	ra,24(sp)
 892:	e822                	sd	s0,16(sp)
 894:	1000                	addi	s0,sp,32
 896:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 89a:	4605                	li	a2,1
 89c:	fef40593          	addi	a1,s0,-17
 8a0:	f2fff0ef          	jal	7ce <write>
}
 8a4:	60e2                	ld	ra,24(sp)
 8a6:	6442                	ld	s0,16(sp)
 8a8:	6105                	addi	sp,sp,32
 8aa:	8082                	ret

00000000000008ac <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 8ac:	715d                	addi	sp,sp,-80
 8ae:	e486                	sd	ra,72(sp)
 8b0:	e0a2                	sd	s0,64(sp)
 8b2:	f84a                	sd	s2,48(sp)
 8b4:	0880                	addi	s0,sp,80
 8b6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 8b8:	c299                	beqz	a3,8be <printint+0x12>
 8ba:	0805c363          	bltz	a1,940 <printint+0x94>
  neg = 0;
 8be:	4881                	li	a7,0
 8c0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 8c4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 8c6:	00000517          	auipc	a0,0x0
 8ca:	7d250513          	addi	a0,a0,2002 # 1098 <digits>
 8ce:	883e                	mv	a6,a5
 8d0:	2785                	addiw	a5,a5,1
 8d2:	02c5f733          	remu	a4,a1,a2
 8d6:	972a                	add	a4,a4,a0
 8d8:	00074703          	lbu	a4,0(a4)
 8dc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 8e0:	872e                	mv	a4,a1
 8e2:	02c5d5b3          	divu	a1,a1,a2
 8e6:	0685                	addi	a3,a3,1
 8e8:	fec773e3          	bgeu	a4,a2,8ce <printint+0x22>
  if(neg)
 8ec:	00088b63          	beqz	a7,902 <printint+0x56>
    buf[i++] = '-';
 8f0:	fd078793          	addi	a5,a5,-48
 8f4:	97a2                	add	a5,a5,s0
 8f6:	02d00713          	li	a4,45
 8fa:	fee78423          	sb	a4,-24(a5)
 8fe:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 902:	02f05a63          	blez	a5,936 <printint+0x8a>
 906:	fc26                	sd	s1,56(sp)
 908:	f44e                	sd	s3,40(sp)
 90a:	fb840713          	addi	a4,s0,-72
 90e:	00f704b3          	add	s1,a4,a5
 912:	fff70993          	addi	s3,a4,-1
 916:	99be                	add	s3,s3,a5
 918:	37fd                	addiw	a5,a5,-1
 91a:	1782                	slli	a5,a5,0x20
 91c:	9381                	srli	a5,a5,0x20
 91e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 922:	fff4c583          	lbu	a1,-1(s1)
 926:	854a                	mv	a0,s2
 928:	f67ff0ef          	jal	88e <putc>
  while(--i >= 0)
 92c:	14fd                	addi	s1,s1,-1
 92e:	ff349ae3          	bne	s1,s3,922 <printint+0x76>
 932:	74e2                	ld	s1,56(sp)
 934:	79a2                	ld	s3,40(sp)
}
 936:	60a6                	ld	ra,72(sp)
 938:	6406                	ld	s0,64(sp)
 93a:	7942                	ld	s2,48(sp)
 93c:	6161                	addi	sp,sp,80
 93e:	8082                	ret
    x = -xx;
 940:	40b005b3          	neg	a1,a1
    neg = 1;
 944:	4885                	li	a7,1
    x = -xx;
 946:	bfad                	j	8c0 <printint+0x14>

0000000000000948 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 948:	711d                	addi	sp,sp,-96
 94a:	ec86                	sd	ra,88(sp)
 94c:	e8a2                	sd	s0,80(sp)
 94e:	e0ca                	sd	s2,64(sp)
 950:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 952:	0005c903          	lbu	s2,0(a1)
 956:	28090663          	beqz	s2,be2 <vprintf+0x29a>
 95a:	e4a6                	sd	s1,72(sp)
 95c:	fc4e                	sd	s3,56(sp)
 95e:	f852                	sd	s4,48(sp)
 960:	f456                	sd	s5,40(sp)
 962:	f05a                	sd	s6,32(sp)
 964:	ec5e                	sd	s7,24(sp)
 966:	e862                	sd	s8,16(sp)
 968:	e466                	sd	s9,8(sp)
 96a:	8b2a                	mv	s6,a0
 96c:	8a2e                	mv	s4,a1
 96e:	8bb2                	mv	s7,a2
  state = 0;
 970:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 972:	4481                	li	s1,0
 974:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 976:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 97a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 97e:	06c00c93          	li	s9,108
 982:	a005                	j	9a2 <vprintf+0x5a>
        putc(fd, c0);
 984:	85ca                	mv	a1,s2
 986:	855a                	mv	a0,s6
 988:	f07ff0ef          	jal	88e <putc>
 98c:	a019                	j	992 <vprintf+0x4a>
    } else if(state == '%'){
 98e:	03598263          	beq	s3,s5,9b2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 992:	2485                	addiw	s1,s1,1
 994:	8726                	mv	a4,s1
 996:	009a07b3          	add	a5,s4,s1
 99a:	0007c903          	lbu	s2,0(a5)
 99e:	22090a63          	beqz	s2,bd2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 9a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 9a6:	fe0994e3          	bnez	s3,98e <vprintf+0x46>
      if(c0 == '%'){
 9aa:	fd579de3          	bne	a5,s5,984 <vprintf+0x3c>
        state = '%';
 9ae:	89be                	mv	s3,a5
 9b0:	b7cd                	j	992 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 9b2:	00ea06b3          	add	a3,s4,a4
 9b6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 9ba:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 9bc:	c681                	beqz	a3,9c4 <vprintf+0x7c>
 9be:	9752                	add	a4,a4,s4
 9c0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 9c4:	05878363          	beq	a5,s8,a0a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 9c8:	05978d63          	beq	a5,s9,a22 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 9cc:	07500713          	li	a4,117
 9d0:	0ee78763          	beq	a5,a4,abe <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 9d4:	07800713          	li	a4,120
 9d8:	12e78963          	beq	a5,a4,b0a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 9dc:	07000713          	li	a4,112
 9e0:	14e78e63          	beq	a5,a4,b3c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 9e4:	06300713          	li	a4,99
 9e8:	18e78e63          	beq	a5,a4,b84 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 9ec:	07300713          	li	a4,115
 9f0:	1ae78463          	beq	a5,a4,b98 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9f4:	02500713          	li	a4,37
 9f8:	04e79563          	bne	a5,a4,a42 <vprintf+0xfa>
        putc(fd, '%');
 9fc:	02500593          	li	a1,37
 a00:	855a                	mv	a0,s6
 a02:	e8dff0ef          	jal	88e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 a06:	4981                	li	s3,0
 a08:	b769                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 a0a:	008b8913          	addi	s2,s7,8
 a0e:	4685                	li	a3,1
 a10:	4629                	li	a2,10
 a12:	000ba583          	lw	a1,0(s7)
 a16:	855a                	mv	a0,s6
 a18:	e95ff0ef          	jal	8ac <printint>
 a1c:	8bca                	mv	s7,s2
      state = 0;
 a1e:	4981                	li	s3,0
 a20:	bf8d                	j	992 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 a22:	06400793          	li	a5,100
 a26:	02f68963          	beq	a3,a5,a58 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a2a:	06c00793          	li	a5,108
 a2e:	04f68263          	beq	a3,a5,a72 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 a32:	07500793          	li	a5,117
 a36:	0af68063          	beq	a3,a5,ad6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 a3a:	07800793          	li	a5,120
 a3e:	0ef68263          	beq	a3,a5,b22 <vprintf+0x1da>
        putc(fd, '%');
 a42:	02500593          	li	a1,37
 a46:	855a                	mv	a0,s6
 a48:	e47ff0ef          	jal	88e <putc>
        putc(fd, c0);
 a4c:	85ca                	mv	a1,s2
 a4e:	855a                	mv	a0,s6
 a50:	e3fff0ef          	jal	88e <putc>
      state = 0;
 a54:	4981                	li	s3,0
 a56:	bf35                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a58:	008b8913          	addi	s2,s7,8
 a5c:	4685                	li	a3,1
 a5e:	4629                	li	a2,10
 a60:	000bb583          	ld	a1,0(s7)
 a64:	855a                	mv	a0,s6
 a66:	e47ff0ef          	jal	8ac <printint>
        i += 1;
 a6a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a6c:	8bca                	mv	s7,s2
      state = 0;
 a6e:	4981                	li	s3,0
        i += 1;
 a70:	b70d                	j	992 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a72:	06400793          	li	a5,100
 a76:	02f60763          	beq	a2,a5,aa4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a7a:	07500793          	li	a5,117
 a7e:	06f60963          	beq	a2,a5,af0 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a82:	07800793          	li	a5,120
 a86:	faf61ee3          	bne	a2,a5,a42 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a8a:	008b8913          	addi	s2,s7,8
 a8e:	4681                	li	a3,0
 a90:	4641                	li	a2,16
 a92:	000bb583          	ld	a1,0(s7)
 a96:	855a                	mv	a0,s6
 a98:	e15ff0ef          	jal	8ac <printint>
        i += 2;
 a9c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a9e:	8bca                	mv	s7,s2
      state = 0;
 aa0:	4981                	li	s3,0
        i += 2;
 aa2:	bdc5                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 aa4:	008b8913          	addi	s2,s7,8
 aa8:	4685                	li	a3,1
 aaa:	4629                	li	a2,10
 aac:	000bb583          	ld	a1,0(s7)
 ab0:	855a                	mv	a0,s6
 ab2:	dfbff0ef          	jal	8ac <printint>
        i += 2;
 ab6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 ab8:	8bca                	mv	s7,s2
      state = 0;
 aba:	4981                	li	s3,0
        i += 2;
 abc:	bdd9                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 abe:	008b8913          	addi	s2,s7,8
 ac2:	4681                	li	a3,0
 ac4:	4629                	li	a2,10
 ac6:	000be583          	lwu	a1,0(s7)
 aca:	855a                	mv	a0,s6
 acc:	de1ff0ef          	jal	8ac <printint>
 ad0:	8bca                	mv	s7,s2
      state = 0;
 ad2:	4981                	li	s3,0
 ad4:	bd7d                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 ad6:	008b8913          	addi	s2,s7,8
 ada:	4681                	li	a3,0
 adc:	4629                	li	a2,10
 ade:	000bb583          	ld	a1,0(s7)
 ae2:	855a                	mv	a0,s6
 ae4:	dc9ff0ef          	jal	8ac <printint>
        i += 1;
 ae8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 aea:	8bca                	mv	s7,s2
      state = 0;
 aec:	4981                	li	s3,0
        i += 1;
 aee:	b555                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 af0:	008b8913          	addi	s2,s7,8
 af4:	4681                	li	a3,0
 af6:	4629                	li	a2,10
 af8:	000bb583          	ld	a1,0(s7)
 afc:	855a                	mv	a0,s6
 afe:	dafff0ef          	jal	8ac <printint>
        i += 2;
 b02:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 b04:	8bca                	mv	s7,s2
      state = 0;
 b06:	4981                	li	s3,0
        i += 2;
 b08:	b569                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 b0a:	008b8913          	addi	s2,s7,8
 b0e:	4681                	li	a3,0
 b10:	4641                	li	a2,16
 b12:	000be583          	lwu	a1,0(s7)
 b16:	855a                	mv	a0,s6
 b18:	d95ff0ef          	jal	8ac <printint>
 b1c:	8bca                	mv	s7,s2
      state = 0;
 b1e:	4981                	li	s3,0
 b20:	bd8d                	j	992 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b22:	008b8913          	addi	s2,s7,8
 b26:	4681                	li	a3,0
 b28:	4641                	li	a2,16
 b2a:	000bb583          	ld	a1,0(s7)
 b2e:	855a                	mv	a0,s6
 b30:	d7dff0ef          	jal	8ac <printint>
        i += 1;
 b34:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 b36:	8bca                	mv	s7,s2
      state = 0;
 b38:	4981                	li	s3,0
        i += 1;
 b3a:	bda1                	j	992 <vprintf+0x4a>
 b3c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 b3e:	008b8d13          	addi	s10,s7,8
 b42:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 b46:	03000593          	li	a1,48
 b4a:	855a                	mv	a0,s6
 b4c:	d43ff0ef          	jal	88e <putc>
  putc(fd, 'x');
 b50:	07800593          	li	a1,120
 b54:	855a                	mv	a0,s6
 b56:	d39ff0ef          	jal	88e <putc>
 b5a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b5c:	00000b97          	auipc	s7,0x0
 b60:	53cb8b93          	addi	s7,s7,1340 # 1098 <digits>
 b64:	03c9d793          	srli	a5,s3,0x3c
 b68:	97de                	add	a5,a5,s7
 b6a:	0007c583          	lbu	a1,0(a5)
 b6e:	855a                	mv	a0,s6
 b70:	d1fff0ef          	jal	88e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b74:	0992                	slli	s3,s3,0x4
 b76:	397d                	addiw	s2,s2,-1
 b78:	fe0916e3          	bnez	s2,b64 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 b7c:	8bea                	mv	s7,s10
      state = 0;
 b7e:	4981                	li	s3,0
 b80:	6d02                	ld	s10,0(sp)
 b82:	bd01                	j	992 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 b84:	008b8913          	addi	s2,s7,8
 b88:	000bc583          	lbu	a1,0(s7)
 b8c:	855a                	mv	a0,s6
 b8e:	d01ff0ef          	jal	88e <putc>
 b92:	8bca                	mv	s7,s2
      state = 0;
 b94:	4981                	li	s3,0
 b96:	bbf5                	j	992 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 b98:	008b8993          	addi	s3,s7,8
 b9c:	000bb903          	ld	s2,0(s7)
 ba0:	00090f63          	beqz	s2,bbe <vprintf+0x276>
        for(; *s; s++)
 ba4:	00094583          	lbu	a1,0(s2)
 ba8:	c195                	beqz	a1,bcc <vprintf+0x284>
          putc(fd, *s);
 baa:	855a                	mv	a0,s6
 bac:	ce3ff0ef          	jal	88e <putc>
        for(; *s; s++)
 bb0:	0905                	addi	s2,s2,1
 bb2:	00094583          	lbu	a1,0(s2)
 bb6:	f9f5                	bnez	a1,baa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 bb8:	8bce                	mv	s7,s3
      state = 0;
 bba:	4981                	li	s3,0
 bbc:	bbd9                	j	992 <vprintf+0x4a>
          s = "(null)";
 bbe:	00000917          	auipc	s2,0x0
 bc2:	4d290913          	addi	s2,s2,1234 # 1090 <malloc+0x3c6>
        for(; *s; s++)
 bc6:	02800593          	li	a1,40
 bca:	b7c5                	j	baa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 bcc:	8bce                	mv	s7,s3
      state = 0;
 bce:	4981                	li	s3,0
 bd0:	b3c9                	j	992 <vprintf+0x4a>
 bd2:	64a6                	ld	s1,72(sp)
 bd4:	79e2                	ld	s3,56(sp)
 bd6:	7a42                	ld	s4,48(sp)
 bd8:	7aa2                	ld	s5,40(sp)
 bda:	7b02                	ld	s6,32(sp)
 bdc:	6be2                	ld	s7,24(sp)
 bde:	6c42                	ld	s8,16(sp)
 be0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 be2:	60e6                	ld	ra,88(sp)
 be4:	6446                	ld	s0,80(sp)
 be6:	6906                	ld	s2,64(sp)
 be8:	6125                	addi	sp,sp,96
 bea:	8082                	ret

0000000000000bec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 bec:	715d                	addi	sp,sp,-80
 bee:	ec06                	sd	ra,24(sp)
 bf0:	e822                	sd	s0,16(sp)
 bf2:	1000                	addi	s0,sp,32
 bf4:	e010                	sd	a2,0(s0)
 bf6:	e414                	sd	a3,8(s0)
 bf8:	e818                	sd	a4,16(s0)
 bfa:	ec1c                	sd	a5,24(s0)
 bfc:	03043023          	sd	a6,32(s0)
 c00:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c04:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c08:	8622                	mv	a2,s0
 c0a:	d3fff0ef          	jal	948 <vprintf>
}
 c0e:	60e2                	ld	ra,24(sp)
 c10:	6442                	ld	s0,16(sp)
 c12:	6161                	addi	sp,sp,80
 c14:	8082                	ret

0000000000000c16 <printf>:

void
printf(const char *fmt, ...)
{
 c16:	711d                	addi	sp,sp,-96
 c18:	ec06                	sd	ra,24(sp)
 c1a:	e822                	sd	s0,16(sp)
 c1c:	1000                	addi	s0,sp,32
 c1e:	e40c                	sd	a1,8(s0)
 c20:	e810                	sd	a2,16(s0)
 c22:	ec14                	sd	a3,24(s0)
 c24:	f018                	sd	a4,32(s0)
 c26:	f41c                	sd	a5,40(s0)
 c28:	03043823          	sd	a6,48(s0)
 c2c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c30:	00840613          	addi	a2,s0,8
 c34:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c38:	85aa                	mv	a1,a0
 c3a:	4505                	li	a0,1
 c3c:	d0dff0ef          	jal	948 <vprintf>
}
 c40:	60e2                	ld	ra,24(sp)
 c42:	6442                	ld	s0,16(sp)
 c44:	6125                	addi	sp,sp,96
 c46:	8082                	ret

0000000000000c48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c48:	1141                	addi	sp,sp,-16
 c4a:	e422                	sd	s0,8(sp)
 c4c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 c4e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c52:	00001797          	auipc	a5,0x1
 c56:	3be7b783          	ld	a5,958(a5) # 2010 <freep>
 c5a:	a02d                	j	c84 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 c5c:	4618                	lw	a4,8(a2)
 c5e:	9f2d                	addw	a4,a4,a1
 c60:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c64:	6398                	ld	a4,0(a5)
 c66:	6310                	ld	a2,0(a4)
 c68:	a83d                	j	ca6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c6a:	ff852703          	lw	a4,-8(a0)
 c6e:	9f31                	addw	a4,a4,a2
 c70:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c72:	ff053683          	ld	a3,-16(a0)
 c76:	a091                	j	cba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c78:	6398                	ld	a4,0(a5)
 c7a:	00e7e463          	bltu	a5,a4,c82 <free+0x3a>
 c7e:	00e6ea63          	bltu	a3,a4,c92 <free+0x4a>
{
 c82:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c84:	fed7fae3          	bgeu	a5,a3,c78 <free+0x30>
 c88:	6398                	ld	a4,0(a5)
 c8a:	00e6e463          	bltu	a3,a4,c92 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c8e:	fee7eae3          	bltu	a5,a4,c82 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c92:	ff852583          	lw	a1,-8(a0)
 c96:	6390                	ld	a2,0(a5)
 c98:	02059813          	slli	a6,a1,0x20
 c9c:	01c85713          	srli	a4,a6,0x1c
 ca0:	9736                	add	a4,a4,a3
 ca2:	fae60de3          	beq	a2,a4,c5c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ca6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 caa:	4790                	lw	a2,8(a5)
 cac:	02061593          	slli	a1,a2,0x20
 cb0:	01c5d713          	srli	a4,a1,0x1c
 cb4:	973e                	add	a4,a4,a5
 cb6:	fae68ae3          	beq	a3,a4,c6a <free+0x22>
    p->s.ptr = bp->s.ptr;
 cba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 cbc:	00001717          	auipc	a4,0x1
 cc0:	34f73a23          	sd	a5,852(a4) # 2010 <freep>
}
 cc4:	6422                	ld	s0,8(sp)
 cc6:	0141                	addi	sp,sp,16
 cc8:	8082                	ret

0000000000000cca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 cca:	7139                	addi	sp,sp,-64
 ccc:	fc06                	sd	ra,56(sp)
 cce:	f822                	sd	s0,48(sp)
 cd0:	f426                	sd	s1,40(sp)
 cd2:	ec4e                	sd	s3,24(sp)
 cd4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cd6:	02051493          	slli	s1,a0,0x20
 cda:	9081                	srli	s1,s1,0x20
 cdc:	04bd                	addi	s1,s1,15
 cde:	8091                	srli	s1,s1,0x4
 ce0:	0014899b          	addiw	s3,s1,1
 ce4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 ce6:	00001517          	auipc	a0,0x1
 cea:	32a53503          	ld	a0,810(a0) # 2010 <freep>
 cee:	c915                	beqz	a0,d22 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cf0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cf2:	4798                	lw	a4,8(a5)
 cf4:	08977a63          	bgeu	a4,s1,d88 <malloc+0xbe>
 cf8:	f04a                	sd	s2,32(sp)
 cfa:	e852                	sd	s4,16(sp)
 cfc:	e456                	sd	s5,8(sp)
 cfe:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 d00:	8a4e                	mv	s4,s3
 d02:	0009871b          	sext.w	a4,s3
 d06:	6685                	lui	a3,0x1
 d08:	00d77363          	bgeu	a4,a3,d0e <malloc+0x44>
 d0c:	6a05                	lui	s4,0x1
 d0e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 d12:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d16:	00001917          	auipc	s2,0x1
 d1a:	2fa90913          	addi	s2,s2,762 # 2010 <freep>
  if(p == SBRK_ERROR)
 d1e:	5afd                	li	s5,-1
 d20:	a081                	j	d60 <malloc+0x96>
 d22:	f04a                	sd	s2,32(sp)
 d24:	e852                	sd	s4,16(sp)
 d26:	e456                	sd	s5,8(sp)
 d28:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 d2a:	00001797          	auipc	a5,0x1
 d2e:	2f678793          	addi	a5,a5,758 # 2020 <base>
 d32:	00001717          	auipc	a4,0x1
 d36:	2cf73f23          	sd	a5,734(a4) # 2010 <freep>
 d3a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 d3c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 d40:	b7c1                	j	d00 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 d42:	6398                	ld	a4,0(a5)
 d44:	e118                	sd	a4,0(a0)
 d46:	a8a9                	j	da0 <malloc+0xd6>
  hp->s.size = nu;
 d48:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d4c:	0541                	addi	a0,a0,16
 d4e:	efbff0ef          	jal	c48 <free>
  return freep;
 d52:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d56:	c12d                	beqz	a0,db8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d58:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d5a:	4798                	lw	a4,8(a5)
 d5c:	02977263          	bgeu	a4,s1,d80 <malloc+0xb6>
    if(p == freep)
 d60:	00093703          	ld	a4,0(s2)
 d64:	853e                	mv	a0,a5
 d66:	fef719e3          	bne	a4,a5,d58 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 d6a:	8552                	mv	a0,s4
 d6c:	9f9ff0ef          	jal	764 <sbrk>
  if(p == SBRK_ERROR)
 d70:	fd551ce3          	bne	a0,s5,d48 <malloc+0x7e>
        return 0;
 d74:	4501                	li	a0,0
 d76:	7902                	ld	s2,32(sp)
 d78:	6a42                	ld	s4,16(sp)
 d7a:	6aa2                	ld	s5,8(sp)
 d7c:	6b02                	ld	s6,0(sp)
 d7e:	a03d                	j	dac <malloc+0xe2>
 d80:	7902                	ld	s2,32(sp)
 d82:	6a42                	ld	s4,16(sp)
 d84:	6aa2                	ld	s5,8(sp)
 d86:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d88:	fae48de3          	beq	s1,a4,d42 <malloc+0x78>
        p->s.size -= nunits;
 d8c:	4137073b          	subw	a4,a4,s3
 d90:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d92:	02071693          	slli	a3,a4,0x20
 d96:	01c6d713          	srli	a4,a3,0x1c
 d9a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d9c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 da0:	00001717          	auipc	a4,0x1
 da4:	26a73823          	sd	a0,624(a4) # 2010 <freep>
      return (void*)(p + 1);
 da8:	01078513          	addi	a0,a5,16
  }
}
 dac:	70e2                	ld	ra,56(sp)
 dae:	7442                	ld	s0,48(sp)
 db0:	74a2                	ld	s1,40(sp)
 db2:	69e2                	ld	s3,24(sp)
 db4:	6121                	addi	sp,sp,64
 db6:	8082                	ret
 db8:	7902                	ld	s2,32(sp)
 dba:	6a42                	ld	s4,16(sp)
 dbc:	6aa2                	ld	s5,8(sp)
 dbe:	6b02                	ld	s6,0(sp)
 dc0:	b7f5                	j	dac <malloc+0xe2>
