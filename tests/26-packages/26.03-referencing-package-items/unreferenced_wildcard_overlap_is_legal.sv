/*
:section: 26.3 Referencing data in packages
:summary: Two wildcard imports defining the same name are fine as long as that name is never
  referenced.
:description: The overlap is only an error when a reference resolves to the shared name.
*/
package p1; int k = 1; int only1 = 10; endpackage
package p2; int k = 2; int only2 = 20; endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import p1::*;
  import p2::*;
  initial begin
    #1;
    check(only1 + only2 == 30, "both packages used; the shared name is never referenced");
    check(p1::k == 1 && p2::k == 2, "qualified references are unambiguous");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
