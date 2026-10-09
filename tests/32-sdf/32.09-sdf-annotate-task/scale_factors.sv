/*
:section: 32.9 Loading timing data from an SDF file
:summary: The scale_factors argument of $sdf_annotate multiplies min, typ and max annotated
  values respectively.
:data: scale.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 1;
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
  initial begin
      $sdf_annotate("scale.sdf", , , , "TYPICAL", "1.0:2.0:1.0");
      #20 a = 1;
      #5 check(y === 1'b0, "typical 3 scaled by 2.0: not changed at 5");
    #2 check(y === 1'b1, "typical 3 scaled by 2.0: changed by 7");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
