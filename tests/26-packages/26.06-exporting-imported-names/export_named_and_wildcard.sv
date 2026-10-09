/*
:section: 26.6 Exporting imported names from packages
:summary: Packages can re-export imported items by name or wildcard, giving access to the
  original declarations.
*/
package base;
  int alpha = 1, beta = 2;
endpackage
package mid1;
  import base::alpha;
  export base::alpha;
endpackage
package mid2;
  import base::*;
  int uses_beta = beta;
  export base::*;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import mid1::*;
  import mid2::*;
  initial begin
    #1;
    check(alpha == 1, "alpha through two export paths is one declaration");
    check(beta == 2, "beta exported by the wildcard export after being referenced");
    alpha = 7;
    check(base::alpha == 7, "the exported name is the original declaration");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
