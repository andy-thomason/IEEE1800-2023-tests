/*
:section: 19.5.7 Value resolution
:summary: Bin values are resolved against the coverpoint type, so bin values the coverpoint
  cannot hold are discarded.
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
    bit [2:0] v;
    covergroup cg;
      r: coverpoint v { bins b = {[6:10]}; bins c = {7}; }
    endgroup
    cg c = new;
  initial begin
    v = 7; c.sample();
    check(near(c.r.get_inst_coverage(), 100.0), "a value in two bins counts in both");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
