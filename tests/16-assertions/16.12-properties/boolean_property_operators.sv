/*
:section: 16.12.3 Negation property
:summary: Property operators not, or, and, and if-else combine property results as logical
  negation, disjunction, conjunction and choice.
:description: c stays 1 past the end of the checked cycles so the else branch only fails at cycle 5.
:flags-verilator: --coverage-user
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  timeunit 1ns; timeprecision 1ns;
  logic clk = 0;
  always #5 clk = ~clk;
  logic a = 0;
  string w_a = "0101000000";
  logic b = 0;
  string w_b = "0010010000";
  logic c = 0;
  string w_c = "1111101111111";
  initial begin
    for (int i = 0; i <= 13; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      c = (i < w_c.len()) && (w_c[i] == "1");
    end
  end
  int f_not = 0, f_and = 0, f_or = 0, f_if = 0;
  a1: assert property (@(posedge clk) not (a ##1 b)) else f_not++;
  a2: assert property (@(posedge clk) (a |-> c) and (b |-> c)) else f_and++;
  a3: assert property (@(posedge clk) (a |-> c) or (b |-> c)) else f_or++;
  a4: assert property (@(posedge clk) if (a) ##1 b else c) else f_if++;
  initial begin
    #132;
    check(f_not == 1, $sformatf("not: %0d", f_not));
    check(f_and == 1, $sformatf("and: %0d", f_and));
    check(f_or == 0, $sformatf("or: %0d", f_or));
    check(f_if == 2, $sformatf("if-else: %0d", f_if));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
