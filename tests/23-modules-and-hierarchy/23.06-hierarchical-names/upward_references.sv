/*
:section: 23.8 Upwards name referencing
:summary: Lower modules can refer upward to items in enclosing instances by module or instance
  name.
*/
module child;
  int seen_param, seen_var;
  initial #1 begin
    seen_var = parent.level;
    seen_param = top.LIMIT;
  end
endmodule
module parent;
  int level = 42;
  child c();
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int LIMIT = 17;
  parent p();
  initial begin
    #2;
    check(p.c.seen_var == 42, "upward reference by module name");
    check(p.c.seen_param == 17, "upward reference to the top");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
