/*
:section: 7.10 Queues
:summary: Queues are declared with $ as the size and start empty unless initialized.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte bytes [$];
  string words [$] = {"one"};
  integer nums [$] = {6, 5, 4};
  initial begin
    check(bytes.size() == 0, "queue without an initial value is not empty");
    check(words.size() == 1 && words[0] == "one", "queue initialised with one element");
    check(nums.size() == 3 && nums[$] == 4, "queue initialised with three elements");
    nums = {};
    check(nums.size() == 0, "{} is not the empty queue");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
