/*
:section: 26.3 Referencing data in packages
:summary: An import statement may not appear directly inside a class body.
:type: parse
:should_fail_because: an import appears directly in a class
*/
package nums; int k; endpackage
module top;
  class Holder;
    import nums::*;
  endclass
endmodule
