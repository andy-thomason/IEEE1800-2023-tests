/*
:section: 6.20.6 Const constants
:summary: const values may be set from parameters, hierarchical references or runtime values in
  automatic contexts.
*/
module leaf;
  int setting = 17;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  leaf u_leaf();
  parameter int P = 4;
  const int FROM_PARAM = P * 3;
  const int FROM_HIER = top.u_leaf.setting;
  task automatic scaled(input int v, output int r);
    const int K = v + 1;
    r = K * 2;
  endtask
  initial begin
    int r;
    #1;
    check(FROM_PARAM == 12, "const from a parameter");
    check(FROM_HIER == 17, "const from a hierarchical name");
    scaled(4, r);
    check(r == 10, "automatic const from a task argument");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
