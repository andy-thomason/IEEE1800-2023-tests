/*
:section: 6.20.2 Value parameters
:summary: A parameter value expression must not use a hierarchical name.
:type: elaboration
:should_fail_because: the parameter value uses a hierarchical name
*/
module leaf;
  parameter int K = 4;
endmodule

module top;
  leaf u_leaf();
  parameter int COPY = top.u_leaf.K;
endmodule
