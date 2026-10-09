/*
:section: 6.23 Type operator
:summary: The type operator yields an expression's self-determined type, usable in declarations
  and overrides.
*/
module holder #(parameter type T = int) (output int width);
  assign width = $bits(T);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [5:0] x;
  logic [9:0] y;
  var type(x * y) product;
  localparam type wide_t = type(logic [12:0]);
  wide_t w;
  int width;
  holder #(.T(type(y))) u(.width(width));
  initial begin
    #1;
    check($bits(product) == 10, $sformatf("type(x * y) has %0d bits, expected 10", $bits(product)));
    check($bits(w) == 13, "type of a data type");
    check(type(x)'(8'hFF) == 6'h3F, "cast to type(x)");
    check(width == 10, "type reference as a type parameter override");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
