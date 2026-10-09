/*
:section: 15.3.3 Get()
:summary: Processes blocked on semaphore get are served in the order they started waiting.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  semaphore s = new(0);
  int order [$];
  initial begin
    fork
      begin #1 s.get(); order.push_back(1); end
      begin #2 s.get(); order.push_back(2); end
      begin #3 s.get(); order.push_back(3); end
      begin #5 s.put(3); end
    join
    check(order.size() == 3 && order[0] == 1 && order[1] == 2 && order[2] == 3, $sformatf("waiters served out of order: %p", order));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
