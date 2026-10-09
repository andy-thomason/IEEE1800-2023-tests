/*
:section: 28.8 Bidirectional pass switches
:summary: For tranif delays, the first value is turn-on and the second is turn-off; one covers
  both.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic c = 0;
  wire src, out;
  assign src = 1'b1;
  tranif1 #(3, 6) t(src, out, c);
  initial begin
    #10 c = 1;
    #2 check(out === 1'bz, "not on before 3");
    #2 check(out === 1'b1, "turn-on delay 3");
    c = 0;
    #5 check(out === 1'b1, "not off before 6");
    #2 check(out === 1'bz, "turn-off delay 6");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
