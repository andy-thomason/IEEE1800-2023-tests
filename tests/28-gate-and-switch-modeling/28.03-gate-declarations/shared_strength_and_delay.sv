/*
:section: 28.3 Gate and switch declaration syntax
:summary: Gates declared together in one comma-separated list share the same strength and delay.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0, b = 1, c = 1;
  wire o1, o2;
  nand (weak1, weak0) #3 g1(o1, a, b), g2(o2, a, c);
  initial begin
    #2;
    check(o1 === 1'bx && o2 === 1'bx, "both instances still delayed at time 2");
    #2;
    check($sformatf("%v", o1) == "We1" && $sformatf("%v", o2) == "We1", $sformatf("both instances %v %v", o1, o2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
