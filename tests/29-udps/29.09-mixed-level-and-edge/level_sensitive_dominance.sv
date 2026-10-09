/*
:section: 29.10 Level-sensitive dominance
:summary: When level and edge entries in a UDP table conflict, the level-sensitive entry wins.
*/
primitive dff_set (q, clk, d, set);
  output q;
  reg q;
  input clk, d, set;
  table
    // clk d set : q : q+
    ?   ? 1   : ? : 1;
    r   0 0   : ? : 0;
    r   1 0   : ? : 1;
    r   0 ?   : ? : 0;
    f   ? ?   : ? : -;
    ?   * ?   : ? : -;
    ?   ? f   : ? : -;
  endtable
endprimitive

  module top;
    int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
    logic clk = 0, d = 0, set = 0;
    wire q;
    dff_set f(q, clk, d, set);
    initial begin
      clk = 1; #1;
      check(q === 1'b0, "edge entry loads 0");
      clk = 0; #1;
      set = 1; #1;
      check(q === 1'b1, "level set");
      clk = 1; #1;
      check(q === 1'b1, $sformatf("rising edge with d=0 and set=1: the level entry wins, q=%b", q));
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
