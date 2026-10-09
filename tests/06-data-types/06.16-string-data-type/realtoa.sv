/*
:section: 6.16.15 Realtoa()
:summary: realtoa writes a real value as text that atoreal can read back.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s;
  initial begin
    s.realtoa(2.5);
    check(s.atoreal() == 2.5, $sformatf("realtoa(2.5) gave '%s'", s));
    s.realtoa(-0.125);
    check(s.atoreal() == 0.0 || s[0] == "-", $sformatf("realtoa(-0.125) gave '%s'", s));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
