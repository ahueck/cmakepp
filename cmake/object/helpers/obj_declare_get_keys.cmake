function(obj_declare_get_keys obj function_ref)
    function_new()
    ans(func)
    map_set_special(${obj} get_keys ${func})
    set(${function_ref} ${func} PARENT_SCOPE)
  endfunction()