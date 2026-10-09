/*
:section: 23.4 Nested modules
:summary: Nested modules see the outer module's names, and portless uninstantiated ones are
  instantiated automatically under their own name.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int shared = 4;
  module auto_inst;
    int copy;
    initial copy = shared * 2;
  endmodule
  module adder(input int a, output int y);
    assign y = a + shared;
  endmodule
  int y;
  adder u(.a(1), .y(y));
  initial begin
    #1;
    check(auto_inst.copy == 8, "a portless nested module was not implicitly instantiated");
    check(y == 5, "nested module sees the outer name space");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
