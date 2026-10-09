/*
:section: 6.20.3 Type parameters
:summary: A parameter type lets each instance choose the data type used by its ports and
  variables.
*/
typedef struct packed { logic [2:0] a; logic [9:0] b; } pair_t;

module holder #(parameter type T = shortint) (input T in, output T out);
  assign out = in;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  shortint s_in = -5, s_out;
  pair_t p_in = '{3'd5, 10'd700}, p_out;
  holder u_default(.in(s_in), .out(s_out));
  holder #(.T(pair_t)) u_struct(.in(p_in), .out(p_out));
  initial begin
    #1;
    check(s_out == -5 && $bits(s_out) == 16, "default type parameter");
    check(p_out.b == 700 && $bits(u_struct.out) == 13, "struct type parameter");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
