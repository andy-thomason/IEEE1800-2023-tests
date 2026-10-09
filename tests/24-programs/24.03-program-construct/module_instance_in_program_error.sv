/*
:section: 24.3 The program construct
:summary: A program block may not instantiate a module.
:type: elaboration
:should_fail_because: a program instantiates a module
*/
module leaf; endmodule
program p;
  leaf u();
endprogram
module top;
  p u();
endmodule
