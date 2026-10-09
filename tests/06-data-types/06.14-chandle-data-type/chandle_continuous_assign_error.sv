/*
:section: 6.14 Chandle data type
:summary: A chandle must not be the target of a continuous assignment.
:type: elaboration
:should_fail_because: a chandle is the target of a continuous assignment
*/
module top;
  chandle c, d;
  assign d = c;
endmodule
