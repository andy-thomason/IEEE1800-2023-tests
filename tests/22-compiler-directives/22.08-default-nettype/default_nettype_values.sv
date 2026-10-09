/*
:section: 22.8 `default_nettype
:summary: `default_nettype selects the net type used for implicit nets, such as tri1 pulling a
  floating net high.
*/
`default_nettype tri1
module pulled(input p);
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  pulled u(.p(floating));
  initial begin
    #1;
    check(floating === 1'b1, $sformatf("implicit tri1 net is %b", floating));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
`default_nettype wire
