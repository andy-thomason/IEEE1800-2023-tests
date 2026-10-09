/*
:section: 10.6.2 The force and release procedural statements
:summary: A force statement may not target a bit-select of a variable.
:type: elaboration
:should_fail_because: force targets a bit-select of a variable
*/
module top;
  logic [3:0] v;
  initial force v[0] = 1'b1;
endmodule
