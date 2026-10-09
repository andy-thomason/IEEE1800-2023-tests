/*
:section: 5.13 Built-in methods
:summary: Built-in methods called without arguments, or with all arguments defaulted, may omit
  the empty parentheses.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum { RED, GREEN, BLUE } colour_t;
  int q [$] = '{1, 2, 3};
  int dyn [] = new [4];
  string word = "hello";
  colour_t c = RED;
  initial begin
    check(q.size == 3, "queue size without parentheses");
    check(dyn.size == 4, "dynamic array size without parentheses");
    check(word.len == 5, "string len without parentheses");
    check(c.next == GREEN, "enum next (default argument) without parentheses");
    check(c.last == BLUE, "enum last without parentheses");
    check(word.toupper == "HELLO", "string toupper without parentheses");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
