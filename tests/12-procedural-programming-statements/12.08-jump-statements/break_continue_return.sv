/*
:section: 12.8 Jump statements
:summary: break exits a loop, continue begins the next iteration, and return leaves a task or
  function.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int total;
  task automatic early(output int r);
    r = 1;
    if (r) return;
    r = 2;
  endtask
  function automatic int first_neg(int v []);
    foreach (v[i]) if (v[i] < 0) return i;
    return -1;
  endfunction
  initial begin
    total = 0;
    for (int i = 0; i < 10; i++) begin
      if (i % 2) continue;
      if (i > 6) break;
      total += i;
    end
    check(total == 12, $sformatf("break/continue total %0d", total));
    early(total);
    check(total == 1, "return from a task");
    check(first_neg('{3, 4, -1, 2}) == 2, "return from inside a loop in a function");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
