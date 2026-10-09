/*
:section: 8.26 Interface classes
:summary: Classes implementing an interface class can be assigned to its handles and cast
  between implemented interfaces.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  interface class scorer_ic #(type T = int);
    pure virtual function T score();
  endclass
  interface class labelled_ic;
    typedef bit [5:0] code_t;
    pure virtual function string label();
  endclass
  class tile_c #(type T = int) implements scorer_ic #(T), labelled_ic;
    T points;
    function new(T p); points = p; endfunction
    virtual function T score(); return points * 2; endfunction
    virtual function string label(); return "tile"; endfunction
  endclass
  tile_c #(shortint) t;
  scorer_ic #(shortint) s;
  labelled_ic l;
  initial begin
    t = new(21);
    s = t;
    check(s.score() == 42, "call through an interface class handle");
    check($cast(l, s), "cast between interface class handles");
    check(l.label() == "tile", "call through the second implemented interface");
    check($bits(labelled_ic::code_t) == 6, "type from an interface class");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
