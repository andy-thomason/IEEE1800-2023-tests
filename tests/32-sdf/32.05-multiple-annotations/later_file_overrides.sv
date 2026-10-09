/*
:section: 32.6 Multiple SDF files
:summary: Several $sdf_annotate calls may be made, with later files overwriting or adding to
  earlier values.
:data: first.sdf second.sdf
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
      $sdf_annotate("first.sdf");
      $sdf_annotate("second.sdf");
      #20 a = 1;
      #11 check(y === 1'b0, "ABSOLUTE 9 then INCREMENT 3: not changed at 11");
    #2 check(y === 1'b1, "ABSOLUTE 9 then INCREMENT 3: changed by 13");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
