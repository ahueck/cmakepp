## `(<index:<int>> <str:<string>> <char:<string>>)-><string>`
##
## Sets the character at the specified position to the input 'char'. 
## Indexing of strings starts at 0. Indices less than -1 are translated into "length - |index|"
## 
## **Examples**<%
##  set(str "example")
##  string_set_char_at(0 "${str}" "E") # => "Example"
##  ans(res)
## %>
##
##
function(string_set_char_at index input char)
  string(LENGTH "${input}" len)
  string_normalize_index("${input}" ${index})
  ans(index)
  if("${index}" LESS 0 OR ${index} EQUAL "${len}" OR ${index} GREATER ${len}) 
    return()
  endif()

  string(SUBSTRING "${input}" 0 ${index} res1)
  MATH(EXPR index "${index} + 1")
  string(SUBSTRING "${input}" ${index} -1 res2)
  
  set(res "${res1}${char}${res2}")

  return_ref(res)
endfunction()