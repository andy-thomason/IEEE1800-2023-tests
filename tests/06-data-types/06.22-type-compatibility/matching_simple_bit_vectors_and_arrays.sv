/*
:section: 6.22.1 Matching types
:summary: Bit vectors match predefined types of equal width, sign and state; arrays match by
  element and size.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef logic signed [31:0] my_integer_t;
  typedef logic signed [0:31] reversed_t;
  typedef bit signed [63:0] my_longint_t;
  typedef shortint words_t [16];
  typedef bit signed [15:0] my_words_t [16];
  typedef int quad_a_t [1:4];
  typedef int quad_b_t [4];
  typedef logic [1:0][3:0] nibbles_t;
  typedef logic [7:0] octet_t;
  typedef int q1_t [$];
  typedef int d1_t [];
  typedef int signed sint_t;
  typedef bit unsigned [3:0] ubits_t;
  initial begin
    check(type(my_integer_t) == type(integer), "logic signed [31:0] does not match integer");
    check(type(reversed_t) != type(integer), "logic signed [0:31] matches integer");
    check(type(my_longint_t) == type(longint), "bit signed [63:0] does not match longint");
    check(type(words_t) == type(my_words_t), "arrays of matching elements and bounds do not match");
    check(type(quad_a_t) != type(quad_b_t), "fixed arrays with different bounds match");
    check(type(nibbles_t) != type(octet_t), "logic [1:0][3:0] matches logic [7:0]");
    check(type(q1_t) != type(d1_t), "a queue matches a dynamic array");
    check(type(sint_t) == type(int) && type(ubits_t) == type(bit [3:0]), "redundant signing changed the type");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
