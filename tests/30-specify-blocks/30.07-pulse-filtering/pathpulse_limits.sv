/*
:section: 30.7.1 Specify block control of pulse limit values
:summary: A PATHPULSE$ specparam sets reject and error pulse limits for a named module path.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 6;
    specparam PATHPULSE$a$y = (2, 4);
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0;
  wire y;
  dut u(.a(a), .y(y));
  bit saw_change;
  always @(y) if ($time > 15) saw_change = 1;
  initial begin
    #20 a = 1;
    #1 a = 0;
    #20 check(!saw_change, "a 1-unit pulse is below the reject limit 2");
    a = 1;
    #3 a = 0;
    #4 check(y === 1'bx, $sformatf("a 3-unit pulse between the limits is filtered to x, y=%b", y));
    #10 check(y === 1'b0, "back to 0 after the filtered pulse");
    a = 1;
    #5 a = 0;
    #2 check(y === 1'b1, "a 5-unit pulse at or above the error limit 4 passes");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
