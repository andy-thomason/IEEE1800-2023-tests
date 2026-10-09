/*
:section: 6.20 Constants
:summary: Instance parameters can be overridden by ordered list, by name, or with defparam.
*/
module pcell;
  parameter int A = 1;
  parameter int B = 2;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  pcell u_default();
  pcell #(10, 20) u_ordered();
  pcell #(.B(7)) u_named();
  pcell u_defparam();
  defparam u_defparam.A = 33;
  initial begin
    check(u_default.A == 1 && u_default.B == 2, "defaults");
    check(u_ordered.A == 10 && u_ordered.B == 20, "ordered list");
    check(u_named.A == 1 && u_named.B == 7, "by name");
    check(u_defparam.A == 33, "defparam");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
