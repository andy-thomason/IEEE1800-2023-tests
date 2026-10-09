/*
:section: 9.3.4 Block names
:summary: Named begin and fork blocks create a scope, and an optional matching name may follow
  the block end.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int result = 0;
  initial begin
    begin : outer_blk
      int local_v = 4;
      fork : par_blk
        result = local_v * 2;
      join : par_blk
    end : outer_blk
    check(result == 8 && top.outer_blk.local_v == 4, "named blocks and hierarchical access");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
