/*
:section: 6.19 Enumerations
:summary: Enums default to int, start at 0, and unvalued names take the previous value plus one.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  enum {LOW, MID, HIGH} level;
  enum {p = 5, q = 9, r} letters;
  enum {first, second = 20, third} order;
  initial begin
    check($bits(level) == 32, $sformatf("default base type has %0d bits", $bits(level)));
    check(LOW == 0 && MID == 1 && HIGH == 2, "default values");
    check(r == 10, $sformatf("r = %0d, expected 10", r));
    check(first == 0 && third == 21, "first defaults to 0, third follows 20");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
