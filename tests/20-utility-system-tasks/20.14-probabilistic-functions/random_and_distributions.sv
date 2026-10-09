/*
:section: 20.14.2 Distribution functions
:summary: $random with equal seeds reproduces sequences, and distribution functions like
  $dist_uniform respect their parameters.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int seed_a, seed_b;
  int seq_a [4], seq_b [4];
  int bad = 0, v, seed_c;
  initial begin
    seed_a = 11; seed_b = 11;
    foreach (seq_a[i]) seq_a[i] = $random(seed_a);
    foreach (seq_b[i]) seq_b[i] = $random(seed_b);
    check(seq_a == seq_b && seed_a == seed_b, "the same seed variable did not give the same stream");
    check(seed_a != 11, "$random did not update its seed argument");
    seed_c = 5;
    repeat (100) begin
      v = $dist_uniform(seed_c, -3, 9);
      if (v < -3 || v > 9) bad++;
    end
    check(bad == 0, "$dist_uniform out of range");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
