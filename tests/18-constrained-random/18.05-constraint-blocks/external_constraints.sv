/*
:section: 18.5.1 External constraint blocks
:summary: Constraints declared extern or as prototypes in a class can have their bodies defined
  outside using class::name.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class box_c;
    rand int w;
    extern constraint c_w;
    constraint c_implicit;
  endclass
  constraint box_c::c_w { w inside {[1:9]}; }
  constraint box_c::c_implicit { w % 2 == 1; }
  box_c b = new;
  int bad = 0;
  initial begin
    repeat (100) if (!b.randomize() || !(b.w inside {[1:9]}) || b.w % 2 != 1) bad++;
    check(bad == 0, "external constraint bodies were not applied");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
