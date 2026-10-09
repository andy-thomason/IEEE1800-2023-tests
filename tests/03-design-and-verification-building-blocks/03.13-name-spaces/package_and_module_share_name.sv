/*
:section: 3.13 Name spaces
:summary: A package and a module may have identical names because they live in separate name
  spaces.
:description: Packages and modules live in different global name spaces, so they may share a name.
*/
package meter;
  function automatic int reading();
    return 17;
  endfunction
endpackage

module meter(output int value);
  assign value = 23;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int from_module;
  meter u_meter(.value(from_module));
  initial begin
    #1;
    check(meter::reading() == 17, $sformatf("meter::reading() = %0d", meter::reading()));
    check(from_module == 23, $sformatf("module meter output = %0d", from_module));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
