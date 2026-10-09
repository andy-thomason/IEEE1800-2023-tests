/*
:section: 7.3 Unions
:summary: An uninitialized unpacked union takes the first member's default, and shared struct
  prefixes are readable.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  union { logic [7:0] first; int second; } fresh4;
  union { int first; logic [7:0] second; } fresh2;
  typedef struct { byte kind; int length; } header_t;
  typedef struct { byte kind; int length; real scale; } scaled_t;
  union { header_t h; scaled_t s; } msg;
  initial begin
    check(fresh4.first === 8'hxx, "union default is not the first member's default (x)");
    check(fresh2.first === 0, "union default is not the first member's default (0)");
    msg.s.kind = 8'd3;
    msg.s.length = 40;
    msg.s.scale = 0.5;
    check(msg.h.kind == 3 && msg.h.length == 40, "common initial sequence read through the other struct");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
