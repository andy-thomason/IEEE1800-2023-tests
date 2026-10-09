/*
:section: 8.19 Constant class properties
:summary: Global constants take their declared value, while instance constants are assigned once
  in the constructor.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class limits_c;
    const int ceiling = 100;
    const int serial;
    static const int shared = 7;
    function new(int s); serial = s; endfunction
  endclass
  limits_c l;
  initial begin
    l = new(42);
    check(l.ceiling == 100 && l.serial == 42 && limits_c::shared == 7, "constant properties");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
