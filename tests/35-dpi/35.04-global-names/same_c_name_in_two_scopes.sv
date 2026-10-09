/*
:section: 35.5.4 Import declarations
:summary: The same C function may be imported in different scopes provided every signature
  matches.
:dpi: same_c_name_in_two_scopes.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int shared_fn(input int x);
  module_user mu();
  initial begin
    #1;
    check(shared_fn(2) == 12 && mu.got == 13, "one C function imported in two scopes");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

module module_user;
  import "DPI-C" function int shared_fn(input int x);
  int got;
  initial got = shared_fn(3);
endmodule
