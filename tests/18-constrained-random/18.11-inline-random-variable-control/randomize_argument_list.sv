/*
:section: 18.11 Inline random variable control
:summary: Passing variables to randomize() makes only those variables random for that call,
  including non-rand ones.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class sel_c;
    rand bit [7:0] r;
    bit [7:0] s = 8'd9;
    constraint c { r != s; s < 20; }
  endclass
  sel_c o = new;
  initial begin
    o.r = 8'd3;
    void'(o.randomize(s));
    check(o.r == 3 && o.s < 20 && o.s != 3, "only the listed variable was randomized");
    o.s = 8'd5; o.r = 8'd6;
    check(o.randomize(null) == 1, "checker mode on satisfied constraints");
    o.r = 8'd5;
    check(o.randomize(null) == 0, "checker mode on violated constraints");
    check(o.r == 5, "checker mode changed a variable");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
