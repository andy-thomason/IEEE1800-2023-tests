/*
:section: 28.15.1 tri0 and tri1 net strengths
:summary: An undriven tri0 reads 0 and tri1 reads 1, while supply nets have supply strength.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  tri0 t0;
  tri1 t1, t1_driven;
  supply0 s0;
  supply1 s1;
  assign (weak1, weak0) t1_driven = 1'b0;
  initial begin
    #1;
    check($sformatf("%v", t0) == "Pu0" && $sformatf("%v", t1) == "Pu1", $sformatf("undriven %v %v", t0, t1));
    check($sformatf("%v", s0) == "Su0" && $sformatf("%v", s1) == "Su1", $sformatf("supplies %v %v", s0, s1));
    check($sformatf("%v", t1_driven) == "Pu1", $sformatf("weak driver loses to tri1's pull: %v", t1_driven));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
