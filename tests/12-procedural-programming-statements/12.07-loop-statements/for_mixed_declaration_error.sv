/*
:section: 12.7.1 The for-loop
:summary: A for-loop initializer must declare either every control variable locally or none of
  them.
:type: parse
:should_fail_because: only some for-loop control variables are declared locally
*/
module top;
  int x;
  initial for (x = 0, int y = 0; x < 3; x++) ;
endmodule
