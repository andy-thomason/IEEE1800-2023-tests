/*
:section: 33.4.1.1 Design statement
:summary: A config names its top cell with design and can pick libraries through a default
  liblist.
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
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int i;
  orig u(.id(i));
  initial begin
    #1;
    check(i == 1, "the configured design elaborated with its own binding");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

config top;
  design work.tb;
  default liblist work;
endconfig
