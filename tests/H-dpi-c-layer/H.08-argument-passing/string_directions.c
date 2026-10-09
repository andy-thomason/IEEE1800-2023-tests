#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

int c_strlen(const char *s) { return (int)strlen(s); }
void c_name(const char **s) { *s = "from C"; }
void c_upgrade(const char **s) {
    static char buf[32];
    strcpy(buf, *s);
    strcat(buf, "+new");
    *s = buf;
}

#ifdef __cplusplus
}
#endif
