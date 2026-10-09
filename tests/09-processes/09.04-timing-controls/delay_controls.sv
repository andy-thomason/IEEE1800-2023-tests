/*
:section: 9.4.1 Delay control
:summary: A delay control postpones the next statement, treating x or z delays as zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  integer xd = 'x;
  logic [3:0] dv = 4'd3;
  initial begin
    #(dv + 1);
    check($time == 4, "expression delay");
    #xd;
    check($time == 4, "x delay is not zero");
    #((2 + 4) / 2);
    check($time == 7, "parenthesised delay");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
