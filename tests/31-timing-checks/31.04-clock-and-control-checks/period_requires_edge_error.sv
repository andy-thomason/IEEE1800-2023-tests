/*
:section: 31.4.5 $period
:summary: $period requires an edge-qualified reference event; a plain signal is a compile error.
:type: elaboration
:should_fail_because: $period is given a reference event without an edge
:flags-icarus: -gspecify
*/
module chk(input clk);
  specify
    $period(clk, 10);
  endspecify
endmodule
module top;
  logic clk;
  chk u(.clk(clk));
endmodule
