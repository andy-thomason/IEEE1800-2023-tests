/*
:section: 6.20.5 Specify parameters
:summary: A specparam must not appear in the range of a declaration.
:type: elaboration
:should_fail_because: a specparam is used in the range of a declaration
*/
module top;
  specparam W = 4;
  logic [W-1:0] v;
endmodule
