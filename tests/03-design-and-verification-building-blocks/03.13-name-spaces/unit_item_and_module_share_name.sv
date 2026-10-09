/*
:section: 3.13 Name spaces
:summary: A compilation-unit function and a module may share a name since they occupy different
  name spaces.
:description: A compilation-unit function and a module are in different name spaces, so they may
  share a name.
*/
function automatic int halve(int v);
  return v / 2;
endfunction

module halve(output int value);
  assign value = 99;
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
  halve u_halve(.value(from_module));
  initial begin
    #1;
    check(halve(84) == 42, $sformatf("function halve(84) = %0d", halve(84)));
    check(from_module == 99, $sformatf("module halve output = %0d", from_module));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
