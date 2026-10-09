/*
:section: 10.10 Unpacked array concatenation
:summary: Unpacked array concatenation builds an array from elements and arrays whose items
  match the target element type.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int three [3] = '{1, 2, 3};
  int nine [9];
  int q [$];
  string words [];
  class obj_c; endclass
  obj_c handles [2];
  initial begin
    nine = {three, 4, 5, three, 6};
    check(nine[3] == 4 && nine[5] == 1 && nine[8] == 6, "elements and arrays mixed");
    q = {};
    check(q.size() == 0, "empty concatenation");
    q = {q, 8, three};
    check(q.size() == 4 && q[1] == 1, "queue built from itself");
    words = {"ab", "cd"};
    check(words.size() == 2 && words[1] == "cd", "string elements");
    handles = {null, null};
    check(handles[0] == null, "null elements for class handles");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
