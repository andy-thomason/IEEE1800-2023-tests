/*
:section: 27.5 Conditional generate constructs
:summary: Blocks of a directly nested conditional generate may reuse the outer block name and be
  referenced.
*/
module chain #(parameter int N = 0);
  if (N == 0) begin : choice
    int id = 10;
  end else
    if (N == 1) begin : choice
      int id = 11;
    end else begin : choice
      int id = 12;
    end
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  chain #(0) c0();
  chain #(1) c1();
  chain #(7) c7();
  initial begin
    #1;
    check(c0.choice.id == 10 && c1.choice.id == 11 && c7.choice.id == 12, "the nested blocks are named directly under the module");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
