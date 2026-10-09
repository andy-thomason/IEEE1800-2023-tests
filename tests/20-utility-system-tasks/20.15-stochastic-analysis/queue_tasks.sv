/*
:section: 20.15 Stochastic analysis tasks and functions
:summary: The $q_initialize, $q_add, $q_remove, $q_full and $q_exam tasks manage stochastic
  queues and report status codes.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int status, job, info, full;
  initial begin
    $q_initialize(1, 1, 2, status);
    check(status == 0, $sformatf("$q_initialize status %0d", status));
    $q_add(1, 10, 100, status);
    $q_add(1, 20, 200, status);
    full = $q_full(1, status);
    check(full == 1, "queue with two entries and maximum length 2 is not full");
    $q_remove(1, job, info, status);
    check(status == 0 && job == 10 && info == 100, "FIFO removal");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
