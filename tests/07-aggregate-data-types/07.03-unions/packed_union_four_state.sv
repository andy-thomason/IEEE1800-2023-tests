/*
:section: 7.3.1 Packed unions
:summary: A packed union containing a 4-state member is 4-state; reading the 2-state member
  converts x and z.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  union packed { bit [3:0] two; logic [3:0] four; } u;
  initial begin
    u.four = 4'b1x0z;
    check(u === 4'b1x0z, "union with a 4-state member lost x/z");
    check(u.two === 4'b1000, $sformatf("2-state member read %b, expected 1000", u.two));
    u.two = 4'b0110;
    check(u.four === 4'b0110, "writing the 2-state member");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
