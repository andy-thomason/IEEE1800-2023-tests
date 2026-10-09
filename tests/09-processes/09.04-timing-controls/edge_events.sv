/*
:section: 9.4.2 Event control
:summary: posedge and negedge detect transitions on the least significant bit, while a plain
  event triggers on any change.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [1:0] v = 2'b00;
  int pos = 0, neg = 0, any = 0, edges = 0;
  always @(posedge v) pos++;
  always @(negedge v) neg++;
  always @(v) any++;
  always @(edge v) edges++;
  initial begin
    #1 v = 2'b10;
    #1 v = 2'b11;
    #1 v = 2'b1x;
    #1 v = 2'b10;
    #1 v = 2'bz0;
    #1;
    check(any == 5, $sformatf("value changes counted %0d", any));
    check(pos == 1, $sformatf("posedge counted %0d (0->1 only; LSB only)", pos));
    check(neg == 2, $sformatf("negedge counted %0d (1->x, x->0)", neg));
    check(edges == 3, $sformatf("edge counted %0d", edges));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
