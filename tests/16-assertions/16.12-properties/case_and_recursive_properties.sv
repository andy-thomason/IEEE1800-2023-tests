/*
:section: 16.12.16 Case
:summary: A case property selects one branch by value, and a named property may instantiate
  itself recursively.
:description: Waveforms: character k of each string is the value sampled at the k-th rising clock
  edge.
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
  timeunit 1ns; timeprecision 1ns;
  logic clk = 0;
  always #5 clk = ~clk;
  logic m0 = 0;
  string w_m0 = "1100";
  logic m1 = 0;
  string w_m1 = "0010";
  logic a = 0;
  string w_a = "10";
  logic b = 0;
  string w_b = "001";
  logic st = 0;
  string w_st = "001";
  logic h = 0;
  string w_h = "1111111";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      m0 = (i < w_m0.len()) && (w_m0[i] == "1");
      m1 = (i < w_m1.len()) && (w_m1[i] == "1");
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      st = (i < w_st.len()) && (w_st[i] == "1");
      h = (i < w_h.len()) && (w_h[i] == "1");
    end
  end
  int f_case = 0, f_rec = 0;
  property by_mode;
    case ({m1, m0})
      2'b01: a;
      2'b10: b;
      default: 1;
    endcase
  endproperty
  property hold_forever(x);
    x and nexttime hold_forever(x);
  endproperty
  a1: assert property (@(posedge clk) by_mode) else f_case++;
  a2: assert property (@(posedge clk) st |-> hold_forever(h)) else f_rec++;
  initial begin
    #112;
    check(f_case == 1, $sformatf("case property: %0d failures", f_case));
    check(f_rec == 1, $sformatf("recursive property: %0d failures", f_rec));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
