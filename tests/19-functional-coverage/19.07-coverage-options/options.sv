/*
:section: 19.7 Specifying coverage options
:summary: Options such as at_least, auto_bin_max, weight and per_instance change how covergroup
  coverage is computed.
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
      option.at_least = 2;
      cp: coverpoint v { bins b[] = {[0:1]}; }
      small_auto: coverpoint v { option.auto_bin_max = 2; }
    endgroup
    cg c = new;
  initial begin
    v = 0; c.sample();
    v = 1; c.sample(); c.sample();
    check(near(c.cp.get_inst_coverage(), 50.0), $sformatf("at_least = 2: %f, expected 50", c.cp.get_inst_coverage()));
    check(near(c.small_auto.get_inst_coverage(), 50.0), $sformatf("auto_bin_max = 2: %f, expected 1 of 2 bins", c.small_auto.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
