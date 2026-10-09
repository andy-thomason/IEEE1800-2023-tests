/*
:section: 10.7 Assignment extension and truncation
:summary: Assignments zero-extend or sign-extend narrower values and truncate wider values to
  the target width.
:flags-verilator: -Wno-WIDTH
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] wide;
  logic [3:0] narrow;
  logic signed [3:0] snarrow;
  logic signed [5:0] neg = -6'sd12;
  initial begin
    wide = 4'b1010;          check(wide == 8'h0A, "unsigned zero-extension");
    wide = 4'sb1010;         check(wide == 8'hFA, "signed sign-extension");
    narrow = 8'hA5;          check(narrow == 4'h5, "truncation of MSBs");
    snarrow = neg;           check(snarrow == 4'sd4, $sformatf("-12 truncated to 4 bits gave %0d, expected +4", snarrow));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
