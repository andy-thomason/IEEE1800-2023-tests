/*
:section: 26.6 Exporting imported names from packages
:summary: Exporting a name that was only a wildcard candidate counts as a reference and imports
  it.
*/
package base; int gamma = 3; endpackage
package mid;
  import base::*;
  export base::gamma;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import mid::gamma;
  initial begin
    #1;
    check(gamma == 3, "export of an unreferenced wildcard candidate");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
