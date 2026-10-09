/*
:section: 20.10 Severity system tasks
:summary: $fatal ends simulation with an error status immediately, so statements after it do not
  run.
:type: simulation
:should_fail_because: $fatal terminates the simulation with an error code
*/
module top;
  initial begin
    $fatal(1, "stopping on purpose (%0d)", 7);
    $display("statement after $fatal ran");
  end
endmodule
