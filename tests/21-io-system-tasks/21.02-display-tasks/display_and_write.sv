/*
:section: 21.2.1 The display and write tasks
:summary: $display adds a trailing newline while $write does not, and the b, o and h variants
  change the radix.
:expect: part1 part2
  10
  0a
  00001010
  012
  a b
*/
module top;
  logic [7:0] v = 8'd10;
  initial begin
    $write("part1 ");
    $write("part2");
    $display;
    $display(v);
    $displayh(v);
    $displayb(v);
    $displayo(v);
    $display("a", , "b");
    $finish;
  end
endmodule
