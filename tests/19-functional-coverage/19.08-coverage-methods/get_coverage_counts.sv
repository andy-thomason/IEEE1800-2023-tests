/*
:section: 19.8 Predefined coverage methods
:summary: get_coverage and get_inst_coverage return percentages and report covered and total bin
  counts through ref arguments.
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
      cp: coverpoint v { bins b[] = {[0:4]}; }
    endgroup
    cg c1 = new, c2 = new;
    int covered, total;
    real r;
  initial begin
    v = 0; c1.sample();
    v = 1; c2.sample();
    r = c1.get_inst_coverage(covered, total);
    check(covered == 1 && total == 5, $sformatf("instance counts %0d/%0d", covered, total));
    r = c1.get_coverage(covered, total);
    check(covered == 2 && total == 5 && near(r, 40.0), $sformatf("type coverage merges instances: %0d/%0d", covered, total));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
