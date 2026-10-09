/*
:section: 26.3 Referencing data in packages
:summary: Referencing a name that no declaration or import provides is an error.
:type: elaboration
:should_fail_because: missing_name is not declared anywhere
*/
package nums; int k; endpackage
module top;
  import nums::*;
  int copy = missing_name;
endmodule
