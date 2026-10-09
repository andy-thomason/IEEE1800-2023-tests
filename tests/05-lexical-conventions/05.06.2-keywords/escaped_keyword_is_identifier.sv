/*
:section: 5.6.2 Keywords
:summary: A keyword written with a leading backslash is treated as an ordinary identifier.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int \while = 3;
  logic [3:0] \module = 4'd9;
  int \begin = 2;
  initial begin
    check(\while * \begin == 6, "escaped keywords used as variables");
    check(\module == 9, "escaped keyword used as a variable");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
