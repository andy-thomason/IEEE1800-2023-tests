/*
:section: 13.5.4 Argument binding by name
:summary: Arguments may be bound by name in any order, with positional ones first and defaults
  filling gaps.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic string join3(string s = "a", int n = 1, bit up = 0);
    string r = "";
    repeat (n) r = {r, s};
    return up ? r.toupper() : r;
  endfunction
  initial begin
    check(join3(.n(3), .s("x")) == "xxx", "named only, any order");
    check(join3("y", .up(1)) == "Y", "positional then named");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
