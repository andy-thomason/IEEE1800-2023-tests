/*
:section: 6.16.6 Compare()
:summary: compare orders strings like C strcmp, and icompare does the same ignoring letter case.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "Bravo";
  initial begin
    check(s.compare("Bravo") == 0, "compare equal");
    check(s.compare("Charlie") < 0, "compare less");
    check(s.compare("Alpha") > 0, "compare greater");
    check(s.compare("bravo") < 0, "compare is not case sensitive ('B' < 'b')");
    check(s.icompare("bRAVO") == 0, "icompare is case sensitive");
    check(s.icompare("alpha") > 0 && s.icompare("CHARLIE") < 0, "icompare ordering");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
