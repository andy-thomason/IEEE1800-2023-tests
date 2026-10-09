/*
:section: 11.4.14.1 Concatenation of stream_expressions
:summary: A streaming concatenation flattens integral values, unpacked arrays, queues and
  structures into one bit stream before reordering.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { byte a; shortint b; } pair_t;
  pair_t p;
  byte q [$] = '{8'h11, 8'h22};
  string s = "AB";
  logic [23:0] r24;
  logic [31:0] r32;
  logic [15:0] r16;
  initial begin
    p.a = 8'hAA; p.b = 16'hBBCC;
    r24 = {>> {p}};
    check(r24 == 24'hAABBCC, "unpacked struct streamed member by member");
    r32 = {>> {q, s}};
    check(r32 == 32'h1122_4142, "queue and string streamed in order");
    r16 = {<< byte {s}};
    check(r16 == "BA", "string streamed right to left by byte");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
