/*
:section: 7.3.2 Tagged unions
:summary: Tagged unions support void members, nesting, and dynamic types, with tagged
  expressions for values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef union tagged { void Empty; byte Code; } slot_t;
  typedef union tagged {
    union tagged { shortint Celsius; void Unknown; } Temp;
    struct { bit [5:0] row; bit [5:0] col; } Pos;
  } reading_t;
  typedef union tagged { int Samples []; string Note; } payload_t;
  slot_t s;
  reading_t r;
  payload_t p;
  initial begin
    s = tagged Code 8'h21;
    check(s.Code == 8'h21, "void/byte tagged union");
    s = tagged Empty;
    r = tagged Temp (tagged Celsius -16'sd4);
    check(r.Temp.Celsius == -4, "nested tagged union");
    r = tagged Pos '{row: 6'd3, col: 6'd9};
    check(r.Pos.col == 9, "struct member of a tagged union");
    p = tagged Note "go";
    check(p.Note == "go", "string member of a tagged union");
    p = tagged Samples '{1, 2, 3};
    check(p.Samples.size() == 3, "dynamic array member of a tagged union");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
