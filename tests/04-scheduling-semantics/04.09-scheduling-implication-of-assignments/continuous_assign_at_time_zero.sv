/*
:section: 4.9.1 Continuous assignment
:summary: Continuous assignments, including implicit ones from port connections, are evaluated
  at time zero.
*/
module pass_through(input logic [3:0] in, output logic [3:0] out);
  assign out = in;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  localparam logic [3:0] K = 4'd11;
  wire [3:0] from_constant;
  wire [3:0] declared = 4'd9;
  wire [3:0] through_port;
  assign from_constant = K;
  pass_through u(.in(4'd6), .out(through_port));
  initial begin
    #1;
    check(from_constant === 4'd11, $sformatf("constant assignment = %b", from_constant));
    check(declared === 4'd9, $sformatf("net declaration assignment = %b", declared));
    check(through_port === 4'd6, $sformatf("constant through a port = %b", through_port));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
