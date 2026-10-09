/*
:section: 9.3.2 Parallel blocks
:summary: Variables declared in a fork block are initialized on entry, before any child
  processes start.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int seen [3];
  initial begin
    for (int i = 0; i < 3; i++)
      fork
        automatic int k = i;
        #1 seen[k] = k * 10;
      join_none
    #2;
    check(seen[0] == 0 && seen[1] == 10 && seen[2] == 20, $sformatf("per-iteration copies: %p", seen));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
