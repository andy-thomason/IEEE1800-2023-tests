/*
:section: 6.20.2 Value parameters
:summary: Parameter values may be built from package items, enum names and constant function
  calls.
*/
package widths;
  parameter int BASE = 6;
  typedef enum {SMALL = 2, LARGE = 5} size_t;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int doubled(int v);
    return 2 * v;
  endfunction
  localparam int FROM_PKG = widths::BASE + 1;
  localparam int FROM_FN = doubled(FROM_PKG);
  localparam int FROM_ENUM = widths::LARGE * 10;
  initial begin
    check(FROM_PKG == 7 && FROM_FN == 14 && FROM_ENUM == 50, "parameters from a package, a constant function and an enum");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
