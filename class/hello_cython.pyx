
# compile as python dict
cdef struct test:
	int a

cdef test b

# cdef say_hello(name=None):
# 	return 'hello %s' & name

# cdef say_hello2(object name=None):
# 	return 'hello %s' & name

# cdef say_hello3(char* name=None):
# 	return 'hello %s' & name

# # can be import
# cpdef say_hello4(char* name=None):
# 	return 'hello %s' & name

# print say_hello3("123")

# cimport cplib

cdef int i

# only def, class can be define as cpdef, and invoke by python
# so you can access any variable in cpdef method/class you want.
# variable cant be def as cpdef, so you cant see it in python
cpdef int j

j = 100
print j

# can be see by python
ee = "ee as python def in pyx"

# can be python invoke
cpdef echo2():
	print "echo2 by cpdef"

# can not be python import and invoke
cdef echo3():
	print "echo3 by cdef"


i = 2147483647 + 100

def echo():
	echo4()  # as the same file name xxx.pxd define echo4 function
	print i

cpdef int y = 999

print y

# print i

# print 'hello world'

# http://docs.cython.org/src/reference/language_basics.html#callable-from-python

