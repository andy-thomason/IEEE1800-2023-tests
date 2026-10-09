/*
:section: 11.4.14.2 Re-ordering of the generic stream
:summary: The << operator reverses a stream in slices of the given size, while >> leaves the
  order unchanged.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [31:0] word = 32'h1234_5678;
  logic [31:0] r;
  logic [5:0] r6;
  logic [7:0] r8;
  initial begin
    r = {>> {word}};         check(r == 32'h1234_5678, ">> keeps the order");
    r = {<< byte {word}};    check(r == 32'h7856_3412, "<< byte reverses bytes");
    r = {<< 16 {word}};      check(r == 32'h5678_1234, "<< 16 swaps halves");
    r8 = {<< {8'b0011_0101}};
    check(r8 == 8'b1010_1100, "<< reverses bits");
    r6 = {<< 4 {6'b11_0101}};
    check(r6 == 6'b0101_11, "<< 4 on 6 bits leaves a short block at the end");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
