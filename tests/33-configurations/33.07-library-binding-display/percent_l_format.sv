/*
:section: 33.7 Displaying library binding information
:summary: The %l format specifier prints the library.cell binding of the enclosing module
  instance.
:description: The library name is tool-defined (often work); the cell part must be the module name.
*/
module leaf;
  string binding;
  initial binding = $sformatf("%l");
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string b, upper;
  leaf u();
  initial begin
    #1;
    b = u.binding;
    upper = $sformatf("%L");
    check(b.len() > 5 && b.substr(b.len() - 5, b.len() - 1) == ".leaf", $sformatf("%%l in leaf printed '%s'", b));
    check(upper.len() > 4 && upper.substr(upper.len() - 4, upper.len() - 1) == ".top", $sformatf("%%L in top printed '%s'", upper));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
