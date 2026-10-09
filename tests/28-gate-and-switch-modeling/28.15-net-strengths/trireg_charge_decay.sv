/*
:section: 28.16.2.1 Charge decay process
:summary: A trireg holding charge decays to x once its configured charge decay time expires.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 1, g = 1;
  trireg (large) #(0, 0, 20) cap;
  nmos n(cap, d, g);
  initial begin
    #10 g = 0;
    #19 check(cap === 1'b1, "charge held before the decay time");
    #2 check(cap === 1'bx, "decayed to x after 20");
    g = 1; d = 0;
    #1 g = 0;
    #10 g = 1;
    #1 g = 0;
    #15 check(cap === 1'b0, "re-driving restarted the decay; still 0 at 15 after the last turn-off");
    #6 check(cap === 1'bx, "decayed again");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
