/*
:section: 5.6.2 Keywords
:summary: Keywords are lowercase only, so capitalised forms like Begin or MODULE are ordinary
  identifiers.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int Begin = 1;
  int MODULE = 2;
  int While = 3;
  int END = 4;
  initial begin
    check(Begin + MODULE + While + END == 10, "capitalised keywords used as identifiers");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
