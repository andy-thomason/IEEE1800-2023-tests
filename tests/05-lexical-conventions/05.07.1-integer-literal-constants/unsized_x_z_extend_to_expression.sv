/*
:section: 5.7.1 Integer literal constants
:summary: Unsized literals whose top digit is x or z extend that value to the full expression
  width.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [63:0] w;
  logic [47:0] v;
  initial begin
    w = 'hz;
    check(w === {64{1'bz}}, $sformatf("'hz in 64 bits = %h", w));
    w = 'bx;
    check(w === {64{1'bx}}, $sformatf("'bx in 64 bits = %h", w));
    v = 'hx5;
    check(v === {{44{1'bx}}, 4'h5}, $sformatf("'hx5 in 48 bits = %h", v));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
