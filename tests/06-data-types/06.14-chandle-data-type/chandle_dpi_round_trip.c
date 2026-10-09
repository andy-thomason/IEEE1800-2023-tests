/* DPI-C helpers for the chandle tests: a heap counter behind an opaque handle. */
#include <stdlib.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

void *counter_new(int start) {
    int *p = (int *)malloc(sizeof(int));
    *p = start;
    return p;
}

int counter_next(void *handle) {
    int *p = (int *)handle;
    return ++*p;
}

void counter_free(void *handle) {
    free(handle);
}

int handle_is_null(void *handle) {
    return handle == 0;
}

#ifdef __cplusplus
}
#endif
