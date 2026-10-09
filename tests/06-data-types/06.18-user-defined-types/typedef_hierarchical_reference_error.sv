/*
:section: 6.18 User-defined types
:summary: A type identifier must not be referenced through a hierarchical path.
:type: elaboration
:should_fail_because: a type is referenced through a hierarchical name
*/
module inner;
  typedef logic [2:0] small_t;
endmodule

module top;
  inner u();
  top.u.small_t value;
endmodule
