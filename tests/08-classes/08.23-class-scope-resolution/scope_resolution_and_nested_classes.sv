/*
:section: 8.23 Class scope resolution operator ::
:summary: The :: operator reaches static members, parent members, nested classes and types from
  outside or within a class.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class outer_c;
    typedef enum {IDLE, BUSY} mode_t;
    localparam int LIMIT = 8;
    static int hits = 0;
    local static int secret = 5;
    static function void hit(); hits++; endfunction
    class inner_c;
      function int peek(); return secret + LIMIT; endfunction
    endclass
  endclass
  outer_c::mode_t m;
  outer_c::inner_c in_obj;
  initial begin
    m = outer_c::BUSY;
    outer_c::hit();
    check(m == outer_c::BUSY && outer_c::LIMIT == 8 && outer_c::hits == 1, "class scope access");
    in_obj = new;
    check(in_obj.peek() == 13, "nested class reads local static members of its container");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
