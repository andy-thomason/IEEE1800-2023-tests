/*
:section: 6.12.1 Conversion
:summary: Converting a vector to real treats any x or z bits as zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [5:0] v = 6'b11x0z1;
  real r;
  initial begin
    r = v;
    check(r == 49.0, $sformatf("6'b11x0z1 converted to %f, expected 49 (x and z as 0)", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
