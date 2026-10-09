/*
:section: 28.3.2 The drive strength specification
:summary: A highz1 strength makes a gate output z instead of 1, and highz0 does likewise for 0.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a;
  wire o1, o0;
  buf (highz1, strong0) b1(o1, a);
  not (strong1, highz0) b0(o0, a);
  initial begin
    a = 1; #1;
    check(o1 === 1'bz && o0 === 1'bz, $sformatf("1 with highz1 gave %b, 0 with highz0 gave %b", o1, o0));
    a = 0; #1;
    check(o1 === 1'b0 && o0 === 1'b1, "other value unaffected");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
