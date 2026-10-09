/*
:section: 12.5.1 Case statement with do-not-cares
:summary: casez ignores z and ? bits, while casex also ignores x bits, in both the selector and
  items.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int taken;
  logic [3:0] ir;
  initial begin
    ir = 4'b1011;
    casez (ir)
      4'b0???: taken = 1;
      4'b1?1?: taken = 2;
      default: taken = 0;
    endcase
    check(taken == 2, "casez with ? in an item");
    ir = 4'b1z00;
    casez (ir)
      4'b1100: taken = 3;
      default: taken = 0;
    endcase
    check(taken == 3, "z in the case expression is a do-not-care for casez");
    ir = 4'b1x00;
    casez (ir) 4'b1100: taken = 4; default: taken = 0; endcase
    check(taken == 0, "x is not a do-not-care for casez");
    casex (ir) 4'b1100: taken = 5; default: taken = 0; endcase
    check(taken == 5, "x is a do-not-care for casex");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
