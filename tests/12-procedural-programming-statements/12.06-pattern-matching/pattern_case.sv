/*
:section: 12.6.1 Pattern matching in case statements
:summary: A pattern-matching case evaluates its selector once and binds pattern variables from
  the first matching tagged pattern.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef union tagged { void None; int Some; } maybe_t;
  typedef union tagged {
    struct { bit [3:0] x, y; } Sum;
    union tagged { bit [7:0] Near; bit [7:0] Far; } Branch;
  } op_t;
  maybe_t v;
  op_t ins;
  int result;
  initial begin
    v = tagged Some 9;
    case (v) matches
      tagged None: result = -1;
      tagged Some .n &&& (n > 5): result = n * 2;
      tagged Some .n: result = n;
    endcase
    check(result == 18, "tagged pattern with a filter");
    ins = tagged Branch (tagged Far 8'd3);
    case (ins) matches
      tagged Sum '{.a, .b}: result = a + b;
      tagged Branch (tagged Near .t): result = 100 + t;
      tagged Branch (tagged Far .*): result = 200;
    endcase
    check(result == 200, "nested pattern with a wildcard");
    ins = tagged Sum '{4'd2, 4'd5};
    case (ins) matches
      tagged Sum '{.a, 4'd5}: result = a;
      default: result = 0;
    endcase
    check(result == 2, "constant inside a struct pattern");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
