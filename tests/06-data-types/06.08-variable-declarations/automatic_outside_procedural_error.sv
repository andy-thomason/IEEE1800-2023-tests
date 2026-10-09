/*
:section: 6.8 Variable declarations
:summary: The automatic keyword is illegal on a variable declared outside any procedural
  context.
:type: elaboration
:should_fail_because: automatic is used for a module-level variable
*/
module top;
  automatic int counter;
endmodule
