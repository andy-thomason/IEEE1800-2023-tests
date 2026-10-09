/*
:section: 24.3 The program construct
:summary: Code outside any program may not reference a variable declared inside a program.
:type: elaboration
:should_fail_because: a module reads a program variable
*/
program p;
  int secret = 1;
endprogram
module top;
  p u();
  int copy;
  initial copy = u.secret;
endmodule
