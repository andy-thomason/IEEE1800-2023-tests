/*
:section: 7.10.5 Bounded queues
:summary: Writes that grow a bounded queue past its limit discard the excess elements.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int iq_t [$];
  function automatic bit eq(iq_t got, iq_t want);
    return got == want;
  endfunction
  int bq [$:2];
  initial begin
    bq.push_back(1); bq.push_back(2); bq.push_back(3);
    bq.push_back(4);
    check(eq(bq, '{1, 2, 3}), $sformatf("push_back past the bound: %p", bq));
    bq.push_front(0);
    check(eq(bq, '{0, 1, 2}), $sformatf("push_front dropped the wrong element: %p", bq));
    bq.insert(1, 9);
    check(eq(bq, '{0, 9, 1}), $sformatf("insert: %p", bq));
    bq = {5, 6, 7, 8, 9};
    check(eq(bq, '{5, 6, 7}), $sformatf("assignment of 5 elements: %p", bq));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
