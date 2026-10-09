/*
:section: 11.4.12.1 Replication operator
:summary: Concatenations and replications build packed values whose bits can be selected, with
  zero-count replications allowed alongside sized items.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int Z = 0;
  logic [3:0] a = 4'hA, b = 4'h5;
  logic [7:0] r;
  int calls = 0;
  function automatic logic [1:0] noisy(); calls++; return 2'b11; endfunction
  initial begin
    r = {a, b};             check(r == 8'hA5, "concatenation");
    r = {2{a}};             check(r == 8'hAA, "replication");
    r = {b, {Z{1'b1}}, a};  check(r == 8'h5A, "zero replication inside a concatenation is ignored");
    r = {4{noisy()}};       check(calls == 1, $sformatf("operand evaluated %0d times", calls));
    r = {a, {Z{noisy()}}, b};
    check(calls == 2, "operand of a zero replication not evaluated once");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
