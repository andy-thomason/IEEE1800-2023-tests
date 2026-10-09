/*
:section: 6.21 Scope and lifetime
:summary: A variable cannot be referenced by simple name before its declaration.
:type: elaboration
:should_fail_because: early is referenced before it is declared
*/
module top;
  initial early = 1;
  int early;
endmodule
