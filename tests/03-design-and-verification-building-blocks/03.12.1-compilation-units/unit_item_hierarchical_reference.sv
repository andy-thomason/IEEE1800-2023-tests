/*
:section: 3.12.1 Compilation units
:summary: A compilation-unit function may use a hierarchical reference such as top.counter,
  resolved like a top-level element.
*/
function automatic int read_counter();
  return top.counter;
endfunction

module top;
  int counter = 9;
  initial begin
    #1;
    if (read_counter() != 9) $display("FAIL: read_counter() = %0d", read_counter());
    else $display("PASS");
    $finish;
  end
endmodule
