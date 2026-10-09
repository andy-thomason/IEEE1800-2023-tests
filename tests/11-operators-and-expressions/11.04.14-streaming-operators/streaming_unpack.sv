/*
:section: 11.4.14.3 Streaming concatenation as an assignment target (unpack)
:summary: A streaming concatenation used as an assignment target splits the source bits into the
  listed variables.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte a, b, c;
  logic [3:0] n1, n2;
  int q [$];
  initial begin
    {>> {a, b, c}} = 24'h11_22_33;
    check(a == 8'h11 && c == 8'h33, "unpack left to right");
    {<< byte {a, b, c}} = 24'h11_22_33;
    check(a == 8'h33 && c == 8'h11, "unpack right to left by byte");
    {>> {n1, n2}} = 12'hABC;
    check(n1 == 4'hA && n2 == 4'hB, "extra source bits are taken from the left");
    {>> {q}} = 64'h0000_0001_0000_0002;
    check(q.size() == 2 && q[1] == 2, "unpack into a queue");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
