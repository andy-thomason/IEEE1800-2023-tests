/*
:section: 28.6 bufif1, bufif0, notif1, and notif0 gates
:summary: Three-state gates connect output, data, control in order and follow their truth
  tables, including z.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d, c;
  wire y1, y0, n1, n0;
  bufif1 g1(y1, d, c);
  bufif0 g2(y0, d, c);
  notif1 g3(n1, d, c);
  notif0 g4(n0, d, c);
  initial begin
    d = 1; c = 1; #1;
    check(y1 === 1 && y0 === 1'bz && n1 === 0 && n0 === 1'bz, "control 1");
    c = 0; #1;
    check(y1 === 1'bz && y0 === 1 && n1 === 1'bz && n0 === 0, "control 0");
    d = 1'bz; c = 1; #1;
    check(y1 === 1'bx && n1 === 1'bx, "z data with the gate on gives x");
    d = 0; c = 1'bx; #1;
    check(y1 === 1'bx && n1 === 1'bx, $sformatf("unknown control gives L/H which reads as x: %b %b", y1, n1));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
