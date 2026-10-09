/*
:section: 26.3 Referencing data in packages
:summary: A function call binds to a local function declared later in the scope over a wildcard
  import.
*/
package lib; function automatic int pick(); return 1; endfunction endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import lib::*;
  int got;
  initial got = pick();
  function automatic int pick(); return 2; endfunction
  initial begin
    #1;
    check(got == 2, $sformatf("call bound to %0d; the later local function should win", got));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
