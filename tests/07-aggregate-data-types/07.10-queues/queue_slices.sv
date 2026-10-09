/*
:section: 7.10.1 Queue operators
:summary: Queue slices Q[a:b] give b-a+1 items, or an empty queue if reversed or out of range.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int q [$] = {10, 20, 30, 40, 50};
  int r [$];
  int a, b;
  integer xb = 'x;
  initial begin
    a = 1; b = 3;
    r = q[a:b];   check(r.size() == 3 && r[0] == 20 && r[2] == 40, "q[1:3]");
    r = q[3:1];   check(r.size() == 0, "a > b");
    r = q[2:2];   check(r.size() == 1 && r[0] == 30, "q[n:n]");
    r = q[7:7];   check(r.size() == 0, "q[n:n] out of range");
    r = q[-2:1];  check(r.size() == 2 && r[0] == 10, "negative low bound");
    r = q[3:99];  check(r.size() == 2 && r[1] == 50, "high bound past the end");
    r = q[xb:2];  check(r.size() == 0, "x bound");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
