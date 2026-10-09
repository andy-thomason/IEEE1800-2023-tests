/*
:section: 6.6.4.1 Capacitive networks
:summary: Connected trireg nets share charge, with larger capacitance dominating and equal sizes
  giving x.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic en_la = 1, en_sm = 1, en_m1 = 1, en_m2 = 1, link = 0;
  trireg (large) la;
  trireg (small) sm;
  trireg (medium) m1, m2;
  bufif1 d1(la, 1'b0, en_la);
  bufif1 d2(sm, 1'b1, en_sm);
  bufif1 d3(m1, 1'b0, en_m1);
  bufif1 d4(m2, 1'b1, en_m2);
  tranif1 t1(la, sm, link);
  tranif1 t2(m1, m2, link);
  initial begin
    #1 {en_la, en_sm, en_m1, en_m2} = 4'b0000;
    #1 check(la === 1'b0 && sm === 1'b1 && m1 === 1'b0 && m2 === 1'b1, "stored values before connecting");
    link = 1;
    #1;
    check(sm === 1'b0 && la === 1'b0, $sformatf("large 0 and small 1 joined gave la=%b sm=%b, expected 0", la, sm));
    check(m1 === 1'bx && m2 === 1'bx, $sformatf("equal sizes with different values gave %b %b, expected x", m1, m2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
