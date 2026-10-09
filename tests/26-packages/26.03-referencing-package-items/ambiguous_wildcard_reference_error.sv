/*
:section: 26.3 Referencing data in packages
:summary: Referencing a name provided by two wildcard-imported packages is an ambiguity error.
:type: elaboration
:should_fail_because: k is visible through two wildcard imports and is referenced
*/
package p1; int k = 1; endpackage
package p2; int k = 2; endpackage
module top;
  import p1::*;
  import p2::*;
  int copy = k;
endmodule
