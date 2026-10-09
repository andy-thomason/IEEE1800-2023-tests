/*
:section: 11.4.3.1 Arithmetic expressions with unsigned and signed types
:summary: Values stored into signed or unsigned nets and variables are interpreted using that
  target's signedness.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic signed [7:0] s;
  logic        [7:0] u;
  logic signed [15:0] s16;
  wire         [7:0] un_net;
  wire signed  [7:0] sn_net;
  assign un_net = s;
  assign sn_net = u;
  initial begin
    s = -3;
    check(s === 8'b1111_1101, $sformatf("-3 in 8-bit signed is %b, expected two's complement", s));
    u = s;
    check(u === s, "signed to unsigned changed the bits");
    check(u == 8'd253, $sformatf("unsigned view of -3 is %0d, expected 253", u));
    u = 8'd200;
    s = u;
    check(s === u, "unsigned to signed changed the bits");
    check(s == -56, $sformatf("signed view of 200 is %0d, expected -56", s));
    s16 = -1;
    check(s16 === 16'hFFFF, $sformatf("-1 in 16-bit signed is %h", s16));
    s = -3;
    #1;
    check(un_net === 8'b1111_1101 && un_net == 8'd253, $sformatf("unsigned net driven by -3 is %0d", un_net));
    check(sn_net === u && sn_net == -56, $sformatf("signed net driven by 200 is %0d", sn_net));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
