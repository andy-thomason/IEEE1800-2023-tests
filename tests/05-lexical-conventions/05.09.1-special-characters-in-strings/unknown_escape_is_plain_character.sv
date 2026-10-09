/*
:section: 5.9.1 Special characters in strings
:summary: A backslash before a character with no defined escape meaning simply yields that
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
    s = "\q\m\%";
    check(s == "qm%", $sformatf("\\q\\m\\%% gave \"%s\"", s));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
