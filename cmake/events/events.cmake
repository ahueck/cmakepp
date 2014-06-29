# returns the global events map
function(events)

  function(events)
    map_get(global events)
    ans(events)
    return_ref(events)
  endfunction()

  map_new()
  ans(events)
  map_set(global events ${events})
  events(${ARGN})
  return_ans()
endfunction()
