/*
:section: 11.8.1 Rules for expression types
:summary: Expression signedness comes only from operands, and selects and concatenations are
  unsigned even from signed sources.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic signed [7:0] s = -1;
  logic signed [15:0] r;
  initial begin
    r = s[7:0];      check(r == 16'h00FF, "a full part-select is unsigned");
    r = s[7];        check(r == 16'h0001, "a bit-select is unsigned");
    r = {s};         check(r == 16'h00FF, "a concatenation is unsigned");
    r = s;           check(r == -1, "the signed variable itself is signed");
    r = (s < 0);     check(r == 1, "comparison result is unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
