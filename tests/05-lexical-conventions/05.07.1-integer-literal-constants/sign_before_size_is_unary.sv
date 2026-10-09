/*
:section: 5.7.1 Integer literal constants
:summary: A minus before a sized literal is a unary operator yielding the two's complement
  value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [5:0] six;
  logic [7:0] eight;
  initial begin
    six = -6'd5;
    check(six === 6'b111011, $sformatf("-6'd5 = %b, expected 111011", six));
    eight = -8'sd7;
    check(eight === 8'hF9, $sformatf("-8'sd7 = %h, expected f9", eight));
    eight = +8'd12;
    check(eight === 8'd12, "unary plus changed the value");
    check(-4'sd1 === 4'b1111, "-4'sd1 is not all ones");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
