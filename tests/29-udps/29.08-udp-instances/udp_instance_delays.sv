/*
:section: 29.8 UDP instances
:summary: A UDP instantiation may include a delay specification that postpones output changes.
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
    logic a = 0, b = 0, c = 0;
    wire yd;
    majority3 #(3, 6) slow(yd, a, b, c);
    initial begin
      #10;
      a = 1; b = 1;
      #2 check(yd === 1'b0, "rise delay 3 not elapsed");
      #2 check(yd === 1'b1, "rise delay 3");
      a = 0;
      #5 check(yd === 1'b1, "fall delay 6 not elapsed");
      #2 check(yd === 1'b0, "fall delay 6");
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
