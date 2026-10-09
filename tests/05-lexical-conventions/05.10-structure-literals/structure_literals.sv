/*
:section: 5.10 Structure literals
:summary: Structure literals need a type from a cast or context and may use member names or
  default.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int count; real ratio; byte tag; } rec_t;
  typedef struct { rec_t inner; int extra; } outer_t;
  rec_t r;
  outer_t o;
  function automatic int sum(rec_t x);
    return x.count + x.tag;
  endfunction
  initial begin
    r = '{3, 0.5, 8'd65};
    check(r.count == 3 && r.ratio == 0.5 && r.tag == 65, "positional literal from context");
    r = '{tag: 8'd2, count: 9, ratio: 1.25};
    check(r.count == 9 && r.ratio == 1.25 && r.tag == 2, "member name keys");
    r = '{default: 0};
    check(r.count == 0 && r.ratio == 0.0 && r.tag == 0, "default key");
    r = rec_t'{int: 4, real: 2.0, default: 1};
    check(r.count == 4 && r.ratio == 2.0 && r.tag == 1, "type keys with an explicit type prefix");
    check(sum(rec_t'{10, 0.0, 8'd5}) == 15, "typed literal as a function argument");
    o = '{'{1, 1.5, 8'd7}, 8};
    check(o.inner.count == 1 && o.inner.tag == 7 && o.extra == 8, "nested braces for a nested structure");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
