/*
:section: 19.6.2 Excluding cross products
:summary: Cross bins can be chosen with binsof and intersect, and ignore_bins removes chosen
  cross products.
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
    bit [1:0] a, b;
    covergroup cg;
      ca: coverpoint a { bins lo = {0}; bins hi = {3}; }
      cb: coverpoint b { bins lo = {0}; bins hi = {3}; }
      axb: cross ca, cb { ignore_bins both_hi = binsof(ca.hi) && binsof(cb.hi); }
    endgroup
    cg c = new;
  initial begin
    a = 0; b = 0; c.sample();
    a = 0; b = 3; c.sample();
    a = 3; b = 0; c.sample();
    check(near(c.axb.get_inst_coverage(), 100.0), $sformatf("cross with an ignored product: %f", c.axb.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
