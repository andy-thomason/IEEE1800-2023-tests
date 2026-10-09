/*
:section: 6.16 String data type
:summary: Strings default to empty with length zero, and index 0 selects the leftmost character.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string blank;
  string s = "maze";
  initial begin
    check(blank.len() == 0 && blank == "", "uninitialised string is not empty");
    check(s[0] == "m" && s[3] == "e", "index 0 is not the leftmost character");
    check($bits(s[1]) == 8, "a string character is not 8 bits");
    s[1] = "o";
    check(s == "moze", $sformatf("writing s[1] gave %s", s));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
