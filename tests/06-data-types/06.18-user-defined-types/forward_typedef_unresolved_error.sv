/*
:section: 6.18 User-defined types
:summary: A forward typedef must be resolved by an actual type definition in the same scope.
:type: elaboration
:should_fail_because: the forward typedef is never given a definition
*/
module top;
  typedef never_defined_t;
  never_defined_t value;
endmodule
