
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
}
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	addi	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:

void
go(int which_child)
{
      74:	7159                	addi	sp,sp,-112
      76:	f486                	sd	ra,104(sp)
      78:	f0a2                	sd	s0,96(sp)
      7a:	eca6                	sd	s1,88(sp)
      7c:	fc56                	sd	s5,56(sp)
      7e:	1880                	addi	s0,sp,112
      80:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      82:	4501                	li	a0,0
      84:	2bb000ef          	jal	b3e <sbrk>
      88:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      8a:	00001517          	auipc	a0,0x1
      8e:	11650513          	addi	a0,a0,278 # 11a0 <malloc+0xfc>
      92:	35f000ef          	jal	bf0 <mkdir>
  if(chdir("grindir") != 0){
      96:	00001517          	auipc	a0,0x1
      9a:	10a50513          	addi	a0,a0,266 # 11a0 <malloc+0xfc>
      9e:	35b000ef          	jal	bf8 <chdir>
      a2:	cd11                	beqz	a0,be <go+0x4a>
      a4:	e8ca                	sd	s2,80(sp)
      a6:	e4ce                	sd	s3,72(sp)
      a8:	e0d2                	sd	s4,64(sp)
      aa:	f85a                	sd	s6,48(sp)
    printf("grind: chdir grindir failed\n");
      ac:	00001517          	auipc	a0,0x1
      b0:	0fc50513          	addi	a0,a0,252 # 11a8 <malloc+0x104>
      b4:	73d000ef          	jal	ff0 <printf>
    exit(1);
      b8:	4505                	li	a0,1
      ba:	2cf000ef          	jal	b88 <exit>
      be:	e8ca                	sd	s2,80(sp)
      c0:	e4ce                	sd	s3,72(sp)
      c2:	e0d2                	sd	s4,64(sp)
      c4:	f85a                	sd	s6,48(sp)
  }
  chdir("/");
      c6:	00001517          	auipc	a0,0x1
      ca:	10a50513          	addi	a0,a0,266 # 11d0 <malloc+0x12c>
      ce:	32b000ef          	jal	bf8 <chdir>
      d2:	00001997          	auipc	s3,0x1
      d6:	10e98993          	addi	s3,s3,270 # 11e0 <malloc+0x13c>
      da:	c489                	beqz	s1,e4 <go+0x70>
      dc:	00001997          	auipc	s3,0x1
      e0:	0fc98993          	addi	s3,s3,252 # 11d8 <malloc+0x134>
  uint64 iters = 0;
      e4:	4481                	li	s1,0
  int fd = -1;
      e6:	5a7d                	li	s4,-1
      e8:	00001917          	auipc	s2,0x1
      ec:	3c890913          	addi	s2,s2,968 # 14b0 <malloc+0x40c>
      f0:	a819                	j	106 <go+0x92>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      f2:	20200593          	li	a1,514
      f6:	00001517          	auipc	a0,0x1
      fa:	0f250513          	addi	a0,a0,242 # 11e8 <malloc+0x144>
      fe:	2cb000ef          	jal	bc8 <open>
     102:	2af000ef          	jal	bb0 <close>
    iters++;
     106:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     108:	1f400793          	li	a5,500
     10c:	02f4f7b3          	remu	a5,s1,a5
     110:	e791                	bnez	a5,11c <go+0xa8>
      write(1, which_child?"B":"A", 1);
     112:	4605                	li	a2,1
     114:	85ce                	mv	a1,s3
     116:	4505                	li	a0,1
     118:	291000ef          	jal	ba8 <write>
    int what = rand() % 23;
     11c:	f3dff0ef          	jal	58 <rand>
     120:	47dd                	li	a5,23
     122:	02f5653b          	remw	a0,a0,a5
     126:	0005071b          	sext.w	a4,a0
     12a:	47d9                	li	a5,22
     12c:	fce7ede3          	bltu	a5,a4,106 <go+0x92>
     130:	02051793          	slli	a5,a0,0x20
     134:	01e7d513          	srli	a0,a5,0x1e
     138:	954a                	add	a0,a0,s2
     13a:	411c                	lw	a5,0(a0)
     13c:	97ca                	add	a5,a5,s2
     13e:	8782                	jr	a5
    } else if(what == 2){
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     140:	20200593          	li	a1,514
     144:	00001517          	auipc	a0,0x1
     148:	0b450513          	addi	a0,a0,180 # 11f8 <malloc+0x154>
     14c:	27d000ef          	jal	bc8 <open>
     150:	261000ef          	jal	bb0 <close>
     154:	bf4d                	j	106 <go+0x92>
    } else if(what == 3){
      unlink("grindir/../a");
     156:	00001517          	auipc	a0,0x1
     15a:	09250513          	addi	a0,a0,146 # 11e8 <malloc+0x144>
     15e:	27b000ef          	jal	bd8 <unlink>
     162:	b755                	j	106 <go+0x92>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     164:	00001517          	auipc	a0,0x1
     168:	03c50513          	addi	a0,a0,60 # 11a0 <malloc+0xfc>
     16c:	28d000ef          	jal	bf8 <chdir>
     170:	ed11                	bnez	a0,18c <go+0x118>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     172:	00001517          	auipc	a0,0x1
     176:	09e50513          	addi	a0,a0,158 # 1210 <malloc+0x16c>
     17a:	25f000ef          	jal	bd8 <unlink>
      chdir("/");
     17e:	00001517          	auipc	a0,0x1
     182:	05250513          	addi	a0,a0,82 # 11d0 <malloc+0x12c>
     186:	273000ef          	jal	bf8 <chdir>
     18a:	bfb5                	j	106 <go+0x92>
        printf("grind: chdir grindir failed\n");
     18c:	00001517          	auipc	a0,0x1
     190:	01c50513          	addi	a0,a0,28 # 11a8 <malloc+0x104>
     194:	65d000ef          	jal	ff0 <printf>
        exit(1);
     198:	4505                	li	a0,1
     19a:	1ef000ef          	jal	b88 <exit>
    } else if(what == 5){
      close(fd);
     19e:	8552                	mv	a0,s4
     1a0:	211000ef          	jal	bb0 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1a4:	20200593          	li	a1,514
     1a8:	00001517          	auipc	a0,0x1
     1ac:	07050513          	addi	a0,a0,112 # 1218 <malloc+0x174>
     1b0:	219000ef          	jal	bc8 <open>
     1b4:	8a2a                	mv	s4,a0
     1b6:	bf81                	j	106 <go+0x92>
    } else if(what == 6){
      close(fd);
     1b8:	8552                	mv	a0,s4
     1ba:	1f7000ef          	jal	bb0 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1be:	20200593          	li	a1,514
     1c2:	00001517          	auipc	a0,0x1
     1c6:	06650513          	addi	a0,a0,102 # 1228 <malloc+0x184>
     1ca:	1ff000ef          	jal	bc8 <open>
     1ce:	8a2a                	mv	s4,a0
     1d0:	bf1d                	j	106 <go+0x92>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1d2:	3e700613          	li	a2,999
     1d6:	00002597          	auipc	a1,0x2
     1da:	e4a58593          	addi	a1,a1,-438 # 2020 <buf.0>
     1de:	8552                	mv	a0,s4
     1e0:	1c9000ef          	jal	ba8 <write>
     1e4:	b70d                	j	106 <go+0x92>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1e6:	3e700613          	li	a2,999
     1ea:	00002597          	auipc	a1,0x2
     1ee:	e3658593          	addi	a1,a1,-458 # 2020 <buf.0>
     1f2:	8552                	mv	a0,s4
     1f4:	1ad000ef          	jal	ba0 <read>
     1f8:	b739                	j	106 <go+0x92>
    } else if(what == 9){
      mkdir("grindir/../a");
     1fa:	00001517          	auipc	a0,0x1
     1fe:	fee50513          	addi	a0,a0,-18 # 11e8 <malloc+0x144>
     202:	1ef000ef          	jal	bf0 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     206:	20200593          	li	a1,514
     20a:	00001517          	auipc	a0,0x1
     20e:	03650513          	addi	a0,a0,54 # 1240 <malloc+0x19c>
     212:	1b7000ef          	jal	bc8 <open>
     216:	19b000ef          	jal	bb0 <close>
      unlink("a/a");
     21a:	00001517          	auipc	a0,0x1
     21e:	03650513          	addi	a0,a0,54 # 1250 <malloc+0x1ac>
     222:	1b7000ef          	jal	bd8 <unlink>
     226:	b5c5                	j	106 <go+0x92>
    } else if(what == 10){
      mkdir("/../b");
     228:	00001517          	auipc	a0,0x1
     22c:	03050513          	addi	a0,a0,48 # 1258 <malloc+0x1b4>
     230:	1c1000ef          	jal	bf0 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     234:	20200593          	li	a1,514
     238:	00001517          	auipc	a0,0x1
     23c:	02850513          	addi	a0,a0,40 # 1260 <malloc+0x1bc>
     240:	189000ef          	jal	bc8 <open>
     244:	16d000ef          	jal	bb0 <close>
      unlink("b/b");
     248:	00001517          	auipc	a0,0x1
     24c:	02850513          	addi	a0,a0,40 # 1270 <malloc+0x1cc>
     250:	189000ef          	jal	bd8 <unlink>
     254:	bd4d                	j	106 <go+0x92>
    } else if(what == 11){
      unlink("b");
     256:	00001517          	auipc	a0,0x1
     25a:	02250513          	addi	a0,a0,34 # 1278 <malloc+0x1d4>
     25e:	17b000ef          	jal	bd8 <unlink>
      link("../grindir/./../a", "../b");
     262:	00001597          	auipc	a1,0x1
     266:	fae58593          	addi	a1,a1,-82 # 1210 <malloc+0x16c>
     26a:	00001517          	auipc	a0,0x1
     26e:	01650513          	addi	a0,a0,22 # 1280 <malloc+0x1dc>
     272:	177000ef          	jal	be8 <link>
     276:	bd41                	j	106 <go+0x92>
    } else if(what == 12){
      unlink("../grindir/../a");
     278:	00001517          	auipc	a0,0x1
     27c:	02050513          	addi	a0,a0,32 # 1298 <malloc+0x1f4>
     280:	159000ef          	jal	bd8 <unlink>
      link(".././b", "/grindir/../a");
     284:	00001597          	auipc	a1,0x1
     288:	f9458593          	addi	a1,a1,-108 # 1218 <malloc+0x174>
     28c:	00001517          	auipc	a0,0x1
     290:	01c50513          	addi	a0,a0,28 # 12a8 <malloc+0x204>
     294:	155000ef          	jal	be8 <link>
     298:	b5bd                	j	106 <go+0x92>
    } else if(what == 13){
      int pid = fork();
     29a:	0e7000ef          	jal	b80 <fork>
      if(pid == 0){
     29e:	c519                	beqz	a0,2ac <go+0x238>
        exit(0);
      } else if(pid < 0){
     2a0:	00054863          	bltz	a0,2b0 <go+0x23c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2a4:	4501                	li	a0,0
     2a6:	0eb000ef          	jal	b90 <wait>
     2aa:	bdb1                	j	106 <go+0x92>
        exit(0);
     2ac:	0dd000ef          	jal	b88 <exit>
        printf("grind: fork failed\n");
     2b0:	00001517          	auipc	a0,0x1
     2b4:	00050513          	mv	a0,a0
     2b8:	539000ef          	jal	ff0 <printf>
        exit(1);
     2bc:	4505                	li	a0,1
     2be:	0cb000ef          	jal	b88 <exit>
    } else if(what == 14){
      int pid = fork();
     2c2:	0bf000ef          	jal	b80 <fork>
      if(pid == 0){
     2c6:	c519                	beqz	a0,2d4 <go+0x260>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2c8:	00054d63          	bltz	a0,2e2 <go+0x26e>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2cc:	4501                	li	a0,0
     2ce:	0c3000ef          	jal	b90 <wait>
     2d2:	bd15                	j	106 <go+0x92>
        fork();
     2d4:	0ad000ef          	jal	b80 <fork>
        fork();
     2d8:	0a9000ef          	jal	b80 <fork>
        exit(0);
     2dc:	4501                	li	a0,0
     2de:	0ab000ef          	jal	b88 <exit>
        printf("grind: fork failed\n");
     2e2:	00001517          	auipc	a0,0x1
     2e6:	fce50513          	addi	a0,a0,-50 # 12b0 <malloc+0x20c>
     2ea:	507000ef          	jal	ff0 <printf>
        exit(1);
     2ee:	4505                	li	a0,1
     2f0:	099000ef          	jal	b88 <exit>
    } else if(what == 15){
      sbrk(6011);
     2f4:	6505                	lui	a0,0x1
     2f6:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x26b>
     2fa:	045000ef          	jal	b3e <sbrk>
     2fe:	b521                	j	106 <go+0x92>
    } else if(what == 16){
      if(sbrk(0) > break0)
     300:	4501                	li	a0,0
     302:	03d000ef          	jal	b3e <sbrk>
     306:	e0aaf0e3          	bgeu	s5,a0,106 <go+0x92>
        sbrk(-(sbrk(0) - break0));
     30a:	4501                	li	a0,0
     30c:	033000ef          	jal	b3e <sbrk>
     310:	40aa853b          	subw	a0,s5,a0
     314:	02b000ef          	jal	b3e <sbrk>
     318:	b3fd                	j	106 <go+0x92>
    } else if(what == 17){
      int pid = fork();
     31a:	067000ef          	jal	b80 <fork>
     31e:	8b2a                	mv	s6,a0
      if(pid == 0){
     320:	c10d                	beqz	a0,342 <go+0x2ce>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     322:	02054d63          	bltz	a0,35c <go+0x2e8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     326:	00001517          	auipc	a0,0x1
     32a:	faa50513          	addi	a0,a0,-86 # 12d0 <malloc+0x22c>
     32e:	0cb000ef          	jal	bf8 <chdir>
     332:	ed15                	bnez	a0,36e <go+0x2fa>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     334:	855a                	mv	a0,s6
     336:	083000ef          	jal	bb8 <kill>
      wait(0);
     33a:	4501                	li	a0,0
     33c:	055000ef          	jal	b90 <wait>
     340:	b3d9                	j	106 <go+0x92>
        close(open("a", O_CREATE|O_RDWR));
     342:	20200593          	li	a1,514
     346:	00001517          	auipc	a0,0x1
     34a:	f8250513          	addi	a0,a0,-126 # 12c8 <malloc+0x224>
     34e:	07b000ef          	jal	bc8 <open>
     352:	05f000ef          	jal	bb0 <close>
        exit(0);
     356:	4501                	li	a0,0
     358:	031000ef          	jal	b88 <exit>
        printf("grind: fork failed\n");
     35c:	00001517          	auipc	a0,0x1
     360:	f5450513          	addi	a0,a0,-172 # 12b0 <malloc+0x20c>
     364:	48d000ef          	jal	ff0 <printf>
        exit(1);
     368:	4505                	li	a0,1
     36a:	01f000ef          	jal	b88 <exit>
        printf("grind: chdir failed\n");
     36e:	00001517          	auipc	a0,0x1
     372:	f7250513          	addi	a0,a0,-142 # 12e0 <malloc+0x23c>
     376:	47b000ef          	jal	ff0 <printf>
        exit(1);
     37a:	4505                	li	a0,1
     37c:	00d000ef          	jal	b88 <exit>
    } else if(what == 18){
      int pid = fork();
     380:	001000ef          	jal	b80 <fork>
      if(pid == 0){
     384:	c519                	beqz	a0,392 <go+0x31e>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     386:	00054d63          	bltz	a0,3a0 <go+0x32c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     38a:	4501                	li	a0,0
     38c:	005000ef          	jal	b90 <wait>
     390:	bb9d                	j	106 <go+0x92>
        kill(getpid());
     392:	077000ef          	jal	c08 <getpid>
     396:	023000ef          	jal	bb8 <kill>
        exit(0);
     39a:	4501                	li	a0,0
     39c:	7ec000ef          	jal	b88 <exit>
        printf("grind: fork failed\n");
     3a0:	00001517          	auipc	a0,0x1
     3a4:	f1050513          	addi	a0,a0,-240 # 12b0 <malloc+0x20c>
     3a8:	449000ef          	jal	ff0 <printf>
        exit(1);
     3ac:	4505                	li	a0,1
     3ae:	7da000ef          	jal	b88 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3b2:	fa840513          	addi	a0,s0,-88
     3b6:	7e2000ef          	jal	b98 <pipe>
     3ba:	02054363          	bltz	a0,3e0 <go+0x36c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3be:	7c2000ef          	jal	b80 <fork>
      if(pid == 0){
     3c2:	c905                	beqz	a0,3f2 <go+0x37e>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3c4:	08054263          	bltz	a0,448 <go+0x3d4>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3c8:	fa842503          	lw	a0,-88(s0)
     3cc:	7e4000ef          	jal	bb0 <close>
      close(fds[1]);
     3d0:	fac42503          	lw	a0,-84(s0)
     3d4:	7dc000ef          	jal	bb0 <close>
      wait(0);
     3d8:	4501                	li	a0,0
     3da:	7b6000ef          	jal	b90 <wait>
     3de:	b325                	j	106 <go+0x92>
        printf("grind: pipe failed\n");
     3e0:	00001517          	auipc	a0,0x1
     3e4:	f1850513          	addi	a0,a0,-232 # 12f8 <malloc+0x254>
     3e8:	409000ef          	jal	ff0 <printf>
        exit(1);
     3ec:	4505                	li	a0,1
     3ee:	79a000ef          	jal	b88 <exit>
        fork();
     3f2:	78e000ef          	jal	b80 <fork>
        fork();
     3f6:	78a000ef          	jal	b80 <fork>
        if(write(fds[1], "x", 1) != 1)
     3fa:	4605                	li	a2,1
     3fc:	00001597          	auipc	a1,0x1
     400:	f1458593          	addi	a1,a1,-236 # 1310 <malloc+0x26c>
     404:	fac42503          	lw	a0,-84(s0)
     408:	7a0000ef          	jal	ba8 <write>
     40c:	4785                	li	a5,1
     40e:	00f51f63          	bne	a0,a5,42c <go+0x3b8>
        if(read(fds[0], &c, 1) != 1)
     412:	4605                	li	a2,1
     414:	fa040593          	addi	a1,s0,-96
     418:	fa842503          	lw	a0,-88(s0)
     41c:	784000ef          	jal	ba0 <read>
     420:	4785                	li	a5,1
     422:	00f51c63          	bne	a0,a5,43a <go+0x3c6>
        exit(0);
     426:	4501                	li	a0,0
     428:	760000ef          	jal	b88 <exit>
          printf("grind: pipe write failed\n");
     42c:	00001517          	auipc	a0,0x1
     430:	eec50513          	addi	a0,a0,-276 # 1318 <malloc+0x274>
     434:	3bd000ef          	jal	ff0 <printf>
     438:	bfe9                	j	412 <go+0x39e>
          printf("grind: pipe read failed\n");
     43a:	00001517          	auipc	a0,0x1
     43e:	efe50513          	addi	a0,a0,-258 # 1338 <malloc+0x294>
     442:	3af000ef          	jal	ff0 <printf>
     446:	b7c5                	j	426 <go+0x3b2>
        printf("grind: fork failed\n");
     448:	00001517          	auipc	a0,0x1
     44c:	e6850513          	addi	a0,a0,-408 # 12b0 <malloc+0x20c>
     450:	3a1000ef          	jal	ff0 <printf>
        exit(1);
     454:	4505                	li	a0,1
     456:	732000ef          	jal	b88 <exit>
    } else if(what == 20){
      int pid = fork();
     45a:	726000ef          	jal	b80 <fork>
      if(pid == 0){
     45e:	c519                	beqz	a0,46c <go+0x3f8>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     460:	04054f63          	bltz	a0,4be <go+0x44a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     464:	4501                	li	a0,0
     466:	72a000ef          	jal	b90 <wait>
     46a:	b971                	j	106 <go+0x92>
        unlink("a");
     46c:	00001517          	auipc	a0,0x1
     470:	e5c50513          	addi	a0,a0,-420 # 12c8 <malloc+0x224>
     474:	764000ef          	jal	bd8 <unlink>
        mkdir("a");
     478:	00001517          	auipc	a0,0x1
     47c:	e5050513          	addi	a0,a0,-432 # 12c8 <malloc+0x224>
     480:	770000ef          	jal	bf0 <mkdir>
        chdir("a");
     484:	00001517          	auipc	a0,0x1
     488:	e4450513          	addi	a0,a0,-444 # 12c8 <malloc+0x224>
     48c:	76c000ef          	jal	bf8 <chdir>
        unlink("../a");
     490:	00001517          	auipc	a0,0x1
     494:	ec850513          	addi	a0,a0,-312 # 1358 <malloc+0x2b4>
     498:	740000ef          	jal	bd8 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     49c:	20200593          	li	a1,514
     4a0:	00001517          	auipc	a0,0x1
     4a4:	e7050513          	addi	a0,a0,-400 # 1310 <malloc+0x26c>
     4a8:	720000ef          	jal	bc8 <open>
        unlink("x");
     4ac:	00001517          	auipc	a0,0x1
     4b0:	e6450513          	addi	a0,a0,-412 # 1310 <malloc+0x26c>
     4b4:	724000ef          	jal	bd8 <unlink>
        exit(0);
     4b8:	4501                	li	a0,0
     4ba:	6ce000ef          	jal	b88 <exit>
        printf("grind: fork failed\n");
     4be:	00001517          	auipc	a0,0x1
     4c2:	df250513          	addi	a0,a0,-526 # 12b0 <malloc+0x20c>
     4c6:	32b000ef          	jal	ff0 <printf>
        exit(1);
     4ca:	4505                	li	a0,1
     4cc:	6bc000ef          	jal	b88 <exit>
    } else if(what == 21){
      unlink("c");
     4d0:	00001517          	auipc	a0,0x1
     4d4:	e9050513          	addi	a0,a0,-368 # 1360 <malloc+0x2bc>
     4d8:	700000ef          	jal	bd8 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4dc:	20200593          	li	a1,514
     4e0:	00001517          	auipc	a0,0x1
     4e4:	e8050513          	addi	a0,a0,-384 # 1360 <malloc+0x2bc>
     4e8:	6e0000ef          	jal	bc8 <open>
     4ec:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4ee:	04054763          	bltz	a0,53c <go+0x4c8>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4f2:	4605                	li	a2,1
     4f4:	00001597          	auipc	a1,0x1
     4f8:	e1c58593          	addi	a1,a1,-484 # 1310 <malloc+0x26c>
     4fc:	6ac000ef          	jal	ba8 <write>
     500:	4785                	li	a5,1
     502:	04f51663          	bne	a0,a5,54e <go+0x4da>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     506:	fa840593          	addi	a1,s0,-88
     50a:	855a                	mv	a0,s6
     50c:	6d4000ef          	jal	be0 <fstat>
     510:	e921                	bnez	a0,560 <go+0x4ec>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     512:	fb843583          	ld	a1,-72(s0)
     516:	4785                	li	a5,1
     518:	04f59d63          	bne	a1,a5,572 <go+0x4fe>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     51c:	fac42583          	lw	a1,-84(s0)
     520:	0c800793          	li	a5,200
     524:	06b7e163          	bltu	a5,a1,586 <go+0x512>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     528:	855a                	mv	a0,s6
     52a:	686000ef          	jal	bb0 <close>
      unlink("c");
     52e:	00001517          	auipc	a0,0x1
     532:	e3250513          	addi	a0,a0,-462 # 1360 <malloc+0x2bc>
     536:	6a2000ef          	jal	bd8 <unlink>
     53a:	b6f1                	j	106 <go+0x92>
        printf("grind: create c failed\n");
     53c:	00001517          	auipc	a0,0x1
     540:	e2c50513          	addi	a0,a0,-468 # 1368 <malloc+0x2c4>
     544:	2ad000ef          	jal	ff0 <printf>
        exit(1);
     548:	4505                	li	a0,1
     54a:	63e000ef          	jal	b88 <exit>
        printf("grind: write c failed\n");
     54e:	00001517          	auipc	a0,0x1
     552:	e3250513          	addi	a0,a0,-462 # 1380 <malloc+0x2dc>
     556:	29b000ef          	jal	ff0 <printf>
        exit(1);
     55a:	4505                	li	a0,1
     55c:	62c000ef          	jal	b88 <exit>
        printf("grind: fstat failed\n");
     560:	00001517          	auipc	a0,0x1
     564:	e3850513          	addi	a0,a0,-456 # 1398 <malloc+0x2f4>
     568:	289000ef          	jal	ff0 <printf>
        exit(1);
     56c:	4505                	li	a0,1
     56e:	61a000ef          	jal	b88 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     572:	2581                	sext.w	a1,a1
     574:	00001517          	auipc	a0,0x1
     578:	e3c50513          	addi	a0,a0,-452 # 13b0 <malloc+0x30c>
     57c:	275000ef          	jal	ff0 <printf>
        exit(1);
     580:	4505                	li	a0,1
     582:	606000ef          	jal	b88 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     586:	00001517          	auipc	a0,0x1
     58a:	e5250513          	addi	a0,a0,-430 # 13d8 <malloc+0x334>
     58e:	263000ef          	jal	ff0 <printf>
        exit(1);
     592:	4505                	li	a0,1
     594:	5f4000ef          	jal	b88 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     598:	f9840513          	addi	a0,s0,-104
     59c:	5fc000ef          	jal	b98 <pipe>
     5a0:	0c054263          	bltz	a0,664 <go+0x5f0>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     5a4:	fa040513          	addi	a0,s0,-96
     5a8:	5f0000ef          	jal	b98 <pipe>
     5ac:	0c054663          	bltz	a0,678 <go+0x604>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5b0:	5d0000ef          	jal	b80 <fork>
      if(pid1 == 0){
     5b4:	0c050c63          	beqz	a0,68c <go+0x618>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5b8:	14054e63          	bltz	a0,714 <go+0x6a0>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5bc:	5c4000ef          	jal	b80 <fork>
      if(pid2 == 0){
     5c0:	16050463          	beqz	a0,728 <go+0x6b4>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5c4:	20054263          	bltz	a0,7c8 <go+0x754>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5c8:	f9842503          	lw	a0,-104(s0)
     5cc:	5e4000ef          	jal	bb0 <close>
      close(aa[1]);
     5d0:	f9c42503          	lw	a0,-100(s0)
     5d4:	5dc000ef          	jal	bb0 <close>
      close(bb[1]);
     5d8:	fa442503          	lw	a0,-92(s0)
     5dc:	5d4000ef          	jal	bb0 <close>
      char buf[4] = { 0, 0, 0, 0 };
     5e0:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     5e4:	4605                	li	a2,1
     5e6:	f9040593          	addi	a1,s0,-112
     5ea:	fa042503          	lw	a0,-96(s0)
     5ee:	5b2000ef          	jal	ba0 <read>
      read(bb[0], buf+1, 1);
     5f2:	4605                	li	a2,1
     5f4:	f9140593          	addi	a1,s0,-111
     5f8:	fa042503          	lw	a0,-96(s0)
     5fc:	5a4000ef          	jal	ba0 <read>
      read(bb[0], buf+2, 1);
     600:	4605                	li	a2,1
     602:	f9240593          	addi	a1,s0,-110
     606:	fa042503          	lw	a0,-96(s0)
     60a:	596000ef          	jal	ba0 <read>
      close(bb[0]);
     60e:	fa042503          	lw	a0,-96(s0)
     612:	59e000ef          	jal	bb0 <close>
      int st1, st2;
      wait(&st1);
     616:	f9440513          	addi	a0,s0,-108
     61a:	576000ef          	jal	b90 <wait>
      wait(&st2);
     61e:	fa840513          	addi	a0,s0,-88
     622:	56e000ef          	jal	b90 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     626:	f9442783          	lw	a5,-108(s0)
     62a:	fa842703          	lw	a4,-88(s0)
     62e:	8fd9                	or	a5,a5,a4
     630:	eb99                	bnez	a5,646 <go+0x5d2>
     632:	00001597          	auipc	a1,0x1
     636:	e4658593          	addi	a1,a1,-442 # 1478 <malloc+0x3d4>
     63a:	f9040513          	addi	a0,s0,-112
     63e:	2cc000ef          	jal	90a <strcmp>
     642:	ac0502e3          	beqz	a0,106 <go+0x92>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     646:	f9040693          	addi	a3,s0,-112
     64a:	fa842603          	lw	a2,-88(s0)
     64e:	f9442583          	lw	a1,-108(s0)
     652:	00001517          	auipc	a0,0x1
     656:	e2e50513          	addi	a0,a0,-466 # 1480 <malloc+0x3dc>
     65a:	197000ef          	jal	ff0 <printf>
        exit(1);
     65e:	4505                	li	a0,1
     660:	528000ef          	jal	b88 <exit>
        fprintf(2, "grind: pipe failed\n");
     664:	00001597          	auipc	a1,0x1
     668:	c9458593          	addi	a1,a1,-876 # 12f8 <malloc+0x254>
     66c:	4509                	li	a0,2
     66e:	159000ef          	jal	fc6 <fprintf>
        exit(1);
     672:	4505                	li	a0,1
     674:	514000ef          	jal	b88 <exit>
        fprintf(2, "grind: pipe failed\n");
     678:	00001597          	auipc	a1,0x1
     67c:	c8058593          	addi	a1,a1,-896 # 12f8 <malloc+0x254>
     680:	4509                	li	a0,2
     682:	145000ef          	jal	fc6 <fprintf>
        exit(1);
     686:	4505                	li	a0,1
     688:	500000ef          	jal	b88 <exit>
        close(bb[0]);
     68c:	fa042503          	lw	a0,-96(s0)
     690:	520000ef          	jal	bb0 <close>
        close(bb[1]);
     694:	fa442503          	lw	a0,-92(s0)
     698:	518000ef          	jal	bb0 <close>
        close(aa[0]);
     69c:	f9842503          	lw	a0,-104(s0)
     6a0:	510000ef          	jal	bb0 <close>
        close(1);
     6a4:	4505                	li	a0,1
     6a6:	50a000ef          	jal	bb0 <close>
        if(dup(aa[1]) != 1){
     6aa:	f9c42503          	lw	a0,-100(s0)
     6ae:	552000ef          	jal	c00 <dup>
     6b2:	4785                	li	a5,1
     6b4:	00f50c63          	beq	a0,a5,6cc <go+0x658>
          fprintf(2, "grind: dup failed\n");
     6b8:	00001597          	auipc	a1,0x1
     6bc:	d4858593          	addi	a1,a1,-696 # 1400 <malloc+0x35c>
     6c0:	4509                	li	a0,2
     6c2:	105000ef          	jal	fc6 <fprintf>
          exit(1);
     6c6:	4505                	li	a0,1
     6c8:	4c0000ef          	jal	b88 <exit>
        close(aa[1]);
     6cc:	f9c42503          	lw	a0,-100(s0)
     6d0:	4e0000ef          	jal	bb0 <close>
        char *args[3] = { "echo", "hi", 0 };
     6d4:	00001797          	auipc	a5,0x1
     6d8:	d4478793          	addi	a5,a5,-700 # 1418 <malloc+0x374>
     6dc:	faf43423          	sd	a5,-88(s0)
     6e0:	00001797          	auipc	a5,0x1
     6e4:	d4078793          	addi	a5,a5,-704 # 1420 <malloc+0x37c>
     6e8:	faf43823          	sd	a5,-80(s0)
     6ec:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     6f0:	fa840593          	addi	a1,s0,-88
     6f4:	00001517          	auipc	a0,0x1
     6f8:	d3450513          	addi	a0,a0,-716 # 1428 <malloc+0x384>
     6fc:	4c4000ef          	jal	bc0 <exec>
        fprintf(2, "grind: echo: not found\n");
     700:	00001597          	auipc	a1,0x1
     704:	d3858593          	addi	a1,a1,-712 # 1438 <malloc+0x394>
     708:	4509                	li	a0,2
     70a:	0bd000ef          	jal	fc6 <fprintf>
        exit(2);
     70e:	4509                	li	a0,2
     710:	478000ef          	jal	b88 <exit>
        fprintf(2, "grind: fork failed\n");
     714:	00001597          	auipc	a1,0x1
     718:	b9c58593          	addi	a1,a1,-1124 # 12b0 <malloc+0x20c>
     71c:	4509                	li	a0,2
     71e:	0a9000ef          	jal	fc6 <fprintf>
        exit(3);
     722:	450d                	li	a0,3
     724:	464000ef          	jal	b88 <exit>
        close(aa[1]);
     728:	f9c42503          	lw	a0,-100(s0)
     72c:	484000ef          	jal	bb0 <close>
        close(bb[0]);
     730:	fa042503          	lw	a0,-96(s0)
     734:	47c000ef          	jal	bb0 <close>
        close(0);
     738:	4501                	li	a0,0
     73a:	476000ef          	jal	bb0 <close>
        if(dup(aa[0]) != 0){
     73e:	f9842503          	lw	a0,-104(s0)
     742:	4be000ef          	jal	c00 <dup>
     746:	c919                	beqz	a0,75c <go+0x6e8>
          fprintf(2, "grind: dup failed\n");
     748:	00001597          	auipc	a1,0x1
     74c:	cb858593          	addi	a1,a1,-840 # 1400 <malloc+0x35c>
     750:	4509                	li	a0,2
     752:	075000ef          	jal	fc6 <fprintf>
          exit(4);
     756:	4511                	li	a0,4
     758:	430000ef          	jal	b88 <exit>
        close(aa[0]);
     75c:	f9842503          	lw	a0,-104(s0)
     760:	450000ef          	jal	bb0 <close>
        close(1);
     764:	4505                	li	a0,1
     766:	44a000ef          	jal	bb0 <close>
        if(dup(bb[1]) != 1){
     76a:	fa442503          	lw	a0,-92(s0)
     76e:	492000ef          	jal	c00 <dup>
     772:	4785                	li	a5,1
     774:	00f50c63          	beq	a0,a5,78c <go+0x718>
          fprintf(2, "grind: dup failed\n");
     778:	00001597          	auipc	a1,0x1
     77c:	c8858593          	addi	a1,a1,-888 # 1400 <malloc+0x35c>
     780:	4509                	li	a0,2
     782:	045000ef          	jal	fc6 <fprintf>
          exit(5);
     786:	4515                	li	a0,5
     788:	400000ef          	jal	b88 <exit>
        close(bb[1]);
     78c:	fa442503          	lw	a0,-92(s0)
     790:	420000ef          	jal	bb0 <close>
        char *args[2] = { "cat", 0 };
     794:	00001797          	auipc	a5,0x1
     798:	cbc78793          	addi	a5,a5,-836 # 1450 <malloc+0x3ac>
     79c:	faf43423          	sd	a5,-88(s0)
     7a0:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     7a4:	fa840593          	addi	a1,s0,-88
     7a8:	00001517          	auipc	a0,0x1
     7ac:	cb050513          	addi	a0,a0,-848 # 1458 <malloc+0x3b4>
     7b0:	410000ef          	jal	bc0 <exec>
        fprintf(2, "grind: cat: not found\n");
     7b4:	00001597          	auipc	a1,0x1
     7b8:	cac58593          	addi	a1,a1,-852 # 1460 <malloc+0x3bc>
     7bc:	4509                	li	a0,2
     7be:	009000ef          	jal	fc6 <fprintf>
        exit(6);
     7c2:	4519                	li	a0,6
     7c4:	3c4000ef          	jal	b88 <exit>
        fprintf(2, "grind: fork failed\n");
     7c8:	00001597          	auipc	a1,0x1
     7cc:	ae858593          	addi	a1,a1,-1304 # 12b0 <malloc+0x20c>
     7d0:	4509                	li	a0,2
     7d2:	7f4000ef          	jal	fc6 <fprintf>
        exit(7);
     7d6:	451d                	li	a0,7
     7d8:	3b0000ef          	jal	b88 <exit>

00000000000007dc <iter>:
  }
}

void
iter()
{
     7dc:	7179                	addi	sp,sp,-48
     7de:	f406                	sd	ra,40(sp)
     7e0:	f022                	sd	s0,32(sp)
     7e2:	1800                	addi	s0,sp,48
  unlink("a");
     7e4:	00001517          	auipc	a0,0x1
     7e8:	ae450513          	addi	a0,a0,-1308 # 12c8 <malloc+0x224>
     7ec:	3ec000ef          	jal	bd8 <unlink>
  unlink("b");
     7f0:	00001517          	auipc	a0,0x1
     7f4:	a8850513          	addi	a0,a0,-1400 # 1278 <malloc+0x1d4>
     7f8:	3e0000ef          	jal	bd8 <unlink>
  
  int pid1 = fork();
     7fc:	384000ef          	jal	b80 <fork>
  if(pid1 < 0){
     800:	02054163          	bltz	a0,822 <iter+0x46>
     804:	ec26                	sd	s1,24(sp)
     806:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     808:	e905                	bnez	a0,838 <iter+0x5c>
     80a:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     80c:	00001717          	auipc	a4,0x1
     810:	7f470713          	addi	a4,a4,2036 # 2000 <rand_next>
     814:	631c                	ld	a5,0(a4)
     816:	01f7c793          	xori	a5,a5,31
     81a:	e31c                	sd	a5,0(a4)
    go(0);
     81c:	4501                	li	a0,0
     81e:	857ff0ef          	jal	74 <go>
     822:	ec26                	sd	s1,24(sp)
     824:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     826:	00001517          	auipc	a0,0x1
     82a:	a8a50513          	addi	a0,a0,-1398 # 12b0 <malloc+0x20c>
     82e:	7c2000ef          	jal	ff0 <printf>
    exit(1);
     832:	4505                	li	a0,1
     834:	354000ef          	jal	b88 <exit>
     838:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     83a:	346000ef          	jal	b80 <fork>
     83e:	892a                	mv	s2,a0
  if(pid2 < 0){
     840:	02054063          	bltz	a0,860 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     844:	e51d                	bnez	a0,872 <iter+0x96>
    rand_next ^= 7177;
     846:	00001697          	auipc	a3,0x1
     84a:	7ba68693          	addi	a3,a3,1978 # 2000 <rand_next>
     84e:	629c                	ld	a5,0(a3)
     850:	6709                	lui	a4,0x2
     852:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x6f9>
     856:	8fb9                	xor	a5,a5,a4
     858:	e29c                	sd	a5,0(a3)
    go(1);
     85a:	4505                	li	a0,1
     85c:	819ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     860:	00001517          	auipc	a0,0x1
     864:	a5050513          	addi	a0,a0,-1456 # 12b0 <malloc+0x20c>
     868:	788000ef          	jal	ff0 <printf>
    exit(1);
     86c:	4505                	li	a0,1
     86e:	31a000ef          	jal	b88 <exit>
    exit(0);
  }

  int st1 = -1;
     872:	57fd                	li	a5,-1
     874:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     878:	fdc40513          	addi	a0,s0,-36
     87c:	314000ef          	jal	b90 <wait>
  if(st1 != 0){
     880:	fdc42783          	lw	a5,-36(s0)
     884:	eb99                	bnez	a5,89a <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     886:	57fd                	li	a5,-1
     888:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     88c:	fd840513          	addi	a0,s0,-40
     890:	300000ef          	jal	b90 <wait>

  exit(0);
     894:	4501                	li	a0,0
     896:	2f2000ef          	jal	b88 <exit>
    kill(pid1);
     89a:	8526                	mv	a0,s1
     89c:	31c000ef          	jal	bb8 <kill>
    kill(pid2);
     8a0:	854a                	mv	a0,s2
     8a2:	316000ef          	jal	bb8 <kill>
     8a6:	b7c5                	j	886 <iter+0xaa>

00000000000008a8 <main>:
}

int
main()
{
     8a8:	1101                	addi	sp,sp,-32
     8aa:	ec06                	sd	ra,24(sp)
     8ac:	e822                	sd	s0,16(sp)
     8ae:	e426                	sd	s1,8(sp)
     8b0:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    pause(20);
    rand_next += 1;
     8b2:	00001497          	auipc	s1,0x1
     8b6:	74e48493          	addi	s1,s1,1870 # 2000 <rand_next>
     8ba:	a809                	j	8cc <main+0x24>
      iter();
     8bc:	f21ff0ef          	jal	7dc <iter>
    pause(20);
     8c0:	4551                	li	a0,20
     8c2:	356000ef          	jal	c18 <pause>
    rand_next += 1;
     8c6:	609c                	ld	a5,0(s1)
     8c8:	0785                	addi	a5,a5,1
     8ca:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8cc:	2b4000ef          	jal	b80 <fork>
    if(pid == 0){
     8d0:	d575                	beqz	a0,8bc <main+0x14>
    if(pid > 0){
     8d2:	fea057e3          	blez	a0,8c0 <main+0x18>
      wait(0);
     8d6:	4501                	li	a0,0
     8d8:	2b8000ef          	jal	b90 <wait>
     8dc:	b7d5                	j	8c0 <main+0x18>

00000000000008de <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     8de:	1141                	addi	sp,sp,-16
     8e0:	e406                	sd	ra,8(sp)
     8e2:	e022                	sd	s0,0(sp)
     8e4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     8e6:	fc3ff0ef          	jal	8a8 <main>
  exit(r);
     8ea:	29e000ef          	jal	b88 <exit>

00000000000008ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8ee:	1141                	addi	sp,sp,-16
     8f0:	e422                	sd	s0,8(sp)
     8f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8f4:	87aa                	mv	a5,a0
     8f6:	0585                	addi	a1,a1,1
     8f8:	0785                	addi	a5,a5,1
     8fa:	fff5c703          	lbu	a4,-1(a1)
     8fe:	fee78fa3          	sb	a4,-1(a5)
     902:	fb75                	bnez	a4,8f6 <strcpy+0x8>
    ;
  return os;
}
     904:	6422                	ld	s0,8(sp)
     906:	0141                	addi	sp,sp,16
     908:	8082                	ret

000000000000090a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     90a:	1141                	addi	sp,sp,-16
     90c:	e422                	sd	s0,8(sp)
     90e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     910:	00054783          	lbu	a5,0(a0)
     914:	cb91                	beqz	a5,928 <strcmp+0x1e>
     916:	0005c703          	lbu	a4,0(a1)
     91a:	00f71763          	bne	a4,a5,928 <strcmp+0x1e>
    p++, q++;
     91e:	0505                	addi	a0,a0,1
     920:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     922:	00054783          	lbu	a5,0(a0)
     926:	fbe5                	bnez	a5,916 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     928:	0005c503          	lbu	a0,0(a1)
}
     92c:	40a7853b          	subw	a0,a5,a0
     930:	6422                	ld	s0,8(sp)
     932:	0141                	addi	sp,sp,16
     934:	8082                	ret

0000000000000936 <strlen>:

uint
strlen(const char *s)
{
     936:	1141                	addi	sp,sp,-16
     938:	e422                	sd	s0,8(sp)
     93a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     93c:	00054783          	lbu	a5,0(a0)
     940:	cf91                	beqz	a5,95c <strlen+0x26>
     942:	0505                	addi	a0,a0,1
     944:	87aa                	mv	a5,a0
     946:	86be                	mv	a3,a5
     948:	0785                	addi	a5,a5,1
     94a:	fff7c703          	lbu	a4,-1(a5)
     94e:	ff65                	bnez	a4,946 <strlen+0x10>
     950:	40a6853b          	subw	a0,a3,a0
     954:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     956:	6422                	ld	s0,8(sp)
     958:	0141                	addi	sp,sp,16
     95a:	8082                	ret
  for(n = 0; s[n]; n++)
     95c:	4501                	li	a0,0
     95e:	bfe5                	j	956 <strlen+0x20>

0000000000000960 <memset>:

void*
memset(void *dst, int c, uint n)
{
     960:	1141                	addi	sp,sp,-16
     962:	e422                	sd	s0,8(sp)
     964:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     966:	ca19                	beqz	a2,97c <memset+0x1c>
     968:	87aa                	mv	a5,a0
     96a:	1602                	slli	a2,a2,0x20
     96c:	9201                	srli	a2,a2,0x20
     96e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     972:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     976:	0785                	addi	a5,a5,1
     978:	fee79de3          	bne	a5,a4,972 <memset+0x12>
  }
  return dst;
}
     97c:	6422                	ld	s0,8(sp)
     97e:	0141                	addi	sp,sp,16
     980:	8082                	ret

0000000000000982 <strchr>:

char*
strchr(const char *s, char c)
{
     982:	1141                	addi	sp,sp,-16
     984:	e422                	sd	s0,8(sp)
     986:	0800                	addi	s0,sp,16
  for(; *s; s++)
     988:	00054783          	lbu	a5,0(a0)
     98c:	cb99                	beqz	a5,9a2 <strchr+0x20>
    if(*s == c)
     98e:	00f58763          	beq	a1,a5,99c <strchr+0x1a>
  for(; *s; s++)
     992:	0505                	addi	a0,a0,1
     994:	00054783          	lbu	a5,0(a0)
     998:	fbfd                	bnez	a5,98e <strchr+0xc>
      return (char*)s;
  return 0;
     99a:	4501                	li	a0,0
}
     99c:	6422                	ld	s0,8(sp)
     99e:	0141                	addi	sp,sp,16
     9a0:	8082                	ret
  return 0;
     9a2:	4501                	li	a0,0
     9a4:	bfe5                	j	99c <strchr+0x1a>

00000000000009a6 <gets>:

char*
gets(char *buf, int max)
{
     9a6:	711d                	addi	sp,sp,-96
     9a8:	ec86                	sd	ra,88(sp)
     9aa:	e8a2                	sd	s0,80(sp)
     9ac:	e4a6                	sd	s1,72(sp)
     9ae:	e0ca                	sd	s2,64(sp)
     9b0:	fc4e                	sd	s3,56(sp)
     9b2:	f852                	sd	s4,48(sp)
     9b4:	f456                	sd	s5,40(sp)
     9b6:	f05a                	sd	s6,32(sp)
     9b8:	ec5e                	sd	s7,24(sp)
     9ba:	1080                	addi	s0,sp,96
     9bc:	8baa                	mv	s7,a0
     9be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9c0:	892a                	mv	s2,a0
     9c2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9c4:	4aa9                	li	s5,10
     9c6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     9c8:	89a6                	mv	s3,s1
     9ca:	2485                	addiw	s1,s1,1
     9cc:	0344d663          	bge	s1,s4,9f8 <gets+0x52>
    cc = read(0, &c, 1);
     9d0:	4605                	li	a2,1
     9d2:	faf40593          	addi	a1,s0,-81
     9d6:	4501                	li	a0,0
     9d8:	1c8000ef          	jal	ba0 <read>
    if(cc < 1)
     9dc:	00a05e63          	blez	a0,9f8 <gets+0x52>
    buf[i++] = c;
     9e0:	faf44783          	lbu	a5,-81(s0)
     9e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9e8:	01578763          	beq	a5,s5,9f6 <gets+0x50>
     9ec:	0905                	addi	s2,s2,1
     9ee:	fd679de3          	bne	a5,s6,9c8 <gets+0x22>
    buf[i++] = c;
     9f2:	89a6                	mv	s3,s1
     9f4:	a011                	j	9f8 <gets+0x52>
     9f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     9f8:	99de                	add	s3,s3,s7
     9fa:	00098023          	sb	zero,0(s3)
  return buf;
}
     9fe:	855e                	mv	a0,s7
     a00:	60e6                	ld	ra,88(sp)
     a02:	6446                	ld	s0,80(sp)
     a04:	64a6                	ld	s1,72(sp)
     a06:	6906                	ld	s2,64(sp)
     a08:	79e2                	ld	s3,56(sp)
     a0a:	7a42                	ld	s4,48(sp)
     a0c:	7aa2                	ld	s5,40(sp)
     a0e:	7b02                	ld	s6,32(sp)
     a10:	6be2                	ld	s7,24(sp)
     a12:	6125                	addi	sp,sp,96
     a14:	8082                	ret

0000000000000a16 <stat>:

int
stat(const char *n, struct stat *st)
{
     a16:	1101                	addi	sp,sp,-32
     a18:	ec06                	sd	ra,24(sp)
     a1a:	e822                	sd	s0,16(sp)
     a1c:	e04a                	sd	s2,0(sp)
     a1e:	1000                	addi	s0,sp,32
     a20:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a22:	4581                	li	a1,0
     a24:	1a4000ef          	jal	bc8 <open>
  if(fd < 0)
     a28:	02054263          	bltz	a0,a4c <stat+0x36>
     a2c:	e426                	sd	s1,8(sp)
     a2e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a30:	85ca                	mv	a1,s2
     a32:	1ae000ef          	jal	be0 <fstat>
     a36:	892a                	mv	s2,a0
  close(fd);
     a38:	8526                	mv	a0,s1
     a3a:	176000ef          	jal	bb0 <close>
  return r;
     a3e:	64a2                	ld	s1,8(sp)
}
     a40:	854a                	mv	a0,s2
     a42:	60e2                	ld	ra,24(sp)
     a44:	6442                	ld	s0,16(sp)
     a46:	6902                	ld	s2,0(sp)
     a48:	6105                	addi	sp,sp,32
     a4a:	8082                	ret
    return -1;
     a4c:	597d                	li	s2,-1
     a4e:	bfcd                	j	a40 <stat+0x2a>

0000000000000a50 <atoi>:

int
atoi(const char *s)
{
     a50:	1141                	addi	sp,sp,-16
     a52:	e422                	sd	s0,8(sp)
     a54:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a56:	00054683          	lbu	a3,0(a0)
     a5a:	fd06879b          	addiw	a5,a3,-48
     a5e:	0ff7f793          	zext.b	a5,a5
     a62:	4625                	li	a2,9
     a64:	02f66863          	bltu	a2,a5,a94 <atoi+0x44>
     a68:	872a                	mv	a4,a0
  n = 0;
     a6a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     a6c:	0705                	addi	a4,a4,1
     a6e:	0025179b          	slliw	a5,a0,0x2
     a72:	9fa9                	addw	a5,a5,a0
     a74:	0017979b          	slliw	a5,a5,0x1
     a78:	9fb5                	addw	a5,a5,a3
     a7a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     a7e:	00074683          	lbu	a3,0(a4)
     a82:	fd06879b          	addiw	a5,a3,-48
     a86:	0ff7f793          	zext.b	a5,a5
     a8a:	fef671e3          	bgeu	a2,a5,a6c <atoi+0x1c>
  return n;
}
     a8e:	6422                	ld	s0,8(sp)
     a90:	0141                	addi	sp,sp,16
     a92:	8082                	ret
  n = 0;
     a94:	4501                	li	a0,0
     a96:	bfe5                	j	a8e <atoi+0x3e>

0000000000000a98 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     a98:	1141                	addi	sp,sp,-16
     a9a:	e422                	sd	s0,8(sp)
     a9c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     a9e:	02b57463          	bgeu	a0,a1,ac6 <memmove+0x2e>
    while(n-- > 0)
     aa2:	00c05f63          	blez	a2,ac0 <memmove+0x28>
     aa6:	1602                	slli	a2,a2,0x20
     aa8:	9201                	srli	a2,a2,0x20
     aaa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     aae:	872a                	mv	a4,a0
      *dst++ = *src++;
     ab0:	0585                	addi	a1,a1,1
     ab2:	0705                	addi	a4,a4,1
     ab4:	fff5c683          	lbu	a3,-1(a1)
     ab8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     abc:	fef71ae3          	bne	a4,a5,ab0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ac0:	6422                	ld	s0,8(sp)
     ac2:	0141                	addi	sp,sp,16
     ac4:	8082                	ret
    dst += n;
     ac6:	00c50733          	add	a4,a0,a2
    src += n;
     aca:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     acc:	fec05ae3          	blez	a2,ac0 <memmove+0x28>
     ad0:	fff6079b          	addiw	a5,a2,-1
     ad4:	1782                	slli	a5,a5,0x20
     ad6:	9381                	srli	a5,a5,0x20
     ad8:	fff7c793          	not	a5,a5
     adc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ade:	15fd                	addi	a1,a1,-1
     ae0:	177d                	addi	a4,a4,-1
     ae2:	0005c683          	lbu	a3,0(a1)
     ae6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     aea:	fee79ae3          	bne	a5,a4,ade <memmove+0x46>
     aee:	bfc9                	j	ac0 <memmove+0x28>

0000000000000af0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     af0:	1141                	addi	sp,sp,-16
     af2:	e422                	sd	s0,8(sp)
     af4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     af6:	ca05                	beqz	a2,b26 <memcmp+0x36>
     af8:	fff6069b          	addiw	a3,a2,-1
     afc:	1682                	slli	a3,a3,0x20
     afe:	9281                	srli	a3,a3,0x20
     b00:	0685                	addi	a3,a3,1
     b02:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b04:	00054783          	lbu	a5,0(a0)
     b08:	0005c703          	lbu	a4,0(a1)
     b0c:	00e79863          	bne	a5,a4,b1c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b10:	0505                	addi	a0,a0,1
    p2++;
     b12:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b14:	fed518e3          	bne	a0,a3,b04 <memcmp+0x14>
  }
  return 0;
     b18:	4501                	li	a0,0
     b1a:	a019                	j	b20 <memcmp+0x30>
      return *p1 - *p2;
     b1c:	40e7853b          	subw	a0,a5,a4
}
     b20:	6422                	ld	s0,8(sp)
     b22:	0141                	addi	sp,sp,16
     b24:	8082                	ret
  return 0;
     b26:	4501                	li	a0,0
     b28:	bfe5                	j	b20 <memcmp+0x30>

0000000000000b2a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b2a:	1141                	addi	sp,sp,-16
     b2c:	e406                	sd	ra,8(sp)
     b2e:	e022                	sd	s0,0(sp)
     b30:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     b32:	f67ff0ef          	jal	a98 <memmove>
}
     b36:	60a2                	ld	ra,8(sp)
     b38:	6402                	ld	s0,0(sp)
     b3a:	0141                	addi	sp,sp,16
     b3c:	8082                	ret

0000000000000b3e <sbrk>:

char *
sbrk(int n) {
     b3e:	1141                	addi	sp,sp,-16
     b40:	e406                	sd	ra,8(sp)
     b42:	e022                	sd	s0,0(sp)
     b44:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     b46:	4585                	li	a1,1
     b48:	0c8000ef          	jal	c10 <sys_sbrk>
}
     b4c:	60a2                	ld	ra,8(sp)
     b4e:	6402                	ld	s0,0(sp)
     b50:	0141                	addi	sp,sp,16
     b52:	8082                	ret

0000000000000b54 <sbrklazy>:

char *
sbrklazy(int n) {
     b54:	1141                	addi	sp,sp,-16
     b56:	e406                	sd	ra,8(sp)
     b58:	e022                	sd	s0,0(sp)
     b5a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     b5c:	4589                	li	a1,2
     b5e:	0b2000ef          	jal	c10 <sys_sbrk>
}
     b62:	60a2                	ld	ra,8(sp)
     b64:	6402                	ld	s0,0(sp)
     b66:	0141                	addi	sp,sp,16
     b68:	8082                	ret

0000000000000b6a <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
     b6a:	1141                	addi	sp,sp,-16
     b6c:	e422                	sd	s0,8(sp)
     b6e:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
     b70:	040007b7          	lui	a5,0x4000
     b74:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffdbf5>
     b76:	07b2                	slli	a5,a5,0xc
}
     b78:	4388                	lw	a0,0(a5)
     b7a:	6422                	ld	s0,8(sp)
     b7c:	0141                	addi	sp,sp,16
     b7e:	8082                	ret

0000000000000b80 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     b80:	4885                	li	a7,1
 ecall
     b82:	00000073          	ecall
 ret
     b86:	8082                	ret

0000000000000b88 <exit>:
.global exit
exit:
 li a7, SYS_exit
     b88:	4889                	li	a7,2
 ecall
     b8a:	00000073          	ecall
 ret
     b8e:	8082                	ret

0000000000000b90 <wait>:
.global wait
wait:
 li a7, SYS_wait
     b90:	488d                	li	a7,3
 ecall
     b92:	00000073          	ecall
 ret
     b96:	8082                	ret

0000000000000b98 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b98:	4891                	li	a7,4
 ecall
     b9a:	00000073          	ecall
 ret
     b9e:	8082                	ret

0000000000000ba0 <read>:
.global read
read:
 li a7, SYS_read
     ba0:	4895                	li	a7,5
 ecall
     ba2:	00000073          	ecall
 ret
     ba6:	8082                	ret

0000000000000ba8 <write>:
.global write
write:
 li a7, SYS_write
     ba8:	48c1                	li	a7,16
 ecall
     baa:	00000073          	ecall
 ret
     bae:	8082                	ret

0000000000000bb0 <close>:
.global close
close:
 li a7, SYS_close
     bb0:	48d5                	li	a7,21
 ecall
     bb2:	00000073          	ecall
 ret
     bb6:	8082                	ret

0000000000000bb8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     bb8:	4899                	li	a7,6
 ecall
     bba:	00000073          	ecall
 ret
     bbe:	8082                	ret

0000000000000bc0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     bc0:	489d                	li	a7,7
 ecall
     bc2:	00000073          	ecall
 ret
     bc6:	8082                	ret

0000000000000bc8 <open>:
.global open
open:
 li a7, SYS_open
     bc8:	48bd                	li	a7,15
 ecall
     bca:	00000073          	ecall
 ret
     bce:	8082                	ret

0000000000000bd0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     bd0:	48c5                	li	a7,17
 ecall
     bd2:	00000073          	ecall
 ret
     bd6:	8082                	ret

0000000000000bd8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     bd8:	48c9                	li	a7,18
 ecall
     bda:	00000073          	ecall
 ret
     bde:	8082                	ret

0000000000000be0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     be0:	48a1                	li	a7,8
 ecall
     be2:	00000073          	ecall
 ret
     be6:	8082                	ret

0000000000000be8 <link>:
.global link
link:
 li a7, SYS_link
     be8:	48cd                	li	a7,19
 ecall
     bea:	00000073          	ecall
 ret
     bee:	8082                	ret

0000000000000bf0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     bf0:	48d1                	li	a7,20
 ecall
     bf2:	00000073          	ecall
 ret
     bf6:	8082                	ret

0000000000000bf8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     bf8:	48a5                	li	a7,9
 ecall
     bfa:	00000073          	ecall
 ret
     bfe:	8082                	ret

0000000000000c00 <dup>:
.global dup
dup:
 li a7, SYS_dup
     c00:	48a9                	li	a7,10
 ecall
     c02:	00000073          	ecall
 ret
     c06:	8082                	ret

0000000000000c08 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c08:	48ad                	li	a7,11
 ecall
     c0a:	00000073          	ecall
 ret
     c0e:	8082                	ret

0000000000000c10 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     c10:	48b1                	li	a7,12
 ecall
     c12:	00000073          	ecall
 ret
     c16:	8082                	ret

0000000000000c18 <pause>:
.global pause
pause:
 li a7, SYS_pause
     c18:	48b5                	li	a7,13
 ecall
     c1a:	00000073          	ecall
 ret
     c1e:	8082                	ret

0000000000000c20 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c20:	48b9                	li	a7,14
 ecall
     c22:	00000073          	ecall
 ret
     c26:	8082                	ret

0000000000000c28 <bind>:
.global bind
bind:
 li a7, SYS_bind
     c28:	48f5                	li	a7,29
 ecall
     c2a:	00000073          	ecall
 ret
     c2e:	8082                	ret

0000000000000c30 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
     c30:	48f9                	li	a7,30
 ecall
     c32:	00000073          	ecall
 ret
     c36:	8082                	ret

0000000000000c38 <send>:
.global send
send:
 li a7, SYS_send
     c38:	48fd                	li	a7,31
 ecall
     c3a:	00000073          	ecall
 ret
     c3e:	8082                	ret

0000000000000c40 <recv>:
.global recv
recv:
 li a7, SYS_recv
     c40:	02000893          	li	a7,32
 ecall
     c44:	00000073          	ecall
 ret
     c48:	8082                	ret

0000000000000c4a <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
     c4a:	02100893          	li	a7,33
 ecall
     c4e:	00000073          	ecall
 ret
     c52:	8082                	ret

0000000000000c54 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
     c54:	02200893          	li	a7,34
 ecall
     c58:	00000073          	ecall
 ret
     c5c:	8082                	ret

0000000000000c5e <prac>:
.global prac
prac:
 li a7, SYS_prac
     c5e:	02300893          	li	a7,35
 ecall
     c62:	00000073          	ecall
 ret
     c66:	8082                	ret

0000000000000c68 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     c68:	1101                	addi	sp,sp,-32
     c6a:	ec06                	sd	ra,24(sp)
     c6c:	e822                	sd	s0,16(sp)
     c6e:	1000                	addi	s0,sp,32
     c70:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     c74:	4605                	li	a2,1
     c76:	fef40593          	addi	a1,s0,-17
     c7a:	f2fff0ef          	jal	ba8 <write>
}
     c7e:	60e2                	ld	ra,24(sp)
     c80:	6442                	ld	s0,16(sp)
     c82:	6105                	addi	sp,sp,32
     c84:	8082                	ret

0000000000000c86 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     c86:	715d                	addi	sp,sp,-80
     c88:	e486                	sd	ra,72(sp)
     c8a:	e0a2                	sd	s0,64(sp)
     c8c:	f84a                	sd	s2,48(sp)
     c8e:	0880                	addi	s0,sp,80
     c90:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     c92:	c299                	beqz	a3,c98 <printint+0x12>
     c94:	0805c363          	bltz	a1,d1a <printint+0x94>
  neg = 0;
     c98:	4881                	li	a7,0
     c9a:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     c9e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     ca0:	00001517          	auipc	a0,0x1
     ca4:	87050513          	addi	a0,a0,-1936 # 1510 <digits>
     ca8:	883e                	mv	a6,a5
     caa:	2785                	addiw	a5,a5,1
     cac:	02c5f733          	remu	a4,a1,a2
     cb0:	972a                	add	a4,a4,a0
     cb2:	00074703          	lbu	a4,0(a4)
     cb6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     cba:	872e                	mv	a4,a1
     cbc:	02c5d5b3          	divu	a1,a1,a2
     cc0:	0685                	addi	a3,a3,1
     cc2:	fec773e3          	bgeu	a4,a2,ca8 <printint+0x22>
  if(neg)
     cc6:	00088b63          	beqz	a7,cdc <printint+0x56>
    buf[i++] = '-';
     cca:	fd078793          	addi	a5,a5,-48
     cce:	97a2                	add	a5,a5,s0
     cd0:	02d00713          	li	a4,45
     cd4:	fee78423          	sb	a4,-24(a5)
     cd8:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
     cdc:	02f05a63          	blez	a5,d10 <printint+0x8a>
     ce0:	fc26                	sd	s1,56(sp)
     ce2:	f44e                	sd	s3,40(sp)
     ce4:	fb840713          	addi	a4,s0,-72
     ce8:	00f704b3          	add	s1,a4,a5
     cec:	fff70993          	addi	s3,a4,-1
     cf0:	99be                	add	s3,s3,a5
     cf2:	37fd                	addiw	a5,a5,-1
     cf4:	1782                	slli	a5,a5,0x20
     cf6:	9381                	srli	a5,a5,0x20
     cf8:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     cfc:	fff4c583          	lbu	a1,-1(s1)
     d00:	854a                	mv	a0,s2
     d02:	f67ff0ef          	jal	c68 <putc>
  while(--i >= 0)
     d06:	14fd                	addi	s1,s1,-1
     d08:	ff349ae3          	bne	s1,s3,cfc <printint+0x76>
     d0c:	74e2                	ld	s1,56(sp)
     d0e:	79a2                	ld	s3,40(sp)
}
     d10:	60a6                	ld	ra,72(sp)
     d12:	6406                	ld	s0,64(sp)
     d14:	7942                	ld	s2,48(sp)
     d16:	6161                	addi	sp,sp,80
     d18:	8082                	ret
    x = -xx;
     d1a:	40b005b3          	neg	a1,a1
    neg = 1;
     d1e:	4885                	li	a7,1
    x = -xx;
     d20:	bfad                	j	c9a <printint+0x14>

0000000000000d22 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d22:	711d                	addi	sp,sp,-96
     d24:	ec86                	sd	ra,88(sp)
     d26:	e8a2                	sd	s0,80(sp)
     d28:	e0ca                	sd	s2,64(sp)
     d2a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d2c:	0005c903          	lbu	s2,0(a1)
     d30:	28090663          	beqz	s2,fbc <vprintf+0x29a>
     d34:	e4a6                	sd	s1,72(sp)
     d36:	fc4e                	sd	s3,56(sp)
     d38:	f852                	sd	s4,48(sp)
     d3a:	f456                	sd	s5,40(sp)
     d3c:	f05a                	sd	s6,32(sp)
     d3e:	ec5e                	sd	s7,24(sp)
     d40:	e862                	sd	s8,16(sp)
     d42:	e466                	sd	s9,8(sp)
     d44:	8b2a                	mv	s6,a0
     d46:	8a2e                	mv	s4,a1
     d48:	8bb2                	mv	s7,a2
  state = 0;
     d4a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     d4c:	4481                	li	s1,0
     d4e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     d50:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     d54:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     d58:	06c00c93          	li	s9,108
     d5c:	a005                	j	d7c <vprintf+0x5a>
        putc(fd, c0);
     d5e:	85ca                	mv	a1,s2
     d60:	855a                	mv	a0,s6
     d62:	f07ff0ef          	jal	c68 <putc>
     d66:	a019                	j	d6c <vprintf+0x4a>
    } else if(state == '%'){
     d68:	03598263          	beq	s3,s5,d8c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     d6c:	2485                	addiw	s1,s1,1
     d6e:	8726                	mv	a4,s1
     d70:	009a07b3          	add	a5,s4,s1
     d74:	0007c903          	lbu	s2,0(a5)
     d78:	22090a63          	beqz	s2,fac <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
     d7c:	0009079b          	sext.w	a5,s2
    if(state == 0){
     d80:	fe0994e3          	bnez	s3,d68 <vprintf+0x46>
      if(c0 == '%'){
     d84:	fd579de3          	bne	a5,s5,d5e <vprintf+0x3c>
        state = '%';
     d88:	89be                	mv	s3,a5
     d8a:	b7cd                	j	d6c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     d8c:	00ea06b3          	add	a3,s4,a4
     d90:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     d94:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     d96:	c681                	beqz	a3,d9e <vprintf+0x7c>
     d98:	9752                	add	a4,a4,s4
     d9a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     d9e:	05878363          	beq	a5,s8,de4 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     da2:	05978d63          	beq	a5,s9,dfc <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     da6:	07500713          	li	a4,117
     daa:	0ee78763          	beq	a5,a4,e98 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     dae:	07800713          	li	a4,120
     db2:	12e78963          	beq	a5,a4,ee4 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     db6:	07000713          	li	a4,112
     dba:	14e78e63          	beq	a5,a4,f16 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     dbe:	06300713          	li	a4,99
     dc2:	18e78e63          	beq	a5,a4,f5e <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     dc6:	07300713          	li	a4,115
     dca:	1ae78463          	beq	a5,a4,f72 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     dce:	02500713          	li	a4,37
     dd2:	04e79563          	bne	a5,a4,e1c <vprintf+0xfa>
        putc(fd, '%');
     dd6:	02500593          	li	a1,37
     dda:	855a                	mv	a0,s6
     ddc:	e8dff0ef          	jal	c68 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     de0:	4981                	li	s3,0
     de2:	b769                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     de4:	008b8913          	addi	s2,s7,8
     de8:	4685                	li	a3,1
     dea:	4629                	li	a2,10
     dec:	000ba583          	lw	a1,0(s7)
     df0:	855a                	mv	a0,s6
     df2:	e95ff0ef          	jal	c86 <printint>
     df6:	8bca                	mv	s7,s2
      state = 0;
     df8:	4981                	li	s3,0
     dfa:	bf8d                	j	d6c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     dfc:	06400793          	li	a5,100
     e00:	02f68963          	beq	a3,a5,e32 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e04:	06c00793          	li	a5,108
     e08:	04f68263          	beq	a3,a5,e4c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     e0c:	07500793          	li	a5,117
     e10:	0af68063          	beq	a3,a5,eb0 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     e14:	07800793          	li	a5,120
     e18:	0ef68263          	beq	a3,a5,efc <vprintf+0x1da>
        putc(fd, '%');
     e1c:	02500593          	li	a1,37
     e20:	855a                	mv	a0,s6
     e22:	e47ff0ef          	jal	c68 <putc>
        putc(fd, c0);
     e26:	85ca                	mv	a1,s2
     e28:	855a                	mv	a0,s6
     e2a:	e3fff0ef          	jal	c68 <putc>
      state = 0;
     e2e:	4981                	li	s3,0
     e30:	bf35                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e32:	008b8913          	addi	s2,s7,8
     e36:	4685                	li	a3,1
     e38:	4629                	li	a2,10
     e3a:	000bb583          	ld	a1,0(s7)
     e3e:	855a                	mv	a0,s6
     e40:	e47ff0ef          	jal	c86 <printint>
        i += 1;
     e44:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     e46:	8bca                	mv	s7,s2
      state = 0;
     e48:	4981                	li	s3,0
        i += 1;
     e4a:	b70d                	j	d6c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e4c:	06400793          	li	a5,100
     e50:	02f60763          	beq	a2,a5,e7e <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     e54:	07500793          	li	a5,117
     e58:	06f60963          	beq	a2,a5,eca <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e5c:	07800793          	li	a5,120
     e60:	faf61ee3          	bne	a2,a5,e1c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e64:	008b8913          	addi	s2,s7,8
     e68:	4681                	li	a3,0
     e6a:	4641                	li	a2,16
     e6c:	000bb583          	ld	a1,0(s7)
     e70:	855a                	mv	a0,s6
     e72:	e15ff0ef          	jal	c86 <printint>
        i += 2;
     e76:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     e78:	8bca                	mv	s7,s2
      state = 0;
     e7a:	4981                	li	s3,0
        i += 2;
     e7c:	bdc5                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e7e:	008b8913          	addi	s2,s7,8
     e82:	4685                	li	a3,1
     e84:	4629                	li	a2,10
     e86:	000bb583          	ld	a1,0(s7)
     e8a:	855a                	mv	a0,s6
     e8c:	dfbff0ef          	jal	c86 <printint>
        i += 2;
     e90:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     e92:	8bca                	mv	s7,s2
      state = 0;
     e94:	4981                	li	s3,0
        i += 2;
     e96:	bdd9                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
     e98:	008b8913          	addi	s2,s7,8
     e9c:	4681                	li	a3,0
     e9e:	4629                	li	a2,10
     ea0:	000be583          	lwu	a1,0(s7)
     ea4:	855a                	mv	a0,s6
     ea6:	de1ff0ef          	jal	c86 <printint>
     eaa:	8bca                	mv	s7,s2
      state = 0;
     eac:	4981                	li	s3,0
     eae:	bd7d                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     eb0:	008b8913          	addi	s2,s7,8
     eb4:	4681                	li	a3,0
     eb6:	4629                	li	a2,10
     eb8:	000bb583          	ld	a1,0(s7)
     ebc:	855a                	mv	a0,s6
     ebe:	dc9ff0ef          	jal	c86 <printint>
        i += 1;
     ec2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     ec4:	8bca                	mv	s7,s2
      state = 0;
     ec6:	4981                	li	s3,0
        i += 1;
     ec8:	b555                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     eca:	008b8913          	addi	s2,s7,8
     ece:	4681                	li	a3,0
     ed0:	4629                	li	a2,10
     ed2:	000bb583          	ld	a1,0(s7)
     ed6:	855a                	mv	a0,s6
     ed8:	dafff0ef          	jal	c86 <printint>
        i += 2;
     edc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     ede:	8bca                	mv	s7,s2
      state = 0;
     ee0:	4981                	li	s3,0
        i += 2;
     ee2:	b569                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
     ee4:	008b8913          	addi	s2,s7,8
     ee8:	4681                	li	a3,0
     eea:	4641                	li	a2,16
     eec:	000be583          	lwu	a1,0(s7)
     ef0:	855a                	mv	a0,s6
     ef2:	d95ff0ef          	jal	c86 <printint>
     ef6:	8bca                	mv	s7,s2
      state = 0;
     ef8:	4981                	li	s3,0
     efa:	bd8d                	j	d6c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     efc:	008b8913          	addi	s2,s7,8
     f00:	4681                	li	a3,0
     f02:	4641                	li	a2,16
     f04:	000bb583          	ld	a1,0(s7)
     f08:	855a                	mv	a0,s6
     f0a:	d7dff0ef          	jal	c86 <printint>
        i += 1;
     f0e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     f10:	8bca                	mv	s7,s2
      state = 0;
     f12:	4981                	li	s3,0
        i += 1;
     f14:	bda1                	j	d6c <vprintf+0x4a>
     f16:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     f18:	008b8d13          	addi	s10,s7,8
     f1c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f20:	03000593          	li	a1,48
     f24:	855a                	mv	a0,s6
     f26:	d43ff0ef          	jal	c68 <putc>
  putc(fd, 'x');
     f2a:	07800593          	li	a1,120
     f2e:	855a                	mv	a0,s6
     f30:	d39ff0ef          	jal	c68 <putc>
     f34:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f36:	00000b97          	auipc	s7,0x0
     f3a:	5dab8b93          	addi	s7,s7,1498 # 1510 <digits>
     f3e:	03c9d793          	srli	a5,s3,0x3c
     f42:	97de                	add	a5,a5,s7
     f44:	0007c583          	lbu	a1,0(a5)
     f48:	855a                	mv	a0,s6
     f4a:	d1fff0ef          	jal	c68 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     f4e:	0992                	slli	s3,s3,0x4
     f50:	397d                	addiw	s2,s2,-1
     f52:	fe0916e3          	bnez	s2,f3e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
     f56:	8bea                	mv	s7,s10
      state = 0;
     f58:	4981                	li	s3,0
     f5a:	6d02                	ld	s10,0(sp)
     f5c:	bd01                	j	d6c <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
     f5e:	008b8913          	addi	s2,s7,8
     f62:	000bc583          	lbu	a1,0(s7)
     f66:	855a                	mv	a0,s6
     f68:	d01ff0ef          	jal	c68 <putc>
     f6c:	8bca                	mv	s7,s2
      state = 0;
     f6e:	4981                	li	s3,0
     f70:	bbf5                	j	d6c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     f72:	008b8993          	addi	s3,s7,8
     f76:	000bb903          	ld	s2,0(s7)
     f7a:	00090f63          	beqz	s2,f98 <vprintf+0x276>
        for(; *s; s++)
     f7e:	00094583          	lbu	a1,0(s2)
     f82:	c195                	beqz	a1,fa6 <vprintf+0x284>
          putc(fd, *s);
     f84:	855a                	mv	a0,s6
     f86:	ce3ff0ef          	jal	c68 <putc>
        for(; *s; s++)
     f8a:	0905                	addi	s2,s2,1
     f8c:	00094583          	lbu	a1,0(s2)
     f90:	f9f5                	bnez	a1,f84 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
     f92:	8bce                	mv	s7,s3
      state = 0;
     f94:	4981                	li	s3,0
     f96:	bbd9                	j	d6c <vprintf+0x4a>
          s = "(null)";
     f98:	00000917          	auipc	s2,0x0
     f9c:	51090913          	addi	s2,s2,1296 # 14a8 <malloc+0x404>
        for(; *s; s++)
     fa0:	02800593          	li	a1,40
     fa4:	b7c5                	j	f84 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
     fa6:	8bce                	mv	s7,s3
      state = 0;
     fa8:	4981                	li	s3,0
     faa:	b3c9                	j	d6c <vprintf+0x4a>
     fac:	64a6                	ld	s1,72(sp)
     fae:	79e2                	ld	s3,56(sp)
     fb0:	7a42                	ld	s4,48(sp)
     fb2:	7aa2                	ld	s5,40(sp)
     fb4:	7b02                	ld	s6,32(sp)
     fb6:	6be2                	ld	s7,24(sp)
     fb8:	6c42                	ld	s8,16(sp)
     fba:	6ca2                	ld	s9,8(sp)
    }
  }
}
     fbc:	60e6                	ld	ra,88(sp)
     fbe:	6446                	ld	s0,80(sp)
     fc0:	6906                	ld	s2,64(sp)
     fc2:	6125                	addi	sp,sp,96
     fc4:	8082                	ret

0000000000000fc6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     fc6:	715d                	addi	sp,sp,-80
     fc8:	ec06                	sd	ra,24(sp)
     fca:	e822                	sd	s0,16(sp)
     fcc:	1000                	addi	s0,sp,32
     fce:	e010                	sd	a2,0(s0)
     fd0:	e414                	sd	a3,8(s0)
     fd2:	e818                	sd	a4,16(s0)
     fd4:	ec1c                	sd	a5,24(s0)
     fd6:	03043023          	sd	a6,32(s0)
     fda:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     fde:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     fe2:	8622                	mv	a2,s0
     fe4:	d3fff0ef          	jal	d22 <vprintf>
}
     fe8:	60e2                	ld	ra,24(sp)
     fea:	6442                	ld	s0,16(sp)
     fec:	6161                	addi	sp,sp,80
     fee:	8082                	ret

0000000000000ff0 <printf>:

void
printf(const char *fmt, ...)
{
     ff0:	711d                	addi	sp,sp,-96
     ff2:	ec06                	sd	ra,24(sp)
     ff4:	e822                	sd	s0,16(sp)
     ff6:	1000                	addi	s0,sp,32
     ff8:	e40c                	sd	a1,8(s0)
     ffa:	e810                	sd	a2,16(s0)
     ffc:	ec14                	sd	a3,24(s0)
     ffe:	f018                	sd	a4,32(s0)
    1000:	f41c                	sd	a5,40(s0)
    1002:	03043823          	sd	a6,48(s0)
    1006:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    100a:	00840613          	addi	a2,s0,8
    100e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1012:	85aa                	mv	a1,a0
    1014:	4505                	li	a0,1
    1016:	d0dff0ef          	jal	d22 <vprintf>
}
    101a:	60e2                	ld	ra,24(sp)
    101c:	6442                	ld	s0,16(sp)
    101e:	6125                	addi	sp,sp,96
    1020:	8082                	ret

0000000000001022 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1022:	1141                	addi	sp,sp,-16
    1024:	e422                	sd	s0,8(sp)
    1026:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1028:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    102c:	00001797          	auipc	a5,0x1
    1030:	fe47b783          	ld	a5,-28(a5) # 2010 <freep>
    1034:	a02d                	j	105e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1036:	4618                	lw	a4,8(a2)
    1038:	9f2d                	addw	a4,a4,a1
    103a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    103e:	6398                	ld	a4,0(a5)
    1040:	6310                	ld	a2,0(a4)
    1042:	a83d                	j	1080 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1044:	ff852703          	lw	a4,-8(a0)
    1048:	9f31                	addw	a4,a4,a2
    104a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    104c:	ff053683          	ld	a3,-16(a0)
    1050:	a091                	j	1094 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1052:	6398                	ld	a4,0(a5)
    1054:	00e7e463          	bltu	a5,a4,105c <free+0x3a>
    1058:	00e6ea63          	bltu	a3,a4,106c <free+0x4a>
{
    105c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    105e:	fed7fae3          	bgeu	a5,a3,1052 <free+0x30>
    1062:	6398                	ld	a4,0(a5)
    1064:	00e6e463          	bltu	a3,a4,106c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1068:	fee7eae3          	bltu	a5,a4,105c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    106c:	ff852583          	lw	a1,-8(a0)
    1070:	6390                	ld	a2,0(a5)
    1072:	02059813          	slli	a6,a1,0x20
    1076:	01c85713          	srli	a4,a6,0x1c
    107a:	9736                	add	a4,a4,a3
    107c:	fae60de3          	beq	a2,a4,1036 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1080:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1084:	4790                	lw	a2,8(a5)
    1086:	02061593          	slli	a1,a2,0x20
    108a:	01c5d713          	srli	a4,a1,0x1c
    108e:	973e                	add	a4,a4,a5
    1090:	fae68ae3          	beq	a3,a4,1044 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1094:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1096:	00001717          	auipc	a4,0x1
    109a:	f6f73d23          	sd	a5,-134(a4) # 2010 <freep>
}
    109e:	6422                	ld	s0,8(sp)
    10a0:	0141                	addi	sp,sp,16
    10a2:	8082                	ret

00000000000010a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10a4:	7139                	addi	sp,sp,-64
    10a6:	fc06                	sd	ra,56(sp)
    10a8:	f822                	sd	s0,48(sp)
    10aa:	f426                	sd	s1,40(sp)
    10ac:	ec4e                	sd	s3,24(sp)
    10ae:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10b0:	02051493          	slli	s1,a0,0x20
    10b4:	9081                	srli	s1,s1,0x20
    10b6:	04bd                	addi	s1,s1,15
    10b8:	8091                	srli	s1,s1,0x4
    10ba:	0014899b          	addiw	s3,s1,1
    10be:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    10c0:	00001517          	auipc	a0,0x1
    10c4:	f5053503          	ld	a0,-176(a0) # 2010 <freep>
    10c8:	c915                	beqz	a0,10fc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10cc:	4798                	lw	a4,8(a5)
    10ce:	08977a63          	bgeu	a4,s1,1162 <malloc+0xbe>
    10d2:	f04a                	sd	s2,32(sp)
    10d4:	e852                	sd	s4,16(sp)
    10d6:	e456                	sd	s5,8(sp)
    10d8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    10da:	8a4e                	mv	s4,s3
    10dc:	0009871b          	sext.w	a4,s3
    10e0:	6685                	lui	a3,0x1
    10e2:	00d77363          	bgeu	a4,a3,10e8 <malloc+0x44>
    10e6:	6a05                	lui	s4,0x1
    10e8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    10ec:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10f0:	00001917          	auipc	s2,0x1
    10f4:	f2090913          	addi	s2,s2,-224 # 2010 <freep>
  if(p == SBRK_ERROR)
    10f8:	5afd                	li	s5,-1
    10fa:	a081                	j	113a <malloc+0x96>
    10fc:	f04a                	sd	s2,32(sp)
    10fe:	e852                	sd	s4,16(sp)
    1100:	e456                	sd	s5,8(sp)
    1102:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1104:	00001797          	auipc	a5,0x1
    1108:	30478793          	addi	a5,a5,772 # 2408 <base>
    110c:	00001717          	auipc	a4,0x1
    1110:	f0f73223          	sd	a5,-252(a4) # 2010 <freep>
    1114:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1116:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    111a:	b7c1                	j	10da <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    111c:	6398                	ld	a4,0(a5)
    111e:	e118                	sd	a4,0(a0)
    1120:	a8a9                	j	117a <malloc+0xd6>
  hp->s.size = nu;
    1122:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1126:	0541                	addi	a0,a0,16
    1128:	efbff0ef          	jal	1022 <free>
  return freep;
    112c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1130:	c12d                	beqz	a0,1192 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1132:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1134:	4798                	lw	a4,8(a5)
    1136:	02977263          	bgeu	a4,s1,115a <malloc+0xb6>
    if(p == freep)
    113a:	00093703          	ld	a4,0(s2)
    113e:	853e                	mv	a0,a5
    1140:	fef719e3          	bne	a4,a5,1132 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1144:	8552                	mv	a0,s4
    1146:	9f9ff0ef          	jal	b3e <sbrk>
  if(p == SBRK_ERROR)
    114a:	fd551ce3          	bne	a0,s5,1122 <malloc+0x7e>
        return 0;
    114e:	4501                	li	a0,0
    1150:	7902                	ld	s2,32(sp)
    1152:	6a42                	ld	s4,16(sp)
    1154:	6aa2                	ld	s5,8(sp)
    1156:	6b02                	ld	s6,0(sp)
    1158:	a03d                	j	1186 <malloc+0xe2>
    115a:	7902                	ld	s2,32(sp)
    115c:	6a42                	ld	s4,16(sp)
    115e:	6aa2                	ld	s5,8(sp)
    1160:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1162:	fae48de3          	beq	s1,a4,111c <malloc+0x78>
        p->s.size -= nunits;
    1166:	4137073b          	subw	a4,a4,s3
    116a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    116c:	02071693          	slli	a3,a4,0x20
    1170:	01c6d713          	srli	a4,a3,0x1c
    1174:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1176:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    117a:	00001717          	auipc	a4,0x1
    117e:	e8a73b23          	sd	a0,-362(a4) # 2010 <freep>
      return (void*)(p + 1);
    1182:	01078513          	addi	a0,a5,16
  }
}
    1186:	70e2                	ld	ra,56(sp)
    1188:	7442                	ld	s0,48(sp)
    118a:	74a2                	ld	s1,40(sp)
    118c:	69e2                	ld	s3,24(sp)
    118e:	6121                	addi	sp,sp,64
    1190:	8082                	ret
    1192:	7902                	ld	s2,32(sp)
    1194:	6a42                	ld	s4,16(sp)
    1196:	6aa2                	ld	s5,8(sp)
    1198:	6b02                	ld	s6,0(sp)
    119a:	b7f5                	j	1186 <malloc+0xe2>
