/*
:section: 18.13.2 $urandom_range()
:summary: $urandom with the same seed repeats its sequence, and $urandom_range returns values
  inside the given bounds.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int unsigned seq1 [5], seq2 [5];
  int bad = 0, v;
  initial begin
    seq1[0] = $urandom(77);
    for (int i = 1; i < 5; i++) seq1[i] = $urandom;
    seq2[0] = $urandom(77);
    for (int i = 1; i < 5; i++) seq2[i] = $urandom;
    check(seq1 == seq2, "the same seed did not reproduce the sequence");
    repeat (100) begin
      v = $urandom_range(9, 3); if (v < 3 || v > 9) bad++;
      v = $urandom_range(3, 9); if (v < 3 || v > 9) bad++;
      v = $urandom_range(4); if (v > 4) bad++;
    end
    check(bad == 0, "$urandom_range out of range (incl. reversed arguments)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
