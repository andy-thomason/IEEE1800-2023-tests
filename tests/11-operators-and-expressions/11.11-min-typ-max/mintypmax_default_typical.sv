/*
:section: 11.11 Minimum, typical, and maximum delay expressions
:summary: A min:typ:max delay expression uses the typical value by default.
:description: Tools usually select min or max with a command-line option; the default is typical.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 0;
  wire q;
  assign #(1:4:9) q = d;
  initial begin
    #10 d = 1;
    #3 check(q === 1'b0, "the minimum delay was used");
    #1 check(q === 1'b1, "the typical delay (4) was not used");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
