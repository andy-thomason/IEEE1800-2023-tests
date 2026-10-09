/*
:section: 3.12.1 Compilation units
:summary: Text pulled in by `include joins the compilation unit of whichever file includes it.
:description: Runs with one compilation unit per file where the tool supports it.
:includes: include_joins_including_unit_defs.svh
:flags-icarus: -u
*/
`include "include_joins_including_unit_defs.svh"

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  nibble_pair_t pair;
  initial begin
    pair.hi = 4'hA;
    pair.lo = 4'h5;
    check($bits(pair) == 8, $sformatf("$bits(nibble_pair_t) = %0d", $bits(pair)));
    check(PAIR_COUNT == 3, $sformatf("PAIR_COUNT = %0d", PAIR_COUNT));
    check(pair == 8'hA5, $sformatf("pair = %h", pair));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
