/*
:section: 19.5.3 Automatic bin creation for coverage points of integral expressions
:summary: A coverpoint without bins gets automatic bins, limited to auto_bin_max, which defaults
  to 64.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic bit near(real got, real want); return got > want - 0.01 && got < want + 0.01; endfunction
    bit [1:0] small_v;
    bit [7:0] wide_v;
    covergroup cg;
      s: coverpoint small_v;
      w: coverpoint wide_v;
    endgroup
    cg c = new;
  initial begin
    small_v = 0; wide_v = 0;   c.sample();
    small_v = 2; wide_v = 255; c.sample();
    check(near(c.s.get_inst_coverage(), 50.0), $sformatf("2-bit point: %f, expected 50 (2 of 4 bins)", c.s.get_inst_coverage()));
    check(near(c.w.get_inst_coverage(), 100.0 * 2 / 64), $sformatf("8-bit point: %f, expected 2 of 64 bins", c.w.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
