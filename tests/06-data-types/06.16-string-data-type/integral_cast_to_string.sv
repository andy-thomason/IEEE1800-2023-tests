/*
:section: 6.16 String data type
:summary: Converting an integral value to string resizes it, zero-padding on the left to whole
  bytes.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [11:0] twelve = 12'h563;
  bit [11:0] padded = 12'h041;
  logic [23:0] three = "Hey";
  string s;
  initial begin
    s = string'(twelve);
    check(s.len() == 2 && s[0] == 8'h05 && s[1] == 8'h63, "12-bit value was not zero-filled to 16 bits");
    s = string'(padded);
    check(s == "A", $sformatf("12'h041 gave '%s'; the zero byte should be dropped", s));
    s = string'(three);
    check(s == "Hey", $sformatf("24-bit value gave '%s'", s));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
