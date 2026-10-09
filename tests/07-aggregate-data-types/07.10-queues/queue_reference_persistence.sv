/*
:section: 7.10.3 Persistence of references to elements of a queue
:summary: References to queue elements stay valid after methods that do not remove those
  elements.
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
  int q [$];
  task automatic write_later(ref int slot, input int value);
    #2 slot = value;
  endtask
  initial begin
    q = {10, 20, 30};
    fork write_later(q[1], 21); join_none
    #1 q.push_front(5);
    #2 check(eq(q, '{5, 10, 21, 30}), $sformatf("after push_front the reference was lost: %p", q));
    fork write_later(q[0], 99); join_none
    #1 void'(q.pop_front());
    #2 check(eq(q, '{10, 21, 30}), $sformatf("a write through a reference to a popped element changed the queue: %p", q));
    fork write_later(q[0], 77); join_none
    #1 q = {q, 40};
    #2 check(eq(q, '{10, 21, 30, 40}), $sformatf("a write through an outdated reference changed the queue: %p", q));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
