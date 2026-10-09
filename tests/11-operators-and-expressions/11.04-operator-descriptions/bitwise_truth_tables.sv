/*
:section: 11.4.8 Bitwise operators
:summary: Bitwise AND, OR, XOR, XNOR and negation follow their four-state truth tables,
  including x and z inputs.
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
  string got, want;
  string table_0 = "000001xx0xxx0xxx";
  string table_1 = "01xx1111x1xxx1xx";
  string table_2 = "01xx10xxxxxxxxxx";
  string table_3 = "10xx01xxxxxxxxxx";
  string table_4 = "10xx01xxxxxxxxxx";
  string table_5 = "11110000xxxxxxxx";
  function automatic logic value_of(int k);
    case (k) 0: return 1'b0; 1: return 1'b1; 2: return 1'bx; default: return 1'bz; endcase
  endfunction
  initial begin
    for (int i = 0; i < 4; i++)
      for (int j = 0; j < 4; j++) begin
        a = value_of(i);
        b = value_of(j);
    got = $sformatf("%b", a & b);
    want = table_0.substr(4 * i + j, 4 * i + j);
    check(got == want, $sformatf("&: %b op %b = %s, expected %s", a, b, got, want));
    got = $sformatf("%b", a | b);
    want = table_1.substr(4 * i + j, 4 * i + j);
    check(got == want, $sformatf("|: %b op %b = %s, expected %s", a, b, got, want));
    got = $sformatf("%b", a ^ b);
    want = table_2.substr(4 * i + j, 4 * i + j);
    check(got == want, $sformatf("^: %b op %b = %s, expected %s", a, b, got, want));
    got = $sformatf("%b", a ~^ b);
    want = table_3.substr(4 * i + j, 4 * i + j);
    check(got == want, $sformatf("~^: %b op %b = %s, expected %s", a, b, got, want));
    got = $sformatf("%b", a ^~ b);
    want = table_4.substr(4 * i + j, 4 * i + j);
    check(got == want, $sformatf("^~: %b op %b = %s, expected %s", a, b, got, want));
    got = $sformatf("%b", ~a);
    want = table_5.substr(4 * i + j, 4 * i + j);
    check(got == want, $sformatf("~a: %b op %b = %s, expected %s", a, b, got, want));
      end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
