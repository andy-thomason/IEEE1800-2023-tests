/*
:section: 11.4.3 Arithmetic operators
:summary: Dividing a four-state value by zero yields all x bits, and storing it into a 2-state
  variable gives zero.
:description: The operands are 2-state, but the result is still x (11.3.4 names division
  by zero as an operator that produces x from 2-state operands). Stored in a 2-state
  variable, the x then becomes 0 (6.11.1).
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int n, zero, two_state;
  integer four_state;
  logic [31:0] vec;
  initial begin
    n = 99;
    zero = 0;
    four_state = n / zero; check(four_state === 32'hxxxx_xxxx, $sformatf("int 99 / 0 into integer = %b", four_state));
    vec = n % zero;        check(vec === 32'hxxxx_xxxx, $sformatf("int 99 %% 0 into logic = %b", vec));
    two_state = n / zero;  check(two_state === 0, $sformatf("int 99 / 0 into int = %0d, expected x converted to 0", two_state));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
