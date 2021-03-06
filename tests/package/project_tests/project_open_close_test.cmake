function(test)
  obj("{}")
  ## remove all events as I do not want to test all extensions
  event_clear(project_on_opening)
  event_clear(project_on_open)
  event_clear(project_on_opened)
  event_clear(project_on_closing)
  event_clear(project_on_close)
  event_clear(project_on_closed)

  pushd(proj0 --create)
    map_new()
    ans(project)
    
    timer_start(project_open_ref)
    project_open(${project})
    ans(res)
    timer_print_elapsed(project_open_ref)
    assert("${res}" STREQUAL "${project}") 
    assertf("{project.content_dir}" STREQUAL "${test_dir}/proj0") 
    assertf("{project.uri}" STREQUAL "project:root")
    assertf("{project.project_descriptor}" ISNOTNULL)
    assertf("{project.project_descriptor.package_cache}" ISNOTNULL)


    timer_start(project_close_ref)
    project_close(${project})
    ans(res)
    timer_print_elapsed(project_close_ref)
    assert(EXISTS ".cps/project.scmake")
    assert("${res}" STREQUAL "${test_dir}/proj0/.cps/project.scmake")

  popd()

  pushd(proj1 --create)
    events_track(
      project_on_opened 
      project_on_open
      project_on_opening 
      project_on_closing 
      project_on_close 
      project_on_closed)
    ans(tracker)

    timer_start(project_open_default)
    project_open()
    ans(project)
    timer_print_elapsed(project_open_default)
    assertf("{project.uri}" STREQUAL "project:root")
    assertf("{project.content_dir}" STREQUAL "${test_dir}/proj1")
    assertf("{project.project_descriptor}" ISNOTNULL)
    assertf("{project.project_descriptor.package_cache}" ISNOTNULL)
    assertf("{project.project_descriptor.dependency_dir}" STREQUAL "packages" )
    assertf("{project.project_descriptor.project_file}" STREQUAL ".cps/project.scmake")
    assertf("{project.project_descriptor.package_descriptor_file}" ISNULL)  
      
    assertf("{tracker.project_on_opened[0].args[0]}" STREQUAL "${project}")
    assertf("{tracker.project_on_open[0].args[0]}" STREQUAL "${project}")
    assertf("{tracker.project_on_opening[0].args[0]}" STREQUAL "${project}")


    project_close(${project})
    ans(res)
    assert("${res}" STREQUAL "${test_dir}/proj1/.cps/project.scmake")
    fread_data("${res}")
    ans(res)
    assertf("{res.uri}" STREQUAL "project:root")
    assertf("{tracker.project_on_closing[0].args[0]}" STREQUAL "${project}")
    assertf("{tracker.project_on_close[0].args[0]}" STREQUAL "${project}")
    assertf("{tracker.project_on_closed[0].args[0]}" STREQUAL "${project}")
  popd()


  pushd("proj2" --create)



    project_open()
    ans(project)
    map_set(${project} uri "project:lol")
    project_close(${project})
    
    events_track(project_on_opened)
    ans(tracker)

    timer_start(project_open_dir)
    project_open()
    ans(new_project)
    timer_print_elapsed(project_open_dir)
    assert(NOT "${project}" STREQUAL "${new_project}")
    assertf("{new_project.uri}" STREQUAL "project:lol")

    assertf("{tracker.project_on_opened[0].args[0]}" STREQUAL "${new_project}")
 
  popd()


  pushd("proj3" --create)
    project_open()
    ans(project)
    map_set(${project} uri "project:lol")
    project_close(${project})
    ans(project_file)

    pushd("..")
      timer_start(project_open_file)
      project_open("${project_file}")
      ans(new_project)    
      timer_print_elapsed(project_open_file)

      assert(new_project)
      assertf("{new_project.uri}" STREQUAL "project:lol")
      assertf("{new_project.content_dir}" STREQUAL "${test_dir}/proj3")
    popd()
  popd()

  
endfunction()