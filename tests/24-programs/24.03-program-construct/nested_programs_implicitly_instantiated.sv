/*
:section: 24.3 The program construct
:summary: Port-less programs nested in a module are instantiated implicitly and can share module
  variables.
:timeout: 30
*/
module top;
  int shared;
  program producer;
    initial shared = 5;
  endprogram
  program consumer;
    int seen;
    initial #1 seen = shared;
  endprogram
  initial begin
    #2;
    if (consumer.seen == 5) $display("PASS");
    else $display("FAIL: nested programs did not share the module variable (%0d)", consumer.seen);
  end
endmodule
