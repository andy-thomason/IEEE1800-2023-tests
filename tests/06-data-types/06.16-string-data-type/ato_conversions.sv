/*
:section: 6.16.9 Atoi(), atohex(), atooct(), atobin()
:summary: atoi, atohex, atooct and atobin parse leading digits and underscores, stopping at the
  first invalid character.
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
    s = "4_096 rest";  check(s.atoi() == 4096, $sformatf("atoi = %0d", s.atoi()));
    s = "fF_0g";       check(s.atohex() == 'hFF0, $sformatf("atohex = %h", s.atohex()));
    s = "17_79";       check(s.atooct() == 'o177, $sformatf("atooct = %o", s.atooct()));
    s = "1012";        check(s.atobin() == 'b101, $sformatf("atobin = %b", s.atobin()));
    s = "none";        check(s.atoi() == 0, "no digits should give 0");
    s = "";            check(s.atohex() == 0, "empty string should give 0");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
