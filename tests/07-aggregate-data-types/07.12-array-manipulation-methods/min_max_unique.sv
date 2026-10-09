/*
:section: 7.12.1 Array locator methods
:summary: min() and max() return one extreme element, while unique() and unique_index() return
  distinct values or their indices.
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
  int vals [7] = '{5, -3, 8, -3, 8, 0, 5};
  string names [4] = '{"Zed", "amy", "AMY", "bob"};
  int r [$];
  string s [$];
  int idx [$];
  initial begin
    r = vals.min();  check(eq(r, '{-3}), "min returns one element");
    r = vals.max();  check(eq(r, '{8}), "max returns one element");
    r = vals.max with (-item);
    check(eq(r, '{-3}), "max with a with clause");
    r = vals.unique();
    r.sort();
    check(eq(r, '{-3, 0, 5, 8}), "unique");
    idx = vals.unique_index();
    check(idx.size() == 4, "unique_index count");
    s = names.unique(n) with (n.tolower());
    check(s.size() == 3, "unique with a with clause");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
