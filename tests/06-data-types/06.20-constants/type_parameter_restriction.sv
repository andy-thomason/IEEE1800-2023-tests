/*
:section: 6.20.3 Type parameters
:summary: A type parameter may limit acceptable types with keywords like enum or struct before
  its name.
*/
typedef enum {OFF, ON} switch_t;
typedef struct { int x; } point_t;

module only_enum #(parameter type enum E = switch_t);
  E value;
endmodule

module only_struct #(parameter type struct S = point_t);
  S value;
endmodule

module top;
  only_enum #(.E(switch_t)) u_enum();
  only_struct #(.S(point_t)) u_struct();
  initial begin
    u_enum.value = ON;
    u_struct.value.x = 3;
    #1;
    if (u_enum.value != ON || u_struct.value.x != 3) $display("FAIL: restricted type parameters");
    else $display("PASS");
    $finish;
  end
endmodule
