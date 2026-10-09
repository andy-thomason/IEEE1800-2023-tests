/*
:section: 6.16.2 Putc()
:summary: putc replaces one character, leaving the string unchanged for out-of-range indices or
  a zero value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "cart";
  initial begin
    s.putc(0, "d");  check(s == "dart", $sformatf("putc(0) gave %s", s));
    s.putc(4, "s");  check(s == "dart", "putc past the end changed the string");
    s.putc(-1, "s"); check(s == "dart", "putc at -1 changed the string");
    s.putc(2, 0);    check(s == "dart", "putc with 0 changed the string");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
