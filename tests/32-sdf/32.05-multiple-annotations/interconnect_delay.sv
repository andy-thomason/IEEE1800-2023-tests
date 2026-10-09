/*
:section: 32.4.4 SDF annotation of interconnect delays
:summary: An SDF INTERCONNECT entry adds delay between a driving output port and a receiving
  input port.
:data: net.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module drv(input a, output o);
  assign o = a;
endmodule
module rcv(input i, output seen);
  assign seen = i;
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
  wire n, seen;
  drv src(.a(a), .o(n));
  rcv dst(.i(n), .seen(seen));
  wire y = seen;
  initial begin
    $sdf_annotate("net.sdf");
    #20 a = 1;
    #1 check(src.o === 1'b1, "the source is undelayed");
    #3 check(dst.i === 1'b0, "the load is still delayed at 4");
    #2 check(dst.i === 1'b1, "the load changed by 6");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
