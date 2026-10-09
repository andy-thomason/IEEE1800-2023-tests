/*
:section: 18.5.8 Global constraints
:summary: Constraints spanning a parent object and its rand member objects are solved together
  as one problem.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class leaf_c; rand int v; constraint c { v inside {[0:5]}; } endclass
  class tree_c;
    rand leaf_c left = new, right = new;
    constraint order { left.v < right.v; }
  endclass
  tree_c t = new;
  int bad = 0;
  initial begin
    repeat (100) if (!t.randomize() || !(t.left.v < t.right.v) || t.right.v > 5) bad++;
    check(bad == 0, "global constraint across objects violated");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
