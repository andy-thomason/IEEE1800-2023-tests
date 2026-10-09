/*
:section: 16.4 Deferred assertions
:summary: Deferred assertions report only the final result after glitches settle, not transient
  failures.
:flags-verilator: --coverage-user
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0;
  wire delayed;
  assign delayed = a;
  int obs_fails = 0, fin_fails = 0, real_fails = 0;
  logic stuck = 0;
  function void note_obs(); obs_fails++; endfunction
  function void note_fin(); fin_fails++; endfunction
  function void note_real(); real_fails++; endfunction
  always @(a, delayed) begin
    a0: assert #0 (delayed == a) else note_obs();
    af: assert final (delayed == a) else note_fin();
  end
  always @(stuck) begin
    ar: assert #0 (!stuck) else note_real();
  end
  initial begin
    #1 a = 1;
    #1 a = 0;
    #1 a = 1;
    #1 stuck = 1;
    #1;
    check(obs_fails == 0, $sformatf("observed deferred assertion reported %0d glitch failures", obs_fails));
    check(fin_fails == 0, $sformatf("final deferred assertion reported %0d glitch failures", fin_fails));
    check(real_fails == 1, $sformatf("a failure that persists to the end of the time step was reported %0d times", real_fails));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
