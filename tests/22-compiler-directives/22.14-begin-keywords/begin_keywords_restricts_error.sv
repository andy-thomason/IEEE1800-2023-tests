/*
:section: 22.14 `begin_keywords, `end_keywords
:summary: Using interface inside a `begin_keywords 1364-2005 region is illegal because it is not
  a keyword there.
:type: parse
:should_fail_because: interface is not a keyword under 1364-2005
*/
`begin_keywords "1364-2005"
interface not_allowed;
endinterface
`end_keywords
module top;
endmodule
