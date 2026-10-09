/*
:section: 8.25 Parameterized classes
:summary: One parameterized class may extend another parameterized class, passing parameters
  through.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class base_c #(type T = bit);
    T v;
  endclass
  class d1_c #(type P = real) extends base_c;
  endclass
  class d2_c #(type P = real) extends base_c #(integer);
  endclass
  class d3_c #(type P = real) extends base_c #(P);
  endclass
  d1_c x1 = new;
  d2_c x2 = new;
  d3_c #(shortint) x3 = new;
  initial begin
    check($bits(x1.v) == 1 && $bits(x2.v) == 32 && $bits(x3.v) == 16, "base parameters from the extends clause");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
