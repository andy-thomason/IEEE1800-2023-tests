/*
:section: 6.16.10 Atoreal()
:summary: atoreal parses a leading real constant, stopping at the first nonconforming character,
  returning zero without digits.
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
    s = "3.25e2xyz"; check(s.atoreal() == 325.0, $sformatf("atoreal = %f", s.atoreal()));
    s = "0.5";       check(s.atoreal() == 0.5, "atoreal of 0.5");
    s = "abc";       check(s.atoreal() == 0.0, "no digits should give 0");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
