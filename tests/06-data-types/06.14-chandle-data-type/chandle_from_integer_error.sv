/*
:section: 6.14 Chandle data type
:summary: An integer value must not be assigned to a chandle variable.
:type: elaboration
:should_fail_because: an integer is assigned to a chandle
*/
module top;
  chandle c;
  initial c = 64'h1000;
endmodule
