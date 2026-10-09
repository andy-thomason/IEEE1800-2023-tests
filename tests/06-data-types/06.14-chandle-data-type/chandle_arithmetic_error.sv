/*
:section: 6.14 Chandle data type
:summary: Arithmetic operators must not be applied to a chandle.
:type: elaboration
:should_fail_because: arithmetic is applied to a chandle
*/
module top;
  chandle c;
  chandle d;
  initial d = c + 1;
endmodule
