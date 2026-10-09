/*
:section: 33.4.1.1 Design statement
:summary: A config must contain a single design statement; two design statements are illegal.
:type: elaboration
:should_fail_because: the config has two design statements
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
  design work.alt;
endconfig
