#include "kernel/types.h"
#include "user/user.h"
int
main(void)
{
  printf("ugetpid: %d\n", ugetpid());
  exit(0);
}