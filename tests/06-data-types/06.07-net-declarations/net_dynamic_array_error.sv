/*
:section: 6.7.1 Net declarations with built-in net types
:summary: A net must not be declared as a dynamic array; only fixed-size unpacked arrays are
  allowed.
:type: elaboration
:should_fail_because: a dynamic array is not a fixed-size unpacked array
*/
module top;
  wire logic w [];
endmodule
