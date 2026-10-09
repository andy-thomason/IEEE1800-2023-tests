/*
:section: 24.3 The program construct
:summary: Hierarchical references from one program into another program's scope are legal.
:timeout: 30
*/
module top;
  p1 a();
  p2 b();
endmodule
program p1;
  int value = 12;
endprogram
program p2;
  initial begin
    #1;
    if (top.a.value == 12) $display("PASS");
    else $display("FAIL: program-to-program reference read %0d", top.a.value);
  end
endprogram
