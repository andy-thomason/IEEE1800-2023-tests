/*
:section: 32.4.1 Mapping of SDF delay constructs to SystemVerilog declarations
:summary: An SDF IOPATH without a condition annotates every specify path between the same two
  ports.
:data: all.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module dut(input a, input m, output y);
  buf b(y, a);
  specify
    if (m) (a => y) = 2;
    if (!m) (a => y) = 2;
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
  logic a = 0, m = 1;
  wire y;
  dut u(.a(a), .m(m), .y(y));
  initial begin
      $sdf_annotate("all.sdf");
      #20 a = 1;
      #4 check(y === 1'b0, "m=1 path annotated: not changed at 4");
    #2 check(y === 1'b1, "m=1 path annotated: changed by 6");
      m = 0;
      #20 a = 0;
      #4 check(y === 1'b1, "m=0 path annotated: not changed at 4");
    #2 check(y === 1'b0, "m=0 path annotated: changed by 6");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
