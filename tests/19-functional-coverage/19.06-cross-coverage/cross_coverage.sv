/*
:section: 19.6 Defining cross coverage
:summary: A cross of coverpoints counts coverage across every combination of their bins.
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
    bit a, b;
    covergroup cg;
      ca: coverpoint a;
      cb: coverpoint b;
      axb: cross ca, cb;
    endgroup
    cg c = new;
  initial begin
    a = 0; b = 0; c.sample();
    a = 1; b = 1; c.sample();
    check(near(c.axb.get_inst_coverage(), 50.0), $sformatf("cross coverage %f, expected 2 of 4", c.axb.get_inst_coverage()));
    a = 0; b = 1; c.sample();
    a = 1; b = 0; c.sample();
    check(near(c.axb.get_inst_coverage(), 100.0), "all cross products");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
