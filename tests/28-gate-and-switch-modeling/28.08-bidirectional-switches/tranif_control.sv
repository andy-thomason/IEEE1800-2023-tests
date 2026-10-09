/*
:section: 28.8 Bidirectional pass switches
:summary: tranif switches pass signals when on and block when off; control may be 2-state or
  4-state.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 1;
  bit c2 = 1;
  logic c4 = 0;
  wire src, on1, on0;
  assign src = d;
  tranif1 t1(src, on1, c2);
  tranif0 t0(src, on0, c4);
  initial begin
    #1;
    check(on1 === 1'b1 && on0 === 1'b1, "both switches on");
    c2 = 0; c4 = 1;
    #1;
    check(on1 === 1'bz && on0 === 1'bz, "both switches off");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
