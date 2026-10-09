/*
:section: 9.4.2.2 Implicit event_expression list
:summary: An @* implicit sensitivity list includes signals read on right-hand sides, in
  conditions and as indices.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [1:0] sel = 0, idx = 0;
  logic a = 0, b = 0, c = 0;
  logic [3:0] out;
  int runs = 0;
  function automatic void count_run(); runs++; endfunction
  always @* begin
    count_run();
    out = 0;
    case (sel)
      2'd1: out[idx] = a;
      default: out[idx] = b ? c : 1'b0;
    endcase
  end
  initial begin
    #1 sel = 1;    #1 a = 1;   #1 idx = 2;
    #1 sel = 0;    #1 b = 1;   #1 c = 1;
    #1;
    check(runs == 6, $sformatf("@* reacted %0d times, expected 6", runs));
    check(out == 4'b0100, $sformatf("out = %b", out));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
