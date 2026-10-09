/*
:section: 25.3.3 Interface example using a generic bundle
:summary: A module header may use a generic interface port that accepts any interface type at
  instantiation.
*/
interface a_if; int v = 1; endinterface
interface b_if; int v = 2; endinterface
module reader(interface port, output int got);
  assign got = port.v * 10;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  a_if ai();
  b_if bi();
  int ga, gb;
  reader ra(.port(ai), .got(ga));
  reader rb(.port(bi), .got(gb));
  initial begin
    #1;
    check(ga == 10 && gb == 20, $sformatf("one generic module bound to two interface types: %0d %0d", ga, gb));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
