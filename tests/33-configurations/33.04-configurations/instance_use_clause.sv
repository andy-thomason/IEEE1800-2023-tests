/*
:section: 33.4.1.6 The use clause
:summary: An instance clause with use binds that specific hierarchical instance to the named
  library cell.
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
  int i1, i2;
  orig u1(.id(i1));
  orig u2(.id(i2));
  initial begin
    #1;
    check(i1 == 1, "u1 keeps the default binding");
    check(i2 == 2, $sformatf("u2 rebound to alt: id=%0d", i2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

config top;
  design work.tb;
  instance tb.u2 use work.alt;
endconfig
