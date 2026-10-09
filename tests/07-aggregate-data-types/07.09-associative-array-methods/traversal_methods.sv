/*
:section: 7.9.4 First()
:summary: first, last, next and prev step through indices in order, returning 0 when none
  remain.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int sparse [int];
  int k;
  initial begin
    check(sparse.first(k) == 0 && sparse.last(k) == 0, "first/last of an empty array did not return 0");
    sparse[40] = 1; sparse[-5] = 2; sparse[12] = 3;
    check(sparse.first(k) == 1 && k == -5, "first");
    check(sparse.last(k) == 1 && k == 40, "last");
    k = 12;
    check(sparse.next(k) == 1 && k == 40, "next");
    check(sparse.next(k) == 0 && k == 40, "next at the end changed the index");
    k = 13;
    check(sparse.prev(k) == 1 && k == 12, "prev from a missing index");
    k = -5;
    check(sparse.prev(k) == 0 && k == -5, "prev at the start changed the index");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
