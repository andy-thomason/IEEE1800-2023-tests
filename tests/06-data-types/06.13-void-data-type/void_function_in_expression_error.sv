/*
:section: 6.13 Void data type
:summary: A void function call must not be used as a value in an expression.
:type: elaboration
:should_fail_because: a void function is used as a value
*/
module top;
  function void nothing();
  endfunction
  int x;
  initial x = nothing();
endmodule
