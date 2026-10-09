/*
:section: 5.9.1 Special characters in strings
:summary: Three backslashes before a newline give one backslash character and then a line
  continuation.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "end\\\
next";
  initial begin
    check(s == {"end", 8'd92, "next"}, $sformatf("got \"%s\"", s));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
