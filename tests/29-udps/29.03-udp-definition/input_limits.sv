/*
:section: 29.3.2 UDP port declarations
:summary: Tools must accept combinational UDPs with ten inputs and sequential UDPs with nine
  inputs.
*/
primitive all_ones10 (y, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9);
  output y;
  input a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
  table
    1 1 1 1 1 1 1 1 1 1 : 1;
    0 ? ? ? ? ? ? ? ? ? : 0;
    ? 0 ? ? ? ? ? ? ? ? : 0;
    ? ? ? ? ? ? ? ? ? 0 : 0;
  endtable
endprimitive
primitive latch9 (q, en, d0, d1, d2, d3, d4, d5, d6, d7);
  output q;
  reg q;
  input en, d0, d1, d2, d3, d4, d5, d6, d7;
  table
    1 1 ? ? ? ? ? ? ? : ? : 1;
    1 0 ? ? ? ? ? ? ? : ? : 0;
    0 ? ? ? ? ? ? ? ? : ? : -;
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
    logic [9:0] v = '1;
    logic en = 1, d = 1;
    wire y, q;
    all_ones10 u(y, v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9]);
    latch9 l(q, en, d, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
    initial begin
      #1;
      check(y === 1'b1 && q === 1'b1, "10-input and 9-input UDPs");
      v[9] = 0; en = 0; d = 0; #1;
      check(y === 1'b0 && q === 1'b1, "10th input and latch hold");
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
