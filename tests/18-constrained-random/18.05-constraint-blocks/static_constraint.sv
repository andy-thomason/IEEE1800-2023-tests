/*
:section: 18.5.10 Static constraint blocks
:summary: Disabling a static constraint with constraint_mode() on one object affects that
  constraint in every instance.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class st_c;
    rand bit [3:0] v;
    static constraint low { v < 4; }
  endclass
  st_c a = new, b = new;
  int high_seen = 0;
  initial begin
    a.low.constraint_mode(0);
    repeat (100) begin void'(b.randomize()); if (b.v >= 4) high_seen++; end
    check(high_seen > 0, "turning off a static constraint through one object did not affect another");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
