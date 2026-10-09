/*
:section: 26.6 Exporting imported names from packages
:summary: The export *::* form re-exports everything a package imports from any package.
*/
package pa; int a = 10; endpackage
package pb; int b = 20; endpackage
package both;
  export *::*;
  import pa::a;
  import pb::b;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import both::*;
  initial begin
    #1;
    check(a + b == 30, "export *::* re-exports every imported declaration");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
