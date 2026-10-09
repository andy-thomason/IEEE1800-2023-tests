/*
:section: 6.16.11 Itoa()
:summary: itoa, hextoa, octtoa and bintoa write an integer as decimal, hex, octal or binary
  text.
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
    s.itoa(1234);   check(s == "1234", $sformatf("itoa = %s", s));
    s.itoa(-42);    check(s == "-42", $sformatf("itoa(-42) = %s", s));
    s.hextoa(255);  check(s.tolower() == "ff", $sformatf("hextoa = %s", s));
    check(s.atohex() == 255, "hextoa is not the inverse of atohex");
    s.octtoa(8);    check(s == "10", $sformatf("octtoa = %s", s));
    check(s.atooct() == 8, "octtoa is not the inverse of atooct");
    s.bintoa(5);    check(s == "101", $sformatf("bintoa = %s", s));
    check(s.atobin() == 5, "bintoa is not the inverse of atobin");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
