/*
:section: 24.3 The program construct
:summary: A program block may not declare another program inside it.
:type: elaboration
:should_fail_because: a program contains another program
*/
module leaf; endmodule
program p;
  program inner; endprogram
endprogram
module top;
  p u();
endmodule
