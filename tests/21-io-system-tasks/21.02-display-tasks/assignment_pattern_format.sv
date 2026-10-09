/*
:section: 21.2.1.6 Assignment pattern format
:summary: %p prints aggregates as assignment patterns, showing struct fields by name and enum
  values by name.
:description: White space in %p output is implementation dependent, so it is removed before
  comparing.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {RED, GREEN} colour_t;
  typedef struct { int a; colour_t c; string s; } rec_t;
  class obj_c; endclass
  rec_t r;
  obj_c h;
  int arr [3] = '{1, 2, 3};
  string text;
  function automatic string squash(string in);
    string out = "";
    foreach (in[i]) if (in[i] != " ") out = {out, string'(in[i])};
    return out;
  endfunction
  initial begin
    r.a = 5; r.c = GREEN; r.s = "hi";
    text = squash($sformatf("%p", r));
    check(text == "'{a:5,c:GREEN,s:\"hi\"}", $sformatf("struct printed as %s", text));
    text = squash($sformatf("%p", arr));
    check(text == "'{1,2,3}", $sformatf("array printed as %s", text));
    text = $sformatf("%p", h);
    check(text == "null", $sformatf("null handle printed as %s", text));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
