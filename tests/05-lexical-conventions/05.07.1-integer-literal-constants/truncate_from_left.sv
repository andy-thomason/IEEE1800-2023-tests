/*
:section: 5.7.1 Integer literal constants
:summary: Digits exceeding the declared literal width are discarded from the most significant
  end.
:flags-verilator: -Wno-WIDTH
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    check(4'hABC === 4'hC, "4'hABC was not truncated to 4'hC");
    check(6'b1110001 === 6'b110001, "6'b1110001 was not truncated to 6'b110001");
    check(3'o17 === 3'o7, "3'o17 was not truncated to 3'o7");
    check(5'd100 === 5'd4, "5'd100 was not truncated to 5'd4");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
