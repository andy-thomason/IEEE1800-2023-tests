/*
:section: 18.5.11 Functions in constraints
:summary: Functions called in constraints are evaluated before solving, and their results act as
  fixed state values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class fn_c;
    rand bit [7:0] a, b;
    function int ones(bit [7:0] v); return $countones(v); endfunction
    constraint c { ones(a) == 3; b == a + 1; }
  endclass
  fn_c f = new;
  int bad = 0;
  initial begin
    repeat (100) if (!f.randomize() || $countones(f.a) != 3 || f.b != f.a + 1) bad++;
    check(bad == 0, "function in constraint");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
