/*
:section: 6.9 Vector declarations
:summary: logic, reg and bit objects without a range are one bit wide; with a range they are
  vectors.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef bit flag_t;
  logic a; reg b; bit c; flag_t d;
  logic [4:0] e;
  initial begin
    check($bits(a) + $bits(b) + $bits(c) + $bits(d) == 4, "scalars are 1 bit");
    check($bits(e) == 5, "vector width");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
