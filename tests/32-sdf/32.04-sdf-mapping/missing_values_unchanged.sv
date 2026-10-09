/*
:section: 32.3 The SDF annotator
:summary: Timing values absent from the SDF file keep their original values after
  back-annotation.
:data: partial.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module dut2(input a, input b, output y, output z);
  buf g1(y, a);
  buf g2(z, b);
  specify
    (a => y) = 3;
    (b => z) = 4;
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
  logic a = 0, b = 0;
  wire y, z;
  dut2 u(.a(a), .b(b), .y(y), .z(z));
  initial begin
    $sdf_annotate("partial.sdf");
    #20 a = 1; b = 1;
    #3 check(z === 1'b0, "b->z not before 4");
    #2 check(z === 1'b1, "b->z kept its own 4");
    #2 check(y === 1'b0, "a->y not before 8");
    #2 check(y === 1'b1, "a->y annotated to 8");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
