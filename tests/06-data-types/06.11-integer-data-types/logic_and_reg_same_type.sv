/*
:section: 6.11.2 2-state (two-value) and 4-state (four-value) data types
:summary: logic and reg name the same data type.
:description: Uses the type operator (6.23) to compare the two types.
*/
module top;
  localparam bit SAME = type(logic [3:0]) == type(reg [3:0]);
  initial begin
    if (!SAME) $display("FAIL: logic [3:0] and reg [3:0] are different types");
    else $display("PASS");
    $finish;
  end
endmodule
