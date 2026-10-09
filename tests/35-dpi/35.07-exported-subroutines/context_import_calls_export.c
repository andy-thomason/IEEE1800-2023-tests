#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int sv_scale(int v);
int c_apply(int x) { return sv_scale(x) + 1; }

#ifdef __cplusplus
}
#endif
