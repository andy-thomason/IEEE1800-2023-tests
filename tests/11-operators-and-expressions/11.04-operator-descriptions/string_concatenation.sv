/*
:section: 11.4.12.2 String concatenation and replication
:summary: A concatenation or replication with any string operand produces a string result.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "ab";
  string r;
  initial begin
    r = {s, "cd", s};
    check(r == "abcdab", "string concatenation");
    r = {3{s}};
    check(r == "ababab", "string replication");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
