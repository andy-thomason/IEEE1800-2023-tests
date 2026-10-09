/*
:section: 19.5.4 Wildcard specification of coverage point bins
:summary: wildcard bins treat x, z and ? as match-anything bits, and ignore_bins values are left
  out of coverage.
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
      w: coverpoint v { wildcard bins odd = {4'b???1}; bins high = {[8:15]}; ignore_bins skip = {14, 15}; }
    endgroup
    cg c = new;
  initial begin
    v = 3; c.sample();
    check(near(c.w.get_inst_coverage(), 50.0), $sformatf("after an odd value: %f", c.w.get_inst_coverage()));
    v = 15; c.sample();
    check(near(c.w.get_inst_coverage(), 50.0), $sformatf("an ignored value counted toward 'high': %f", c.w.get_inst_coverage()));
    v = 8; c.sample();
    check(near(c.w.get_inst_coverage(), 100.0), "all bins hit");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
