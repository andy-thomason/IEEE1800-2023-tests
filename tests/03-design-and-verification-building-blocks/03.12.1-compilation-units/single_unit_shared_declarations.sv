/*
:section: 3.12.1 Compilation units
:summary: When all files form one compilation unit, unit-scope declarations from one file are
  usable in later files.
:description: The test file holds only compilation-unit declarations; the second file uses them.
:files: single_unit_shared_declarations_top.svh
*/
// Compilation-unit scope declarations used by the second file.
typedef logic [5:0] six_bits_t;
parameter int SHARED_LIMIT = 42;
function automatic int twice(int v);
  return 2 * v;
endfunction
