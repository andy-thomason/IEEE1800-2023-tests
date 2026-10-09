/*
:section: 3.12.1 Compilation units
:summary: The $unit:: prefix selects an outermost compilation-unit declaration even when a local
  name hides it.
*/
int depth = 7;

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int depth = 70;
  function automatic int sum_depths();
    int depth = 700;
    return depth + $unit::depth;
  endfunction
  initial begin
    check(sum_depths() == 707, $sformatf("local + $unit::depth = %0d", sum_depths()));
    check($unit::depth == 7, $sformatf("$unit::depth = %0d", $unit::depth));
    check(depth == 70, $sformatf("module depth = %0d", depth));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
