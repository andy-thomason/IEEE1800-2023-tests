/*
:section: 30.4.5 Full connection and parallel connection paths
:summary: A parallel => module path requires source and destination of equal bit width.
:type: elaboration
:should_fail_because: a parallel path connects 4 bits to 2
:flags-icarus: -gspecify
*/
module dut(input [3:0] a, output [1:0] y);
  assign y = a[1:0];
  specify
    (a => y) = 2;
  endspecify
endmodule
  module top;
  endmodule
