/*
:section: 24.7 Program control tasks
:summary: Calling $exit in a program initial thread ends every initial thread and child thread
  of that program.
:timeout: 30
*/
module top;
  int p1_late, p1_child, p1_other;
  p1 a();
  p2 b();
endmodule
program p1;
  initial begin
    fork
      forever #1 top.p1_child++;
    join_none
    #3 $exit();
    top.p1_late = 1;
  end
  initial #10 top.p1_other = 1;
endprogram
program p2;
  initial begin
    int snap;
    #4 snap = top.p1_child;
    #10;
    if (top.p1_late) $display("FAIL: statements after $exit ran");
    else if (top.p1_other) $display("FAIL: the program's other initial procedure survived $exit");
    else if (top.p1_child != snap) $display("FAIL: a descendant thread survived $exit");
    else $display("PASS");
  end
endprogram
