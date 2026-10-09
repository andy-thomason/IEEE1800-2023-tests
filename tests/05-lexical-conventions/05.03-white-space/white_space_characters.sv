/*
:section: 5.3 White space
:summary: Spaces, tabs and newlines between tokens are ignored, though blanks inside string
  literals are kept.
:description: The file contains literal tab and form-feed characters as token separators and inside
  a string.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int	first=	9;
  int second =	 4;
  string gap = "a	 	b";
  initial begin
    check(first == 9, $sformatf("first = %0d", first));
    check(second == 4, $sformatf("second = %0d", second));
    check(gap.len() == 5, $sformatf("string with a tab, space and tab has length %0d, expected 5", gap.len()));
    check(gap[1] == 8'h09 && gap[2] == 8'h20 && gap[3] == 8'h09, "tab and space inside a string were not kept");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
