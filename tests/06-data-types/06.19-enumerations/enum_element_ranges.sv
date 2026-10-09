/*
:section: 6.19.2 Enumerated type ranges
:summary: Enum range forms like name[N], name[N:M] and name[N:M] = C generate numbered
  constants.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {start = 4, op[3], slot[2:4] = 20, lane[3:1], tail} gen_t;
  gen_t g;
  initial begin
    check(op0 == 5 && op1 == 6 && op2 == 7, "op[3] values");
    check(slot2 == 20 && slot3 == 21 && slot4 == 22, "slot[2:4] = 20 values");
    check(lane3 == 23 && lane2 == 24 && lane1 == 25, "decreasing lane[3:1]");
    check(tail == 26, "name after a range");
    g = lane2;
    check(g.name() == "lane2", $sformatf("generated name is %s", g.name()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
