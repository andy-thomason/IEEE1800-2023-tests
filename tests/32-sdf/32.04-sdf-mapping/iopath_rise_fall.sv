/*
:section: 32.4.1 Mapping of SDF delay constructs to SystemVerilog declarations
:summary: An SDF IOPATH with two values annotates rise and fall delays onto the matching specify
  path.
:data: rise_fall.sdf
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
      $sdf_annotate("rise_fall.sdf");
      #20 a = 1;
      #3 check(y === 1'b0, "annotated rise 4: not changed at 3");
    #2 check(y === 1'b1, "annotated rise 4: changed by 5");
      #20 a = 0;
      #6 check(y === 1'b1, "annotated fall 7: not changed at 6");
    #2 check(y === 1'b0, "annotated fall 7: changed by 8");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
