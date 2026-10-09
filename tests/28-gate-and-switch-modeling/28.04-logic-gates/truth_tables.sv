/*
:section: 28.4 and, nand, nor, or, xor, and xnor gates
:summary: Logic gates take the output first then inputs and follow the defined truth tables.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a, b;
  wire y_and, y_nand, y_or, y_nor, y_xor, y_xnor;
  and  g1(y_and, a, b);
  nand g2(y_nand, a, b);
  or   g3(y_or, a, b);
  nor  g4(y_nor, a, b);
  xor  g5(y_xor, a, b);
  xnor g6(y_xnor, a, b);
  logic [3:0] vals = 4'b01xz;
  initial begin
    for (int i = 0; i < 4; i++)
      for (int j = 0; j < 4; j++) begin
        logic ea, eb;
        a = vals[3 - i];
        b = vals[3 - j];
        #1;
        // z inputs behave as x, so the bitwise operators give the expected values
        ea = (a === 1'bz) ? 1'bx : a;
        eb = (b === 1'bz) ? 1'bx : b;
        check(y_and === (ea & eb) && y_nand === ~(ea & eb), $sformatf("and/nand %b %b -> %b %b", a, b, y_and, y_nand));
        check(y_or === (ea | eb) && y_nor === ~(ea | eb), $sformatf("or/nor %b %b -> %b %b", a, b, y_or, y_nor));
        check(y_xor === (ea ^ eb) && y_xnor === ~(ea ^ eb), $sformatf("xor/xnor %b %b -> %b %b", a, b, y_xor, y_xnor));
      end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
