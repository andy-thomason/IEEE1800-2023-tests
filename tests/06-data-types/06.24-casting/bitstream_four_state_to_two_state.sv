/*
:section: 6.24.3 Bit-stream casting
:summary: Bit-stream casting x or z into 2-state fields yields 0, while 4-state fields keep
  them.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { bit [3:0] two; logic [3:0] four; } mixed_t;
  mixed_t m;
  initial begin
    m = mixed_t'(8'b1x0z_1x0z);
    check(m.two === 4'b1000, $sformatf("2-state field = %b, expected x and z as 0", m.two));
    check(m.four === 4'b1x0z, $sformatf("4-state field = %b", m.four));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
