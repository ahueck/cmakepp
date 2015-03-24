function(test)
  set(str "hello")

  string_set_char_at(1 ${str} a)
  ans(res)
  assert("${res}" STREQUAL "hallo")

  string_set_char_at(-2 ${str} a)
  ans(res)
  assert("${res}" STREQUAL "hella")


  set(str "hello three words")

  string_set_char_at(-2 ${str} e)
  ans(res)
  assert("${res}" STREQUAL "hello three worde")

  string_set_char_at(5 ${str} s)
  ans(res)
  assert("${res}" STREQUAL "hellosthree words")

endfunction()