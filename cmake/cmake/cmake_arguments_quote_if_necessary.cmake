## `(<any>...)-><cmake escaped>...`
##
## quotes all arguments which need quoting 
function(cmake_arguments_quote_if_necessary)
  regex_cmake()
  set(result)
  foreach(arg ${ARGN})
    if("${arg}" MATCHES "${regex_cmake_value_needs_quotes}")
      string(REGEX REPLACE 
        "${regex_cmake_value_quote_escape_chars}" 
        "\\\\\\0" #prepends a '\' before each matched cahr 
        arg "${arg}"
        )
      set(arg "\"${arg}\"")
    endif()

    list(APPEND result "${arg}")
  endforeach()
  return_ref(result)
endfunction()