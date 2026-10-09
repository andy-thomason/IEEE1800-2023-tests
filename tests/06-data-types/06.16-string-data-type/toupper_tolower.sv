/*
:section: 6.16.4 Toupper()
:summary: toupper and tolower return case-converted copies without modifying the original
  string.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "MiXed 42!";
  initial begin
    check(s.toupper() == "MIXED 42!", $sformatf("toupper gave %s", s.toupper()));
    check(s.tolower() == "mixed 42!", $sformatf("tolower gave %s", s.tolower()));
    check(s == "MiXed 42!", "the original string was changed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
