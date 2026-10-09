/*
:section: 19.3 Defining the coverage model: covergroup
:summary: A covergroup defines coverpoints with bins, is constructed with new, and sample()
  updates its coverage.
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
    bit [1:0] v;
    covergroup cg;
      cp: coverpoint v { bins zero = {0}; bins one = {1}; bins two = {2}; bins three = {3}; }
    endgroup
    cg c = new;
  initial begin
    check(near(c.get_inst_coverage(), 0.0), "coverage before any sample");
    v = 1; c.sample();
    v = 3; c.sample();
    v = 1; c.sample();
    check(near(c.get_inst_coverage(), 50.0), $sformatf("coverage %f, expected 50 (2 of 4 bins)", c.get_inst_coverage()));
    check(near(c.cp.get_inst_coverage(), 50.0), "coverpoint coverage");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
