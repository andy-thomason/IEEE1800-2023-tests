/*
:section: 6.20.2 Value parameters
:summary: Parameter type, sign and range derive from the declaration and from the final
  overriding value.
*/
module params;
  parameter P_PLAIN = 5'b10101;
  parameter P_REAL = 1;
  parameter [5:0] P_RANGE = 3;
  parameter signed [7:0] P_SRANGE = 1;
  parameter signed P_SIGNED = 4'sb0001;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  params #(.P_PLAIN(8'hFF), .P_REAL(2.5), .P_RANGE(-1), .P_SRANGE(9'h1FF), .P_SIGNED(4'sb1000)) u();
  initial begin
    check($bits(u.P_PLAIN) == 8 && u.P_PLAIN == 255, "untyped parameter takes the override's size");
    check(u.P_REAL == 2.5, "untyped parameter becomes real when overridden with a real");
    check($bits(u.P_RANGE) == 6 && u.P_RANGE == 63 && u.P_RANGE > 0, "ranged parameter keeps [5:0] and is unsigned");
    check($bits(u.P_SRANGE) == 8 && u.P_SRANGE == -1, "signed ranged parameter keeps 8 bits and is signed");
    check($bits(u.P_SIGNED) == 4 && u.P_SIGNED < 0, "signed parameter takes the override's range");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
