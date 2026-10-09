/*
:section: 22.5.1 `define
:summary: Macro text supports backslash line continuation, `" stringification, escaped quotes,
  `` token pasting and empty bodies.
*/
`define MULTI (1 + \
               2 + \
               3)
`define STR(x) `"x`"
`define QUOTED(x) `"say `\`"x`\`"`"
`define CAT(a, b) a``b
`define EMPTY

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask

  int `CAT(var, _seven) = 7;
  initial begin
    check(`MULTI == 6, "multi-line macro");
    check(`STR(abc) == "abc", "`\" stringification");
    check(`QUOTED(z) == "say \"z\"", "`\\`\" inside a stringified macro");
    check(var_seven == 7, "`` token pasting");
    check(`EMPTY 3 == 3, "empty macro");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
