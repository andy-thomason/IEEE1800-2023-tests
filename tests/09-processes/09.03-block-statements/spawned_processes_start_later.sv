/*
:section: 9.3.2 Parallel blocks
:summary: Processes created by fork do not begin running until the parent blocks or finishes.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int order [$];
  initial begin
    fork
      order.push_back(1);
      order.push_back(2);
    join_none
    order.push_back(0);
    #0;
    check(order.size() == 3 && order[0] == 0, $sformatf("the parent did not run first: %p", order));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
