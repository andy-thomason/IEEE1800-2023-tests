/*
:section: 30.5 Assigning delays to module paths
:summary: Path delays may use specparams with min:typ:max values giving separate rise and fall
  delays.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    specparam t_rise = 1:3:5, t_fall = 2:7:9;
    (a => y) = (t_rise, t_fall);
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
    #2 check(y === 1'b0, "not risen at 2");
    #2 check(y === 1'b1, "typical rise 3");
    #16 a = 0;
    #6 check(y === 1'b1, "not fallen at 6");
    #2 check(y === 1'b0, "typical fall 7");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
