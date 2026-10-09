/*
:section: 11.9 Tagged union expressions and member access
:summary: Reading a tagged union member different from the one currently tagged is a run-time
  error.
:type: simulation
:should_fail_because: the Number member is read while the tag is Letter
*/
module top;
  typedef union tagged { int Number; byte Letter; } val_t;
  val_t v;
  int n;
  initial begin
    v = tagged Letter 8'h41;
    n = v.Number;
    $display("read the wrong member without an error: %0d", n);
    $finish;
  end
endmodule
