# coding:utf-8
# http://docs.cython.org/src/reference/language_basics.html#callable-from-python

# http://docs.cython.org/src/userguide/sharing_declarations.html#the-cimport-statement
# cimport like import, use for import .pxd file in pyx file
# the same name {same name}.pyx auto import {same name}.pxd


# compile as python dict
cdef struct test:
    int a


cpdef test b


cdef int i

# only def, class can be define as cpdef, and invoke by python
# so you can access any variable in cpdef method/class you want.
# variable cant be def as cpdef, so you cant see it in python
cpdef int j  # cpdef type 將被視為 cdef

# can be see by python
ee = "ee as python def in pyx"

# can be python invoke
cpdef echo2():
    print "echo2 by cpdef"


# can not be python import and invoke
cdef echo3():
    print "echo3 by cdef"

# overflow
i = 2147483647 + 100


def echo():
    echo4()  # as the same file name xxx.pxd define echo4 function
    print i


cpdef int y = 999

cdef class SS:
    cpdef double eval(self, double x) except *:
        return x**2


cdef double eval(double x):
    return x


cdef class ball:
    def __cinit__(self):
        self.x = 10
        self.y = 20
        print self.x, self.y

    # must be define first at .pxd
    cpdef echo(self):
        print 2

    # cant be invoke by .py but .pyx
    cdef echo2(self):
        print 'echo by cdef of ball', 10

ball().echo2()

cimport lib
lib.echo9()
# print lib.rr

# cdef class rr:
#     cdef int x

# 調用 C Header 內的 Function
# 因為 cython 不認識 .h File 所以要再定義介面 double sim()
cdef extern from "math.h":
    double sin(double x)   

cpdef test_by_extern():
    print sin(10)  # invoke C Function by main.py test_cy.test_by_extern()
