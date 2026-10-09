/*
:section: 33.4.2 Hierarchical configurations
:summary: An instance clause must not reach into a hierarchy already controlled by a different
  config.
:type: elaboration
:should_fail_because: tb.u.inner lies inside the hierarchy configured by wrap_cfg
:description: The config is named top so the runner's top-level selection (-s top / --top-module
  top) elaborates through it; the testbench module is tb.
*/
module orig(output int id);
  assign id = 1;
endmodule
module alt(output int id);
  assign id = 2;
endmodule

  module wrap(output int id);
    orig inner(.id(id));
  endmodule
  config wrap_cfg;
    design work.wrap;
  endconfig
  module tb;
    int i;
    orig u(.id(i));
  endmodule
  config top;
  design work.tb;
  instance tb.u use work.wrap_cfg:config;
  instance tb.u.inner use work.alt;
endconfig
