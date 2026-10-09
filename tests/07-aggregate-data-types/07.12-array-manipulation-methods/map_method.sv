/*
:section: 7.12.5 Array mapping method
:summary: The map() method yields an array of the same shape whose elements come from the with
  expression.
:description: The map() method is new in IEEE 1800-2023.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int idyn_t [];
  typedef bit bdyn_t [];
  function automatic bit eq_i(idyn_t got, idyn_t want);
    return got == want;
  endfunction
  function automatic bit eq_b(bdyn_t got, bdyn_t want);
    return got == want;
  endfunction
  int base [] = '{4, 5, 6};
  int other [] = '{4, 0, 6};
  int plus [];
  bit same [];
  string names [int] = '{3: "c", 1: "a"};
  int lens [int];
  initial begin
    plus = base.map() with (item * 2);
    check(eq_i(plus, '{8, 10, 12}), "map with item");
    same = base.map(v) with (v == other[v.index]);
    check(eq_b(same, '{1, 0, 1}), "map with an iterator name and index");
    lens = names.map(n) with (n.len() + n.index);
    check(lens.num() == 2 && lens[3] == 4 && lens[1] == 2, "map keeps associative indices");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
