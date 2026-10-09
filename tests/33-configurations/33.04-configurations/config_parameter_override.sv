/*
:section: 33.4.3 Setting parameters in configurations
:summary: A config can override module parameter values for particular instances in the design.
:description: The config is named top so the runner's top-level selection (-s top / --top-module
  top) elaborates through it; the testbench module is tb.
*/
module sized #(parameter int W = 4) (output int w);
  assign w = W;
endmodule

module tb;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int wa, wb, wc;
  sized a(.w(wa));
  sized b(.w(wb));
  sized c(.w(wc));
  defparam b.W = 8;
  initial begin
    #1;
    check(wa == 32, "config localparam override");
    check(wb == 16, "config override beats defparam at the same level");
    check(wc == 4, "unconfigured instance keeps its default");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

config top;
  localparam int WIDE = 32;
  design work.tb;
  instance tb.a use #(.W(WIDE));
  instance tb.b use #(.W(16));
endconfig
