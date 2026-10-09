/*
:section: 31.4.1 $skew
:summary: $skew with a zero limit does not flag reference and data events that occur together.
:flags-icarus: -gspecify
*/
module chk(input a, input b);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $skew(posedge a, posedge b, 0, n);
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0, b = 0;
  chk u(.a(a), .b(b));
  initial begin
    #100 a = 1;
    b = 1;
    #10;
    check(u.violations == 0, $sformatf("expected 0 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
