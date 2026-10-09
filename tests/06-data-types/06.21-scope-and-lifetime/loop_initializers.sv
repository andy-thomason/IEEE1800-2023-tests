/*
:section: 6.21 Scope and lifetime
:summary: Explicit automatic and static variables in loop bodies reinitialize per pass or only
  once, respectively.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int auto_total = 0, static_total = 0;
  initial begin
    for (int i = 0; i < 4; i++) begin
      automatic int per_pass = 0;
      static int across_passes = 0;
      per_pass += 2;
      across_passes += 2;
      auto_total += per_pass;
      static_total += across_passes;
    end
    check(auto_total == 8, $sformatf("automatic initialiser total = %0d, expected 8", auto_total));
    check(static_total == 20, $sformatf("static initialiser total = %0d, expected 20", static_total));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
