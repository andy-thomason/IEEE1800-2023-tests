/*
:section: 7.9.3 Exists()
:summary: exists() reports 1 for an index holding an element and 0 otherwise.
:description: Uses an int index so that only exists() is under test, not string keys.
*/
module top;
  int scores [int];
  int errors = 0;
  initial begin
    scores[42] = 7;
    scores[-3] = 9;
    if (scores.exists(42) != 1) begin $display("FAIL: exists(42) missed a stored key"); errors++; end
    if (scores.exists(-3) != 1) begin $display("FAIL: exists(-3) missed a stored key"); errors++; end
    if (scores.exists(43) != 0) begin $display("FAIL: exists(43) found a missing key"); errors++; end
    scores.delete(42);
    if (scores.exists(42) != 0) begin $display("FAIL: exists(42) found a deleted key"); errors++; end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
