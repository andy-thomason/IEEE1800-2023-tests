/*
:section: 23.10.3 Parameter dependence
:summary: Overriding a parameter that another default depends on also changes the dependent
  parameter value.
*/
module mem #(parameter int WIDTH = 8, parameter int BYTES = WIDTH / 8);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mem u_default();
  mem #(.WIDTH(32)) u_wide();
  mem #(.WIDTH(32), .BYTES(1)) u_both();
  initial begin
    #1;
    check(u_default.BYTES == 1 && u_wide.BYTES == 4 && u_both.BYTES == 1, "dependent parameter follows the override");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
