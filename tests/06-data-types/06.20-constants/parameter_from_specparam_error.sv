/*
:section: 6.20.5 Specify parameters
:summary: A parameter or localparam value must not depend on any specparam.
:type: elaboration
:should_fail_because: a parameter is assigned an expression containing a specparam
*/
module top;
  specparam HOLD = 2;
  parameter int TOTAL = HOLD + 1;
endmodule
