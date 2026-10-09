/*
:section: 38.15 vpi_get_value()
:summary: vpi_get_value returns an object value in the format chosen by the value structure,
  such as binary or hex.
:vpi: get_value_formats.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] v = 8'b1x0z_0101;
  int ok_bin, ok_hex, ok_vec;
  initial begin
    $t_formats(v, ok_bin, ok_hex, ok_vec);
    check(ok_bin == 1, "vpiBinStrVal");
    check(ok_hex == 1, "vpiHexStrVal with x and z nibbles");
    check(ok_vec == 1, "vpiVectorVal aval/bval encoding");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
