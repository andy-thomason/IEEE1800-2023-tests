/*
:section: 28.12.1 Combined signals of unambiguous strength
:summary: The stronger driver wins, like values keep the higher strength, equal opposite values
  give x.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire w_dom, w_like, w_conflict, w_weak_conflict;
  assign (pull1, pull0) w_dom = 1'b1;
  assign (strong1, strong0) w_dom = 1'b0;
  assign (weak1, weak0) w_like = 1'b1;
  assign (pull1, pull0) w_like = 1'b1;
  assign w_conflict = 1'b1;
  assign w_conflict = 1'b0;
  assign (weak1, weak0) w_weak_conflict = 1'b1;
  assign (weak1, weak0) w_weak_conflict = 1'b0;
  initial begin
    #1;
    check($sformatf("%v", w_dom) == "St0", $sformatf("strong0 beats pull1: %v", w_dom));
    check($sformatf("%v", w_like) == "Pu1", $sformatf("like values keep the greater strength: %v", w_like));
    check($sformatf("%v", w_conflict) == "StX", $sformatf("equal strong conflict: %v", w_conflict));
    check($sformatf("%v", w_weak_conflict) == "WeX", $sformatf("equal weak conflict: %v", w_weak_conflict));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
