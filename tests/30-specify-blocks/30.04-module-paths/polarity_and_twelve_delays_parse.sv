/*
:section: 30.4.7 Module path polarity
:summary: Paths accept +=> and -*> polarity prefixes and lists of one, two, six or twelve
  delays.
:type: elaboration
:flags-icarus: -gspecify
*/
module dut(input a, input b, input c, output y, output n, output z);
  assign y = a;
  assign n = ~b;
  assign z = c;
  specify
    (a +=> y) = 2;
    (b -*> n) = (2, 3);
    (c => z) = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
  endspecify
endmodule
module top;
  logic a, b, c;
  wire y, n, z;
  dut u(.*);
endmodule
