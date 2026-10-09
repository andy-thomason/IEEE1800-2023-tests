/*
:section: 19.8 Predefined coverage methods
:summary: stop() and start() pause and resume collection, and a covergroup may override sample()
  with its own arguments.
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
    covergroup cg with function sample(int x);
      cp: coverpoint x { bins b[] = {[0:3]}; }
    endgroup
    cg c = new;
  initial begin
    c.sample(1);
    c.stop();
    c.sample(2);
    c.start();
    c.sample(3);
    check(near(c.cp.get_inst_coverage(), 50.0), $sformatf("coverage %f; the sample while stopped must not count", c.cp.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
