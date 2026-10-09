/*
:section: 18.5.5 Implication
:summary: The -> operator and if-else forms in constraints make a constraint conditional on an
  expression.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class mode_c;
    rand bit small_mode;
    rand bit [7:0] len;
    constraint c1 { small_mode -> len < 10; }
    constraint c2 { if (!small_mode) len > 100; else len > 0; }
  endclass
  mode_c m = new;
  int bad = 0, smalls = 0;
  initial begin
    repeat (200) begin
      void'(m.randomize());
      if (m.small_mode) begin smalls++; if (!(m.len < 10 && m.len > 0)) bad++; end
      else if (!(m.len > 100)) bad++;
    end
    check(bad == 0, "implication or if-else constraint violated");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
