/*
:section: 5.7.1 Integer literal constants
:summary: Sized signed or negative literals get sign extension when stored into wider targets.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [11:0] u;
  logic [3:0] narrow;
  initial begin
    u = 4'sb1010;  check(u === 12'hFFA, $sformatf("4'sb1010 into 12 bits = %h", u));
    u = -4'd3;     check(u === 12'hFFD, $sformatf("-4'd3 into 12 bits = %h", u));
    u = 4'b1010;   check(u === 12'h00A, $sformatf("unsigned 4'b1010 into 12 bits = %h", u));
    narrow = 4'bx01z;
    check($isunknown(4'bx01z) == 1, "a literal can hold x and z (it is logic)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
