/*
:section: 6.5 Nets and variables
:summary: A single struct member must not be driven by two continuous assignments.
:type: elaboration
:should_fail_because: one struct member has two continuous assignments
*/
  module top;
    struct { logic [3:0] a; logic [3:0] b; } rec;
assign rec.b = 4'd1;
assign rec.b = 4'd2;
  endmodule
