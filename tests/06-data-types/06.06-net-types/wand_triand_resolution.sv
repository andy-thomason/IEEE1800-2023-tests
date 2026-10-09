/*
:section: 6.6.3 Wired nets
:summary: wand and triand behave identically, resolving to 0 whenever any driver is 0 per Table
  6-3.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a, b;
  wand r_0;
  assign r_0 = a;
  assign r_0 = b;
  triand r_1;
  assign r_1 = a;
  assign r_1 = b;
  // Row = first driver, column = second driver, each in the order 0 1 x z.
  string expected = "000001x10xxx01xz";
  string want, got;
  function automatic logic value_of(int k);
    case (k)
      0: return 1'b0;
      1: return 1'b1;
      2: return 1'bx;
      default: return 1'bz;
    endcase
  endfunction
  initial begin
    for (int i = 0; i < 4; i++)
      for (int j = 0; j < 4; j++) begin
        a = value_of(i);
        b = value_of(j);
        want = expected.substr(4 * i + j, 4 * i + j);
        #1;
        got = $sformatf("%b", r_0);
        check(got == want, $sformatf("wand: %b with %b gave %s, expected %s", a, b, got, want));
        got = $sformatf("%b", r_1);
        check(got == want, $sformatf("triand: %b with %b gave %s, expected %s", a, b, got, want));
      end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
