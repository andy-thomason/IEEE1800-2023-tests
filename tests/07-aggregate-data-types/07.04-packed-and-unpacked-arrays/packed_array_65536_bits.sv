/*
:section: 7.4.1 Packed arrays
:summary: Packed arrays of arbitrary width work arithmetically, with at least 65536 bits
  supported.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [47:0] i48;
  bit [255:0][255:0] big;
  bit [65535:0] flat;
  initial begin
    i48 = 48'hFFFF_FFFF_FFFF;
    i48 = i48 + 1;
    check(i48 == 0, "48-bit arithmetic did not wrap");
    i48 = 48'h1_0000_0000 * 3;
    check(i48 == 48'h3_0000_0000, "48-bit multiply");
    big = '0;
    big[255][255] = 1'b1;
    flat = big;
    check($bits(big) == 65536 && flat[65535] == 1'b1 && flat[65534] == 1'b0, "65536-bit packed array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
