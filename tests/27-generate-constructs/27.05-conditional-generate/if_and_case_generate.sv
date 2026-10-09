/*
:section: 27.5 Conditional generate constructs
:summary: Conditional if and case generate pick at most one block, so alternatives may share a
  name.
*/
module picker #(parameter int MODE = 0) (output int kind);
  if (MODE == 0) begin : impl
    assign kind = 100;
  end else begin : impl
    assign kind = 200;
  end
  case (MODE)
    0, 1: begin : sel int tag = 1; end
    2: begin : sel int tag = 2; end
    default: begin : sel int tag = 3; end
  endcase
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int k0, k1, k5;
  picker #(0) p0(.kind(k0));
  picker #(2) p2(.kind(k1));
  picker #(5) p5(.kind(k5));
  initial begin
    #1;
    check(k0 == 100 && k1 == 200, "if-generate chose the block");
    check(p0.sel.tag == 1 && p2.sel.tag == 2 && p5.sel.tag == 3, "case-generate with default");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
