/*
:section: 29.6 Edge-sensitive sequential UDPs
:summary: An edge-sensitive UDP updates only on listed transitions, and unlisted input edges
  drive the output to x.
*/
primitive toggle_ff (q, clk, rst);
  output q;
  reg q;
  input clk, rst;
  table
    // clk rst : q : q+
    ?   1   : ? : 0;
    r   0   : 0 : 1;
    r   0   : 1 : 0;
    f   0   : ? : -;
    ?   f   : ? : -;
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
    logic clk = 0, rst = 1;
    wire q;
    toggle_ff t(q, clk, rst);
    initial begin
      #1;
      check(q === 1'b0, "level reset");
      rst = 0; #1;
      check(q === 1'b0, "reset release is specified as no change");
      clk = 1; #1;
      check(q === 1'b1, "first rising edge");
      clk = 0; #1;
      check(q === 1'b1, "falling edge is no change");
      clk = 1; #1;
      check(q === 1'b0, "second rising edge");
      clk = 1'bx; #1;
      check(q === 1'bx, "unspecified transition 1->x gives x");
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
