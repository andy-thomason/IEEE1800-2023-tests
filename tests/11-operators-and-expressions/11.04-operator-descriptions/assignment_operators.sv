/*
:section: 11.4.1 Assignment operators
:summary: Compound assignment operators such as += and <<= behave like the equivalent expanded
  assignment, evaluating the target once.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int v;
  logic signed [7:0] s;
  int arr [4];
  int k;
  function automatic int next_index(); k++; return k; endfunction
  initial begin
    v = 10; v += 5; v -= 3; v *= 2; v /= 4; v %= 4;
    check(v == 2, "arithmetic assignment operators");
    v = 6; v &= 3; v |= 8; v ^= 1;
    check(v == 11, "bitwise assignment operators");
    v = 1; v <<= 3; v >>= 1;
    check(v == 4, "logical shift assignment operators");
    s = -8; s >>>= 1;
    check(s == -4, "arithmetic shift assignment");
    s <<<= 2;
    check(s == -16, "<<<= ");
    k = 0;
    arr[next_index()] += 7;
    check(k == 1 && arr[1] == 7, "the left-hand index was evaluated more than once");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
