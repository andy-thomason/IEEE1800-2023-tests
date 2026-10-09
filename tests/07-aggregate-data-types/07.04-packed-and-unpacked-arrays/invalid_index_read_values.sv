/*
:section: 7.4.5 Indexing and slicing of arrays
:summary: An out-of-range or x/z index read returns the element type's default value, such as x
  or 0.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class obj_c; endclass
  typedef enum logic [1:0] {P = 1, Q = 2} e4_t;
  typedef struct { int fixed = 7; int plain; } st_t;
  logic [3:0] l4 [4];
  int i2 [4];
  e4_t en [4];
  real r [4];
  string s [4];
  int dyn_of [2][];
  int fixed_of [2][3];
  st_t structs [2];
  int idx;
  int sub [3];
  initial begin
    foreach (i2[k]) begin i2[k] = 5; l4[k] = 4'd5; r[k] = 1.5; s[k] = "x"; end
    idx = 9;
    check(l4[idx] === 4'bxxxx, "4-state element");
    check(i2[idx] === 0, "2-state element");
    check(en[idx] === 2'bxx, "enum element (4-state base)");
    check(r[idx] == 0.0, "real element");
    check(s[idx] == "", "string element");
    check(dyn_of[idx].size() == 0, "dynamic subarray");
    sub = fixed_of[idx];
    check(sub[0] == 0 && sub[2] == 0, "fixed-size subarray");
    check(structs[idx].fixed == 7 && structs[idx].plain == 0, "struct with a member initialiser");
    check(i2[-1] === 0, "negative index");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
