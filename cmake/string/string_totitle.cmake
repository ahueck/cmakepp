# transforms the specified string to title case
# According to Stuart Colville Python implementation "titlecase 0.2"
# MIT License
function(string_totitle str)
  set(SMALL "a|an|and|as|at|but|by|en|for|if|in|of|on|or|the|to|via")
  set(PUNCT "!")
  set(UC_LETTER "[a-zA-Z]+[A-Z]+")
  set(INLINE_PERIOD "[a-zA-Z]+\\.[a-zA-Z]+")

  set(ws " ")
  string_split(${str} ${ws})
  ans(words)

  set(first true)
  foreach(word ${words})
    if("${word}" MATCHES "$^{SMALL}$")
      string(TOLOWER "${word}" word)
    elseif(NOT "${word}" MATCHES "${UC_LETTER}" AND NOT "${word}" MATCHES "${INLINE_PERIOD}")
      string(SUBSTRING "${word}" 0 1 char)
      string(TOUPPER "${char}" char)
      string_set_char_at(0 ${word} ${char})
      ans(word)
    endif()

    # string_combine(" " res u_res)
    if(first)
      set(first false)
    else()
      set(res "${res}${ws}")
    endif()
    set(res "${res}${word}")
  endforeach()

  # Special case: beginning of word
  string(REGEX REPLACE "(^${PUNCT}*)(${SMALL})(.*)" "\\1;\\2;\\3" RESULT "${res}")
  list(GET RESULT 0 group0)
  list(GET RESULT 1 group1)
  list(GET RESULT 2 group2)
  string(SUBSTRING "${group1}" 0 1 char)
  string(TOUPPER "${char}" char)
  string_set_char_at(0 ${group1} ${char})
  ans(group1)
  set(res "${group0}${group1}${group2}")

  return_ref(res)
endfunction()