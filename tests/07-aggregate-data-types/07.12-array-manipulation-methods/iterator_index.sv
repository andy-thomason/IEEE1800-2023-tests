/*
:section: 7.12.4 Iterator index querying
:summary: An iterator's index method reports the current element position, defaulting to the
  first dimension, and may be renamed.
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
  typedef struct { int index; } tagged_t;
  int arr [] = '{0, 5, 2, 7, 4};
  int r [$];
  tagged_t items [3];
  initial begin
    r = arr.find with (item == item.index);
    r.sort();
    check(eq(r, '{0, 2, 4}), "item.index");
    items[0].index = 0; items[1].index = 9; items[2].index = 2;
    r = items.find_index(it, pos) with (it.index != it.pos);
    check(eq(r, '{1}), "renamed index method avoids the member called index");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
