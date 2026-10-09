/*
:section: 5.9 String literals
:summary: String literals assigned to or combined with string variables become values of type
  string.
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
    s = "base";
    check(s.len() == 4, "assigned string has the wrong length");
    s = {s, "line"};
    check(s == "baseline", $sformatf("concatenation gave \"%s\"", s));
    check(s > "basal", "comparison with a literal as a string failed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
