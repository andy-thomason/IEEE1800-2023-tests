/*
:section: 29.3.1 UDP header
:summary: A UDP may use an ANSI-style header and be defined after it is instantiated.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0, b = 1;
  wire y;
  nand_udp g(y, a, b);
  initial begin
    #1;
    check(y === 1'b1, "0 nand 1");
    a = 1; #1;
    check(y === 1'b0, "1 nand 1");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

primitive nand_udp (output y, input a, input b);
  table
    0 ? : 1;
    ? 0 : 1;
    1 1 : 0;
  endtable
endprimitive
