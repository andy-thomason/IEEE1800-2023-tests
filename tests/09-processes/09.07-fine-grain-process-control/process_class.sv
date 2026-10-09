/*
:section: 9.7 Fine-grain process control
:summary: The process class provides self(), status(), kill() and await() for inspecting and
  controlling processes.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  process worker, sleeper;
  int progress = 0;
  initial begin
    fork
      begin worker = process::self(); #2 progress++; end
      begin sleeper = process::self(); #20 progress += 100; end
    join_none
    #1;
    check(worker.status() == process::WAITING, "a delayed process is not WAITING");
    check(process::self().status() == process::RUNNING, "the current process is not RUNNING");
    worker.await();
    check(worker.status() == process::FINISHED && progress == 1, "await / FINISHED");
    sleeper.kill();
    check(sleeper.status() == process::KILLED, "kill");
    #30;
    check(progress == 1, "a killed process kept running");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
