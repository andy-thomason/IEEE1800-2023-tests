/*
:section: 4.6 Determinism
:summary: Statements in one begin-end block always run in written order, even when suspended and
  interleaved.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  string trail = "";
  event go;
  initial begin
    trail = {trail, "a"};
    #2;
    trail = {trail, "b"};
    @(go);
    trail = {trail, "c"};
    #0;
    trail = {trail, "d"};
  end
  initial begin
    #1  trail = {trail, "1"};
    #2  -> go;
    #1  trail = {trail, "2"};
    #1;
    check(trail == "a1bcd2", $sformatf("execution trail is %s, expected a1bcd2", trail));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
