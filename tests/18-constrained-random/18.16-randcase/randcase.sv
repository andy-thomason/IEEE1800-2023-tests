/*
:section: 18.16 Random weighted case—randcase
:summary: randcase picks a branch with probability proportional to its weight, never choosing a
  zero-weight branch.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int hits [3];
  int none = 1;
  initial begin
    repeat (300) randcase
      3: hits[0]++;
      1: hits[1]++;
      0: hits[2]++;
    endcase
    check(hits[2] == 0 && hits[0] + hits[1] == 300, "zero-weight branch taken");
    check(hits[0] > hits[1], "weights not applied (3 vs 1)");
    randcase 0: none = 2; 0: none = 3; endcase
    check(none == 1, "a branch was taken when all weights are zero");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
