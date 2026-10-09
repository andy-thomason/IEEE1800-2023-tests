/*
:section: H.7.5 Normalized and linearized ranges
:summary: A multi-dimensional packed DPI argument is flattened into one dimension keeping the
  same bit layout.
:dpi: linearized_packed_dimensions.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int bit_at(input bit [1:0][2:0][3:0] m, input int index);
  bit [1:0][2:0][3:0] m;
  initial begin
    m = '0;
    m[1][2][3] = 1;
    m[0][1][2] = 1;
    check(bit_at(m, 3 + 2*4 + 1*3*4) == 1, "m[1][2][3] at linear index 23");
    check(bit_at(m, 2 + 1*4) == 1, "m[0][1][2] at linear index 6");
    check(bit_at(m, 0) == 0, "other bits clear");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
