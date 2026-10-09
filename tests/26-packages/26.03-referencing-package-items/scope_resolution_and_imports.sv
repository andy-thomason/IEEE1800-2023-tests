/*
:section: 26.3 Referencing data in packages
:summary: Package items are reachable with :: or through explicit and wildcard import
  declarations.
*/
package colours;
  typedef enum {RED, GREEN, BLUE} colour_t;
  function automatic colour_t next(colour_t c); return colour_t'((c + 1) % 3); endfunction
endpackage
module explicit_user(output int r);
  import colours::colour_t, colours::GREEN, colours::next;
  colour_t c = GREEN;
  assign r = next(c);
endmodule
module wildcard_user(output int r);
  import colours::*;
  assign r = next(BLUE);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a, b;
  explicit_user u1(.r(a));
  wildcard_user u2(.r(b));
  initial begin
    #1;
    check(a == colours::BLUE, "explicit imports");
    check(b == colours::RED, "wildcard import");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
