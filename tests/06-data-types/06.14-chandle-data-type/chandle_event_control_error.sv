/*
:section: 6.14 Chandle data type
:summary: A chandle must not appear in an event control expression.
:type: elaboration
:should_fail_because: a chandle is used in an event expression
*/
module top;
  chandle c;
  initial @(c) $display("changed");
endmodule
