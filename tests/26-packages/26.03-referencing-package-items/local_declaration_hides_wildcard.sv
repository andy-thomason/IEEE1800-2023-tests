/*
:section: 26.3 Referencing data in packages
:summary: A local declaration takes precedence over a same-named identifier from a wildcard
  import.
*/
package nums; int k = 5; int j = 6; endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import nums::*;
  int k = 50;
  initial begin
    #1;
    check(k == 50, "the local declaration wins over the wildcard candidate");
    check(j == 6, "other names still come from the package");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
