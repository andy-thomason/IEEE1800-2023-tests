/*
:section: 25.3 Interface syntax
:summary: Interfaces can be instantiated with parameter overrides and as arrays of instances,
  like modules.
*/
interface word_if #(parameter int W = 8);
  logic [W-1:0] value;
endinterface

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  word_if #(16) one();
  word_if #(.W(4)) many [2:0] ();
  word_if plain();
  initial begin
    #1;
    check($bits(one.value) == 16 && $bits(many[2].value) == 4 && $bits(plain.value) == 8, "parameterised widths");
    many[0].value = 4'h9;
    many[2].value = 4'h1;
    #1;
    check(many[0].value == 4'h9 && many[2].value == 4'h1, "instance array elements are separate");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
