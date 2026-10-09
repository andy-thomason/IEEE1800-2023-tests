/*
:section: 6.16 String data type
:summary: NUL characters are removed from literals assigned to strings, and writing 0 to a
  character is ignored.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string s = "pq\0rs";
  initial begin
    check(s == "pqrs" && s.len() == 4, $sformatf("\"pq\\0rs\" gave '%s' (length %0d)", s, s.len()));
    s[1] = 0;
    check(s == "pqrs", $sformatf("assigning 0 to a character changed the string to '%s'", s));
    s = "\0\0";
    check(s.len() == 0, "a literal of only NUL characters did not give the empty string");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
