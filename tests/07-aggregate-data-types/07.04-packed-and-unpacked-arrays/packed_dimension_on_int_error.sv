/*
:section: 7.4.1 Packed arrays
:summary: A predefined-width integer type such as int cannot have a packed dimension.
:type: elaboration
:should_fail_because: int is given a packed dimension
*/
module top;
  int [3:0] v;
endmodule
