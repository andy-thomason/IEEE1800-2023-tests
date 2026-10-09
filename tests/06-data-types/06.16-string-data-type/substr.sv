/*
:section: 6.16.8 Substr()
:summary: substr returns characters i through j, or an empty string when the indices are
  invalid.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "keyboard";
  initial begin
    check(s.substr(3, 7) == "board", $sformatf("substr(3,7) = %s", s.substr(3, 7)));
    check(s.substr(0, 0) == "k", "single-character substring");
    check(s.substr(-1, 2) == "", "i < 0");
    check(s.substr(4, 3) == "", "j < i");
    check(s.substr(2, 8) == "", "j >= len");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
