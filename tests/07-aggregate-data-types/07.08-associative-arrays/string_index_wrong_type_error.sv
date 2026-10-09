/*
:section: 7.8.2 String index
:summary: An int value cannot index an associative array whose index type is string.
:type: elaboration
:should_fail_because: an int is used to index a string-indexed associative array
*/
module top;
  int by_name [string];
  initial by_name[42] = 1;
endmodule
