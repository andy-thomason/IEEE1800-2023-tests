/*
:section: 10.11 Net aliasing
:summary: Nets joined by alias must all have the same width.
:type: elaboration
:should_fail_because: aliased nets differ in size
*/
module top;
  wire [3:0] a;
    wire [7:0] b;
    alias a = b;
endmodule
