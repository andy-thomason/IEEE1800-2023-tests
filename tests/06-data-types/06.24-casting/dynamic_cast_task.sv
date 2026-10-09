/*
:section: 6.24.2 $cast dynamic casting
:summary: Task-form $cast assigns the source value to the destination when the conversion is
  legal.
:description: Only valid task-form casts are used. For an invalid one the standard requires a run-
  time error, which a tool may report by stopping the simulation, so that case is not
  checked here.
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
  initial begin
    $cast(lv, 3 * 3);
    check(lv == HIGH, "valid task-form $cast did not assign");
    $cast(lv, 2 * 2);
    check(lv == MID, "second valid task-form $cast did not assign");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
