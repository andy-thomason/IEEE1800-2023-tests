/*
:section: 18.5.13 Soft constraints
:summary: A soft constraint on a randc variable is illegal.
:type: elaboration
:should_fail_because: a soft constraint is applied to a randc variable
*/
module top;
  class c_c;
    randc bit [3:0] v;
    constraint k { soft v == 3; }
  endclass
endmodule
