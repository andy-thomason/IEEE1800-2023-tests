/*
:section: 6.21 Scope and lifetime
:summary: Processes spawned by fork can still use automatic variables after the spawning task
  returns.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int result = 0;
  task automatic spawn(int v);
    int doubled = v * 2;
    fork
      #2 result = doubled;
    join_none
  endtask
  initial begin
    spawn(21);
    #3;
    check(result == 42, $sformatf("process spawned by a finished task saw %0d", result));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
