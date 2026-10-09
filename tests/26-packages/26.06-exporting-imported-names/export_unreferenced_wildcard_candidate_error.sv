/*
:section: 26.6 Exporting imported names from packages
:summary: A wildcard export omits candidate names the package never referenced, so importers
  cannot see them.
:type: elaboration
:should_fail_because: beta was never referenced in mid, so mid does not export it
*/
package base;
  int alpha, beta;
endpackage
package mid;
  import base::*;
  int a = alpha;
  export base::*;
endpackage
module top;
  import mid::*;
  int b = beta;
endmodule
