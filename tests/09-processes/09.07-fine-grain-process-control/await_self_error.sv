/*
:section: 9.7 Fine-grain process control
:summary: A process calling await() on its own handle is an error.
:type: simulation
:should_fail_because: a process awaits its own termination
*/
module top;
  initial begin
    process::self().await();
    $display("returned from await on self");
    $finish;
  end
endmodule
