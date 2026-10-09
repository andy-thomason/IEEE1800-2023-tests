/*
:section: 5.7.1 Integer literal constants
:summary: An unsized decimal needing over 32 bits gets enough width for its value plus a sign
  bit.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    // 2**33 + 1 needs 34 value bits plus a sign bit.
    check($bits(8589934593) >= 35, $sformatf("$bits(8589934593) = %0d", $bits(8589934593)));
    check(8589934593 > 0, "8589934593 is not positive");
    check(64'(8589934593) == 64'h2_0000_0001, "8589934593 lost bits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
