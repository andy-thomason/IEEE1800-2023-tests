/*
:section: 6.6.8 Generic interconnect
:summary: An interconnect net must not be declared with a data type.
:type: parse
:should_fail_because: an interconnect net has a data type
*/
module top;
  interconnect logic [3:0] link;
endmodule
