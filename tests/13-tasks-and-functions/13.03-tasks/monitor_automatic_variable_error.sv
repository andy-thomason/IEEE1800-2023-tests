/*
:section: 13.3.2 Task memory usage and concurrent activation
:summary: Variables of automatic tasks may not be passed to $monitor.
:type: elaboration
:should_fail_because: an automatic variable is passed to $monitor
*/
module top;
  task automatic watch();
    int v;
    $monitor("%0d", v);
  endtask
endmodule
