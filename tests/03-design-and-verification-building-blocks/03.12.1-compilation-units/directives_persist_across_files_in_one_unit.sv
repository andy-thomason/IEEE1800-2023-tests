/*
:section: 3.12.1 Compilation units
:summary: A macro defined in an earlier file stays in effect for later files of the same
  compilation unit.
:description: Both files form one compilation unit (the default), so the macro carries over.
:files: directives_persist_across_files_in_one_unit_top.svh
*/
`define DEPTH_FROM_FIRST_FILE 12
