/*
:section: 7.6 Array assignments
:summary: Unpacked array assignment requires equivalent element types; int and logic [31:0]
  differ.
:type: elaboration
:should_fail_because: int and logic [31:0] elements are not equivalent
*/
module top;
  int ints [4];
  logic [31:0] vecs [4];
  initial ints = vecs;
endmodule
