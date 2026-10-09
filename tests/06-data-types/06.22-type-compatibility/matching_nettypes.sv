/*
:section: 6.22.6 Matching nettypes
:summary: A nettype alias matches the nettype it renames, so nets can connect across them.
*/
nettype int level_net;
nettype level_net alias_net;

module sink(input level_net in, output int seen);
  assign seen = in;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  alias_net wire_a;
  int seen;
  assign wire_a = 12;
  sink u(.in(wire_a), .seen(seen));
  initial begin
    #1;
    check(seen == 12, "a renamed nettype did not connect to its original");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
