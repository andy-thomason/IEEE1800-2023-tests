/*
:section: 35.5.6.1 Open arrays
:summary: An open unpacked array formal accepts fixed-size actuals of different lengths.
:dpi: open_unpacked_arrays.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int sum_open(input int values []);
  int three [3] = '{1, 2, 3};
  int five [5] = '{10, 20, 30, 40, 50};
  initial begin
    check(sum_open(three) == 6, "fixed array of 3");
    check(sum_open(five) == 150, "fixed array of 5");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
