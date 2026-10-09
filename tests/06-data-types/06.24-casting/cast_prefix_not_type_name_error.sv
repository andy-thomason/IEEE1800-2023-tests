/*
:section: 6.24.1 Cast operator
:summary: A cast prefix must be a type keyword or type identifier, not a ranged type expression.
:type: parse
:should_fail_because: the cast prefix is a complex type, not a type keyword or type identifier
*/
module top;
  int i = 300;
  logic [3:0] r;
  initial r = logic [3:0]'(i);
endmodule
