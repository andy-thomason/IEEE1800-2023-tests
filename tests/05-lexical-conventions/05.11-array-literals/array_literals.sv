/*
:section: 5.11 Array literals
:summary: Array literals nest braces per dimension and may use replication, index keys and
  default.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int quad_t [0:3];
  int table3 [0:2][0:1] = '{'{7, 8}, '{2{-1}}, '{0, 4}};
  int checks [0:2][0:3] = '{3{'{2{1, 0}}}};
  quad_t keyed = '{2: 5, default: 1};
  function automatic int total(quad_t q);
    return q[0] + q[1] + q[2] + q[3];
  endfunction
  initial begin
    check(table3[0][0] == 7 && table3[2][1] == 4, "outer and inner braces follow the dimensions");
    check(table3[1][0] == -1 && table3[1][1] == -1, "replication within one row");
    check(checks[0][0] == 1 && checks[0][1] == 0 && checks[2][2] == 1 && checks[1][3] == 0, "nested replication");
    check(keyed[0] == 1 && keyed[2] == 5 && keyed[3] == 1, "index key with default");
    check(total(quad_t'{4, 3, 2, 1}) == 10, "typed array literal as an argument");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
