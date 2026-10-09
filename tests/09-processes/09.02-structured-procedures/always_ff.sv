/*
:section: 9.2.2.4 Sequential logic always_ff procedure
:summary: always_ff models clocked logic using a single event control while forbidding blocking
  delays.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0, rst = 1;
  logic [3:0] count;
  always_ff @(posedge clk or posedge rst)
    if (rst) count <= '0;
    else count <= count + 1;
  always #1 clk = ~clk;
  initial begin
    #2 rst = 0;
    #8;
    check(count == 4, $sformatf("count = %0d after four rising edges", count));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
