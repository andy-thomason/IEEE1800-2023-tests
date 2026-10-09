/*
:section: 29.8 UDP instances
:summary: A UDP can be instantiated as an array by giving a range after the instance name.
*/
primitive majority3 (y, a, b, c);
  output y;
  input a, b, c;
  table
    // a b c : y
    1 1 ? : 1;
    1 ? 1 : 1;
    ? 1 1 : 1;
    0 0 ? : 0;
    0 ? 0 : 0;
    ? 0 0 : 0;
  endtable
endprimitive

  module top;
    int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
    logic [3:0] a = 4'b1010, b = 4'b1100, c = 4'b0110;
    wire [3:0] y;
    majority3 arr[3:0] (y, a, b, c);
    initial begin
      #1;
      check(y == 4'b1110, $sformatf("array of UDP instances gave %b", y));
      if (errors == 0) $display("PASS");
    $finish;
    end
  endmodule
