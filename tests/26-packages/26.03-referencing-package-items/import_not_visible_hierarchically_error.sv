/*
:section: 26.3 Referencing data in packages
:summary: An imported name cannot be reached by a hierarchical reference into the importing
  scope.
:type: elaboration
:should_fail_because: c.k names an imported identifier by hierarchical reference
*/
package nums; int k; endpackage
module child;
  import nums::k;
endmodule
module top;
  child c();
  initial c.k = 1;
endmodule
