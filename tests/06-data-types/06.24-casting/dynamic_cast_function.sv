/*
:section: 6.24.2 $cast dynamic casting
:summary: Function-form $cast returns 1 and assigns on success, or returns 0 without assigning.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {LOW = 1, MID = 4, HIGH = 9} level_t;
  level_t lv = LOW;
  int ok;
  initial begin
    ok = $cast(lv, 2 + 2);
    check(ok == 1 && lv == MID, "valid $cast did not assign or return 1");
    ok = $cast(lv, 5);
    check(ok == 0, "invalid $cast did not return 0");
    check(lv == MID, "invalid $cast changed the destination");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
