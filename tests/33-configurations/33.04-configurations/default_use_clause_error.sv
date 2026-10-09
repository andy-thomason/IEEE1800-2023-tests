/*
:section: 33.4.1.2 The default clause
:summary: A default clause in a config cannot take a use expansion.
:type: elaboration
:should_fail_because: a default clause has a use expansion
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
  design work.tb;
  default use work.alt;
endconfig
