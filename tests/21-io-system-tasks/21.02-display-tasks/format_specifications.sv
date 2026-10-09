/*
:section: 21.2.1.1 Format specifications
:summary: Format specifiers like %d, %h, %o, %b, %c, %s and %% print values in the named form
  with width control.
:expect: [  10] [00a]
  [10] [a]
  [   7] [0003f] [ q]
  [Hi] [str] [17] [1010]
  [2.500] [1.000000e+03] [0.5] [100%]
  [ab] [ab]
*/
module top;
  logic [11:0] r = 12'd10;
  initial begin
    $display("[%d] [%h]", r, r);
    $display("[%0d] [%0h]", r, r);
    $display("[%4d] [%5h] [%2s]", 32'd7, 32'h3f, "q");
    $display("[%c%c] [%s] [%o] [%b]", 8'h48, 8'h69, "str", 6'o17, 4'b1010);
    $display("[%0.3f] [%e] [%g] [100%%]", 2.5, 1000.0, 0.5);
    $display("[%x] [%X]", 8'hab, 8'hab);
    $finish;
  end
endmodule
