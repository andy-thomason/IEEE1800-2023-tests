/*
:section: 6.11 Integer data types
:summary: Each integer type has its specified width, signedness and 2-state or 4-state value
  set.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  shortint si; int i; longint li; byte b; bit [5:0] bv;
  logic [6:0] lv; reg [2:0] rv; integer ig; time t;
  initial begin
    check($bits(si) == 16 && $bits(i) == 32 && $bits(li) == 64 && $bits(b) == 8, "2-state integer widths");
    check($bits(ig) == 32 && $bits(t) == 64, "integer and time widths");
    check($bits(bv) == 6 && $bits(lv) == 7 && $bits(rv) == 3, "user-defined vector widths");
    si = 'x; i = 'x; li = 'x; b = 'x; bv = 'x;
    check(!$isunknown(si) && !$isunknown(i) && !$isunknown(li) && !$isunknown(b) && !$isunknown(bv),
          "a 2-state type stored an unknown value");
    lv = 'x; rv = 'z; ig = 'x; t = 'x;
    check($isunknown(lv) && $isunknown(rv) && $isunknown(ig) && $isunknown(t), "a 4-state type lost x or z");
    si = -1; b = -1; li = -1;
    check(si < 0 && b < 0 && li < 0, "shortint, byte or longint is not signed");
    t = '1;
    check(t > 0, "time is not unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
