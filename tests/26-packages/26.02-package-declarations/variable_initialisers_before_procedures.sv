/*
:section: 26.2 Package declarations
:summary: Package variable initialisers are evaluated before initial and always procedures start
  running.
*/
package cfg;
  int seed = 1234;
  int derived = seed * 2;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int seen_seed, seen_derived;
  initial begin
    seen_seed = cfg::seed;
    seen_derived = cfg::derived;
  end
  initial begin
    #1;
    check(seen_seed == 1234 && seen_derived == 2468, $sformatf("time-0 reads gave %0d %0d", seen_seed, seen_derived));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
