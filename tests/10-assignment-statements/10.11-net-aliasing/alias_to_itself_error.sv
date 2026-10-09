/*
:section: 10.11 Net aliasing
:summary: Aliasing bits of a net back onto themselves is illegal.
:type: elaboration
:should_fail_because: bits of a net are aliased to themselves
*/
module top;
  wire [7:0] bus;
    wire [3:0] low;
    alias bus = {bus[7:4], low};
endmodule
