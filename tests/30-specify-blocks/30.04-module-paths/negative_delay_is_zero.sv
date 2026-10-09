/*
:section: 30.5.1 Specifying transition delays on module paths
:summary: A module path delay that evaluates negative is clamped to zero.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    specparam t_neg = -4;
    (a => y) = t_neg;
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
    #20 a = 1;
    #1 check(y === 1'b1, "negative path delay acts as zero");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
