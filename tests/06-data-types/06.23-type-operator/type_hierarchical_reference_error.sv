/*
:section: 6.23 Type operator
:summary: The expression inside type() must not contain a hierarchical reference.
:type: elaboration
:should_fail_because: the type() expression contains a hierarchical reference
*/
module inner;
  logic [3:0] v;
endmodule

module top;
  inner u();
  var type(top.u.v) copy;
endmodule
