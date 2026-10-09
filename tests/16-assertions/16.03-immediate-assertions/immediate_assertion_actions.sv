/*
:section: 16.3 Immediate assertions
:summary: Immediate assertions evaluate their expression like an if condition and run the pass
  or fail action.
:flags-verilator: --coverage-user
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int passes = 0, fails = 0, covers = 0;
  logic [1:0] v;
  initial begin
    v = 2'b01; a1: assert (v) passes++; else fails++;
    v = 2'b00; a2: assert (v) passes++; else fails++;
    v = 2'bx0; a3: assert (v) passes++; else fails++;
    v = 2'bz1; a4: assert (v) passes++; else fails++;
    check(passes == 2 && fails == 2, $sformatf("passes %0d fails %0d", passes, fails));
    v = 2'b10; cover (v) covers++;
    v = 2'b00; cover (v) covers++;
    check(covers == 1, "immediate cover");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
