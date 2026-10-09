/*
:section: 12.5.3 unique-case, unique0-case, and priority-case
:summary: unique, unique0 and priority case statements execute the first matching item.
:description: Only behaviour is checked; violation reports are tool-specific messages.
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
  logic [1:0] s;
  initial begin
    s = 2'd2;
    unique case (s) 2'd0: taken = 0; 2'd2: taken = 2; default: taken = -1; endcase
    check(taken == 2, "unique case");
    priority casez (s) 2'b1?: taken = 10; 2'b?0: taken = 20; endcase
    check(taken == 10, "priority case takes the first match");
    taken = -5;
    unique0 case (s) 2'd0: taken = 0; 2'd1: taken = 1; endcase
    check(taken == -5, "unique0 case with no match");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
