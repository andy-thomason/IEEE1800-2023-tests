/*
:section: 6.6.7 User-defined nettypes
:summary: A user-defined nettype must not use string as its data type.
:type: elaboration
:should_fail_because: string is not a valid data type for a nettype
*/
module top;
  nettype string text_net;
endmodule
