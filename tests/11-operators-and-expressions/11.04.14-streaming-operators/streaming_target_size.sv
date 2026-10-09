/*
:section: 11.4.14 Streaming operators (pack/unpack)
:summary: A stream assigned to a wider fixed-size target is padded with zeros on the right;
  dynamic targets resize.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [11:0] r12;
  byte q [$];
  initial begin
    r12 = {>> {8'hA5}};
    check(r12 == 12'hA50, "stream widened on the right");
    q = {>> {20'hABCDE}};
    check(q.size() == 3 && q[0] == 8'hAB && q[2] == 8'hE0, "queue resized to three bytes, padded on the right");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
