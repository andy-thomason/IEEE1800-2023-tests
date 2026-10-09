/*
:section: 12.5 Case statement
:summary: A case statement may not contain more than one default item.
:type: elaboration
:should_fail_because: a case statement has two default items
*/
module top;
  logic [1:0] s;
  int t;
  initial case (s)
    2'd0: t = 0;
    default: t = 1;
    default: t = 2;
  endcase
endmodule
