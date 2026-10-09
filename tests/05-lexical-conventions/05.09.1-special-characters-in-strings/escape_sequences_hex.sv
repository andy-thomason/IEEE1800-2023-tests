/*
:section: 5.9.1 Special characters in strings
:summary: A \x escape takes one or two hex digits; a one-digit form must not precede another hex
  digit.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s;
  initial begin
    s = "\x41\x7e\x9g";
    check(s.len() == 4, $sformatf("length %0d, expected 4", s.len()));
    check(s[0] == 65 && s[1] == 126 && s[2] == 9 && s[3] == "g", "hex escapes of 2 and 1 digits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
