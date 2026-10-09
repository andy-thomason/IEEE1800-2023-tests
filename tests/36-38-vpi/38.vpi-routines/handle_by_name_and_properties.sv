/*
:section: 38.21 vpi_handle_by_name()
:summary: vpi_handle_by_name finds objects from the top level, and vpi_get and vpi_get_str
  report their properties.
:vpi: handle_by_name_and_properties.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [11:0] bus;
  sub u();
  int size, is_reg, ok_name, ok_def;
  initial begin
    $t_probe(size, is_reg, ok_name, ok_def);
    check(size == 12, $sformatf("vpiSize of top.bus = %0d", size));
    check(is_reg == 1, "top.bus is a variable (vpiReg or vpiLogicVar)");
    check(ok_name == 1, "vpiName and vpiFullName of top.u.inner");
    check(ok_def == 1, "vpiDefName of the instance top.u");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

module sub;
  int inner;
endmodule
