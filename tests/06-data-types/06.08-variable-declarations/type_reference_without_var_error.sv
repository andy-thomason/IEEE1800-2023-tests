/*
:section: 6.8 Variable declarations
:summary: A variable declared with a type reference must begin with the var keyword.
:type: parse
:should_fail_because: a type reference starts a variable declaration without var
*/
module top;
  logic [5:0] model;
  type(model) copy;
endmodule
