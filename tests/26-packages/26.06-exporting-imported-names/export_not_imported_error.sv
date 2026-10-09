/*
:section: 26.6 Exporting imported names from packages
:summary: A package may export a name only if it actually imported that name from the same
  package.
:type: elaboration
:should_fail_because: mid exports base::alpha but imported other::alpha
*/
package base; int alpha; endpackage
package other; int alpha; endpackage
package mid;
  import other::alpha;
  export base::alpha;
endpackage
module top;
endmodule
