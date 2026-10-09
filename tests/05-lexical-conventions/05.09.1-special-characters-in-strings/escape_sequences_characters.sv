/*
:section: 5.9.1 Special characters in strings
:summary: The escapes for newline, tab, backslash, double quote, vertical tab, form feed and
  bell each yield one character.
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
    s = "\n\t\\\"\v\f\a";
    check(s.len() == 7, $sformatf("seven escapes gave length %0d", s.len()));
    check(s[0] == 10 && s[1] == 9 && s[2] == 92 && s[3] == 34, "\\n \\t \\\\ \\\" values");
    check(s[4] == 11 && s[5] == 12 && s[6] == 7, "\\v \\f \\a values");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
