/*
:section: 26.3 Referencing data in packages
:summary: Explicitly importing a name already declared locally in the same scope is illegal.
:type: elaboration
:should_fail_because: k is declared locally and explicitly imported
*/
package nums; int k; endpackage
module top;
  int k;
  import nums::k;
endmodule
