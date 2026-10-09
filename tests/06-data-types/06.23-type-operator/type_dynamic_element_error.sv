/*
:section: 6.23 Type operator
:summary: The type operator cannot be applied to an element of a dynamic array.
:type: elaboration
:should_fail_because: the type() expression refers to an element of a dynamic array
*/
module top;
  int dyn [];
  var type(dyn[0]) copy;
endmodule
