/*
:section: 28.16.1 min:typ:max delays
:summary: Gate delays may use min:typ:max triples for each of rise, fall and turn-off values.
:description: The typical value is the default selection when no tool option picks min or max.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0;
  wire y;
  buf #(1:4:9, 2:5:10) g(y, a);
  initial begin
    #20 a = 1;
    #3 check(y === 1'b0, "not risen at 3");
    #2 check(y === 1'b1, "typical rise delay 4");
    a = 0;
    #4 check(y === 1'b1, "not fallen at 4");
    #2 check(y === 1'b0, "typical fall delay 5");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
