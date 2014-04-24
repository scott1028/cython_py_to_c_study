# as like c header file, in pyx file don not need be cimport

# can not be see in python but c
cdef inline void echo4():
    print "echo in pxd"

# can be see in python
cpdef inline echo5():
    print "echo in pxd with cpdef"
