/*
:section: 6.20.4 Local parameters (localparam)
:summary: In packages, classes and generate blocks, a parameter declaration behaves as a
  localparam.
*/
package limits;
  parameter int MAX = 12;
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class holder;
    parameter int SIZE = 4;
  endclass
  if (1) begin : gen
    parameter int G = 3;
  end
  initial begin
    check(limits::MAX == 12, "parameter in a package");
    check(gen.G == 3, "parameter in a generate block");
    check(holder::SIZE == 4, "parameter in a class");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
