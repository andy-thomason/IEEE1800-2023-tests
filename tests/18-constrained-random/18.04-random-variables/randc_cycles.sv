/*
:section: 18.4.2 Randc modifier
:summary: A randc variable visits every value of its range once before any value repeats.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class cyc_c;
    randc bit [2:0] v;
  endclass
  cyc_c c = new;
  bit seen [8];
  int distinct;
  initial begin
    for (int round = 0; round < 3; round++) begin
      foreach (seen[i]) seen[i] = 0;
      repeat (8) begin
        void'(c.randomize());
        seen[c.v] = 1;
      end
      distinct = 0;
      foreach (seen[i]) distinct += seen[i];
      check(distinct == 8, $sformatf("round %0d produced %0d distinct values in 8 calls", round, distinct));
    end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
