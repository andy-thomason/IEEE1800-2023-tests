/*
:section: 19.5.2 Specifying bins for transitions
:summary: Transition bins count value sequences using =>, consecutive repetition [* n] and goto
  repetition [-> n].
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
      t: coverpoint v {
        bins up = (1 => 2 => 3);
        bins hold = (5 [* 3]);
        bins jump = (0 => 6);
      }
    endgroup
    cg c = new;
    int seq [] = '{1, 2, 3, 5, 5, 5, 0, 4, 6};
  initial begin
    foreach (seq[i]) begin v = seq[i]; c.sample(); end
    check(near(c.t.get_inst_coverage(), 100.0 * 2 / 3), $sformatf("transition coverage %f, expected 2 of 3 (0 => 6 not consecutive)", c.t.get_inst_coverage()));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
