/*
:section: 6.22.2 Equivalent types
:summary: Packed types of equal width, signedness and state are equivalent, as are same-size
  unpacked arrays.
:description: A ref argument requires an equivalent type (13.5.2), so a successful call shows
  equivalence.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct packed signed { bit [1:0] hi; bit [5:0] lo; } split_byte_t;
  logic [3:0] arr_a [1:3];
  logic [0:3] arr_b [3];
  split_byte_t sb;
  function automatic int width_of(ref byte b);
    return $bits(b);
  endfunction
  function automatic int sum3(ref logic [3:0] f [0:2]);
    return f[0] + f[1] + f[2];
  endfunction
  initial begin
    sb = 8'h81;
    arr_a = '{4'd1, 4'd2, 4'd3};
    arr_b = '{4'd4, 4'd5, 4'd6};
    check(width_of(sb) == 8, "a signed 2-state 8-bit packed struct is not equivalent to byte");
    check(sum3(arr_a) == 6, "an unpacked array with different bounds is not equivalent");
    check(sum3(arr_b) == 15, "an unpacked array of [0:3] elements is not equivalent");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
