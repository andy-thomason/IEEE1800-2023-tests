/*
:section: 23.3.3.2 Port connection rules for variables
:summary: An unconnected variable input port holds its type's default value, while an
  unconnected net input floats to z.
*/
module probe(input var int iv, input wire [1:0] nw, output int seen_iv, output logic [1:0] seen_nw);
  assign seen_iv = iv;
  assign seen_nw = nw;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int siv;
  logic [1:0] snw;
  probe u(.iv(), .nw(), .seen_iv(siv), .seen_nw(snw));
  initial begin
    #1;
    check(siv == 0, "unconnected variable input has the type's default");
    check(snw === 2'bzz, "unconnected net input is z");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
