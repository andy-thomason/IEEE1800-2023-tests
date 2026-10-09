/*
:section: 33.4.3 Setting parameters in configurations
:summary: A localparam inside a config must be given a literal value, not a computed expression.
:type: elaboration
:should_fail_because: a config localparam is set to an expression
:description: The config is named top so the runner's top-level selection (-s top / --top-module
  top) elaborates through it; the testbench module is tb.
*/
module orig(output int id);
  assign id = 1;
endmodule
module alt(output int id);
  assign id = 2;
endmodule
  module tb;
    int i;
    orig u(.id(i));
  endmodule
  config top;
  localparam int A = 3;
  localparam int B = A + 1;
  design work.tb;
endconfig
