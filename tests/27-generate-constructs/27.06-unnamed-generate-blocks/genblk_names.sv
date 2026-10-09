/*
:section: 27.6 External names for unnamed generate blocks
:summary: Unnamed generate blocks are named genblk<n>, n being the generate construct's textual
  position in its scope.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  if (1) begin
    int v = 1;
  end
  if (1) begin
    int v = 2;
  end
  for (genvar g = 0; g < 1; g++) begin : named
    if (1) begin
      int v = 30;
    end
  end
  if (1) begin
    int v = 4;
  end
  initial begin
    #1;
    check(genblk1.v == 1 && genblk2.v == 2, "constructs numbered in textual order");
    check(named[0].genblk1.v == 30, "numbering restarts inside a named block");
    check(genblk4.v == 4, "the named construct still took number 3");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
