/*
:section: 7.4.1 Packed arrays
:summary: Packed arrays form contiguous vectors usable in arithmetic, with the left index most
  significant.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [0:3][7:0] quad;
  bit signed [1:0][3:0] sp;
  typedef bit signed [3:0] snib_t;
  snib_t [1:0] named_elems;
  initial begin
    quad = 32'h11223344;
    check(quad[0] == 8'h11 && quad[3] == 8'h44, "element 0 of [0:3] is not the most significant");
    check(quad + 1 == 32'h11223345, "packed array used as a vector");
    sp = 8'hF0;
    check(sp < 0, "signed packed array is not signed as a whole");
    check(sp[1] > 0, "an element of a signed packed array compared as negative; elements are unsigned");
    check(sp[1][3:0] > 0 && sp[7:4] > 0, "a part-select compared as negative; part-selects are unsigned");
    named_elems = 8'hF0;
    check(named_elems[1] < 0, "elements of a signed named type are not signed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
