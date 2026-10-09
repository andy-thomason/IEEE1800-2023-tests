/*
:section: 6.24.1 Cast operator
:summary: A const cast leaves both the value and the type of its operand unchanged.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [10:0] x = 11'h4D2;
  initial begin
    check(const'(x) === x && $bits(const'(x)) == 11, "const'() changed the value or type");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
