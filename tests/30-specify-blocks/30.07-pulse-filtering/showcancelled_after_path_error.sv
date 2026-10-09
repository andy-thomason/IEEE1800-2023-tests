/*
:section: 30.7.4.2 Negative pulse detection
:summary: Naming an output in showcancelled after it already appears in a module path is an
  error.
:type: elaboration
:should_fail_because: showcancelled names y after its path
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 3;
    showcancelled y;
  endspecify
endmodule
  module top;
  endmodule
