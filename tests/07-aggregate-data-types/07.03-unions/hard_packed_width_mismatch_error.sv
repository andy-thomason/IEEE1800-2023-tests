/*
:section: 7.3.1 Packed unions
:summary: All members of a hard packed union must be the same width.
:type: elaboration
:should_fail_because: members of a hard packed union have different sizes
*/
module top;
  union packed { bit [15:0] word; bit [7:0] small_part; } u;
endmodule
