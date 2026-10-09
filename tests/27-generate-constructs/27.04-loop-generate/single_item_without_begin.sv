/*
:section: 27.4 Loop generate constructs
:summary: A loop generate body can be one item without begin-end and still forms a generate
  block.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] src = 4'b1010;
  wire [3:0] dst;
  for (genvar g = 0; g < 4; g++)
    assign dst[g] = ~src[g];
  initial begin
    #1;
    check(dst == 4'b0101, $sformatf("one-item generate blocks gave %b", dst));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
