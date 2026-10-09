/*
:section: 8.18 Data hiding and encapsulation
:summary: Local members are visible only inside their class, while protected members are also
  visible to subclasses.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class account_c;
    local int pin = 1234;
    protected int balance = 50;
    function bit same_pin(account_c other); return pin == other.pin; endfunction
    function int peek(); return balance; endfunction
  endclass
  class savings_c extends account_c;
    function void add(int v); balance += v; endfunction
  endclass
  savings_c s1, s2;
  initial begin
    s1 = new; s2 = new;
    check(s1.same_pin(s2), "local member of another instance of the same class");
    s1.add(25);
    check(s1.peek() == 75, "protected member used by a subclass");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
