/*
:section: 9.2.3 Final procedures
:summary: A final procedure runs once when simulation finishes, without consuming time.
:expect: final at 5 count=3
*/
module top;
  int count = 0;
  initial begin
    #5 count = 3;
    $finish;
  end
  final begin
    $display("final at %0t count=%0d", $time, count);
  end
endmodule
