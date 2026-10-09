/*
:section: 8.17 Chaining constructors
:summary: The default keyword in a subclass constructor list inherits the parent constructor's
  arguments, passed on via super.new(default).
:description: The default keyword in constructor argument lists is new in IEEE 1800-2023.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class base_c;
    string name;
    int weight;
    function new(string name, int weight = 5);
      this.name = name;
      this.weight = weight;
    endfunction
  endclass
  class same_c extends base_c;
    function new(default);
    endfunction
  endclass
  class more_c extends base_c;
    int size;
    function new(int size, default, bit flag);
      super.new(default);
      this.size = flag ? size * 2 : size;
    endfunction
  endclass
  same_c s;
  more_c m;
  initial begin
    s = new("s", 9);
    check(s.name == "s" && s.weight == 9, "default arguments passed implicitly");
    s = new("t");
    check(s.weight == 5, "default value of an expanded argument");
    m = new(3, "m", 7, 1);
    check(m.name == "m" && m.weight == 7 && m.size == 6, "arguments before and after default");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
