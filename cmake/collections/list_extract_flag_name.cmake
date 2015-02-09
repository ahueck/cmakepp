 ## extracts a flag from the list if it is found 
 ## returns the flag itself (usefull for forwarding flags)
  macro(list_extract_flag_name __lst __flag)
    list_extract_flag("${__lst}" "${__flag}")
    ans(__flag_was_found)
    set_ans("")
    if(__flag_was_found)
      if(ARGN)
        set_ans("${ARGN")
      else()
        set_ans("${__flag}")
      endif()
    endif()
  endmacro()