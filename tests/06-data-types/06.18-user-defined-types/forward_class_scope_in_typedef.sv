/*
:section: 6.18 User-defined types
:summary: A typedef may select a type through a forward-declared class before that class is
  defined.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef holder;
  typedef holder::item_t local_item_t;
  local_item_t v;
  class holder;
    typedef logic [4:0] item_t;
  endclass
  initial begin
    check($bits(v) == 5, "type selected from a forward class through a typedef");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
