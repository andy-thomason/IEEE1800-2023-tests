/*
:section: 23.2.2.4 Default port values
:summary: An omitted input port takes its default value, evaluated in the declaring module's
  scope.
*/
module adder #(parameter int BIAS = 100) (input int a, input int b = BIAS + 1, output int sum);
  assign sum = a + b;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int BIAS = 7;
  int a = 1, s1, s2, s3, sum;
  adder u1(.a(a), .sum(s1));
  adder u2(.a(a), .b(5), .sum(s2));
  adder u3(.*);
  assign s3 = sum;
  initial begin
    #1;
    check(s1 == 102, $sformatf("omitted port used the default from the module's scope: %0d", s1));
    check(s2 == 6, "explicit connection");
    check(s3 == 102, ".* used the default for b");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
