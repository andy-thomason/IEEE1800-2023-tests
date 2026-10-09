/*
:section: 18.17.7 Value passing between productions
:summary: A randsequence production declared with a return type can return a value to the
  production that invoked it.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int total;
  initial begin
    randsequence (main)
      main : sum(3, 4) { total = sum; };
      int sum (int a, int b) : { return a + b; };
    endsequence
    check(total == 7, $sformatf("value returned by a production: %0d", total));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
