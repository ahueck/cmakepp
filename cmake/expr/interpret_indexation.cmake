function(interpret_indexation tokens)
  set(lhs_tokens ${tokens})
  list(LENGTH lhs_tokens token_count)
  if(NOT "${token_count}" GREATER 1)
    throw("invalid token count, expected more than one token, got ${token_count}" --function interpret_indexation)
  endif()

  list_pop_back(lhs_tokens)
  ans(indexation_token)

  map_tryget("${indexation_token}" type)
  ans(token_type)


  if(NOT "${token_type}" STREQUAL "bracket")
    throw("invalid token type, expected bracket but got ${token_type}" --function interpret_indexation)
  endif()

  map_tryget("${indexation_token}" tokens)
  ans(inner_tokens)


  interpret_elements("${inner_tokens}" "comma" "interpret_range;interpret_rvalue")
  rethrow()
  ans(elements)

  next_id()
  ans(ref)

  set(code "set(${ref})\n")


  interpret_rvalue("${lhs_tokens}")
  rethrow()
  ans(lhs)

  map_tryget("${lhs}" value)
  ans(lhs_value)

  map_tryget("${lhs}" expression_type)
  ans(lhs_expression_type)




  set(value_type any)

  list(LENGTH elements element_count)
  if("${element_count}" GREATER 1)
    set(value_type list)
  endif()

  foreach(element ${elements})

    map_tryget("${element}" expression_type)
    ans(expression_type)


    map_tryget("${element}" value)
    ans(element_value)

    if("${expression_type}" STREQUAL "range")
      set(value_type list)
      set(code "${code}
value_range_get(\"${lhs_value}\" \"${element_value}\")
list(APPEND ${ref} \${__ans} )
")
    elseif("${lhs_expression_type}" STREQUAL "ellipsis")
      set(code "${code}foreach(local ${lhs_value})
        get_property(__ans GLOBAL PROPERTY \"\${local}.__object__\" SET)
        if(__ans)
          message(FATAL_ERROR object_get_not_supported_currently)
        else()
          get_property(__ans GLOBAL PROPERTY \"\${local}.${element_value}\")
          list(APPEND ${ref} \${__ans})
        endif()
      endforeach()
        ")
    else()

      set(code "${code}get_property(__ans GLOBAL PROPERTY \"${lhs_value}.__object__\" SET)
                if(__ans)
                  message(FATAL_ERROR object_get_not_supported_currently)
                else()
                  get_property(__ans GLOBAL PROPERTY \"${lhs_value}.${element_value}\")
                  list(APPEND ${ref} \${__ans})
                endif()\n")
    endif()

  endforeach()




  ast_new(
    "${tokens}"         # tokens
    "indexation"        # expression_type
    "${value_type}"                  # value_type
    "${ref}"                  # ref
    "${code}"                  # code
    "\${${ref}}"                  # value
    "false"                  # const
    "false"                  # pure_value
    "${lhs};${elements}"                  # children
    )
  ans(ast)
  return_ref(ast)
endfunction()
