/*
:section: 30.4.1 Module path restrictions
:summary: A module path must start from an input or inout port, not an internal net.
:type: elaboration
:should_fail_because: the path source is an internal net
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  wire inner = a;
  assign y = inner;
  specify
    (inner => y) = 2;
  endspecify
endmodule
  module top;
  endmodule
