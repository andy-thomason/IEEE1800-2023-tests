/*
:section: 10.8 Assignment-like contexts
:summary: Assignment patterns take their type from assignment-like contexts such as ports,
  parameters, arguments and return values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int pair_t [2];
  parameter pair_t P = '{3, 4};
  function automatic int sum(pair_t v); return v[0] + v[1]; endfunction
  function automatic pair_t make(); return '{5, 6}; endfunction
  pair_t r;
  bit sel = 1;
  initial begin
    r = sel ? '{1, 2} : '{7, 8};
    check(r[0] == 1, "pattern in a conditional operand");
    r = ('{9, 10});
    check(r[1] == 10, "pattern in parentheses");
    check(P[1] == 4 && sum('{20, 22}) == 42 && make() == pair_t'{5, 6}, "parameter, argument and return contexts");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
