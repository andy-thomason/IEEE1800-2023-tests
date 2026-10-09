/*
:section: 5.12 Attributes
:summary: When an attribute name repeats on one element, the final value wins and the object is
  unaffected.
:description: Only acceptance is checked; reading the chosen value needs the VPI.
*/
module top;
  (* level = 1, level = 2 *) int v = 5;
  (* mark *) (* mark = 0 *) int w = 6;
  initial begin
    if (v != 5 || w != 6) $display("FAIL: values changed");
    else $display("PASS");
    $finish;
  end
endmodule
