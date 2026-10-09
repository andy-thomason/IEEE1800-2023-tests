/*
:section: 6.24.1 Cast operator
:summary: Converting a shortreal to int by cast or assignment rounds to the nearest integer.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  shortreal sr = 2.5;
  int i;
  initial begin
    check(int'(sr) == 3, $sformatf("int'(2.5) = %0d", int'(sr)));
    i = shortreal'(-7.6);
    check(i == -8, $sformatf("assignment of -7.6 = %0d", i));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
