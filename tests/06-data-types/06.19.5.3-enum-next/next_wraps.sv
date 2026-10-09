/*
:section: 6.19.5.3 Next()
:summary: next steps forward through the enum values and wraps back to the first after the last.
*/
module top;
  typedef enum logic [1:0] { NORTH, EAST, SOUTH, WEST } heading_t;
  heading_t h, n;
  int errors = 0;
  task automatic check(input heading_t got, input heading_t want, input string what);
    if (got != want) begin
      $display("FAIL: %s gave %s, expected %s", what, got.name(), want.name());
      errors++;
    end
  endtask
  initial begin
    h = EAST;
    n = h.next();  check(n, SOUTH, "EAST.next()");
    n = h.next(2); check(n, WEST, "EAST.next(2)");
    h = WEST;
    n = h.next();  check(n, NORTH, "WEST.next() (wrap)");
    n = h.next(3); check(n, SOUTH, "WEST.next(3) (wrap)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
