#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int sum_open(const svOpenArrayHandle h) {
    int total = 0;
    for (int i = svLow(h, 1); i <= svHigh(h, 1); i++)
        total += *(int *)svGetArrElemPtr1(h, i);
    return total;
}

#ifdef __cplusplus
}
#endif
