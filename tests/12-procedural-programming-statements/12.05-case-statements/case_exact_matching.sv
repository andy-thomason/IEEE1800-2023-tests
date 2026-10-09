/*
:section: 12.5 Case statement
:summary: A case expression is evaluated once and items are compared in order using exact
  four-state matching.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int evals = 0, taken;
  logic [3:0] sel;
  function automatic logic [3:0] get(); evals++; return sel; endfunction
  initial begin
    sel = 4'b10x1;
    case (get())
      4'b1001: taken = 1;
      4'b10x1: taken = 2;
      4'b10?1: taken = 3;
      default: taken = 0;
    endcase
    check(taken == 2 && evals == 1, "exact x match, expression evaluated once");
    sel = 4'b0011;
    case (sel)
      2'b11: taken = 7;
      default: taken = 0;
    endcase
    check(taken == 7, "case items are extended to a common length");
    case (sel)
      4'd1, 4'd3, 4'd5: taken = 8;
      default: taken = 0;
    endcase
    check(taken == 8, "a list of case item expressions");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
