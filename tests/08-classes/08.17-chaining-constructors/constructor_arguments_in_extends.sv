/*
:section: 8.17 Chaining constructors
:summary: Fixed base constructor arguments may be supplied in the extends clause instead of an
  explicit super.new call.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class packet_c;
    int len;
    function new(int l); len = l; endfunction
  endclass
  class fixed_c extends packet_c(12); endclass
  class explicit_c extends packet_c;
    function new(); super.new(40); endfunction
  endclass
  fixed_c f;
  explicit_c e;
  initial begin
    f = new;
    e = new;
    check(f.len == 12, "arguments in the extends specifier");
    check(e.len == 40, "explicit super.new");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
