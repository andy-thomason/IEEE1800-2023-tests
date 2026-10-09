/*
:section: 32.4.2 Mapping of SDF timing check constructs to SystemVerilog
:summary: An SDF SETUP timing check annotates the limit of a matching $setup check in the
  design.
:data: tc.sdf
:flags-icarus: -gspecify
*/
`timescale 1ns/1ns
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;
  specify
    $setup(d, posedge clk, 1, n);
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
  logic clk = 0, d = 0;
  chk u(.clk(clk), .d(d));
  initial begin
    $sdf_annotate("tc.sdf");
    #100 d = 1;
    #5 clk = 1;
    #1 check(u.violations == 1, $sformatf("annotated setup limit 10 caught a 5-unit setup, violations=%0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
