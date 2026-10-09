/*
:section: 7.4.1 Packed arrays
:summary: A packed dimension must be a range like [7:0], not a single size like [8].
:type: parse
:should_fail_because: a packed dimension is given as [8]
*/
module top;
  bit [8] v;
endmodule
