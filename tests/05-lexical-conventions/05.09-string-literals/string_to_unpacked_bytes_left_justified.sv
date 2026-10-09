/*
:section: 5.9 String literals
:summary: A string assigned to a larger unpacked byte array fills from the left, zeroing the
  rest.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte chars [0:5] = "xyz";
  initial begin
    check(chars[0] == "x" && chars[1] == "y" && chars[2] == "z", "characters are not left justified");
    check(chars[3] == 0 && chars[4] == 0 && chars[5] == 0, "remaining bytes are not zero");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
