/*
:section: 11.4.14.4 Streaming dynamically sized data
:summary: A with clause on an array inside a streaming operator restricts which elements are
  packed or unpacked.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte data [] = '{8'h01, 8'h02, 8'h03, 8'h04};
  byte len;
  byte body [];
  logic [15:0] r;
  initial begin
    r = {>> {data with [1 +: 2]}};
    check(r == 16'h0203, "packing a range of an array");
    {>> {len, body with [0 +: len]}} = 32'h02_AA_BB_CC;
    check(len == 2 && body.size() == 2 && body[1] == 8'hBB, "unpacking a length-prefixed body");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
