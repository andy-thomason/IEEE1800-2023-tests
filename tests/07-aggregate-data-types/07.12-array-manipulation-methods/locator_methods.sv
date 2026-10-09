/*
:section: 7.12.1 Array locator methods
:summary: Locator methods yield a queue holding matching elements or their indices, empty when
  nothing matches.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int iq_t [$];
  function automatic bit eq(iq_t got, iq_t want);
    return got == want;
  endfunction
  int vals [6] = '{4, 9, 2, 9, 7, 1};
  int empty_dyn [];
  int found [$];
  string scores_keys [$];
  int scores [string] = '{"amy": 70, "ben": 95, "cal": 95};
  initial begin
    found = vals.find(x) with (x > 5);
    check(found.size() == 3, "find");
    found = vals.find_index with (item == 9);
    found.sort();
    check(eq(found, '{1, 3}), "find_index");
    found = vals.find_first with (item > 8);
    check(eq(found, '{9}), "find_first");
    found = vals.find_first_index(v) with (v > 8);
    check(eq(found, '{1}), "find_first_index");
    found = vals.find_last with (item < 5);
    check(eq(found, '{1}), "find_last");
    found = vals.find_last_index with (item == 9);
    check(eq(found, '{3}), "find_last_index");
    found = vals.find with (item > 100);
    check(found.size() == 0, "no match gives an empty queue");
    found = empty_dyn.find with (item > 0);
    check(found.size() == 0, "empty array gives an empty queue");
    scores_keys = scores.find_index with (item == 95);
    scores_keys.sort();
    check(scores_keys.size() == 2 && scores_keys[0] == "ben", "associative find_index returns the index type");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
