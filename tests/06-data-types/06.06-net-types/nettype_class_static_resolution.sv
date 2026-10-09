/*
:section: 6.6.7 User-defined nettypes
:summary: A nettype resolution function may be a static method of a parameterized class.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class merge #(parameter int W = 8);
    typedef bit [W-1:0] T;
    static function T or_all(input T drivers []);
      or_all = '0;
      foreach (drivers[i]) or_all |= drivers[i];
    endfunction
  endclass
  typedef merge#(4) merge4_t;
  typedef merge#(12) merge12_t;
  nettype merge4_t::T or4_net with merge4_t::or_all;
  nettype merge12_t::T or12_net with merge12_t::or_all;
  or4_net n4;
  or12_net n12;
  assign n4 = 4'b0011;
  assign n4 = 4'b0100;
  assign n12 = 12'h800;
  assign n12 = 12'h001;
  initial begin
    #1;
    check(n4 == 4'b0111 && $bits(n4) == 4, "4-bit OR resolution");
    check(n12 == 12'h801 && $bits(n12) == 12, "12-bit OR resolution");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
