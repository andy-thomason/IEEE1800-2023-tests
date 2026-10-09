/*
:section: 6.24.3 Bit-stream casting
:summary: An associative array type cannot be the destination of a bit-stream cast.
:type: elaboration
:should_fail_because: the destination of a bit-stream cast is an associative array
*/
module top;
  typedef byte map_t [int];
  map_t m;
  initial m = map_t'(32'h01020304);
endmodule
