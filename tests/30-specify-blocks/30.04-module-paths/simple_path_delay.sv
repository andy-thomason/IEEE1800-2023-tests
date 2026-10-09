/*
:section: 30.4.2 Simple module paths
:summary: A single delay on a simple => path inside specify applies to every output transition.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 5;
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
    #4 check(y === 1'b0, "not changed at 4");
    #2 check(y === 1'b1, "path delay 5 on rise");
    a = 0;
    #4 check(y === 1'b1, "not changed at 4");
    #2 check(y === 1'b0, "path delay 5 on fall");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
