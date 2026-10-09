/*
:section: 25.5 Modports
:summary: A modport named in the module header limits and sets directions for interface access.
*/
interface hs_if;
  logic req, ack;
  modport producer(output req, input ack);
  modport consumer(input req, output ack);
endinterface
module prod(hs_if.producer p);
  initial p.req = 1;
endmodule
module cons(hs_if.consumer c);
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
  prod p(.p(link));
  cons c(.c(link));
  initial begin
    #1;
    check(link.ack === 1'b1, "handshake through modports");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
