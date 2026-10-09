/*
:section: 28.5 buf and not gates
:summary: buf and not gates may drive several outputs, with the final terminal as the input.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic in;
  wire b1, b2, b3, n1, n2;
  buf bb(b1, b2, b3, in);
  not nn(n1, n2, in);
  initial begin
    in = 1; #1;
    check(b1 === 1 && b2 === 1 && b3 === 1 && n1 === 0 && n2 === 0, "all outputs follow the single input");
    in = 1'bz; #1;
    check(b1 === 1'bx && n1 === 1'bx, $sformatf("z input gives buf %b not %b", b1, n1));
    in = 1'bx; #1;
    check(b3 === 1'bx && n2 === 1'bx, "x input");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
