/*
:section: 6.23 Type operator
:summary: A type reference may only be compared against another type reference, not a value.
:type: elaboration
:should_fail_because: a type reference is compared with a value
*/
module top;
  logic [3:0] v;
  localparam bit B = (type(v) == 4);
endmodule
