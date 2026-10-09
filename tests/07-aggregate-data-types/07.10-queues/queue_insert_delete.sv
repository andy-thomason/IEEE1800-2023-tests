/*
:section: 7.10.2.2 Insert()
:summary: insert() and delete() modify queues at valid positions and ignore invalid indices.
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
  int q [$] = {1, 3};
  integer xi = 'x;
  initial begin
    q.insert(1, 2);
    check(eq(q, '{1, 2, 3}), "insert in the middle");
    q.insert(3, 4);
    check(eq(q, '{1, 2, 3, 4}), "insert at size (the end)");
    q.insert(9, 0); q.insert(-1, 0); q.insert(xi, 0);
    check(q.size() == 4, "invalid insert changed the queue");
    q.delete(0);
    check(eq(q, '{2, 3, 4}), "delete(0)");
    q.delete(3); q.delete(-1); q.delete(xi);
    check(q.size() == 3, "invalid delete changed the queue");
    q.delete();
    check(q.size() == 0, "delete()");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
