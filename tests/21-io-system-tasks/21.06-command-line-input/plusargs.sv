/*
:section: 21.6 Command line input
:summary: $test$plusargs matches plusarg prefixes, and $value$plusargs parses the remainder of a
  matching plusarg into a variable.
:plusargs: +VERBOSE +COUNT=12 +NAME=bob
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int n = -1, unused = -1;
  string name;
  initial begin
    check($test$plusargs("VERBOSE") != 0, "+VERBOSE");
    check($test$plusargs("VERB") != 0, "prefix match");
    check($test$plusargs("QUIET") == 0, "absent plusarg");
    check($value$plusargs("COUNT=%d", n) != 0 && n == 12, $sformatf("+COUNT=12 gave %0d", n));
    check($value$plusargs("NAME=%s", name) != 0 && name == "bob", "string plusarg");
    check($value$plusargs("MISSING=%d", unused) == 0 && unused == -1, "missing plusarg leaves the variable");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
