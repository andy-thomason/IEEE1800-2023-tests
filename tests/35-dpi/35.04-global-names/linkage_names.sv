/*
:section: 35.4 Global name space of imported and exported functions
:summary: A DPI import uses its SystemVerilog name as the C symbol unless another linkage name
  is supplied.
:dpi: linkage_names.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int plain_square(input int x);
  import "DPI-C" c_triple = function int triple(input int x);
  import "DPI-C" \begin = function int start_value();
  initial begin
    check(plain_square(7) == 49, "default linkage name is the SystemVerilog name");
    check(triple(5) == 15, "explicit c_identifier");
    check(start_value() == 99, "escaped keyword as a linkage name");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
