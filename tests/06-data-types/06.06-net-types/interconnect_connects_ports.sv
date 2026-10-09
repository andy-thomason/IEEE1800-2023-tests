/*
:section: 6.6.8 Generic interconnect
:summary: Interconnect nets carry no type and may join ports whose bits resolve to different net
  types.
*/
package net_kinds;
  nettype real real_net;
endpackage

module logic_source(output wire logic [3:0] o);
  assign o = 4'd11;
endmodule

module real_source import net_kinds::*; (output real_net o);
  assign o = 3.75;
endmodule

module logic_sink(input wire logic [3:0] i, output int seen);
  assign seen = i;
endmodule

module real_sink import net_kinds::*; (input real_net i, output real seen);
  assign seen = i;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  interconnect [3:0] link_logic;
  interconnect link_real;
  int seen_logic;
  real seen_real;
  logic_source ls(.o(link_logic));
  logic_sink lk(.i(link_logic), .seen(seen_logic));
  real_source rs(.o(link_real));
  real_sink rk(.i(link_real), .seen(seen_real));
  initial begin
    #1;
    check(seen_logic == 11, $sformatf("logic value through an interconnect net = %0d", seen_logic));
    check(seen_real == 3.75, $sformatf("real value through an interconnect net = %f", seen_real));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
