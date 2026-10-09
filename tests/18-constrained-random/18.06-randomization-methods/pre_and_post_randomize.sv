/*
:section: 18.6.2 Pre_randomize() and post_randomize()
:summary: randomize() calls pre_randomize() before and post_randomize() after solving, skipping
  post_randomize() when it fails.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class hook_c;
    rand bit [3:0] v;
    int pre = 0, post = 0;
    bit impossible = 0;
    constraint c { impossible -> v > 20; }
    function void pre_randomize(); pre++; endfunction
    function void post_randomize(); post++; endfunction
  endclass
  hook_c h = new;
  initial begin
    void'(h.randomize());
    check(h.pre == 1 && h.post == 1, "hooks on success");
    h.impossible = 1;
    void'(h.randomize());
    check(h.pre == 2 && h.post == 1, "post_randomize called after a failure");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
