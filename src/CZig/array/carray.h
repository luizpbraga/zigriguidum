
#include <stdio.h>

extern void showarray(int *a, int len) {
  for (int i=0; i<len; i++) printf("%i\n", a[i]);
}
