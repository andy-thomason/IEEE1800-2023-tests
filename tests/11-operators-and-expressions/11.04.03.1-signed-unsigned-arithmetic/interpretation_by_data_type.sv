/*
:section: 11.4.3.1 Arithmetic expressions with unsigned and signed types
:summary: Arithmetic interprets nets and variables as unsigned or two's-complement signed
  according to their declared type.
:description: The same 8-bit pattern 8'hEC is divided and reduced modulo in each kind of
  object. As unsigned it is 236; as signed it is -20.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  wire        [7:0] un_net = 8'hEC;
  wire signed [7:0] sn_net = 8'hEC;
  logic        [7:0] uv;
  logic signed [7:0] sv;
  real rv;
  int q;
  initial begin
    uv = 8'hEC;
    sv = 8'hEC;
    rv = -20;
    #1;
    q = un_net / 8; check(q == 29, $sformatf("unsigned net 8'hEC / 8 = %0d, expected 29", q));
    q = sn_net / 8; check(q == -2, $sformatf("signed net 8'hEC / 8 = %0d, expected -2", q));
    q = uv / 8;     check(q == 29, $sformatf("unsigned variable 8'hEC / 8 = %0d, expected 29", q));
    q = sv / 8;     check(q == -2, $sformatf("signed variable 8'hEC / 8 = %0d, expected -2", q));
    q = uv % 7;     check(q == 5, $sformatf("unsigned variable 8'hEC %% 7 = %0d, expected 5", q));
    q = sv % 7;     check(q == -6, $sformatf("signed variable 8'hEC %% 7 = %0d, expected -6", q));
    check(rv / 8 == -2.5, $sformatf("real -20 / 8 = %f, expected -2.5", rv / 8));
    check(rv < 0, "real variable is not signed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
