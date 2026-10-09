/*
:section: 4.9.5 Switch (transistor) processing
:summary: A bidirectional switch merges the nets it joins when on and resolves them separately
  when off.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic drive_left = 1'b1, enable_left = 1'b1;
  logic drive_right = 1'b0, enable_right = 1'b0;
  logic ctl = 1'b1;
  wire left, right, far;
  assign left = enable_left ? drive_left : 1'bz;
  assign right = enable_right ? drive_right : 1'bz;
  tran t1(left, right);
  tranif1 t2(right, far, ctl);
  initial begin
    #1 check(right === 1'b1 && far === 1'b1, $sformatf("left to right: right=%b far=%b", right, far));
    enable_left = 0; enable_right = 1;
    #1 check(left === 1'b0 && far === 1'b0, $sformatf("right to left: left=%b far=%b", left, far));
    ctl = 1'b0;
    #1 check(far === 1'bz, $sformatf("tranif1 off: far=%b", far));
    ctl = 1'bx;
    #1 check(far === 1'bx, $sformatf("tranif1 with x control: far=%b, expected x (0 when on, z when off)", far));
    enable_right = 0;
    #1 check(far === 1'bz && left === 1'bz, $sformatf("undriven network: left=%b far=%b", left, far));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
