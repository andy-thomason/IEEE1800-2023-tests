/*
:section: 19.5.1 Specifying bins for values
:summary: bins x[] makes one bin per value, a fixed bin count spreads values evenly, and default
  collects the rest.
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
    bit [3:0] v;
    covergroup cg;
      each: coverpoint v { bins b[] = {[0:3]}; }
      split: coverpoint v { bins b[2] = {[0:7]}; bins rest = default; }
    endgroup
    cg c = new;
  initial begin
    v = 1; c.sample();
    v = 6; c.sample();
    v = 12; c.sample();
    check(near(c.each.get_inst_coverage(), 25.0), $sformatf("bins b[] = {[0:3]}: %f, expected 25", c.each.get_inst_coverage()));
    check(near(c.split.get_inst_coverage(), 100.0), $sformatf("bins b[2] = {[0:7]} hit both halves: %f", c.split.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
