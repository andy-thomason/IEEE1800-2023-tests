/*
:section: 5.9.1 Special characters in strings
:summary: An octal escape takes one to three octal digits, stopping before a non-octal
  character.
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
    s = "\101\60\7w";
    check(s.len() == 4, $sformatf("length %0d, expected 4", s.len()));
    check(s[0] == 65 && s[1] == 48 && s[2] == 7 && s[3] == "w", "octal escapes of 3, 2 and 1 digits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
