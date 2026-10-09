/*
:section: 6.11.1 Integral types
:summary: int holds only 0 and 1 values, whereas integer can also hold x and z.
*/
module top;
  int     two_state;
  integer four_state;
  initial begin
    if (two_state !== 0) $display("FAIL: int did not start at 0");
    else if (four_state !== 32'bx) $display("FAIL: integer did not start unknown");
    else begin
      two_state = 32'bz;
      four_state = 32'bz;
      if (two_state !== 0) $display("FAIL: int stored z bits");
      else if (four_state !== 32'bz) $display("FAIL: integer lost z bits");
      else $display("PASS");
    end
    $finish;
  end
endmodule
