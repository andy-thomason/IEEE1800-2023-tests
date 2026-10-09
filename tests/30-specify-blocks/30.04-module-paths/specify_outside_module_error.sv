/*
:section: 30.3 Specify block declaration
:summary: A specify block may only be placed in a module, so one inside an interface is illegal.
:type: parse
:should_fail_because: a specify block appears in an interface
:flags-icarus: -gspecify
*/
interface not_a_module(input a, output y);
  specify
    (a => y) = 2;
  endspecify
endinterface
module top;
endmodule
