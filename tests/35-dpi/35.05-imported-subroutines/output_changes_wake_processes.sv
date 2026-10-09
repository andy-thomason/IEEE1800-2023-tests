/*
:section: 35.6.2 Value changes for output and inout arguments
:summary: Output values written by an imported function trigger waiting processes once control
  returns to SystemVerilog.
:dpi: output_changes_wake_processes.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function void put_value(output int o, input int v);
  int watched;
  int wakes;
  always @(watched) wakes++;
  initial begin
    #1;
    wakes = 0;
    put_value(watched, 5);
    #1;
    check(watched == 5 && wakes == 1, $sformatf("the output change woke the always block %0d time(s)", wakes));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
