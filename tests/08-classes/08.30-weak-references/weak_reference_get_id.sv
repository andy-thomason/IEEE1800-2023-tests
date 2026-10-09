/*
:section: 8.30.5 Get_id()
:summary: weak_reference::get_id returns 0 for null and a stable nonzero value for each distinct
  object.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class obj_c; endclass
  class ext_c extends obj_c; endclass
  typedef weak_reference #(obj_c) obj_ref_t;
  typedef weak_reference #(ext_c) ext_ref_t;
  ext_c e = new;
  obj_c o = new;
  initial begin
    check(obj_ref_t::get_id(null) == 0, "get_id(null) is not 0");
    check(ext_ref_t::get_id(e) != 0, "get_id of an object is 0");
    check(obj_ref_t::get_id(e) == ext_ref_t::get_id(e), "id depends on the handle type");
    check(ext_ref_t::get_id(e) == ext_ref_t::get_id(e), "id is not stable");
    check(obj_ref_t::get_id(o) != obj_ref_t::get_id(e), "two objects share an id");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
