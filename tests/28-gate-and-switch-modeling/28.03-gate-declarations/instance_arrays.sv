/*
:section: 28.3.5 The range specification
:summary: A gate range [lhi:rhi] yields abs(lhi-rhi)+1 gates, with port bits split or shared
  across them.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 4'b1100, b = 4'b1010;
  logic en = 1;
  logic one_in = 0;
  wire [3:0] y_nand, y_buf;
  wire one_out;
  nand ng[7:4] (y_nand, a, b);
  bufif1 bg[0:3] (y_buf, a, en);
  not single[2:2] (one_out, one_in);
  initial begin
    #1;
    check(y_nand == 4'b0111, $sformatf("bitwise nand array gave %b", y_nand));
    check(y_buf == 4'b1100, "scalar enable connected to every instance");
    check(one_out === 1'b1, "[2:2] creates one instance");
    en = 0;
    #1;
    check(y_buf === 4'bzzzz, "shared enable switched every instance off");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
