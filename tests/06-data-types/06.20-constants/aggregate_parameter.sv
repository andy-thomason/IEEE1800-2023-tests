/*
:section: 6.20.2 Value parameters
:summary: Aggregate parameters such as unpacked arrays and structs are overridden whole, but
  members may be read.
*/
typedef struct { int lo; int hi; } bounds_t;

module table_user #(parameter int TABLE [3] = '{1, 2, 3}, parameter bounds_t LIMITS = '{0, 9});
  int total = TABLE[0] + TABLE[1] + TABLE[2];
  int span = LIMITS.hi - LIMITS.lo;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  table_user u_default();
  table_user #(.TABLE('{10, 20, 30}), .LIMITS('{5, 25})) u_override();
  initial begin
    #1;
    check(u_default.total == 6 && u_default.span == 9, "default aggregate parameters");
    check(u_override.total == 60 && u_override.span == 20, "aggregate parameters overridden as a whole");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
