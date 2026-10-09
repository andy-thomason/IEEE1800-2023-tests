/*
:section: 11.4.12 Concatenation operators
:summary: A number without an explicit size may not appear as a concatenation operand.
:type: elaboration
:should_fail_because: an unsized number appears in a concatenation
*/
module top;
  logic [7:0] r;
  initial r = {4'h3, 5};
endmodule
