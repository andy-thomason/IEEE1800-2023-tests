/*
:section: 6.16.3 Getc()
:summary: getc returns the character code at an index, or 0 when the index is out of range.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "Zq";
  initial begin
    check(s.getc(0) == 8'h5A && s.getc(1) == "q", "getc returned the wrong code");
    check(s.getc(2) == 0 && s.getc(-3) == 0, "getc out of range is not 0");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
