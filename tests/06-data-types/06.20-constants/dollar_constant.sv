/*
:section: 6.20.7 $ as a constant
:summary: $ declares queues, selects the last queue element, and marks open ends of value
  ranges.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int q [$] = '{4, 8, 15};
  int v = -100;
  initial begin
    check(q[$] == 15, "q[$] is not the last element");
    check(v inside {[$:0]}, "[$:0] does not include -100");
    v = 1000;
    check(v inside {[50:$]}, "[50:$] does not include 1000");
    check(!(v inside {[$:999]}), "[$:999] includes 1000");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
