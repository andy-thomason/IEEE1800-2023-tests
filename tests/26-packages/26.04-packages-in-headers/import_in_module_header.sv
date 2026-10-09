/*
:section: 26.4 Using packages in module headers
:summary: A package can be imported in a module header so its items are usable in parameters and
  ports.
*/
package bus_types;
  typedef logic [11:0] addr_t;
  parameter int DEFAULT_DEPTH = 3;
endpackage
module mem import bus_types::*; #(parameter int DEPTH = DEFAULT_DEPTH) (input addr_t a, output int width, output int depth);
  assign width = $bits(a);
  assign depth = DEPTH;
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int w, d;
  mem u(.a(12'h0), .width(w), .depth(d));
  initial begin
    #1;
    check(w == 12 && d == 3, $sformatf("header import gave width %0d depth %0d", w, d));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
