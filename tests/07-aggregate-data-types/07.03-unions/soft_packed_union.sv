/*
:section: 7.3.1 Packed unions
:summary: Soft packed union members may differ in width; the union is as wide as its largest
  member.
:description: Soft packed unions are new in IEEE 1800-2023.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  union soft { bit [11:0] wide; bit [3:0] narrow; bit [7:0] middle; } u;
  union soft packed {
    bit [2:0] three;
    union soft { bit [6:0] seven; bit [0:0] one; } deep;
  } n;
  initial begin
    check($bits(u) == 12 && $bits(n) == 7, "soft union size is not the largest member");
    u.wide = 12'hABC;
    check(u.narrow == 4'hC && u.middle == 8'hBC, "narrow members are not right-justified");
    u.narrow = 4'h5;
    check(u.wide == 12'hAB5, $sformatf("writing narrow gave %h, expected ab5 (upper bits unaffected)", u.wide));
    n.deep.seven = 7'b1010101;
    n.deep.one = 1'b0;
    check(n.three == 3'b100 && n.deep.seven == 7'b1010100, "nested soft union layout");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
