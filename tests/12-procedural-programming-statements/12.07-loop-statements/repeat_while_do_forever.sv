/*
:section: 12.7.2 The repeat loop
:summary: repeat runs a fixed count with x treated as zero, while while, do-while and forever
  loop as expected.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int n, runs;
  integer xcount = 'x;
  initial begin
    runs = 0; repeat (4) runs++;
    check(runs == 4, "repeat");
    runs = 0; repeat (xcount) runs++;
    check(runs == 0, "repeat with an x count runs zero times");
    runs = 0; repeat (-2) runs++;
    check(runs == 0, "repeat with a negative count");
    n = 0; runs = 0; while (n > 0) runs++;
    check(runs == 0, "while with a false condition");
    n = 0; runs = 0; do runs++; while (n > 0);
    check(runs == 1, "do-while runs once");
    runs = 0; forever begin runs++; if (runs == 3) break; end
    check(runs == 3, "forever with break");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
