
  function(handler_request)
    set(request "${ARGN}")
    map_isvalid("${request}")
    ans(is_map)

    if(NOT is_map)
      map_new()
      ans(request)
      map_set(${request} input ${ARGN})
    endif()
    return_ref(request)
  endfunction()