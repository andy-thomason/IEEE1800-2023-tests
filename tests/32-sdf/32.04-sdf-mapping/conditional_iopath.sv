/*
:section: 32.4.1 Mapping of SDF delay constructs to SystemVerilog declarations
:summary: A conditional SDF IOPATH annotates only the specify path with the same condition
  between those ports.
:data: cond.sdf
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
      $sdf_annotate("cond.sdf");
      #20 a = 1;
      #5 check(y === 1'b0, "m=1 path annotated to 6: not changed at 5");
    #2 check(y === 1'b1, "m=1 path annotated to 6: changed by 7");
      m = 0;
      #20 a = 0;
      #1 check(y === 1'b1, "m=0 path kept 2: not changed at 1");
    #2 check(y === 1'b0, "m=0 path kept 2: changed by 3");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
