/*
:section: 35.5.6.1 Open arrays
:summary: A dynamic array actual can be passed to an imported function whose formal is an open
  array.
:dpi: open_array_dynamic_actual.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int sum_dyn(input int values []);
  int dyn [];
  initial begin
    dyn = '{7, 8, 9};
    check(sum_dyn(dyn) == 24, "dynamic array passed to an open array formal");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
