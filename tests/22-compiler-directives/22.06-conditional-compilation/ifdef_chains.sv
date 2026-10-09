/*
:section: 22.6 `ifdef, `else, `elsif, `endif, `ifndef
:summary: `ifdef, `elsif, `else and `ifndef nest, and directives hidden inside comments do not
  end a block.
*/
`define SECOND
`define OUTER

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  `ifdef FIRST
    int which = 1;
  `elsif SECOND
    int which = 2;
  `else
    int which = 3;
  `endif
  `ifndef OUTER
    int nested = 0;
  `else
    `ifdef INNER
      int nested = 10;
    `else
      int nested = 11;   // `endif in a comment
    `endif
  `endif
  `ifdef SECOND
    string hidden = "`endif inside a string";
  `endif
  initial begin
    check(which == 2, $sformatf("`elsif chain picked %0d", which));
    check(nested == 11, $sformatf("nested conditional gave %0d", nested));
    check(hidden == "`endif inside a string", "a directive inside a string literal ended the block");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
