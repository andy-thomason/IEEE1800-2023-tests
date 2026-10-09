/*
:section: 9.4.2.1 Event OR operator
:summary: Commas and the or keyword are interchangeable separators in an event control list.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0, b = 0;
  int by_or = 0, by_comma = 0;
  always @(a or b) by_or++;
  always @(a, b) by_comma++;
  initial begin
    #1 a = 1;
    #1 b = 1;
    #1 a = 0;
    #1;
    check(by_or == 3 && by_comma == 3, $sformatf("or %0d, comma %0d", by_or, by_comma));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
