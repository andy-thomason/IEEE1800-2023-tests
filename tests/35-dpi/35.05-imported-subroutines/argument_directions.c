#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

void shuffle(int a, int *b, int *c, const int *arr) {
    *b = a * 2;
    *c += a;
    (void)arr;
}

#ifdef __cplusplus
}
#endif
