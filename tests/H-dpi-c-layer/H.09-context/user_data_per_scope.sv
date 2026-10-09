/*
:section: H.9.3 Working with DPI context tasks and functions in C code
:summary: DPI user data is stored separately for each instance scope of a context import.
:dpi: user_data_per_scope.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  counter_m a(), b();
  initial begin
    a.bump(); a.bump(); a.bump();
    b.bump();
    check(a.count() == 3 && b.count() == 1, "user data is kept separately for each instance scope");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

module counter_m;
  import "DPI-C" context function void bump();
  import "DPI-C" context function int count();
endmodule
