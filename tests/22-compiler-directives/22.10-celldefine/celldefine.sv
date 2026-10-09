/*
:section: 22.10 `celldefine and `endcelldefine
:summary: `celldefine and `endcelldefine mark modules as cells without changing how they
  simulate.
*/
`celldefine
module inv_cell(input a, output y);
  assign y = ~a;
endmodule
`endcelldefine

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire o;
  inv_cell u(.a(1'b1), .y(o));
  initial begin
    #1;
    check(o === 1'b0, "cell module output");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
