/*
:section: 32.4.3 SDF annotation of specparams
:summary: An SDF LABEL sets a specparam, and path delays using that specparam are recomputed.
:data: label.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module dut(input a, output y);
  buf b(y, a);
  specify
    specparam tpd = 1;
    (a => y) = tpd;
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
      $sdf_annotate("label.sdf");
      #20 a = 1;
      #5 check(y === 1'b0, "the path delay expression tpd reevaluated with tpd = 6: not changed at 5");
    #2 check(y === 1'b1, "the path delay expression tpd reevaluated with tpd = 6: changed by 7");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
