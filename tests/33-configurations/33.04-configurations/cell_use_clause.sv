/*
:section: 33.4.1.4 The cell clause
:summary: A cell clause with use rebinds every instance of that cell, including deeply nested
  ones.
:description: The config is named top so the runner's top-level selection (-s top / --top-module
  top) elaborates through it; the testbench module is tb.
*/
module orig(output int id);
  assign id = 1;
endmodule
module alt(output int id);
  assign id = 2;
endmodule

  module mid(output int id);
    orig deep(.id(id));
  endmodule

module tb;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int i1, i2;
  orig u1(.id(i1));
  mid m(.id(i2));
  initial begin
    #1;
    check(i1 == 2 && i2 == 2, $sformatf("every orig instance rebound to alt: %0d %0d", i1, i2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

config top;
  design work.tb;
  cell orig use alt;
endconfig
