/*
:section: 7.8.7 Allocating associative array elements
:summary: Assignment, increment or ref passing allocates a missing associative array entry,
  using any default.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int left = 4; int right = 6; } pair_t;
  int counts [int] = '{default: 10};
  pair_t pairs [string];
  int plain [int];
  task automatic set_ref(ref int slot);
    slot = 77;
  endtask
  initial begin
    counts[3]++;
    check(counts[3] == 11, $sformatf("increment of a new element gave %0d, expected 11", counts[3]));
    pairs["p"].left = 1;
    check(pairs["p"].left == 1 && pairs["p"].right == 6, "member write allocated without member defaults");
    set_ref(plain[9]);
    check(plain.exists(9) && plain[9] == 77, "passing by reference did not allocate");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
