/*
:section: 7.4.5 Indexing and slicing of arrays
:summary: Reading class, event or chandle array elements with an out-of-range index yields null.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class obj_c; endclass
  obj_c c [4];
  event ev [4];
  chandle ch [4];
  int idx = 7;
  initial begin
    foreach (c[k]) c[k] = new;
    check(c[idx] == null, "class element");
    check(ev[idx] == null, "event element");
    check(ch[idx] == null, "chandle element");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
