
  function(stack_peek stack)
    ref_get(${stack} )
    ans(lst)
    list_peek_back( lst)
    ans(decoded)
    string_decode_list("${decoded}")
    ans(decoded)
    return_ref(decoded)
  endfunction()