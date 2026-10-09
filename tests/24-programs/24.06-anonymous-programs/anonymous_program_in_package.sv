/*
:section: 24.6 Program-wide space and anonymous programs
:summary: An anonymous program inside a package adds program-only items without creating a new
  scope.
:timeout: 30
*/
package tb_utils;
  program;
    function automatic int checksum(int a, int b); return a ^ b; endfunction
    int calls;
  endprogram
endpackage
module top;
  t u();
endmodule
program t;
  initial begin
    tb_utils::calls++;
    if (tb_utils::checksum(6, 3) == 5 && tb_utils::calls == 1) $display("PASS");
    else $display("FAIL: anonymous program items");
  end
endprogram
