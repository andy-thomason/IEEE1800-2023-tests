/*
:section: 7.8 Associative arrays
:summary: An associative array index type must not declare a new type inline.
:type: elaboration
:should_fail_because: the index type declares a new enum type
*/
module top;
  int by_enum [enum {RED, BLUE}];
endmodule
