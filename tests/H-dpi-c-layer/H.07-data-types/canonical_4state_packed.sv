/*
:section: H.7.7 Canonical representation of packed arrays
:summary: 4-state packed DPI arguments use aval and bval bit pairs to encode 0, 1, z and x.
:dpi: canonical_4state_packed.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int encoding_ok(input logic [3:0] v);
  import "DPI-C" function void make_xz(output logic [3:0] v);
  logic [3:0] got;
  initial begin
    check(encoding_ok(4'bxz10) == 1, "aval/bval encoding of x z 1 0");
    make_xz(got);
    check(got === 4'b10zx, $sformatf("4-state output gave %b", got));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
