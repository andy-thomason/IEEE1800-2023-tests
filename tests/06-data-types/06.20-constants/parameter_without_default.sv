/*
:section: 6.20.1 Parameter declaration syntax
:summary: A parameter port without a default is legal when every instance supplies a value.
*/
module needs_value #(parameter int N);
  int seen = N;
endmodule

module top;
  needs_value #(.N(12)) u();
  initial begin
    #1;
    if (u.seen != 12) $display("FAIL: N = %0d", u.seen);
    else $display("PASS");
    $finish;
  end
endmodule
