/*
:section: 11.4.13 Set membership operator
:summary: An inside expression yields 1'b1 when the value matches any listed item, range or
  array element, else 1'b0.
*/
module top;
  int primes [] = '{2, 3, 5, 7};
  int v;
  initial begin
    v = 5;
    if ((v inside {1, primes}) !== 1'b1) $display("FAIL: 5 not found via array member");
    else if ((v inside {[10:20], 4}) !== 1'b0) $display("FAIL: 5 found in {[10:20], 4}");
    else if ((15 inside {[10:20]}) !== 1'b1) $display("FAIL: 15 not inside [10:20]");
    else if ((v inside {5, 5, [4:6]}) !== 1'b1) $display("FAIL: overlapping set members");
    else $display("PASS");
    $finish;
  end
endmodule
