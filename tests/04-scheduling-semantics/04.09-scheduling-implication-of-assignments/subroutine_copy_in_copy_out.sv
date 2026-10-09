/*
:section: 4.9.7 Subroutines
:summary: Task arguments are copied in at the call and copied out when the task returns.
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
  int source = 10;
  int both = 100;
  task automatic produce(output int o);
    o = 5;
    #3;
    o = 6;
  endtask
  task automatic consume(input int i, output int seen);
    #3;
    seen = i;
  endtask
  task automatic bump(inout int v);
    #3;
    v = v + 1;
  endtask
  int seen;
  initial begin
    fork
      produce(result);
      begin
        #1 check(result == 0, $sformatf("output argument copied out early: result = %0d", result));
      end
    join
    check(result == 6, $sformatf("output argument after return = %0d", result));
    fork
      consume(source, seen);
      #1 source = 99;
    join
    check(seen == 10, $sformatf("input argument was not copied in at the call: seen = %0d", seen));
    fork
      bump(both);
      #1 both = 500;
    join
    check(both == 101, $sformatf("inout argument = %0d, expected 101 (copy-in 100, copy-out at return)", both));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
