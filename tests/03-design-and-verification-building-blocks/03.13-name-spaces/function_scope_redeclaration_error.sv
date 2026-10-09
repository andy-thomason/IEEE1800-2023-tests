/*
:section: 3.13 Name spaces
:summary: A function local variable cannot reuse the name of one of that function's arguments.
:type: elaboration
:should_fail_because: the function declares a local with the same name as its argument
*/
module top;
  function automatic int pick(int choice);
    int choice;
    return choice;
  endfunction
endmodule
