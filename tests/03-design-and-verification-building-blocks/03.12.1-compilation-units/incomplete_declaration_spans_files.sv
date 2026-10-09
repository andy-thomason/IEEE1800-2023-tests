/*
:section: 3.12.1 Compilation units
:summary: A declaration left unfinished at the end of one file continues into the next file of
  that unit.
:description: Even with one compilation unit per file, the unfinished module joins the files.
:files: incomplete_declaration_spans_files_rest.svh
:flags-icarus: -u
*/
// This module is completed by the second file.
module top;
  int part_one = 11;
