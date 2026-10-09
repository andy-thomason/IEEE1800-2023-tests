/*
:section: 12.7.1 The for-loop
:summary: A for-loop may declare several control variables and repeat until its condition is
  false.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int total, outer_i, count;
  initial begin
    total = 0;
    for (int i = 0, j = 10; i < j; i += 2, j--) total += i;
    check(total == 12, $sformatf("multiple control variables: total %0d", total));
    for (outer_i = 3; outer_i > 0; outer_i--) ;
    check(outer_i == 0, "a loop variable declared outside keeps its value");
    count = 0;
    for (;;) begin count++; if (count == 5) break; end
    check(count == 5, "all parts omitted");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
