/*
:section: 23.3.3.2 Port connection rules for variables
:summary: A ref port acts as an alias, so writes through it change the connected variable
  directly.
*/
module bumper(ref int shared);
  initial #2 shared = shared + 70;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int s = 7;
  bumper u(.shared(s));
  initial begin
    #1;
    #2;
    check(s == 77, $sformatf("ref port write seen as %0d", s));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
