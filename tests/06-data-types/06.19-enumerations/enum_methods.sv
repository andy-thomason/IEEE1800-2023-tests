/*
:section: 6.19.5 Enumerated type methods
:summary: The first, last, next, prev, num and name methods navigate enum members with
  wraparound.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {APRIL = 4, MAY, JUNE = 8, JULY} month_t;
  month_t m;
  initial begin
    check(m.first() == APRIL && m.last() == JULY, "first and last");
    check(m.num() == 4, $sformatf("num = %0d", m.num()));
    m = JUNE;
    check(m.prev() == MAY && m.prev(2) == APRIL, "prev");
    m = APRIL;
    check(m.prev() == JULY && m.prev(3) == MAY, "prev wraps to the end");
    check(m.name() == "APRIL", $sformatf("name = %s", m.name()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
