/*
:section: 6.6.7 User-defined nettypes
:summary: Nettypes accept 4-state and 2-state integral, real, shortreal and fixed-size unpacked
  aggregate data types.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { real volts; bit [3:0] tag; } probe_t;
  nettype logic [7:0] n_logic;
  nettype bit [15:0] n_bit;
  nettype real n_real;
  nettype probe_t n_probe;
  typedef int int3_t [3];
  nettype int3_t n_array;
  nettype n_real n_real_alias;
  n_logic w1; n_bit w2; n_real w3; n_probe w4; n_array w5; n_real_alias w6;
  assign w1 = 8'h5A;
  assign w2 = 16'hBEEF;
  assign w3 = 1.25;
  assign w4 = '{2.5, 4'd7};
  assign w5 = '{1, 2, 3};
  assign w6 = 0.5;
  initial begin
    #1;
    check(w1 === 8'h5A && w2 == 16'hBEEF && w3 == 1.25, "integral and real nettypes");
    check(w4.volts == 2.5 && w4.tag == 7, "unpacked struct nettype");
    check(w5[0] + w5[1] + w5[2] == 6, "unpacked array nettype");
    check(w6 == 0.5, "renamed nettype");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
