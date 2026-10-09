/*
:section: 7.2.1 Packed structures
:summary: A packed struct with any 4-state member is 4-state, with 2-state members reading x and
  z as 0.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  struct packed { bit [3:0] two; logic [3:0] four; } mixed;
  struct packed { bit [3:0] a; bit [3:0] b; } all_two;
  initial begin
    mixed = 8'b1x0z_1x0z;
    check(mixed === 8'b1x0z_1x0z, "a struct with a 4-state member lost x/z as a whole");
    check(mixed.two === 4'b1000, $sformatf("reading the 2-state member gave %b, expected x/z as 0", mixed.two));
    check(mixed.four === 4'b1x0z, "4-state member");
    all_two = 8'b1x0z_1x0z;
    check(all_two === 8'b1000_1000, $sformatf("an all 2-state struct stored %b", all_two));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
