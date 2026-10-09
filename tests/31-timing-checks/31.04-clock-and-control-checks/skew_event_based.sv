/*
:section: 31.4.1 $skew
:summary: $skew is evaluated on each data event and reports every one arriving later than the
  limit.
:flags-icarus: -gspecify
*/
module chk(input a, input b);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $skew(posedge a, posedge b, 5, n);
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
    #3 b = 1;        // within 5
    #10 a = 0; b = 0;
    #87 a = 1;
    #10 b = 1;       // 10 after: violation
    #2 b = 0;
    #2 b = 1;        // 14 after: violation again
    #50;
    check(u.violations == 2, $sformatf("expected 2 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
