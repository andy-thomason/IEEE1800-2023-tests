/*
:section: 11.8.4 Handling x and z in signed expressions
:summary: Sign-extending a signed value whose sign bit is x or z fills the new upper bits with
  that value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic signed [3:0] sx = 4'bx011, sz = 4'bz011;
  logic signed [7:0] r;
  initial begin
    r = sx;  check(r === 8'bxxxx_x011, $sformatf("x sign bit extended to %b", r));
    r = sz;  check(r === 8'bzzzz_z011, $sformatf("z sign bit extended to %b", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
