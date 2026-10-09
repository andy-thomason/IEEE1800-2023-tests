/*
:section: 31.4.2 $timeskew
:summary: $timeskew by default reports once when the limit elapses, then stays silent until the
  next reference edge.
:flags-icarus: -gspecify
*/
module chk(input a, input b);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $timeskew(posedge a, posedge b, 5, n);
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
    #6 check(u.violations == 1, "reported when the limit elapsed with no data event");
    #10 b = 1;       // late data event: dormant, no second report
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
