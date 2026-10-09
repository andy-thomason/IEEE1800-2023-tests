/*
:section: 6.20.6 Const constants
:summary: A const variable must not be assigned after its declaration.
:type: elaboration
:should_fail_because: a const variable is assigned after its declaration
*/
module top;
  const int FIXED = 3;
  initial FIXED = 4;
endmodule
