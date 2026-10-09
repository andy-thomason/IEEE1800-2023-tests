/*
:section: 6.14 Chandle data type
:summary: Chandles start as null, pass through DPI and subroutines, and support only equality
  tests and assignment.
:description: Uses C functions imported through DPI-C to create, use and free a heap object.
:dpi: chandle_dpi_round_trip.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function chandle counter_new(input int start);
  import "DPI-C" function int counter_next(input chandle h);
  import "DPI-C" function void counter_free(input chandle h);
  import "DPI-C" function int handle_is_null(input chandle h);
  class owner;
    chandle h;
  endclass
  function automatic chandle pass_through(chandle h);
    return h;
  endfunction
  chandle a, b, unset;
  int names [chandle];
  owner o = new;
  initial begin
    check(unset == null && unset === null, "default chandle is not null");
    check(handle_is_null(unset) == 1, "null chandle is not 0 on the C side");
    a = counter_new(10);
    check(a != null && a !== null, "new handle is null");
    b = pass_through(a);
    check(b == a && b === a, "copied handle differs");
    check(counter_next(b) == 11 && counter_next(a) == 12, "both handles do not reach the same C object");
    names[a] = 1;
    check(names.exists(b), "chandle as an associative array key");
    o.h = a;
    check(counter_next(o.h) == 13, "chandle stored in a class");
    counter_free(a);
    a = null;
    check(a == null && a != b, "assignment to null");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
