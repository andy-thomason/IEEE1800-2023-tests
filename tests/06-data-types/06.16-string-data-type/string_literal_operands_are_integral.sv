/*
:section: 6.16 String data type
:summary: Operators applied only to string literals treat them as integral values, not string
  objects.
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
    check("ab" == 16'h6162, "two literals did not compare as integers");
    check({"a", "b"} === 16'h6162, "concatenation of literals is not integral");
    check($bits({"a", "bc"}) == 24, "concatenation of literals has the wrong width");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
