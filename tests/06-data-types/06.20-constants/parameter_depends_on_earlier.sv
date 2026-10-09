/*
:section: 6.20.1 Parameter declaration syntax
:summary: Parameters may depend on earlier ones, and the parameter keyword is optional in port
  lists.
*/
module sized #(int W = 3, D = W + 2, type E = byte, E INIT = 7);
  E store = INIT;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  sized u_default();
  sized #(.W(10)) u_wide();
  sized #(.E(shortint), .INIT(-300)) u_typed();
  initial begin
    #1;
    check(u_default.D == 5, "D from the default W");
    check(u_wide.D == 12, "D follows an overridden W");
    check($bits(u_default.store) == 8 && u_default.store == 7, "default type and value");
    check($bits(u_typed.store) == 16 && u_typed.store == -300, "overridden type and value");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
