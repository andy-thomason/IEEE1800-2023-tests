/*
:section: 28.10 pullup and pulldown sources
:summary: pullup drives 1 and pulldown drives 0, at pull strength unless a strength is given.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire p_default, d_default, p_strong, d_supply, p_ignored, a, b;
  pullup u1(p_default);
  pulldown u2(d_default);
  pullup (strong1) u3(p_strong);
  pulldown (supply0) u4(d_supply);
  pullup (strong0, weak1) u5(p_ignored);
  pullup u6(a, b);
  initial begin
    #1;
    check($sformatf("%v", p_default) == "Pu1" && $sformatf("%v", d_default) == "Pu0", $sformatf("defaults %v %v", p_default, d_default));
    check($sformatf("%v", p_strong) == "St1" && $sformatf("%v", d_supply) == "Su0", $sformatf("specified %v %v", p_strong, d_supply));
    check($sformatf("%v", p_ignored) == "We1", $sformatf("strength0 on a pullup is ignored: %v", p_ignored));
    check(a === 1'b1 && b === 1'b1, "a pullup with two terminals drives both");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
