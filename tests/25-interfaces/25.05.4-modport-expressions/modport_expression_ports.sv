/*
:section: 25.5.4 Modport expressions
:summary: Modport expressions expose named slices or values, with port names scoped separately
  per modport.
*/
interface split_if;
  logic [7:0] word;
  int limit_a = 3;
  modport low(output .nib(word[3:0]), input .lim(limit_a));
  modport high(output .nib(word[7:4]), input .lim(12));
endinterface
module writer(interface p);
  initial p.nib = p.lim;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  split_if s();
  writer w_lo(.p(s.low));
  writer w_hi(.p(s.high));
  initial begin
    #1;
    check(s.word == 8'hC3, $sformatf("modport expression writes gave %h", s.word));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
