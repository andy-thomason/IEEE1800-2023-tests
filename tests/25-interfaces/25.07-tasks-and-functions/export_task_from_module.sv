/*
:section: 25.7.3 Example of exporting tasks and functions
:summary: A task exported through a modport can be defined in one module and called from
  another.
*/
interface link_if;
  modport server(export task serve(input int x, output int y));
  modport client(import task serve(input int x, output int y));
endinterface
module server_m(link_if.server s);
  task s.serve(input int x, output int y);
    y = x * 3;
  endtask
endmodule
module client_m(link_if.client c, output int got);
  initial c.serve(7, got);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  link_if l();
  int got;
  server_m srv(.s(l));
  client_m cli(.c(l), .got(got));
  initial begin
    #1;
    check(got == 21, $sformatf("exported task result %0d", got));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
