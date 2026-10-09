/*
:section: 8.18 Data hiding and encapsulation
:summary: A local class member cannot be accessed from outside the class.
:type: elaboration
:should_fail_because: a local member is read from outside the class
*/
module top;
  class account_c; local int pin; endclass
    account_c a = new;
    int x;
    initial x = a.pin;
endmodule
