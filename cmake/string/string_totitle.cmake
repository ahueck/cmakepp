# transforms the specified string to title case
# According to Stuart Colville Python implementation "titlecase 0.2"
# MIT License
function(string_totitle str)
  set(small a an and as at but by en for if in of on or the to via vs v v. vs. A An And As At But By En For If In Of On Or The To Via Vs V V. Vs.)

  set(subsentence "[!:.?']+")
  # groups all brackets (for our algorithm sufficient)
  set(bracket_open "[\\(]+")
  set(bracket_close "[\\(]+")
  set(other "[^ !:.?'\\(\\)]+")
  set(ws "[ ]+")
  #set(ucase_elsewhere "[a-zA-Z]+[A-Z]+")

  string_encode_list(${str})
  ans(str_encoded)
  string(REGEX MATCHALL "(${other})|(${subsentence})|(${ws})|(${bracket_open})|(${bracket_close})" tokens "${str_encoded}")

  set(is_subsentence false)
  # TODO: stack for correct handling of words like "t(e)st", "t(e)St" and inline periods etc.
  #set(combine_stack)
  while(true)
    list(LENGTH tokens length)
    if(NOT length)
      break()
    endif()
    list(GET tokens 0 token)
    list(REMOVE_AT tokens 0)

    if("${token}" MATCHES "${ws}")
    elseif("${token}" MATCHES "${subsentence}")
      set(is_subsentence true)
    elseif("${token}" MATCHES "${bracket_open}")
      
    elseif("${token}" MATCHES "${bracket_close}")
      
    elseif("${token}" MATCHES "${other}")
      string(SUBSTRING "${token}" 0 1 first)
      string(SUBSTRING "${token}" 1 -1 rest)

      list(FIND small ${token} index)
      if(index GREATER -1)
        if(is_subsentence)
          string(TOUPPER ${first} first)
        else()
          string(TOLOWER ${first} first)
        endif()
        set(token "${first}${rest}")
      else()
        # TODO 'uppercase elsewhere', 'inline period' -> keep existing case
        string(TOUPPER ${first} first)
        set(token "${first}${rest}")
      endif()
      set(is_subsentence false)
    endif()

    set(res "${res}${token}")
  endwhile()
  return_ref(res)

# FIXME remove
# set(is_sub false)
# set(start true)
# foreach(token ${tokens})
#   message("Start token=[${token}]")
#   if("${token}" MATCHES "${subsentence}")
#     set(is_sub true)
#   elseif("${token}" MATCHES "${other}")
#     #message("Other token found = ${token}")
#     # Until smarter way?
#     string(SUBSTRING "${token}" 0 1 first)
#     string(SUBSTRING "${token}" 1 -1 rest)
#     
#     list(FIND small ${token} index)
#     #message("Token=${token} - ${index} (${first} ${rest})")
#     if(index GREATER -1)
#       # small token
#       if(start OR is_sub)
#         string(TOUPPER ${first} first)
#         set(is_sub false)
#       else()
#         string(TOLOWER ${first} first)
#       endif()
#       set(token "${first}${rest}")
#     elseif(NOT "${token}" MATCHES "${ucase_elsewhere}" AND NOT "${token}" MATCHES "${inline_period}")
#       # ucase_elsewhere and inline_period -> keep existing case
#       string(TOUPPER ${first} first)
#       #message("token to upper")
#       set(token "${first}${rest}")
#     endif()
#   endif()
#   set(start false)

#   set(res "${res}${token}")
# endforeach()

# return_ref(res)




# string(REGEX MATCHALL "" words ${str_encoded})

# set(ws " ")
# string_split(${str} ${ws})
# ans(words)

# set(first true)
# set(has_subsentence false)
# foreach(word ${words})
#   # extract small letter at beginning (TODO [:]* extend for subsentence)
#   if(${word} MATCHES "([a-z])(.*)([:]*)")
#     if(NOT ${CMAKE_MATCH_3} STREQUAL "")
#       set(has_subsentence true)
#     endif()
#     # starts with lower case actually
#     if(NOT ${CMAKE_MATCH_1} STREQUAL "")

#     endif()


#     list(FIND small ${word} index)
#     if(idx GREATER 0)
#       if(has_subsentence)
#         set(has_subsentence false)
#         string(TOUPPER "${word}" word)
#         message("Line 24: small toupper")
#       else()
#         string(TOLOWER "${word}" word)
#         message("Line 27: small tolower")
#       endif()
#     elseif(${word} MATCHES "([']*)([a-z])([a-z]*)([\\.\\?!:;]*)") 
#       message("Matched word=${word}")
#       string(TOUPPER ${CMAKE_MATCH_2} CMAKE_MATCH_2)
#       set(word "${CMAKE_MATCH_1}${CMAKE_MATCH_2}${CMAKE_MATCH_3}${CMAKE_MATCH_4}")
#       if(NOT ${CMAKE_MATCH_4} STREQUAL "")
#         message("Line 27: Found subsentence in word")
#         set(has_subsentence true)
#       endif()
#     endif()
#   endif()

#   # string_combine(" " res u_res)
#   if(first)
#     set(first false)
#   else()
#     set(res "${res}${ws}")
#   endif()
#   set(res "${res}${word}")
# endforeach()

  # Special case: beginning of word
  #string(REGEX REPLACE "(^${PUNCT}*)(${SMALL})(.*)" "\\1;\\2;\\3" RESULT "${res}")
  #list(GET RESULT 0 group0)
  #list(GET RESULT 1 group1)
  #list(GET RESULT 2 group2)
  #string(SUBSTRING "${group1}" 0 1 char)
  #string(TOUPPER "${char}" char)
  #string_set_char_at(0 ${group1} ${char})
  #ans(group1)
  #set(res "${group0}${group1}${group2}")

#  return_ref(res)
endfunction()