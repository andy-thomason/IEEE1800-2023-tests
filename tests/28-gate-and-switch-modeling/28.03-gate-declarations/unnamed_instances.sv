/*
:section: 28.3.4 The primitive instance identifier
:summary: Gate and switch instances may be declared without an instance name.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 1, b = 0;
  wire o1, o2;
  xor (o1, a, b);
  not (o2, a);
  initial begin
    #1;
    check(o1 === 1'b1 && o2 === 1'b0, "unnamed gate instances");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
