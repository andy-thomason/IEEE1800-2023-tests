/*
:section: 9.7 Fine-grain process control
:summary: suspend() pauses a process, resume() restarts it, and resuming a non-suspended process
  does nothing.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  process p;
  int ticks = 0;
  initial begin
    fork
      begin p = process::self(); forever #2 ticks++; end
    join_none
    #5;
    p.suspend();
    check(p.status() == process::SUSPENDED, "suspend");
    #10;
    check(ticks == 2, $sformatf("a suspended process ran: ticks = %0d", ticks));
    p.resume();
    #10;
    check(ticks > 2 && p.status() != process::SUSPENDED, "resume");
    p.kill();
    p.resume();
    check(p.status() == process::KILLED, "resume of a killed process had an effect");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
