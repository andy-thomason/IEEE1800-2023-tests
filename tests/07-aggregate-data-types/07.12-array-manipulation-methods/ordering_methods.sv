/*
:section: 7.12.2 Array ordering methods
:summary: reverse(), sort(), rsort() and shuffle() reorder unpacked array elements, with sort
  and rsort accepting a with clause.
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
  typedef struct { byte r, g, b; } px_t;
  string words [] = '{"pear", "fig", "apple"};
  int q [$] = {7, 1, 9, 4};
  int keep [$];
  px_t pixels [3];
  initial begin
    words.reverse();
    check(words[0] == "apple" && words[2] == "pear", "reverse");
    q.sort();
    check(eq(q, '{1, 4, 7, 9}), "sort");
    q.rsort();
    check(eq(q, '{9, 7, 4, 1}), "rsort");
    q.sort(v) with (v % 3);
    check(q[0] == 9 && q[3] inside {4, 7, 1} && q[3] % 3 == 1, "sort with an expression");
    pixels[0] = '{3, 0, 9}; pixels[1] = '{1, 5, 9}; pixels[2] = '{2, 5, 0};
    pixels.sort with ({item.b, item.g});
    check(pixels[0].r == 2 && pixels[1].r == 3 && pixels[2].r == 1, "struct sort by a concatenated key");
    keep = q;
    q.shuffle();
    q.sort(); keep.sort();
    check(q == keep, "shuffle changed the set of elements");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
