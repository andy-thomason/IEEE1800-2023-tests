/*
:section: 21.3.3 Formatting data to a string
:summary: $swrite formats like $fwrite into a string, while $sformat takes its format only from
  the second argument.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s;
  int a, b, n;
  initial begin
    $swrite(s, "x=", 5, " y=", 6);
    check(s == "x=5 y=6" || s == "x=          5 y=          6", $sformatf("$swrite gave '%s'", s));
    $sformat(s, "%0d-%s", 42, "z");
    check(s == "42-z", "$sformat");
    check($sformatf("%03d|%h", 7, 8'hA) == "007|0a", $sformatf("$sformatf gave %s", $sformatf("%03d|%h", 7, 8'hA)));
    n = $sscanf("10 0x1f", "%d %h", a, b);
    check(n == 2 && a == 10 && b == 31, $sformatf("$sscanf read %0d items: %0d %0d", n, a, b));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
