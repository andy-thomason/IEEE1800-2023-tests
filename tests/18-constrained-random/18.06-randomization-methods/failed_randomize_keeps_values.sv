/*
:section: 18.6.3 Behavior of randomization methods
:summary: When randomize() fails because constraints conflict, it returns 0 and the rand
  variables keep their old values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class fail_c;
    rand bit [3:0] v;
    bit block = 0;
    constraint c { block -> v > 20; }
  endclass
  fail_c f = new;
  int saved;
  initial begin
    void'(f.randomize());
    saved = f.v;
    f.block = 1;
    check(f.randomize() == 0, "infeasible randomize returned success");
    check(f.v == saved, "a failed randomize changed the variable");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
