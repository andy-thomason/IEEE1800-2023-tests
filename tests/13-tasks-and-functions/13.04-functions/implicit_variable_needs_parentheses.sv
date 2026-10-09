/*
:section: 13.4.1 Return values and void functions
:summary: Accessing a member of a function call result requires parentheses after the function
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
  class node_c; int member = 1; endclass
  function node_c make();
    make = new;
    make.member = 5;
  endfunction
  initial begin
    check(make().member == 5, "member of a function call result");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
