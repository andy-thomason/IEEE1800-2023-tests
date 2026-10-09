/*
:section: 6.20.4 Local parameters (localparam)
:summary: In a parameter port list, entries after localparam stay local until the next parameter
  keyword.
*/
module mixed #(parameter int A = 1, localparam int B = A * 2, C = B + 1, parameter int E = 9);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  mixed #(.A(5), .E(4)) u();
  initial begin
    check(u.B == 10 && u.C == 11, "local parameters follow A");
    check(u.E == 4, "a parameter after the local ones can be overridden");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
