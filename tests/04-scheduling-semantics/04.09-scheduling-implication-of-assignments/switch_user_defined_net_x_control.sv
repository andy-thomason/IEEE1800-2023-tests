/*
:section: 4.9.5 Switch (transistor) processing
:summary: A tranif1 joining user-defined nets resolves them as one when the control is on,
  separately when off.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  nettype int int_net;
  int_net source, sink;
  logic ctl = 1'b1;
  assign source = 42;
  tranif1 sw(source, sink, ctl);
  initial begin
    #1 check(sink == 42, $sformatf("switch on: sink = %0d", sink));
    ctl = 1'b0;
    #1 check(sink == 0, $sformatf("switch off: sink = %0d, expected the int default 0", sink));
    ctl = 1'bx;
    #1 check(sink == 0, $sformatf("x control: sink = %0d, expected 0 (treated as off)", sink));
    ctl = 1'bz;
    #1 check(sink == 0, $sformatf("z control: sink = %0d, expected 0 (treated as off)", sink));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
