/*
:section: 18.6.1 Randomize()
:summary: randomize() assigns new values to rand variables that satisfy all active constraints
  and returns 1 on success.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class packet_c;
    rand bit [7:0] len;
    rand bit [3:0] kind;
    bit [7:0] fixed = 8'd42;
    constraint c_len { len inside {[10:20]}; }
    constraint c_kind { kind != 0; kind < len[3:0] || len > 15; }
  endclass
  packet_c p = new;
  int bad = 0;
  initial begin
    repeat (200) begin
      if (!p.randomize()) bad++;
      else if (!(p.len inside {[10:20]}) || p.kind == 0 || !(p.kind < p.len[3:0] || p.len > 15)) bad++;
    end
    check(bad == 0, $sformatf("%0d randomizations failed or broke a constraint", bad));
    check(p.fixed == 42, "a non-random variable changed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
