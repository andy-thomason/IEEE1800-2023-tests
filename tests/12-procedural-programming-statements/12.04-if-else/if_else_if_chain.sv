/*
:section: 12.4.1 if–else–if construct
:summary: An if-else-if chain tests conditions in order and runs only the first branch whose
  condition holds.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int evals = 0, taken;
  function automatic bit cond(bit v); evals++; return v; endfunction
  initial begin
    if (cond(0)) taken = 1;
    else if (cond(1)) taken = 2;
    else if (cond(1)) taken = 3;
    else taken = 4;
    check(taken == 2 && evals == 2, $sformatf("taken %0d after %0d evaluations", taken, evals));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
