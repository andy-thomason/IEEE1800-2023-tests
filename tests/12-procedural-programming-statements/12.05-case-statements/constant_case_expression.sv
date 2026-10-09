/*
:section: 12.5.2 Constant expression in case statement
:summary: A constant such as 1'b1 may serve as the case expression, with items compared against
  it.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [2:0] enc;
  int pos;
  initial begin
    enc = 3'b010;
    case (1'b1)
      enc[2]: pos = 2;
      enc[1]: pos = 1;
      enc[0]: pos = 0;
      default: pos = -1;
    endcase
    check(pos == 1, "case (1) priority encoder");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
