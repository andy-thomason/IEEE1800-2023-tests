/*
:section: 6.8 Variable declarations
:summary: A data declaration must name a data type when var is absent.
:type: parse
:should_fail_because: the declaration has no data type and no var keyword
*/
module top;
  initial begin
    static count = 2;
  end
endmodule
