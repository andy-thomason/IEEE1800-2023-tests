#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
static int key;
void bump(void) {
    svScope s = svGetScope();
    int *n = (int *)svGetUserData(s, &key);
    if (!n) { n = (int *)calloc(1, sizeof *n); svPutUserData(s, &key, n); }
    ++*n;
}
int count(void) {
    int *n = (int *)svGetUserData(svGetScope(), &key);
    return n ? *n : 0;
}

#ifdef __cplusplus
}
#endif
