/*
:section: 13.4.3 Constant functions
:summary: Functions meeting the constant function restrictions may be evaluated during
  elaboration, ignoring system task calls.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int DEPTH = 300;
  function automatic int bits_for(int n, int extra = 0);
    int b = 0;
    $display("ignored during elaboration");
    while ((1 << b) < n) b++;
    return b + extra;
  endfunction
  localparam int ADDR = bits_for(DEPTH);
  logic [bits_for(DEPTH, 2) - 1:0] wide;
  initial begin
    check(ADDR == 9, $sformatf("constant function gave %0d", ADDR));
    check($bits(wide) == 11, "constant function with a default argument in a range");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
