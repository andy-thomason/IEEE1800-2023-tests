/*
:section: 18.5.3 Distribution
:summary: Applying a dist constraint to a randc variable is illegal.
:type: elaboration
:should_fail_because: dist is applied to a randc variable
*/
module top;
  class c_c;
    randc bit [3:0] v;
    constraint k { v dist { 0 := 1, [1:15] :/ 1 }; }
  endclass
endmodule
