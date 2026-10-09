/*
:section: 13.3.2 Task memory usage and concurrent activation
:summary: Variables of automatic tasks may not be the target of a force statement.
:type: elaboration
:should_fail_because: an automatic variable is referenced by force
*/
module top;
  logic g;
  task automatic hold();
    logic v = 1;
    force g = v;
  endtask
endmodule
