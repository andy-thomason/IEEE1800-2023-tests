/*
:section: 22.12 `line
:summary: `line changes the reported file name and line number, which `__FILE__ and `__LINE__
  then reflect.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string here_file;
  int here_line, next_line;
  initial begin
    here_line = `__LINE__;
    next_line = `__LINE__;
    check(next_line == here_line + 1 && here_line > 0, $sformatf("`__LINE__ gave %0d then %0d", here_line, next_line));
`line 100 "renamed.sv" 0
    here_line = `__LINE__;
    here_file = `__FILE__;
    check(here_line == 100, $sformatf("`__LINE__ after `line = %0d", here_line));
    check(here_file == "renamed.sv", $sformatf("`__FILE__ after `line = %s", here_file));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
