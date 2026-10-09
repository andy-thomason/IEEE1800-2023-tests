/*
:section: 6.24.3 Bit-stream casting
:summary: Bit-stream casts into dynamic members give the first dynamic item all leftover bits.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { byte head; byte body []; byte rest [$]; } msg_t;
  msg_t m;
  initial begin
    m = msg_t'(32'hA1B2C3D4);
    check(m.head == 8'hA1, "fixed field");
    check(m.body.size() == 3 && m.body[0] == 8'hB2 && m.body[2] == 8'hD4, "first dynamic field is greedy");
    check(m.rest.size() == 0, "later dynamic field is not empty");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
