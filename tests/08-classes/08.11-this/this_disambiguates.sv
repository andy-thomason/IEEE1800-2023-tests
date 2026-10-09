/*
:section: 8.11 This
:summary: Using this.name selects the class member when a method argument shadows it.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class point_c;
    int x;
    function new(int x);
      this.x = x + 1;
      x = 0;
    endfunction
    function point_c self(); return this; endfunction
  endclass
  point_c p;
  initial begin
    p = new(4);
    check(p.x == 5, "this.x did not reach the property");
    check(p.self() == p, "this is not the current object");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
