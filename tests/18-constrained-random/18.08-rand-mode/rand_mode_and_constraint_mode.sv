/*
:section: 18.8 Disabling random variables with rand_mode()
:summary: rand_mode(0) makes a rand variable behave as state, and constraint_mode() switches
  named constraints on or off.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class ctl_c;
    rand bit [7:0] a, b;
    constraint small_a { a < 10; }
  endclass
  ctl_c c = new;
  int big_a = 0;
  initial begin
    c.b = 77;
    c.b.rand_mode(0);
    check(c.b.rand_mode() == 0, "rand_mode query");
    repeat (20) void'(c.randomize());
    check(c.b == 77, "an inactive random variable changed");
    c.small_a.constraint_mode(0);
    check(c.small_a.constraint_mode() == 0, "constraint_mode query");
    repeat (100) begin void'(c.randomize()); if (c.a >= 10) big_a++; end
    check(big_a > 0, "a disabled constraint still applied");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
