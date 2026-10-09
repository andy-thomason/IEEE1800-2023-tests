/*
:section: 27.6 External names for unnamed generate blocks
:summary: If genblk<n> clashes with a declared name, leading zeros are added to the generated
  name.
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
  int genblk2;
  if (1) begin
    int v = 2;
  end
  initial begin
    #1;
    check(genblk02.v == 2, "conflict with a declared genblk2 adds a leading zero");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
