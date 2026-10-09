/*
:section: 23.2.2.2 ANSI style list of port declarations
:summary: A variable output port may be given an initial value in its declaration.
*/
module counter(output int count = 5);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int c;
  counter u(.count(c));
  initial begin
    #1;
    check(c == 5, $sformatf("initialised output variable port = %0d", c));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
