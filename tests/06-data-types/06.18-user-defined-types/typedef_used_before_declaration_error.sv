/*
:section: 6.18 User-defined types
:summary: A user-defined type must be declared before any use of its name.
:type: elaboration
:should_fail_because: later_t is used before its typedef
*/
module top;
  later_t value;
  typedef int later_t;
endmodule
