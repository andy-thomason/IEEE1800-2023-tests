/*
:section: 18.5.2 Constraint inheritance
:summary: A derived class constraint with a base constraint's name replaces it, while other base
  constraints still apply.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class base_c;
    rand int x;
    constraint c_range { x inside {[0:9]}; }
    constraint c_even { x % 2 == 0; }
  endclass
  class derived_c extends base_c;
    constraint c_range { x inside {[100:109]}; }
  endclass
  base_c h;
  derived_c d = new;
  int bad = 0;
  initial begin
    h = d;
    repeat (100) if (!h.randomize() || !(h.x inside {[100:109]}) || h.x % 2 != 0) bad++;
    check(bad == 0, "the derived constraint did not replace the base constraint of the same name");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
