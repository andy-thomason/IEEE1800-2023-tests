/*
:section: 30.6 Mixing module path delays and distributed delays
:summary: When a module has both path delays and gate delays, the larger delay on each path
  takes effect.
:flags-icarus: -gspecify
*/
module path_wins(input a, output y);
  buf #2 b(y, a);
  specify
    (a => y) = 6;
  endspecify
endmodule
module gate_wins(input a, output y);
  buf #9 b(y, a);
  specify
    (a => y) = 4;
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
  logic a = 0;
  wire y1, y2;
  path_wins u1(.a(a), .y(y1));
  gate_wins u2(.a(a), .y(y2));
  initial begin
    #30 a = 1;
    #5 check(y1 === 1'b0, "path delay 6 not elapsed");
    #2 check(y1 === 1'b1 && y2 === 1'b0, "path delay 6 used; gate delay 9 pending");
    #3 check(y2 === 1'b1, "gate delay 9 used");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
