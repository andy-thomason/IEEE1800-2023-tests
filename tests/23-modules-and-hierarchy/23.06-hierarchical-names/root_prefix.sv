/*
:section: 23.3.1 Top-level modules and $root
:summary: A path starting with $root refers unambiguously to an instance from the top of the
  hierarchy.
*/
module leaf; int value; endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  leaf l();
  initial begin
    l.value = 22;
    #1;
    check($root.top.l.value == 22, "$root path");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
