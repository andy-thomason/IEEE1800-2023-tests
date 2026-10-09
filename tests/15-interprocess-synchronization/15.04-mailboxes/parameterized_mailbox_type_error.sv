/*
:section: 15.4.9 Parameterized mailboxes
:summary: A parameterized mailbox rejects at compile time any attempt to receive into a
  different type.
:type: elaboration
:should_fail_because: a string is received from a mailbox of int
*/
module top;
  mailbox #(int) mb = new;
  string s;
  initial mb.get(s);
endmodule
