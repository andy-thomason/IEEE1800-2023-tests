/*
:section: 24.3 The program construct
:summary: When a program's initial procedures finish, its forked child threads are killed
  immediately.
:timeout: 30
*/
module top;
  int ticks;
  p1 a();
  p2 b();
endmodule

program p1;
  initial begin
    fork
      forever #1 top.ticks++;
    join_none
    #5;
  end
endprogram

program p2;
  initial begin
    int at_end;
    #6 at_end = top.ticks;
    #10;
    if (top.ticks != at_end) $display("FAIL: p1's forked thread kept running after p1's initial ended (%0d -> %0d)", at_end, top.ticks);
    else $display("PASS");
    $finish;
  end
endprogram
