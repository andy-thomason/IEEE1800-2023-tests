/*
:section: 6.8 Variable declarations
:summary: A type reference may declare a variable after var or a net after a net type keyword.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [5:0] model;
  var type(model) copy;
  wire type(model) net_copy = 6'd9;
  initial begin
    #1;
    check($bits(copy) == 6 && $bits(net_copy) == 6 && net_copy == 9, "type references in var and net declarations");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
