/*
:section: 18.12 Randomization of scope variables—std::randomize()
:summary: std::randomize() randomizes scope variables without a class and accepts an inline with
  constraint block.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a, b;
  bit [3:0] n;
  int bad = 0;
  initial begin
    repeat (50) begin
      if (!std::randomize(a, b) with { a > 0; a < 10; b == a * 2; }) bad++;
      else if (!(a > 0 && a < 10 && b == 2 * a)) bad++;
    end
    check(bad == 0, "std::randomize with constraints");
    check(std::randomize(n) == 1, "std::randomize without constraints");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
