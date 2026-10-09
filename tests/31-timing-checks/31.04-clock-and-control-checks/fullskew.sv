/*
:section: 31.4.3 $fullskew
:summary: $fullskew applies separate limits depending on whether the data or the reference event
  occurs first.
:flags-icarus: -gspecify
*/
module chk(input a, input b);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $fullskew(posedge a, negedge b, 4, 6, n);
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
  logic a = 0, b = 1;
  chk u(.a(a), .b(b));
  initial begin
    #100 a = 1;
    #3 b = 0;        // within 4
    #20 a = 0; b = 1;
    #77 b = 0;
    #5 a = 1;        // a follows b within 6
    #20 a = 0; b = 1;
    #75 a = 1;       // b never follows: violation after 4
    #20;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
