/*
:section: 26.3 Referencing data in packages
:summary: Importing one identifier repeatedly from the same package is permitted.
*/
package nums; int k = 5; endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import nums::k;
  import nums::k;
  import nums::*;
  initial begin
    #1;
    check(k == 5, "repeated import of one declaration");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
