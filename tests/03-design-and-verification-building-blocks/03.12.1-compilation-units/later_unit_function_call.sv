/*
:section: 3.12.1 Compilation units
:summary: Functions and tasks in the compilation unit may be called before they are declared.
:description: Task and function names are the exception: calling one defined later is legal.
*/
function automatic int outer_value();
  return inner_value() + 1;
endfunction

task automatic bump(inout int v);
  v = v + step_size();
endtask

function automatic int inner_value();
  return 41;
endfunction

function automatic int step_size();
  return 5;
endfunction

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int n = 10;
  initial begin
    check(outer_value() == 42, $sformatf("outer_value() = %0d", outer_value()));
    bump(n);
    check(n == 15, $sformatf("after bump n = %0d", n));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
