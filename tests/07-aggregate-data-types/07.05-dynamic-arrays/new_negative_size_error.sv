/*
:section: 7.5.1 New[ ]
:summary: Calling new[] with a negative size is an error.
:type: simulation
:should_fail_because: the size given to new[] is negative
:description: The size is only known at run time, so the error is expected to stop the run with a
  failure status.
*/
module top;
  int d [];
  int n = -2;
  initial begin
    d = new [n];
    $display("size after new[-2]: %0d", d.size());
    $finish;
  end
endmodule
