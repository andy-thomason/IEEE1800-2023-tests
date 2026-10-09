/*
:section: 4.4.2.4 NBA events region
:summary: Nonblocking updates take effect only after active and inactive work in the time step
  has finished.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 1, b = 2;
  initial begin
    #1;
    a <= b;
    b <= a;
    check(a == 1 && b == 2, "nonblocking assignments updated immediately");
    #0;
    check(a == 1 && b == 2, "nonblocking assignments updated before the Inactive region");
    #1;
    check(a == 2 && b == 1, $sformatf("swap gave a = %0d, b = %0d", a, b));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
