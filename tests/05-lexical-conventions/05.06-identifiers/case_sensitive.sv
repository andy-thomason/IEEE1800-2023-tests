/*
:section: 5.6 Identifiers, keywords, and system names
:summary: Identifiers that differ only in letter case are distinct names.
*/
module top;
  int counter = 3;
  int Counter = 5;
  int COUNTER = 7;
  initial begin
    if (counter != 3 || Counter != 5 || COUNTER != 7)
      $display("FAIL: identifiers differing only in case were merged");
    else $display("PASS");
    $finish;
  end
endmodule
