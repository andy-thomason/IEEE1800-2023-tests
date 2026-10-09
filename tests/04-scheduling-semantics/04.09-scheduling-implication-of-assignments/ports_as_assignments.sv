/*
:section: 4.9.6 Port connections
:summary: Input, output and inout ports behave like continuous assignments or direct net joins
  across the boundary.
*/
module child(input logic [3:0] in, output logic [3:0] out, inout wire io);
  assign out = in + 4'd1;
  logic drive = 0;
  assign io = drive ? 1'b1 : 1'bz;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 4'd2;
  wire [3:0] b;
  wire shared;
  logic outside_drive = 0;
  assign shared = outside_drive ? 1'b0 : 1'bz;
  child u(.in(a + 4'd1), .out(b), .io(shared));
  initial begin
    #1 check(b == 4'd4, $sformatf("input expression then output: b = %0d", b));
    a = 4'd7;
    #1 check(b == 4'd9, $sformatf("ports did not follow a change: b = %0d", b));
    u.drive = 1;
    #1 check(shared === 1'b1, "inout did not carry the inside driver out");
    outside_drive = 1;
    #1 check(shared === 1'bx && u.io === 1'bx, "inout connection did not resolve both drivers as one net");
    u.drive = 0;
    #1 check(u.io === 1'b0, "inout did not carry the outside driver in");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
