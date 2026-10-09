/*
:section: 6.21 Scope and lifetime
:summary: An initialized variable in a static loop block needs an explicit static or automatic
  keyword.
:type: elaboration
:should_fail_because: a variable in a static block has an initialiser but no static or automatic keyword
*/
module top;
  initial begin
    for (int i = 0; i < 2; i++) begin
      int running = 1;
      running++;
    end
  end
endmodule
