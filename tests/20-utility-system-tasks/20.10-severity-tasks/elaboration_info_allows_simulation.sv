/*
:section: 20.10.1 Elaboration severity system tasks
:summary: Elaboration-time $warning and $info only print messages and do not stop elaboration or
  simulation.
*/
module checked #(parameter int N = 1);
  if (N > 4) $warning("N = %0d is large", N);
  else $info("N = %0d", N);
  if (N > 100) $error("never reached");
endmodule
module top;
  checked #(.N(9)) a();
  checked #(.N(2)) b();
  initial begin
    $display("PASS");
    $finish;
  end
endmodule
