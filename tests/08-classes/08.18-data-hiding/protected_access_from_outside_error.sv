/*
:section: 8.18 Data hiding and encapsulation
:summary: A protected class member cannot be accessed from code outside the class hierarchy.
:type: elaboration
:should_fail_because: a protected member is read from outside the class hierarchy
*/
module top;
  class account_c; protected int balance; endclass
    account_c a = new;
    int x;
    initial x = a.balance;
endmodule
