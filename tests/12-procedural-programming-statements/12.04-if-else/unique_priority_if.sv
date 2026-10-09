/*
:section: 12.4.2 unique-if, unique0-if, and priority-if
:summary: unique, unique0 and priority qualifiers on if-else-if chains still select the matching
  branch as usual.
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
  logic [2:0] a;
  initial begin
    a = 3'd5;
    unique if (a == 1) taken = 1; else if (a == 5) taken = 5; else taken = 0;
    check(taken == 5, "unique if");
    priority if (a[2]) taken = 4; else if (a[0]) taken = 1;
    check(taken == 4, "priority if takes the first true condition");
    taken = -1;
    unique0 if (a == 1) taken = 1; else if (a == 2) taken = 2;
    check(taken == -1, "unique0 if with no match executes nothing");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
