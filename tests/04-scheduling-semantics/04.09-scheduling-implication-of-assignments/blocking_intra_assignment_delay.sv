/*
:section: 4.9.3 Blocking assignment
:summary: A blocking assignment with intra-assignment delay samples the right side immediately
  and assigns after the delay.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 1, b = 0, c = 0;
  initial begin
    b = #5 a;
    check($time == 5, $sformatf("b was assigned at time %0t, expected 5", $time));
    check(b == 1, $sformatf("b = %0d; the right-hand side should be the value of a at time 0", b));
  end
  initial #2 a = 50;
  initial begin
    #10;
    a = 3;
    c = #0 a;
    check($time == 10, "c = #0 a resumed at a later time");
    check(c == 3, $sformatf("c = %0d; c = #0 a must use the value of a before suspending", c));
  end
  initial begin
    #10;
    #0;
    a = 9;   // Inactive region at time 10, alongside the resumption of c = #0 a
  end
  initial begin
    #15;
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
