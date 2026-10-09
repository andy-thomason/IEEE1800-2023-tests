/*
:section: 10.6.2 The force and release procedural statements
:summary: force overrides all other drivers until release, after which the variable or net
  reverts as specified.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] v = 4'd1;
  logic [3:0] forced_src = 4'd8;
  wire [3:0] n = 4'd2;
  initial begin
    force v = forced_src;
    #1 check(v == 8, "force on a variable");
    forced_src = 4'd12;
    #1 check(v == 12, "force follows its source");
    release v;
    #1 check(v == 12, "a released variable changed value immediately");
    v = 4'd3;
    check(v == 3, "procedural assignment after release");
    force n[1:0] = 2'b11;
    #1 check(n == 4'b0011, "force of a part-select of a net");
    release n[1:0];
    #1 check(n == 4'd2, "a released net did not return to its driver");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
