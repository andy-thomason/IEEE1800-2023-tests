#include <string.h>
#include <math.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int sv_long_wait(void);
static int saw = 0;
int c_runner(void) {
    int r = sv_long_wait();
    if (r == 1) saw |= 1;
    if (svIsDisabledState()) saw |= 2;
    svAckDisabledState();
    return 1;
}
int c_saw_disable(void) { return saw; }

#ifdef __cplusplus
}
#endif
