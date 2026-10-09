/*
:section: 31.6 Notifiers: user-defined responses to timing violations
:summary: On a violation the notifier toggles between 0 and 1, x becomes known, and z stays z.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n_one = 1'b1, n_x, n_z = 1'bz;
  specify
    $setup(d, posedge clk, 10, n_one);
    $setup(d, posedge clk, 10, n_x);
    $setup(d, posedge clk, 10, n_z);
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
    #100 d = 1;
    #2 clk = 1;
    #1;
    check(u.n_one === 1'b0, "1 toggles to 0");
    check(u.n_x === 1'b0 || u.n_x === 1'b1, "x becomes 0 or 1");
    check(u.n_z === 1'bz, "z stays z");
    #10 clk = 0;
    #10 d = 0;
    #2 clk = 1;
    #1;
    check(u.n_one === 1'b1, "0 toggles back to 1");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
