/*
:section: 29.5 Level-sensitive sequential UDPs
:summary: A level-sensitive UDP uses a reg output with a current-state column, and - holds the
  previous value.
*/
primitive hold_cell (out, load, val, clr);
  output out;
  reg out;
  input load, val, clr;
  table
    // load val clr : out : out+
       ?    ?   1   :  ?  :  0;
       1    1   0   :  ?  :  1;
       1    0   0   :  ?  :  0;
       0    ?   0   :  ?  :  -;
  endtable
endprimitive

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic load, val, clr;
  wire out;
  hold_cell h(out, load, val, clr);
  initial begin
    clr = 0; load = 1; val = 1; #1;
    check(out === 1'b1, "transparent while load is high");
    load = 0; val = 0; #1;
    check(out === 1'b1, "holds while load is low");
    clr = 1; #1;
    check(out === 1'b0, "clear overrides the held state");
    clr = 0; #1;
    check(out === 1'b0, "holds the cleared value");
    load = 1; val = 1; #1;
    check(out === 1'b1, "reloads");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
