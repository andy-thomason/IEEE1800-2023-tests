/*
:section: 26.3 Referencing data in packages
:summary: After a wildcard-imported name is used, declaring that name locally in the scope is
  illegal.
:type: elaboration
:should_fail_because: k is declared after a reference has imported nums::k
*/
package nums; int k = 5; endpackage
module top;
  import nums::*;
  int copy = k;
  int k;
endmodule
