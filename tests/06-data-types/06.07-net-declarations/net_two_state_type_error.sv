/*
:section: 6.7.1 Net declarations with built-in net types
:summary: A net must not use a 2-state data type such as bit.
:type: elaboration
:should_fail_because: bit is a 2-state type, which is not a valid net data type
*/
module top;
  wire bit [3:0] w;
endmodule
