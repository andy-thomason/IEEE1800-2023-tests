/*
:section: 24.3 The program construct
:summary: A program block may not contain gate primitive instances.
:type: elaboration
:should_fail_because: a program contains a primitive instance
*/
module leaf; endmodule
program p;
  wire a, b; and g(a, b, b);
endprogram
module top;
  p u();
endmodule
