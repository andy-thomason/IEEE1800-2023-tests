/*
:section: 19.5.6 Specifying Illegal coverage point values or transitions
:summary: Sampling a value that matches an illegal_bins definition must produce a run-time
  error.
:type: simulation
:should_fail_because: an illegal_bins value is sampled
*/
module top;
  bit [1:0] v;
  covergroup cg;
    cp: coverpoint v { bins ok = {[0:2]}; illegal_bins bad = {3}; }
  endgroup
  cg c = new;
  initial begin
    v = 3;
    c.sample();
    $display("illegal value sampled without an error");
    $finish;
  end
endmodule
