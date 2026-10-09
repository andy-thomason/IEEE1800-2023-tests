/*
:section: 10.9.1 Array assignment patterns
:summary: Array assignment patterns support replication, index keys, type keys and default
  entries.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int row_t [3];
  int a [4];
  int b [2][3];
  logic [7:0] mixed [3];
  initial begin
    a = '{4{7}};
    check(a[0] == 7 && a[3] == 7, "replication");
    a = '{1: 5, 3: 6, default: 0};
    check(a[0] == 0 && a[1] == 5 && a[3] == 6, "index keys with default");
    b = '{default: 9};
    check(b[1][2] == 9, "default descends into subarrays");
    b = '{row_t: '{1, 2, 3}};
    check(b[0][1] == 2 && b[1][2] == 3, "type key for subarrays");
    b = '{2{'{3{4}}}};
    check(b[1][0] == 4, "nested replication");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
