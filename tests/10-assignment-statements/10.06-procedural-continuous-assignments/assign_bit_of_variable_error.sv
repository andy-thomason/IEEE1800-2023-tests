/*
:section: 10.6.1 The assign and deassign procedural statements
:summary: A procedural assign statement may not target a partial range of a variable.
:type: elaboration
:should_fail_because: assign targets a part-select of a variable
*/
module top;
  logic [3:0] v;
  initial assign v[1:0] = 2'b10;
endmodule
