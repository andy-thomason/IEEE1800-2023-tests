/*
:section: 10.11 Net aliasing
:summary: alias joins net bits so they always carry the same value, including reordered bits and
  chains of aliases.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire [7:0] packed_bus;
  wire [3:0] upper, lower;
  wire [3:0] n1, n2, n3;
  alias packed_bus = {lower, upper};
  alias n1 = n2;
  alias n3 = n2;
  logic [7:0] drv = 8'h3C;
  logic en = 1;
  assign packed_bus = en ? drv : 8'bz;
  assign n1 = 4'h9;
  initial begin
    #1;
    check(upper === 4'hC && lower === 4'h3, $sformatf("concatenated alias gave upper=%h lower=%h", upper, lower));
    check(n3 === 4'h9, "alias is transitive through a shared net");
    en = 0;
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
