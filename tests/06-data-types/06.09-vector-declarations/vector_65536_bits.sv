/*
:section: 6.9.1 Specifying vectors
:summary: Tools must support vectors of at least 65536 bits.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [65535:0] big;
  initial begin
    big = '0;
    big[65535] = 1'b1;
    big[0] = 1'b1;
    check($bits(big) == 65536, "width");
    check(big[65535] === 1'b1 && big[0] === 1'b1 && big[32768] === 1'b0, "end bits");
    check($countones(big) == 2, "bit count");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
