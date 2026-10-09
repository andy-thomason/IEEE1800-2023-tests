/*
:section: 30.4.1 Module path restrictions
:summary: A module path must end on an output or inout port, not an input.
:type: elaboration
:should_fail_because: the path destination is an input port
:flags-icarus: -gspecify
*/
module dut(input a, input b, output y);
  assign y = a;
  specify
    (a => b) = 2;
  endspecify
endmodule
  module top;
  endmodule
