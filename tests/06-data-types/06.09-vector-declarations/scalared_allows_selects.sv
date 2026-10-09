/*
:section: 6.9.2 Vector net accessibility
:summary: Selecting individual bits or bit ranges is allowed on a net declared scalared.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire scalared [7:0] bus;
  tri vectored [3:0] whole;
  assign bus[2] = 1'b1;
  assign bus[7:4] = 4'hA;
  assign whole = 4'h6;
  initial begin
    #1;
    check(bus[2] === 1'b1 && bus[7:4] === 4'hA, "bit- and part-select of a scalared net");
    check(whole === 4'h6, "vectored net driven as a whole");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
