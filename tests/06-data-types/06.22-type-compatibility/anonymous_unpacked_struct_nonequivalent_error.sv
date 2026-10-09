/*
:section: 6.22.2 Equivalent types
:summary: Identical anonymous unpacked structs in separate declarations are not equivalent
  types.
:type: elaboration
:should_fail_because: unpacked structs from two declarations are not equivalent
*/
module top;
  struct { int a; byte b; } p;
  struct { int a; byte b; } r;
  initial p = r;
endmodule
