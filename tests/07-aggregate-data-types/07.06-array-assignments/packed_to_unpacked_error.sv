/*
:section: 7.6 Array assignments
:summary: Assigning a packed array to an unpacked array requires an explicit cast.
:type: elaboration
:should_fail_because: a packed array is assigned to an unpacked array without a cast
*/
module top;
  bit [7:0] packed_bits;
  bit unpacked_bits [8];
  initial unpacked_bits = packed_bits;
endmodule
