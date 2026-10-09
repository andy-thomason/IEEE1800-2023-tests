/*
:section: 25.9.2 Virtual interface modports and clocking blocks
:summary: A virtual interface may name a modport, and an unqualified one may be assigned to it.
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  sig_if a(.clk(clk));
  virtual sig_if.mon m1, m2;
  virtual sig_if plain;
  initial begin
    #1;
    a.value = 8'h77;
    plain = a;
    m1 = plain;
    m2 = a.mon;
    check(m1.value == 8'h77 && m2.value == 8'h77, "reading through modport-qualified virtual interfaces");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
