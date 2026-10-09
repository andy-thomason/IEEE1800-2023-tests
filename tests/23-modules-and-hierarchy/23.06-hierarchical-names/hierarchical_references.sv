/*
:section: 23.6 Hierarchical names
:summary: Hierarchical names can reach items through instance array elements, generate blocks
  and named blocks.
*/
module leaf; int value; endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  leaf arr [1:3] ();
  for (genvar g = 0; g < 2; g++) begin : gen
    int doubled = g * 2;
  end
  initial begin : blk
    int local_v = 9;
  end
  initial begin
    arr[2].value = 22;
    #1;
    check(top.arr[2].value == 22, "instance array select");
    check(gen[1].doubled == 2 && top.gen[0].doubled == 0, "loop generate block select");
    check(top.blk.local_v == 9, "named block");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
