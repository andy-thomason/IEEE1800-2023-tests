/*
:section: H.12.2 Array querying functions
:summary: DPI open-array query functions follow $dimensions-style semantics, with dimension 0
  meaning the packed part.
:dpi: array_querying_functions.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function void query(input bit [3:0] a [][], output int r [8]);
  bit [3:0] a [2:5][1:0];
  int r [8];
  initial begin
    query(a, r);
    check(r[0] == 2, $sformatf("svDimensions = %0d", r[0]));
    check(r[1] == 2 && r[2] == 5 && r[3] == 2 && r[4] == 5, $sformatf("dim 1 left/right/low/high %0d %0d %0d %0d", r[1], r[2], r[3], r[4]));
    check(r[5] == -1, $sformatf("svIncrement for [2:5] = %0d", r[5]));
    check(r[6] == 2, $sformatf("svSize of dim 2 = %0d", r[6]));
    check(r[7] == 4, $sformatf("svSize of the packed part = %0d", r[7]));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
