/*
:section: 7.4.6 Operations on arrays
:summary: An integer value cannot be assigned directly to an unpacked array.
:type: elaboration
:should_fail_because: an integer is assigned to an unpacked array
*/
module top;
  bit flags [8];
  initial flags = 8'hFF;
endmodule
