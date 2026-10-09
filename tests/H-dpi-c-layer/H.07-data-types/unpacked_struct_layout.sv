/*
:section: H.7.8 Unpacked aggregate arguments
:summary: An unpacked struct of unpacked fields matches the layout the platform C compiler would
  use.
:dpi: unpacked_struct_layout.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int count; real scale; byte tag; } rec_t;
  import "DPI-C" function real rec_value(input rec_t r);
  import "DPI-C" function void rec_fill(output rec_t r);
  rec_t r, out;
  initial begin
    r.count = 3; r.scale = 1.5; r.tag = 8'd2;
    check(rec_value(r) == 6.5, "struct fields read in C layout");
    rec_fill(out);
    check(out.count == 7 && out.scale == 0.25 && out.tag == -1, "struct written by C");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
