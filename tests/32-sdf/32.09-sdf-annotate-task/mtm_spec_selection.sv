/*
:section: 32.9 Loading timing data from an SDF file
:summary: $sdf_annotate accepts a target instance scope and an mtm_spec choosing which delay
  triplet to apply.
:description: The SDF names instance u relative to the scope argument, so each call annotates one
  copy.
:data: mtm.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 1;
  endspecify
endmodule

  module wrap(input a, output y);
    dut u(.a(a), .y(y));
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
  wire y_max, y_min;
  wrap w_max(.a(a), .y(y_max));
  wrap w_min(.a(a), .y(y_min));
  initial begin
    $sdf_annotate("mtm.sdf", w_max, , , "MAXIMUM");
    $sdf_annotate("mtm.sdf", w_min, , , "MINIMUM");
    #20 a = 1;
    #1 check(y_min === 1'b0, "minimum not before 2");
    #2 check(y_min === 1'b1 && y_max === 1'b0, "minimum 2 used in w_min");
    #5 check(y_max === 1'b0, "maximum not before 9");
    #2 check(y_max === 1'b1, "maximum 9 used in w_max");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
