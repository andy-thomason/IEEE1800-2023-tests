/*
:section: 22.5.1 `define
:summary: Within a macro body, the triple quote form `""" produces a triple-quoted string with
  argument substitution.
:description: `""" in macros is new in IEEE 1800-2023.
*/
`define TQ(x) `"""a "x" b`"""

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask

  initial begin
    check(`TQ(go) == "a \"go\" b", $sformatf("got %s", `TQ(go)));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
