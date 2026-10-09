/*
:section: 22.6 `ifdef, `else, `elsif, `endif, `ifndef
:summary: `ifdef and `ifndef accept parenthesized macro expressions using &&, ||, -> and <->
  operators.
:description: Expressions in `ifdef are new in IEEE 1800-2023.
*/
`define HAS_A
`define HAS_B

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  `ifdef (HAS_A && HAS_B) int and_ok = 1; `else int and_ok = 0; `endif
  `ifdef (HAS_C || HAS_B) int or_ok = 1; `else int or_ok = 0; `endif
  `ifndef (HAS_A && HAS_C) int not_ok = 1; `else int not_ok = 0; `endif
  `ifdef (HAS_C -> HAS_D) int imp_ok = 1; `else int imp_ok = 0; `endif
  initial begin
    check(and_ok == 1 && or_ok == 1 && not_ok == 1 && imp_ok == 1, "ifdef macro expressions");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
