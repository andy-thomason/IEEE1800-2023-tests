/*
:section: 24.7 Program control tasks
:summary: Calling $exit from a module thread has no effect and the thread continues.
:timeout: 30
*/
module top;
  int after;
  initial begin
    #1 $exit();
    after = 1;
  end
  t u();
endmodule
program t;
  initial begin
    #5;
    if (top.after == 1) $display("PASS");
    else $display("FAIL: $exit in a module stopped the thread");
  end
endprogram
