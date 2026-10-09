#include <string.h>
#include <stdint.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int report_id(void);
int where_am_i(const char **name) { *name = svGetNameFromScope(svGetScope()); return 0; }
int call_in(const char *scope_name) {
    svScope prev = svSetScope(svGetScopeFromName(scope_name));
    int r = report_id();
    svSetScope(prev);
    return r;
}
int unknown_scope_is_null(void) { return svGetScopeFromName("top.no_such_instance") == NULL; }

#ifdef __cplusplus
}
#endif
