/*
:section: 24.3.2 Operation of program port connections in the absence of clocking blocks
:summary: Program ports without clocking blocks connect like module ports, with program updates
  in the Reactive region.
:timeout: 30
:description: A value computed in the program's Reactive region still propagates back to the design,
  which reruns its loop.
*/
module top;
  logic r = 0;
  wire s;
  logic seen;
  always @(s) seen = s;
  p u(.r(r), .s(s));
  initial begin
    #1 r = 1;
    #1;
    if (s === 1'b0 && seen === 1'b0) $display("PASS");
    else $display("FAIL: program output s=%b seen=%b", s, seen);
  end
endmodule
program p(input logic r, output wire s);
  assign s = ~r;
endprogram
