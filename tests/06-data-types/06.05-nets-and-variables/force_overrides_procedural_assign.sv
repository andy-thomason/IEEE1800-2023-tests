/*
:section: 6.5 Nets and variables
:summary: A force overrides a procedural assign, which overrides ordinary assignments; release
  restores the resolved value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] v;
  logic [3:0] from_assign = 4'd5, from_force = 4'd9;
  wire [3:0] n = 4'd3;
  initial begin
    v = 4'd1;
    assign v = from_assign;
    #1 check(v == 5, "procedural assign did not override the normal assignment");
    v = 4'd2;
    #1 check(v == 5, "a normal assignment overrode the procedural assign");
    force v = from_force;
    #1 check(v == 9, "force did not override the procedural assign");
    release v;
    #1 check(v == 5, "after release the procedural assign did not resume");
    force n = 4'd12;
    #1 check(n == 12, "force did not override the net");
    release n;
    #1 check(n == 3, "after release the net did not return to its driven value");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
