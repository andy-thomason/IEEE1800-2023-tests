/*
:section: 26.2 Package declarations
:summary: A package may declare a net with an initial assignment, readable via package scope.
*/
package globals;
  wire [3:0] pkg_net = 4'h9;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask

  initial begin
    #1;
    check(globals::pkg_net == 4'h9, $sformatf("package net = %h", globals::pkg_net));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
