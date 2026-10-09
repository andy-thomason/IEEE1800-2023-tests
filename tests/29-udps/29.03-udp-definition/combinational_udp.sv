/*
:section: 29.4 Combinational UDPs
:summary: A combinational UDP output depends only on current inputs, with unlisted input
  combinations giving x.
*/
primitive majority3 (y, a, b, c);
  output y;
  input a, b, c;
  table
    // a b c : y
    1 1 ? : 1;
    1 ? 1 : 1;
    ? 1 1 : 1;
    0 0 ? : 0;
    0 ? 0 : 0;
    ? 0 0 : 0;
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
    logic a, b, c;
    wire y;
    majority3 m(y, a, b, c);
    initial begin
      for (int i = 0; i < 8; i++) begin
        {a, b, c} = i[2:0];
        #1;
        check(y === ((a & b) | (a & c) | (b & c)), $sformatf("majority of %b%b%b gave %b", a, b, c, y));
      end
      {a, b, c} = 3'b1x1; #1;
      check(y === 1'b1, "? row matched an x input");
      {a, b, c} = 3'b10x; #1;
      check(y === 1'bx, "no row matches 1 0 x, so the output is x");
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
