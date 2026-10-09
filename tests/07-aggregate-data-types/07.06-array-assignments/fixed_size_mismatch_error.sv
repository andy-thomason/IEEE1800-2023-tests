/*
:section: 7.6 Array assignments
:summary: Assigning between fixed-size unpacked arrays with different element counts is illegal.
:type: elaboration
:should_fail_because: fixed-size arrays of different sizes
*/
module top;
  int six [6];
  int nine [9];
  initial six = nine;
endmodule
