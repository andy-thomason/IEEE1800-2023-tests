/*
:section: 18.5.13 Soft constraints
:summary: When soft constraints conflict, the one declared later takes priority, and hard
  constraints override soft ones.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class sft_c;
    rand int v;
    constraint s1 { soft v == 5; }
    constraint s2 { soft v == 7; }
  endclass
  sft_c s = new;
  initial begin
    void'(s.randomize());
    check(s.v == 7, $sformatf("later soft constraint did not win: %0d", s.v));
    void'(s.randomize() with { v > 100; v < 102; });
    check(s.v == 101, "a hard inline constraint did not override the soft ones");
    void'(s.randomize() with { soft v == 9; });
    check(s.v == 9, "an inline soft constraint did not win over class soft constraints");
    void'(s.randomize() with { disable soft v; v inside {[20:30]}; });
    check(s.v inside {[20:30]}, "disable soft");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
