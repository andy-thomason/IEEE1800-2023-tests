/*
:section: 9.3.5 Statement labels
:summary: A label before a procedural statement creates a named scope that can be referenced
  hierarchically.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int total = 0;
  initial begin
    step: total = total + 5;
    loop_blk: for (int i = 0; i < 3; i++) total += i;
    check(total == 8, "labelled statements");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
