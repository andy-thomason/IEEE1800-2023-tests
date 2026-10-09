/*
:section: 6.19.5.3 Next()
:summary: next steps forward through the enum values and wraps back to the first after the last.
*/
module top;
  typedef enum logic [1:0] { NORTH, EAST, SOUTH, WEST } heading_t;
  heading_t h;
  initial begin
    h = EAST;
    if (h.next() != SOUTH) $display("FAIL: EAST.next() gave %s", h.next().name());
    else if (h.next(2) != WEST) $display("FAIL: EAST.next(2) gave %s", h.next(2).name());
    else begin
      h = WEST;
      if (h.next() != NORTH) $display("FAIL: WEST.next() did not wrap, gave %s", h.next().name());
      else if (h.next(3) != SOUTH) $display("FAIL: WEST.next(3) gave %s", h.next(3).name());
      else $display("PASS");
    end
    $finish;
  end
endmodule
