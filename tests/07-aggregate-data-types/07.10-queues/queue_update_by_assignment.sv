/*
:section: 7.10.4 Updating a queue using assignment and unpacked array concatenation
:summary: Assigning unpacked concatenations to a queue can append, prepend, insert or remove
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
  int q [$] = {3, 6, 9};
  int x = 1, pos = 2;
  initial begin
    q = {q, 12};               check(eq(q, '{3, 6, 9, 12}), "append");
    q = {x, q};                check(eq(q, '{1, 3, 6, 9, 12}), "prepend");
    q = q[1:$];                check(eq(q, '{3, 6, 9, 12}), "drop first");
    q = q[0:$-1];              check(eq(q, '{3, 6, 9}), "drop last");
    q = {q[0:pos-1], 7, q[pos:$]};  check(eq(q, '{3, 6, 7, 9}), "insert");
    q = q[1:$-1];              check(eq(q, '{6, 7}), "drop both ends");
    q = {};                    check(q.size() == 0, "clear");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
