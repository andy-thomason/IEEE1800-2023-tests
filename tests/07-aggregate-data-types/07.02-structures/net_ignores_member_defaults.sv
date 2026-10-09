/*
:section: 7.2.2 Assigning to structures
:summary: Member default values in a struct type do not apply to nets declared with that type.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { logic [3:0] level = 4'd5; logic flag = 1'b1; } sig_t;
  wire sig_t undriven_net;
  sig_t variable;
  initial begin
    #1;
    check(variable.level == 5, "the variable did not get the member default");
    check(undriven_net.level === 4'bzzzz && undriven_net.flag === 1'bz, "the net used the member defaults instead of z");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
