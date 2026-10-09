/*
:section: 29.3.5 z values in UDP
:summary: A z driven onto a UDP input is handled exactly like an x when matching table rows.
*/
primitive pick_x (y, a);
  output y;
  input a;
  table
    0 : 0;
    1 : 0;
    x : 1;
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
    logic a;
    wire y;
    pick_x p(y, a);
    initial begin
      a = 1'bz; #1;
      check(y === 1'b1, $sformatf("z input matched the x row: %b", y));
      a = 0; #1;
      check(y === 1'b0, "0 row");
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
