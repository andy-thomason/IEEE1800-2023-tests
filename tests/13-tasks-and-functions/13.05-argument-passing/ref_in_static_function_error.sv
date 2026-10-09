/*
:section: 13.5.2 Pass by reference
:summary: A static function may not declare ref arguments.
:type: elaboration
:should_fail_because: a static function has a ref argument
*/
module top;
  function void clear(ref int v);
    v = 0;
  endfunction
endmodule
