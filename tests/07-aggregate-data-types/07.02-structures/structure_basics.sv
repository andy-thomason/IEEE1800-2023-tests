/*
:section: 7.2 Structures
:summary: Unpacked structs may hold any type and support whole assignment and passing to
  functions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class tag_c; int id = 7; endclass
  typedef struct {
    string name;
    real weight;
    int counts [];
    tag_c tag;
    bit [3:0] flags;
  } record_t;
  function automatic record_t bump(record_t r);
    r.weight += 1.0;
    r.counts[0]++;
    return r;
  endfunction
  record_t a, b;
  initial begin
    a.name = "axle";
    a.weight = 2.5;
    a.counts = new [2];
    a.counts[0] = 4;
    a.tag = new;
    a.flags = 4'b1010;
    b = a;
    check(b.name == "axle" && b.weight == 2.5 && b.tag.id == 7 && b.flags == 4'b1010, "whole-struct assignment");
    b = bump(a);
    check(b.weight == 3.5 && b.counts[0] == 5, "struct passed to and returned from a function");
    check(a.weight == 2.5, "the function changed the caller's copy");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
