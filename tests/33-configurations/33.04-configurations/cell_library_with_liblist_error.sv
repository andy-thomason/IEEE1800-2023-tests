/*
:section: 33.4.1.4 The cell clause
:summary: A cell clause that names a library must not be paired with a liblist expansion.
:type: elaboration
:should_fail_because: a library-qualified cell clause has a liblist expansion
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
  cell work.orig liblist work;
endconfig
