/*
:section: 18.7.1 local:: scope resolution
:summary: Inline randomize() with constraints resolve names in the object first, and local::
  selects the caller's variables.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class item_c;
    rand int x;
    int limit = 1000;
  endclass
  item_c it = new;
  int limit = 5;
  int bad = 0;
  initial begin
    repeat (50) if (!it.randomize() with { x > 0; x < limit; } || it.x >= 1000) bad++;
    check(bad == 0, "unqualified name resolved to the class property");
    repeat (50) if (!it.randomize() with { x > 0; x < local::limit; } || it.x >= 5) bad++;
    check(bad == 0, "local:: did not resolve to the caller's variable");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
