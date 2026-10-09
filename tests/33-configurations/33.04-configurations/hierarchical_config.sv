/*
:section: 33.4.2 Hierarchical configurations
:summary: An instance can be bound to a separate config, which then governs bindings beneath
  that instance.
:description: The config is named top so the runner's top-level selection (-s top / --top-module
  top) elaborates through it; the testbench module is tb.
*/
module orig(output int id);
  assign id = 1;
endmodule
module alt(output int id);
  assign id = 2;
endmodule

  module sub(output int id);
    orig leaf(.id(id));
  endmodule
  config sub_cfg;
    design work.sub;
    instance sub.leaf use work.alt;
  endconfig

module tb;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int i1, i2;
  sub s1(.id(i1));
  sub s2(.id(i2));
  initial begin
    #1;
    check(i1 == 1, "s1 not configured");
    check(i2 == 2, "s2 bound through sub_cfg");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

config top;
  design work.tb;
  instance tb.s2 use work.sub_cfg:config;
endconfig
