/*
:section: 6.12 Real, shortreal, and realtime data types
:summary: real matches a C double, shortreal a C float, and realtime is interchangeable with
  real.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  real r = 0.1;
  shortreal sr = 0.1;
  realtime rt = 0.1;
  initial begin
    check($realtobits(r) == 64'h3FB9_9999_9999_999A, "real is not an IEEE 754 double");
    check($shortrealtobits(sr) == 32'h3DCC_CCCD, "shortreal is not an IEEE 754 single");
    check(real'(sr) != r, "shortreal holds 0.1 as precisely as real");
    check($realtobits(rt) == $realtobits(r), "realtime is not the same as real");
    rt = 1.0 / 3.0;
    r = rt;
    check(r == rt, "realtime to real assignment lost precision");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
