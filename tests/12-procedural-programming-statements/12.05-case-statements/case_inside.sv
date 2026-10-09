/*
:section: 12.5.4 Set membership case statement
:summary: In case inside, items are matched using set membership, allowing ranges and wildcard
  bits.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int taken;
  int v;
  logic [3:0] bits;
  initial begin
    v = 7;
    case (v) inside
      [0:3]: taken = 1;
      [4:8], 20: taken = 2;
      default: taken = 0;
    endcase
    check(taken == 2, "range item");
    bits = 4'b1010;
    case (bits) inside
      4'b1?1?: taken = 3;
      default: taken = 0;
    endcase
    check(taken == 3, "wildcard item");
    bits = 4'b1x10;
    case (bits) inside 4'b1010: taken = 4; default: taken = 0; endcase
    check(taken == 0, "x in the case expression does not match a known item");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
