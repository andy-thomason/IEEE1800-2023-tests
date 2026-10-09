/*
:section: 18.5.7 Iterative constraints
:summary: foreach constraints relate array elements, and array reduction methods like sum() can
  be constrained.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class vec_c;
    rand bit [3:0] items [];
    constraint c_size { items.size() inside {[3:6]}; }
    constraint c_each { foreach (items[i]) if (i > 0) items[i] > items[i - 1]; }
    constraint c_sum { items.sum() with (int'(item)) == 20; }
  endclass
  vec_c v = new;
  int bad = 0, total;
  initial begin
    repeat (50) begin
      if (!v.randomize()) begin bad++; continue; end
      total = 0;
      foreach (v.items[i]) begin
        total += v.items[i];
        if (i > 0 && v.items[i] <= v.items[i - 1]) bad++;
      end
      if (total != 20 || !(v.items.size() inside {[3:6]})) bad++;
    end
    check(bad == 0, "foreach, size or sum constraint violated");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
