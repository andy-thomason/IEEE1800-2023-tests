/*
:section: 26.3 Referencing data in packages
:summary: The same identifier may not be explicitly imported from two different packages.
:type: elaboration
:should_fail_because: k is explicitly imported from two packages
*/
package p1; int k; endpackage
package p2; int k; endpackage
module top;
  import p1::k;
  import p2::k;
endmodule
