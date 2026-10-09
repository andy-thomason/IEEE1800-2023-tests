/*
:section: 6.11.2 2-state (two-value) and 4-state (four-value) data types
:summary: Widening zero-extends unsigned values and sign-extends signed ones; narrowing drops
  the upper bits.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte sb = -3;
  bit [7:0] ub = 8'hFD;
  int wide;
  shortint narrow;
  initial begin
    wide = sb;  check(wide == -3, $sformatf("signed byte -3 widened to %0d", wide));
    wide = ub;  check(wide == 253, $sformatf("unsigned 8'hFD widened to %0d", wide));
    wide = 32'h1234_ABCD;
    narrow = wide;
    check(narrow == 16'shABCD, $sformatf("truncation kept %h", narrow));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
