/*
:section: 11.2.1 Constant expressions
:summary: Constant expressions may use parameters, literals, constant functions and
  side-effect-free built-in calls in declarations.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int W = 6;
  localparam string NAME = "alu";
  function automatic int log2up(int v); return $clog2(v); endfunction
  logic [W * 2 - 1:0] vec;
  logic [log2up(100) - 1:0] idx;
  localparam int LEN = NAME.len();
  logic [LEN - 1:0] by_method;
  initial begin
    check($bits(vec) == 12 && $bits(idx) == 7, "constant arithmetic and constant function in ranges");
    check($bits(by_method) == 3, "constant built-in method call");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
