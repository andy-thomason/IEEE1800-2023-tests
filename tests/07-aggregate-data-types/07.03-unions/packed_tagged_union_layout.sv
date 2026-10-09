/*
:section: 7.3.2 Tagged unions
:summary: Packed tagged union width equals tag bits plus the widest member, with the tag
  occupying the MSBs.
:description: Tags are numbered in declaration order (0, 1, 2).
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef union tagged packed { void Empty; bit [7:0] Byte; bit [3:0] Nibble; } item_t;
  item_t v;
  initial begin
    check($bits(item_t) == 10, $sformatf("$bits = %0d, expected 2 tag bits + 8", $bits(item_t)));
    v = tagged Byte 8'hA5;
    check(v[9:8] == 2'd1 && v[7:0] == 8'hA5, $sformatf("Byte layout %b", v));
    v = tagged Nibble 4'h7;
    check(v[9:8] == 2'd2 && v[3:0] == 4'h7, $sformatf("Nibble layout %b", v));
    v = tagged Empty;
    check(v[9:8] == 2'd0, "Empty tag");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
