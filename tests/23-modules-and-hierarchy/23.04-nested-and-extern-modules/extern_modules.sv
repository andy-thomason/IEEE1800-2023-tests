/*
:section: 23.5 Extern modules
:summary: An extern module declaration gives ports and parameters, letting the module be
  instantiated before its definition.
*/
extern module scaler #(parameter int K = 2) (input int a, output int y);

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int y;
  scaler #(.K(3)) u(.a(5), .y(y));
  initial begin
    #1;
    check(y == 15, $sformatf("extern-declared module output %0d", y));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

module scaler (.*);
  assign y = a * K;
endmodule
