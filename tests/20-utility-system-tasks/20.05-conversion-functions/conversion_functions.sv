/*
:section: 20.5 Conversion functions
:summary: $rtoi truncates reals toward zero unlike casting, and $itor, $realtobits and
  $bitstoreal convert between forms.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic bit near(real got, real want); return (got - want < 1.0e-9) && (want - got < 1.0e-9); endfunction
    real r;
    shortreal s;
  initial begin
    check($rtoi(7.9) == 7 && $rtoi(-7.9) == -7 && int'(7.9) == 8, "$rtoi truncates, a cast rounds");
    check(near($itor(-12), -12.0), "$itor");
    r = 3.25;
    check(near($bitstoreal($realtobits(r)), r), "$realtobits / $bitstoreal round trip");
    s = 0.75;
    check($bitstoshortreal($shortrealtobits(s)) == s && $shortrealtobits(s) == 32'h3F40_0000, "shortreal conversions");
    check($signed(4'b1110) == -2 && $unsigned(-1) > 0, "$signed / $unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
