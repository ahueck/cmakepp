
function(cmake_token_range_filter range )
  arguments_encoded_list2(1 ${ARGC})
  ans(args)
  
  list_extract_flag(args --reverse)
  ans(reverse)
  
  cmake_token_range("${range}")
  if(reverse)
    ans_extract(end current)
  else()
    ans_extract(current end)
  endif()

  list_extract_labelled_value(args --skip)
  ans(skip)
  list_extract_labelled_value(args --take)
  ans(take)
  if("${take}_" STREQUAL "_")
    set(take -1)
  endif()
  set(predicate ${args})
  set(result)
  while(take AND current AND NOT "${current}" STREQUAL "${end}")
    map_tryget("${current}" literal_value)
    ans(value)
    map_tryget("${current}" type)
    ans(type)

    eval_predicate(${predicate})
    ans(predicate_holds)

    #print_vars(reverse predicate predicate_holds value type)
    #string(REPLACE "{type}" "${type}" current _predicate "${args}")
    #string(REPLACE "{value}" "${value}" current_predicate "${current_predicate}")
    if(predicate_holds)

      if(skip)
        math(EXPR skip "${skip} - 1")
      else()
        list(APPEND result ${current})
        if(${take} GREATER 0)
          math(EXPR take "${take} - 1")
        endif()
      endif()
    endif()
    if(reverse)
      cmake_token_go_back(current)
    else()
      cmake_token_advance(current)
    endif()
  endwhile()
  return_ref(result)
endfunction() 


