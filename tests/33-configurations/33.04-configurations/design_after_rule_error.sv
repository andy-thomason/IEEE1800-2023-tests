/*
:section: 33.4.1.1 Design statement
:summary: Inside a config the design statement must come before any rule statements.
:type: elaboration
:should_fail_because: a rule precedes the design statement
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
  instance tb.u use work.alt;
  design work.tb;
endconfig
