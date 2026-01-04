#include "kernel/types.h"
#include "user/user.h"

int
main(void)
{
  int r = prac();
  printf("prac syscall returned %d\n", r);
  exit(0);
}