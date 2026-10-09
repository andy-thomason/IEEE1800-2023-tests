/*
:section: 6.16.9 Atoi(), atohex(), atooct(), atobin()
:summary: atoi does not accept a leading sign, so a string starting with minus converts to zero.
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
    s = "-25";
    check(s.atoi() == 0, $sformatf("atoi of -25 = %0d; the scan stops at the sign", s.atoi()));
    s = "8'd9";
    check(s.atoi() == 8, $sformatf("atoi of 8'd9 = %0d; the scan stops at the apostrophe", s.atoi()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
