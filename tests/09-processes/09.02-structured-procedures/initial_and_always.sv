/*
:section: 9.2 Structured procedures
:summary: initial procedures run once from time zero, while always procedures repeat until
  simulation ends.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int once = 0, repeated = 0;
  initial once++;
  always #2 repeated++;
  initial begin
    #9;
    check(once == 1, "initial ran more than once");
    check(repeated == 4, $sformatf("always ran %0d times in 9 time units, expected 4", repeated));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
