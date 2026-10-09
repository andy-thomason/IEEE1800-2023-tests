/*
:section: 6.21 Scope and lifetime
:summary: Static variables, even inside automatic tasks or named blocks, can be accessed
  hierarchically.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  task automatic counted();
    static int uses = 0;
    uses++;
  endtask
  initial begin : named
    static int marker = 7;
  end
  initial begin
    counted();
    counted();
    check(top.counted.uses == 2, "static variable inside an automatic task");
    check(top.named.marker == 7, "static variable in a named block");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
