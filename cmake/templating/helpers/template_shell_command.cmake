
function(template_shell command)
    if("${command}" STREQUAL "set_base_dir")
        ref_set(template_shell_base_dir "${ARGN}")
    endif()
    ref_get(template_shell_base_dir)
    ans(shell_base_dir)
    if(NOT shell_base_dir)
        pwd()
        ans(shell_base_dir)
        ref_set(template_shell_base_dir "${shell_base_dir}")
    endif()
    
    set(args ${ARGN})
    list_extract_flag(args --echo)
    ans(echo)
    pwd()
    ans(pwd)
    path_relative("${shell_base_dir}" "${pwd}")
    ans(rel_pwd)
    string_combine(" " ${args})
    ans(arg_string)
    template_out("${rel_pwd}/> ${command} ${arg_string}")
    call2("${command}" ${ARGN})
    ans(res)
    if(NOT echo)
        return()
    endif()
    json_indented("${res}")
    string(REPLACE "${shell_base_dir}" "." res "${res}")
    template_out("\n")
    template_out_json("${res}")
endfunction()
