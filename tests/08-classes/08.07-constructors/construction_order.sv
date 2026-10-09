/*
:section: 8.7 Constructors
:summary: Constructors run the base constructor first, then property initializers, then the
  remaining body statements.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string trail = "";
  class root_c;
    int r = 1;
    function new(); trail = {trail, "R"}; endfunction
  endclass
  class mid_c extends root_c;
    int seen_at_body;
    int m = 5;
    function new();
      trail = {trail, "M"};
      seen_at_body = m + r;
    endfunction
  endclass
  class implicit_c extends mid_c;
    int k = 9;
  endclass
  implicit_c obj;
  initial begin
    obj = new;
    check(trail == "RM", $sformatf("constructor order %s, expected RM", trail));
    check(obj.seen_at_body == 6, "properties were not initialised before the constructor body");
    check(obj.k == 9, "implicit constructor did not initialise properties");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
