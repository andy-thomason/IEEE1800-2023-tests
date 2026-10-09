/*
:section: 25.5 Modports
:summary: A modport may be chosen at the module instance connection instead of in the module
  header.
*/
interface hs_if;
  logic req, ack;
  modport producer(output req, input ack);
  modport consumer(input req, output ack);
endinterface
module prod(hs_if p);
  initial p.req = 1;
endmodule
module cons(hs_if c);
  assign c.ack = c.req;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  hs_if link();
  prod p(.p(link.producer));
  cons c(.c(link.consumer));
  initial begin
    #1;
    check(link.ack === 1'b1, "modports chosen at the instance");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
