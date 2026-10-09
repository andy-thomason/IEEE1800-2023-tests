/*
:section: 5.9 String literals
:summary: A backslash immediately before a newline continues the string, dropping both
  characters.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string joined = "front-\
back";
  initial begin
    check(joined == "front-back", $sformatf("joined = \"%s\"", joined));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
