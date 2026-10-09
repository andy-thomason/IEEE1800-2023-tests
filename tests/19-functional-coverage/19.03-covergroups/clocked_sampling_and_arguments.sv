/*
:section: 19.3 Defining the coverage model: covergroup
:summary: A covergroup with a clocking event samples on that event, accepts arguments, and
  honours coverpoint iff conditions.
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
    logic clk = 0;
    always #5 clk = ~clk;
    bit [1:0] v = 0;
    bit en = 0;
    covergroup cg (ref bit [1:0] x, input int lo) @(posedge clk);
      cp: coverpoint x iff (en) { bins low = {[0:lo]}; bins high = {[lo + 1:3]}; }
    endgroup
    cg c = new(v, 1);
  initial begin
    @(negedge clk) v = 3;
    @(negedge clk) en = 1; v = 0;
    @(negedge clk) en = 0;
    check(near(c.get_inst_coverage(), 50.0), $sformatf("coverage %f; the sample with en = 0 must not count", c.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
