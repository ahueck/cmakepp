function(test)
	obj_new()
  ans(obj)
	assert(obj)
	obj_getprototype(${obj} )
	ans(proto)
	assert(proto)
	obj_istype(${obj}  Object)
	ans(res)
	assert(res)
	set(res)
	obj_callmember(${obj} to_string )
	ans(res)
	assert(res)


endfunction()