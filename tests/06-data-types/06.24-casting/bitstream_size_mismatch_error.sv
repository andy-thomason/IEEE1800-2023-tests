/*
:section: 6.24.3 Bit-stream casting
:summary: Casting between fixed-size types of unequal width is a compile error when either is
  unpacked.
:type: elaboration
:should_fail_because: a 24-bit unpacked struct is cast to a 32-bit int
*/
module top;
  typedef struct { byte a; byte b; byte c; } three_t;
  three_t t;
  int i;
  initial i = int'(t);
endmodule
