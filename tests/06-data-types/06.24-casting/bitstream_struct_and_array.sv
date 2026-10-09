/*
:section: 6.24.3 Bit-stream casting
:summary: Explicit casts convert unpacked structs, arrays, queues and strings to and from bit
  streams.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { byte tag; bit [5:0] code; bit [1:0] pair [3]; } frame_t;
  typedef bit flat_t [20];
  typedef logic [19:0] packed_t;
  typedef byte bytes_t [$];
  frame_t f, g;
  flat_t flat;
  bytes_t q;
  string s = "Hi";
  initial begin
    f.tag = 8'h3C; f.code = 6'h2A; f.pair = '{2'd1, 2'd2, 2'd3};
    flat = flat_t'(f);
    check(flat[0] == 1'b0 && flat[2] == 1'b1, "struct to unpacked bits");
    g = frame_t'(flat);
    check(g.tag == 8'h3C && g.code == 6'h2A && g.pair[2] == 3, "unpacked bits back to struct");
    check(packed_t'(f) === {8'h3C, 6'h2A, 2'd1, 2'd2, 2'd3}, "struct to packed");
    q = '{8'h12, 8'h34, 8'h56, 8'h78};
    check(int'(q) == 32'h12345678, "queue to int: index 0 should be the MSBs");
    check(shortint'(s) == 16'h4869, "string to shortint");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
