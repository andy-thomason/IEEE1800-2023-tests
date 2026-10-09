/*
:section: 6.8 Variable declarations
:summary: A var declaration may omit the data type, which then defaults to logic.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  var v1;
  var [11:0] v12;
  var signed [3:0] vs;
  var byte vb;
  var reg vr;
  initial begin
    check($bits(v1) == 1 && v1 === 1'bx, "var without a type is a 1-bit logic");
    check($bits(v12) == 12 && v12 === 12'hxxx, "var with a range is a logic vector");
    vs = -1;
    check(vs < 0, "var signed is signed");
    check($bits(vb) == 8 && vb == 0, "var byte is a byte");
    check(vr === 1'bx, "var reg is 4-state");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
