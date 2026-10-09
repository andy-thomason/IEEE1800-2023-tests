/*
:section: 5.7.1 Integer literal constants
:summary: Unbased unsized literals such as '1, '0, 'x and 'z fill every bit of the target.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [40:0] v;
  initial begin
    v = '1;  check(v === {41{1'b1}}, "'1 did not fill 41 bits with 1");
    v = '0;  check(v === {41{1'b0}}, "'0 did not fill 41 bits with 0");
    v = 'x;  check(v === {41{1'bx}}, "'x did not fill 41 bits with x");
    v = 'Z;  check(v === {41{1'bz}}, "'Z did not fill 41 bits with z");
    check($bits('1) == 1, $sformatf("$bits('1) = %0d", $bits('1)));
    check({'1, 2'b00} === 3'b100, "'1 in a concatenation is not 1 bit");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
