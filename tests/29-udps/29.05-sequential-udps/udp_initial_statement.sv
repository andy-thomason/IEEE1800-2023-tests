/*
:section: 29.7 Sequential UDP initialization
:summary: A sequential UDP output can be given a starting value via an initial statement or port
  declaration.
*/
primitive set_latch (q, s);
  output q;
  reg q;
  input s;
  initial q = 1'b1;
  table
    1 : ? : 1;
    0 : ? : -;
  endtable
endprimitive
primitive start_zero (output reg q = 0, input s);
  table
    1 : ? : 1;
    0 : ? : -;
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
    logic s = 0;
    wire q1, q2;
    set_latch #5 u1(q1, s);
    start_zero u2(q2, s);
    initial begin
      #1;
      check(q1 === 1'b1, $sformatf("initial value not delayed by the instance delay: %b", q1));
      check(q2 === 1'b0, "ANSI output reg initialiser");
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
