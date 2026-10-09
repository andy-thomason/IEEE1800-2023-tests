/*
:section: 24.3 The program construct
:summary: A program block may not contain an always procedure.
:type: elaboration
:should_fail_because: a program contains an always procedure
*/
module leaf; endmodule
program p;
  logic c; always #1 c = ~c;
endprogram
module top;
  p u();
endmodule
