#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int sv_wait(int n);
int c_wait_twice(int n) {
    sv_wait(n);
    sv_wait(n);
    return 0;
}

#ifdef __cplusplus
}
#endif
