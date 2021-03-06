# macro version of eval function which causes set(PARENT_SCOPE ) statements to access 
# scope of invokation
macro(eval_ref __eval_ref_theref)
  ans(__eval_ref_current_ans)
  cmakepp_config(temp_dir)
  ans(__eval_ref_dir)

  fwrite_temp("${${__eval_ref_theref}}" ".cmake")
  ans(__eval_ref_filename)

  set_ans("${__eval_ref_current_ans}")
#_message("${ref_count}\n${${__eval_ref_theref}}")

  include(${__eval_ref_filename})
  ans(__eval_ref_res)
  
  cmakepp_config(keep_temp)
  ans(__eval_ref_keep_temp)
  if(NOT __eval_ref_keep_temp)
    file(REMOVE ${__eval_ref_filename})
  endif()


  set_ans("${__eval_ref_res}")
endmacro()
