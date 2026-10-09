/*
:section: 6.6.6 Supply nets
:summary: supply0 and supply1 nets hold supply strength, so weaker continuous drivers cannot
  change their values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  supply0 gnd;
  supply1 vdd;
  assign vdd = 1'b0;
  assign gnd = 1'b1;
  initial begin
    #1;
    check(vdd === 1'b1 && gnd === 1'b0, "a strong driver overrode a supply net");
    check($sformatf("%v", vdd) == "Su1" && $sformatf("%v", gnd) == "Su0", $sformatf("strengths are %v and %v", vdd, gnd));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
