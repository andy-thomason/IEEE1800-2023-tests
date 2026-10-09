/*
:section: 4.4.2.6 Reactive events region
:summary: Program block code runs in the Reactive region, after module nonblocking updates have
  settled.
:description: The program's initial block runs in the Reactive region, after the module's
  nonblocking update in the NBA region of the same time slot.
*/
program observer(input int module_value, output int seen);
  initial seen = module_value;
endprogram

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int m = 0;
  int seen;
  observer u_obs(.module_value(m), .seen(seen));
  initial m <= 5;
  initial begin
    #1;
    check(seen == 5, $sformatf("program saw %0d at time 0; it should run after the module's NBA update", seen));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
