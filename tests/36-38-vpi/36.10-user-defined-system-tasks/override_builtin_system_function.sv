/*
:section: 36.9.1 Name space
:summary: A user PLI application registered under a built-in name like $random replaces the
  built-in behavior.
:vpi: override_builtin_system_function.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int r;
  initial begin
    r = $random;
    check(r == 4, $sformatf("user $random returned %0d", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
